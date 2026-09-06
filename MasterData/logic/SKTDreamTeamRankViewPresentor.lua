-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/dream/SKTDreamTeamRankViewPresentor.lua

module("logic.extensions.saintknighttask.view.dream.SKTDreamTeamRankViewPresentor", package.seeall)

local SKTDreamTeamRankViewPresentor = class("SKTDreamTeamRankViewPresentor", ViewPresentor)

function SKTDreamTeamRankViewPresentor:ctor()
	SKTDreamTeamRankViewPresentor.super.ctor(self)
end

function SKTDreamTeamRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SKTDreamTeamRankViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttask/sktdreamteamrankview.prefab"
	}
end

function SKTDreamTeamRankViewPresentor:buildViews()
	return {
		SKTDreamTeamRankView.New()
	}
end

return SKTDreamTeamRankViewPresentor
