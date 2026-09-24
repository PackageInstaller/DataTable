-- chunkname: @modules/logic/matchgame/outside/comp/MatchGameItemTipViewContainer.lua

module("modules.logic.matchgame.outside.comp.MatchGameItemTipViewContainer", package.seeall)

local MatchGameItemTipViewContainer = class("MatchGameItemTipViewContainer", BaseViewContainer)

function MatchGameItemTipViewContainer:buildViews()
	return {
		MatchGameItemTipView.New()
	}
end

return MatchGameItemTipViewContainer
