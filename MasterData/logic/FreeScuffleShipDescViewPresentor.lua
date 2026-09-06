-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleShipDescViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleShipDescViewPresentor", package.seeall)

local FreeScuffleShipDescViewPresentor = class("FreeScuffleShipDescViewPresentor", ViewPresentor)

function FreeScuffleShipDescViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FreeScuffleShipDescViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescuffleshipdescview.prefab"
	}
end

function FreeScuffleShipDescViewPresentor:buildViews()
	return {
		FreeScuffleShipDescView.New()
	}
end

return FreeScuffleShipDescViewPresentor
