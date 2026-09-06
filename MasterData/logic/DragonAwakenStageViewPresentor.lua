-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenStageViewPresentor.lua

module("logic.extensions.dragonawaken.view.DragonAwakenStageViewPresentor", package.seeall)

local DragonAwakenStageViewPresentor = class("DragonAwakenStageViewPresentor", ViewPresentor)

function DragonAwakenStageViewPresentor:ctor()
	DragonAwakenStageViewPresentor.super.ctor(self)
end

function DragonAwakenStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAwakenStageViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonawaken/dragonawakenstageview.prefab"
	}
end

function DragonAwakenStageViewPresentor:buildViews()
	return {
		DragonAwakenStageView.New()
	}
end

function DragonAwakenStageViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DragonAwakenStageViewPresentor
