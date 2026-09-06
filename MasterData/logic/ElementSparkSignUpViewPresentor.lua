-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkSignUpViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkSignUpViewPresentor", package.seeall)

local ElementSparkSignUpViewPresentor = class("ElementSparkSignUpViewPresentor", ViewPresentor)

function ElementSparkSignUpViewPresentor:ctor()
	ElementSparkSignUpViewPresentor.super.ctor(self)
end

function ElementSparkSignUpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkSignUpViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparksignupview.prefab"
	}
end

function ElementSparkSignUpViewPresentor:buildViews()
	return {
		ElementSparkSignUpView.New()
	}
end

function ElementSparkSignUpViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ElementSparkSignUpViewPresentor
