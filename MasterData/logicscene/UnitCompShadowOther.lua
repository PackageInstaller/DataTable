-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompShadowOther.lua

module("logicscene.scene.unit.component.UnitCompShadowOther", package.seeall)

local UnitCompShadowOther = class("UnitCompShadowOther", UnitComponentBase)

function UnitCompShadowOther:ctor(unit)
	UnitCompShadowOther.super.ctor(self, unit)

	self._shadowObject = nil
	self._posX, self._posY, self._posZ = 0, 0, 0
	self._rotationX, self._rotationY, self._rotationZ = 0, 180, 0
end

function UnitCompShadowOther:onInit()
	return
end

function UnitCompShadowOther:onDestroy()
	if self._shadowObject then
		self._shadowObject:SetActive(false)
		CommonObjectMgr.instance.shadowPool:returnObject(self._shadowObject)

		self._shadowObject = nil
	end
end

function UnitCompShadowOther:_onSpineLoaded()
	self:_createShadow()
end

function UnitCompShadowOther:_createShadow()
	if self._shadowObject then
		return
	end

	self._shadowObject = CommonObjectMgr.instance.shadowPool:fetchObject()

	GoUtil.SetVisible(self._shadowObject, true)
	Framework.GameObjectUtil.SetLayerRecursively(self._shadowObject, self._unit:getLayer())
	goutil.addChildToParent(self._shadowObject, self._unit.mountRoot:getEffectRoot())
	Framework.TransformUtil.SetLocalPos(self._shadowObject.transform, self._posX, self._posY, self._posZ)
	Framework.TransformUtil.SetLocalRotation(self._shadowObject.transform, self._rotationX, self._rotationY, self._rotationZ)
	goutil.setActive(self._shadowObject, true)
	self:_updateScale()

	self._shadowTrans = goutil.findChild(self._shadowObject, "shadow")

	self:onBridgeStateChange(self._isUnderBridge)
	self:onBridgeChange(self._onBridgeId, self._bridgeZPos)
end

function UnitCompShadowOther:setScale(scale)
	self._scale = scale

	self:_updateScale()
end

function UnitCompShadowOther:setLocalPos(posX, posY, posZ)
	if posX then
		self._posX = posX
	end

	if posY then
		self._posY = posY
	end

	if posZ then
		self._posZ = posZ
	end

	if self._shadowObject then
		Framework.TransformUtil.SetLocalPos(self._shadowObject.transform, self._posX, self._posY, self._posZ)
	end
end

function UnitCompShadowOther:setLocalRotation(ratationX, ratationY, ratationZ)
	if ratationX then
		self._rotationX = ratationX
	end

	if ratationY then
		self._rotationY = ratationY
	end

	if ratationZ then
		self._rotationZ = ratationZ
	end

	if self._shadowObject then
		Framework.TransformUtil.SetLocalRotation(self._shadowObject.transform, self._rotationX, self._rotationY, self._rotationZ)
	end
end

function UnitCompShadowOther:_updateScale()
	if self._shadowObject then
		if not self._scale then
			if self._unit.modelId then
				local scaleModel = CharacterConfig.instance:getModelCo(self._unit.modelId).followShadowScale

				if scaleModel and #scaleModel > 0 then
					Framework.TransformUtil.SetLocalScale(self._shadowObject.transform, scaleModel[1] * self._scale, scaleModel[2] * self._scale, (scaleModel[3] or 1) * self._scale)
				else
					Framework.TransformUtil.SetLocalScale(self._shadowObject.transform, self._scale, self._scale, self._scale)
				end
			else
				Framework.TransformUtil.SetLocalScale(self._shadowObject.transform, self._scale, self._scale, self._scale)
			end
		end
	end
end

function UnitCompShadowOther:onUnitVisible(go)
	if not self._shadowObject then
		self:_onSpineLoaded()
	end
end

function UnitCompShadowOther:onUnitInVisible(go)
	self:onDestroy()
end

function UnitCompShadowOther:setActive(visible)
	if self._shadowObject then
		self._shadowObject:SetActive(visible)
	end
end

function UnitCompShadowOther:onBridgeStateChange(isUnder)
	self._isUnderBridge = isUnder
end

function UnitCompShadowOther:onBridgeChange(bridgeId, zPos)
	self._bridgeZPos = zPos
	self._onBridgeId = bridgeId or 0

	if goutil.isNil(self._shadowTrans) == false then
		if self._onBridgeId == 0 or self._isUnderBridge then
			GoUtil.SetSortingOrder(self._shadowTrans, -500)
			Framework.TransformUtil.SetLocalPos(self._shadowTrans.transform, 0, 0, 0)
		else
			GoUtil.SetSortingOrder(self._shadowTrans, 0)
			self:_updateShadowZ()
		end
	end
end

function UnitCompShadowOther:lateUpdate()
	self:_updateShadowZ()
end

function UnitCompShadowOther:_updateShadowZ()
	if not self._isUnderBridge and self._bridgeZPos and self._onBridgeId and self._onBridgeId > 0 and goutil.isNil(self._shadowTrans) == false then
		local posX, posY, posZ = Framework.TransformUtil.GetPos(self._shadowTrans.transform, nil, nil, nil)

		Framework.TransformUtil.SetPos(self._shadowTrans.transform, posX, posY, self._bridgeZPos - 0.002)
	end
end

return UnitCompShadowOther
