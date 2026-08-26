-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventSpineMaterial.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventSpineMaterial", package.seeall)

local FightTLEventSpineMaterial = class("FightTLEventSpineMaterial", FightTimelineTrackItem)

function FightTLEventSpineMaterial:onTrackStart(fightStepData, duration, paramsArr)
	local targetType = paramsArr[1]

	self._matName = paramsArr[2]
	self._transitName = paramsArr[3]
	self._transitType = paramsArr[4]

	local transitValue = paramsArr[5]
	local transitTime = tonumber(paramsArr[6])

	self._targetEntitys = nil

	if targetType == "1" then
		self._targetEntitys = {}

		table.insert(self._targetEntitys, FightHelper.getEntity(fightStepData.fromId))
	elseif targetType == "2" then
		self._targetEntitys = FightHelper.getSkillTargetEntitys(fightStepData)
	elseif not string.nilorempty(targetType) then
		local entityMgr = FightGameMgr.entityMgr
		local entityId = fightStepData.stepUid .. "_" .. targetType
		local tempEntity = entityMgr:getEntity(entityId)

		if tempEntity then
			self._targetEntitys = {}

			table.insert(self._targetEntitys, tempEntity)
		else
			logError("找不到实体, id: " .. tostring(targetType))

			return
		end
	end

	local newMat = not string.nilorempty(self._matName) and FightSpineMatPool.getMat(self._matName)
	local needChangeProp = not string.nilorempty(self._transitName)
	local targetValue = MaterialUtil.getPropValueFromStr(self._transitType, transitValue)

	for _, entity in ipairs(self._targetEntitys) do
		if newMat then
			entity.spineRenderer:replaceSpineMat(newMat)
			FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, entity.id, entity.spineRenderer:getReplaceMat())
		end
	end

	if transitTime > 0 then
		local matDict = {}
		local originValueDict = {}
		local valueDict = {}

		for _, entity in ipairs(self._targetEntitys) do
			local spineMat = entity.spineRenderer:getReplaceMat()

			originValueDict[entity.id] = MaterialUtil.getPropValueFromMat(spineMat, self._transitName, self._transitType)
			matDict[entity.id] = spineMat
		end

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, transitTime, function(value)
			for _, entity in ipairs(self._targetEntitys) do
				local originValue = originValueDict[entity.id]
				local spineMat = matDict[entity.id]

				valueDict[entity.id] = MaterialUtil.getLerpValue(self._transitType, originValue, targetValue, value, valueDict[entity.id])

				MaterialUtil.setPropValue(spineMat, self._transitName, self._transitType, valueDict[entity.id])
			end
		end, nil, nil, nil, EaseType.Linear)
	elseif needChangeProp then
		for _, entity in ipairs(self._targetEntitys) do
			local spineMat = entity.spineRenderer:getReplaceMat()

			MaterialUtil.setPropValue(spineMat, self._transitName, self._transitType, targetValue)
		end
	end
end

function FightTLEventSpineMaterial:onTrackEnd()
	self:_clear()
end

function FightTLEventSpineMaterial:_clear()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function FightTLEventSpineMaterial:onDestructor()
	self:_clear()
end

return FightTLEventSpineMaterial
