-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/hud/YearCardPoster2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.hud.YearCardPoster2023ViewPresentor", package.seeall)

local YearCardPoster2023ViewPresentor = class("YearCardPoster2023ViewPresentor", ViewPresentor)

function YearCardPoster2023ViewPresentor:ctor()
	YearCardPoster2023ViewPresentor.super.ctor(self)
end

function YearCardPoster2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPoster2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/hud/yearcardposter2023view.prefab"
	}
end

function YearCardPoster2023ViewPresentor:buildViews()
	return {
		YearCardPoster2023View.New()
	}
end

return YearCardPoster2023ViewPresentor
