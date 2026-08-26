-- chunkname: @modules/logic/playercard/model/PlayerCardSkinMo.lua

module("modules.logic.playercard.model.PlayerCardSkinMo", package.seeall)

local PlayerCardSkinMo = class("PlayerCardSkinMo")

function PlayerCardSkinMo:ctor()
	self._config = nil
	self.id = nil
	self.icon = nil
	self._isEmpty = false
	self._isNew = false
end

function PlayerCardSkinMo:init(mo)
	self._mo = mo
	self.id = mo.id
	self._config = ItemConfig.instance:getItemCo(self.id)
	self.icon = self._config.icon
end

function PlayerCardSkinMo:getConfig()
	return self._config
end

function PlayerCardSkinMo:checkNew()
	return self._isNew
end

function PlayerCardSkinMo:clearNewState()
	self._isNew = false
end

function PlayerCardSkinMo:isEmpty()
	return self._isEmpty
end

function PlayerCardSkinMo:setEmpty()
	self._isEmpty = true
	self.id = 0
end

function PlayerCardSkinMo:isUnLock()
	if self._isEmpty then
		return true
	end

	return ItemModel.instance:getItemCount(self.id) > 0
end

function PlayerCardSkinMo:canBuyInStore()
	if not StoreConfig.instance:getDecorateGoodsIdById(self.id) then
		return false
	end

	return true
end

function PlayerCardSkinMo:isStoreDecorateGoodsValid()
	return StoreModel.instance:isStoreDecorateGoodsValid(self.id)
end

function PlayerCardSkinMo:getSources()
	return self._config.sources
end

function PlayerCardSkinMo:checkIsUse()
	local backgroundId = PlayerCardModel.instance:getPlayerCardSkinId()

	if backgroundId and backgroundId ~= 0 then
		return backgroundId == self.id
	elseif self._isEmpty then
		return true
	end

	return false
end

return PlayerCardSkinMo
