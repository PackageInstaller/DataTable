-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitydaylirecharge/view/WeektotalchargeViewPresentor.lua

module("logic.extensions.activitydaylirecharge.view.WeektotalchargeViewPresentor", package.seeall)

local WeektotalchargeViewPresentor = class("WeektotalchargeViewPresentor", ViewPresentor)

function WeektotalchargeViewPresentor:ctor()
	WeektotalchargeViewPresentor.super.ctor(self)
end

function WeektotalchargeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeektotalchargeViewPresentor:dependWhatResources()
	return {
		"ui/views/activitydaylirecharge/weektotalchargeview.prefab"
	}
end

function WeektotalchargeViewPresentor:buildViews()
	return {
		WeektotalchargeView.New()
	}
end

function WeektotalchargeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return WeektotalchargeViewPresentor
