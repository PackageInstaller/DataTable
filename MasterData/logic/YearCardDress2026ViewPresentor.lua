-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardDress2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardDress2026ViewPresentor", package.seeall)

local YearCardDress2026ViewPresentor = class("YearCardDress2026ViewPresentor", ViewPresentor)

function YearCardDress2026ViewPresentor:ctor()
	YearCardDress2026ViewPresentor.super.ctor(self)
end

function YearCardDress2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardDress2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcarddress2026view.prefab"
	}
end

function YearCardDress2026ViewPresentor:buildViews()
	return {
		YearCardDress2026View.New()
	}
end

return YearCardDress2026ViewPresentor
