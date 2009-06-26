package net.moocowstudio.modelaircraftplanlibrary.events {
    import flash.events.Event;

    public class PlanEvent extends Event {
        /* Save Events */
        public static const onSavePlanType : String = "onSavePlanType";
        public static const onSavePublication : String = "onSavePublication";
        public static const onSaveDesigner : String = "onSaveDesigner";
        public static const onSavePlan : String = "onSavePlan";

        /* Load Events */
        public static const onLoadPlanTypes : String = "onLoadPlanTypes";
        public static const onLoadDesigners : String = "onLoadDesigners";
        public static const onLoadPublications : String = "onLoadPublications";

        public var data : Object;
        public var originator : Object;

        public function PlanEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
            super(type, bubbles, cancelable);
        }

    }
}