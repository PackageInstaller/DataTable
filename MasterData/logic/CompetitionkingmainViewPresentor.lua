-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingmainViewPresentor.lua

module("logic.extensions.competitionking.view.CompetitionkingmainViewPresentor", package.seeall)

local CompetitionkingmainViewPresentor = class("CompetitionkingmainViewPresentor", ViewPresentor)

function CompetitionkingmainViewPresentor:ctor()
	CompetitionkingmainViewPresentor.super.ctor(self)
end

function CompetitionkingmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompetitionkingmainViewPresentor:dependWhatResources()
	return {
		"ui/views/competitionking/competitionkingmainview.prefab"
	}
end

function CompetitionkingmainViewPresentor:buildViews()
	return {
		CompetitionkingmainView.New()
	}
end

return CompetitionkingmainViewPresentor
