-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/datesign/PassportDateSignViewPresentor.lua

module("logic.extensions.passport.view.datesign.PassportDateSignViewPresentor", package.seeall)

local PassportDateSignViewPresentor = class("PassportDateSignViewPresentor", ViewPresentor)

function PassportDateSignViewPresentor:ctor()
	PassportDateSignViewPresentor.super.ctor(self)
end

function PassportDateSignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportDateSignViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportdatesignview.prefab"
	}
end

function PassportDateSignViewPresentor:buildViews()
	return {
		PassportDateSignView.New()
	}
end

function PassportDateSignViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PassportDateSignViewPresentor
