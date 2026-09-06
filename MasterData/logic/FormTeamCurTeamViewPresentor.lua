-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamCurTeamViewPresentor.lua

module("logic.extensions.formteam.view.FormTeamCurTeamViewPresentor", package.seeall)

local FormTeamCurTeamViewPresentor = class("FormTeamCurTeamViewPresentor", ViewPresentor)

function FormTeamCurTeamViewPresentor:ctor()
	FormTeamCurTeamViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PetManualViewPriority
end

function FormTeamCurTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormTeamCurTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/formteam/formteamcurteamview.prefab"
	}
end

function FormTeamCurTeamViewPresentor:buildViews()
	return {
		FormTeamCurTeamView.New()
	}
end

function FormTeamCurTeamViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FormTeamCurTeamViewPresentor
