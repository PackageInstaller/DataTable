-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/hud/YearCardPoster2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.hud.YearCardPoster2026ViewPresentor", package.seeall)

local YearCardPoster2026ViewPresentor = class("YearCardPoster2026ViewPresentor", ViewPresentor)

function YearCardPoster2026ViewPresentor:ctor()
	YearCardPoster2026ViewPresentor.super.ctor(self)
end

function YearCardPoster2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPoster2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/hud/yearcardposter2026view.prefab"
	}
end

function YearCardPoster2026ViewPresentor:buildViews()
	return {
		YearCardPoster2026View.New()
	}
end

return YearCardPoster2026ViewPresentor
