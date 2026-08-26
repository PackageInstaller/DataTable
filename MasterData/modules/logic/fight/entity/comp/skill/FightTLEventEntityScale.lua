-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventEntityScale.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventEntityScale", package.seeall)

local FightTLEventEntityScale = class("FightTLEventEntityScale", FightTimelineTrackItem)

function FightTLEventEntityScale:onTrackStart(fightStepData, duration, paramsArr)
	self._paramsArr = paramsArr
	self._targetScale = tonumber(paramsArr[1])
	self._revertScale = paramsArr[5] == "1"

	local targetType = paramsArr[2]
	local isImmediate = paramsArr[3] == "1"
	local targetEntitys

	if targetType == "1" then
		targetEntitys = {}

		table.insert(targetEntitys, FightHelper.getEntity(fightStepData.fromId))
	elseif targetType == "2" then
		targetEntitys = FightHelper.getSkillTargetEntitys(fightStepData)
	elseif targetType == "3" then
		local from_entity = FightHelper.getEntity(fightStepData.fromId)

		targetEntitys = FightHelper.getSideEntitys(from_entity:getSide(), true)
	elseif targetType == "4" then
		local def_entity = FightHelper.getEntity(fightStepData.toId)

		targetEntitys = def_entity and FightHelper.getSideEntitys(def_entity:getSide(), true) or {}
	end

	if not string.nilorempty(paramsArr[4]) then
		local tar_entity = FightHelper.getEntity(fightStepData.stepUid .. "_" .. paramsArr[4])

		targetEntitys = {}

		if tar_entity then
			table.insert(targetEntitys, tar_entity)
		end
	end

	if isImmediate then
		for _, entity in ipairs(targetEntitys) do
			local targetScale = self:_getScale(entity)

			entity:setScale(targetScale)
			FightHelper.refreshCombinativeMonsterScaleAndPos(entity, targetScale)
		end
	elseif #targetEntitys > 0 then
		self._tweenList = {}

		for _, entity in ipairs(targetEntitys) do
			if not gohelper.isNil(entity.go) then
				local var_1_0 = entity:getScale() or 1
			end
		end
	end

	local standardHeight = tonumber(paramsArr[7])

	if standardHeight and targetEntitys then
		for i, entity in ipairs(targetEntitys) do
			if entity then
				::label_1_0::

				local var_1_1 = entity.spine

				if entity.spine then
					local spineObj = entity.spine:getSpineGO()

					if spineObj then
						local is3DBoss = false
						local entityData = FightDataHelper.entityMgr:getById(entity.id)

						if entityData then
							is3DBoss = lua_fight_monster_3d.configDict[entityData.skin]
						end

						if is3DBoss then
							local tarScale = standardHeight / is3DBoss.sizeForScale[2]

							if tarScale < 1 then
								transformhelper.setLocalScale(spineObj.transform, tarScale, tarScale, tarScale)
							end
						else
							local mesh = spineObj:GetComponent(typeof(UnityEngine.MeshFilter))

							mesh = mesh and mesh.mesh

							if mesh then
								local bounds = mesh.bounds
								local tarScale = standardHeight / bounds.size.y

								if tarScale < 1 then
									transformhelper.setLocalScale(spineObj.transform, tarScale, tarScale, tarScale)
								end
							end
						end
					end
				end
			end
		end
	end

	if not string.nilorempty(paramsArr[8]) and targetEntitys then
		for i, entity in ipairs(targetEntitys) do
			if entity then
				::label_1_1::

				local var_1_2 = entity.spine

				if entity.spine then
					local spineObj = entity.spine:getSpineGO()

					if spineObj then
						transformhelper.setLocalScale(spineObj.transform, 1, 1, 1)
					end
				end
			end
		end
	end
end

function FightTLEventEntityScale:_getScale(entity)
	local entityMO = entity and entity:getMO()

	if self._revertScale and entityMO then
		local _, _, _, scale = FightHelper.getEntityStandPos(entityMO)

		return scale
	end

	if entityMO and not string.nilorempty(self._paramsArr[6]) then
		local arr = FightStrUtil.instance:getSplitCache(self._paramsArr[6], "|")

		for i, v in ipairs(arr) do
			local skinArr = FightStrUtil.instance:getSplitToNumberCache(v, "_")

			if entityMO.skin == skinArr[1] then
				return skinArr[2]
			end
		end
	end

	return self._targetScale
end

function FightTLEventEntityScale:onTrackEnd()
	self:_clear()
end

function FightTLEventEntityScale:onDestructor()
	self:_clear()
end

function FightTLEventEntityScale:_clear()
	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			ZProj.TweenHelper.KillById(v)
		end

		self._tweenList = nil
	end
end

return FightTLEventEntityScale
