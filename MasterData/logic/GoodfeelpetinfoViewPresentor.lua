-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelpetinfoViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelpetinfoViewPresentor", package.seeall)

local GoodfeelpetinfoViewPresentor = class("GoodfeelpetinfoViewPresentor", ViewPresentor)

function GoodfeelpetinfoViewPresentor:ctor()
	GoodfeelpetinfoViewPresentor.super.ctor(self)
end

function GoodfeelpetinfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoodfeelpetinfoViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelpetinfoview.prefab"
	}
end

function GoodfeelpetinfoViewPresentor:buildViews()
	return {
		GoodfeelpetinfoView.New()
	}
end

function GoodfeelpetinfoViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoodfeelpetinfoViewPresentor
