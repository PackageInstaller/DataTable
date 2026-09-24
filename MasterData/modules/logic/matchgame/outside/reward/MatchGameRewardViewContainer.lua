-- chunkname: @modules/logic/matchgame/outside/reward/MatchGameRewardViewContainer.lua

module("modules.logic.matchgame.outside.reward.MatchGameRewardViewContainer", package.seeall)

local MatchGameRewardViewContainer = class("MatchGameRewardViewContainer", BaseViewContainer)

function MatchGameRewardViewContainer:buildViews()
	return {
		MatchGameRewardView.New()
	}
end

return MatchGameRewardViewContainer
