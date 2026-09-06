-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signinbuff/view/CommonSignInBuffViewPresentor.lua

module("logic.extensions.signinbuff.view.CommonSignInBuffViewPresentor", package.seeall)

local CommonSignInBuffViewPresentor = class("CommonSignInBuffViewPresentor", ViewPresentor)

function CommonSignInBuffViewPresentor:ctor()
	CommonSignInBuffViewPresentor.super.ctor(self)
end

function CommonSignInBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CommonSignInBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/commonsigninbuff/commonsigninbuffview.prefab"
	}
end

function CommonSignInBuffViewPresentor:buildViews()
	return {
		CommonSignInBuffView.New()
	}
end

function CommonSignInBuffViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CommonSignInBuffViewPresentor
