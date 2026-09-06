-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianhelp/view/TunTianHelpLotteryViewPresentor.lua

module("logic.extensions.tuntianhelp.view.TunTianHelpLotteryViewPresentor", package.seeall)

local TunTianHelpLotteryViewPresentor = class("TunTianHelpLotteryViewPresentor", ViewPresentor)

function TunTianHelpLotteryViewPresentor:ctor()
	TunTianHelpLotteryViewPresentor.super.ctor(self)
end

function TunTianHelpLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TunTianHelpLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/tuntianhelp/tuntianhelplotteryview.prefab"
	}
end

function TunTianHelpLotteryViewPresentor:buildViews()
	return {
		TunTianHelpLotteryView.New()
	}
end

return TunTianHelpLotteryViewPresentor
