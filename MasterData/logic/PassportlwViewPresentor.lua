-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportlwViewPresentor.lua

module("logic.extensions.passport.view.PassportlwViewPresentor", package.seeall)

local PassportlwViewPresentor = class("PassportlwViewPresentor", ViewPresentor)

function PassportlwViewPresentor:ctor()
	PassportlwViewPresentor.super.ctor(self)
end

function PassportlwViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportlwViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportlwview.prefab"
	}
end

function PassportlwViewPresentor:buildViews()
	return {
		PassportlwView.New()
	}
end

function PassportlwViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PassportlwViewPresentor
