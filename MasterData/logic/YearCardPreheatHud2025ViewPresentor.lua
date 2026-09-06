-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/hud/YearCardPreheatHud2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.hud.YearCardPreheatHud2025ViewPresentor", package.seeall)

local YearCardPreheatHud2025ViewPresentor = class("YearCardPreheatHud2025ViewPresentor", ViewPresentor)

function YearCardPreheatHud2025ViewPresentor:ctor()
	YearCardPreheatHud2025ViewPresentor.super.ctor(self)
end

function YearCardPreheatHud2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPreheatHud2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/hud/yearcardpreheathud2025view.prefab"
	}
end

function YearCardPreheatHud2025ViewPresentor:buildViews()
	return {
		YearCardPreheatHud2025View.New()
	}
end

return YearCardPreheatHud2025ViewPresentor
