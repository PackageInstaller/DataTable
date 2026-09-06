-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleBookPrizeViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleBookPrizeViewPresentor", package.seeall)

local FreeScuffleBookPrizeViewPresentor = class("FreeScuffleBookPrizeViewPresentor", ViewPresentor)

function FreeScuffleBookPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FreeScuffleBookPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescufflebookprizeview.prefab"
	}
end

function FreeScuffleBookPrizeViewPresentor:buildViews()
	return {
		FreeScuffleBookPrizeView.New()
	}
end

return FreeScuffleBookPrizeViewPresentor
