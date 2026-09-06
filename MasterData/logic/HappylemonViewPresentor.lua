-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/HappylemonViewPresentor.lua

module("logic.extensions.bonus.view.HappylemonViewPresentor", package.seeall)

local HappylemonViewPresentor = class("HappylemonViewPresentor", ViewPresentor)

function HappylemonViewPresentor:ctor()
	HappylemonViewPresentor.super.ctor(self)
end

function HappylemonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HappylemonViewPresentor:dependWhatResources()
	return {
		"ui/views/happylemon/happylemonview.prefab"
	}
end

function HappylemonViewPresentor:buildViews()
	return {
		HappylemonView.New()
	}
end

function HappylemonViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HappylemonViewPresentor
