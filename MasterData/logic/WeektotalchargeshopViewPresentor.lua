-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitydaylirecharge/view/WeektotalchargeshopViewPresentor.lua

module("logic.extensions.activitydaylirecharge.view.WeektotalchargeshopViewPresentor", package.seeall)

local WeektotalchargeshopViewPresentor = class("WeektotalchargeshopViewPresentor", ViewPresentor)

function WeektotalchargeshopViewPresentor:ctor()
	WeektotalchargeshopViewPresentor.super.ctor(self)
end

function WeektotalchargeshopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeektotalchargeshopViewPresentor:dependWhatResources()
	return {
		"ui/views/activitydaylirecharge/weektotalchargeshopview.prefab"
	}
end

function WeektotalchargeshopViewPresentor:buildViews()
	return {
		WeektotalchargeshopView.New()
	}
end

function WeektotalchargeshopViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return WeektotalchargeshopViewPresentor
