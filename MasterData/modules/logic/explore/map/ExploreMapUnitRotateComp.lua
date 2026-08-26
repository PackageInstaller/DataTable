-- chunkname: @modules/logic/explore/map/ExploreMapUnitRotateComp.lua

module("modules.logic.explore.map.ExploreMapUnitRotateComp", package.seeall)

local ExploreMapUnitRotateComp = class("ExploreMapUnitRotateComp", ExploreMapBaseComp)

function ExploreMapUnitRotateComp:onInit()
	self._curRotateUnit = nil
	self._btnLeft = nil
	self._btnRight = nil
	self._anim = nil
	self._containerGO = gohelper.create3d(self._mapGo, "RotateComp")

	gohelper.setActive(self._containerGO, false)

	self._loader = PrefabInstantiate.Create(self._containerGO)

	self._loader:startLoad("modules/explore/common/sprite/prefabs/msts_icon_xuanzhuan.prefab", self._onLoaded, self)
end

function ExploreMapUnitRotateComp:_onLoaded()
	local go = self._loader:getInstGO()

	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._btnLeft = gohelper.findChild(go, "right").transform
	self._btnRight = gohelper.findChild(go, "left").transform
end

function ExploreMapUnitRotateComp:addEventListeners()
	self.addEventCb(self, ExploreController.instance, ExploreEvent.SetRotateUnit, self.changeStatus, self)
end

function ExploreMapUnitRotateComp:removeEventListeners()
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.SetRotateUnit, self.changeStatus, self)
end

function ExploreMapUnitRotateComp:changeStatus(unit)
	if not self:beginStatus() then
		return
	end

	self:setRotateUnit(unit)
end

function ExploreMapUnitRotateComp:setRotateUnit(unit)
	if self._curRotateUnit == unit then
		return
	end

	if self._curRotateUnit then
		self._curRotateUnit:endRotate()
	end

	self._curRotateUnit = unit

	if self._curRotateUnit then
		self._curRotateUnit:beginRotate()
	end

	if self._curRotateUnit then
		self:roleMoveToUnit(self._curRotateUnit)
		self:_setViewShow(true)

		self._containerGO.transform.position = self._curRotateUnit:getPos()
	else
		self:_setViewShow(false)
	end
end

function ExploreMapUnitRotateComp:onMapClick(mousePosition)
	if self._isRoleMoving then
		return
	end

	if self._isRotating then
		return
	end

	local hitTrans = self._map:getHitTriggerTrans()

	if hitTrans then
		if hitTrans:IsChildOf(self._btnLeft) then
			return self:doRotate(false)
		elseif hitTrans:IsChildOf(self._btnRight) then
			return self:doRotate(true)
		end
	end

	self:roleMoveBack()
end

function ExploreMapUnitRotateComp:roleMoveToUnit(unit)
	self._isRoleMoving = true

	local hero = self:getHero()
	local dir = ExploreHelper.xyToDir(unit.nodePos.x - hero.nodePos.x, unit.nodePos.y - hero.nodePos.y)
	local finalPos = (hero:getPos() - unit:getPos()):SetNormalize():Mul(0.6):Add(unit:getPos())

	hero:setTrOffset(dir, finalPos, nil, self.onRoleMoveToUnitEnd, self)
	hero:setMoveSpeed(0.3)
end

function ExploreMapUnitRotateComp:onRoleMoveToUnitEnd()
	self._isRoleMoving = false

	self:getHero():setMoveSpeed(0)
end

function ExploreMapUnitRotateComp:getHero()
	return ExploreController.instance:getMap():getHero()
end

function ExploreMapUnitRotateComp:_setViewShow(isShow)
	TaskDispatcher.cancelTask(self._onCloseAnimEnd, self)

	if self._anim then
		if isShow then
			self._anim:Play("open", 0, 0)
			gohelper.setActive(self._containerGO, true)
		else
			self._anim:Play("close", 0, 0)
			TaskDispatcher.runDelay(self._onCloseAnimEnd, self, 0.167)
		end
	else
		gohelper.setActive(self._containerGO, isShow)
	end
end

function ExploreMapUnitRotateComp:_onCloseAnimEnd()
	gohelper.setActive(self._containerGO, false)
end

function ExploreMapUnitRotateComp:onRoleMoveBackEnd()
	self:getHero():setMoveSpeed(0)

	self._isRoleMoving = false

	self._map:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function ExploreMapUnitRotateComp:roleMoveBack()
	self._isRoleMoving = true

	self:setRotateUnit(nil)

	local hero = self:getHero()
	local finalPos = hero:getPos()

	hero:setMoveSpeed(0.3)
	hero:setTrOffset(nil, finalPos, nil, self.onRoleMoveBackEnd, self)
end

function ExploreMapUnitRotateComp:canSwitchStatus(toStatus)
	if toStatus == ExploreEnum.MapStatus.UseItem then
		return false
	end

	if self._isRoleMoving or self._isRotating then
		return false
	end

	return true
end

local paramsFormat = ExploreEnum.TriggerEvent.Rotate .. "#%d"

function ExploreMapUnitRotateComp:doRotate(isReverse)
	local stepIndex = 0
	local rotateAngle = 0

	for k, v in pairs(self._curRotateUnit.mo.triggerEffects) do
		if v[1] == ExploreEnum.TriggerEvent.Rotate then
			stepIndex = k
			rotateAngle = 1

			if isReverse then
				rotateAngle = -rotateAngle
			end

			break
		end
	end

	if stepIndex <= 0 then
		return
	end

	self._isRotating = true
	self._isReverse = isReverse

	self:_setViewShow(false)
	ExploreRpc.instance:sendExploreInteractRequest(self._curRotateUnit.id, stepIndex, string.format(paramsFormat, rotateAngle), self.onRotateRecv, self)
end

function ExploreMapUnitRotateComp:onRotateRecv(cmd, resultCode, msg)
	if resultCode ~= 0 then
		self._isRotating = false

		self:_setViewShow(true)
	end
end

function ExploreMapUnitRotateComp:rotateByServer(unitId, finalDir, callback, callObj)
	local map = ExploreController.instance:getMap()

	if not self._curRotateUnit or self._curRotateUnit.id ~= unitId then
		local unit = map:getUnit(unitId)

		if unit then
			unit:_onFrameRotate(finalDir)
		end

		if callback then
			callback(callObj)
		end

		return
	end

	local hero = map:getHero()

	hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.RotateInteract, true, true)

	self._fromRotate = self._curRotateUnit.mo.unitDir
	self._toRotate = finalDir

	if self._isReverse then
		while self._fromRotate < self._toRotate do
			self._fromRotate = self._fromRotate + 360
		end

		while self._fromRotate > self._toRotate + 360 do
			self._fromRotate = self._fromRotate - 360
		end
	else
		while self._fromRotate > self._toRotate do
			self._fromRotate = self._fromRotate - 360
		end

		while self._fromRotate < self._toRotate - 360 do
			self._fromRotate = self._fromRotate + 360
		end
	end

	self._curRotateUnit:_onFrameRotate(self._fromRotate)

	self._rotateEndCallBack = callback
	self._rotateEndCallBackObj = callObj

	self._curRotateUnit:setEmitLight(true)
	TaskDispatcher.runDelay(self._rotateUnit, self, 0.2)
end

function ExploreMapUnitRotateComp:_rotateUnit()
	AudioMgr.instance:trigger(AudioEnum.Explore.UnitRotate)
	self._curRotateUnit:doRotate(self._fromRotate, self._toRotate, 0.2, self._unitRotateEnd, self)
end

function ExploreMapUnitRotateComp:_unitRotateEnd()
	if self._curRotateUnit then
		self._curRotateUnit:setEmitLight(false)
	end

	self:_setViewShow(true)

	self._isRotating = false

	if self._rotateEndCallBack then
		self._rotateEndCallBack(self._rotateEndCallBackObj)
	end
end

function ExploreMapUnitRotateComp:onStatusEnd()
	self:setRotateUnit(nil)
end

function ExploreMapUnitRotateComp:onDestroy()
	TaskDispatcher.cancelTask(self._onCloseAnimEnd, self)
	TaskDispatcher.cancelTask(self._rotateUnit, self)

	self._rotateEndCallBack = nil
	self._rotateEndCallBackObj = nil
	self._curRotateUnit = nil
	self._btnLeft = nil
	self._btnRight = nil

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	gohelper.destroy(self._containerGO)

	self._containerGO = nil

	ExploreMapUnitRotateComp.super.onDestroy(self)
end

return ExploreMapUnitRotateComp
