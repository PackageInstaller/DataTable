-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventAtkSpineLookDir.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventAtkSpineLookDir", package.seeall)

local FightTLEventAtkSpineLookDir = class("FightTLEventAtkSpineLookDir", FightTimelineTrackItem)

function FightTLEventAtkSpineLookDir:onTrackStart(fightStepData, duration, paramsArr)
	local selectEntityType = string.nilorempty(paramsArr[2]) and "1" or paramsArr[2]
	local revertDir = paramsArr[3] == "1"
	local entitys = self._getEntitys(fightStepData, selectEntityType)
	local attacker = FightHelper.getEntity(fightStepData.fromId)
	local atkLookDir = attacker.spine:getLookDir()

	for _, entity in ipairs(entitys) do
		if revertDir then
			local entityMO = entity:getMO()
			local lookDir = FightHelper.getEntitySpineLookDir(entityMO)

			if entity.spine then
				entity.spine:changeLookDir(lookDir)
			end
		else
			local oldLookDir = entity.spine:getLookDir()
			local newLookDir = oldLookDir

			if paramsArr[1] == "1" then
				newLookDir = 1
			elseif paramsArr[1] == "2" then
				newLookDir = -1
			elseif paramsArr[1] == "3" then
				newLookDir = atkLookDir
			elseif paramsArr[1] == "4" then
				newLookDir = -atkLookDir
			end

			if newLookDir ~= oldLookDir then
				entity.spine:changeLookDir(newLookDir)
			end
		end
	end
end

function FightTLEventAtkSpineLookDir._getEntitys(fightStepData, selectEntityType)
	local entitys = {}
	local attacker = FightHelper.getEntity(fightStepData.fromId)
	local defender = FightHelper.getEntity(fightStepData.toId)

	if selectEntityType == "1" then
		table.insert(entitys, attacker)
	elseif selectEntityType == "2" then
		local dict = {}

		for _, actEffectData in ipairs(fightStepData.actEffect) do
			local targetEntity = FightHelper.getEntity(actEffectData.targetId)

			if targetEntity and targetEntity:getSide() ~= attacker:getSide() and not dict[actEffectData.targetId] then
				table.insert(entitys, targetEntity)

				dict[actEffectData.targetId] = true
			end
		end
	elseif selectEntityType == "3" then
		entitys = FightHelper.getSideEntitys(attacker:getSide(), false)
	elseif selectEntityType == "4" then
		entitys = FightHelper.getSideEntitys(defender:getSide(), false)
	elseif selectEntityType == "5" then
		local my = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)
		local enemy = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)

		tabletool.addValues(entitys, my)
		tabletool.addValues(entitys, enemy)
	elseif selectEntityType == "6" then
		table.insert(entitys, defender)
	else
		local entityMgr = FightGameMgr.entityMgr
		local entityId = fightStepData.stepUid .. "_" .. selectEntityType

		table.insert(entitys, entityMgr:getEntity(entityId))
	end

	return entitys
end

return FightTLEventAtkSpineLookDir
