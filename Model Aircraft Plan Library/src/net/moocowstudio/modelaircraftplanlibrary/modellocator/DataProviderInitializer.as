package net.moocowstudio.modelaircraftplanlibrary.modellocator {
    import flash.events.SQLEvent;

    import net.moocowstudio.modelaircraftplanlibrary.database.sqlite.Query;
    import net.moocowstudio.modelaircraftplanlibrary.database.sqlite.SQLite;


    public class DataProviderInitializer {
        /* Properties */
        private var sqlLite : SQLite = new SQLite();
        private var query : Query = new Query();
        private var dataProvider : DataProvider;

        public function DataProviderInitializer(dp : DataProvider, withResultsFromSQL : String) {
            sqlLite.file = "library.db";
            sqlLite.addEventListener(SQLEvent.OPEN, onOpen);
            this.dataProvider = dp;
            query.sql = withResultsFromSQL;
            query.connection = sqlLite.connection;
        }

        private function initialize() : void {
            query.addEventListener(SQLEvent.RESULT, onResult);
            query.execute();
        }

        /* Event Handlers */
        private function onResult(event : SQLEvent) : void {
            this.dataProvider.value = this.query.data;
        }

        private function onOpen(event : SQLEvent) : void {
            trace("Ready...");
            this.initialize();
        }

    }
}