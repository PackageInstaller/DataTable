-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/saintknight/PassportSaintKnightViewPresentor.lua

module("logic.extensions.passport.view.saintknight.PassportSaintKnightViewPresentor", package.seeall)

local PassportSaintKnightViewPresentor = class("PassportSaintKnightViewPresentor", ViewPresentor)

function PassportSaintKnightViewPresentor:ctor()
	PassportSaintKnightViewPresentor.super.ctor(self)
end

function PassportSaintKnightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportSaintKnightViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/saintknight/passportsaintknightview.prefab"
	}
end

function PassportSaintKnightViewPresentor:buildViews()
	return {
		PassportSaintKnightView.New()
	}
end

function PassportSaintKnightViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PassportSaintKnightViewPresentor
