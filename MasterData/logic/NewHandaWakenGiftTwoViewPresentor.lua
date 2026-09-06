-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandaWakenGiftTwoViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewHandaWakenGiftTwoViewPresentor", package.seeall)

local NewHandaWakenGiftTwoViewPresentor = class("NewHandaWakenGiftTwoViewPresentor", ViewPresentor)

function NewHandaWakenGiftTwoViewPresentor:ctor()
	NewHandaWakenGiftTwoViewPresentor.super.ctor(self)
end

function NewHandaWakenGiftTwoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewHandaWakenGiftTwoViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandawakengifttwoview.prefab"
	}
end

function NewHandaWakenGiftTwoViewPresentor:buildViews()
	return {
		NewHandaWakenGiftTwoView.New()
	}
end

function NewHandaWakenGiftTwoViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return NewHandaWakenGiftTwoViewPresentor
