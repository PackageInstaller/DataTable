-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionFinalViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionFinalViewPresentor", package.seeall)

local GoddessCompetitionFinalViewPresentor = class("GoddessCompetitionFinalViewPresentor", ViewPresentor)

function GoddessCompetitionFinalViewPresentor:ctor()
	GoddessCompetitionFinalViewPresentor.super.ctor(self)
end

function GoddessCompetitionFinalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionFinalViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionfinalview.prefab"
	}
end

function GoddessCompetitionFinalViewPresentor:buildViews()
	return {
		GoddessCompetitionFinalView.New()
	}
end

return GoddessCompetitionFinalViewPresentor
