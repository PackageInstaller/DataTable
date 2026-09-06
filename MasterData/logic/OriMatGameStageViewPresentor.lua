-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameStageViewPresentor.lua

module("logic.extensions.orimatgame.view.OriMatGameStageViewPresentor", package.seeall)

local OriMatGameStageViewPresentor = class("OriMatGameStageViewPresentor", ViewPresentor)

function OriMatGameStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriMatGameStageViewPresentor:dependWhatResources()
	return {
		"ui/views/orimatgame/orimatgamestageview.prefab"
	}
end

function OriMatGameStageViewPresentor:buildViews()
	return {
		OriMatGameStageView.New()
	}
end

return OriMatGameStageViewPresentor
