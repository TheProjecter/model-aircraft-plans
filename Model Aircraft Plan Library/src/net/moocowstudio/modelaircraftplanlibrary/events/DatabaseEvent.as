package net.moocowstudio.modelaircraftplanlibrary.events {
    import flash.events.Event;

    public class DatabaseEvent extends Event {
        /* Properties */
        public static const didSaveToDatabase : String = "didSaveToDatabase";
        public static const didNotSaveToDatabase : String = "didNotSaveToDatabase";
        public static const didLoadFromDatabase : String = "didLoadFromDatabase";
        public static const didNotLoadFromDatabase : String = "didNotLoadFromDatabase";

        public function DatabaseEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
            super(type, bubbles, cancelable);
        }

    }
}