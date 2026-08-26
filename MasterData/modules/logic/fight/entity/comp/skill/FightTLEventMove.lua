-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventMove.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventMove", package.seeall)

local FightTLEventMove = class("FightTLEventMove", FightTimelineTrackItem)

function FightTLEventMove:onTrackStart(fightStepData, duration, paramsArr)
	duration = duration * FightModel.instance:getSpeed()
	self._paramsArr = paramsArr

	local selectEntityType = paramsArr[1]
	local targetType = tonumber(paramsArr[2]) or 0
	local height = tonumber(paramsArr[3]) or 0
	local offsetList = GameUtil.splitString2(paramsArr[4], true, "#", ",")
	local easeType = paramsArr[5]
	local isImmediate = paramsArr[6] == "1"

	if isImmediate then
		duration = 0
	end

	local moveEntitys = FightTLEventMove._getMoveEntitys(fightStepData, selectEntityType)

	if #moveEntitys > 0 then
		local combinative = false

		if selectEntityType == "2" or selectEntityType == "4" then
			for i, entity in ipairs(moveEntitys) do
				local entity_mo = entity:getMO()

				if entity_mo then
					local skin_config = FightConfig.instance:getSkinCO(entity_mo.skin)

					if skin_config and skin_config.canHide == 1 then
						combinative = true
					end

					if lua_fight_assembled_monster.configDict[entity_mo.skin] then
						combinative = true
					end
				end
			end
		end

		if combinative then
			self._combinative_entitys = {}
			self._combinative_pos_offsets = {}

			for i, v in ipairs(FightHelper.getSideEntitys(moveEntitys[1]:getSide())) do
				local entity_mo = v:getMO()

				if entity_mo then
					local skin_config = FightConfig.instance:getSkinCO(entity_mo.skin)

					if skin_config and skin_config.mainBody == 1 then
						self._follow_entity = v
					else
						table.insert(self._combinative_entitys, v)
					end
				end
			end

			if not self._follow_entity then
				self._follow_entity = FightHelper.getEntity(fightStepData.toId)

				tabletool.removeValue(self._combinative_entitys, self._follow_entity)
			end

			if self._follow_entity then
				local endX, endY, endZ = FightHelper.getEntityStandPos(self._follow_entity:getMO())
				local follow_entity_pos = Vector3.New(endX, endY, endZ)

				for i, v in ipairs(self._combinative_entitys) do
					endX, endY, endZ = FightHelper.getEntityStandPos(v:getMO())

					local temp_pos = Vector3.New(endX, endY, endZ)

					table.insert(self._combinative_pos_offsets, temp_pos - follow_entity_pos)
				end

				moveEntitys = {
					self._follow_entity
				}

				TaskDispatcher.runRepeat(self._setCombinativeEntitysPos, self, 0.0001)
			end
		end
	end

	if #moveEntitys > 1 then
		table.sort(moveEntitys, function(entity1, entity2)
			if entity1:getSide() ~= entity2:getSide() then
				return entity1:isMySide()
			end

			local entityMO1 = entity1:getMO()
			local entityMO2 = entity2:getMO()

			if entityMO1 and entityMO2 and entityMO1.position ~= entityMO2.position then
				return entityMO1.position < entityMO2.position
			end

			return tonumber(entity1.id) > tonumber(entity2.id)
		end)
	end

	local forceEndPos

	if not string.nilorempty(self._paramsArr[8]) and #moveEntitys == 1 then
		local entity = moveEntitys[1]
		local arr = FightStrUtil.instance:getSplitCache(self._paramsArr[8], "|")

		if #arr > 1 then
			local hasSkin = false

			for i = 2, #arr do
				local skinArr = FightStrUtil.instance:getSplitCache(arr[i], "_")
				local entityMO = entity:getMO()

				if entityMO and entityMO.skin == tonumber(skinArr[1]) then
					forceEndPos = FightStrUtil.instance:getSplitToNumberCache(skinArr[2], ",")
					hasSkin = true

					break
				end
			end

			if not hasSkin then
				forceEndPos = FightStrUtil.instance:getSplitToNumberCache(arr[1], ",")
			end
		else
			forceEndPos = FightStrUtil.instance:getSplitToNumberCache(self._paramsArr[8], ",")
		end
	end

	for i, entity in ipairs(moveEntitys) do
		if not gohelper.isNil(entity.go) then
			local startX, startY, startZ = transformhelper.getPos(entity.go.transform)
			local endX, endY, endZ = self:_getEndPosXYZ(fightStepData, entity, offsetList, selectEntityType, targetType, i)

			if forceEndPos then
				endX = forceEndPos[1] and (entity:isMySide() and forceEndPos[1] or -forceEndPos[1]) or 0
				endY = forceEndPos[2] or 0
				endZ = forceEndPos[3] or 0
			end

			FightTLEventMove._setupEntityMove(entity, startX, startY, startZ, endX, endY, endZ, duration, height, easeType)
		end
	end
end

function FightTLEventMove:_getEndPosXYZ(fightStepData, entity, offsetList, selectEntityType, targetType, indexInList)
	local attacker = FightHelper.getEntity(fightStepData.fromId)
	local defender = FightHelper.getEntity(fightStepData.toId)
	local offset = offsetList[1]

	if selectEntityType == "3" or selectEntityType == "4" then
		offset = offsetList[entity:getMO().position]
	elseif selectEntityType == "2" then
		offset = offsetList[indexInList]
	end

	if offset then
		if not offset[1] then
			local offsetX = 0

			if offset then
				if not offset[2] then
					local offsetY = 0

					if offset then
						if not offset[3] then
							local offsetZ = 0
							local endX, endY, endZ = 0, 0, 0

							if targetType == 3 then
								local entityMO = entity:getMO()

								if entityMO then
									endX, endY, endZ = FightHelper.getEntityStandPos(entityMO)
								else
									endZ = 0
									endY = 0
									endX = 0
								end
							elseif targetType == 1 or targetType == 2 then
								local targetEntity = targetType == 1 and attacker or defender

								if targetEntity then
									endX, endY, endZ = FightHelper.getProcessEntityStancePos(targetEntity:getMO())
									endX = targetEntity:isMySide() and endX - offsetX or endX + offsetX
									endY = endY + offsetY
									endZ = endZ + offsetZ
								else
									logNormal("targetEntity not exist: " .. ((targetType == 1 or nil) and (fightStepData.fromId or fightStepData.toId)))
								end
							elseif targetType == 0 then
								endX = tonumber(selectEntityType) and entity:isMySide() and endX - offsetX or endX + offsetX
								endY = offsetY
								endZ = offsetZ
							elseif targetType == 4 then
								endX = offsetX
								endY = offsetY
								endZ = offsetZ
							elseif targetType == 5 then
								local offset
								local arr = FightStrUtil.instance:getSplitCache(self._paramsArr[7], "|")

								if #arr > 1 then
									local hasSkin = false

									for i = 2, #arr do
										local skinArr = FightStrUtil.instance:getSplitCache(arr[i], "_")
										local entityMO = entity:getMO()

										if entityMO and entityMO.skin == tonumber(skinArr[1]) then
											offset = FightStrUtil.instance:getSplitToNumberCache(skinArr[2], ",")
											hasSkin = true

											break
										end
									end

									if not hasSkin then
										offset = FightStrUtil.instance:getSplitToNumberCache(arr[1], ",")
									end
								else
									offset = FightStrUtil.instance:getSplitToNumberCache(self._paramsArr[7], ",")
								end

								local startX, startY, startZ = transformhelper.getPos(entity.go.transform)
								local side = entity:isMySide()

								if offset[1] then
									local var_3_4

									if side then
										var_3_4 = offset[1] or -offset[1] or 0
									end
								end

								endX = startX + var_3_4
								endY = startY + (offset[2] or 0)
								endZ = startZ + (offset[3] or 0)
							elseif targetType == 6 then
								if attacker:isMySide() then
									if not FightEnum.EntitySide.EnemySide then
										local side = FightEnum.EntitySide.MySide
										local entityList = {}

										for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
											if entity:getSide() == side and entity:getTag() ~= SceneTag.UnitNpc then
												local isSub = FightDataHelper.entityMgr:isSub(entity.id)

												if not isSub then
													table.insert(entityList, entity)
												end
											end
										end

										table.sort(entityList, FightTLEventAtkFullEffect.sortByEntityX)

										local listCount = #entityList

										if listCount > 0 then
											local pos1x, pos1y, pos1z = transformhelper.getLocalPos(entityList[1].go.transform)
											local pos2x, pos2y, pos2z = transformhelper.getLocalPos(entityList[#entityList].go.transform)

											endX = (pos1x + pos2x) / 2
											endY = (pos1y + pos2y) / 2
											endZ = (pos1z + pos2z) / 2
										else
											endX = 0
											endY = 0
											endZ = 0
										end

										endX = attacker:isMySide() and endX + offsetX or endX - offsetX
										endY = endY + offsetY
										endZ = endZ + offsetZ
									end
								end
							end

							return endX, endY, endZ
						end
					end
				end
			end
		end
	end
end

function FightTLEventMove._getMoveEntitys(fightStepData, selectEntityType)
	local entitys = {}
	local attacker = FightHelper.getEntity(fightStepData.fromId)
	local defender = FightHelper.getEntity(fightStepData.toId)

	if selectEntityType == "1" then
		table.insert(entitys, attacker)
	elseif selectEntityType == "2" then
		local dict = {}

		for _, actEffectData in ipairs(fightStepData.actEffect) do
			local targetEntity = FightHelper.getEntity(actEffectData.targetId)

			if not targetEntity and actEffectData.effectType ~= FightEnum.EffectType.INDICATORCHANGE then
				-- block empty
			end

			if not ((targetEntity and (targetEntity.id == FightEntityScene.MySideId or targetEntity.id == FightEntityScene.EnemySideId) or nil) and true) and targetEntity and targetEntity:getSide() ~= attacker:getSide() and not dict[actEffectData.targetId] then
				table.insert(entitys, targetEntity)

				dict[actEffectData.targetId] = true
			end
		end
	elseif selectEntityType == "3" then
		entitys = FightHelper.getSideEntitys(attacker:getSide(), false)
	elseif selectEntityType == "4" then
		if defender then
			entitys = FightHelper.getSideEntitys(defender:getSide(), false)
		end
	elseif selectEntityType == "5" then
		local my = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)
		local enemy = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)

		tabletool.addValues(entitys, my)
		tabletool.addValues(entitys, enemy)
	elseif selectEntityType == "6" then
		if defender then
			table.insert(entitys, defender)
		end
	else
		local entityMgr = FightGameMgr.entityMgr
		local entityId = fightStepData.stepUid .. "_" .. selectEntityType

		table.insert(entitys, entityMgr:getEntity(entityId))
	end

	return entitys
end

function FightTLEventMove._setupEntityMove(entity, startX, startY, startZ, endX, endY, endZ, duration, height, easeType)
	if not entity.moveComp then
		return
	end

	if height > 0 then
		entity.moveComp.parabolaMover:simpleMove(startX, startY, startZ, endX, endY, endZ, duration, height)
	else
		if easeType and entity.moveComp.mover.setEaseType then
			entity.moveComp.mover:setEaseType(EaseType.Str2Type(easeType))
		end

		entity.moveComp.mover:simpleMove(startX, startY, startZ, endX, endY, endZ, duration)
	end
end

function FightTLEventMove:_setCombinativeEntitysPos()
	if self._combinative_entitys then
		local tar_scale

		for i, entity in ipairs(self._combinative_entitys) do
			local tar_entity = FightHelper.getEntity(entity.id)

			if tar_entity then
				if not gohelper.isNil(tar_entity.go) and not gohelper.isNil(self._follow_entity.go) then
					tar_entity.go.transform.position = self._follow_entity.go.transform.position + self._combinative_pos_offsets[i] * tar_entity:getScale()
				end
			end
		end
	end
end

function FightTLEventMove:onTrackEnd()
	TaskDispatcher.cancelTask(self._setCombinativeEntitysPos, self)
end

function FightTLEventMove:reset()
	self._combinative_entitys = nil
end

return FightTLEventMove
