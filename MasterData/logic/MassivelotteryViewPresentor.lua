-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/MassivelotteryViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.MassivelotteryViewPresentor", package.seeall)

local MassivelotteryViewPresentor = class("MassivelotteryViewPresentor", ViewPresentor)

function MassivelotteryViewPresentor:ctor()
	MassivelotteryViewPresentor.super.ctor(self)
end

function MassivelotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MassivelotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/massivelotteryview.prefab"
	}
end

function MassivelotteryViewPresentor:buildViews()
	return {
		MassivelotteryView.New()
	}
end

return MassivelotteryViewPresentor
