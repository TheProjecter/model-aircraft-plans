package net.moocowstudio.modelaircraftplanlibrary.modellocator {
    import mx.collections.ArrayCollection;


    /* << SINGLETON >> */
    [Bindable] public class DataProviderManager {
        /* Properties */
        private var _allMyDataProviders : ArrayCollection = new ArrayCollection();
        private static var _instance : DataProviderManager = null;

        /* Functions */
        public static function getInstance() : DataProviderManager {
            if (_instance == null) {
                _instance = new DataProviderManager();
            }
            return _instance;
        }

        public function getDataProviderValueForKey(key : String, withResultsFromSQL : String) : Array {
            /* Search through the data providers for a match. If there is no
             * data provider available for the key, attempt to create a new one. */
            var dp : DataProvider;
            for each (dp in this._allMyDataProviders) {
                if (dp.key == key) {
                    break;
                } else {
                    dp = null;
                }
            }
            if (dp == null) {
                dp = new DataProvider(key, withResultsFromSQL);
                this._allMyDataProviders.addItem(dp);
            }
            return dp.value;
        }

        public function setDataProviderValueForKey(value : Object, forKey : String) : void {

        }

        public function removeDataProviderForKey(key : String) : void {
            var indexOfItemToRemove : int = 0;
            var dp : DataProvider;
            for each (dp in this._allMyDataProviders) {
                if (dp.key == key) {
                    break;
                }
                indexOfItemToRemove++;
            }
            this._allMyDataProviders.removeItemAt(indexOfItemToRemove);
        }

        public function addDataProvider(dp : DataProvider) : void {
            this._allMyDataProviders.addItem(dp);
        }


    }
}