-- chunkname: @modules/logic/partygamelobby/view/PartyGameTrialSelectMultipleItem.lua

module("modules.logic.partygamelobby.view.PartyGameTrialSelectMultipleItem", package.seeall)

local PartyGameTrialSelectMultipleItem = class("PartyGameTrialSelectMultipleItem", PartyGameTrialGameItem)

function PartyGameTrialSelectMultipleItem:_btnclickareaOnClick()
	if self.gameId then
		PartyGameTrialPlayModel.instance:updateSelectTrialGameIdByPlayerCount(self.gameId, self.playerCount)
		PartyGameTrialController.instance:dispatchEvent(PartyGameLobbyEvent.TrialSelect)
	end
end

function PartyGameTrialSelectMultipleItem:setPlayerCount(playerCount)
	self.playerCount = playerCount
end

function PartyGameTrialSelectMultipleItem:updateItem()
	if self.gameId == nil then
		return
	end

	local index = PartyGameTrialPlayModel.instance:getSelectTrialGameIndex(self.gameId)

	self._txtnum.text = index or ""

	gohelper.setActive(self._goselect, index ~= nil)
end

return PartyGameTrialSelectMultipleItem
