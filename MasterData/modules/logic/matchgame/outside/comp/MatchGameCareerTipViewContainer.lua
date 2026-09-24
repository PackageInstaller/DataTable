-- chunkname: @modules/logic/matchgame/outside/comp/MatchGameCareerTipViewContainer.lua

module("modules.logic.matchgame.outside.comp.MatchGameCareerTipViewContainer", package.seeall)

local MatchGameCareerTipViewContainer = class("MatchGameCareerTipViewContainer", BaseViewContainer)

function MatchGameCareerTipViewContainer:buildViews()
	return {
		MatchGameCareerTipView.New()
	}
end

return MatchGameCareerTipViewContainer
