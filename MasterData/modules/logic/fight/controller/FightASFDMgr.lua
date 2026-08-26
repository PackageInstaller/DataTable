-- chunkname: @modules/logic/fight/controller/FightASFDMgr.lua

module("modules.logic.fight.controller.FightASFDMgr", package.seeall)

local FightASFDMgr = class("FightASFDMgr", FightBaseClass)

FightASFDMgr.LoadingStatus = {
	NotLoad = 1,
	Loaded = 3,
	Loading = 2
}

function FightASFDMgr:onConstructor()
	self.fightStepDataArrivedCount = {}
	self.effectWrap2EntityIdDict = {}
	self.sideEmitterWrap = nil
	self.missileWrapList = {}
	self.missileMoverList = {}
	self.explosionWrapList = {}
	self.playHitAnimEntityIdDict = {}
	self.startAnimLoadingStatus = FightASFDMgr.LoadingStatus.NotLoad
	self.endAnimLoadingStatus = FightASFDMgr.LoadingStatus.NotLoad

	self:com_registFightEvent(FightEvent.AddUseCard, self.onAddUseCard)
	self:com_registFightEvent(FightEvent.OnMySideRoundEnd, self.onMySideRoundEnd)
	self:com_registFightEvent(FightEvent.BeforePlayUniqueSkill, self.onBeforePlayUniqueSkill)
	self:com_registFightEvent(FightEvent.AfterPlayUniqueSkill, self.onAfterPlayUniqueSkill)
end

function FightASFDMgr:playAudio(audioId)
	if not audioId then
		return
	end

	if audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function FightASFDMgr:onBeforePlayUniqueSkill()
	if self.bornEffectWrap then
		self.bornEffectWrap:setActive(false)
	end
end

function FightASFDMgr:onAfterPlayUniqueSkill()
	if self.bornEffectWrap then
		self.bornEffectWrap:setActive(true)
	end
end

function FightASFDMgr:getASFDEntityMo(cardIndexList)
	if not cardIndexList then
		return
	end

	local cardInfoMoList = FightPlayCardModel.instance:getUsedCards()

	if not cardInfoMoList then
		return
	end

	for _, cardIndex in ipairs(cardIndexList) do
		local cardInfoMo = cardInfoMoList[cardIndex]

		if cardInfoMo then
			local entityId = cardInfoMo.uid
			local entityMo = FightDataHelper.entityMgr:getById(entityId)

			if entityMo and entityMo:isASFDEmitter() then
				return entityMo
			end
		end
	end
end

function FightASFDMgr:onAddUseCard(cardIndexList)
	local entityMo = self:getASFDEntityMo(cardIndexList)

	if not entityMo then
		return
	end

	local entityId = entityMo.id
	local entity = FightHelper.getEntity(entityId)

	if not entity then
		logError("没有找到发射奥术飞弹的实体" .. tostring(entityId))

		return
	end

	local bornCo = FightASFDHelper.getBornCo(entityId)
	local bornRes = FightASFDConfig.instance:getASFDCoRes(bornCo)

	self.curBornCo = bornCo
	self.bornEntity = entity
	self.bornEffectWrap = entity.effect:addGlobalEffect(bornRes)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(entityId, self.bornEffectWrap, FightRenderOrderMgr.MaxOrder)
	self.bornEffectWrap:setLocalPos(FightASFDHelper.getEmitterPos(entityMo.side, bornCo.sceneEmitterId))

	local scale = bornCo.scale

	if scale == 0 then
		scale = 1
	end

	self.bornEffectWrap:setEffectScale(scale)
	self:playAudio(bornCo.audio)

	self.effectWrap2EntityIdDict[self.bornEffectWrap] = entityId
end

function FightASFDMgr:onMySideRoundEnd()
	self:clearBornEffect()
end

function FightASFDMgr:getLSJSpineList()
	return self.lsjSpineList
end

function FightASFDMgr:getLSJPlayedAnimList()
	return self.lsjSpinePlayedAnimList
end

local LSJEmptyEntityValue = 1

function FightASFDMgr:isLSJEmptyEntity(entity)
	return entity == LSJEmptyEntityValue
end

function FightASFDMgr:createLSJSpine(asfdContext)
	self.lsjSpineList = self.lsjSpineList or {}
	self.lsjSpinePlayedAnimList = self.lsjSpinePlayedAnimList or {}

	tabletool.clear(self.lsjSpineList)
	tabletool.clear(self.lsjSpinePlayedAnimList)

	local max = asfdContext.emitterAttackMaxNum
	local curIndex = asfdContext.emitterAttackNum

	for i = 1, max do
		if i < curIndex then
			table.insert(self.lsjSpineList, LSJEmptyEntityValue)
			table.insert(self.lsjSpinePlayedAnimList, true)
		else
			local co = lua_fight_lsj_asfd.configDict[i]

			if co then
				local fullRes = string.format("roles/%s.prefab", co.spineRes)
				local entity = FightGameMgr.entityMgr:buildTempSpine(fullRes, "lsj_" .. i, FightEnum.EntitySide.MySide, nil, nil, "lsj_" .. i)
				local emitterLocalPosX, emitterLocalPosY, emitterLocalPosZ = transformhelper.getLocalPos(self.sideEmitterWrap.containerTr)
				local pos = FightStrUtil.instance:getSplitToNumberCache(co.pos, ",")

				if pos then
					if not pos[1] then
						local x = 0

						if pos then
							if not pos[2] then
								local y = 0

								if pos then
									if not pos[3] then
										local z = 0

										transformhelper.setLocalPos(entity.go.transform, x + emitterLocalPosX, y + emitterLocalPosY, z + emitterLocalPosZ)
										table.insert(self.lsjSpineList, entity)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function FightASFDMgr:createEmitterWrap(fightStepData)
	if not fightStepData then
		return
	end

	local entityId = fightStepData.fromId
	local entityMo = FightDataHelper.entityMgr:getById(entityId)

	if not entityMo then
		logError("没有找到发射奥术飞弹的实体 mo")

		return
	end

	if self.sideEmitterWrap then
		return
	end

	local entity = FightHelper.getEntity(entityId)

	if not entity then
		logError("没有找到发射奥术飞弹的实体")

		return
	end

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnStart, entity, fightStepData.actId, fightStepData)
	self:clearBornEffect(true)

	local emitterCo = FightASFDHelper.getEmitterCo(entityId)
	local emitterRes = FightASFDConfig.instance:getASFDCoRes(emitterCo)
	local emitterWrap = entity.effect:addGlobalEffect(emitterRes)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(entityId, emitterWrap, FightRenderOrderMgr.MaxOrder)
	emitterWrap:setLocalPos(FightASFDHelper.getEmitterPos(entityMo.side, emitterCo.sceneEmitterId))

	local scale = emitterCo.scale

	if scale == 0 then
		scale = 1
	end

	emitterWrap:setEffectScale(scale)
	self:playAudio(emitterCo.audio)

	self.sideEmitterWrap = emitterWrap
	self.effectWrap2EntityIdDict[emitterWrap] = entityId

	self:preloadEmitterRemoveRes(emitterCo)
	self:playStartASFDAnim()

	return emitterWrap
end

function FightASFDMgr:preloadEmitterRemoveRes(emitterCo)
	local res = FightASFDHelper.getASFDEmitterRemoveRes(emitterCo)
	local fullPath = FightHelper.getEffectUrlWithLod(res)

	loadAbAsset(fullPath, true)
end

function FightASFDMgr:emitMissile(fightStepData, asfdContext)
	if not fightStepData then
		return self:emitterFail(fightStepData)
	end

	self.curStepData = fightStepData
	self.fightStepDataArrivedCount[fightStepData] = {
		0,
		0
	}

	if not (asfdContext and asfdContext.splitNum > 0 and self:emitterFissionMissile(fightStepData, asfdContext) or self:emitterNormalMissile(fightStepData, asfdContext)) then
		return self:emitterFail(fightStepData)
	end
end

function FightASFDMgr:emitterNormalMissile(fightStepData, asfdContext)
	if not fightStepData then
		return
	end

	local toId = FightASFDHelper.getMissileTargetId(fightStepData)
	local wrap = self:_emitterOneMissile(fightStepData, toId, asfdContext)

	if wrap then
		self.fightStepDataArrivedCount[fightStepData][1] = self.fightStepDataArrivedCount[fightStepData][1] + 1

		return true
	end
end

function FightASFDMgr:emitterFissionMissile(fightStepData, asfdContext)
	if not fightStepData then
		return
	end

	self.targetDict = self.targetDict or {}

	tabletool.clear(self.targetDict)

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		if FightASFDHelper.isDamageEffect(actEffectData.effectType) then
			self.targetDict[actEffectData.targetId] = true
		end
	end

	local emitterFail = true

	for toId, _ in pairs(self.targetDict) do
		local effectWrap = self:_emitterOneMissile(fightStepData, toId, asfdContext)

		if effectWrap then
			emitterFail = false
			self.fightStepDataArrivedCount[fightStepData][1] = self.fightStepDataArrivedCount[fightStepData][1] + 1

			effectWrap:setEffectScale(FightASFDConfig.instance.fissionScale)
		end
	end

	tabletool.clear(self.targetDict)

	return not emitterFail
end

function FightASFDMgr:_emitterOneMissile(fightStepData, toId, asfdContext)
	local entityId = fightStepData.fromId
	local entity = FightHelper.getEntity(entityId)

	if not entity then
		logError("没有找到发射奥术飞弹的实体, entityId : " .. tostring(entityId))

		return
	end

	local toEntity = FightHelper.getEntity(toId)

	if not toEntity then
		logError("没有找到奥术飞弹 命中实体, toId : " .. tostring(toId))

		return
	end

	local missileCo = FightASFDHelper.getMissileCo(entityId, asfdContext)
	local missileRes = FightASFDConfig.instance:getASFDCoRes(missileCo)
	local missileWrap = entity.effect:addGlobalEffect(missileRes)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(entityId, missileWrap, FightRenderOrderMgr.MaxOrder)

	local mover = FightASFDFlyPathHelper.getMissileMover(entity, missileCo, missileWrap, toId, asfdContext, self.onArrived, self)

	mover.missileWrap = missileWrap
	mover.fightStepData = fightStepData
	mover.toId = toId
	mover.asfdContext = asfdContext
	mover.missileRes = missileRes

	local scale = missileCo.scale

	if scale == 0 then
		scale = 1
	end

	missileWrap:setEffectScale(scale)
	self:playAudio(missileCo.audio)
	table.insert(self.missileMoverList, mover)
	table.insert(self.missileWrapList, missileWrap)

	self.effectWrap2EntityIdDict[missileWrap] = entityId

	return missileWrap
end

function FightASFDMgr:pullOut(fightStepData)
	for _, residualEffect in ipairs(self.alfResidualEffectList) do
		local effectWrap = residualEffect[1]
		local missileRes = residualEffect[2]
		local entityId = residualEffect[3]
		local entity = FightHelper.getEntity(entityId)

		if entity then
			entity.effect:removeEffect(effectWrap)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(entityId, effectWrap)

		if entity then
			local alfCo = lua_fight_sp_effect_alf.configDict[missileRes]

			if alfCo then
				local residualWrap = entity.effect:addHangEffect(alfCo.pullOutRes, ModuleEnum.SpineHangPoint.mountbody, nil, 1)

				residualWrap:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:addEffectWrapByOrder(entityId, residualWrap, FightRenderOrderMgr.MaxOrder)
				self:playAudio(alfCo.audioId)
			end
		end
	end

	tabletool.clear(self.alfResidualEffectList)
end

function FightASFDMgr:emitterFail(fightStepData)
	return self:onASFDArrived(fightStepData)
end

function FightASFDMgr:onArrived(mover)
	local fightStepData = mover.fightStepData
	local context = mover.asfdContext
	local missileRes = mover.missileRes

	if not self.fightStepDataArrivedCount[fightStepData] then
		self.fightStepDataArrivedCount[fightStepData][2] = self.fightStepDataArrivedCount[fightStepData][2] + 1

		self:tryAddALFResidualEffectData(missileRes, mover)
		self:createExplosionEffect(fightStepData, mover.toId, context)
		self:playHitAction(mover.toId)
		self:floatDamage(mover.fightStepData, mover.toId)
		self:clearMover(mover)

		if self.fightStepDataArrivedCount[fightStepData][2] >= self.fightStepDataArrivedCount[fightStepData][1] then
			self.fightStepDataArrivedCount[fightStepData] = nil

			return self:onASFDArrived(fightStepData)
		end
	end
end

function FightASFDMgr:tryAddALFResidualEffectData(missileRes, mover)
	local alfCo = lua_fight_sp_effect_alf.configDict[missileRes]

	if not alfCo then
		return
	end

	local data = {
		missileRes = missileRes,
		entityId = mover.toId,
		startPos = mover:getLastStartPos(),
		endPos = mover:getLastEndPos()
	}

	FightDataHelper.ASFDDataMgr:addEntityResidualData(mover.toId, data)
end

function FightASFDMgr:onASFDArrived(fightStepData)
	return FightController.instance:dispatchEvent(FightEvent.ASFD_OnASFDArrivedDone, fightStepData)
end

function FightASFDMgr:createExplosionEffect(fightStepData, toEntityId, context)
	local toEntity = FightHelper.getEntity(toEntityId)

	if not toEntity then
		return
	end

	local explosionCo = FightASFDHelper.getExplosionCo(fightStepData and fightStepData.fromId, context)
	local explosionDuration = FightASFDConfig.instance.explosionDuration / FightModel.instance:getSpeed()
	local res = FightASFDConfig.instance:getASFDCoRes(explosionCo)
	local wrap = toEntity.effect:addHangEffect(res, ModuleEnum.SpineHangPoint.mountbody, nil, explosionDuration)

	wrap:setLocalPos(0, 0, 0)

	local scale = FightASFDHelper.getASFDExplosionScale(fightStepData, explosionCo, toEntityId)

	wrap:setEffectScale(scale)
	self:playAudio(explosionCo.audio)
	FightRenderOrderMgr.instance:addEffectWrapByOrder(toEntityId, wrap, FightRenderOrderMgr.MaxOrder)

	self.effectWrap2EntityIdDict[wrap] = toEntityId

	table.insert(self.explosionWrapList, wrap)
	TaskDispatcher.cancelTask(self.onExplosionEffectDone, self)
	TaskDispatcher.runDelay(self.onExplosionEffectDone, self, explosionDuration)
end

function FightASFDMgr:onExplosionEffectDone()
	FightController.instance:dispatchEvent(FightEvent.ASFD_OnASFDExplosionDone)
end

function FightASFDMgr:playHitAction(toEntityId)
	local toEntity = FightHelper.getEntity(toEntityId)

	if not toEntity then
		return
	end

	local actionName = FightHelper.processEntityActionName(toEntity, "hit")

	toEntity.spine:play(actionName, false, true, true)
	toEntity.spine:removeAnimEventCallback(self._onAnimEvent, self)
	toEntity.spine:addAnimEventCallback(self._onAnimEvent, self, {
		toEntity,
		actionName
	})

	self.playHitAnimEntityIdDict[toEntityId] = true
end

function FightASFDMgr:_onAnimEvent(actionName, eventName, eventArgs, param)
	local entity = param[1]
	local action = param[2]

	if eventName == SpineAnimEvent.ActionComplete and actionName == action then
		entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
		entity:resetAnimState()
	end
end

function FightASFDMgr:floatDamage(fightStepData, toEntityId)
	local flow = FightWorkFlowSequence.New(fightStepData)

	self:addDamageWork(flow, fightStepData, toEntityId)

	local stepWork = FightStepEffectWork.New()

	stepWork:setFlow(flow)
	stepWork:onStartInternal()
end

function FightASFDMgr:addDamageWork(flow, fightStepData, entityId)
	local effectList = fightStepData and fightStepData.actEffect

	if not effectList then
		return
	end

	for _, actEffectData in ipairs(effectList) do
		local effectType = actEffectData.effectType

		if FightASFDHelper.isDamageEffect(effectType) and actEffectData.targetId == entityId then
			local class = FightStepBuilder.ActEffectWorkCls[effectType]

			if class then
				flow:registWork(class, fightStepData, actEffectData)
			end
		elseif effectType == FightEnum.EffectType.FIGHTSTEP then
			self:addDamageWork(flow, actEffectData.fightStep, entityId)
		end
	end
end

function FightASFDMgr:onContinueASFDFlowDone()
	self.curStepData = nil

	TaskDispatcher.cancelTask(self.onExplosionEffectDone, self)
end

function FightASFDMgr:onASFDFlowDone(fightStepData)
	self.curStepData = nil

	self:clearBornEffect(true)
	self:clearEmitterEffect(fightStepData)
	self:clearLSJSpine()
	self:clearMissileEffect()
	self:clearExplosionEffect()
	tabletool.clear(self.effectWrap2EntityIdDict)
	TaskDispatcher.cancelTask(self.onExplosionEffectDone, self)
	self:resetSpineAnim()
	tabletool.clear(self.fightStepDataArrivedCount)
end

function FightASFDMgr:clearBornEffect(isImmediate)
	if not self.bornEffectWrap then
		return
	end

	self:removeEffect(self.bornEffectWrap)

	self.bornEffectWrap = nil

	if not isImmediate then
		self:createBornRemoveEffect()
	end

	self.curBornCo = nil
	self.bornEntity = nil
end

function FightASFDMgr:createBornRemoveEffect()
	if self.curBornCo and self.bornEntity then
		local bornRemoveRes = FightASFDHelper.getASFDBornRemoveRes(self.curBornCo)
		local bornRemoveEffectWrap = self.bornEntity.effect:addGlobalEffect(bornRemoveRes, nil, 1)

		FightRenderOrderMgr.instance:addEffectWrapByOrder(self.bornEntity.id, bornRemoveEffectWrap, FightRenderOrderMgr.MaxOrder)

		local entityMo = self.bornEntity:getMO()

		bornRemoveEffectWrap:setLocalPos(FightASFDHelper.getEmitterPos(entityMo.side, self.curBornCo.sceneEmitterId))

		local scale = self.curBornCo.scale

		if scale == 0 then
			scale = 1
		end

		bornRemoveEffectWrap:setEffectScale(scale)
	end
end

function FightASFDMgr:clearEmitterEffect(fightStepData)
	if not self.sideEmitterWrap then
		return
	end

	self:removeEffect(self.sideEmitterWrap)
	self:createRemoveEmitterEffect(fightStepData)
	self:playEndASFDAnim()

	self.sideEmitterWrap = nil
end

function FightASFDMgr:clearLSJSpine()
	if not self.lsjSpineList then
		return
	end

	for _, entity in ipairs(self.lsjSpineList) do
		if entity ~= LSJEmptyEntityValue then
			FightGameMgr.entityMgr:delEntity(entity.id)
		end
	end

	tabletool.clear(self.lsjSpineList)
	tabletool.clear(self.lsjSpinePlayedAnimList)
end

function FightASFDMgr:createRemoveEmitterEffect(fightStepData)
	if not fightStepData then
		return
	end

	local entityId = fightStepData.fromId
	local entityMo = FightDataHelper.entityMgr:getById(entityId)

	if not entityMo then
		return
	end

	local entity = FightHelper.getEntity(entityId)

	if not entity then
		return
	end

	local emitterCo = FightASFDHelper.getEmitterCo(entityId)
	local emitterRes = FightASFDHelper.getASFDEmitterRemoveRes(emitterCo)
	local emitterRemoveWrap = entity.effect:addGlobalEffect(emitterRes, nil, 1)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(entityId, emitterRemoveWrap, FightRenderOrderMgr.MaxOrder)
	emitterRemoveWrap:setLocalPos(FightASFDHelper.getEmitterPos(entityMo.side, emitterCo.sceneEmitterId))

	local scale = emitterCo.scale

	if scale == 0 then
		scale = 1
	end

	emitterRemoveWrap:setEffectScale(scale)
end

function FightASFDMgr:clearMissileEffect()
	if self.missileWrapList then
		for _, wrap in ipairs(self.missileWrapList) do
			self:removeEffect(wrap)
		end

		tabletool.clear(self.missileWrapList)
	end

	if self.missileMoverList then
		for _, mover in ipairs(self.missileMoverList) do
			self:clearMover(mover)
		end

		tabletool.clear(self.missileMoverList)
	end
end

function FightASFDMgr:clearMover(mover)
	if not mover then
		return
	end

	mover:unregisterCallback(UnitMoveEvent.Arrive, self.onArrived, self)

	mover.missileWrap = nil
	mover.fightStepData = nil
	mover.toId = nil
	mover.asfdContext = nil
	mover.missileRes = nil
end

function FightASFDMgr:clearExplosionEffect()
	if not self.explosionWrapList then
		return
	end

	for _, wrap in ipairs(self.explosionWrapList) do
		self:removeEffect(wrap)
	end

	tabletool.clear(self.explosionWrapList)
end

function FightASFDMgr:removeEffect(effectWrap)
	if not effectWrap then
		return
	end

	local entityId = self.effectWrap2EntityIdDict[effectWrap]
	local entity = FightHelper.getEntity(entityId)

	if entity then
		entity.effect:removeEffect(effectWrap)
	end

	FightRenderOrderMgr.instance:onRemoveEffectWrap(entityId, effectWrap)
end

function FightASFDMgr:resetSpineAnim()
	if not self.playHitAnimEntityIdDict then
		return
	end

	for entityId, _ in pairs(self.playHitAnimEntityIdDict) do
		local entity = FightHelper.getEntity(entityId)

		if entity then
			entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
			entity:resetAnimState()
		end
	end

	tabletool.clear(self.playHitAnimEntityIdDict)
end

function FightASFDMgr:playStartASFDAnim()
	if self.startAnimLoadingStatus == FightASFDMgr.LoadingStatus.NotLoad then
		loadAbAsset(FightASFDConfig.instance.startAnimAbUrl, false, self.loadStartAnimCallback, self)

		self.startAnimLoadingStatus = FightASFDMgr.LoadingStatus.Loading

		return
	end

	if self.startAnimLoadingStatus == FightASFDMgr.LoadingStatus.Loading then
		return
	end

	local cameraAnimator = CameraMgr.instance:getCameraRootAnimator()

	if cameraAnimator then
		cameraAnimator.enabled = true
		cameraAnimator.runtimeAnimatorController = self.startAnimController

		cameraAnimator:Play("v2a4_asfd_start", 0, 0)
	end
end

function FightASFDMgr:loadStartAnimCallback(assetItem)
	if not assetItem.IsLoadSuccess then
		self.startAnimLoadingStatus = FightASFDMgr.LoadingStatus.NotLoad

		return
	end

	self.startAnimLoadingStatus = FightASFDMgr.LoadingStatus.Loaded

	local oldAsstet = self.startAssetItem

	self.startAssetItem = assetItem

	assetItem:Retain()

	if oldAsstet then
		oldAsstet:Release()
	end

	self.startAnimController = assetItem:GetResource(FightASFDConfig.instance.startAnim)

	return self:playStartASFDAnim()
end

function FightASFDMgr:playEndASFDAnim()
	if self.endAnimLoadingStatus == FightASFDMgr.LoadingStatus.NotLoad then
		loadAbAsset(FightASFDConfig.instance.endAnimAbUrl, false, self.loadEndAnimCallback, self)

		self.endAnimLoadingStatus = FightASFDMgr.LoadingStatus.Loading

		return
	end

	if self.endAnimLoadingStatus == FightASFDMgr.LoadingStatus.Loading then
		return
	end

	local cameraAnimator = CameraMgr.instance:getCameraRootAnimator()

	if cameraAnimator then
		cameraAnimator.enabled = true
		cameraAnimator.runtimeAnimatorController = self.endAnimController

		cameraAnimator:Play("v2a4_asfd_end", 0, 0)
	end
end

function FightASFDMgr:loadEndAnimCallback(assetItem)
	if not assetItem.IsLoadSuccess then
		self.endAnimLoadingStatus = FightASFDMgr.LoadingStatus.NotLoad

		return
	end

	self.endAnimLoadingStatus = FightASFDMgr.LoadingStatus.Loaded

	local oldAsstet = self.endAssetItem

	self.endAssetItem = assetItem

	assetItem:Retain()

	if oldAsstet then
		oldAsstet:Release()
	end

	self.endAnimController = assetItem:GetResource(FightASFDConfig.instance.endAnim)

	return self:playEndASFDAnim()
end

function FightASFDMgr:removeLoader()
	removeAssetLoadCb(FightASFDConfig.instance.startAnimAbUrl, self.loadStartAnimCallback, self)

	if self.startAssetItem then
		self.startAssetItem:Release()

		self.startAssetItem = nil
	end

	removeAssetLoadCb(FightASFDConfig.instance.endAnimAbUrl, self.loadEndAnimCallback, self)

	if self.endAssetItem then
		self.endAssetItem:Release()

		self.endAssetItem = nil
	end
end

function FightASFDMgr:onDestructor()
	self:onASFDFlowDone()
	self:removeLoader()
end

return FightASFDMgr
