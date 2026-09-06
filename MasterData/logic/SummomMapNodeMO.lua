-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/model/SummomMapNodeMO.lua

module("logic.extensions.summontower.model.SummomMapNodeMO", package.seeall)

local SummomMapNodeMO = class("SummomMapNodeMO")

SummomMapNodeMO.evtIconPath = {
	[SummonGridEvtType.Coin] = "ui/icon/items/icon_liumangxngyinbi.png",
	[SummonGridEvtType.Box] = "ui/icon/items/icon_xinxiya.png",
	[SummonGridEvtType.Shop] = "ui/icon/summontower/board_zhmy_11.png",
	[SummonGridEvtType.Door] = "ui/icon/summontower/board_zhmy_10.png"
}
SummomMapNodeMO.gridStatus = {
	RelivePet = 2,
	SwapPet = 3,
	Wish = 4,
	Fnish = 5,
	Init = 1
}

function SummomMapNodeMO:ctor()
	self.mapId = 0
	self.gridId = 0
	self.isUnlock = false
	self.girdStatus = SummomMapNodeMO.gridStatus.Init
	self.gridEventType = SummonGridEvtType.None
	self.gridEventId = 0
	self.shopEvent = nil
	self.guardEvent = nil
	self.extInfo = nil
	self.wishTrigger = false
	self.randomNum = 1000
end

function SummomMapNodeMO:showOnFinished()
	return self.gridEventType == SummonGridEvtType.Door or self.gridEventType == SummonGridEvtType.Shop
end

function SummomMapNodeMO:canShowNode()
	if not self.isUnlock then
		return false
	end

	if not self.isFinished then
		return true
	end

	return self:showOnFinished()
end

function SummomMapNodeMO:isGuardBoss()
	if self.gridEventType ~= SummonGridEvtType.Guard then
		return false
	end

	local evtCo = SummontowerConfig.instance:getGuardEventCo(self.gridEventId)

	return evtCo and evtCo.isBoss
end

function SummomMapNodeMO:needWarningBoss()
	if not self:isGuardBoss() then
		return false
	end

	return not self.isWarningBoss
end

function SummomMapNodeMO:getResPath()
	if self.gridEventType == SummonGridEvtType.Guard then
		local evtCo = SummontowerConfig.instance:getGuardEventCo(self.gridEventId)

		if evtCo.isBoss then
			return
		end

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(evtCo.faceId))

		return GameUrl.getCharacterIconUrl(modelCo.headName)
	end

	return SummomMapNodeMO.evtIconPath[self.gridEventType]
end

function SummomMapNodeMO:getShopItems()
	if self.gridEventType ~= SummonGridEvtType.Shop then
		return
	end

	local shopItems = SummontowerConfig.instance:getShopItemList(self.gridEventId)

	if not shopItems then
		return
	end

	local items = {}

	for i = 1, #shopItems do
		if self.shopEvent then
			for j = 1, #self.shopEvent.shopItemInfos do
				local randomValue = 0
				local buyTimes = 0

				if self.shopEvent.shopItemInfos[j].shopItemId == shopItems[i].shopItemId then
					if shopItems[i].itemType == SummonTowerItemsModel.ItemType.Pet then
						randomValue = self.shopEvent.shopItemInfos[j].randomValue
					end

					buyTimes = self.shopEvent.shopItemInfos[j].buyTimes

					if randomValue and buyTimes then
						local itemMO = SummomShopItemMO.New()

						itemMO.shopItemId = shopItems[i].shopItemId
						itemMO.shopId = self.gridEventId
						itemMO.buyTimes = buyTimes
						itemMO.randomValue = randomValue

						table.insert(items, itemMO)
					end

					break
				end
			end
		end
	end

	return items
end

return SummomMapNodeMO
