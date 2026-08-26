-- chunkname: @modules/logic/playercard/view/comp/PlayerCardAssit.lua

module("modules.logic.playercard.view.comp.PlayerCardAssit", package.seeall)

local PlayerCardAssit = class("PlayerCardAssit", BasePlayerCardComp)

function PlayerCardAssit:onInitView()
	return
end

function PlayerCardAssit:addEventListeners()
	self.addEventCb(self, PlayerController.instance, PlayerEvent.SetShowHero, self.onRefreshView, self)
end

function PlayerCardAssit:removeEventListeners()
	self.removeEventCb(self, PlayerController.instance, PlayerEvent.SetShowHero, self.onRefreshView, self)
end

function PlayerCardAssit:onRefreshView()
	local info = self:getPlayerInfo()

	self:_initPlayerShowCard(info.showHeros)
end

function PlayerCardAssit:_initPlayerShowCard(showHeros)
	for i = 1, 3 do
		local item = self:getOrCreateItem(i)

		item:setData(showHeros[i], self:isPlayerSelf(), self.compType)
	end
end

function PlayerCardAssit:getOrCreateItem(index)
	self.items = self.items or {}

	local item = self.items[index]

	if not item then
		local go = gohelper.findChild(self.viewGO, "layout/#go_assithero" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, PlayerCardAssitItem)
		self.items[index] = item
	end

	return item
end

function PlayerCardAssit:onDestroy()
	return
end

return PlayerCardAssit
