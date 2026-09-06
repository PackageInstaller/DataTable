-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportshowPresentor.lua

module("logic.extensions.passport.view.PassportshowPresentor", package.seeall)

local PassportshowPresentor = class("PassportshowPresentor", ViewPresentor)

function PassportshowPresentor:ctor()
	PassportshowPresentor.super.ctor(self)
end

function PassportshowPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportshowPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportshowview.prefab"
	}
end

function PassportshowPresentor:buildViews()
	return {
		PassportshowView.New()
	}
end

function PassportshowPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PassportshowPresentor
