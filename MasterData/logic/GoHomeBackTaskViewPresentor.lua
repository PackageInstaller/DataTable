-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/gohome/GoHomeBackTaskViewPresentor.lua

module("logic.extensions.playerreturn.view.gohome.GoHomeBackTaskViewPresentor", package.seeall)

local GoHomeBackTaskViewPresentor = class("GoHomeBackTaskViewPresentor", ViewWithGuidePresentor)

function GoHomeBackTaskViewPresentor:ctor()
	GoHomeBackTaskViewPresentor.super.ctor(self)
end

function GoHomeBackTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoHomeBackTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/gohome/gohomebacktaskview.prefab"
	}
end

function GoHomeBackTaskViewPresentor:buildViews()
	return {
		GoHomeBackTaskView.New()
	}
end

return GoHomeBackTaskViewPresentor
