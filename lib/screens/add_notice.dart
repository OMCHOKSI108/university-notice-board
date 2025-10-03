import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import '../models/notice.dart';
import '../services/notice_service.dart';

class AddNoticeScreen extends StatefulWidget {
  final Notice? notice;
  final String userId;
  final String userName;

  const AddNoticeScreen({
    super.key,
    this.notice,
    required this.userId,
    required this.userName,
  });

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _desc;
  late Category _cat;
  late Priority _priority;
  String? _file;
  final NoticeService _svc = NoticeService();

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.notice?.title ?? '');
    _desc = TextEditingController(text: widget.notice?.description ?? '');
    _cat = widget.notice?.category ?? Category.general;
    _priority = widget.notice?.priority ?? Priority.medium;
    _file = widget.notice?.filePath;
  }

  Future<void> _pick() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = result.files.single.path;
      });
    }
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      final notice = Notice(
        id: widget.notice?.id ?? const Uuid().v4(),
        title: _title.text,
        description: _desc.text,
        category: _cat,
        priority: _priority,
        updatedAt: widget.notice != null ? DateTime.now() : null,
        filePath: _file,
        authorId: widget.userId,
        authorName: widget.userName,
      );
      if (widget.notice != null) {
        await _svc.updateNotice(notice);
      } else {
        await _svc.addNotice(notice);
      }
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.notice != null ? 'Edit Notice' : 'Add Notice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,

          child: Column(
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),

              TextFormField(
                controller: _desc,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),

              DropdownButton<Category>(
                value: _cat,
                items: Category.values.map((c) {
                  return DropdownMenuItem(value: c, child: Text(c.name));
                }).toList(),
                onChanged: (v) => setState(() => _cat = v!),
              ),

              const SizedBox(height: 16),

              DropdownButton<Priority>(
                value: _priority,
                items: Priority.values.map((p) {
                  return DropdownMenuItem(
                    value: p,
                    child: Text(p.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (v) => setState(() => _priority = v!),
              ),

              ElevatedButton(onPressed: _pick, child: const Text('Pick File')),
              if (_file != null) Text('File: $_file'),
              const SizedBox(height: 15.0),

              ElevatedButton(onPressed: _save, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
