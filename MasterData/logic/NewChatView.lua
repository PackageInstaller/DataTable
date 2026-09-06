-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/NewChatView.lua

module("logic.extensions.newchat.view.NewChatView", package.seeall)

local NewChatView = class("NewChatView", ViewComponent)
local FamilyFuncOpenId = 60
local ChannelAnim = {
	[GameEnum.ChatChannel.Zone] = "chat_channel_world",
	[GameEnum.ChatChannel.All] = "chat_channel_world",
	[GameEnum.ChatChannel.World] = "chat_channel_world",
	[GameEnum.ChatChannel.League] = "chat_channel_world",
	[GameEnum.ChatChannel.Nearby] = "chat_channel_world",
	[GameEnum.ChatChannel.System] = "chat_channel_system",
	[GameEnum.ChatChannel.Battle] = "chat_channel_world",
	[GameEnum.ChatChannel.Share] = "chat_channel_system",
	[GameEnum.ChatChannel.Camp] = "chat_channel_system",
	[GameEnum.ChatChannel.Help] = "chat_channel_system",
	[GameEnum.ChatChannel.GoddessContest] = "chat_channel_world",
	[GameEnum.ChatChannel.Team] = "chat_channel_world",
	[GameEnum.ChatChannel.GoddessCompetition] = "chat_channel_world",
	[GameEnum.ChatChannel.Luyngarde] = "chat_channel_world",
	[GameEnum.ChatChannel.LanternFestival] = "chat_channel_system"
}

NewChatView.TipsChannel = {
	GameEnum.ChatChannel.All,
	GameEnum.ChatChannel.League
}

function NewChatView:ctor()
	NewChatView.super.ctor(self)
end

function NewChatView:buildUI()
	self._closeButton = self:getBtn("Btn_Close")
	self._closeBtn2 = self:getBtn("Nego_Chat/btnSmallClose")
	self._Btn_Zone = self:getBtn("Nego_Chat/Nego_Left/Btn_Zone")
	self._Btn_All = self:getBtn("Nego_Chat/Nego_Left/Btn_All")
	self._Btn_World = self:getBtn("Nego_Chat/Nego_Left/Btn_World")
	self._Btn_League = self:getBtn("Nego_Chat/Nego_Left/Btn_League")
	self._Btn_Nearby = self:getBtn("Nego_Chat/Nego_Left/Btn_Nearby")
	self._Btn_System = self:getBtn("Nego_Chat/Nego_Left/Btn_System")
	self._Btn_Battle = self:getBtn("Nego_Chat/Nego_Left/Btn_Battle")
	self._Nego_NoLeague = self:getGo("Nego_Chat/Nego_Right/Nego_NoLeague")
	self._Btn_Setting = self:getBtn("Nego_Chat/Nego_Left/Btn_Setting")
	self._btnShare = self:getBtn("Nego_Chat/Nego_Left/Btn_Share")
	self._Btn_Camp = self:getBtn("Nego_Chat/Nego_Left/Btn_Camp")
	self._Btn_Goddess = self:getBtn("Nego_Chat/Nego_Left/Btn_Goddess")
	self._Btn_GoddessCompetition = self:getBtn("Nego_Chat/Nego_Left/Btn_GoddessCompetition")
	self._Btn_Luyngarde = self:getBtn("Nego_Chat/Nego_Left/Btn_Luyngarde")
	self._Btn_LanternFestival = self:getBtn("Nego_Chat/Nego_Left/Btn_LanternFestival")
	self._Btn_Team = self:getBtn("Nego_Chat/Nego_Left/Btn_Team")
	self._Btn_ElementSpark = self:getBtn("Nego_Chat/Nego_Left/Btn_ElementSpark")
	self._Btn_Help = self:getBtn("Nego_Chat/Nego_Left/Btn_Help")
	self._btnCodeWord = self:getBtn("Nego_Chat/Nego_Left/Btn_CodeWord")
	self._codeWordRedPoint = self:getGo("Nego_Chat/Nego_Left/Btn_CodeWord/redpoint")
	self._Btn_Join = Framework.ButtonAdapter.GetFrom(self._Nego_NoLeague, "Btn_Join")
	self._channels = {
		self._Btn_Zone,
		self._Btn_World,
		self._Btn_League,
		self._Btn_Nearby,
		self._Btn_System,
		self._btnShare,
		self._Btn_Battle,
		self._Btn_All,
		self._Btn_Camp,
		self._Btn_Goddess,
		self._Btn_Team,
		self._Btn_ElementSpark,
		self._Btn_GoddessCompetition,
		self._Btn_Help,
		self._Btn_Luyngarde,
		self._Btn_LanternFestival
	}
	self._channelAnim = self:getGo("Nego_Chat"):GetComponent("Animator")
	self._familyLock = goutil.findChild(self._Btn_League.gameObject, "lock")
	self._allLock = goutil.findChild(self._Btn_All.gameObject, "lock")
	self._elementspartLockGo = self:getGo("Nego_Chat/Nego_Left/Btn_ElementSpark/lock")
	self._notOpenTipGo = self:getGo("Nego_Chat/notOpenTip")
	self._txtNotOpenTip = self:getTxt("Nego_Chat/notOpenTip/txt")
	self._extracom = self:getGo("extracom")
end

function NewChatView:_updateGraphic(go, des, size)
	MaterialMgr.setCellByCfg(des, go)
end

function NewChatView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._closeBtn2:AddClickListener(self._onClickClose, self)
	self._Btn_Zone:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.Zone)
	end)
	self._Btn_All:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.All)
	end)
	self._Btn_World:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.World)
	end)
	self._Btn_League:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.League)
	end)
	self._Btn_Nearby:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.Nearby)
	end)
	self._Btn_System:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.System)
	end)
	self._Btn_Battle:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.Battle)
	end)
	self._Btn_Camp:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.Camp)
	end)
	self._Btn_Goddess:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.GoddessContest)
	end)
	self._Btn_Team:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.Team)
	end)
	self._Btn_GoddessCompetition:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.GoddessCompetition)
	end)
	self._Btn_LanternFestival:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.LanternFestival)
	end)

	if self._btnShare then
		self._btnShare:AddClickListener(function()
			self:_onClickChannel(GameEnum.ChatChannel.Share)
		end)
	end

	self._Btn_Setting:AddClickListener(self._onClickSetting)
	self._btnCodeWord:AddClickListener(self._onClickCodeWord, self)
	self._Btn_Join:AddClickListener(self._onClickJoin, self)
	self._Btn_ElementSpark:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.ElementSpark)
	end)
	self._Btn_Help:AddClickListener(function()
		self:_onClickChannel(GameEnum.ChatChannel.Help)
	end)
end

function NewChatView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._closeBtn2:RemoveClickListener()
	self._Btn_Zone:RemoveClickListener()
	self._Btn_All:RemoveClickListener()
	self._Btn_World:RemoveClickListener()
	self._Btn_League:RemoveClickListener()
	self._Btn_Nearby:RemoveClickListener()
	self._Btn_System:RemoveClickListener()
	self._Btn_Battle:RemoveClickListener()
	self._Btn_Setting:RemoveClickListener()
	self._Btn_Camp:RemoveClickListener()
	self._Btn_Goddess:RemoveClickListener()
	self._Btn_GoddessCompetition:RemoveClickListener()
	self._Btn_Luyngarde:RemoveClickListener()
	self._Btn_LanternFestival:RemoveClickListener()
	self._Btn_Join:RemoveClickListener()
	self._btnCodeWord:RemoveClickListener()
	self._Btn_ElementSpark:RemoveClickListener()
	self._Btn_Help:RemoveClickListener()

	if self._btnShare then
		self._btnShare:RemoveClickListener()
	end
end

function NewChatView:checkIsAllLimit(channel, isShowTips)
	return ChatController.instance:checkIsAllLimit(channel, isShowTips)
end

function NewChatView:_checkIsHelpLimit(channel, isShowTips)
	if channel == GameEnum.ChatChannel.Help then
		local funcId = FriendConfig.instance:getCommonValue("CHANNEL_ASK_FOR_HELP_LIMIT_FUN_ID", true)

		if FuncOpenModel.instance:getFuncIsOpen(funcId) then
			return false
		else
			if isShowTips then
				local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

				FuncOpenController.instance:showLockTips(cfg)
			end

			return true
		end
	end

	return false
end

function NewChatView:_onClickChannel_old(channel, force)
	if not force and channel == NewChatController.instance:getCurChannel() then
		return
	end

	local isLimit = self:checkIsAllLimit(channel, true)

	if isLimit then
		return
	end

	if channel == GameEnum.ChatChannel.Help and self:_checkIsHelpLimit(channel, true) then
		return
	end

	if channel == GameEnum.ChatChannel.ElementSpark and ElementSparkModel.instance:getMyCampId() <= 0 then
		FloatWordMgr.instance:show("暂未加入龙裔争夺战活动玩法内的势力")

		return
	end

	goutil.setActive(self._Nego_NoLeague, false)

	local animName = ChannelAnim[channel]

	if channel == GameEnum.ChatChannel.League then
		if not FuncOpenModel.instance:getFuncIsOpen(60) then
			local cfg = FuncOpenConfig.instance:getFunctionOpenById(60)

			FloatWordMgr.instance:show(cfg.lockedTips)

			return
		else
			local hasFamily = FamilyController.instance:getFamilyLv() > 0

			goutil.setActive(self._Nego_NoLeague, not hasFamily)

			if not hasFamily then
				animName = ChannelAnim[GameEnum.ChatChannel.System]
			end
		end
	end

	if string.nilorempty(animName) then
		animName = "chat_channel_world"
	end

	NewChatController.instance:setCurChannel(channel)

	if self._channelAnim then
		self._channelAnim:Play(animName)
	end

	self:_setChannelBtnActive()
	self:_setChannelBtnState()

	if not force then
		GlobalDispatcher:dispatch(GlobalNotify.ChatChannelChange, channel)
	end

	local showNotOpenTip = false

	if channel == GameEnum.ChatChannel.All then
		showNotOpenTip = self:checkIsAllLimit(GameEnum.ChatChannel.All)
	elseif channel == GameEnum.ChatChannel.League then
		showNotOpenTip = not FuncOpenModel.instance:getFuncIsOpen(60)
	end

	goutil.setActive(self._notOpenTipGo, showNotOpenTip)
end

function NewChatView:_onClickChannel(channel, force)
	if not force and channel == NewChatController.instance:getCurChannel() then
		return
	end

	local isLimit = self:_getIsChannelLimit(channel)

	if isLimit then
		local tip = self:_getChannelLimitTip(channel)

		if not string.nilorempty(tip) then
			FloatWordMgr.instance:show(tip)
		end

		return
	end

	self:_beforeChangeChannel()
	self:_playChannelAnim(channel)
	NewChatController.instance:setCurChannel(channel)
	self:_setChannelBtnActive()
	self:_setChannelBtnState()

	if not force then
		GlobalDispatcher:dispatch(GlobalNotify.ChatChannelChange, channel)
	end

	self:_afterChangeChannel(channel)
end

function NewChatView:_getIsChannelLimit(channel)
	if channel == GameEnum.ChatChannel.All then
		local funcId = FriendConfig.instance:getCommonValue("CHANNEL_ALL_LIMIT_FUN_ID", true)

		return not FuncOpenModel.instance:getFuncIsOpen(funcId)
	elseif channel == GameEnum.ChatChannel.Help then
		local funcId = FriendConfig.instance:getCommonValue("CHANNEL_ASK_FOR_HELP_LIMIT_FUN_ID", true)

		return not FuncOpenModel.instance:getFuncIsOpen(funcId)
	elseif channel == GameEnum.ChatChannel.ElementSpark then
		return ElementSparkModel.instance:getMyCampId() <= 0
	elseif channel == GameEnum.ChatChannel.League then
		return not FuncOpenModel.instance:getFuncIsOpen(FamilyFuncOpenId)
	end

	return false
end

function NewChatView:_getChannelLimitTip(channel)
	if channel == GameEnum.ChatChannel.All then
		local funcId = FriendConfig.instance:getCommonValue("CHANNEL_ALL_LIMIT_FUN_ID", true)
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

		return cfg.lockedTips
	elseif channel == GameEnum.ChatChannel.Help then
		local funcId = FriendConfig.instance:getCommonValue("CHANNEL_ASK_FOR_HELP_LIMIT_FUN_ID", true)
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

		return cfg.lockedTips
	elseif channel == GameEnum.ChatChannel.ElementSpark then
		return "暂未加入龙裔争夺战活动玩法内的势力"
	elseif channel == GameEnum.ChatChannel.League then
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(FamilyFuncOpenId)

		return cfg.lockedTips
	end

	return ""
end

function NewChatView:_beforeChangeChannel()
	goutil.setActive(self._Nego_NoLeague, false)
	goutil.setActive(self._notOpenTipGo, false)
	self:showTabAt(self._extracom, "")
end

function NewChatView:_afterChangeChannel(channel)
	if channel == GameEnum.ChatChannel.League then
		local hasFamily = FamilyController.instance:getFamilyLv() > 0

		goutil.setActive(self._Nego_NoLeague, not hasFamily)
	elseif channel == GameEnum.ChatChannel.LanternFestival then
		self:showTabAt(self._extracom, ViewName.LanternFestivalChannelView)
	end
end

function NewChatView:_playChannelAnim(channel)
	local animName = ChannelAnim[channel]

	if string.nilorempty(animName) then
		animName = "chat_channel_world"
	end

	if channel == GameEnum.ChatChannel.League then
		local hasFamily = FamilyController.instance:getFamilyLv() > 0

		if not hasFamily then
			animName = ChannelAnim[GameEnum.ChatChannel.System]
		end
	end

	if self._channelAnim then
		self._channelAnim:Play(animName)
	end
end

function NewChatView:_setChannelBtnActive()
	return
end

function NewChatView:_setChannelBtnState()
	local channel = NewChatController.instance:getCurChannel()

	for k, v in pairs(self._channels) do
		if not goutil.isNil(v) then
			local comp = v.btn.gameObject:GetComponent("UIGoActiveChange")

			if comp then
				comp:SetState(k == channel and 1 or 0)
			end
		end
	end
end

function NewChatView:_onClickSetting()
	UIStateManager.instance:open(ViewName.chatSetting)
end

function NewChatView:_onClickCodeWord()
	UIStateManager.instance:push(ViewName.CodeWordView)
end

function NewChatView:destroyUI()
	return
end

function NewChatView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.CodeWordSelectChannel, self._onCodeWordSelectChannel, self)

	local openParam = self._viewPresentor:getOpenParam()
	local channel = self:_getDefaultShowChannels()

	if openParam and checknumber(openParam[1]) then
		channel = checknumber(openParam[1])
	end

	local isLimit = self:checkIsAllLimit(channel)

	if isLimit then
		channel = nil
	end

	self:_updateShowChannels()
	NewChatController.instance:setCurChannel(channel)
	self:_onClickChannel(channel, true)

	local familyChannelOpen = FuncOpenModel.instance:getFuncIsOpen(60)
	local allChannelOpen = not self:checkIsAllLimit(GameEnum.ChatChannel.All)

	goutil.setActive(self._familyLock, not familyChannelOpen)
	goutil.setActive(self._allLock, not allChannelOpen)
	goutil.setActive(self._elementspartLockGo, ElementSparkModel.instance:getMyCampId() <= 0)

	self._txtNotOpenTip.text = FuncOpenModel.instance:getFuncLockDescription(55)

	RedPointController.instance:regRedPoint(self._codeWordRedPoint, RedPointModel.ID_CODE_WORD)
	settimer(5, self._onSecond, self)
	self:_onSecond()
end

function NewChatView:_getDefaultShowChannels()
	local channel = GameEnum.ChatChannel.World
	local showChannel = NewChatController.instance:getShowChannel()

	if not showChannel then
		return channel
	end

	return showChannel
end

function NewChatView:_updateShowChannels()
	local showChannel = NewChatController.instance:getShowChannel()

	if not showChannel then
		for channel, btn in pairs(self._channels) do
			btn.gameObject:SetActive(channel ~= GameEnum.ChatChannel.Nearby and channel ~= GameEnum.ChatChannel.Battle and channel ~= GameEnum.ChatChannel.Zone)
		end

		self._Btn_Setting.gameObject:SetActive(true)

		if self._channels[GameEnum.ChatChannel.Team] then
			self._channels[GameEnum.ChatChannel.Team].gameObject:SetActive(NewChatController.instance:getShowTeamChannel())
		end

		if self._channels[GameEnum.ChatChannel.ElementSpark] then
			self._channels[GameEnum.ChatChannel.ElementSpark].gameObject:SetActive(ElementSparkSceneController.instance:isInActivityTime())
		end

		if self._channels[GameEnum.ChatChannel.GoddessCompetition] then
			local activityId = GoddessCompetitionController.instance:getActivityId()

			self._channels[GameEnum.ChatChannel.GoddessCompetition].gameObject:SetActive(activityId > 0)
		end

		if self._channels[GameEnum.ChatChannel.Luyngarde] then
			self._channels[GameEnum.ChatChannel.Luyngarde].gameObject:SetActive(ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Luyngarde) ~= 0)
		end

		if self._channels[GameEnum.ChatChannel.LanternFestival] then
			self._channels[GameEnum.ChatChannel.LanternFestival].gameObject:SetActive(LanternFestivalController.instance:isShowInChatChannel())
		end
	else
		self._Btn_Setting.gameObject:SetActive(false)

		for channel, btn in pairs(self._channels) do
			btn.gameObject:SetActive(channel == showChannel)
		end
	end

	local chatChannelGo = self._channels[GameEnum.ChatChannel.Camp].gameObject

	if GameUtil.GetActive(chatChannelGo) then
		chatChannelGo:SetActive(FunCampController.instance:isInActTime())
	end

	local chatGoddessGo = self._channels[GameEnum.ChatChannel.GoddessContest].gameObject

	if GameUtil.GetActive(chatGoddessGo) then
		goutil.setActive(chatGoddessGo, GoddessContestController.instance:isInActTime())
	end
end

function NewChatView:onEnterFinished()
	return
end

function NewChatView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.CodeWordSelectChannel, self._onCodeWordSelectChannel, self)
	RedPointController.instance:unregRedPoint(self._codeWordRedPoint)
	removetimer(self._onSecond, self)
end

function NewChatView:onExitFinished()
	return
end

function NewChatView:_onClickClose()
	UIStateManager.instance:popByName(ViewName.chat)
end

function NewChatView:_onClickJoin()
	if BattleController.instance:isBattling() == true then
		FloatWordMgr.instance:show("战斗中不能跳转")

		return
	end

	self:close()
	FamilySceneController.instance:enterScene()
end

function NewChatView:_onCodeWordSelectChannel(channelId, groupId, id, text)
	self:_onClickChannel(channelId)

	if channelId == GameEnum.ChatChannel.League then
		local hasFamily = FamilyController.instance:getFamilyLv() > 0

		if hasFamily then
			GlobalDispatcher:dispatch(GlobalNotify.CodeWordInputText, text)
		end
	else
		GlobalDispatcher:dispatch(GlobalNotify.CodeWordInputText, text)
	end
end

function NewChatView:_onSecond()
	goutil.setActive(self._btnCodeWord.gameObject, CodeWordController.instance:isExistAvailableCfgInTime())
end

return NewChatView
