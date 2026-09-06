-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingrankFullScreenViewPresentor.lua

module("logic.extensions.competitionking.view.CompetitionkingrankFullScreenViewPresentor", package.seeall)

local CompetitionkingrankFullScreenViewPresentor = class("CompetitionkingrankFullScreenViewPresentor", CompetitionkingrankViewPresentor)

function CompetitionkingrankFullScreenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompetitionkingrankFullScreenViewPresentor:buildViews()
	return {
		CompetitionkingrankFullScreenView.New()
	}
end

return CompetitionkingrankFullScreenViewPresentor
