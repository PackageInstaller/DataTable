-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventEntityRotate.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventEntityRotate", package.seeall)

local FightTLEventEntityRotate = class("FightTLEventEntityRotate", FightTimelineTrackItem)

function FightTLEventEntityRotate:onTrackStart(fightStepData, duration, paramsArr)
	self._attacker = FightHelper.getEntity(fightStepData.fromId)

	if not self._attacker then
		return
	end

	local rotateArr = string.splitToNumber(paramsArr[1], ",")
	local targetType = paramsArr[2]
	local isImmediate = paramsArr[3] == "1"
	local targetEntitys = {}

	if targetType == "1" then
		targetEntitys = {}

		table.insert(targetEntitys, FightHelper.getEntity(fightStepData.fromId))
	elseif targetType == "2" then
		targetEntitys = FightHelper.getSkillTargetEntitys(fightStepData)
	elseif targetType == "3" then
		targetEntitys = FightHelper.getSideEntitys(self._attacker:getSide(), true)
	elseif targetType == "4" then
		local defender = FightHelper.getEntity(fightStepData.toId)

		if defender then
			targetEntitys = FightHelper.getSideEntitys(defender:getSide(), true)
		end
	elseif targetType == "5" then
		targetEntitys = FightHelper.getSkillTargetEntitys(fightStepData)

		local attacker = FightHelper.getEntity(fightStepData.fromId)

		tabletool.removeValue(targetEntitys, attacker)
	end

	if not string.nilorempty(paramsArr[4]) then
		targetEntitys = targetEntitys or {}

		local arr = string.split(paramsArr[4], "#")

		for i, v in ipairs(arr) do
			local tar_entity = FightHelper.getEntity(fightStepData.stepUid .. "_" .. v)

			if tar_entity then
				table.insert(targetEntitys, tar_entity)
			end
		end
	end

	local rorateZ = rotateArr[3]

	if paramsArr[5] == "1" then
		rorateZ = self._attacker:isEnemySide() and -rotateArr[3] or rotateArr[3]
	end

	for _, entity in ipairs(targetEntitys) do
		if entity.spine then
			local spineTr = entity.spine:getSpineTr()

			if not gohelper.isNil(spineTr) then
				if isImmediate then
					transformhelper.setLocalRotation(spineTr, rotateArr[1], rotateArr[2], rorateZ)
				else
					self._tweenIdList = self._tweenIdList or {}

					local tweenId = ZProj.TweenHelper.DOLocalRotate(spineTr, rotateArr[1], rotateArr[2], rorateZ, duration)

					table.insert(self._tweenIdList, tweenId)
				end
			end
		end
	end
end

function FightTLEventEntityRotate:_clear()
	if self._tweenIdList then
		for _, tweenId in ipairs(self._tweenIdList) do
			ZProj.TweenHelper.KillById(tweenId)
		end

		self._tweenIdList = nil
	end
end

function FightTLEventEntityRotate:onDestructor()
	self:_clear()
end

return FightTLEventEntityRotate
