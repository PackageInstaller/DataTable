-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandVerifyFormExViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewHandVerifyFormExViewPresentor", package.seeall)

local NewHandVerifyFormExViewPresentor = class("NewHandVerifyFormExViewPresentor", ViewPresentor)

function NewHandVerifyFormExViewPresentor:ctor()
	NewHandVerifyFormExViewPresentor.super.ctor(self)
end

function NewHandVerifyFormExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewHandVerifyFormExViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandverifyformexview.prefab"
	}
end

function NewHandVerifyFormExViewPresentor:buildViews()
	return {
		NewHandVerifyFormExView.New()
	}
end

function NewHandVerifyFormExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return NewHandVerifyFormExViewPresentor
