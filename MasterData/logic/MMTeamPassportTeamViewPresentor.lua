-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/view/MMTeamPassportTeamViewPresentor.lua

module("logic.extensions.mmteampassport.view.MMTeamPassportTeamViewPresentor", package.seeall)

local MMTeamPassportTeamViewPresentor = class("MMTeamPassportTeamViewPresentor", ViewPresentor)

function MMTeamPassportTeamViewPresentor:ctor()
	MMTeamPassportTeamViewPresentor.super.ctor(self)
end

function MMTeamPassportTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MMTeamPassportTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/mmteampassport/mmteampassportteamview.prefab"
	}
end

function MMTeamPassportTeamViewPresentor:buildViews()
	return {
		MMTeamPassportTeamView.New()
	}
end

function MMTeamPassportTeamViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MMTeamPassportTeamViewPresentor
