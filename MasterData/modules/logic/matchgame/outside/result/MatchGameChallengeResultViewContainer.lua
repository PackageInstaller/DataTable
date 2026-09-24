-- chunkname: @modules/logic/matchgame/outside/result/MatchGameChallengeResultViewContainer.lua

module("modules.logic.matchgame.outside.result.MatchGameChallengeResultViewContainer", package.seeall)

local MatchGameChallengeResultViewContainer = class("MatchGameChallengeResultViewContainer", BaseViewContainer)

function MatchGameChallengeResultViewContainer:buildViews()
	return {
		MatchGameChallengeResultView.New()
	}
end

return MatchGameChallengeResultViewContainer
