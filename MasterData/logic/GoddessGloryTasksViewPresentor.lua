-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddessGloryTasksViewPresentor.lua

module("logic.extensions.goddessglory.view.GoddessGloryTasksViewPresentor", package.seeall)

local GoddessGloryTasksViewPresentor = class("GoddessGloryTasksViewPresentor", ViewPresentor)

function GoddessGloryTasksViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessGloryTasksViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessglory/goddessglorytaskview.prefab"
	}
end

function GoddessGloryTasksViewPresentor:buildViews()
	return {
		GoddessGloryTasksView.New()
	}
end

return GoddessGloryTasksViewPresentor
