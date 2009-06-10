package net.moocowstudio.modelaircraft.database {
    import flash.data.SQLConnection;
    import flash.data.SQLStatement;
    import flash.utils.ByteArray;

    import mx.collections.ArrayCollection;

    import net.moocowstudio.modelaircraft.Aircraft;
    import net.moocowstudio.modelaircraft.model.AircraftType;
    import net.moocowstudio.modelaircraft.model.Designer;
    import net.moocowstudio.modelaircraft.model.Publication;


    public class Database {
        import flash.filesystem.File;

        /* Database */
        private var database : File = File.applicationStorageDirectory.resolvePath("aircraft.db");
        private var sqlConnection : SQLConnection = new SQLConnection();
        private var sqlStatement : SQLStatement = new SQLStatement()

        private const kCOUNTER_KEY_AIRCRAFT : int = 1;
        private const kCOUNTER_KEY_PUBLICATION : int = 2;
        private const kCOUNTER_KEY_DESIGNER : int = 3;
        private const kCOUNTER_KEY_TYPE : int = 4;

        public function Database() {
            this.connect();
        }

        public function addAircraft(
            name : String,
            wingspan : int,
            year : String,
            publicationId : int,
            designerId : int,
            aircraftTypeId : int,
            image : ByteArray) : void {
//var sql : String = "insert into aircraft values(?,?,?,?,?,?,?,?)";

            var sql : String = "insert into aircraft values(" +
                this.getCountFor(this.kCOUNTER_KEY_AIRCRAFT) + ",'" +
                name + "'," +
                publicationId + "," +
                designerId + "," +
                aircraftTypeId + ",'" +
                year + "'," +
                wingspan + ",'" +
                Helper.byteArrayToBase64(image) + "'" +
                ")";


            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;
            /*var id : int = this.getCountFor(this.kCOUNTER_KEY_AIRCRAFT);
               sqlStatement.parameters[0] = id;
               sqlStatement.parameters[1] = name;
               sqlStatement.parameters[2] = publicationId;
               sqlStatement.parameters[3] = designerId;
               sqlStatement.parameters[4] = aircraftTypeId;
               sqlStatement.parameters[5] = year;
               sqlStatement.parameters[6] = wingspan;
             sqlStatement.parameters[7] = image;*/

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
        }

        private function connect() : void {
            /* Open the database.
             * Abre la conexion a la base de datos.*/
            this.sqlConnection.open(database);

            /* Link statement to connection.
             * Liga la declaracion a la conexion de base de datos.*/
            this.sqlStatement.sqlConnection = this.sqlConnection;
        }

        private function deleteCurrentDatabase() : void {
            var sql : String = "drop table aircraft";

            /* Link statement to connection.
             * Liga la declaracion a la conexion de base de datos.*/
            this.sqlStatement.sqlConnection = this.sqlConnection;

            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
        }

        public function createAircraftDatabase() : void {
            /* Remove the existing database.
             * Primero, necesamos eliminar el corriente base de datos. */
            this.deleteCurrentDatabase();
            var sql : String = "create table" +
                "    aircraft(" +
                "       aircraft_id integer not null," +
                "       name text," +
                "       publication_id int," +
                "       designer_id int," +
                "       aircraft_type_id int," +
                "       year text," +
                "       wingspan integer," +
                "       image BLOB," +
                "       primary key(aircraft_id));";

            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();

        }

        public function installDatabase() : void {

            var sql : String;
//Publication
            sql = "create table" +
                "    publication(" +
                "       publication_id integer not null," +
                "       title text," +
                "       primary key(publication_id));";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
//Type
            sql = "create table" +
                "    type(" +
                "       type_id integer not null," +
                "       title text," +
                "       primary key(type_id));";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();

            //Designer
            sql = "create table" +
                "    designer(" +
                "       designer_id integer not null," +
                "       first_name text," +
                "       last_name text," +
                "       primary key(designer_id));";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
        }

        public function addDesigner(
            firstName : String,
            lastName : String) : void {
            var sql : String = "insert into designer values(" +
                this.getCountFor(this.kCOUNTER_KEY_DESIGNER) + ",'" +
                firstName + "','" +
                lastName +
                "')";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
        }

        public function addPublication(
            title : String) : void {
            var sql : String = "insert into publication values(" +
                this.getCountFor(this.kCOUNTER_KEY_PUBLICATION) + ",'" +
                title + "')";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            sqlStatement.execute();
        }



        public function addType(
            title : String) : void {
            var sql : String = "insert into type values(" +
                this.getCountFor(this.kCOUNTER_KEY_TYPE) + ",'" +
                title + "')";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;
            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            sqlStatement.execute();
        }

        public function getAllDesigners() : ArrayCollection {
            var sql : String = "select * from designer";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
            var result : Array = sqlStatement.getResult().data;
            var designers : ArrayCollection = new ArrayCollection();
            for each (var object : Object in result) {
                var designer : Designer = new Designer;
                designer.firstName = object.first_name;
                designer.id = object.designer_id;
                designer.lastName = object.last_name;
                designers.addItem(designer);
            }
            return designers;
        }

        public function getAllAircraftTypes() : ArrayCollection {
            var sql : String = "select * from type";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
            var result : Array = sqlStatement.getResult().data;
            var collection : ArrayCollection = new ArrayCollection();
            for each (var object : Object in result) {
                var o : AircraftType = new AircraftType();
                o.title = object.title;
                o.id = object.type_id;
                collection.addItem(o);
            }
            return collection;
        }

        public function getAllAircraft() : Array {
            var sql : String = "select * from aircraft";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
            var result : Array = sqlStatement.getResult().data;
            var collection : Array = new Array();
            for each (var object : Object in result) {
                var o : Aircraft = new Aircraft();
                o.name = object.name;
                o.id = object.aircraft_id;
                o.designerId = object.designer_id;
                o.publicationId = object.publication_id;
                o.typeId = object.aircraft_type_id;
                o.wingSpan = object.wingspan;
                o.year = object.year;
                o.image = Helper.base64ToByteArray(object.image);

                collection.push(o);
            }
            return collection;
        }

        public function valuesForKey(keyName : String, keyValue : int, onTable : String) : Array {
            var sql : String = "select * from " + onTable + " where " + keyName + " = " + keyValue;
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;
            trace(sql);
            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
            var result : Array = sqlStatement.getResult().data;

            return result;
        }

        public function getAllPublications() : ArrayCollection {
            var sql : String = "select * from publication";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
            var result : Array = sqlStatement.getResult().data;
            var collection : ArrayCollection = new ArrayCollection();
            for each (var object : Object in result) {
                var o : Publication = new Publication();
                o.title = object.title;
                o.id = object.publication_id;
                collection.addItem(o);
            }
            return collection;
        }


        private function getCountFor(key : int) : int {
            var sql : String = "select * from counter where counter_id = " + key;

            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            this.sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
            var result : Array = this.sqlStatement.getResult().data;
            var count : int = result[0].count;
            count++;
            this.incrementCountForKey(key, count);
            return count;
        }

        public function incrementCountForKey(key : int, count : int) : void {
            var sql : String = "update counter set count = " + count + " where counter_id = " + key;

            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            this.sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
        }

        public function createCounterTable() : void {
// Count
            var sql : String = "create table" +
                "    counter(" +
                "       counter_id integer not null," +
                "       count integer," +
                "       primary key(counter_id));";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            this.sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            //this.sqlStatement.execute();

            sql = "insert into counter values(1,1)";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            this.sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
            sql = "insert into counter values(2,1);";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            this.sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
            sql = "insert into counter values(3,1);";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            this.sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
            sql = "insert into counter values(4,1);";
            /* Set the sql statement string.
             * Pon el SQL declaracion.*/
            this.sqlStatement.text = sql;

            /* Execute the sql statement.
             * Finaliza el SQL declaracion.*/
            this.sqlStatement.execute();
        }

    }
}