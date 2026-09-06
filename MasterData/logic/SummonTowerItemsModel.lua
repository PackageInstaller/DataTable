-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/model/SummonTowerItemsModel.lua

module("logic.extensions.summer.model.SummonTowerItemsModel", package.seeall)

local SummonTowerItemsModel = class("SummonTowerItemsModel", BaseModel)

SummonTowerItemsModel.ItemType = {
	Pet = 3,
	GamePlan = 5,
	SpeechBook = 6,
	ReviveStone = 2,
	Coin = 1,
	DragonBall = 4,
	Level = 7,
	Exp = 8
}

function SummonTowerItemsModel:onInit()
	self:onReset()
end

function SummonTowerItemsModel:onReset()
	self._items = nil
end

function SummonTowerItemsModel:setItems(items)
	self._items = {}

	if items then
		for i = 1, #items do
			self._items[items[i].type] = items[i]

			local itemCo = SummontowerConfig.instance:getGameItemCo(items[i].type)

			MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, itemCo.itemId, items[i].num, false)
		end
	end
end

function SummonTowerItemsModel:gainedItems(items)
	if items then
		local changeMos

		self._items = self._items or {}

		for i = 1, #items do
			local currNum = 0

			if self._items[items[i].type] then
				currNum = self._items[items[i].type].num
			end

			local itemCo = SummontowerConfig.instance:getGameItemCo(items[i].type)

			if checknumber(itemCo.itemId) > 0 then
				if currNum < items[i].num then
					changeMos = changeMos or {}

					local itemMo = MaterialMo.New()

					itemMo:initData(MatType.Item_Fake, itemCo.itemId, items[i].num - currNum)
					table.insert(changeMos, {
						itemType = items[i].type,
						itemMo = itemMo
					})
				end

				MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, itemCo.itemId, items[i].num, false)
			end

			self._items[items[i].type] = items[i]
		end

		return changeMos
	end
end

function SummonTowerItemsModel:getItemsNum(itemType)
	if not self._items or not self._items[itemType] then
		return 0
	end

	return self._items[itemType].num or 0
end

function SummonTowerItemsModel:getItemsBuyTimes(itemType)
	if not self._items or not self._items[itemType] then
		return 0
	end

	return self._items[itemType].accBuyTimes or 0
end

function SummonTowerItemsModel:addItemsBuyTimes(itemType)
	self._items = self._items or {}
	self._items[itemType] = self._items[itemType] or {}
	self._items[itemType].accBuyTimes = self._items[itemType].accBuyTimes or 0
	self._items[itemType].accBuyTimes = self._items[itemType].accBuyTimes + 1
end

function SummonTowerItemsModel:getDragonBallsNum()
	return self:getItemsNum(SummonTowerItemsModel.ItemType.DragonBall)
end

function SummonTowerItemsModel:setPlayerExp(exp)
	self._items = self._items or {}
	self._items[SummonTowerItemsModel.ItemType.Exp] = {
		accBuyTimes = 0,
		type = SummonTowerItemsModel.ItemType.Exp,
		num = exp
	}
end

function SummonTowerItemsModel:getPlayerExp()
	return self:getItemsNum(SummonTowerItemsModel.ItemType.Exp)
end

SummonTowerItemsModel.instance = SummonTowerItemsModel.New()

return SummonTowerItemsModel
