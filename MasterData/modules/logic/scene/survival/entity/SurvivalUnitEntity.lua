-- chunkname: @modules/logic/scene/survival/entity/SurvivalUnitEntity.lua

module("modules.logic.scene.survival.entity.SurvivalUnitEntity", package.seeall)

local SurvivalUnitEntity = class("SurvivalUnitEntity", LuaCompBase)
local OcclusionThresholdId = UnityEngine.Shader.PropertyToID("_AlphaThreshold")

function SurvivalUnitEntity.Create(unitMo, root)
	local go = gohelper.create3d(root, string.format("%s_%s", unitMo.pos, SurvivalEnum.UnitTypeToName[unitMo.unitType]))

	if isDebugBuild then
		gohelper.create3d(go, string.format("id:%s cfgId:%s", unitMo.id, unitMo.cfgId))
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalUnitEntity, unitMo)
end

function SurvivalUnitEntity:ctor(unitMo)
	self.x = 0
	self.y = 0
	self.z = 0
	self._finalAlpha = 1
	self._unitMo = unitMo
end

function SurvivalUnitEntity:init(go)
	self.go = go
	self.trans = go.transform
	self._allEffects = {}
	self._effectRoot = gohelper.create3d(go, "Effect")
	self._modelRoot = gohelper.create3d(go, "Model")

	gohelper.setActive(self._effectRoot, false)
	self:_onFollowTaskUpdate()
	self:onPrepairUnitMo()
	self:setPosAndDir(self._unitMo.pos, self._unitMo.dir)

	self._loader = PrefabInstantiate.Create(self._modelRoot)

	local path = self:getResPath()

	if string.nilorempty(path) then
		return
	end

	self._loader:startLoad(path, self._onResLoadEnd, self)
end

function SurvivalUnitEntity:getResPath()
	if self.tempResPath then
		return self.tempResPath
	end

	return self._unitMo:getSceneResPath()
end

function SurvivalUnitEntity:addEventListeners()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitPosChange, self._checkIsTop, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitChange, self._onUnitDataChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnFollowTaskUpdate, self._onFollowTaskUpdate, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnSpBlockUpdate, self._onSpBlockUpdate, self)
end

function SurvivalUnitEntity:removeEventListeners()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitPosChange, self._checkIsTop, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitChange, self._onUnitDataChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnFollowTaskUpdate, self._onFollowTaskUpdate, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnSpBlockUpdate, self._onSpBlockUpdate, self)
end

function SurvivalUnitEntity:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false

	self:_checkIsTop(self._unitMo.pos)
end

function SurvivalUnitEntity:_onResLoadEnd()
	local go = self._loader:getInstGO()
	local trans = go.transform

	self._resGo = go
	self._resTrans = trans
	self._renderers = trans:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

	transformhelper.setLocalPos(trans, 0, 0, 0)
	transformhelper.setLocalRotation(trans, 0, 0, 0)
	transformhelper.setLocalScale(trans, 1, 1, 1)

	self._anim = gohelper.findChildAnim(go, "")

	if self._curAnimName then
		self:playAnim(self._curAnimName)
	end

	self:_checkIsTop(self._unitMo.pos)
	self:updateIsShow()

	if self.loadedCallback then
		self.loadedCallback(self.loadedCallbackObj, self)

		self.loadedCallback = nil
		self.loadedCallbackObj = nil
	end
end

function SurvivalUnitEntity:setLoadedCallback(callback, callObj)
	self.loadedCallback = callback
	self.loadedCallbackObj = callObj
end

function SurvivalUnitEntity:setPosAndDir(pos, dir)
	self._unitMo.dir = dir

	self:onPosChange(pos)

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)

	transformhelper.setLocalPos(self.trans, x, y, z)
	transformhelper.setLocalRotation(self._modelRoot.transform, 0, dir * 60, 0)

	self.x = x
	self.y = y
	self.z = z
end

function SurvivalUnitEntity:tryRemove(isPlayDeadAnim)
	self._isRemove = true

	SurvivalMapHelper.instance:removeEntity(self._unitMo.id)

	if not self._curShowRes then
		TaskDispatcher.runDelay(self._delayDestroy, self, 0.1)
	elseif isPlayDeadAnim then
		self:playAnim("die")
		TaskDispatcher.runDelay(self._delayDestroy, self, 2)
	else
		self:setIsInTop(false)
		TaskDispatcher.runDelay(self._delayDestroy, self, 0.5)
	end
end

function SurvivalUnitEntity:_delayDestroy()
	gohelper.destroy(self.go)
	self:onDestroy()
end

function SurvivalUnitEntity:tornadoTransfer(pos, dir, callback, callObj)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	self._callback = callback
	self._callObj = callObj
	self._targetPos = pos

	self:beginTornadoTransfer()

	if not self.isShow then
		self:setPosAndDir(self._unitMo.pos, dir)
		TaskDispatcher.runDelay(self.onTornadoTransferDone, self, SurvivalConst.TornadoTransferTime)
	else
		self._tweenId = ZProj.TweenHelper.DOLocalMoveY(self.trans, SurvivalConst.TornadoTransferHeight, SurvivalConst.TornadoTransferTime, self.onTornadoTransferDone, self, nil, EaseType.OutCirc)
	end
end

function SurvivalUnitEntity:beginTornadoTransfer()
	return
end

function SurvivalUnitEntity:onTornadoTransferDone()
	self:setPosAndDir(self._targetPos, self._unitMo.dir)

	self._targetPos = nil

	self:_doCallback()

	if not self._tweenModelShowId then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, self._unitMo.id)
	end

	self:onMoveEnd()
end

function SurvivalUnitEntity:swapPos(pos, dir, callback, callObj)
	self:transferTo(pos, dir, callback, callObj)
end

function SurvivalUnitEntity:summonPos(pos, dir, callback, callObj)
	self:transferTo(pos, dir, callback, callObj)
end

function SurvivalUnitEntity:transferTo(pos, dir, callback, callObj)
	self._targetPos = pos
	self._callback = callback
	self._callObj = callObj

	if self._unitMo.dir ~= dir then
		self._unitMo.dir = dir

		transformhelper.setLocalRotation(self._modelRoot.transform, 0, dir * 60, 0)
	end

	self:addEffect(SurvivalConst.UnitEffectPath.Transfer1)
	TaskDispatcher.runDelay(self._tweenToTarget, self, SurvivalConst.UnitEffectTime[SurvivalConst.UnitEffectPath.Transfer1])
end

function SurvivalUnitEntity:rocketTo(pos, dir, callback, callObj)
	self.rocketParam = {
		pos = pos,
		dir = dir,
		callback = callback,
		callObj = callObj
	}
	self.tempResPath = "survival/buiding/v3a4_survival_huojian.prefab"

	self.setLoadedCallback(self, self._rocketToTarget, self)

	if not self:_checkModelPath() then
		self:setLoadedCallback()
		self:_rocketToTarget()
	end
end

function SurvivalUnitEntity:_rocketToTarget()
	local param = self.rocketParam

	if not param then
		return
	end

	local curPosX, curPosY, curPosZ = self.x, self.y, self.z
	local endPosX, endPosY, endPosZ = SurvivalHelper.instance:hexPointToWorldPoint(param.pos.q, param.pos.r)
	local angle = Mathf.Atan2(endPosX - curPosX, endPosZ - curPosZ) * Mathf.Rad2Deg - 90
	local dir = param.dir
	local rootAngle = dir * 60
	local modelAngle = Mathf.DeltaAngle(rootAngle, angle)

	transformhelper.setLocalRotation(self._resTrans, 0, modelAngle, 0)
	self.moveTo(self, param.pos, dir, self._onRocketToFinished, self)
end

function SurvivalUnitEntity:_onRocketToFinished()
	local param = self.rocketParam

	self.rocketParam = nil
	self.tempResPath = nil

	self:_checkModelPath()

	if param and param.callback then
		param.callback(param.callObj)
	end
end

function SurvivalUnitEntity:_tweenToTarget()
	self:removeEffect(SurvivalConst.UnitEffectPath.Transfer1)
	TaskDispatcher.runDelay(self._delayTransfer2, self, 0.3)
end

function SurvivalUnitEntity:_delayTransfer2()
	self:addEffect(SurvivalConst.UnitEffectPath.Transfer2)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_transmit_2)
	self:onPosChange(self._targetPos)

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(self._targetPos.q, self._targetPos.r)

	transformhelper.setLocalPos(self.trans, x, y, z)

	self.x = x
	self.y = y
	self.z = z

	TaskDispatcher.runDelay(self._delayFinish, self, SurvivalConst.UnitEffectTime[SurvivalConst.UnitEffectPath.Transfer2])
end

function SurvivalUnitEntity:_delayFinish()
	self:removeEffect(SurvivalConst.UnitEffectPath.Transfer2)

	self._targetPos = nil
	self._tweenId = nil

	self:_doCallback()

	if not self._tweenModelShowId then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, self._unitMo.id)
	end
end

function SurvivalUnitEntity:moveTo(pos, dir, callback, callObj)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	if self._callback then
		self._callback(self._callObj)
	end

	if self._targetPos then
		self:setPosAndDir(self._targetPos, self._unitMo.dir)
	end

	self._targetPos = pos
	self._callback = callback
	self._callObj = callObj

	if self._unitMo.dir ~= dir then
		self._unitMo.dir = dir
		self._tweenId = ZProj.TweenHelper.DOLocalRotate(self._modelRoot.transform, 0, dir * 60, 0, SurvivalConst.TurnDirSpeed, self._beginMove, self)
	else
		self:_beginMove()
	end
end

function SurvivalUnitEntity:onMoveBegin()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnUnitBeginMove, self._unitMo.id)
end

function SurvivalUnitEntity:_beginMove()
	self:onMoveBegin()
	self:playAnim("run")

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(self._targetPos.q, self._targetPos.r)

	self._tweenId = ZProj.TweenHelper.DOLocalMove(self.trans, (x + self.x) / 2, (y + self.y) / 2, (z + self.z) / 2, SurvivalConst.PlayerMoveSpeed / 2, self._beginMoveHalf, self, nil, EaseType.Linear)
end

function SurvivalUnitEntity:_beginMoveHalf()
	self:onPosChange(self._targetPos)

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(self._targetPos.q, self._targetPos.r)

	self._tweenId = ZProj.TweenHelper.DOLocalMove(self.trans, x, y, z, SurvivalConst.PlayerMoveSpeed / 2, self._endMove, self, nil, EaseType.Linear)
	self.x = x
	self.y = y
	self.z = z
end

function SurvivalUnitEntity:_onSpBlockUpdate(pos)
	if pos == self._unitMo.pos then
		self:_checkModelPath()
	end
end

function SurvivalUnitEntity:onPosChange(newPos)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	sceneMo:onUnitUpdatePos(self._unitMo, newPos)
	self:sortSceneModel()
	self:_checkModelPath()
end

function SurvivalUnitEntity:_checkIsTop(pos)
	if pos == self._unitMo.pos then
		self:sortSceneModel()
	end
end

function SurvivalUnitEntity:sortSceneModel()
	if self._isRemove then
		return
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local isInTop = sceneMo:isInTop(self._unitMo)

	self:setIsInTop(isInTop)
end

function SurvivalUnitEntity:setIsInTop(isTop)
	if self._isTop == nil then
		self._isTop = true
	end

	if self._isTop ~= isTop then
		self._isTop = isTop

		self:updateIsShow()
	end
end

function SurvivalUnitEntity:_checkModelPath()
	if not self._loader then
		return
	end

	local path = self:getResPath()

	if path ~= self._loader:getPath() then
		if self._tweenModelShowId then
			ZProj.TweenHelper.KillById(self._tweenModelShowId, true)

			self._tweenModelShowId = nil
		end

		self._curShowRes = nil
		self._shareMats = nil
		self._matInsts = nil
		self._finalAlpha = 1

		self._loader:dispose()

		if not string.nilorempty(path) then
			self._loader:startLoad(path, self._onResLoadEnd, self)
		end

		self:onModelChange()
		SurvivalMapHelper.instance:getScene().pointEffect:addAutoDisposeEffect(SurvivalPointEffectComp.ResPaths.changeModel, self.trans.position, 2)

		return true
	end
end

function SurvivalUnitEntity:onModelChange()
	return
end

function SurvivalUnitEntity:_onUnitDataChange(unitId)
	if unitId == self._unitMo.id then
		local path = self:getResPath()

		if self._loader:getPath() ~= path then
			self._curShowRes = nil
			self._shareMats = nil
			self._matInsts = nil
			self._finalAlpha = 1

			self._loader:dispose()

			if not string.nilorempty(path) then
				self._loader:startLoad(path, self._onResLoadEnd, self)
			end
		else
			self:updateIsShow()
		end

		self:onPrepairUnitMo()
	end
end

function SurvivalUnitEntity:onPrepairUnitMo()
	self:removeEffect(SurvivalConst.UnitEffectPath.UnitType42)
	self:removeEffect(SurvivalConst.UnitEffectPath.UnitType44)
	self:removeEffect(SurvivalConst.UnitEffectPath.FollowUnit)

	if self._unitMo.co then
		local subType = self._unitMo.co.subType

		if subType == 42 then
			self:addEffect(SurvivalConst.UnitEffectPath.UnitType42)
		elseif subType == 44 or subType == 49 then
			self:addEffect(SurvivalConst.UnitEffectPath.UnitType44)
		end

		if tabletool.indexOf(SurvivalConfig.instance:getHighValueUnitSubTypes(), subType) then
			self:addEffect(SurvivalConst.UnitEffectPath.FollowUnit)
		end

		self:updateUnitMark()
	end
end

function SurvivalUnitEntity:updateUnitMark()
	if not self._unitMo.getMark then
		return
	end

	local lastMark = self._unitMark
	local curMark = self._unitMo:getMark()

	self._unitMark = curMark

	local isChange = lastMark ~= curMark

	if not isChange then
		return
	end

	if self._unitMo:isMark(SurvivalEnum.UnitMarkType.Attract) then
		self:addEffect(SurvivalConst.UnitEffectPath.WelxEffect)
	else
		self:removeEffect(SurvivalConst.UnitEffectPath.WelxEffect)
	end

	if self._unitMo:isMark(SurvivalEnum.UnitMarkType.ItemAttract) then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.ShowUnitBubble, self._unitMo.id, 3, 1)
	end

	if self._unitMo:isMark(SurvivalEnum.UnitMarkType.Skill_Chase) then
		self:addEffect(SurvivalConst.UnitEffectPath.SnatchEffect)
	else
		self:removeEffect(SurvivalConst.UnitEffectPath.SnatchEffect)
	end
end

function SurvivalUnitEntity:_onFollowTaskUpdate()
	return
end

function SurvivalUnitEntity:updateIsShow()
	self.isShow = self._isTop and self._unitMo.visionVal ~= 8

	if not self._resGo then
		return
	end

	local isForce = false

	if self._curShowRes == nil then
		self._curShowRes = true
		isForce = true
	end

	if self._unitMo.id ~= 0 then
		gohelper.setActive(self._effectRoot, self.isShow)
	end

	if self._curShowRes ~= self.isShow then
		transformhelper.setLocalPos(self._resTrans, 0, 0, 0)

		self._curShowRes = self.isShow

		if not self.isShow then
			self:initMats()

			if isForce then
				self:onTween(1)
				self:onTweenEnd()
			else
				if self._tweenModelShowId then
					ZProj.TweenHelper.KillById(self._tweenModelShowId)
				end

				self._tweenModelShowId = ZProj.TweenHelper.DOTweenFloat(self._nowClipValue or 1 - self._finalAlpha, 1, SurvivalConst.ModelClipTime, self.onTween, self.onTweenEnd, self, nil, EaseType.Linear)
			end
		else
			SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, self._unitMo.id)

			if isForce then
				self:onTweenEnd()
			else
				if self._tweenModelShowId then
					ZProj.TweenHelper.KillById(self._tweenModelShowId)
				end

				self._tweenModelShowId = ZProj.TweenHelper.DOTweenFloat(self._nowClipValue or 1, 1 - self._finalAlpha, SurvivalConst.ModelClipTime, self.onTween, self.onTweenEnd, self, nil, EaseType.Linear)
			end
		end
	end
end

function SurvivalUnitEntity:onTween(value)
	self._nowClipValue = value

	for k, v in pairs(self._matInsts) do
		v:SetFloat(OcclusionThresholdId, value)
	end
end

function SurvivalUnitEntity:onTweenEnd()
	self._tweenModelShowId = nil

	if self._curShowRes then
		if self._finalAlpha == 1 then
			for i = 0, self._renderers.Length - 1 do
				local renderer = self._renderers[i]

				if not tolua.isnull(renderer) then
					renderer.material = self._shareMats[i]
				end
			end
		end
	else
		transformhelper.setLocalPos(self._resTrans, 0, -10, 0)

		if not self._tweenId then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, self._unitMo.id)
		end
	end
end

function SurvivalUnitEntity:initMats()
	if not self._shareMats then
		self._shareMats = self:getUserDataTb_()
		self._matInsts = self:getUserDataTb_()

		for i = 0, self._renderers.Length - 1 do
			self._shareMats[i] = self._renderers[i].sharedMaterial
			self._matInsts[i] = self._renderers[i].material

			self._matInsts[i]:EnableKeyword("_SCREENCOORD")
			self._matInsts[i]:SetFloat(OcclusionThresholdId, 0)
		end
	end

	for i = 0, self._renderers.Length - 1 do
		local renderer = self._renderers[i]

		if not tolua.isnull(renderer) then
			renderer.material = self._matInsts[i]
		end
	end
end

function SurvivalUnitEntity:_endMove()
	self:playAnim("idle")

	self._targetPos = nil
	self._tweenId = nil

	self:_doCallback()

	if not self._tweenModelShowId then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, self._unitMo.id)
	end

	self:onMoveEnd()
end

function SurvivalUnitEntity:_doCallback()
	local callback = self._callback
	local callObj = self._callObj

	self._callback = nil
	self._callObj = nil

	if callback then
		self._callback(callObj)
	end
end

function SurvivalUnitEntity:onMoveEnd()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnUnitEndMove, self._unitMo.id)
end

function SurvivalUnitEntity:playAnim(animName)
	self._curAnimName = animName

	if self._anim and not tolua.isnull(self._anim) and self._anim.isActiveAndEnabled then
		self._anim:Play(animName, 0, 0)
	end
end

function SurvivalUnitEntity:addEffect(effectPath)
	if not self._allEffects or self._allEffects[effectPath] then
		return
	end

	if gohelper.isNil(self._effectRoot) then
		logError("SurvivalUnitEntity._effectRoot is nil")

		return
	end

	local go = gohelper.create3d(self._effectRoot, "effect")
	local loader = PrefabInstantiate.Create(go)

	loader:startLoad(effectPath)

	self._allEffects[effectPath] = loader
end

function SurvivalUnitEntity:removeEffect(effectPath)
	if not self._allEffects or not self._allEffects[effectPath] then
		return
	end

	self._allEffects[effectPath]:dispose()
	gohelper.destroy(self._allEffects[effectPath]._containerGO)

	self._allEffects[effectPath] = nil
end

function SurvivalUnitEntity:addEffectTiming(effectPath, time)
	self:addEffect(effectPath)

	if time and time > 0 then
		self._delayEffectDict = self._delayEffectDict or {}
		self._delayEffectDict[effectPath] = Time.realtimeSinceStartup + time

		self:startCheckDelayEffectTimer()
	end
end

function SurvivalUnitEntity:startCheckDelayEffectTimer()
	if not self._delayEffectTimer then
		self._delayEffectTimer = true

		TaskDispatcher.runRepeat(self._checkDelayEffect, self, 0.05)
	end
end

function SurvivalUnitEntity:_checkDelayEffect()
	if not self._delayEffectDict then
		self:destroyCheckDelayEffectTimer()

		return
	end

	local now = Time.realtimeSinceStartup
	local waitRemoveList

	for effectPath, time in pairs(self._delayEffectDict) do
		if time <= now then
			self:removeEffect(effectPath)

			waitRemoveList = waitRemoveList or {}

			table.insert(waitRemoveList, effectPath)
		end
	end

	if waitRemoveList then
		for i = 1, #waitRemoveList do
			self._delayEffectDict[waitRemoveList[i]] = nil
		end
	end

	if tabletool.len(self._delayEffectDict) == 0 then
		self:destroyCheckDelayEffectTimer()
	end
end

function SurvivalUnitEntity:destroyCheckDelayEffectTimer()
	if self._delayEffectTimer then
		self._delayEffectTimer = nil

		TaskDispatcher.cancelTask(self._checkDelayEffect, self)
	end
end

function SurvivalUnitEntity:onDestroy()
	if self._allEffects then
		for _, loader in pairs(self._allEffects) do
			loader:dispose()
		end
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	TaskDispatcher.cancelTask(self.onTornadoTransferDone, self)
	TaskDispatcher.cancelTask(self._delayDestroy, self)

	if self._tweenModelShowId then
		ZProj.TweenHelper.KillById(self._tweenModelShowId)

		self._tweenModelShowId = nil
	end

	self._targetPos = nil
	self._callback = nil
	self._callObj = nil
	self.tempResPath = nil

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self:destroyCheckDelayEffectTimer()
end

return SurvivalUnitEntity
