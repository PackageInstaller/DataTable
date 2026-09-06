-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonPrizeViewPresentor.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonPrizeViewPresentor", package.seeall)

local DarkKingDragonPrizeViewPresentor = class("DarkKingDragonPrizeViewPresentor", ViewPresentor)

function DarkKingDragonPrizeViewPresentor:ctor()
	DarkKingDragonPrizeViewPresentor.super.ctor(self)
end

function DarkKingDragonPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarkKingDragonPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedarkkingdragonclg/darkkingdragonprizeview.prefab"
	}
end

function DarkKingDragonPrizeViewPresentor:buildViews()
	return {
		DarkKingDragonPrizeView.New()
	}
end

return DarkKingDragonPrizeViewPresentor
