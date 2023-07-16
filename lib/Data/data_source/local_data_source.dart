
import 'package:TutApp/Data/network/error_handler.dart';
import 'package:TutApp/Data/response/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_TIME = 60*1000; // 1 min in millis

const CACHE_STORE_DETAILS_KEY = "CACHE_STORE_DETAILS_KEY";
const CACHE_STORE_DETAILS_TIME = 60*1000; // 1 min in millis

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeToCache(HomeResponse homeResponse);

  Future<StoreDetailsResponse> getStoreDetails();
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse storeDetailsResponse);

  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource{

  Map<String,CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData() {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if(cachedItem !=null && cachedItem.isValid(CACHE_HOME_TIME)){
      //return the response
      return cachedItem.data;
    }
    else{
      //cache is empty
      throw ErrorHandler.handle(DataSourse.CHACHE_ERROE);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async{
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

    if(cachedItem !=null && cachedItem.isValid(CACHE_STORE_DETAILS_TIME)){
      //return the response
      return cachedItem.data;
    }
    else{
      //cache is empty
      throw ErrorHandler.handle(DataSourse.CHACHE_ERROE);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse storeDetailsResponse) async{
    cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(storeDetailsResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }



}
class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CacheItemExtention on CachedItem{
  bool isValid(int timeInMillis){

    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTimeInMillis-cacheTime <=timeInMillis;

    return isValid;
  }
}