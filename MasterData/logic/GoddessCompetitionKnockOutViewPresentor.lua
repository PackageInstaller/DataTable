-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionKnockOutViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionKnockOutViewPresentor", package.seeall)

local GoddessCompetitionKnockOutViewPresentor = class("GoddessCompetitionKnockOutViewPresentor", ViewPresentor)

function GoddessCompetitionKnockOutViewPresentor:ctor()
	GoddessCompetitionKnockOutViewPresentor.super.ctor(self)
end

function GoddessCompetitionKnockOutViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionKnockOutViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionknockoutview.prefab"
	}
end

function GoddessCompetitionKnockOutViewPresentor:buildViews()
	return {
		GoddessCompetitionKnockOutView.New()
	}
end

function GoddessCompetitionKnockOutViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionKnockOutViewPresentor
