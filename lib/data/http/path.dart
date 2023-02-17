enum APIPath {
  getYoutubeCategoryTree,
  getYoutubeList,
  bunruiYoutubeData,
  getDeletedVideo,
  getSpecialVideo,
  updateVideoPlayedAt
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.getYoutubeCategoryTree:
        return 'getYoutubeCategoryTree';
      case APIPath.getYoutubeList:
        return 'getYoutubeList';
      case APIPath.bunruiYoutubeData:
        return 'bunruiYoutubeData';
      case APIPath.getDeletedVideo:
        return 'getDeletedVideo';
      case APIPath.getSpecialVideo:
        return 'getSpecialVideo';
      case APIPath.updateVideoPlayedAt:
        return 'updateVideoPlayedAt';
    }
  }
}
