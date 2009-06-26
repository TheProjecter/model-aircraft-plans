package net.moocowstudio.modelaircraftplanlibrary.modellocator {

    [Bindable] public class DataProvider {
        /* Properties */
        public var value : Array;
        public var key : String;
        private var sql : String;

        public function DataProvider(forKey : String, withResultsFromSQL : String) {
            this.key = forKey;
            this.sql = withResultsFromSQL;
            var dpi : DataProviderInitializer = new DataProviderInitializer(this, sql);
        }

    }
}