import 'package:flutter/material.dart';
import '../models/notice.dart';
import '../services/notice_service.dart';
import 'add_notice.dart';

class NoticeDetailScreen extends StatelessWidget {
  final Notice notice;
  final String userId;
  final String userName;

  const NoticeDetailScreen({
    super.key,
    required this.notice,
    required this.userId,
    required this.userName,
  });

  static IconData _icon(Category cat) {
    switch (cat) {
      case Category.exam:
        return Icons.school;
      case Category.event:
        return Icons.event;
      case Category.academic:
        return Icons.book;
      case Category.general:
        return Icons.info;
    }
  }

  static Color _color(Category cat) {
    switch (cat) {
      case Category.exam:
        return Colors.red;
      case Category.event:
        return Colors.blue;
      case Category.academic:
        return Colors.green;
      case Category.general:
        return Colors.orange;
    }
  }

  static IconData _priorityIcon(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Icons.arrow_upward;
      case Priority.medium:
        return Icons.remove;
      case Priority.low:
        return Icons.arrow_downward;
    }
  }

  static Color _priorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  static String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notice.title),
        actions: [
          IconButton(
            icon: Icon(
              notice.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: notice.isFavorite ? Colors.red : null,
            ),
            onPressed: () async {
              await NoticeService().toggleFavorite(notice.id);
              if (context.mounted) {
                Navigator.pop(context); // Refresh by going back
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      AddNoticeScreen(userId: userId, userName: userName),
                ),
              );
              // No need to refresh since we're not changing this notice
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddNoticeScreen(
                    notice: notice,
                    userId: userId,
                    userName: userName,
                  ),
                ),
              );
              if (context.mounted) Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (c) => AlertDialog(
                  title: const Text('Delete Notice?'),
                  content: const Text('This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(c, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(c, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
              if (confirm == true && context.mounted) {
                await NoticeService().deleteNotice(notice.id);
                if (context.mounted) Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              'Category',
              notice.category.name,
              _icon(notice.category),
              _color(notice.category),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Priority',
              notice.priority.name.toUpperCase(),
              _priorityIcon(notice.priority),
              _priorityColor(notice.priority),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Author',
              notice.authorName,
              Icons.person,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Created',
              _formatDateTime(notice.createdAt),
              Icons.calendar_today,
              Colors.green,
            ),
            if (notice.updatedAt != null) ...[
              const SizedBox(height: 16),
              _buildInfoCard(
                'Last Updated',
                _formatDateTime(notice.updatedAt!),
                Icons.update,
                Colors.orange,
              ),
            ],
            const SizedBox(height: 16),
            _buildInfoCard(
              'Description',
              notice.description,
              Icons.description,
              Colors.grey,
            ),
            if (notice.filePath != null) ...[
              const SizedBox(height: 16),
              _buildFileCard(notice.filePath!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    String label,
    String content,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildFileCard(String filePath) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.attach_file, color: Colors.blue),
        title: const Text('Attachment'),
        subtitle: Text(
          filePath.split('/').last,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.download),
        onTap: () {},
      ),
    );
  }
}
