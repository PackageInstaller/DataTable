-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/dragonpsychicclg/DragonPsychicClgNorTaskChildViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.dragonpsychicclg.EternalChallengeTaskChildViewPresentor", package.seeall)

local EternalChallengeTaskChildViewPresentor = class("EternalChallengeTaskChildViewPresentor", ViewPresentor)

function EternalChallengeTaskChildViewPresentor:ctor()
	EternalChallengeTaskChildViewPresentor.super.ctor(self)
end

function EternalChallengeTaskChildViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EternalChallengeTaskChildViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/dragonpsychicclg/dragonpsychicclgnortaskchildview.prefab"
	}
end

function EternalChallengeTaskChildViewPresentor:buildViews()
	return {
		DragonPsychicClgNorTaskChildView.New()
	}
end

function EternalChallengeTaskChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return EternalChallengeTaskChildViewPresentor
