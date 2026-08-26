-- chunkname: @modules/logic/equip/model/EquipMO.lua

module("modules.logic.equip.model.EquipMO", package.seeall)

local EquipMO = pureTable("EquipMO")

function EquipMO:init(info)
	self.id = tonumber(info.uid)
	self.config = EquipConfig.instance:getEquipCo(info.equipId)
	self._canBreak = nil
	self.equipId = info.equipId
	self.uid = info.uid
	self.level = info.level
	self.exp = info.exp
	self.breakLv = info.breakLv
	self.count = info.count
	self.isLock = info.isLock
	self.refineLv = info.refineLv
	self.equipType = EquipEnum.ClientEquipType.Normal

	self:clearRecommend()
end

function EquipMO:getBreakLvByLevel(level)
	local breakLv = math.huge

	if self.config then
		for lv, config in pairs(lua_equip_break_cost.configDict[self.config.rare]) do
			if lv < breakLv and level <= config.level then
				breakLv = lv
			end
		end
	else
		breakLv = 0
	end

	return breakLv
end

function EquipMO:setBreakLvByLevel(level)
	self.breakLv = self:getBreakLvByLevel(level or self.level)
end

function EquipMO:initByConfig(uid, equipId, equipLv, equipRefine)
	uid = uid or "-9999999999"
	self.id = tonumber(uid)
	self.uid = uid
	self.equipId = equipId
	self.level = equipLv
	self.refineLv = math.max(1, equipRefine)
	self.config = EquipConfig.instance:getEquipCo(equipId)
	self.exp = 0

	local breakLv = math.huge

	if self.config then
		for lv, config in pairs(lua_equip_break_cost.configDict[self.config.rare]) do
			if lv < breakLv and config.level >= self.level then
				breakLv = lv
			end
		end
	else
		breakLv = 1

		logError("试用角色心相不存在   >>>  " .. tostring(self.equipId))
	end

	self.breakLv = breakLv
	self.count = 1
	self.isLock = true
	self.equipType = EquipEnum.ClientEquipType.Config
end

function EquipMO:initByTrialCO(trialCO)
	self:initByConfig(tostring(-trialCO.equipId - 1099511627776), trialCO.equipId, trialCO.equipLv, trialCO.equipRefine)

	self.equipType = EquipEnum.ClientEquipType.TrialHero
end

function EquipMO:initByTrialEquipCO(trialCO)
	self:initByConfig(tostring(-trialCO.id), trialCO.equipId, trialCO.equipLv, trialCO.equipRefine)

	self.equipType = EquipEnum.ClientEquipType.TrialEquip
end

function EquipMO:initOtherPlayerEquip(info)
	self:init(info)

	self.equipType = EquipEnum.ClientEquipType.OtherPlayer
end

function EquipMO:clone(id)
	local mo = EquipMO.New()

	mo:init(self)

	mo.count = 1
	mo.id = id

	return mo
end

function EquipMO:setRecommedIndex(index)
	self.recommondIndex = index
end

function EquipMO:clearRecommend()
	self.recommondIndex = -1
end

return EquipMO
