-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/ContinuousRechargeViewPresentor.lua

module("logic.extensions.doubleeleven.view.ContinuousRechargeViewPresentor", package.seeall)

local ContinuousRechargeViewPresentor = class("ContinuousRechargeViewPresentor", ViewWithGuidePresentor)

function ContinuousRechargeViewPresentor:ctor()
	ContinuousRechargeViewPresentor.super.ctor(self)
end

function ContinuousRechargeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContinuousRechargeViewPresentor:dependWhatResources()
	return {
		"ui/views/doubleeleven/continuousrechargeview.prefab"
	}
end

function ContinuousRechargeViewPresentor:buildViews()
	return {
		ContinuousRechargeView.New()
	}
end

return ContinuousRechargeViewPresentor
