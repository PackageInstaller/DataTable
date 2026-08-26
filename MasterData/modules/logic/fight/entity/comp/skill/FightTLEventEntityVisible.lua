-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventEntityVisible.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventEntityVisible", package.seeall)

local FightTLEventEntityVisible = class("FightTLEventEntityVisible", FightTimelineTrackItem)
local latestStepUid
local filterEffectType = {
	[FightEnum.EffectType.DAMAGEFROMABSORB] = true,
	[FightEnum.EffectType.STORAGEINJURY] = true,
	[FightEnum.EffectType.SHIELDVALUECHANGE] = true,
	[FightEnum.EffectType.SHAREHURT] = true
}

function FightTLEventEntityVisible:onTrackStart(fightStepData, duration, paramsArr)
	local tar_entity = FightHelper.getEntity(fightStepData.fromId)

	if tar_entity then
		::label_1_0::

		local var_1_0 = tar_entity.skill

		if tar_entity.skill then
			local is_same_skill_playing = tar_entity.skill:sameSkillPlaying()

			if is_same_skill_playing then
				-- block empty
			elseif latestStepUid and fightStepData.stepUid < latestStepUid then
				return
			end

			if not fightStepData.isFakeStep then
				latestStepUid = fightStepData.stepUid
				FightTLEventEntityVisible.latestStepUid = latestStepUid
			end

			local attackerVisibleType = tonumber(paramsArr[1]) or 1
			local defenderVisibleType = tonumber(paramsArr[2]) or 1
			local transitionTime = tonumber(paramsArr[3]) or 0.2
			local attacker = FightHelper.getEntity(fightStepData.fromId)
			local defenders = FightHelper.getDefenders(fightStepData, false, filterEffectType)
			local entityMgr = FightGameMgr.entityMgr
			local mySide = entityMgr:getTagList(SceneTag.UnitPlayer)
			local enemySide = entityMgr:getTagList(SceneTag.UnitMonster)
			local attackerSide = attacker:isMySide() and mySide or enemySide
			local defenderSide = attacker:isMySide() and enemySide or mySide
			local showEntitys, hideEntitys = self:_getVisibleList(attacker, defenders, attackerSide, attackerVisibleType, defenderSide, defenderVisibleType, fightStepData)

			if not string.nilorempty(paramsArr[5]) then
				local tar_entity = FightHelper.getEntity(fightStepData.stepUid .. "_" .. paramsArr[5])

				if tar_entity then
					table.insert(hideEntitys, tar_entity)
				end
			end

			if not string.nilorempty(paramsArr[6]) then
				local tar_entity = FightHelper.getEntity(fightStepData.stepUid .. "_" .. paramsArr[6])

				if tar_entity then
					table.insert(showEntitys, tar_entity)
				end
			end

			for _, entity in ipairs(showEntitys) do
				FightController.instance:dispatchEvent(FightEvent.SetEntityVisibleByTimeline, entity, fightStepData, true, transitionTime)
			end

			if paramsArr[4] == "1" and is_same_skill_playing then
				-- block empty
			else
				for _, entity in ipairs(hideEntitys) do
					local can_hide = true

					if can_hide then
						FightController.instance:dispatchEvent(FightEvent.SetEntityVisibleByTimeline, entity, fightStepData, false, transitionTime)
					end
				end
			end
		end
	end
end

function FightTLEventEntityVisible:_getVisibleList(attacker, defenders, attackerSide, attackerVisibleType, defenderSide, defenderVisibleType, fightStepData)
	local hideEntitys = {}
	local showEntitys = {}

	for _, entity in pairs(attackerSide) do
		local isHide

		if attackerVisibleType == 0 then
			isHide = true
		elseif attackerVisibleType == 1 then
			isHide = false
		elseif attackerVisibleType == 2 then
			isHide = attacker ~= entity
		elseif attackerVisibleType == 3 then
			isHide = attacker == entity
		elseif attackerVisibleType == 4 then
			isHide = attacker ~= entity and not tabletool.indexOf(defenders, entity)
		elseif attackerVisibleType == 5 then
			isHide = entity.id ~= fightStepData.toId
		end

		if isHide then
			table.insert(hideEntitys, entity)
		else
			table.insert(showEntitys, entity)
		end
	end

	for _, entity in pairs(defenderSide) do
		local isHide

		if defenderVisibleType == 0 then
			isHide = true
		elseif defenderVisibleType == 1 then
			isHide = false
		elseif defenderVisibleType == 2 then
			isHide = not tabletool.indexOf(defenders, entity)

			if isHide then
				local entity_mo = entity:getMO()

				if entity_mo then
					local skin_config = FightConfig.instance:getSkinCO(entity_mo.skin)

					if skin_config and skin_config.canHide == 1 then
						isHide = false
					end
				end
			end
		elseif defenderVisibleType == 3 then
			isHide = tabletool.indexOf(defenders, entity)
		elseif defenderVisibleType == 4 then
			isHide = entity.id ~= fightStepData.toId
		end

		if isHide then
			table.insert(hideEntitys, entity)
		else
			table.insert(showEntitys, entity)
		end
	end

	return showEntitys, hideEntitys
end

return FightTLEventEntityVisible
