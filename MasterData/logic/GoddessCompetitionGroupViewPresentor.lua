-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionGroupViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionGroupViewPresentor", package.seeall)

local GoddessCompetitionGroupViewPresentor = class("GoddessCompetitionGroupViewPresentor", ViewPresentor)

function GoddessCompetitionGroupViewPresentor:ctor()
	GoddessCompetitionGroupViewPresentor.super.ctor(self)
end

function GoddessCompetitionGroupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionGroupViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitiongroupview.prefab"
	}
end

function GoddessCompetitionGroupViewPresentor:buildViews()
	return {
		GoddessCompetitionGroupView.New()
	}
end

function GoddessCompetitionGroupViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionGroupViewPresentor
