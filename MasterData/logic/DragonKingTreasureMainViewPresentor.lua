-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingtreasure/view/DragonKingTreasureMainViewPresentor.lua

module("logic.extensions.dragonkingtreasure.view.DragonKingTreasureMainViewPresentor", package.seeall)

local DragonKingTreasureMainViewPresentor = class("DragonKingTreasureMainViewPresentor", ViewPresentor)

function DragonKingTreasureMainViewPresentor:ctor()
	DragonKingTreasureMainViewPresentor.super.ctor(self)
end

function DragonKingTreasureMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonKingTreasureMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonkingtreasure/dragonkingtreasuremainview.prefab"
	}
end

function DragonKingTreasureMainViewPresentor:buildViews()
	return {
		DragonKingTreasureMainView.New()
	}
end

return DragonKingTreasureMainViewPresentor
