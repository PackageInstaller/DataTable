-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/YirenpozhenrankViewPresentor.lua

module("logic.extensions.yirenpozhen.view.YirenpozhenrankViewPresentor", package.seeall)

local YirenpozhenrankViewPresentor = class("YirenpozhenrankViewPresentor", ViewPresentor)

function YirenpozhenrankViewPresentor:ctor()
	YirenpozhenrankViewPresentor.super.ctor(self)
end

function YirenpozhenrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YirenpozhenrankViewPresentor:dependWhatResources()
	return {
		"ui/views/yirenpozhen/yirenpozhenrankview.prefab"
	}
end

function YirenpozhenrankViewPresentor:buildViews()
	return {
		YirenPozhenRankView.New()
	}
end

return YirenpozhenrankViewPresentor
