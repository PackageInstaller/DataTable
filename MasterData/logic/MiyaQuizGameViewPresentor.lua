-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaQuizGameViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaQuizGameViewPresentor", package.seeall)

local MiyaQuizGameViewPresentor = class("MiyaQuizGameViewPresentor", ViewPresentor)

function MiyaQuizGameViewPresentor:ctor()
	MiyaQuizGameViewPresentor.super.ctor(self)
end

function MiyaQuizGameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiyaQuizGameViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miyaquizgameview.prefab"
	}
end

function MiyaQuizGameViewPresentor:buildViews()
	return {
		MiyaQuizGameView.New()
	}
end

return MiyaQuizGameViewPresentor
