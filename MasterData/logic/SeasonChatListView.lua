-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/mainhud/SeasonChatListView.lua

module("logic.extensions.season.view.mainhud.SeasonChatListView", package.seeall)

local SeasonChatListView = class("SeasonChatListView", ViewComponent)
local ChannelAnim = {
	[GameEnum.ChatChannel.Zone] = "chat_channel_world",
	[GameEnum.ChatChannel.All] = "chat_channel_world",
	[GameEnum.ChatChannel.World] = "chat_channel_world",
	[GameEnum.ChatChannel.League] = "chat_channel_world",
	[GameEnum.ChatChannel.Nearby] = "chat_channel_world",
	[GameEnum.ChatChannel.System] = "chat_channel_system",
	[GameEnum.ChatChannel.Battle] = "chat_channel_world",
	[GameEnum.ChatChannel.Share] = "chat_channel_system",
	[GameEnum.ChatChannel.Camp] = "chat_channel_world",
	[GameEnum.ChatChannel.GoddessContest] = "chat_channel_world",
	[GameEnum.ChatChannel.Team] = "chat_channel_world"
}

function SeasonChatListView:ctor()
	SeasonChatListView.super.ctor(self)
end

function SeasonChatListView:buildUI()
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
	self._Btn_Team = self:getBtn("Nego_Chat/Nego_Left/Btn_Team")
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
		self._Btn_Team
	}
	self._channelAnim = self:getGo("Nego_Chat"):GetComponent("Animator")
	self._familyLock = goutil.findChild(self._Btn_League.gameObject, "lock")
	self._allLock = goutil.findChild(self._Btn_All.gameObject, "lock")
end

function SeasonChatListView:_updateGraphic(go, des, size)
	MaterialMgr.setCellByCfg(des, go)
end

function SeasonChatListView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._closeBtn2:AddClickListener(self._onClickClose, self)
	self._Btn_Setting:AddClickListener(self._onClickSetting)
	self._btnCodeWord:AddClickListener(self._onClickCodeWord, self)
	self._Btn_Join:AddClickListener(self._onClickJoin, self)
end

function SeasonChatListView:unbindEvents()
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
	self._Btn_Join:RemoveClickListener()
	self._btnCodeWord:RemoveClickListener()

	if self._btnShare then
		self._btnShare:RemoveClickListener()
	end
end

function SeasonChatListView:checkIsAllLimit(channel, isShowTips)
	if channel == GameEnum.ChatChannel.All then
		local funcId = FriendConfig.instance:getCommonValue("CHANNEL_ALL_LIMIT_FUN_ID", true)

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

function SeasonChatListView:_onClickChannel(channel, force)
	if not force and channel == NewChatController.instance:getCurChannel() then
		return
	end

	local isLimit = self:checkIsAllLimit(channel, true)

	if isLimit then
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

	NewChatController.instance:setCurChannel(channel)

	if self._channelAnim then
		self._channelAnim:Play(animName)
	end

	self:_setChannelBtnActive()
	self:_setChannelBtnState()

	if not force then
		GlobalDispatcher:dispatch(GlobalNotify.ChatChannelChange, channel)
	end
end

function SeasonChatListView:_setChannelBtnActive()
	return
end

function SeasonChatListView:_setChannelBtnState()
	local channel = NewChatController.instance:getCurChannel()

	for k, v in ipairs(self._channels) do
		if not goutil.isNil(v) then
			local comp = v.btn.gameObject:GetComponent("UIGoActiveChange")

			if comp then
				comp:SetState(k == channel and 1 or 0)
			end
		end
	end
end

function SeasonChatListView:_onClickSetting()
	FloatWordMgr.instance:show(lang("此界面无法修改"))
end

function SeasonChatListView:_onClickCodeWord()
	FloatWordMgr.instance:show(lang("此界面无法打开"))
end

function SeasonChatListView:destroyUI()
	return
end

function SeasonChatListView:onEnter()
	for i = 1, #self._channels do
		self._channels[i].gameObject:SetActive(i == GameEnum.ChatChannel.Team)
	end

	goutil.setActive(self._btnCodeWord.gameObject, false)
	goutil.setActive(self._Nego_NoLeague.gameObject, false)
end

function SeasonChatListView:_getDefaultShowChannels()
	local channel = GameEnum.ChatChannel.World
	local showChannel = NewChatController.instance:getShowChannel()

	if not showChannel then
		return channel
	end

	return showChannel
end

function SeasonChatListView:_updateShowChannels()
	local showChannel = NewChatController.instance:getShowChannel()

	if not showChannel then
		for i = 1, #self._channels do
			self._channels[i].gameObject:SetActive(i ~= GameEnum.ChatChannel.Nearby and i ~= GameEnum.ChatChannel.Battle and i ~= GameEnum.ChatChannel.Zone)
		end

		self._Btn_Setting.gameObject:SetActive(true)

		if self._channels[GameEnum.ChatChannel.Team] then
			self._channels[GameEnum.ChatChannel.Team].gameObject:SetActive(NewChatController.instance:getShowTeamChannel())
		end
	else
		self._Btn_Setting.gameObject:SetActive(false)

		for i = 1, #self._channels do
			self._channels[i].gameObject:SetActive(i == showChannel)
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

function SeasonChatListView:onEnterFinished()
	return
end

function SeasonChatListView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.CodeWordSelectChannel, self._onCodeWordSelectChannel, self)
	RedPointController.instance:unregRedPoint(self._codeWordRedPoint)
	removetimer(self._onSecond, self)
end

function SeasonChatListView:onExitFinished()
	return
end

function SeasonChatListView:_onClickClose()
	UIStateManager.instance:popByName(ViewName.SeasonChatListView)
end

function SeasonChatListView:_onClickJoin()
	if BattleController.instance:isBattling() == true then
		FloatWordMgr.instance:show("战斗中不能跳转")

		return
	end

	self:close()
	FamilySceneController.instance:enterScene()
end

function SeasonChatListView:_onCodeWordSelectChannel(channelId, groupId, id, text)
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

function SeasonChatListView:_onSecond()
	goutil.setActive(self._btnCodeWord.gameObject, false)
end

return SeasonChatListView
