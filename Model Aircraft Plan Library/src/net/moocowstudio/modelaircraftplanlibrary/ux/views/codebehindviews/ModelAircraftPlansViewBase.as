package net.moocowstudio.modelaircraftplanlibrary.ux.views.codebehindviews {
    import flash.events.Event;

    import net.moocowstudio.modelaircraftplanlibrary.controller.Controller;
    import net.moocowstudio.modelaircraftplanlibrary.events.PlanEvent;
    import net.moocowstudio.modelaircraftplanlibrary.ux.views.ModelAircraftPlanEntryView;
    import net.moocowstudio.windowmanagement.UXWindow;

    public class ModelAircraftPlansViewBase extends UXWindow {
        public function ModelAircraftPlansViewBase() {
            super();
        }


        /* Label Functions */
        public function labelFunction_designers(item : Object, object : Object) : String {
            var text : String = item.designer_first_name + " " + item.designer_last_name;
            return text;
        }

        /* Event Handlers */
        public function onClick(event : Event) : void {
            switch (event.currentTarget.id) {
                case "linkbuttonAddPlan":
                    var windowModelAircraftPlanEntryView : ModelAircraftPlanEntryView = new ModelAircraftPlanEntryView();
                    windowManager.add(windowModelAircraftPlanEntryView);
                    windowModelAircraftPlanEntryView.addEventListener(PlanEvent.onSavePlan, Controller.getInstance().onSave);
                    break;
            }
        }


    }
}