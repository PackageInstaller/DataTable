-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleMainViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleMainViewPresentor", package.seeall)

local FreeScuffleMainViewPresentor = class("FreeScuffleMainViewPresentor", ViewPresentor)

function FreeScuffleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FreeScuffleMainViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescufflemainview.prefab"
	}
end

function FreeScuffleMainViewPresentor:buildViews()
	return {
		FreeScuffleMainView.New()
	}
end

return FreeScuffleMainViewPresentor
