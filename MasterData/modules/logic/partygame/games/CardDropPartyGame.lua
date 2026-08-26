-- chunkname: @modules/logic/partygame/games/CardDropPartyGame.lua

module("modules.logic.partygame.games.CardDropPartyGame", package.seeall)

local CardDropPartyGame = class("CardDropPartyGame", PartyGameBase)

function CardDropPartyGame:enterGame()
	if CardDropGameController.EditMode then
		PartyGameCSDefine.CardDropInterfaceCs.SetStartRoundDuration()
	end

	CardDropPartyGame.super.enterGame(self)
end

function CardDropPartyGame:initCsGameBase(csGameBase)
	CardDropPartyGame.super.initCsGameBase(self, csGameBase)
	CardDropGameController.instance:init()
	CardDropTimelineController.instance:onGameStart()
end

function CardDropPartyGame:gameEndResult(data)
	CardDropEndFlowController.instance:startCardDropEndFlow(data)
	PartyGameStatHelper.instance:partyGameEnd()
end

function CardDropPartyGame:getGameViewName()
	if CardDropGameController.EditMode then
		return ViewName.CardDropEditGameView
	else
		return ViewName.CardDropGameView
	end
end

function CardDropPartyGame:onSceneClose()
	CardDropPartyGame.super.onSceneClose(self)

	if self:isGuiding() then
		ViewMgr.instance:closeView(ViewName.CardDropVSView)
		ViewMgr.instance:closeView(ViewName.CardDropPromotionView)
		ViewMgr.instance:closeView(ViewName.PartyGameResultView)
	end

	ViewMgr.instance:closeView(ViewName.CardDropCardTipView)
	ViewMgr.instance:closeView(ViewName.CardDropEditGameView)
	CardDropTimelineController.instance:onGameEnd()
	CardDropGameController.instance:clear()
	PartyGameCSDefine.CardDropInterfaceCs.Clear()
end

return CardDropPartyGame
