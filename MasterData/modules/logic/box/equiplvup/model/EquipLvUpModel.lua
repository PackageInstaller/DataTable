-- chunkname: @modules/logic/box/equiplvup/model/EquipLvUpModel.lua

module("modules.logic.box.equiplvup.model.EquipLvUpModel", package.seeall)

local EquipLvUpModel = class("EquipLvUpModel", BaseModel)

function EquipLvUpModel:onInit()
	self._equipIdsItems = {}

	self:reInit()
end

function EquipLvUpModel:reInit()
	self._selectEquipUid = nil
end

function EquipLvUpModel:isCanOpenChooseView(item)
	local equips = EquipModel.instance:getEquips()

	if not equips or #equips == 0 then
		return false, ToastEnum.NoEquipLvUpTip
	end

	EquipLvUpChooseListModel.instance:setEquipList(item)

	local canLvUpList = EquipLvUpChooseListModel.instance:getCanLvUpList()
	local effectType = self:_getEffectTypeItem(item)

	if canLvUpList and #canLvUpList > 0 or effectType == EquipLvUpEnum.EffectType.All then
		return true
	end

	local maxLvList = EquipLvUpChooseListModel.instance:getMaxLvEquipList()

	if maxLvList and #maxLvList == 0 then
		return false, ToastEnum.NoEquipLvUpTip
	end
end

function EquipLvUpModel:onSelectEquip(equipUId)
	if self._selectEquipUid == equipUId then
		self._selectEquipUid = nil

		return
	end

	self._selectEquipUid = equipUId
end

function EquipLvUpModel:getSelectEquip()
	return self._selectEquipUid
end

function EquipLvUpModel:clearSelectEquip()
	self._selectEquipUid = nil
end

function EquipLvUpModel:getEuipIdsByItemId(itemId)
	local items = self._equipIdsItems[itemId]

	if not items then
		items = {}
		self._equipIdsItems[itemId] = items
		items.idList = {}
		items.bonus = {}

		local itemCo = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, itemId)

		if itemCo and not string.nilorempty(itemCo.effect) then
			local effect = GameUtil.splitString2(itemCo.effect, true)
			local effectType = effect[1][1]

			if effectType == EquipLvUpEnum.EffectType.All then
				self:_getAllEquips(items, effect)
			elseif effectType == EquipLvUpEnum.EffectType.Specify then
				self:_getSpecifyEquips(items, effect)
			end
		end
	end

	return items
end

function EquipLvUpModel:_getEffectTypeItem(itemId)
	local itemCo = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, itemId)

	if itemCo and not string.nilorempty(itemCo.effect) then
		local effect = GameUtil.splitString2(itemCo.effect, true)

		return effect[1][1]
	end

	return EquipLvUpEnum.EffectType.None
end

function EquipLvUpModel:_getAllEquips(tb, effect)
	if not effect then
		return
	end

	if effect[2] then
		if not effect[2][1] then
			local rare = 5

			for _, co in ipairs(lua_equip.configList) do
				if co.rare == rare and co.isExpEquip == 0 and co.isSpRefine == 0 then
					local id = co.id

					tb.idList[id] = {
						id = id
					}
				end
			end

			for i = 3, #effect do
				local _effect = effect[i]

				if #_effect > 1 then
					table.insert(tb.bonus, _effect)
				end
			end
		end
	end
end

function EquipLvUpModel:_getSpecifyEquips(tb, effect)
	if not effect then
		return
	end

	for i = 2, #effect do
		local _effect = effect[i]

		if #_effect > 1 then
			table.insert(tb.bonus, _effect)
		else
			local id = _effect[1]

			tb.idList[id] = {
				id = id
			}
		end
	end
end

function EquipLvUpModel:getCanUseItemId(equipId)
	local itemList = ItemModel.instance:getItemsBySubType(ItemEnum.SubType.EquipLvUp)

	if not itemList or #itemList == 0 then
		return
	end

	local list = {}

	for _, mo in ipairs(itemList) do
		local euipIds = self:getEuipIdsByItemId(mo.id)

		if euipIds and euipIds.idList and euipIds.idList[equipId] then
			table.insert(list, mo.id)
		end
	end

	if #list > 1 then
		for _, id in ipairs(list) do
			local effectType = self:_getEffectTypeItem(id)

			if effectType == EquipLvUpEnum.EffectType.Specify then
				return id
			end
		end
	end

	return list[1]
end

EquipLvUpModel.instance = EquipLvUpModel.New()

return EquipLvUpModel
