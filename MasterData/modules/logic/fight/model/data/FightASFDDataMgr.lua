-- chunkname: @modules/logic/fight/model/data/FightASFDDataMgr.lua

module("modules.logic.fight.model.data.FightASFDDataMgr", package.seeall)

local FightASFDDataMgr = FightDataClass("FightASFDDataMgr", FightDataMgrBase)

function FightASFDDataMgr:onConstructor()
	return
end

function FightASFDDataMgr:updateData(fightData)
	if fightData.attacker.emitterInfo then
		self.attackerEmitterInfo = FightASFDEmitterInfoMO.New()

		self.attackerEmitterInfo:init(fightData.attacker.emitterInfo)
	end

	if fightData.defender.emitterInfo then
		self.defenderEmitterInfo = FightASFDEmitterInfoMO.New()

		self.defenderEmitterInfo:init(fightData.defender.emitterInfo)
	end

	self.mySideEnergy = fightData.attacker.energy or 0
	self.enemySideEnergy = fightData.defender.energy or 0
end

function FightASFDDataMgr:getEmitterInfo(side)
	if side == FightEnum.EntitySide.MySide then
		return self.attackerEmitterInfo
	end

	if side == FightEnum.EntitySide.EnemySide then
		return self.defenderEmitterInfo
	end
end

function FightASFDDataMgr:getMySideEmitterInfo()
	return self.attackerEmitterInfo
end

function FightASFDDataMgr:getEnemySideEmitterInfo()
	return self.defenderEmitterInfo
end

function FightASFDDataMgr:changeEnergy(side, offset)
	if side == FightEnum.EntitySide.MySide then
		self.mySideEnergy = self.mySideEnergy or 0
		self.mySideEnergy = self.mySideEnergy + offset

		return
	end

	if side == FightEnum.EntitySide.EnemySide then
		self.enemySideEnergy = self.enemySideEnergy or 0
		self.enemySideEnergy = self.enemySideEnergy + offset

		return
	end
end

function FightASFDDataMgr:getEnergy(side)
	if side == FightEnum.EntitySide.MySide then
		return self.mySideEnergy
	else
		return self.enemySideEnergy
	end
end

function FightASFDDataMgr:getEmitterEnergy(side)
	if side == FightEnum.EntitySide.MySide then
		return (self.attackerEmitterInfo or nil) and (self.attackerEmitterInfo.energy or 0)
	else
		return (self.defenderEmitterInfo or nil) and (self.defenderEmitterInfo.energy or 0)
	end
end

function FightASFDDataMgr:changeEmitterEnergy(side, offset)
	if side == FightEnum.EntitySide.MySide then
		if self.attackerEmitterInfo then
			self.attackerEmitterInfo:changeEnergy(offset)
		end

		return
	end

	if side == FightEnum.EntitySide.EnemySide then
		if self.defenderEmitterInfo then
			self.defenderEmitterInfo:changeEnergy(offset)
		end

		return
	end
end

function FightASFDDataMgr:setEmitterInfo(side, info)
	if side == FightEnum.EntitySide.MySide then
		self.attackerEmitterInfo = info

		return
	end

	if side == FightEnum.EntitySide.EnemySide then
		self.defenderEmitterInfo = info

		return
	end
end

FightASFDDataMgr.EmitterId = "99998"

function FightASFDDataMgr:setEmitterEntityMo(entityMo)
	self.emitterMo = entityMo
end

function FightASFDDataMgr:getEmitterEmitterMo()
	return self.emitterMo
end

function FightASFDDataMgr:addEntityResidualData(entityId, data)
	self.alfResidualDataDict = self.alfResidualDataDict or {}

	local list = self.alfResidualDataDict[entityId]

	if not list then
		list = {}
		self.alfResidualDataDict[entityId] = list
	end

	table.insert(list, data)
end

function FightASFDDataMgr:popEntityResidualData(entityId)
	if not self.alfResidualDataDict then
		return
	end

	local list = self.alfResidualDataDict[entityId]

	if not list then
		return
	end

	return table.remove(list, 1)
end

function FightASFDDataMgr:checkCanAddALFResidual(entityId)
	self:initALFResidualCountDict()

	if not self.alfResidualCountDict[entityId] then
		local count = 0

		return count < FightASFDConfig.instance.alfMaxShowEffectCount
	end
end

function FightASFDDataMgr:addALFResidual(entityId, count)
	if count < 1 then
		return
	end

	self:initALFResidualCountDict()

	count = (self.alfResidualCountDict[entityId] or 0) + count
	count = math.min(FightASFDConfig.instance.alfMaxShowEffectCount, count)
	self.alfResidualCountDict[entityId] = count
end

function FightASFDDataMgr:removeALFResidual(entityId, count)
	if count < 1 then
		return
	end

	self:initALFResidualCountDict()

	count = (self.alfResidualCountDict[entityId] or 0) - count
	count = math.max(0, count)
	self.alfResidualCountDict[entityId] = count
end

function FightASFDDataMgr:initALFResidualCountDict()
	self.alfResidualCountDict = self.alfResidualCountDict or {}
end

return FightASFDDataMgr
