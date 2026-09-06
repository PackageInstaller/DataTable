-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingtaskFullScreenViewPresentor.lua

module("logic.extensions.competitionking.view.CompetitionkingtaskFullScreenViewPresentor", package.seeall)

local CompetitionkingtaskFullScreenViewPresentor = class("CompetitionkingtaskFullScreenViewPresentor", CompetitionkingtaskViewPresentor)

function CompetitionkingtaskFullScreenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompetitionkingtaskFullScreenViewPresentor:buildViews()
	return {
		CompetitionkingtaskFullScreenView.New()
	}
end

return CompetitionkingtaskFullScreenViewPresentor
