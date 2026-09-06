-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/UnitCompHudOthersPlayer.lua

module("logicscene.scene.unit.component.hud.UnitCompHudOthersPlayer", package.seeall)

local UnitCompHudOthersPlayer = class("UnitCompHudOthersPlayer", UnitComponentBase)
local HUDRoot, UICamera, GameCamera, UICanvas

function UnitCompHudOthersPlayer:ctor(unit)
	UnitCompHudOthersPlayer.super.ctor(self, unit)

	if not HUDRoot then
		HUDRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

		SceneHudMgr.instance:setHudCacheParent(SceneHudMgr.HUD_OTHERS_PLAYER, HUDRoot)
	end

	UICanvas = UICanvas or HUDRoot:GetComponent("Canvas")
	UICamera = UICamera or GlobalModel.instance.uiCameraGO:GetComponent("Camera")

	if not GameCamera then
		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

		GameCamera = mainCamera:getCamera()
	end

	self._hudObj = nil
end

function UnitCompHudOthersPlayer:onUnitVisible(go)
	self:_setHud()
	GlobalDispatcher:addListener(GlobalNotify.OtherMsgAdd, self._SetChatWord, self)
end

function UnitCompHudOthersPlayer:onUnitInVisible(go)
	self:_recycleHud()
end

function UnitCompHudOthersPlayer:setActive(visible)
	if self._hudObj then
		self._hudObj:SetActive(visible)
	end
end

function UnitCompHudOthersPlayer:onDestroy()
	self:_recycleHud()
	GlobalDispatcher:removeListener(GlobalNotify.OtherMsgAdd, self._SetChatWord, self)
end

function UnitCompHudOthersPlayer:_getModel()
	return CityModel.instance
end

function UnitCompHudOthersPlayer:_setHud()
	local playerMo = self:_getModel():getPlayerMo(self._unit.id)

	if playerMo and self._unit and not self._unit.isDestroyed and not self._unit:isClipping() then
		if not self._hudObj then
			local hudObj = SceneHudMgr.instance:getHud(SceneHudMgr.HUD_OTHERS_PLAYER, self._onHudLoaded, self)

			if self._hudObj then
				self:setActive(self._unit:isVisible())

				return
			end

			self._hudObj = hudObj
		end

		if self._hudObj then
			self._hudObj.name = "player_" .. self._unit.id

			self:_initFollowTarget()
			self._hudObj:SetActive(true)
		end

		self:setActive(self._unit:isVisible())
	else
		self:_recycleHud()
	end
end

function UnitCompHudOthersPlayer:setupTitle(userVar)
	local id = userVar:getOriginVar(UserVarKey.CUR_TITLE) or 0

	if not self._hudObj then
		return
	end

	if not self._tilteEffView then
		local go = goutil.findChild(self._hudObj, "titlePoint")

		self._tilteEffView = TilteEffView.Get(go)
	end

	self._tilteEffView:setupTitle(id)
	self:setupAthenaBlessIcon(userVar)
end

function UnitCompHudOthersPlayer:setupNameFrame(userVar)
	if not self._hudObj then
		return
	end

	local vipFrame = userVar:getOriginVar(UserVarKey.NAME_FRAME) or 0
	local nameFrameId = userVar:getOriginVar(UserVarKey.NEW_NAME_FRAME) or 0
	local normalNameFrame = goutil.findChild(self._hudObj, "NameBg")
	local vipNameFrame = goutil.findChild(self._hudObj, "VipNameBg")
	local nameFrame = goutil.findChild(self._hudObj, "nameFrame")

	print("other vipFrame = " .. vipFrame)

	local isVip = vipFrame == 1
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

function UnitCompHudOthersPlayer:setupAthenaBlessIcon(userVar)
	if self._hudObj then
		local athenaIcon = goutil.findChild(self._hudObj, "athenaIcon")

		self._athenaBlessEffView = self._athenaBlessEffView or AthenaBlessEffView.Get(athenaIcon)

		local activityId = 0
		local level = 1
		local list = userVar:getOriginVar(UserVarKey.ATHENA_BLESS_LV) or {}
		local obj = list[1]

		if obj then
			activityId = obj.activityId
			level = obj.level
		end

		local isInTime = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.AthenaBless)
		local path, effectPath = AthenaBlessController.instance:getTargetLevelIconPath(activityId, level)

		goutil.setActive(athenaIcon, isInTime and not string.nilorempty(path))

		if athenaIcon.activeSelf then
			local realPath = GameUrl.getIconFolderUrl("athenabless", path)

			uGuiUtil.setSpriteToImage(athenaIcon, uGuiUtil.SpriteType.BigBg, realPath)
			self._athenaBlessEffView:playAthenaEffect(effectPath)
		else
			uGuiUtil.clearImage(athenaIcon)
			self._athenaBlessEffView:removeAthenaEffect()
		end
	end
end

function UnitCompHudOthersPlayer:_recycleHud()
	if self._hudObj then
		self._hudObj:SetActive(false)

		local athenaIcon = goutil.findChild(self._hudObj, "athenaIcon")

		uGuiUtil.clearImage(athenaIcon)

		local nameFrame = goutil.findChild(self._hudObj, "nameFrame")

		uGuiUtil.clearImage(nameFrame)
		SceneHudMgr.instance:recycle(SceneHudMgr.HUD_OTHERS_PLAYER, self._hudObj)

		self._hudObj = nil

		if self._tilteEffView then
			self._tilteEffView:clear()
		end

		self._tilteEffView = nil

		if self._athenaBlessEffView then
			self._athenaBlessEffView:removeAthenaEffect()
		end

		self._athenaBlessEffView = nil
	end
end

function UnitCompHudOthersPlayer:_onHudLoaded(hudType, go)
	self._hudObj = go

	self:_setHud()
end

function UnitCompHudOthersPlayer:setOffsetY3D(offsetY3D)
	self._offsetY3D = offsetY3D

	if offsetY3D and self._hudObj then
		local followCom = self._hudObj:GetComponent(ComponentType.UIFollowTarget)

		followCom.offsetY3D = self._offsetY3D
	end
end

function UnitCompHudOthersPlayer:setFollowTarget(followTarget)
	self._followTarget = followTarget

	if self._hudObj then
		self:_updateFollowTarget()
	end
end

function UnitCompHudOthersPlayer:_updateFollowTarget()
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

function UnitCompHudOthersPlayer:_initFollowTarget()
	self._hudObj.transform:SetParent(HUDRoot.transform)

	local followCom = self._hudObj:GetComponent(ComponentType.UIFollowTarget)

	self._followTargetComp = followCom
	followCom.uiCamera = UICamera
	followCom.gameCamera = GameCamera
	followCom.target = self._unit.go.transform
	followCom.canvas = UICanvas

	if self._offsetY3D then
		followCom.offsetY3D = self._offsetY3D
	end

	self:_updateFollowTarget()

	followCom.enabled = true

	Framework.TransformUtil.SetLocalPos(self._hudObj.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self._hudObj.transform, 1, 1, 1)

	local playerMo = self:_getModel():getPlayerMo(self._unit.id)

	if playerMo then
		if playerMo.name then
			local name = goutil.findChild(self._hudObj, "Name"):GetComponent("Text")
			local nameBg = goutil.findChild(self._hudObj, "NameBg"):GetComponent("RectTransform")

			name.text = playerMo.name

			local sizeDelta = nameBg.sizeDelta

			sizeDelta.x = name.preferredWidth + 50
			nameBg.sizeDelta = sizeDelta
		end

		self:setupTitle(playerMo.userVar)
		self:setupNameFrame(playerMo.userVar)
	end

	followCom:LateUpdate()

	self._Nego_Chat = goutil.findChild(self._hudObj, "Nego_Chat")

	self._Nego_Chat:SetActive(false)

	self._TxtC_Chat = goutil.findChild(self._Nego_Chat, "TxtC_Chat"):GetComponent("Text")
end

function UnitCompHudOthersPlayer:_SetChatWord(channelId, index, playerId)
	if channelId ~= GameEnum.ChatChannel.Nearby or playerId ~= tonumber(self._unit.id) then
		return
	end

	local data = ChatModel.instance:GetChannelMsg(channelId)[index]

	self._Nego_Chat:SetActive(true)

	self._TxtC_Chat.text = HyperlinkHandler.ChangeRichText(data:GetContent())

	removetimer(self._HideChatWord, self)
	settimer(3, self._HideChatWord, self, false)
end

function UnitCompHudOthersPlayer:_HideChatWord()
	self._Nego_Chat:SetActive(false)
end

return UnitCompHudOthersPlayer
