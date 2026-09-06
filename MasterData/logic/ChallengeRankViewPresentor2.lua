-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/view/ChallengeRankViewPresentor2.lua

module("logic.extensions.battlerecord.view.ChallengeRankViewPresentor2", package.seeall)

local ChallengeRankViewPresentor2 = class("ChallengeRankViewPresentor2", ViewPresentor)

function ChallengeRankViewPresentor2:attachToWhichRoot()
	return ViewRootType.Popup
end

function ChallengeRankViewPresentor2:dependWhatResources()
	return {
		"ui/views/battlerecord/challengeranksview2.prefab"
	}
end

function ChallengeRankViewPresentor2:buildViews()
	return {
		ChallengeRankView2.New()
	}
end

return ChallengeRankViewPresentor2
