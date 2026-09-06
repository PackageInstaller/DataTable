-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutePetTravelTeamSelectViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetTravelTeamSelectViewPresentor", package.seeall)

local CutePetTravelTeamSelectViewPresentor = class("CutePetTravelTeamSelectViewPresentor", ViewPresentor)

function CutePetTravelTeamSelectViewPresentor:ctor()
	CutePetTravelTeamSelectViewPresentor.super.ctor(self)
end

function CutePetTravelTeamSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetTravelTeamSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepettravelteamselectview.prefab"
	}
end

function CutePetTravelTeamSelectViewPresentor:buildViews()
	return {
		CutePetTravelTeamSelectView.New()
	}
end

return CutePetTravelTeamSelectViewPresentor
