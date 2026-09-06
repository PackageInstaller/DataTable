-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleCardPoolViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleCardPoolViewPresentor", package.seeall)

local FreeScuffleCardPoolViewPresentor = class("FreeScuffleCardPoolViewPresentor", ViewPresentor)

function FreeScuffleCardPoolViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FreeScuffleCardPoolViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescufflecardpoolview.prefab"
	}
end

function FreeScuffleCardPoolViewPresentor:buildViews()
	return {
		FreeScuffleCardPoolView.New()
	}
end

return FreeScuffleCardPoolViewPresentor
