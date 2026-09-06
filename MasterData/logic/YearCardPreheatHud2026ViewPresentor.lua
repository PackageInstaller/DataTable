-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/hud/YearCardPreheatHud2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.hud.YearCardPreheatHud2026ViewPresentor", package.seeall)

local YearCardPreheatHud2026ViewPresentor = class("YearCardPreheatHud2026ViewPresentor", ViewPresentor)

function YearCardPreheatHud2026ViewPresentor:ctor()
	YearCardPreheatHud2026ViewPresentor.super.ctor(self)
end

function YearCardPreheatHud2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPreheatHud2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/hud/yearcardpreheathud2026view.prefab"
	}
end

function YearCardPreheatHud2026ViewPresentor:buildViews()
	return {
		YearCardPreheatHud2026View.New()
	}
end

return YearCardPreheatHud2026ViewPresentor
