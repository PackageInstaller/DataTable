-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleCardShowViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleCardShowViewPresentor", package.seeall)

local FreeScuffleCardShowViewPresentor = class("FreeScuffleCardShowViewPresentor", ViewPresentor)

function FreeScuffleCardShowViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FreeScuffleCardShowViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescufflecardshowview.prefab"
	}
end

function FreeScuffleCardShowViewPresentor:buildViews()
	return {
		FreeScuffleCardShowView.New()
	}
end

return FreeScuffleCardShowViewPresentor
