-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/UnitCompHudTalking.lua

module("logicscene.scene.unit.component.hud.UnitCompHudTalking", package.seeall)

local UnitCompHudTalking = class("UnitCompHudTalking", UnitComponentBase)
local HUDRoot, UICamera, GameCamera, UICanvas

function UnitCompHudTalking:ctor(unit)
	UnitCompHudTalking.super.ctor(self, unit)

	if not HUDRoot then
		HUDRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

		SceneHudMgr.instance:setHudCacheParent(SceneHudMgr.HUD_TALKING, HUDRoot)
	end

	UICanvas = UICanvas or HUDRoot:GetComponent("Canvas")
	UICamera = UICamera or GlobalModel.instance.uiCameraGO:GetComponent("Camera")

	if not GameCamera then
		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

		GameCamera = mainCamera:getCamera()
	end

	self._hudObj = nil
end

function UnitCompHudTalking:onUnitVisible(go)
	self:_setHud()
end

function UnitCompHudTalking:onUnitInVisible(go)
	self:_recycleHud()
end

function UnitCompHudTalking:onDestroy()
	self:_recycleHud()
end

function UnitCompHudTalking:getHudObject()
	return self._hudObj
end

function UnitCompHudTalking:setActive(visible)
	if self._hudObj then
		-- block empty
	end
end

function UnitCompHudTalking:updateHud()
	if self._hudObj then
		-- block empty
	end
end

function UnitCompHudTalking:_setHud()
	if self._unit and not self._unit.isDestroyed and not self._unit:isClipping() then
		if not self._hudObj then
			local hudObj = SceneHudMgr.instance:getHud(SceneHudMgr.HUD_TALKING, self._onHudLoaded, self)

			if self._hudObj then
				self:setActive(self._unit:isVisible())

				return
			end

			self._hudObj = hudObj
		end

		if self._hudObj then
			self:_initFollowTarget()
			self._hudObj:SetActive(false)
			self:updateHud()
		end

		self:setActive(self._unit:isVisible())
	else
		self:_recycleHud()
	end
end

function UnitCompHudTalking:_recycleHud()
	removetimer(self.hideChatWord, self)

	if self._hudObj then
		SceneHudMgr.instance:recycle(SceneHudMgr.HUD_TALKING, self._hudObj)

		self._hudObj = nil
	end
end

function UnitCompHudTalking:_onHudLoaded(hudType, go)
	self._hudObj = go

	self:_setHud()
end

function UnitCompHudTalking:_initFollowTarget()
	self._hudObj.transform:SetParent(HUDRoot.transform)

	local ofsx, ofsy, ofsz = self._unit:getTalkingOffset()
	local followCom = self._hudObj:GetComponent(ComponentType.UIFollowTarget)

	followCom.uiCamera = UICamera
	followCom.gameCamera = GameCamera
	followCom.target = self._unit.go.transform
	followCom.canvas = UICanvas
	followCom.offsetX3D = ofsx
	followCom.offsetY3D = ofsy
	followCom.offsetZ3D = ofsz
	followCom.enabled = true

	Framework.TransformUtil.SetLocalPos(self._hudObj.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self._hudObj.transform, 1, 1, 1)

	self._Nego_Chat = goutil.findChild(self._hudObj, "Nego_Chat")

	self._Nego_Chat:SetActive(false)

	self._TxtC_Chat = goutil.findChild(self._Nego_Chat, "TxtC_Chat"):GetComponent("Text")
end

function UnitCompHudTalking:showChatWord(msg)
	if not string.nilorempty(msg) and self._hudObj then
		self._hudObj:SetActive(true)
		self._Nego_Chat:SetActive(true)

		self._TxtC_Chat.text = HyperlinkHandler.ChangeRichText(msg .. "\n")
	end
end

function UnitCompHudTalking:hideChatWord()
	if self._hudObj then
		self._hudObj:SetActive(false)
		self._Nego_Chat:SetActive(false)
	end
end

function UnitCompHudTalking:showAutoChatWord(msg)
	removetimer(self.hideChatWord, self)

	if self._hudObj and not string.nilorempty(msg) then
		self._hudObj:SetActive(true)
		self._Nego_Chat:SetActive(true)

		self._TxtC_Chat.text = HyperlinkHandler.ChangeRichText(msg .. "\n")

		settimer(2, self.hideChatWord, self, false)
	end
end

return UnitCompHudTalking
