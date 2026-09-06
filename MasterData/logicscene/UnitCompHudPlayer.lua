-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/UnitCompHudPlayer.lua

module("logicscene.scene.unit.component.hud.UnitCompHudPlayer", package.seeall)

local UnitCompHudPlayer = class("UnitCompHudPlayer", UnitComponentBase)
local HUDRoot, UICamera, GameCamera, UICanvas
local UIFollowTargetComp = ComponentType.UIFollowTarget

function UnitCompHudPlayer:ctor(unit)
	UnitCompHudPlayer.super.ctor(self, unit)

	HUDRoot = HUDRoot or SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)
	UICanvas = UICanvas or HUDRoot:GetComponent("Canvas")
	UICamera = UICamera or GlobalModel.instance.uiCameraGO:GetComponent("Camera")

	if not GameCamera then
		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

		GameCamera = mainCamera:getCamera()
	end

	self._hudObj = nil
end

function UnitCompHudPlayer:onUnitVisible(go)
	self:_setHud()
	GlobalDispatcher:addListener(GlobalNotify.TitleUpdate, self.setupTitle, self)
	GlobalDispatcher:addListener(GlobalNotify.MyMsgAdd, self._SetChatWord, self)
	GlobalDispatcher:addListener(GlobalNotify.BroadcastCurVipLevel, self.setupNameFrame, self)
	GlobalDispatcher:addListener(GlobalNotify.AthenaBlessGetInfo, self.updateAthenaBlessIcon, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateNameFrame, self._updateNameFrame, self)
end

function UnitCompHudPlayer:onUnitInVisible(go)
	self:_recycleHud()
end

function UnitCompHudPlayer:onDestroy()
	self:_recycleHud()
	GlobalDispatcher:removeListener(GlobalNotify.MyMsgAdd, self._SetChatWord, self)
	GlobalDispatcher:removeListener(GlobalNotify.TitleUpdate, self.setupTitle, self)
	GlobalDispatcher:removeListener(GlobalNotify.BroadcastCurVipLevel, self.setupNameFrame, self)
	GlobalDispatcher:removeListener(GlobalNotify.AthenaBlessGetInfo, self.updateAthenaBlessIcon, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateNameFrame, self._updateNameFrame, self)
end

function UnitCompHudPlayer:setActive(visible)
	if self._hudObj then
		self._hudObj:SetActive(visible)
	end
end

function UnitCompHudPlayer:updateUserName()
	if self._hudObj then
		local usrName = RoleModel.instance:getUserName()

		if usrName then
			local name = goutil.findChild(self._hudObj, "Name"):GetComponent("Text")
			local nameBg = goutil.findChild(self._hudObj, "NameBg"):GetComponent("RectTransform")

			name.text = usrName

			local sizeDelta = nameBg.sizeDelta

			sizeDelta.x = name.preferredWidth + 50
			nameBg.sizeDelta = sizeDelta
		end
	end
end

function UnitCompHudPlayer:updateAthenaBlessIcon()
	if self._hudObj then
		local athenaIcon = goutil.findChild(self._hudObj, "athenaIcon")

		self._athenaBlessEffView = self._athenaBlessEffView or AthenaBlessEffView.Get(athenaIcon)

		local isInTime = AthenaBlessModel.instance:isInActivityTime()

		if isInTime then
			local path, effectPath = AthenaBlessController.instance:curLevelIconPath()

			goutil.setActive(athenaIcon, isInTime and not string.nilorempty(path))

			if athenaIcon.activeSelf then
				local realPath = GameUrl.getIconFolderUrl("athenabless", path)

				uGuiUtil.setSpriteToImage(athenaIcon, uGuiUtil.SpriteType.BigBg, realPath)
			end

			self._athenaBlessEffView:playAthenaEffect(effectPath)
		else
			uGuiUtil.clearImage(athenaIcon)
			self._athenaBlessEffView:removeAthenaEffect()
		end
	end
end

function UnitCompHudPlayer:setupTitle(id)
	if not self._hudObj then
		return
	end

	if not self._tilteEffView then
		local go = goutil.findChild(self._hudObj, "titlePoint")

		self._tilteEffView = TilteEffView.Get(go)
	end

	self._tilteEffView:setupTitle(id)
end

function UnitCompHudPlayer:setupNameFrame()
	local isVip = VipModel.instance:getIsAbleToUseVipNameBoard()
	local normalNameFrame = goutil.findChild(self._hudObj, "NameBg")
	local vipNameFrame = goutil.findChild(self._hudObj, "VipNameBg")
	local nameFrame = goutil.findChild(self._hudObj, "nameFrame")
	local nameFrameId = BattleStartAnimModel.instance:getUsingItemId(MatType.NameFrame)
	local cfg = BattleStartAnimConfig.instance:getNameFrame(nameFrameId)

	if cfg and not string.nilorempty(cfg.icon) and nameFrameId > 1 then
		goutil.setActive(normalNameFrame, false)
		goutil.setActive(vipNameFrame, false)
		goutil.setActive(nameFrame, true)
		uGuiUtil.setSpriteToImage(nameFrame, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("nameframe", cfg.icon))
	else
		goutil.setActive(normalNameFrame, not isVip)
		goutil.setActive(vipNameFrame, isVip)
		goutil.setActive(nameFrame, false)
	end
end

function UnitCompHudPlayer:_updateNameFrame()
	printInfo("test _updateNameFrame")
	self:setupNameFrame()
end

function UnitCompHudPlayer:setOffsetY3D(offsetY3D)
	self._offsetY3D = offsetY3D

	if self._hudObj then
		self:_updateFollowTarget()
	end
end

function UnitCompHudPlayer:setFollowTarget(followTarget)
	print("main player set follow target")

	self._followTarget = followTarget

	if self._hudObj then
		self:_updateFollowTarget()
	end
end

function UnitCompHudPlayer:_updateFollowTarget()
	if self._followTargetComp then
		if self._followTarget then
			self._followTargetComp.target = self._followTarget
			self._followTargetComp.offsetY3D = 0
		else
			self._followTargetComp.target = self._unit.go.transform

			if self._offsetY3D then
				self._followTargetComp.offsetY3D = self._offsetY3D
			end
		end
	end
end

function UnitCompHudPlayer:_setHud()
	if self._unit and not self._unit.isDestroyed and not self._unit:isClipping() then
		if not self._hudObj then
			local hudObj = SceneHudMgr.instance:getHud(SceneHudMgr.HUD_PLAYER, self._onHudLoaded, self)

			if self._hudObj then
				self:setActive(self._unit:isVisible())

				return
			end

			self._hudObj = hudObj
		end

		if self._hudObj then
			self:_initFollowTarget()
			self._hudObj:SetActive(true)
			self:updateUserName()
			self:setupTitle(TitleModel.instance:getCurTitleId())
			self:setupNameFrame()
			self:updateAthenaBlessIcon()
		end

		self:setActive(self._unit:isVisible())
	else
		self:_recycleHud()
	end
end

function UnitCompHudPlayer:_recycleHud()
	if self._hudObj then
		local athenaIcon = goutil.findChild(self._hudObj, "athenaIcon")

		uGuiUtil.clearImage(athenaIcon)

		local nameFrame = goutil.findChild(self._hudObj, "nameFrame")

		uGuiUtil.clearImage(nameFrame)

		if self._athenaBlessEffView then
			self._athenaBlessEffView:removeAthenaEffect()
		end

		self._athenaBlessEffView = nil

		SceneHudMgr.instance:recycle(SceneHudMgr.HUD_PLAYER, self._hudObj)

		self._hudObj = nil
		self._followTargetComp = nil

		if self._tilteEffView then
			self._tilteEffView:clear()
		end

		self._tilteEffView = nil
	end
end

function UnitCompHudPlayer:_onHudLoaded(hudType, go)
	self._hudObj = go

	self:_setHud()
end

function UnitCompHudPlayer:_initFollowTarget()
	self._hudObj.transform:SetParent(HUDRoot.transform)

	local followCom = self._hudObj:GetComponent(UIFollowTargetComp)

	self._followTargetComp = followCom
	followCom.uiCamera = UICamera
	followCom.gameCamera = GameCamera
	followCom.canvas = UICanvas

	self:_updateFollowTarget()

	followCom.enabled = true

	Framework.TransformUtil.SetLocalPos(self._hudObj.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self._hudObj.transform, 1, 1, 1)

	self._Nego_Chat = goutil.findChild(self._hudObj, "Nego_Chat")

	self._Nego_Chat:SetActive(false)

	self._TxtC_Chat = goutil.findChild(self._Nego_Chat, "TxtC_Chat"):GetComponent("Text")
end

function UnitCompHudPlayer:_SetChatWord(channelId, index, playerId)
	if channelId ~= GameEnum.ChatChannel.Nearby then
		return
	end

	local data = ChatModel.instance:GetChannelMsg(channelId)[index]

	self._Nego_Chat:SetActive(true)

	self._TxtC_Chat.text = HyperlinkHandler.ChangeRichText(data:GetContent())

	removetimer(self._HideChatWord, self)
	settimer(3, self._HideChatWord, self, false)
end

function UnitCompHudPlayer:_HideChatWord()
	self._Nego_Chat:SetActive(false)
end

return UnitCompHudPlayer
