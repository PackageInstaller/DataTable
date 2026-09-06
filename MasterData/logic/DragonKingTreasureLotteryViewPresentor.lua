-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingtreasure/view/DragonKingTreasureLotteryViewPresentor.lua

module("logic.extensions.dragonkingtreasure.view.DragonKingTreasureLotteryViewPresentor", package.seeall)

local DragonKingTreasureLotteryViewPresentor = class("DragonKingTreasureLotteryViewPresentor", ViewPresentor)

function DragonKingTreasureLotteryViewPresentor:ctor()
	DragonKingTreasureLotteryViewPresentor.super.ctor(self)
end

function DragonKingTreasureLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DragonKingTreasureLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonkingtreasure/dragonkingtreasurelotteryview.prefab"
	}
end

function DragonKingTreasureLotteryViewPresentor:buildViews()
	return {
		DragonKingTreasureLotteryView.New()
	}
end

return DragonKingTreasureLotteryViewPresentor
