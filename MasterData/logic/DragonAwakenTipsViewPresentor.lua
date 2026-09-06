-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenTipsViewPresentor.lua

module("logic.extensions.dragonawaken.view.DragonAwakenTipsViewPresentor", package.seeall)

local DragonAwakenTipsViewPresentor = class("DragonAwakenTipsViewPresentor", ViewPresentor)

function DragonAwakenTipsViewPresentor:ctor()
	DragonAwakenTipsViewPresentor.super.ctor(self)
end

function DragonAwakenTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAwakenTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonawaken/dragonawakentipsview.prefab"
	}
end

function DragonAwakenTipsViewPresentor:buildViews()
	return {
		DragonAwakenTipsView.New()
	}
end

return DragonAwakenTipsViewPresentor
