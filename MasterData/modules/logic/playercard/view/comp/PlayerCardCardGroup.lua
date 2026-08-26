-- chunkname: @modules/logic/playercard/view/comp/PlayerCardCardGroup.lua

module("modules.logic.playercard.view.comp.PlayerCardCardGroup", package.seeall)

local PlayerCardCardGroup = class("PlayerCardCardGroup", BasePlayerCardComp)

function PlayerCardCardGroup:onInitView()
	self.items = {}

	for i = 1, 4 do
		self.items[i] = self:createItem(i)
	end
end

function PlayerCardCardGroup:createItem(index)
	local parentGO = gohelper.findChild(self.viewGO, "#go_card")
	local go = gohelper.clone(self.itemRes, parentGO, tostring(index))

	return (MonoHelper.addNoUpdateLuaComOnceToGo(go, PlayerCardCardItem, {
		index = index,
		compType = self.compType
	}))
end

function PlayerCardCardGroup:addEventListeners()
	return
end

function PlayerCardCardGroup:removeEventListeners()
	return
end

function PlayerCardCardGroup:onRefreshView()
	local data = self.cardInfo:getCardData()

	for i, v in ipairs(self.items) do
		local config = PlayerCardConfig.instance:getCardConfig(data[i])

		v:refreshView(self.cardInfo, config)
	end

	local isVisible = not self:isSingle()

	self.items[3]:setVisible(isVisible)
	self.items[4]:setVisible(isVisible)
end

function PlayerCardCardGroup:isSingle()
	if not self.cardInfo then
		return
	end

	local data = self.cardInfo:getCardData()

	return data and #data < 3
end

function PlayerCardCardGroup:onDestroy()
	return
end

return PlayerCardCardGroup
