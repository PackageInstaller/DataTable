-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/dream/SKTDreamTeamViewPresentor.lua

module("logic.extensions.saintknighttask.view.dream.SKTDreamTeamViewPresentor", package.seeall)

local SKTDreamTeamViewPresentor = class("SKTDreamTeamViewPresentor", ViewPresentor)

function SKTDreamTeamViewPresentor:ctor()
	SKTDreamTeamViewPresentor.super.ctor(self)
end

function SKTDreamTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SKTDreamTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttask/sktdreamteamview.prefab"
	}
end

function SKTDreamTeamViewPresentor:buildViews()
	return {
		SKTDreamTeamView.New()
	}
end

function SKTDreamTeamViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SKTDreamTeamViewPresentor
