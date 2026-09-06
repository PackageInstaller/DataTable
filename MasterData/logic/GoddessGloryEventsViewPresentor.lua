-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddessGloryEventsViewPresentor.lua

module("logic.extensions.goddessglory.view.GoddessGloryEventsViewPresentor", package.seeall)

local GoddessGloryEventsViewPresentor = class("GoddessGloryEventsViewPresentor", ViewPresentor)

function GoddessGloryEventsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessGloryEventsViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessglory/goddessgloryeventview.prefab"
	}
end

function GoddessGloryEventsViewPresentor:buildViews()
	return {
		GoddessGloryEventsView.New()
	}
end

return GoddessGloryEventsViewPresentor
