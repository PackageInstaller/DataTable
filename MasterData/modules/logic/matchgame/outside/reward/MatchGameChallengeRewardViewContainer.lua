-- chunkname: @modules/logic/matchgame/outside/reward/MatchGameChallengeRewardViewContainer.lua

module("modules.logic.matchgame.outside.reward.MatchGameChallengeRewardViewContainer", package.seeall)

local MatchGameChallengeRewardViewContainer = class("MatchGameChallengeRewardViewContainer", BaseViewContainer)

function MatchGameChallengeRewardViewContainer:buildViews()
	return {
		MatchGameChallengeRewardView.New()
	}
end

return MatchGameChallengeRewardViewContainer
