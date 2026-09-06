-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardDress2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardDress2025ViewPresentor", package.seeall)

local YearCardDress2025ViewPresentor = class("YearCardDress2025ViewPresentor", ViewPresentor)

function YearCardDress2025ViewPresentor:ctor()
	YearCardDress2025ViewPresentor.super.ctor(self)
end

function YearCardDress2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardDress2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcarddress2025view.prefab"
	}
end

function YearCardDress2025ViewPresentor:buildViews()
	return {
		YearCardDress2025View.New()
	}
end

return YearCardDress2025ViewPresentor
