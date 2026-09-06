-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingtaskViewPresentor.lua

module("logic.extensions.competitionking.view.CompetitionkingtaskViewPresentor", package.seeall)

local CompetitionkingtaskViewPresentor = class("CompetitionkingtaskViewPresentor", ViewPresentor)

function CompetitionkingtaskViewPresentor:ctor()
	CompetitionkingtaskViewPresentor.super.ctor(self)
end

function CompetitionkingtaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompetitionkingtaskViewPresentor:dependWhatResources()
	return {
		"ui/views/competitionking/competitionkingtaskview.prefab"
	}
end

function CompetitionkingtaskViewPresentor:buildViews()
	return {
		CompetitionkingtaskView.New()
	}
end

return CompetitionkingtaskViewPresentor
