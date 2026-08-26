-- chunkname: @modules/logic/scene/shelter/entity/SurvivalShelterUnitEntity.lua

module("modules.logic.scene.shelter.entity.SurvivalShelterUnitEntity", package.seeall)

local SurvivalShelterUnitEntity = class("SurvivalShelterUnitEntity", LuaCompBase)

function SurvivalShelterUnitEntity:ctor(param)
	self.unitType = param.unitType
	self.unitId = param.unitId

	SurvivalMapHelper.instance:addShelterEntity(self.unitType, self.unitId, self)
	self:onCtor(param)
end

function SurvivalShelterUnitEntity:init(go)
	self.go = go
	self.trans = go.transform

	self:onInit()
	self:showEffect()
end

function SurvivalShelterUnitEntity:onLoadedEnd()
	self._isVisible = nil

	self:updateEntity()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterMapUnitAdd, self.unitType, self.unitId)
end

function SurvivalShelterUnitEntity:updateEntity(updateAll)
	self:refreshShow()
	self:onUpdateEntity()
	self:onChangeEntity(updateAll)
end

function SurvivalShelterUnitEntity:refreshShow()
	local isVisible = self:canShow()

	self:setVisible(isVisible)
end

function SurvivalShelterUnitEntity:setVisible(isVisible, force)
	if self._isVisible == isVisible and not force then
		return
	end

	self._isVisible = isVisible

	gohelper.setActive(self.goModel, self._isVisible)
	gohelper.setActive(self._effectRoot, self._isVisible)
end

function SurvivalShelterUnitEntity:isVisible()
	return self._isVisible
end

function SurvivalShelterUnitEntity:canShow()
	return true
end

function SurvivalShelterUnitEntity:onCtor(param)
	return
end

function SurvivalShelterUnitEntity:onInit()
	return
end

function SurvivalShelterUnitEntity:onUpdateEntity()
	return
end

function SurvivalShelterUnitEntity:needUI()
	return false
end

function SurvivalShelterUnitEntity:getFolowerTransform()
	if gohelper.isNil(self.goCenter) then
		local x, y, z = self:getCenterPos()

		self.goCenter = gohelper.create3d(self.trans.parent.gameObject, "center")
		self.transCenter = self.goCenter.transform

		local scale = self:getScale()

		transformhelper.setLocalPos(self.transCenter, x, 0.5 * scale, z)
		gohelper.addChildPosStay(self.go, self.goCenter)
	end

	return self.transCenter
end

function SurvivalShelterUnitEntity:getPos()
	return self.pos
end

function SurvivalShelterUnitEntity:getScale()
	return 1
end

function SurvivalShelterUnitEntity:getCenterPos()
	local pos = self:getPos()
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)

	return x, y, z
end

function SurvivalShelterUnitEntity:checkClick(hexPoint)
	if not self._isVisible then
		return false
	end

	return self:getPos() == hexPoint
end

function SurvivalShelterUnitEntity:isInPlayerPos()
	local scene = SurvivalMapHelper.instance:getScene()

	if not scene then
		return false
	end

	local player = scene.unit:getPlayer()

	return player:isInPos(self:getPos())
end

function SurvivalShelterUnitEntity:focusEntity(time, callback, callbackObj)
	local pos = self:getPos()

	if not pos then
		if callback then
			callback(callbackObj)
		end

		return
	end

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(x, y, z), time, callback, callbackObj)
end

function SurvivalShelterUnitEntity:onChangeEntity(updateAll)
	if updateAll then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterMapUnitChange, self.unitType)
	else
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterMapUnitChange, self.unitType, self.unitId)
	end
end

function SurvivalShelterUnitEntity:onDestroy()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterMapUnitDel, self.unitType, self.unitId)
end

function SurvivalShelterUnitEntity:getEffectPath()
	return nil
end

function SurvivalShelterUnitEntity:showEffect()
	self._effectPath = self:getEffectPath()

	if self._effectPath == nil then
		return
	end

	if gohelper.isNil(self._effectRoot) then
		self._effectRoot = gohelper.create3d(self.trans.gameObject, "EffectRoot")

		gohelper.setActive(self._effectRoot, false)
	end

	if not gohelper.isNil(self._goEffect) then
		return
	end

	if self._effectLoader then
		return
	end

	self._effectLoader = PrefabInstantiate.Create(self._effectRoot)

	self._effectLoader:startLoad(self._effectPath, self._onEffectResLoadEnd, self)
end

function SurvivalShelterUnitEntity:_onEffectResLoadEnd()
	local go = self._effectLoader:getInstGO()
	local trans = go.transform

	self._goEffect = go

	transformhelper.setLocalPos(trans, 0, 0, 0)
	transformhelper.setLocalRotation(trans, 0, 0, 0)
	transformhelper.setLocalScale(trans, 1, 1, 1)
	self:onEffectLoadedEnd()
	gohelper.setActive(self._effectRoot, self._isVisible)
end

function SurvivalShelterUnitEntity:onEffectLoadedEnd()
	return
end

return SurvivalShelterUnitEntity
