import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notice.dart';

class NoticeService {
  static const String _k = 'notices';

  Future<List<Notice>> getNotices() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_k);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => Notice.fromJson(e)).toList();
  }

  Future<void> addNotice(Notice notice) async {
    final notices = await getNotices();
    notices.add(notice);
    await _saveNotices(notices);
  }

  Future<void> updateNotice(Notice notice) async {
    final notices = await getNotices();
    final index = notices.indexWhere((n) => n.id == notice.id);
    if (index != -1) {
      notices[index] = notice;
      await _saveNotices(notices);
    }
  }

  Future<void> deleteNotice(String id) async {
    final notices = await getNotices();
    notices.removeWhere((n) => n.id == id);
    await _saveNotices(notices);
  }

  Future<void> toggleFavorite(String id) async {
    final notices = await getNotices();
    final index = notices.indexWhere((n) => n.id == id);
    if (index != -1) {
      notices[index] = Notice(
        id: notices[index].id,
        title: notices[index].title,
        description: notices[index].description,
        category: notices[index].category,
        priority: notices[index].priority,
        createdAt: notices[index].createdAt,
        updatedAt: notices[index].updatedAt,
        filePath: notices[index].filePath,
        authorId: notices[index].authorId,
        authorName: notices[index].authorName,
        isFavorite: !notices[index].isFavorite,
      );
      await _saveNotices(notices);
    }
  }

  Future<void> _saveNotices(List<Notice> notices) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(notices.map((n) => n.toJson()).toList());
    await prefs.setString(_k, data);
  }
}
