-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupOddsPrizeViewPresentor.lua

module("logic.extensions.worldcup.view.WorldCupOddsPrizeViewPresentor", package.seeall)

local WorldCupOddsPrizeViewPresentor = class("WorldCupOddsPrizeViewPresentor", ViewPresentor)

function WorldCupOddsPrizeViewPresentor:ctor()
	WorldCupOddsPrizeViewPresentor.super.ctor(self)
end

function WorldCupOddsPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WorldCupOddsPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/worldcup/worldcupoddsprizeview.prefab"
	}
end

function WorldCupOddsPrizeViewPresentor:buildViews()
	return {
		WorldCupOddsPrizeView.New()
	}
end

return WorldCupOddsPrizeViewPresentor
