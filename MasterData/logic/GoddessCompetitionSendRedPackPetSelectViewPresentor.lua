-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionSendRedPackPetSelectViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionSendRedPackPetSelectViewPresentor", package.seeall)

local GoddessCompetitionSendRedPackPetSelectViewPresentor = class("GoddessCompetitionSendRedPackPetSelectViewPresentor", ViewPresentor)

function GoddessCompetitionSendRedPackPetSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessCompetitionSendRedPackPetSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionsendredpackpetselectview.prefab"
	}
end

function GoddessCompetitionSendRedPackPetSelectViewPresentor:buildViews()
	return {
		GoddessCompetitionSendRedPackPetSelectView.New()
	}
end

return GoddessCompetitionSendRedPackPetSelectViewPresentor
