-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/view/LanternFestivalChannelViewPresentor.lua

module("logic.extensions.lanternfestival.view.LanternFestivalChannelViewPresentor", package.seeall)

local LanternFestivalChannelViewPresentor = class("LanternFestivalChannelViewPresentor", ViewPresentor)

function LanternFestivalChannelViewPresentor:ctor()
	LanternFestivalChannelViewPresentor.super.ctor(self)
end

function LanternFestivalChannelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LanternFestivalChannelViewPresentor:dependWhatResources()
	return {
		"ui/views/lanternfestival/lanternfestivalchannelview.prefab"
	}
end

function LanternFestivalChannelViewPresentor:buildViews()
	return {
		LanternFestivalChannelView.New()
	}
end

function LanternFestivalChannelViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LanternFestivalChannelViewPresentor
