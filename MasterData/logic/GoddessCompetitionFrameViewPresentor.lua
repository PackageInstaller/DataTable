-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionFrameViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionFrameViewPresentor", package.seeall)

local GoddessCompetitionFrameViewPresentor = class("GoddessCompetitionFrameViewPresentor", ViewPresentor)

function GoddessCompetitionFrameViewPresentor:ctor()
	GoddessCompetitionFrameViewPresentor.super.ctor(self)
end

function GoddessCompetitionFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionframeview.prefab"
	}
end

function GoddessCompetitionFrameViewPresentor:buildViews()
	return {
		GoddessCompetitionFrameView.New()
	}
end

function GoddessCompetitionFrameViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionFrameViewPresentor
