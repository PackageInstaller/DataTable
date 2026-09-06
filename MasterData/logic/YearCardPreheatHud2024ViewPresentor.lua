-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/hud/YearCardPreheatHud2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.hud.YearCardPreheatHud2024ViewPresentor", package.seeall)

local YearCardPreheatHud2024ViewPresentor = class("YearCardPreheatHud2024ViewPresentor", ViewPresentor)

function YearCardPreheatHud2024ViewPresentor:ctor()
	YearCardPreheatHud2024ViewPresentor.super.ctor(self)
end

function YearCardPreheatHud2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPreheatHud2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/hud/yearcardpreheathud2024view.prefab"
	}
end

function YearCardPreheatHud2024ViewPresentor:buildViews()
	return {
		YearCardPreheatHud2024View.New()
	}
end

return YearCardPreheatHud2024ViewPresentor
