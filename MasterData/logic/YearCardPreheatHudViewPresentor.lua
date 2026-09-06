-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardPreheatHudViewPresentor.lua

module("logic.extensions.yearcard.view.2022.YearCardPreheatHudViewPresentor", package.seeall)

local YearCardPreheatHudViewPresentor = class("YearCardPreheatHudViewPresentor", ViewPresentor)

function YearCardPreheatHudViewPresentor:ctor()
	YearCardPreheatHudViewPresentor.super.ctor(self)
end

function YearCardPreheatHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPreheatHudViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/yearcardpreheathudview.prefab"
	}
end

function YearCardPreheatHudViewPresentor:buildViews()
	return {
		YearCardPreheatHudView.New()
	}
end

return YearCardPreheatHudViewPresentor
