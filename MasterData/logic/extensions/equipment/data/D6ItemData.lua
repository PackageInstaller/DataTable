-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/data/D6ItemData.lua

module("logic.extensions.equipment.data.D6ItemData", package.seeall)

local M = class("D6ItemData", ItemData)
local json = require("cjson")
local iconPrefix = "25010"

function M:ctor(params)
	M.super.ctor(self, params)

	self._attrs = {}
	self._equipUuid = nil
	self._isDiscard = params.discard
	self._decomposedItemId = false
	self._decomposedItemCount = false

	if not string.nilorempty(params.extJson) then
		local DiceInfoNO = json.decode(params.extJson)
		local attrs = DiceInfoNO.attrs

		self:refreshAttrs(attrs)
	end
end

function M:refreshAttrs(attrs)
	table.clear(self._attrs)

	for _, DiceAttrNO in ipairs(attrs) do
		table.insert(self._attrs, DiceAttrMO.New(DiceAttrNO))
	end
end

function M:addOneAttr(DiceAttrNO)
	table.insert(self._attrs, DiceAttrMO.New(DiceAttrNO))
end

function M:addFackAttr(type)
	for i = #self._attrs + 1, EquipEnum.MaxAttrCount do
		table.insert(self._attrs, DiceAttrMO.New({
			diceAttrId = 1,
			level = 0,
			fackAttrType = type
		}))
	end
end

function M:getAttrs()
	return self._attrs
end

function M:getDecomposedItem()
	if not self._decomposedItemId then
		local qa = self:getQuality()
		local decomposeInfo = EquipmentConfig.instance:getD6EDecomposeInfo(qa)
		local info = string.gmatch(decomposeInfo.decomposedItem, "(%d+):(%d+)")

		for id, count in info do
			self._decomposedItemId = id
			self._decomposedItemCount = tonumber(count)
		end
	end

	return self._decomposedItemId, self._decomposedItemCount
end

function M:getDecomposedCanGetExp()
	if not self._canGetExp then
		local decomposedItemId, decomposedItemCount = self:getDecomposedItem()

		self._canGetExp = EquipmentConfig.instance:getItemAddEquipExp(decomposedItemId) * decomposedItemCount
	end

	return self._canGetExp
end

function M:setEquipUuid(equipUuid)
	self._equipUuid = equipUuid
end

function M:getEquipUuid()
	return self._equipUuid
end

function M:setIsDiscard(isDiscard)
	self._isDiscard = isDiscard
end

function M:getIsDiscard()
	return self._isDiscard
end

function M:getQuality()
	if self._tempQulity then
		return self._tempQulity
	end

	if self._itemInfo and self._itemInfo.quality and self._itemInfo.quality > 0 then
		return self._itemInfo.quality
	end

	local maxLevel = self:getMaxAttrLevel()
	local dataList = EquipmentConfig.instance:getConfigList(ConfigName.D6Lv2Quality)

	maxLevel = math.min(dataList[#dataList].level, maxLevel)

	local cfg = EquipmentConfig.instance:getConfigByKey(ConfigName.D6Lv2Quality, maxLevel)

	return cfg.quality
end

function M:setTempQuality(qa)
	self._tempQulity = qa
end

function M:getPart()
	return self._itemInfo.part
end

function M:getMaxAttrLevel()
	local maxLevel = 1

	for _, diceAttrMo in ipairs(self._attrs) do
		if maxLevel < diceAttrMo:getLevel() then
			maxLevel = diceAttrMo:getLevel()
		end
	end

	return maxLevel
end

function M:getIcon()
	local part = self:getPart()
	local quality = self:getQuality()
	local qualityIcon = EquipEnum.EquipD6Quality2IconNum[quality]

	return iconPrefix .. part .. qualityIcon
end

return M
