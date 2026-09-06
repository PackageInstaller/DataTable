-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/view/MMTeamPassportTeamHallViewPresentor.lua

module("logic.extensions.mmteampassport.view.MMTeamPassportTeamHallViewPresentor", package.seeall)

local MMTeamPassportTeamHallViewPresentor = class("MMTeamPassportTeamHallViewPresentor", ViewPresentor)

function MMTeamPassportTeamHallViewPresentor:ctor()
	MMTeamPassportTeamHallViewPresentor.super.ctor(self)
end

function MMTeamPassportTeamHallViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MMTeamPassportTeamHallViewPresentor:dependWhatResources()
	return {
		"ui/views/mmteampassport/mmteampassportteamhallview.prefab"
	}
end

function MMTeamPassportTeamHallViewPresentor:buildViews()
	return {
		MMTeamPassportTeamHallView.New()
	}
end

return MMTeamPassportTeamHallViewPresentor
