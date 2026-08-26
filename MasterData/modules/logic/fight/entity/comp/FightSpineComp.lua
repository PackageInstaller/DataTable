-- chunkname: @modules/logic/fight/entity/comp/FightSpineComp.lua

module("modules.logic.fight.entity.comp.FightSpineComp", package.seeall)

local FightSpineComp = class("FightSpineComp", FightBaseClass)

FightSpineComp.TypeSkeletonAnimtion = typeof(Spine.Unity.SkeletonAnimation)
FightSpineComp.TypeSpineAnimationEvent = typeof(ZProj.SpineAnimationEvent)

function FightSpineComp:onConstructor(entity)
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
	self._defaultAnimState = SpineAnimState.idle1
	self._isLoop = false
	self._lookDir = SpineLookDir.Left
	self._timeScale = 1
	self._bFreeze = false
	self._layer = UnityLayer.Unit
	self._actionCbList = {}
	self._useGoScaleReplaceSpineScale = false
	self._isActive = true
end

function FightSpineComp:setUseGoScaleReplaceSpineScale(active)
	self._useGoScaleReplaceSpineScale = active
end

function FightSpineComp:registLoadSpineWork(resPath, loadedCallback, loadedCallbackHandle)
	self.loadedCallback = loadedCallback
	self.loadedCallbackHandle = loadedCallbackHandle

	local flow = self:com_registFlowSequence()

	resPath = resPath or self:getSpineUrl()

	if string.nilorempty(resPath) then
		return flow
	end

	local spineFromPool = FightSpinePool.getSpine(resPath)

	if spineFromPool then
		flow:registWork(FightWorkFunction, self.initSpineByPool, self, spineFromPool)
	else
		flow:registWork(FightWorkLoadAsset, resPath, self.onSpineLoaded, self)
	end

	return flow
end

function FightSpineComp:getSpineUrl(skinConfig)
	if isTypeOf(self.entity, FightEntityAssembledMonsterSub) then
		return nil
	end

	if self.entityExData.spineUrl then
		return self.entityExData.spineUrl
	end

	skinConfig = skinConfig or self.entity:getMO():getSpineSkinCO()

	if FightDataHelper.entityMgr:isSub(self.entityData.id) then
		return (ResUrl.getSpineFightPrefab(skinConfig and skinConfig.alternateSpine))
	end

	local spinePath = ResUrl.getSpineFightPrefabBySkin(skinConfig)

	if FightHelper.XingTiSpineUrl2Special[spinePath] and FightHelper.detectXingTiSpecialUrl(self.entity) then
		spinePath = FightHelper.XingTiSpineUrl2Special[spinePath]
	end

	return spinePath
end

function FightSpineComp:initSpineByPool(spineFromPool)
	if gohelper.isNil(self._gameObj) then
		logError("try move spine, but parent is nil, spine name : " .. tostring(spineFromPool.name))
	end

	gohelper.addChild(self._gameObj, spineFromPool)
	transformhelper.setLocalPos(spineFromPool.transform, 0, 0, 0)
	self:_initSpine(spineFromPool)
end

function FightSpineComp:onSpineLoaded(success, loader)
	if not success then
		return
	end

	local prefab = loader:GetResource()
	local spineGO = gohelper.clone(prefab, self._gameObj)

	self:_initSpine(spineGO)
end

function FightSpineComp:setFreeze(isFreeze)
	self._bFreeze = isFreeze

	if self._skeletonAnim then
		self._skeletonAnim.freeze = self._bFreeze
	end
end

function FightSpineComp:setTimeScale(timeScale)
	self._timeScale = timeScale

	if self._skeletonAnim then
		self._skeletonAnim.timeScale = self._timeScale
	end
end

function FightSpineComp:_clear()
	if self._csSpineEvt then
		self._csSpineEvt:RemoveAnimEventCallback()
	end

	gohelper.destroy(self._spineGo)

	self._skeletonAnim = nil
	self._spineGo = nil
	self._spineTr = nil
	self._bFreeze = false
	self._isActive = true
	self._renderOrder = nil
end

function FightSpineComp:_initSpine(spineGO)
	if self.entity.initHangPointDict then
		self.entity:initHangPointDict()
	end

	self._spineGo = spineGO
	self._spineTr = self._spineGo.transform

	self:setLayer(self._layer, true)

	self._skeletonAnim = self._spineGo:GetComponent(FightSpineComp.TypeSkeletonAnimtion)

	if self._lookDir == SpineLookDir.Right then
		if self._useGoScaleReplaceSpineScale then
			self:_changeLookDirByScale()
		else
			self._skeletonAnim.initialFlipX = true
		end

		self._skeletonAnim:Initialize(true)
	else
		self._skeletonAnim:Initialize(false)
	end

	self._skeletonAnim.freeze = self._bFreeze
	self._skeletonAnim.timeScale = self._timeScale
	self._spineRenderer = self._spineGo:GetComponent(typeof(UnityEngine.MeshRenderer))
	self._ppEffectMask = self._spineGo:GetComponent(typeof(UrpCustom.PPEffectMask))
	self._csSpineEvt = gohelper.onceAddComponent(self._spineGo, FightSpineComp.TypeSpineAnimationEvent)

	self._csSpineEvt:SetAnimEventCallback(self._onAnimCallback, self)
	self:setActive(self._isActive)

	if self._curAnimState then
		local animState = self._curAnimState

		self._curAnimState = nil

		self:play(animState, self._isLoop)
	elseif self._defaultAnimState and self._skeletonAnim:HasAnimation(self._defaultAnimState) then
		self._isLoop = true

		self:play(self._defaultAnimState, self._isLoop, true)
	end

	self:setRenderOrder(self._renderOrder, true)

	if self.loadedCallback then
		self.loadedCallback(self.loadedCallbackHandle)
	end

	FightController.instance:dispatchEvent(FightEvent.AfterInitSpine, self)
	self:newClass(FightEntityWadingEffect, self.entity)
	self:newClass(FightEntityWeatherEffect, self.entity)
end

function FightSpineComp:setLayer(layer, recursive)
	self._layer = layer

	if not gohelper.isNil(self._spineGo) then
		gohelper.setLayer(self._spineGo, self._layer, recursive)
	end
end

function FightSpineComp:getSpineGO()
	return self._spineGo
end

function FightSpineComp:getSpineTr()
	return self._spineTr
end

function FightSpineComp:getSkeletonAnim()
	return self._skeletonAnim
end

function FightSpineComp:getAnimState()
	return self._curAnimState or self._defaultAnimState
end

function FightSpineComp:getPPEffectMask()
	return self._ppEffectMask
end

function FightSpineComp:setRenderOrder(order, force)
	if not order then
		return
	end

	local oldOrder = self._renderOrder

	self._renderOrder = order

	if not force and order == oldOrder then
		return
	end

	if not gohelper.isNil(self._spineRenderer) then
		self._spineRenderer.sortingOrder = order
	end
end

function FightSpineComp:changeLookDir(dir)
	if dir == self._lookDir then
		return
	end

	self._lookDir = dir

	self:_changeLookDir()
end

function FightSpineComp:_changeLookDir()
	if self._useGoScaleReplaceSpineScale then
		self:_changeLookDirByScale()
	elseif self._skeletonAnim then
		self._skeletonAnim:SetScaleX(self._lookDir)
	end
end

function FightSpineComp:_changeLookDirByScale()
	if not gohelper.isNil(self._spineTr) then
		local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(self._spineTr)

		scaleX = math.abs(scaleX)
		scaleX = self._lookDir * scaleX

		transformhelper.setLocalScale(self._spineTr, scaleX, scaleY, scaleZ)
	end
end

function FightSpineComp:getLookDir()
	return self._lookDir
end

function FightSpineComp:setActive(isActive)
	if self._spineGo then
		gohelper.setActive(self._spineGo, isActive)
	else
		self._isActive = isActive
	end
end

function FightSpineComp:play(animState, loop, reStart)
	if not animState then
		return
	end

	local needPlay = reStart or animState ~= self._curAnimState or loop ~= self._isLoop

	self._curAnimState = animState
	self._isLoop = loop or false
	reStart = reStart or false

	if self._skeletonAnim and needPlay then
		if self._skeletonAnim:HasAnimation(animState) then
			self:playAnim(animState, self._isLoop, reStart)
		else
			if isDebugBuild then
				if not gohelper.isNil(self._spineGo) then
					if not self._spineGo.name then
						local cloneName = "spine_nil"
						local begin = string.find(cloneName, "(Clone)", 1)
						local spineName = begin and string.sub(cloneName, 1, begin - 2) or cloneName

						if animState ~= "posture" then
							logError(string.format("%s 缺少动作: %s", spineName, animState))
						end
					end
				end
			end

			self:playAnim(SpineAnimState.idle1, true, true)
		end
	end
end

function FightSpineComp:hasAnimation(animState)
	if self._skeletonAnim then
		return self._skeletonAnim:HasAnimation(animState)
	end

	return false
end

function FightSpineComp:playAnim(animState, loop, reStart)
	self._skeletonAnim:PlayAnim(animState, loop, reStart)
end

function FightSpineComp:setAnimation(animState, loop, mixTime)
	if self._skeletonAnim then
		self._curAnimState = animState
		self._isLoop = loop or false

		self._skeletonAnim:SetAnimation(0, animState, loop, mixTime or 0)
	end
end

function FightSpineComp:addAnimEventCallback(animEvtCb, animEvtCbObj, param)
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

function FightSpineComp:removeAnimEventCallback(animEvtCb, animEvtCbObj)
	for i, cbTable in ipairs(self._actionCbList) do
		local callback = cbTable[1]
		local callbackObj = cbTable[2]

		if callback == animEvtCb and callbackObj == animEvtCbObj then
			table.remove(self._actionCbList, i)

			break
		end
	end
end

function FightSpineComp:removeAllAnimEventCallback()
	self._actionCbList = {}
end

function FightSpineComp:_onAnimCallback(actionName, eventName, eventArgs)
	for i, cbTable in ipairs(self._actionCbList) do
		local callback = cbTable[1]
		local callbackObj = cbTable[2]
		local param = cbTable[3]

		if callbackObj then
			callback(callbackObj, actionName, eventName, eventArgs, param)
		else
			callback(actionName, eventName, eventArgs, param)
		end
	end
end

function FightSpineComp:logNilGameObj()
	return
end

function FightSpineComp:onDestructor()
	self:_clear()

	self._csSpineEvt = nil
end

return FightSpineComp
