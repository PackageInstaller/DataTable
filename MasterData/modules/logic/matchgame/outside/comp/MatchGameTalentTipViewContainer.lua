-- chunkname: @modules/logic/matchgame/outside/comp/MatchGameTalentTipViewContainer.lua

module("modules.logic.matchgame.outside.comp.MatchGameTalentTipViewContainer", package.seeall)

local MatchGameTalentTipViewContainer = class("MatchGameTalentTipViewContainer", BaseViewContainer)

function MatchGameTalentTipViewContainer:buildViews()
	return {
		MatchGameTalentTipView.New()
	}
end

return MatchGameTalentTipViewContainer
