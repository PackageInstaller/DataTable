-- chunkname: @modules/logic/partygamelobby/view/PartyGameTrialSelectOneItem.lua

module("modules.logic.partygamelobby.view.PartyGameTrialSelectOneItem", package.seeall)

local PartyGameTrialSelectOneItem = class("PartyGameTrialSelectOneItem", PartyGameTrialGameItem)

function PartyGameTrialSelectOneItem:_btnclickareaOnClick()
	if self.gameId then
		PartyGameTrialPlayModel.instance:setOneTrialGameId(self.gameId)

		local maxPlayerCount = PartyGameLobbyModel.instance:getOneTrialMaxPlayerCount(self.gameId)

		PartyGameTrialController.instance:enterTrial(self.gameId, maxPlayerCount)
		ViewMgr.instance:closeView(ViewName.PartyGameLobbyTrialView)
		ViewMgr.instance:closeView(ViewName.LoginView)
		ViewMgr.instance:closeView(ViewName.SimulateLoginView)
	end
end

function PartyGameTrialSelectOneItem:UpdateGameInfo(gameCo)
	PartyGameTrialSelectOneItem.super.UpdateGameInfo(self, gameCo)
end

return PartyGameTrialSelectOneItem
