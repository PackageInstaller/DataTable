-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardDress2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardDress2024ViewPresentor", package.seeall)

local YearCardDress2024ViewPresentor = class("YearCardDress2024ViewPresentor", ViewPresentor)

function YearCardDress2024ViewPresentor:ctor()
	YearCardDress2024ViewPresentor.super.ctor(self)
end

function YearCardDress2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardDress2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/main/yearcarddress2024view.prefab"
	}
end

function YearCardDress2024ViewPresentor:buildViews()
	return {
		YearCardDress2024View.New()
	}
end

return YearCardDress2024ViewPresentor
