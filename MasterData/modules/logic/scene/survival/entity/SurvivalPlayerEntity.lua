-- chunkname: @modules/logic/scene/survival/entity/SurvivalPlayerEntity.lua

module("modules.logic.scene.survival.entity.SurvivalPlayerEntity", package.seeall)

local SurvivalPlayerEntity = class("SurvivalPlayerEntity", SurvivalUnitEntity)

function SurvivalPlayerEntity.Create(playerMo, root)
	local go = gohelper.create3d(root, tostring(playerMo.pos))

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalPlayerEntity, playerMo)
end

function SurvivalPlayerEntity:init(go)
	SurvivalPlayerEntity.super.init(self, go)
	self:onWarmingAttrUpdate()
	gohelper.setActive(self._effectRoot, true)
end

function SurvivalPlayerEntity:getResPath()
	if self.tempResPath then
		return self.tempResPath
	end

	return self._unitMo:getResPath()
end

function SurvivalPlayerEntity:addEventListeners()
	SurvivalPlayerEntity.super.addEventListeners(self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnAttrUpdate, self._onAttrUpdate, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapCircleUpdate, self._checkIsInCircle, self)
end

function SurvivalPlayerEntity:removeEventListeners()
	SurvivalPlayerEntity.super.removeEventListeners(self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnAttrUpdate, self._onAttrUpdate, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapCircleUpdate, self._checkIsInCircle, self)
end

function SurvivalPlayerEntity:_onAttrUpdate(attrId)
	if attrId == SurvivalEnum.AttrType.NoWarning then
		self:onWarmingAttrUpdate()
	elseif attrId == SurvivalEnum.AttrType.Vehicle_Miasma or attrId == SurvivalEnum.AttrType.Vehicle_Morass or attrId == SurvivalEnum.AttrType.Vehicle_Magma or attrId == SurvivalEnum.AttrType.Vehicle_Ice or attrId == SurvivalEnum.AttrType.Vehicle_Water then
		self:_checkModelPath()
	end
end

function SurvivalPlayerEntity:onMoveBegin()
	if self._unitMo:isDefaultModel() then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_move)
	else
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local blockType = sceneMo:getBlockTypeByPos(self._unitMo.pos)

		if blockType == SurvivalEnum.UnitSubType.Water then
			AudioMgr.instance:trigger(AudioEnum3_1.Survival.PlayerMoveByWater)
		else
			AudioMgr.instance:trigger(AudioEnum3_1.Survival.PlayerMoveByCar)
		end
	end
end

function SurvivalPlayerEntity:onModelChange()
	AudioMgr.instance:trigger(AudioEnum3_1.Survival.PlayerChangeModel)
end

function SurvivalPlayerEntity:onMoveEnd()
	return
end

function SurvivalPlayerEntity:_onResLoadEnd()
	SurvivalPlayerEntity.super._onResLoadEnd(self)
	self:onWarmingAttrUpdate()

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if sceneMo:isHaveIceEvent() then
		self:playAnim("down_idle")
	end
end

function SurvivalPlayerEntity:onWarmingAttrUpdate()
	if not self._resGo then
		return
	end

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()
	local val = weekMo:getAttr(SurvivalEnum.AttrType.NoWarning)

	val = val == 1 and SurvivalConst.PlayerClipRate or 1

	if val == self._finalAlpha then
		return
	end

	self._finalAlpha = val

	if not self._tweenModelShowId and self._resGo and self._curShowRes then
		if self._finalAlpha == 1 then
			self:onTweenEnd()
		else
			self:initMats()
			self:onTween(1 - self._finalAlpha)
		end
	end
end

function SurvivalPlayerEntity:onPosChange(newPos)
	self._unitMo.pos = newPos

	self:_checkIsTop(newPos)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapPlayerPosChange)

	local showTargetPos = SurvivalMapModel.instance:getShowTargetPos()

	if showTargetPos then
		if showTargetPos == newPos then
			SurvivalMapModel.instance:setShowTarget()
		else
			local walkables = SurvivalMapModel.instance:getCurMapCo().walkables
			local path = SurvivalAStarFindPath.instance:findPath(newPos, showTargetPos, walkables)

			if not path then
				SurvivalMapModel.instance:setShowTarget()

				return
			end

			table.insert(path, 1, newPos)
			SurvivalMapHelper.instance:getScene().path:setPathListShow(path)
		end
	end

	self:_checkIsInCircle()
	self:_checkModelPath()
end

function SurvivalPlayerEntity:_checkIsInCircle()
	return
end

function SurvivalPlayerEntity:_checkIsTop(pos)
	if pos == self._unitMo.pos then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local list = sceneMo:getListByPos(pos)
		local isTop = true

		if list then
			for _, unitMo in ipairs(list) do
				if not string.nilorempty(unitMo:getResPath()) and unitMo.co and unitMo.co.subType ~= SurvivalEnum.UnitSubType.BlockEvent then
					isTop = false

					break
				end
			end
		end

		self:setIsInTop(isTop)
	end
end

function SurvivalPlayerEntity:transferTo(...)
	SurvivalPlayerEntity.super.transferTo(self, ...)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(self.x, self.y, self.z), 0.2)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_transmit)
end

function SurvivalPlayerEntity:_tweenToTarget(...)
	SurvivalPlayerEntity.super._tweenToTarget(self, ...)

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(self._targetPos.q, self._targetPos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(x, y, z), 0.3)
end

function SurvivalPlayerEntity:swapPos(pos, dir, callback, callObj)
	self:transferTo(pos, dir, callback, callObj)
end

function SurvivalPlayerEntity:flyTo(pos, dir, callback, callObj)
	self._targetPos = pos
	self._callback = callback
	self._callObj = callObj

	if self._unitMo.dir ~= dir then
		self._unitMo.dir = dir

		transformhelper.setLocalRotation(self._modelRoot.transform, 0, dir * 60, 0)
	end

	self:playAnim("run")
	self:addEffect(SurvivalConst.UnitEffectPath.Fly)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_move_fast)

	local dis = SurvivalHelper.instance:getDistance(pos, self._unitMo.pos)
	local time = dis * SurvivalConst.UnitEffectTime[SurvivalConst.UnitEffectPath.Fly]
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(self._targetPos.q, self._targetPos.r)

	self._tweenId = ZProj.TweenHelper.DOLocalMove(self.trans, x, y, z, time, self._flyEnd, self, nil, EaseType.Linear)
	self.x = x
	self.y = y
	self.z = z
end

function SurvivalPlayerEntity:_flyEnd()
	self:removeEffect(SurvivalConst.UnitEffectPath.Fly)
	self:onPosChange(self._targetPos)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_move_fast)
	self:playAnim("idle")

	self._targetPos = nil
	self._tweenId = nil

	self:_doCallback()

	if not self._tweenModelShowId then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateUnitIsShow, self._unitMo.id)
	end
end

function SurvivalPlayerEntity:beginTornadoTransfer()
	SurvivalPlayerEntity.super.beginTornadoTransfer(self)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnPlayerTornadoTransferBegin)
end

function SurvivalPlayerEntity:onTornadoTransferDone()
	SurvivalPlayerEntity.super.onTornadoTransferDone(self)
	SurvivalMapHelper.instance:tweenToHeroPosIfNeed()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnPlayerTornadoTransferEnd)
end

function SurvivalPlayerEntity:onDestroy()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_move_fast)
	TaskDispatcher.cancelTask(self._tweenToTarget, self)
	TaskDispatcher.cancelTask(self._delayTransfer2, self)
	TaskDispatcher.cancelTask(self._delayFinish, self)
end

return SurvivalPlayerEntity
