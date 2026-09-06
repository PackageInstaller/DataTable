-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/ReturnTaskViewPresentor.lua

module("logic.extensions.recalltask.view.ReturnTaskViewPresentor", package.seeall)

local ReturnTaskViewPresentor = class("ReturnTaskViewPresentor", ViewPresentor)

function ReturnTaskViewPresentor:ctor()
	ReturnTaskViewPresentor.super.ctor(self)
end

function ReturnTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ReturnTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/recalltask/returntaskview.prefab"
	}
end

function ReturnTaskViewPresentor:buildViews()
	return {
		ReturnTaskView.New()
	}
end

return ReturnTaskViewPresentor
