-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingrankViewPresentor.lua

module("logic.extensions.competitionking.view.CompetitionkingrankViewPresentor", package.seeall)

local CompetitionkingrankViewPresentor = class("CompetitionkingrankViewPresentor", ViewPresentor)

function CompetitionkingrankViewPresentor:ctor()
	CompetitionkingrankViewPresentor.super.ctor(self)
end

function CompetitionkingrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompetitionkingrankViewPresentor:dependWhatResources()
	return {
		"ui/views/competitionking/competitionkingrankview.prefab"
	}
end

function CompetitionkingrankViewPresentor:buildViews()
	return {
		CompetitionkingrankView.New()
	}
end

return CompetitionkingrankViewPresentor
