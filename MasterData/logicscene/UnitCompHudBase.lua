-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/UnitCompHudBase.lua

module("logicscene.scene.unit.component.hud.UnitComponentBase", package.seeall)

local UnitCompHudBase = class("UnitCompHudBase", UnitComponentBase)
local HUDRoot, UICamera, GameCamera, UICanvas

function UnitCompHudBase:ctor(unit)
	UnitCompHudBase.super.ctor(self, unit)

	HUDRoot = HUDRoot or SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)
	UICanvas = UICanvas or HUDRoot:GetComponent("Canvas")
	UICamera = UICamera or GlobalModel.instance.uiCameraGO:GetComponent("Camera")

	if not GameCamera then
		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

		GameCamera = mainCamera:getCamera()
	end

	self._hudObj = nil
end

function UnitCompHudBase:onUnitVisible(go)
	self:_setHud()
end

function UnitCompHudBase:onUnitInVisible(go)
	self:_recycleHud()
end

function UnitCompHudBase:setActive(visible)
	if self._hudObj then
		self._hudObj:setActive(visible)
	end
end

function UnitCompHudBase:onDestroy()
	self:_recycleHud()
end

function UnitCompHudBase:_setHud()
	if self._unit and not self._unit.isDestroyed and not self._unit:isClipping() then
		if not self._hudObj then
			local resPath = self:_getResPath()

			if resPath then
				self._hudObj = self._unit.scene.resCache:newObject(resPath, self._onHudLoaded, self)
			end
		end

		if self._hudObj then
			self._hudObj:setActive(self._unit:isVisible())
			self:_updateHud()
		end
	else
		self:_recycleHud()
	end
end

function UnitCompHudBase:_recycleHud()
	if self._hudObj then
		self._unit.scene.resCache:recycleObject(self._hudObj)

		self._hudObj = nil
	end

	self._hudGameObject = nil
end

function UnitCompHudBase:_onHudLoaded()
	self._hudObj:setActive(self._unit:isVisible())
	self:_updateHud()
end

function UnitCompHudBase:setHudOffset(ofsX, ofsY, ofsZ)
	self._ofsX = ofsX or 0
	self._ofsY = ofsY or 0
	self._ofsZ = ofsZ or 0

	if self._hudObj and not goutil.isNil(self._hudObj.go) then
		local followCom = self._hudObj.go:GetComponent(ComponentType.UIFollowTarget)

		followCom.offsetX3D = self._ofsX
		followCom.offsetY3D = self._ofsY
		followCom.offsetZ3D = self._ofsZ
	end
end

function UnitCompHudBase:setHudScale(scale)
	self._scale = scale or 1

	if self._hudObj then
		self._hudObj:setScale(scale)
	end
end

function UnitCompHudBase:_updateHud()
	if not self._hudObj or goutil.isNil(self._hudObj.go) then
		return
	end

	local hudGo = self._hudObj.go

	hudGo.transform:SetParent(HUDRoot.transform)

	local followCom = hudGo:GetComponent(ComponentType.UIFollowTarget)

	followCom = followCom or hudGo:AddComponent(ComponentType.UIFollowTarget)
	followCom.uiCamera = UICamera
	followCom.gameCamera = GameCamera
	followCom.target = self._unit.go.transform
	followCom.canvas = UICanvas

	self:setHudOffset(self._ofsX, self._ofsY, self._ofsZ)
	self:setHudScale(self._scale)
	Framework.TransformUtil.SetLocalPos(hudGo.transform, 0, 0, 0)

	self._hudGameObject = hudGo

	self:_updateHudInfo(hudGo)

	followCom.enabled = true

	followCom:LateUpdate()
end

function UnitCompHudBase:_setFullScreenNodeParent()
	if not self._hudGameObject then
		return
	end

	local rootNode = ViewMgr.instance:getRoot(ViewRootType.FullScreen)

	self._hudGameObject.transform:SetParent(rootNode.transform)
	self._hudGameObject.transform:SetAsFirstSibling()
end

function UnitCompHudBase:_getResPath()
	return nil
end

function UnitCompHudBase:_updateHudInfo(hudGo)
	return
end

return UnitCompHudBase
