-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffSubBuff.lua

module("modules.logic.fight.entity.comp.buff.FightBuffSubBuff", package.seeall)

local FightBuffSubBuff = class("FightBuffSubBuff")

function FightBuffSubBuff:onBuffStart(entity, buffMo)
	self.entity = entity
	self.entityId = entity.id
	self.existCount = 0
	self.effectList = {}

	FightController.instance:registerCallback(FightEvent.ASFD_PullOut, self.pullOutAllEffect, self)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self.onSpineLoaded, self)

	self.buffMo = buffMo

	self:tryCreateALFResidualEffect(buffMo)
end

function FightBuffSubBuff:onSpineLoaded(spine)
	if spine.unitSpawn ~= self.entity then
		return
	end

	self:tryCreateALFResidualEffect(self.buffMo)
end

function FightBuffSubBuff:log(prefix, buffMo)
	logError(string.format("[%s] entityId : %s, entityName : %s, subBuffComp : %s, buffUid : %s, buffCoId : %s, buffName : %s, buffLayer : %s", prefix, self.entityId, FightHelper.getEntityName(self.entity), self, buffMo and buffMo.uid, buffMo and buffMo.buffId, buffMo and buffMo:getCO().name, buffMo and buffMo.layer))
end

function FightBuffSubBuff:onBuffUpdate(buffMo)
	self.buffMo = buffMo

	self:tryCreateALFResidualEffect(buffMo)
end

function FightBuffSubBuff:tryCreateALFResidualEffect(buffMo)
	local spine = self.entity.spine
	local spineGo = spine and spine:getSpineGO()

	if gohelper.isNil(spineGo) then
		return
	end

	while self.existCount < buffMo.layer do
		if not FightDataHelper.ASFDDataMgr:checkCanAddALFResidual(self.entityId) then
			break
		end

		local data = FightDataHelper.ASFDDataMgr:popEntityResidualData(self.entityId)
		local alfCo = data and data.missileRes and lua_fight_sp_effect_alf.configDict[data.missileRes] or FightHeroSpEffectConfig.instance:getRandomAlfASFDMissileRes()
		local residualRes = alfCo and alfCo.residualRes

		if not string.nilorempty(residualRes) then
			local residualWrap = self.entity.effect:addHangEffect(residualRes, ModuleEnum.SpineHangPoint.mountbody)

			FightRenderOrderMgr.instance:addEffectWrapByOrder(self.entityId, residualWrap, FightRenderOrderMgr.MaxOrder)
			residualWrap:setLocalPos(0, 0, 0)

			local startPos = data and data.startPos
			local endPos = data and data.endPos
			local rotationZ = startPos and endPos and FightASFDHelper.getZRotation(startPos.x, startPos.y, endPos.x, endPos.y) or math.random(-30, 30)

			self:setRotation(residualWrap.containerGO.transform, rotationZ)
			table.insert(self.effectList, {
				residualWrap,
				alfCo,
				rotationZ
			})
			self.entity.buff:addLoopBuff(residualWrap)
		end

		self.existCount = self.existCount + 1

		FightDataHelper.ASFDDataMgr:addALFResidual(self.entityId, 1)
	end
end

function FightBuffSubBuff:pullOutAllEffect(fightStepData)
	for _, residualEffect in ipairs(self.effectList) do
		local effectWrap = residualEffect[1]
		local alfCo = residualEffect[2]
		local rotationZ = residualEffect[3]

		if self.entity then
			self.entity.buff:removeLoopBuff(effectWrap)
			self.entity.effect:removeEffect(effectWrap)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, effectWrap)

		if alfCo and self.entity then
			if self.entity.effect:isDestroyed() then
				if isDebugBuild then
					logError(string.format("entityName : %s, effectComp is destroyed", FightHelper.getEntityName(self.entity)))
				end
			else
				local pullOutWrap = self.entity.effect:addHangEffect(alfCo.pullOutRes, ModuleEnum.SpineHangPoint.mountmiddle, nil, 1)

				pullOutWrap:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:addEffectWrapByOrder(self.entityId, pullOutWrap, FightRenderOrderMgr.MaxOrder)
				self:setRotation(pullOutWrap.containerGO.transform, rotationZ)
				self:playAudio(alfCo.audioId)
			end
		end
	end

	FightDataHelper.ASFDDataMgr:removeALFResidual(self.entityId, #self.effectList)
	tabletool.clear(self.effectList)
end

function FightBuffSubBuff:setRotation(transform, rotation)
	local parent = transform.parent
	local _, _, rotationZ = transformhelper.getLocalRotation(parent)

	rotation = 180 - rotation + rotationZ

	transformhelper.setLocalRotation(transform, 0, 0, rotation)
end

function FightBuffSubBuff:playAudio(audioId)
	if not audioId then
		return
	end

	if audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function FightBuffSubBuff:onOpenView(viewName)
	if viewName == ViewName.FightFocusView then
		self:setEffectActive(false)
	end
end

function FightBuffSubBuff:onCloseViewFinish(viewName)
	if viewName == ViewName.FightFocusView then
		self:setEffectActive(true)
	end
end

function FightBuffSubBuff:onSkillPlayStart(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) then
		self:setEffectActive(false)
	end
end

function FightBuffSubBuff:onSkillPlayFinish(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) then
		self:setEffectActive(true)
	end
end

function FightBuffSubBuff:setEffectActive(active)
	for _, residualEffect in ipairs(self.effectList) do
		local effectWrap = residualEffect[1]

		effectWrap:setActive(active)
	end
end

function FightBuffSubBuff:clear()
	FightController.instance:unregisterCallback(FightEvent.ASFD_PullOut, self.pullOutAllEffect, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self.onSpineLoaded, self)

	for _, residualEffect in ipairs(self.effectList) do
		local effectWrap = residualEffect[1]

		if self.entity then
			self.entity.buff:removeLoopBuff(effectWrap)
			self.entity.effect:removeEffect(effectWrap)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, effectWrap)
	end

	FightDataHelper.ASFDDataMgr:removeALFResidual(self.entityId, #self.effectList)
	tabletool.clear(self.effectList)
end

function FightBuffSubBuff:onBuffEnd()
	self:clear()
end

function FightBuffSubBuff:dispose()
	self:clear()
end

return FightBuffSubBuff
