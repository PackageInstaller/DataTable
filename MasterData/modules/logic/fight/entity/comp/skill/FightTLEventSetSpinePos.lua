-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventSetSpinePos.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventSetSpinePos", package.seeall)

local FightTLEventSetSpinePos = class("FightTLEventSetSpinePos", FightTimelineTrackItem)

function FightTLEventSetSpinePos:onTrackStart(fightStepData, duration, paramsArr)
	local targetType = paramsArr[1]
	local targetEntitys = {}

	if targetType == "1" then
		targetEntitys = {}

		table.insert(targetEntitys, FightHelper.getEntity(fightStepData.fromId))
	elseif targetType == "2" then
		targetEntitys = FightHelper.getSkillTargetEntitys(fightStepData)
	elseif targetType == "3" then
		local from_entity = FightHelper.getEntity(fightStepData.fromId)

		targetEntitys = FightHelper.getAllSideEntitys(from_entity:getSide())
	elseif targetType == "4" then
		local entityData = FightDataHelper.entityMgr:getById(fightStepData.toId)

		targetEntitys = entityData and FightHelper.getAllSideEntitys(entityData.side) or {}
	elseif targetType == "5" then
		local from_entity = FightHelper.getEntity(fightStepData.fromId)

		targetEntitys = FightHelper.getAllSideEntitys(from_entity:getSide())

		for i, v in ipairs(targetEntitys) do
			if v.id == fightStepData.fromId then
				table.remove(targetEntitys, i)

				break
			end
		end
	elseif targetType == "6" then
		local from_entity = FightHelper.getEntity(fightStepData.toId)

		if from_entity then
			targetEntitys = FightHelper.getAllSideEntitys(from_entity:getSide())

			for i, v in ipairs(targetEntitys) do
				if v.id == fightStepData.toId then
					table.remove(targetEntitys, i)

					if FightHelper.isAssembledMonster(v) then
						for index = #targetEntitys, 1, -1 do
							if FightHelper.isAssembledMonster(targetEntitys[index]) then
								table.remove(targetEntitys, index)
							end
						end
					end

					break
				end
			end
		end
	elseif targetType == "7" then
		for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
			local entityData = FightDataHelper.entityMgr:getById(entity.id)

			if entityData then
				local config3D = lua_fight_monster_3d.configDict[entityData.skin]

				if config3D then
					table.insert(targetEntitys, entity)
				end
			end
		end
	end

	if not string.nilorempty(paramsArr[4]) then
		local deadEntityMgr = self:com_sendMsg(FightMsgId.GetDeadEntityMgr)

		targetEntitys = {}

		local arr = string.splitToNumber(paramsArr[4], "#")

		for k, v in pairs(deadEntityMgr.entityDic) do
			local entityMO = v:getMO()

			if entityMO and tabletool.indexOf(arr, entityMO.skin) then
				table.insert(targetEntitys, v)
			end
		end
	end

	local pos = string.splitToNumber(paramsArr[2], "#")
	local revert = paramsArr[3] == "1"

	if #targetEntitys > 0 then
		for _, entity in ipairs(targetEntitys) do
			local spine = entity.spine
			local transform = spine and spine:getSpineTr()

			if transform then
				if revert then
					transformhelper.setLocalPos(transform, 0, 0, 0)
					FightController.instance:dispatchEvent(FightEvent.SetSpinePosByTimeline, entity.id, 0, 0, 0)
				else
					transformhelper.setLocalPos(transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)
					FightController.instance:dispatchEvent(FightEvent.SetSpinePosByTimeline, entity.id, pos[1] or 0, pos[2] or 0, pos[3] or 0)
				end
			end
		end
	end
end

function FightTLEventSetSpinePos:onTrackEnd()
	return
end

return FightTLEventSetSpinePos
