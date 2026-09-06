-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/OriginDreamTeamTabShowViewPresentor.lua

module("logic.extensions.groupregress.view.OriginDreamTeamTabShowViewPresentor", package.seeall)

local OriginDreamTeamTabShowViewPresentor = class("OriginDreamTeamTabShowViewPresentor", ViewPresentor)

function OriginDreamTeamTabShowViewPresentor:ctor()
	OriginDreamTeamTabShowViewPresentor.super.ctor(self)
end

function OriginDreamTeamTabShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDreamTeamTabShowViewPresentor:dependWhatResources()
	return {
		"ui/views/groupregress/origindreamteamtabshowview.prefab"
	}
end

function OriginDreamTeamTabShowViewPresentor:buildViews()
	return {
		OriginDreamTeamTabShowView.New()
	}
end

return OriginDreamTeamTabShowViewPresentor
