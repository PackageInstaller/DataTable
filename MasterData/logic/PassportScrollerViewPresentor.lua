-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/scroller/PassportScrollerViewPresentor.lua

module("logic.extensions.passport.view.datesign.PassportScrollerViewPresentor", package.seeall)

local PassportScrollerViewPresentor = class("PassportScrollerViewPresentor", ViewPresentor)

function PassportScrollerViewPresentor:ctor()
	PassportScrollerViewPresentor.super.ctor(self)
end

function PassportScrollerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportScrollerViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportscrollerview.prefab"
	}
end

function PassportScrollerViewPresentor:buildViews()
	return {
		PassportScrollerView.New()
	}
end

function PassportScrollerViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PassportScrollerViewPresentor
