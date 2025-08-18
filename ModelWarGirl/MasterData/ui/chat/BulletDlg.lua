-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\BulletDlg.lua

local MsgReceiver = require("System/MsgReceiver")
local GameSettings = require("Helper/GameSettings")
local strClassName = "BulletDlg"
local BulletDlg = Class(strClassName, UIControls.Window)
local STATE = {
	COMMON = 1,
	HIDE = 0,
	BATTLE = 0.15
}

function BulletDlg:ctor(...)
	self.panel = UIControls.Panel(self, "BulletScreen")
	self.screenController = self:getController():GetCom(UIConst.ControlTypeBulletScreen, "BulletScreen")

	self:setState(STATE.COMMON)
	self:initData()
end

function BulletDlg:initData(...)
	self.bullets = {}
	self.receiver = MsgReceiver({})
	self.receiver.mEventReceive = Slot(self.onMsgReceive, self)
	self.receiver.mEventUpdate = Slot(self.onMsgUpdate, self)
	self.channels = utils.copyTable(MsgManager.getBulletChannels())
	self.channels[Const.CHANNEL_BP_PVP] = 4

	self:changeChannel()
end

function BulletDlg:onOpen()
	BulletDlg.super.onOpen(self)
end

function BulletDlg:changeChannel(...)
	local channels = {}

	for channel, state in pairs(self.channels) do
		if state ~= false then
			table.insert(channels, channel)
		end
	end

	self.receiver:changeChannel(channels)
end

function BulletDlg:refreshChannels(channels)
	for channel, state in pairs(channels) do
		if self.channels[channel] ~= false and state == false and not tolua.isnull(self.screenController) and self.channels[channel] then
			self.screenController:ClearByType(self.channels[channel])
		end
	end

	self.channels = utils.copyTable(channels)

	self:changeChannel()
end

function BulletDlg:destroy(...)
	self.receiver:destroy()
	BulletDlg.super.destroy(self)
	self:clearAll()
end

function BulletDlg:onMsgUpdate(msgDatas)
	self.msgDatas = msgDatas

	local time = 0
	local limitNum = 3 * Const.BULLET_NUM_LIMIT

	if limitNum >= #msgDatas then
		for i, msg in ipairs(self.msgDatas) do
			time = MsgManager.getLastBulletTime(msg.channel)

			self:onMsgReceive(msg, time)
		end
	else
		for i = #msgDatas - limitNum, #msgDatas do
			time = MsgManager.getLastBulletTime(msgDatas[i].channel)

			self:onMsgReceive(msgDatas[i], time)
		end
	end
end

function BulletDlg:onMsgReceive(msgData, lastTime)
	if not self:checkShow(msgData) then
		return
	end

	local t = self.channels[msgData.channel] or 9

	if MsgManager.checkShowMsg(lastTime, msgData) then
		local name = msgData.sattr.name

		if msgData.sub_channel == Const.CHANNEL_NONE and (not name or name == "") then
			return
		end

		if RegionUtils.isSEA() then
			name = name .. " :"
		else
			name = name .. ":"
		end

		msgData.is_unread = false

		local format = MsgManager.getMsgColorFormatByMsg(msgData)
		local content = msgData.content

		if format then
			name = string.format(format, name)
			content = string.format(format, content)
		end

		name = self:addPreDesc(msgData, name)

		if not tolua.isnull(self.screenController) then
			if RegionUtils.isSEA() then
				content = " " .. content
			end

			self.screenController:AddBullet(name, content, t, utils.isLargeEmoji(msgData.content) ~= nil)
		end
	end
end

function BulletDlg:checkShow(msgData)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BULLET_SCREEN) then
		return
	end

	if GameFsm.isInState(Const.STATE_MAIN_CIRCLE) and msgData.channel ~= Const.CHANNEL_GUILD then
		return
	end

	if msgData.is_unread == false then
		return
	end

	if msgData.share == Const.CHAT_SHARE_TYPE.REPLAY or msgData.share == Const.CHAT_SHARE_TYPE.RED_PACKET then
		return
	end

	if msgData.share == Const.CHAT_SHARE_TYPE.SPE_NOTICE and msgData.share_content.specData.notice_type ~= Const.CHAT_SPEC_NOTICE_TYPE.DYNAMIC_ICON then
		return
	end

	if msgData.sub_channel == Const.WORLD_CHANNEL_SYSTEM then
		return
	end

	local data = CurAvatar:parseMsgOtherInfo(msgData.other)

	if data and (data[1] == Const.CUSTOM_MSG_DATA_TYPE.RED_THX or data[1] == Const.CUSTOM_MSG_DATA_TYPE.RED_CLAIM) then
		return
	end

	if self.showState == STATE.BATTLE and not GameSettings.bulletInBattle then
		return
	end

	if msgData.hideBulletHistory == true then
		return
	end

	local inBpPvpState = false
	local bpPvpUIName = {
		"topPvpBpMainDlg",
		"topPvpWaittingDlg"
	}

	for _, uiName in pairs(bpPvpUIName) do
		local ui = UIManager.tryGetUI(uiName)

		if ui and ui:getVisible() then
			inBpPvpState = true

			break
		end
	end

	if inBpPvpState == true and msgData.channel ~= Const.CHANNEL_BP_PVP then
		return
	end

	return true
end

function BulletDlg:addPreDesc(msgData, name)
	local content = ""
	local isSysMsg = false

	if msgData.channel == Const.CHANNEL_GUILD and Const.FORCE_OPEN_CIRCLE_BATTLE then
		if msgData.sub_channel ~= Const.GUILD_CHANNEL_SYSTEM then
			local preFix = MsgManager.getCirclePreFix(msgData)

			if preFix then
				content = preFix .. content
			end

			content = "<9007>" .. content
		else
			isSysMsg = true
			content = "<9011>"
		end
	end

	if not isSysMsg then
		if msgData.sattr.help_cnt then
			local icon = MsgManager.getRentEmoji(msgData.sattr.help_cnt, msgData.sattr.uid)

			if icon then
				content = content .. icon
			end
		end

		name = content .. name
	else
		name = content
	end

	return name
end

function BulletDlg:testBullet(...)
	if not tolua.isnull(self.screenController) then
		self.screenController:TestBullet()
	end
end

function BulletDlg:clearAll(...)
	if not tolua.isnull(self.screenController) then
		self.screenController:ClearAll()
	end
end

function BulletDlg:checkState(...)
	local isInBattle = GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY)

	if isInBattle then
		self:setState(STATE.BATTLE)
	else
		self:setState(STATE.COMMON)
	end
end

function BulletDlg:setState(nowState)
	if nowState == nil or self.showState == nowState then
		return
	end

	self.showState = nowState

	if self.showState == STATE.BATTLE and not GameSettings.bulletInBattle then
		self:clearAll()
	end

	if not tolua.isnull(self.screenController) then
		self.screenController:ChangeHeightRange(self.showState or 1)
	end
end

function BulletDlg:onStateEnter(preStateName, nextStateName)
	self:checkState()

	if self.isInBattle == true and nextStateName ~= Const.STATE_BATTLE and nextStateName ~= Const.STATE_BATTLE_REPLAY then
		self.isInBattle = nil

		if not GameSettings.bulletInBattle then
			self:changeChannel()
		end
	elseif nextStateName == Const.STATE_BATTLE or nextStateName == Const.STATE_BATTLE_REPLAY then
		self.isInBattle = true

		if not GameSettings.bulletInBattle then
			MsgManager.saveLastBulletTime()
		end
	end
end

function BulletDlg:showMsg(v)
	if not v then
		self:setState(STATE.HIDE)
	else
		self:checkState()
	end
end

return BulletDlg
