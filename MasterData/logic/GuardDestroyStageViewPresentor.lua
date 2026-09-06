-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/view/GuardDestroyStageViewPresentor.lua

module("logic.extensions.guarddestroy.view.GuardDestroyStageViewPresentor", package.seeall)

local GuardDestroyStageViewPresentor = class("GuardDestroyStageViewPresentor", ViewPresentor)

function GuardDestroyStageViewPresentor:ctor()
	GuardDestroyStageViewPresentor.super.ctor(self)
end

function GuardDestroyStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardDestroyStageViewPresentor:dependWhatResources()
	return {
		"ui/views/guarddestroy/guarddestroystageview.prefab"
	}
end

function GuardDestroyStageViewPresentor:buildViews()
	return {
		GuardDestroyStageView.New()
	}
end

return GuardDestroyStageViewPresentor
