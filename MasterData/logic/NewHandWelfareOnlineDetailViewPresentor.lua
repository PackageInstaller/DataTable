-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandWelfareOnlineDetailViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewHandWelfareOnlineDetailViewPresentor", package.seeall)

local NewHandWelfareOnlineDetailViewPresentor = class("NewHandWelfareOnlineDetailViewPresentor", ViewPresentor)

function NewHandWelfareOnlineDetailViewPresentor:ctor()
	NewHandWelfareOnlineDetailViewPresentor.super.ctor(self)
end

function NewHandWelfareOnlineDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewHandWelfareOnlineDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandwelfareonlinedetailview.prefab"
	}
end

function NewHandWelfareOnlineDetailViewPresentor:buildViews()
	return {
		NewHandWelfareOnlineDetailView.New()
	}
end

function NewHandWelfareOnlineDetailViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return NewHandWelfareOnlineDetailViewPresentor
