-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChannelChatTableView.lua

module("logic.extensions.chat.view.ChannelChatTableView", package.seeall)

local ChannelChatTableView = class("ChannelChatTableView", ChatTableView)

function ChannelChatTableView:ctor()
	ChannelChatTableView.super.ctor(self)

	self._viewName = ViewName.chat
end

function ChannelChatTableView:buildUI()
	ChannelChatTableView.super.buildUI(self)

	self._TxtC_Send = goutil.findChildTextComponent(self._Btn_Send, "TxtC_Send")
	self._Nego_VoiceSetting = self:getGo("Nego_Chat/Nego_Right/Nego_VoiceSetting")
	self._Nego_Bottom = self:getGo("Nego_Chat/Nego_Bottom")
	self._btnVoiceSetting = self:getBtn("Nego_Chat/Nego_Right/Nego_VoiceSetting/btnVoiceSetting")
	self._imgGou = goutil.findChild(self._btnVoiceSetting.btn.gameObject, "Checkmark")
	self._btnSkin = self:getBtn("Nego_Chat/Nego_Bottom/Btn_Skin")
	self._btnMicrophone = self:getBtn("Nego_Chat/Nego_Bottom/Btn_Microphone")
end

function ChannelChatTableView:_onClickSkin()
	FloatWordMgr.instance:show(ConstString.NotRelease)
end

function ChannelChatTableView:_onClickMicrophone()
	FloatWordMgr.instance:show(ConstString.NotRelease)
end

function ChannelChatTableView:bindEventsNew()
	ChannelChatTableView.super.bindEventsNew(self)
	GlobalDispatcher:addListener(GlobalNotify.ChatChannelChange, self.onChannelChange, self)
	self._btnVoiceSetting:AddClickListener(self._onClickVoiceSetting, self)
	self._btnMicrophone:AddClickListener(self._onClickMicrophone, self)
	self._btnSkin:AddClickListener(self._onClickSkin, self)
end

function ChannelChatTableView:unbindEventsNew()
	ChannelChatTableView.super.unbindEventsNew(self)
	GlobalDispatcher:removeListener(GlobalNotify.ChatChannelChange, self.onChannelChange, self)
	self._btnVoiceSetting:RemoveClickListener()
	self._btnSkin:RemoveClickListener()
	self._btnMicrophone:RemoveClickListener()
end

function ChannelChatTableView:onEnter()
	ChannelChatTableView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FormTeamJoinTeam, self._onJoinTeam, self)
	settimer(0.02, self._forceClickChannel, self, false)
end

function ChannelChatTableView:onExit()
	ChannelChatTableView.super.onExit(self)
	removetimer(self._forceClickChannel, self)
end

function ChannelChatTableView:_forceClickChannel()
	local channel = NewChatController.instance:getCurChannel()

	self:onChannelChange(channel)
end

function ChannelChatTableView:checkChannelLimit()
	return true
end

function ChannelChatTableView:checkEnoughAndSendMsg(text, msgType)
	local channel = self._channel
	local funcOpen = true

	if channel == GameEnum.ChatChannel.All then
		funcOpen = not ChatController.instance:checkIsAllLimit(channel)
	elseif channel == GameEnum.ChatChannel.League then
		funcOpen = FuncOpenModel.instance:getFuncIsOpen(60)
	end

	if not funcOpen then
		FloatWordMgr.instance:show(FuncOpenModel.instance:getFuncLockDescription(55))

		return
	end

	local function func(isFree)
		ViewMgr.instance:close(ViewName.ChatEmoji)
		self:sendMsg(self._channel, text, msgType, isFree)
	end

	local function toggleFunc(isOn)
		ChatSettingModel.instance:SetConumeNotice(self._channel, isOn)
		ChatAgent.instance:sendSetChatSettingsReq()
	end

	if self._channel == GameEnum.ChatChannel.Help then
		local chatTimes = FriendConfig.instance:getCommonValue("CHANNEL_ASK_FOR_HELP_LIMIT_DAILY_SEND_TIMES", true)
	end

	local sendMat = ChatConfig.instance:GetSendMat(self._channel)

	if not sendMat then
		func()
	elseif (self._channel == GameEnum.ChatChannel.World or self._channel == GameEnum.ChatChannel.Zone) and NewChatModel.instance:getUsedWorldChatFreeTimes() < VipModel.instance:getFreeTimesOfChatOnWorld() then
		func(true)
	elseif self._channel == GameEnum.ChatChannel.All and NewChatModel.instance:getAllChatFreeUseTimes() < VipModel.instance:getFreeTimesOfChatOnAll() then
		func()
	else
		local notice = ChatSettingModel.instance:GetConumeNotice(self._channel)
		local mat = sendMat[1]
		local cfg = ItemConfig.instance:getCfgById(mat.id)

		if not cfg then
			print("item config not found")

			return
		end

		local isEnough = MaterialModel.instance:IsEnough(mat.type, mat.id, mat.count)

		if not notice then
			if MaterialFacade.instance:checkMatEnough(mat.type, mat.id, mat.count) then
				func()
			end
		else
			local channelShortCut = ConstString.ChannelShortcut[self._channel]
			local isNotice = ChatSettingModel.instance:GetConumeNotice(self._channel)
			local matType = mat.type
			local matId = mat.id
			local matNum = mat.count
			local cfg = MaterialMgr.getMatCfg(matType, matId)
			local name = cfg and lang(cfg.name) or ""
			local content = string.format("在<color=#d44c28>%s</color>频道发言需要消耗<color=#d44c28>%s个%s</color>", channelShortCut, mat.count, lang(cfg.name))

			content = content .. string.format("<quad name=%s:%s size=70 width=1 offsetY=-10/>", matType, matId)

			TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
				if MaterialFacade.instance:checkMatEnough(mat.type, mat.id, mat.count) then
					func()
				end
			end, toggleFunc)
		end
	end
end

function ChannelChatTableView:_onClickVoiceSetting()
	local channel = NewChatController.instance:getCurChannel()
	local isOn = self._imgGou.activeSelf

	ChatSettingModel.instance:SetAutoVoice(channel, not isOn)
	goutil.setActive(self._imgGou, not isOn)

	local tips = lang(not isOn and "auto_voice_true" or "auto_voice_false")

	ChatAgent.instance:sendSetChatSettingsReq(function()
		FloatWordMgr.instance:show(string.format(tips, ConstString.Channel[channel]))
	end)
end

function ChannelChatTableView:onChannelChange(channel)
	self:initChatRoom(channel)
	self._Nego_VoiceSetting:SetActive(channel ~= GameEnum.ChatChannel.System)

	local funcOpen = true

	if channel == GameEnum.ChatChannel.All then
		funcOpen = not ChatController.instance:checkIsAllLimit(channel)
	elseif channel == GameEnum.ChatChannel.League then
		funcOpen = FuncOpenModel.instance:getFuncIsOpen(60)
	end

	local sendGoActive = channel ~= GameEnum.ChatChannel.System and channel ~= GameEnum.ChatChannel.Camp and funcOpen

	self._Nego_Bottom:SetActive(sendGoActive)
	goutil.setActive(self._imgGou, ChatSettingModel.instance:GetAutoVoice(channel))
end

function ChannelChatTableView:_onJoinTeam()
	UIStateManager.instance:push(ViewName.FormTeamCurTeamView)
end

function ChannelChatTableView:_createItemChatNormal(data, go, tag)
	local item = self._itemChatMap[go.gameObject]

	if not item then
		item = ChannelItemChatNormal.New(go.gameObject, tag)
		self._itemChatMap[go.gameObject] = item
	else
		item:buildUIWithTag(tag)
	end

	item:setEffectClip(self, self._tableSrollRect)
	item:Refresh(data, self._viewName, self._nowTime)

	return item
end

return ChannelChatTableView
