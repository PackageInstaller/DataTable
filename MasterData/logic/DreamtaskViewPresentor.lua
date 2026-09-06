-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/view/DreamtaskViewPresentor.lua

module("logic.extensions.dreamyouth.view.DreamtaskViewPresentor", package.seeall)

local DreamtaskViewPresentor = class("DreamtaskViewPresentor", ViewPresentor)

function DreamtaskViewPresentor:ctor()
	DreamtaskViewPresentor.super.ctor(self)
end

function DreamtaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamtaskViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamyouth/dreamtaskview.prefab"
	}
end

function DreamtaskViewPresentor:buildViews()
	return {
		DreamtaskView.New()
	}
end

return DreamtaskViewPresentor
