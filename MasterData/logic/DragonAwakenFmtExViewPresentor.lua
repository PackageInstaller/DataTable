-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenFmtExViewPresentor.lua

module("logic.extensions.dragonawaken.view.DragonAwakenFmtExViewPresentor", package.seeall)

local DragonAwakenFmtExViewPresentor = class("DragonAwakenFmtExViewPresentor", ViewPresentor)

function DragonAwakenFmtExViewPresentor:ctor()
	DragonAwakenFmtExViewPresentor.super.ctor(self)
end

function DragonAwakenFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAwakenFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonawaken/dragonawakenfmtexview.prefab"
	}
end

function DragonAwakenFmtExViewPresentor:buildViews()
	return {
		DragonAwakenFmtExView.New()
	}
end

function DragonAwakenFmtExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DragonAwakenFmtExViewPresentor
