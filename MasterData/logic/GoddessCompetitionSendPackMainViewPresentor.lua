-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionSendPackMainViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionSendPackMainViewPresentor", package.seeall)

local GoddessCompetitionSendPackMainViewPresentor = class("GoddessCompetitionSendPackMainViewPresentor", ViewPresentor)

function GoddessCompetitionSendPackMainViewPresentor:ctor()
	GoddessCompetitionSendPackMainViewPresentor.super.ctor(self)
end

function GoddessCompetitionSendPackMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionSendPackMainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionsendpackmainview.prefab"
	}
end

function GoddessCompetitionSendPackMainViewPresentor:buildViews()
	return {
		GoddessCompetitionSendPackMainView.New()
	}
end

function GoddessCompetitionSendPackMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionSendPackMainViewPresentor
