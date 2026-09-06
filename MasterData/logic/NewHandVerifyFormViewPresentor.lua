-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandVerifyFormViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewHandVerifyFormViewPresentor", package.seeall)

local NewHandVerifyFormViewPresentor = class("NewHandVerifyFormViewPresentor", ViewPresentor)

function NewHandVerifyFormViewPresentor:ctor()
	NewHandVerifyFormViewPresentor.super.ctor(self)
end

function NewHandVerifyFormViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewHandVerifyFormViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandverifyformview.prefab"
	}
end

function NewHandVerifyFormViewPresentor:buildViews()
	return {
		NewHandVerifyFormView.New()
	}
end

function NewHandVerifyFormViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return NewHandVerifyFormViewPresentor
