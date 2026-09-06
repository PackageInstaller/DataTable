-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/UnitCompHudCommon.lua

module("logicscene.scene.unit.component.hud.UnitCompHudCommon", package.seeall)

local UnitCompHudCommon = class("UnitCompHudCommon", UnitComponentBase)
local HUDRoot, UICamera, GameCamera, UICanvas

function UnitCompHudCommon:ctor(unit)
	UnitCompHudCommon.super.ctor(self, unit)

	self._hudType = unit:getUnitHudType()

	if not HUDRoot then
		HUDRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

		SceneHudMgr.instance:setHudCacheParent(self._hudType, HUDRoot)
	end

	UICanvas = UICanvas or HUDRoot:GetComponent("Canvas")
	UICamera = UICamera or GlobalModel.instance.uiCameraGO:GetComponent("Camera")

	if not GameCamera then
		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

		GameCamera = mainCamera:getCamera()
	end

	self._hudObj = nil
end

function UnitCompHudCommon:onUnitVisible(go)
	self:_setHud()
	GlobalDispatcher:addListener(GlobalNotify.OtherMsgAdd, self._setChatWord, self)
end

function UnitCompHudCommon:onUnitInVisible(go)
	self:_recycleHud()
	GlobalDispatcher:removeListener(GlobalNotify.OtherMsgAdd, self._setChatWord, self)
end

function UnitCompHudCommon:setActive(visible)
	if self._hudObj then
		self._hudObj:SetActive(visible)
	end
end

function UnitCompHudCommon:onDestroy()
	self:_recycleHud()
end

function UnitCompHudCommon:_setHud()
	if self._unit and not self._unit.isDestroyed and not self._unit:isClipping() then
		if not self._hudObj then
			local hudObj = SceneHudMgr.instance:getHud(self._hudType, self._onHudLoaded, self)

			if self._hudObj then
				self:setActive(self._unit:isVisible())

				return
			end

			self._hudObj = hudObj
		end

		if self._hudObj then
			self._hudObj.name = "hud_" .. self._unit.id

			self:_initFollowTarget()
			self._hudObj:SetActive(true)
		end

		self:setActive(self._unit:isVisible())
	else
		self:_recycleHud()
	end
end

function UnitCompHudCommon:_recycleHud()
	if self._hudObj then
		self._hudObj:SetActive(false)
		SceneHudMgr.instance:recycle(self._hudType, self._hudObj)

		self._hudObj = nil
	end
end

function UnitCompHudCommon:_onHudLoaded(hudType, go)
	self._hudObj = go

	self:_setHud()
end

function UnitCompHudCommon:setHudOffset(ofsX, ofsY, ofsZ)
	self._ofsX = ofsX
	self._ofsY = ofsY
	self._ofsZ = ofsZ
end

function UnitCompHudCommon:setOffsetY3D(offsetY3D)
	self._ofsY = offsetY3D

	if offsetY3D and self._hudObj then
		local followCom = self._hudObj:GetComponent(ComponentType.UIFollowTarget)

		followCom.offsetY3D = self._ofsY
	end
end

function UnitCompHudCommon:setHudSign(sign, scale)
	scale = scale or 0

	if scale == 0 then
		scale = 1
	end

	self._hudSignIndex = sign
	self._hudSignScale = scale

	if self._hudSign then
		self._hudSign.gameObject:SetActive(sign ~= nil and sign >= 0)

		if sign then
			self._hudSign:SetState(sign)
			Framework.TransformUtil.SetLocalScale(self._hudSign.transform, scale, scale, scale)
		end
	end
end

function UnitCompHudCommon:_initFollowTarget()
	if not self._hudObj then
		return
	end

	self._hudObj.transform:SetParent(HUDRoot.transform)

	local followCom = self._hudObj:GetComponent(ComponentType.UIFollowTarget)

	followCom.uiCamera = UICamera
	followCom.gameCamera = GameCamera
	followCom.target = self._unit.go.transform
	followCom.canvas = UICanvas

	local ofsX, ofsY, ofsZ = self._unit:getUnitHudOffset()

	ofsX = ofsX or self._ofsX
	ofsY = ofsY or self._ofsY
	ofsZ = ofsZ or self._ofsZ

	if ofsX then
		followCom.offsetX3D = ofsX
	end

	if ofsY then
		followCom.offsetY3D = ofsY
	end

	if ofsZ then
		followCom.offsetZ3D = ofsZ
	end

	Framework.TransformUtil.SetLocalPos(self._hudObj.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self._hudObj.transform, 1, 1, 1)

	local name = goutil.findChild(self._hudObj, "Name"):GetComponent("Text")
	local nameBg = goutil.findChild(self._hudObj, "NameBg"):GetComponent("RectTransform")
	local nameTxt = self._unit:getUnitName()

	name.text = nameTxt

	local sizeDelta = nameBg.sizeDelta

	sizeDelta.x = name.preferredWidth + 50
	nameBg.sizeDelta = sizeDelta

	if not nameTxt or nameTxt == "" or tostring(nameTxt) == "0" then
		nameBg.gameObject:SetActive(false)
		name.gameObject:SetActive(false)
	else
		nameBg.gameObject:SetActive(true)
		name.gameObject:SetActive(true)
	end

	local hudSign = goutil.findChild(self._hudObj, "Sign")

	self._Nego_Chat = goutil.findChild(self._hudObj, "Nego_Chat")

	if self._Nego_Chat then
		self._Nego_Chat:SetActive(false)

		self._TxtC_Chat = goutil.findChild(self._Nego_Chat, "TxtC_Chat"):GetComponent("Text")
	end

	if hudSign then
		self._hudSign = hudSign:GetComponent(ComponentType.UIImageSpriteChange)
	end

	if self._hudSign then
		Framework.TransformUtil.SetLocalPos(self._hudSign.transform, -sizeDelta.x * 0.5 + 4, 16, 0)
	end

	self:setHudSign(self._hudSignIndex, self._hudSignScale)

	followCom.enabled = true

	followCom:LateUpdate()
end

function UnitCompHudCommon:_setChatWord(channelId, index, playerId)
	if self._Nego_Chat then
		if channelId ~= GameEnum.ChatChannel.Nearby or playerId ~= tonumber(self._unit.id) then
			return
		end

		local data = ChatModel.instance:GetChannelMsg(channelId)[index]

		self._Nego_Chat:SetActive(true)

		self._TxtC_Chat.text = HyperlinkHandler.ChangeRichText(data:GetContent())

		removetimer(self._hideChatWord, self)
		settimer(3, self._hideChatWord, self, false)
	end
end

function UnitCompHudCommon:_hideChatWord()
	if self._Nego_Chat then
		self._Nego_Chat:SetActive(false)
	end
end

return UnitCompHudCommon
