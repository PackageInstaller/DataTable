-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/hud/YearCardPreheatHud2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.hud.YearCardPreheatHud2023ViewPresentor", package.seeall)

local YearCardPreheatHud2023ViewPresentor = class("YearCardPreheatHud2023ViewPresentor", ViewPresentor)

function YearCardPreheatHud2023ViewPresentor:ctor()
	YearCardPreheatHud2023ViewPresentor.super.ctor(self)
end

function YearCardPreheatHud2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPreheatHud2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/hud/yearcardpreheathud2023view.prefab"
	}
end

function YearCardPreheatHud2023ViewPresentor:buildViews()
	return {
		YearCardPreheatHud2023View.New()
	}
end

return YearCardPreheatHud2023ViewPresentor
