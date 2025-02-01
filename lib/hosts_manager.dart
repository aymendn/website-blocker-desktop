import 'dart:io';

abstract class HostsManager {
  static const blockStart = '# WEBSITE_BLOCKER_START';
  static const blockEnd = '# WEBSITE_BLOCKER_END';
  static List<String> blockedWebsites = [];

  static String getHostsPath() {
    if (Platform.isWindows) return r'C:\Windows\System32\drivers\etc\hosts';
    if (Platform.isMacOS) return '/private/etc/hosts';
    return '/etc/hosts';
  }

  static Future<String> readHostsFile() async {
    final file = File(getHostsPath());
    return await file.readAsString();
  }

  static Future<void> init() async {
    blockedWebsites = await getCurrentBlockedWebsites();
  }

  static List<String> validateWebsites(String input) {
    final websites = input
        .split('\n')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (websites.isEmpty) {
      return [];
    }

    final urlRegex = RegExp(
      r'^(http(s)?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?(\/[^\s]*)?$',
      caseSensitive: false,
    );

    return websites.where((site) => urlRegex.hasMatch(site)).toSet().toList();
  }

  static Future<void> updateBlockedWebsites(List<String> websites) async {
    final originalContent = await readHostsFile();
    final newBlock = websites.isEmpty
        ? ""
        : [blockStart, ...websites.map((site) => '127.0.0.1\t$site'), blockEnd]
            .join('\n');

    // Remove existing block and add new one
    final cleanedContent = originalContent
        .replaceAll(RegExp('$blockStart[\\s\\S]*?$blockEnd\n?'), '')
        .trim();

    await writeToHostsFile('$cleanedContent\n\n$newBlock\n');
    blockedWebsites = websites;
  }

  static Future<void> writeToHostsFile(String content) async {
    try {
      final hostsPath = getHostsPath();

      // Backup hosts file
      final backup = File('$hostsPath.backup');
      if (!await backup.exists()) {
        await backup.writeAsString(await File(hostsPath).readAsString());
      }

      // Write new content
      final file = File(hostsPath);
      await file.writeAsString(content);
    } on FileSystemException catch (e) {
      if (e.osError?.errorCode == 5) {
        // Access denied
        throw Exception(
            'Administrator privileges required. Right-click and "Run as Administrator"');
      }
      rethrow;
    }
  }

  static Future<List<String>> getCurrentBlockedWebsites() async {
    final content = await readHostsFile();
    final blockMatch = RegExp('$blockStart\\s*(.*?)\\s*$blockEnd', dotAll: true)
        .firstMatch(content);

    if (blockMatch == null) return [];

    return blockMatch
        .group(1)!
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .map((line) => line.split(RegExp(r'\s+'))[1]) // Extract domain
        .toList();
  }
}
