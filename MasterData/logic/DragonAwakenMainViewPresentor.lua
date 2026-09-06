-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenMainViewPresentor.lua

module("logic.extensions.dragonawaken.view.DragonAwakenMainViewPresentor", package.seeall)

local DragonAwakenMainViewPresentor = class("DragonAwakenMainViewPresentor", ViewPresentor)

function DragonAwakenMainViewPresentor:ctor()
	DragonAwakenMainViewPresentor.super.ctor(self)
end

function DragonAwakenMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAwakenMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonawaken/dragonawakenmainview.prefab"
	}
end

function DragonAwakenMainViewPresentor:buildViews()
	return {
		DragonAwakenMainView.New()
	}
end

function DragonAwakenMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DragonAwakenMainViewPresentor
