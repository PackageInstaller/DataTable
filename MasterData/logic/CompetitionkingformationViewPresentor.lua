-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingformationViewPresentor.lua

module("logic.extensions.competitionking.view.CompetitionkingformationViewPresentor", package.seeall)

local CompetitionkingformationViewPresentor = class("CompetitionkingformationViewPresentor", ViewPresentor)

function CompetitionkingformationViewPresentor:ctor()
	CompetitionkingformationViewPresentor.super.ctor(self)
end

function CompetitionkingformationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompetitionkingformationViewPresentor:dependWhatResources()
	return {
		"ui/views/competitionking/competitionkingformationview.prefab"
	}
end

function CompetitionkingformationViewPresentor:buildViews()
	return {
		CompetitionkingformationView.New()
	}
end

return CompetitionkingformationViewPresentor
