-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/GoddessCompetitionHudViewPresentor.lua

module("logic.extensions.operationsummary.view.GoddessCompetitionHudViewPresentor", package.seeall)

local GoddessCompetitionHudViewPresentor = class("GoddessCompetitionHudViewPresentor", ViewPresentor)

function GoddessCompetitionHudViewPresentor:ctor()
	GoddessCompetitionHudViewPresentor.super.ctor(self)
end

function GoddessCompetitionHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionHudViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/goddesscompetitionhudview.prefab"
	}
end

function GoddessCompetitionHudViewPresentor:buildViews()
	return {
		GoddessCompetitionHudView.New()
	}
end

return GoddessCompetitionHudViewPresentor
