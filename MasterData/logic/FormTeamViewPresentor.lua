-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamViewPresentor.lua

module("logic.extensions.formteam.view.FormTeamViewPresentor", package.seeall)

local FormTeamViewPresentor = class("FormTeamViewPresentor", ViewPresentor)

function FormTeamViewPresentor:ctor()
	FormTeamViewPresentor.super.ctor(self)
end

function FormTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/formteam/formteamview.prefab"
	}
end

function FormTeamViewPresentor:buildViews()
	return {
		FormTeamView.New()
	}
end

function FormTeamViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FormTeamViewPresentor
