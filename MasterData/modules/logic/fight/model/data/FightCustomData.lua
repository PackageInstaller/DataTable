-- chunkname: @modules/logic/fight/model/data/FightCustomData.lua

module("modules.logic.fight.model.data.FightCustomData", package.seeall)

local FightCustomData = FightDataClass("FightCustomData")

FightCustomData.CustomDataType = {
	Act183 = 1,
	WeekwalkVer2 = 2,
	Act191 = 3,
	ShowTaoFuBen = 9,
	Survival = 4,
	Act229 = 10,
	Rouge2 = 7,
	Odyssey = 5,
	TowerCompose = 8,
	Act128Sp = 6
}

local data2Json = {
	[FightCustomData.CustomDataType.Act183] = true,
	[FightCustomData.CustomDataType.Act191] = true,
	[FightCustomData.CustomDataType.Survival] = true,
	[FightCustomData.CustomDataType.Odyssey] = true,
	[FightCustomData.CustomDataType.Act128Sp] = true,
	[FightCustomData.CustomDataType.Rouge2] = true,
	[FightCustomData.CustomDataType.TowerCompose] = true,
	[FightCustomData.CustomDataType.ShowTaoFuBen] = true,
	[FightCustomData.CustomDataType.Act229] = true
}

function FightCustomData:onConstructor(proto)
	for i, v in ipairs(proto) do
		self[v.type] = data2Json[v.type] and cjson.decode(v.data) or v.data
	end

	self:updateRouge2Data()
end

function FightCustomData:getRouge2BuffId2RelicDict()
	return self.buffId2RelicDict
end

function FightCustomData:updateRouge2Data()
	local data = self[FightCustomData.CustomDataType.Rouge2]
	local str = data and data.buffId2CheckRelicMap

	if string.nilorempty(str) then
		self.buffId2RelicDict = nil
	else
		self.buffId2RelicDict = cjson.decode(str)
	end

	local valueDict = data and data.attrFinalVal

	if not valueDict then
		self.rouge2AttrParamDict = nil
	else
		self.rouge2AttrParamDict = self.rouge2AttrParamDict or {}

		tabletool.clear(self.rouge2AttrParamDict)

		for attrId, value in pairs(valueDict) do
			attrId = tonumber(attrId)

			local co = lua_rouge2_relics_attr.configDict[attrId]
			local attrName = co and co.flag

			if not string.nilorempty(attrName) then
				self.rouge2AttrParamDict[attrName] = value
			end
		end
	end
end

function FightCustomData:getRougeAttrValue(attrId)
	if not attrId then
		return 0
	end

	local data = self[FightCustomData.CustomDataType.Rouge2]
	local valueDict = data and data.attrFinalVal

	if not valueDict then
		return 0
	end

	return valueDict[attrId]
end

function FightCustomData:getRouge2AttrParam()
	return self.rouge2AttrParamDict
end

function FightCustomData:testFunc()
	logError(tostring(self))
end

return FightCustomData
