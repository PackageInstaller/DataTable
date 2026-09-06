-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleBookViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleBookViewPresentor", package.seeall)

local FreeScuffleBookViewPresentor = class("FreeScuffleBookViewPresentor", ViewPresentor)

function FreeScuffleBookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FreeScuffleBookViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescufflebookview.prefab"
	}
end

function FreeScuffleBookViewPresentor:buildViews()
	return {
		FreeScuffleBookView.New()
	}
end

return FreeScuffleBookViewPresentor
