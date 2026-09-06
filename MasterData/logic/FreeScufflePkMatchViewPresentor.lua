-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScufflePkMatchViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScufflePkMatchViewPresentor", package.seeall)

local FreeScufflePkMatchViewPresentor = class("FreeScufflePkMatchViewPresentor", ViewPresentor)

function FreeScufflePkMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FreeScufflePkMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescufflepkmatchview.prefab"
	}
end

function FreeScufflePkMatchViewPresentor:buildViews()
	return {
		FreeScufflePkMatchView.New()
	}
end

return FreeScufflePkMatchViewPresentor
