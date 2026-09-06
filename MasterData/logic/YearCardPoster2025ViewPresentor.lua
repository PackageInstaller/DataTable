-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/hud/YearCardPoster2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.hud.YearCardPoster2025ViewPresentor", package.seeall)

local YearCardPoster2025ViewPresentor = class("YearCardPoster2025ViewPresentor", ViewPresentor)

function YearCardPoster2025ViewPresentor:ctor()
	YearCardPoster2025ViewPresentor.super.ctor(self)
end

function YearCardPoster2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPoster2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/hud/yearcardposter2025view.prefab"
	}
end

function YearCardPoster2025ViewPresentor:buildViews()
	return {
		YearCardPoster2025View.New()
	}
end

return YearCardPoster2025ViewPresentor
