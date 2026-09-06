-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompShadowForMainPlayer.lua

module("logicscene.scene.unit.component.UnitCompShadowForMainPlayer", package.seeall)

local UnitCompShadowForMainPlayer = class("UnitCompShadowForMainPlayer", UnitCompShadowOther)

function UnitCompShadowForMainPlayer:ctor(unit)
	UnitCompShadowForMainPlayer.super.ctor(self, unit)

	self._bridgeZPos = 0
	self._onBridgeId = 0
	self._oldCellType = 0
end

function UnitCompShadowForMainPlayer:onInit()
	GlobalDispatcher:addListener(GlobalNotify.HardwareQualityChanged, self._onHardwareQualityChanged, self)

	self._shadowQualityLv = HardwareQuality.getQualityLevel()
	self._spine = self._unit.spine

	if self._spine then
		self._spine:addListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)
	end

	UnitCompShadowForMainPlayer.super.onInit(self)
end

function UnitCompShadowForMainPlayer:onDestroy()
	GlobalDispatcher:removeListener(GlobalNotify.HardwareQualityChanged, self._onHardwareQualityChanged, self)

	if self._shadowQualityLv == 0 then
		self:_destroyMainPlayerShadow()
	else
		UnitCompShadowForMainPlayer.super.onDestroy(self)
	end
end

function UnitCompShadowForMainPlayer:_onSpineLoaded()
	self._spine:removeListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)

	if self._shadowQualityLv == 0 then
		self:_createMainPlayerShadow()
	else
		UnitCompShadowForMainPlayer.super._onSpineLoaded(self)
	end
end

function UnitCompShadowForMainPlayer:_createMainPlayerShadow()
	local shadowPrefab = CommonPreloader.instance:getSkinlibAsset(CommonResPath.MainPlayerShadow)

	if goutil.isNil(shadowPrefab) then
		printError("加载主角阴影预制失败，path=" .. CommonResPath.MainPlayerShadow)
	else
		self._shadowObject = goutil.cloneAndSetParent(shadowPrefab, self._unit.mountRoot:getEffectRoot().transform)

		goutil.setActive(self._shadowObject, true)

		self._shadowTrans = goutil.findChild(self._shadowObject, "shadow")
		self._shadowWaterTrans = goutil.findChild(self._shadowObject, "shadow_water")

		self:onBridgeStateChange(self._isUnderBridge)
		self:onBridgeChange(self._onBridgeId, self._bridgeZPos)
	end
end

function UnitCompShadowForMainPlayer:_destroyMainPlayerShadow()
	if goutil.isNil(self._shadowObject) == false then
		goutil.destroy(self._shadowObject)

		self._shadowObject = nil
	end

	self._shadowTrans = nil
	self._shadowWaterTrans = nil
end

function UnitCompShadowForMainPlayer:setActive(visible)
	UnitCompShadowForMainPlayer.super.setActive(self, visible)
end

function UnitCompShadowForMainPlayer:_onHardwareQualityChanged(resolution)
	if self._shadowQualityLv ~= resolution then
		self._shadowQualityLv = resolution

		if self._shadowQualityLv == 0 then
			UnitCompShadowForMainPlayer.super.onDestroy(self)
			self:_createMainPlayerShadow()
		else
			self:_destroyMainPlayerShadow()
			UnitCompShadowForMainPlayer.super._createShadow(self)
		end
	end
end

function UnitCompShadowForMainPlayer:onBridgeStateChange(isUnder)
	self._isUnderBridge = isUnder
end

function UnitCompShadowForMainPlayer:onBridgeChange(bridgeId, zPos)
	if self._shadowQualityLv ~= 0 then
		UnitCompShadowForMainPlayer.super.onBridgeChange(self, bridgeId, zPos)

		return
	end

	self._bridgeZPos = zPos
	self._onBridgeId = bridgeId

	if goutil.isNil(self._shadowTrans) == false then
		Framework.TransformUtil.SetLocalPos(self._shadowTrans.transform, -0.04, -0.04, 0)

		if bridgeId == 0 or self._isUnderBridge then
			GoUtil.SetSortingOrder(self._shadowTrans, -500)
		else
			GoUtil.SetSortingOrder(self._shadowTrans, 0)
			self:_updateShadowZ()
		end
	end
end

function UnitCompShadowForMainPlayer:clearBridgeState()
	self._isUnderBridge = false
	self._bridgeZPos = nil
	self._onBridgeId = nil

	if goutil.isNil(self._shadowTrans) == false then
		GoUtil.SetSortingOrder(self._shadowTrans, -500)

		if self._shadowQualityLv ~= 0 then
			Framework.TransformUtil.SetLocalPos(self._shadowTrans.transform, 0, 0, 0)

			return
		end

		Framework.TransformUtil.SetLocalPos(self._shadowTrans.transform, -0.04, -0.04, 0)
	end
end

function UnitCompShadowForMainPlayer:setScale(scale)
	if self._shadowQualityLv ~= 0 then
		UnitCompShadowForMainPlayer.super.setScale(self, scale)

		return
	end
end

function UnitCompShadowForMainPlayer:setLocalPos(posX, posY, posZ)
	if self._shadowQualityLv ~= 0 then
		UnitCompShadowForMainPlayer.super.setLocalPos(self, posX, posY, posZ)

		return
	end
end

function UnitCompShadowForMainPlayer:lateUpdate()
	if self._shadowQualityLv ~= 0 then
		UnitCompShadowForMainPlayer.super.lateUpdate(self)

		return
	end

	self:_updateShadowZ()
end

function UnitCompShadowForMainPlayer:_updateShadowZ()
	if self._shadowQualityLv ~= 0 then
		UnitCompShadowForMainPlayer.super._updateShadowZ(self)

		return
	end

	if not self._isUnderBridge and self._bridgeZPos and self._onBridgeId and self._onBridgeId > 0 and goutil.isNil(self._shadowTrans) == false then
		local posX, posY, posZ = Framework.TransformUtil.GetPos(self._shadowTrans.transform, nil, nil, nil)

		Framework.TransformUtil.SetPos(self._shadowTrans.transform, posX, posY, self._bridgeZPos - 0.002)
	end
end

function UnitCompShadowForMainPlayer:updateShadowState(_cellType)
	if not _cellType then
		return
	end

	if goutil.isNil(self._shadowWaterTrans) == false and self._oldCellType ~= _cellType then
		if _cellType == GameEnum.FootStep.WATER then
			self._shadowWaterTrans.gameObject:SetActive(true)
		else
			self._shadowWaterTrans.gameObject:SetActive(false)
		end

		self._oldCellType = _cellType
	end
end

function UnitCompShadowForMainPlayer:getOldCellType()
	return self._oldCellType
end

return UnitCompShadowForMainPlayer
