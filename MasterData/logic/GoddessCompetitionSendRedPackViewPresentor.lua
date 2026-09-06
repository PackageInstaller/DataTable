-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionSendRedPackViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionSendRedPackViewPresentor", package.seeall)

local GoddessCompetitionSendRedPackViewPresentor = class("GoddessCompetitionSendRedPackViewPresentor", ViewPresentor)

function GoddessCompetitionSendRedPackViewPresentor:ctor()
	GoddessCompetitionSendRedPackViewPresentor.super.ctor(self)
end

function GoddessCompetitionSendRedPackViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessCompetitionSendRedPackViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionsendredpackview.prefab"
	}
end

function GoddessCompetitionSendRedPackViewPresentor:buildViews()
	return {
		GoddessCompetitionSendRedPackView.New()
	}
end

return GoddessCompetitionSendRedPackViewPresentor
