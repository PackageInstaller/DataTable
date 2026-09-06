-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/christmasandnewyear/YueyingwangViewPresentor.lua

module("logic.extensions.bonus.view.christmasandnewyear.YueyingwangViewPresentor", package.seeall)

local YueyingwangViewPresentor = class("YueyingwangViewPresentor", ViewPresentor)

function YueyingwangViewPresentor:ctor()
	YueyingwangViewPresentor.super.ctor(self)
end

function YueyingwangViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YueyingwangViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/christmasandnewyear/yueyingwangview.prefab"
	}
end

function YueyingwangViewPresentor:buildViews()
	return {
		YueyingwangView.New()
	}
end

return YueyingwangViewPresentor
