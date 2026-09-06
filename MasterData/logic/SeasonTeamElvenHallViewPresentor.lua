-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/teamcampshow/SeasonTeamElvenHallViewPresentor.lua

module("logic.extensions.season.view.teamcampshow.SeasonTeamElvenHallViewPresentor", package.seeall)

local SeasonTeamElvenHallViewPresentor = class("SeasonTeamElvenHallViewPresentor", ViewPresentor)

function SeasonTeamElvenHallViewPresentor:ctor()
	SeasonTeamElvenHallViewPresentor.super.ctor(self)
end

function SeasonTeamElvenHallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonTeamElvenHallViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonelvenhallview.prefab"
	}
end

function SeasonTeamElvenHallViewPresentor:buildViews()
	return {
		SeasonTeamElvenHallView.New()
	}
end

return SeasonTeamElvenHallViewPresentor
