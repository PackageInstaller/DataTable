-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/saintknight/PassportSaintKnightBuyViewPresentor.lua

module("logic.extensions.passport.view.saintknight.PassportSaintKnightBuyViewPresentor", package.seeall)

local PassportSaintKnightBuyViewPresentor = class("PassportSaintKnightBuyViewPresentor", ViewPresentor)

function PassportSaintKnightBuyViewPresentor:ctor()
	PassportSaintKnightBuyViewPresentor.super.ctor(self)
end

function PassportSaintKnightBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportSaintKnightBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/saintknight/passportsaintknightbuyview.prefab"
	}
end

function PassportSaintKnightBuyViewPresentor:buildViews()
	return {
		PassportSaintKnightBuyView.New()
	}
end

return PassportSaintKnightBuyViewPresentor
