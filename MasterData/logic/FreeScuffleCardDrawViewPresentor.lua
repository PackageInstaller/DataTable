-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleCardDrawViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleCardDrawViewPresentor", package.seeall)

local FreeScuffleCardDrawViewPresentor = class("FreeScuffleCardDrawViewPresentor", ViewPresentor)

function FreeScuffleCardDrawViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FreeScuffleCardDrawViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescufflecarddrawview.prefab"
	}
end

function FreeScuffleCardDrawViewPresentor:buildViews()
	return {
		FreeScuffleCardDrawView.New()
	}
end

return FreeScuffleCardDrawViewPresentor
