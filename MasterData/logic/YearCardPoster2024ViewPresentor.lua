-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/hud/YearCardPoster2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.hud.YearCardPoster2024ViewPresentor", package.seeall)

local YearCardPoster2024ViewPresentor = class("YearCardPoster2024ViewPresentor", ViewPresentor)

function YearCardPoster2024ViewPresentor:ctor()
	YearCardPoster2024ViewPresentor.super.ctor(self)
end

function YearCardPoster2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPoster2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/hud/yearcardposter2024view.prefab"
	}
end

function YearCardPoster2024ViewPresentor:buildViews()
	return {
		YearCardPoster2024View.New()
	}
end

return YearCardPoster2024ViewPresentor
