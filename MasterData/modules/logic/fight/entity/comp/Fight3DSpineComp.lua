-- chunkname: @modules/logic/fight/entity/comp/Fight3DSpineComp.lua

module("modules.logic.fight.entity.comp.Fight3DSpineComp", package.seeall)

local Fight3DSpineComp = class("Fight3DSpineComp", FightBaseClass)

function Fight3DSpineComp:onConstructor(entity)
	self.unitSpawn = entity
	self.entity = entity
	self.entityData = entity.entityData
	self.entityExData = FightDataHelper.entityExMgr:getById(entity.entityData.id)

	local go = entity.go

	self._gameObj = go
	self._gameTr = go.transform
	self._skeletonAnim = nil
	self._spineRenderer = nil
	self._ppEffectMask = nil
	self._spineGo = nil
	self._spineTr = nil
	self._curAnimState = nil
	self._isLoop = true
	self._renderOrder = 0
	self._lookDir = SpineLookDir.Left
	self._timeScale = 1
	self._bFreeze = false
	self._layer = UnityLayer.UnitOpaque
	self._actionCbList = {}
	self._isActive = true

	self:com_registFightEvent(FightEvent.OnBuffUpdate, self.onBuffUpdate)
	self:com_registFightEvent(FightEvent.SkillEditorRefreshBuff, self.detectRefreshAct)
	self:com_registMsg(FightMsgId.Set3_7BossLayer2Unit, self.onSet3_7BossLayer2Unit)
	self:com_registMsg(FightMsgId.Set3_7BossLayer2Scene, self.onSet3_7BossLayer2Scene)
end

function Fight3DSpineComp:detectRefreshAct(buffId)
	local entityMO = self.unitSpawn:getMO()

	if entityMO then
		local config = lua_fight_buff_replace_spine_act.configDict[entityMO.skin]

		if config and config[buffId] then
			self.unitSpawn:resetAnimState()
		end
	end
end

function Fight3DSpineComp:onBuffUpdate(entityId, effectType, buffId)
	if entityId == self.unitSpawn.id then
		self:detectRefreshAct(buffId)
	end
end

function Fight3DSpineComp:registLoadSpineWork(resPath, loadedCallback, loadedCallbackHandle)
	self.loadedCallback = loadedCallback
	self.loadedCallbackHandle = loadedCallbackHandle

	local flow = self:com_registFlowSequence()

	resPath = resPath or self:getSpineUrl()

	if string.nilorempty(resPath) then
		return flow
	end

	flow:registWork(FightWorkLoadAsset, resPath, self.onSpineLoaded, self)

	return flow
end

function Fight3DSpineComp:getSpineUrl(skinConfig)
	if self.entityExData.spineUrl then
		return self.entityExData.spineUrl
	end

	skinConfig = skinConfig or self.entity.entityData:getSpineSkinCO()

	return skinConfig.spine .. ".prefab"
end

function Fight3DSpineComp:onSpineLoaded(success, loader)
	if not success then
		return
	end

	local prefab = loader:GetResource()
	local spineGO = gohelper.clone(prefab, self._gameObj)

	self:_initSpine(spineGO)
end

function Fight3DSpineComp:setFreeze(isFreeze)
	self._bFreeze = isFreeze
end

function Fight3DSpineComp:setTimeScale(timeScale)
	self._timeScale = timeScale
end

function Fight3DSpineComp:_initSpine(spineGO)
	if self.entity.initHangPointDict then
		self.entity:initHangPointDict()
	end

	self._spineGo = spineGO
	self._spineTr = self._spineGo.transform

	self:setLayer(self._layer, true)

	self.animatorPlayer = gohelper.onceAddComponent(self._spineGo, typeof(ZProj.FightAnimatorPlayer))
	self.animatorPlayer.useCrossFadeInFixedTime = true
	self.animatorPlayer.fadeInFixedTime = 0.2

	self.animatorPlayer:setCallback(self.onAnimEnd, self)

	self._spineRenderer = self._spineGo:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	self:setActive(self._isActive)

	if not self._curAnimState then
		self._curAnimState = nil

		self:play(self._curAnimState, self._isLoop)
		self:setRenderOrder(self._renderOrder, true)

		if self.loadedCallback then
			self.loadedCallback(self.loadedCallbackHandle)
		end

		FightController.instance:dispatchEvent(FightEvent.AfterInitSpine, self)
		self:com_registMsg(FightMsgId.BeforePlayTimeline, self.beforePlayTimeline)
		self:com_registMsg(FightMsgId.OnTimelineWorkDestroyed, self.onTimelineWorkDestroyed)
	end
end

function Fight3DSpineComp:beforePlayTimeline(entityId, skillId, fightStepData, timelineName)
	if not FightCardDataHelper.isBigSkill(skillId) then
		if entityId == self.entity.id then
			return
		end

		if FightDataHelper.tempMgr.isNdkQteing then
			return
		end

		self.timelineCount = self.timelineCount or 0
		self.timelineCount = self.timelineCount + 1

		if self.timelineCount > 0 and self._layer ~= UnityLayer.SceneOpaque then
			self:setLayer(UnityLayer.SceneOpaque, true)
		end
	end
end

function Fight3DSpineComp:onTimelineWorkDestroyed(entityId, skillId, fightStepData, timelineName)
	if not FightCardDataHelper.isBigSkill(skillId) then
		if entityId == self.entity.id then
			return
		end

		if FightDataHelper.tempMgr.isNdkQteing then
			return
		end

		self.timelineCount = self.timelineCount or 0
		self.timelineCount = self.timelineCount - 1

		if self.timelineCount <= 0 and self._layer ~= UnityLayer.UnitOpaque then
			self:setLayer(UnityLayer.UnitOpaque, true)
		end
	end
end

local forceSetUnitLayer = {
	["effects/prefabs/v3a7_smxjdz1/smxjdz1_c_hudun02.prefab"] = true,
	["effects/prefabs/v3a7_smxjdz1/smxjdz1_b_skill1_xing02.prefab"] = true
}

function Fight3DSpineComp:setLayer(layer, recursive)
	self._layer = layer

	if not gohelper.isNil(self._spineGo) then
		gohelper.setLayer(self._spineGo, self._layer, recursive)

		if layer == UnityLayer.UnitOpaque then
			if not UnityLayer.Unit then
				local effectLayer = UnityLayer.Scene

				for _, effectWrap in pairs(self.entity.effect._playingEffectDict) do
					if forceSetUnitLayer[effectWrap.path] then
						effectWrap:setLayer(UnityLayer.Unit)
					else
						effectWrap:setLayer(effectLayer)
					end
				end
			end
		end
	end
end

function Fight3DSpineComp:onSet3_7BossLayer2Unit()
	self:setLayer(UnityLayer.UnitOpaque, true)
end

function Fight3DSpineComp:onSet3_7BossLayer2Scene()
	self:setLayer(UnityLayer.SceneOpaque, true)
end

function Fight3DSpineComp:getSpineGO()
	return self._spineGo
end

function Fight3DSpineComp:getSpineTr()
	return self._spineTr
end

function Fight3DSpineComp:getSkeletonAnim()
	return self._skeletonAnim
end

function Fight3DSpineComp:getAnimState()
	return self._curAnimState
end

function Fight3DSpineComp:getPPEffectMask()
	return self._ppEffectMask
end

function Fight3DSpineComp:setRenderOrder(order, force)
	if not order then
		return
	end

	local oldOrder = self._renderOrder

	self._renderOrder = order

	if not force and order == oldOrder then
		return
	end

	if self._spineRenderer then
		for i = 0, self._spineRenderer.Length - 1 do
			self._spineRenderer[i].sortingOrder = order
		end
	end
end

function Fight3DSpineComp:changeLookDir(dir)
	if dir == self._lookDir then
		return
	end

	self._lookDir = dir

	self:_changeLookDir()
end

function Fight3DSpineComp:_changeLookDir()
	return
end

function Fight3DSpineComp:getLookDir()
	return self._lookDir
end

function Fight3DSpineComp:setActive(isActive)
	if self._spineGo then
		gohelper.setActive(self._spineGo, isActive)
	else
		self._isActive = isActive
	end
end

function Fight3DSpineComp:play(animState, loop, reStart, donotProcess)
	local work = self:registworkPlayAnim(animState, loop, reStart, donotProcess)

	if work then
		work:start()
	end
end

function Fight3DSpineComp:registworkPlayAnim(animState, loop, reStart, donotProcess)
	return (self:com_registWork(FightWorkPlay3DSpineAnim, self.entity, animState, reStart, donotProcess))
end

function Fight3DSpineComp:hasAnimation(animState)
	return true
end

function Fight3DSpineComp:onAnimEnd()
	FightMsgMgr.sendMsg(FightMsgId.On3DSpineAnimPlayFinish, self.entity.id, self._curAnimState)
	self:invokeAnimEventCallback(SpineAnimEvent.ActionComplete)
end

function Fight3DSpineComp:invokeAnimEventCallback(eventName)
	for i, cbTable in ipairs(self._actionCbList) do
		local callback = cbTable[1]
		local callbackObj = cbTable[2]
		local param = cbTable[3]

		if callbackObj then
			callback(callbackObj, self._curAnimState, eventName, nil, param)
		else
			callback(self._curAnimState, eventName, nil, param)
		end
	end
end

function Fight3DSpineComp:setAnimation(animState, loop, mixTime)
	return
end

function Fight3DSpineComp:addAnimEventCallback(animEvtCb, animEvtCbObj, param)
	if not animEvtCb then
		return
	end

	for i, cbTable in ipairs(self._actionCbList) do
		local callback = cbTable[1]
		local callbackObj = cbTable[2]

		if callback == animEvtCb and callbackObj == animEvtCbObj then
			cbTable[3] = param

			return
		end
	end

	table.insert(self._actionCbList, {
		animEvtCb,
		animEvtCbObj,
		param
	})
end

function Fight3DSpineComp:removeAnimEventCallback(animEvtCb, animEvtCbObj)
	for i, cbTable in ipairs(self._actionCbList) do
		local callback = cbTable[1]
		local callbackObj = cbTable[2]

		if callback == animEvtCb and callbackObj == animEvtCbObj then
			table.remove(self._actionCbList, i)

			break
		end
	end
end

function Fight3DSpineComp:removeAllAnimEventCallback()
	self._actionCbList = {}
end

function Fight3DSpineComp:logNilGameObj()
	return
end

function Fight3DSpineComp:onDestructor()
	return
end

function Fight3DSpineComp.changeTo1()
	FightWorkPlay3DSpineAnim.preName = "face1_"

	local flow = FightGameMgr.entityMgr:com_registFlowSequence()

	for k, entity in pairs(FightGameMgr.entityMgr.entityDic) do
		local entityData = entity:getMO()

		if entityData and lua_fight_monster_3d.configDict[entityData.skin] then
			flow:addWork(entity.spine:registworkPlayAnim("idle"))
		end
	end

	flow:start()
end

function Fight3DSpineComp.changeTo2()
	FightWorkPlay3DSpineAnim.preName = "face2_"

	local flow = FightGameMgr.entityMgr:com_registFlowSequence()

	for k, entity in pairs(FightGameMgr.entityMgr.entityDic) do
		local entityData = entity:getMO()

		if entityData and lua_fight_monster_3d.configDict[entityData.skin] then
			flow:addWork(entity.spine:registworkPlayAnim("changeToface2"))
			flow:addWork(entity.spine:registworkPlayAnim("idle"))
		end
	end

	flow:start()
end

function Fight3DSpineComp.changeTo3()
	FightWorkPlay3DSpineAnim.preName = "face3_"

	local flow = FightGameMgr.entityMgr:com_registFlowSequence()

	for k, entity in pairs(FightGameMgr.entityMgr.entityDic) do
		local entityData = entity:getMO()

		if entityData and lua_fight_monster_3d.configDict[entityData.skin] then
			flow:addWork(entity.spine:registworkPlayAnim("changeToface3"))
			flow:addWork(entity.spine:registworkPlayAnim("idle"))
		end
	end

	flow:start()
end

function Fight3DSpineComp.changeTo4()
	FightWorkPlay3DSpineAnim.preName = "face4_"

	local flow = FightGameMgr.entityMgr:com_registFlowSequence()

	for k, entity in pairs(FightGameMgr.entityMgr.entityDic) do
		local entityData = entity:getMO()

		if entityData and lua_fight_monster_3d.configDict[entityData.skin] then
			entity.spine:play("idle")
		end
	end

	flow:start()
end

return Fight3DSpineComp
