-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/scroller/PassportScrollerTenSevenViewPresentor.lua

module("logic.extensions.passport.view.datesign.PassportScrollerTenSevenViewPresentor", package.seeall)

local PassportScrollerTenSevenViewPresentor = class("PassportScrollerTenSevenViewPresentor", ViewPresentor)

function PassportScrollerTenSevenViewPresentor:ctor()
	PassportScrollerTenSevenViewPresentor.super.ctor(self)
end

function PassportScrollerTenSevenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportScrollerTenSevenViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportscrollertensevenview.prefab"
	}
end

function PassportScrollerTenSevenViewPresentor:buildViews()
	return {
		PassportScrollerTenSevenView.New()
	}
end

function PassportScrollerTenSevenViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PassportScrollerTenSevenViewPresentor
