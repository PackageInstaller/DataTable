-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleCardResultViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleCardResultViewPresentor", package.seeall)

local FreeScuffleCardResultViewPresentor = class("FreeScuffleCardResultViewPresentor", ViewPresentor)

function FreeScuffleCardResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FreeScuffleCardResultViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescufflecardresultview.prefab"
	}
end

function FreeScuffleCardResultViewPresentor:buildViews()
	return {
		FreeScuffleCardResultView.New()
	}
end

return FreeScuffleCardResultViewPresentor
