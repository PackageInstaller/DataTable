-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardRankViewPresentor.lua

module("logic.extensions.yearcard.view.2022.YearCardRankViewPresentor", package.seeall)

local YearCardRankViewPresentor = class("YearCardRankViewPresentor", ViewPresentor)

function YearCardRankViewPresentor:ctor()
	YearCardRankViewPresentor.super.ctor(self)
end

function YearCardRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardRankViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/yearcardrankview.prefab"
	}
end

function YearCardRankViewPresentor:buildViews()
	return {
		YearCardRankView.New()
	}
end

return YearCardRankViewPresentor
