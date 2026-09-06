-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/view/GuardDestroyRankViewPresentor.lua

module("logic.extensions.guarddestroy.view.GuardDestroyRankViewPresentor", package.seeall)

local GuardDestroyRankViewPresentor = class("GuardDestroyRankViewPresentor", ViewPresentor)

function GuardDestroyRankViewPresentor:ctor()
	GuardDestroyRankViewPresentor.super.ctor(self)
end

function GuardDestroyRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardDestroyRankViewPresentor:dependWhatResources()
	return {
		"ui/views/guarddestroy/guarddestroyrankview.prefab"
	}
end

function GuardDestroyRankViewPresentor:buildViews()
	return {
		GuardDestroyRankView.New()
	}
end

return GuardDestroyRankViewPresentor
