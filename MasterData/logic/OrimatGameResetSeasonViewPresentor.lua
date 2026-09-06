-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OrimatGameResetSeasonViewPresentor.lua

module("logic.extensions.orimatgame.view.OrimatGameResetSeasonViewPresentor", package.seeall)

local OrimatGameResetSeasonViewPresentor = class("OrimatGameResetSeasonViewPresentor", ViewPresentor)

function OrimatGameResetSeasonViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OrimatGameResetSeasonViewPresentor:dependWhatResources()
	return {
		"ui/views/orimatgame/orimatgameresetseasonview.prefab"
	}
end

function OrimatGameResetSeasonViewPresentor:buildViews()
	return {
		OrimatGameResetSeasonView.New()
	}
end

return OrimatGameResetSeasonViewPresentor
