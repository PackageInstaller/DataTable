-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\SpeakerBox.lua

local MsgReceiver = require("System/MsgReceiver")
local ResClientHardCode = require("ClientData/ResClientHardCode")
local ResUpperLimit = require("ClientData/ResUpperLimit")
local GameSettings = require("Helper/GameSettings")
local ResItemClientConfig = require("ClientData/ResItemClientConfig")
local strClassName = "SpeakerBox"
local SpeakerBox = Class(strClassName, UIControls.Window)
local TIME_RUN_WAIT = 1
local TIME_RUN = ResClientHardCode[8].value[1]
local WIDTH_MASK = 690
local WIDTH_MAX = 1750
local SPD = (WIDTH_MAX - WIDTH_MASK) / TIME_RUN
local SHOW_TYPE = {
	NORMAL = 1,
	HIGH = 2
}

function SpeakerBox:ctor()
	self.hideFlag = false
	self.mMsgDatas = {}
	self.mMsgCur = nil
	self.mCurMsgItem = nil
	self.mHighMsgDatas = {}
	self.mHighMsgCur = nil
	self.mCurHighMsgItem = nil

	self:initUI()

	self.receiver = MsgReceiver({
		Const.CHANNEL_WORLD,
		Const.MAIN_CHANNEL_SYSTEM,
		Const.CHANNEL_GUILD,
		Const.CHANNEL_SERVER
	})
	self.receiver.mEventReceive = Slot(self.onMsgReceive, self)
	self.receiver.mEventUpdate = Slot(self.onMsgUpdate, self)
	self.timerWait = Timer.New(Slot(self.onMsgCheck, self), TIME_RUN + TIME_RUN_WAIT, -1)
	self.timerRun = Timer.New(Slot(self.onMsgRun, self), 0.03, -1)
	self.highTimerWait = Timer.New(Slot(self.onHighMsgCheck, self), TIME_RUN + TIME_RUN_WAIT, -1)
	self.highTimerRun = Timer.New(Slot(self.onHighMsgRun, self), 0.03, -1)
	self._textWidth = 0
	self._startTime = 0
	self._highTextWidth = 0
	self._highStartTime = 0

	self.receiver:update()
end

function SpeakerBox:destroy()
	SpeakerBox.super.destroy(self)
	self.receiver:destroy()
	self.timerWait:Stop()
	self.timerRun:Stop()
	self.highTimerWait:Stop()
	self.highTimerRun:Stop()
	MsgManager.saveLastBulletTime()
end

function SpeakerBox:initUI()
	self.imgBg = UIControls.Image(self, "SoftMask/BgNotice")
	self.text = UIControls.Label(self, "SoftMask/BgNotice/Mask/TextBroadcast", true)
	self.txtEmojiLarge = UIControls.Label(self, "SoftMask/BgNotice/Mask/TextBroadcast/TextLargeEmoji", true)
	self.btnSensor = UIControls.Button(self, "SoftMask/BgNotice")

	self.btnSensor:addEventClick(self.onSensorClick)

	self.imgIcon = UIControls.Image(self, "SoftMask/BgNotice/IconChannel")
	self.panelSuperRedPacket = UIControls.Panel(self, "RedMoneyPanel")
	self.txtSuperRedPacket = UIControls.Label(self, "RedMoneyPanel/SoftMask/BgNotice/Mask/TextBroadcast")
	self.btnHighSensor = UIControls.Button(self, "RedMoneyPanel/SoftMask/BgNotice")

	self.btnHighSensor:addEventClick(self.onbtnHighSensorClick)
	self:_showMsg(false)
	self:_showHighMsg(false)
end

function SpeakerBox:clear()
	self.text:setText("")
	self:_showMsg(false)
	self.timerWait:Stop()
	self.timerRun:Stop()

	self.mMsgDatas = {}

	self.txtSuperRedPacket:setText("")
	self:_showHighMsg(false)
	self.highTimerWait:Stop()
	self.highTimerRun:Stop()

	self.mHighMsgDatas = {}
end

function SpeakerBox:onMsgCheck()
	local msgItem = self.mMsgDatas[1]

	if msgItem == nil then
		self.mMsgCur = nil

		self.timerWait:Stop()
		self.timerRun:Stop()
		self:_showMsg(false)
	else
		table.remove(self.mMsgDatas, 1)

		self.mMsgCur = true
		self.mCurMsgItem = msgItem

		local nameFormat = msgItem.sattr.name or ""
		local content = msgItem.content

		if nameFormat ~= "" then
			local item = MsgManager.isNormalRedPacket(msgItem)

			if item then
				local emoji = "<0311>"

				if ResItemClientConfig[item.id] and ResItemClientConfig[item.id].red_pack_emoji then
					emoji = ResItemClientConfig[item.id].red_pack_emoji
				end

				nameFormat = emoji .. utils.getColorfulStr(nameFormat, ResColor.QUALITYORANGE)
				content = string.format(Lang.get(30170), item.name)
			else
				nameFormat = nameFormat .. ":"
			end
		end

		if utils.isLargeEmoji(content) then
			self.text:setText(nameFormat)
			self.txtEmojiLarge:setText("")
			self.txtEmojiLarge:setText(content)
		else
			self.txtEmojiLarge:setText("")

			local format = MsgManager.getMsgColorFormatByMsg(msgItem)

			if format then
				nameFormat = string.format(format, nameFormat)
				content = string.format(format, content)
			end

			self.text:setText(nameFormat .. content)
		end

		self:_showMsg(true)
		self.text:setPosition(0)

		self._textWidth = self.text:getWidth() + self.txtEmojiLarge:getWidth()

		if self._textWidth > WIDTH_MASK then
			self._startTime = Time.time

			self.timerRun:Start()
		else
			self.timerRun:Stop()
		end

		local imgInfo = MsgManager.getChannelUIConfig(msgItem)

		if imgInfo then
			self.imgBg:setImage("Atlas/ChatAtlas/ChatAtlas", imgInfo.bg)
			self.imgIcon:setImage("Atlas/ChatAtlas/ChatAtlas", imgInfo.icon)
		end
	end
end

function SpeakerBox:onHighMsgCheck()
	local msgItem = self.mHighMsgDatas[1]

	if msgItem == nil then
		self.mHighMsgCur = nil

		self.highTimerWait:Stop()
		self.highTimerRun:Stop()
		self:_showHighMsg(false)
	else
		table.remove(self.mHighMsgDatas, 1)

		self.mHighMsgCur = true
		self.mCurHighMsgItem = msgItem

		local nameFormat = msgItem.sattr.name or ""
		local content = msgItem.content

		if nameFormat ~= "" then
			local item = MsgManager.isSuperRedPacket(msgItem)

			if item then
				local emoji = "<0312>"

				if ResItemClientConfig[item.id] and ResItemClientConfig[item.id].red_pack_emoji then
					emoji = ResItemClientConfig[item.id].red_pack_emoji
				end

				nameFormat = emoji .. utils.getColorfulStr(nameFormat, ResColor.QUALITYORANGE)
				content = string.format(Lang.get(30170), item.name)
			else
				nameFormat = nameFormat .. ":"
			end
		end

		self.txtSuperRedPacket:setText(nameFormat .. content)
		self:_showHighMsg(true)
		self.txtSuperRedPacket:setPosition(0)

		self._highTextWidth = self.txtSuperRedPacket:getWidth()

		if self._highTextWidth > WIDTH_MASK then
			self._highStartTime = Time.time

			self.highTimerRun:Start()
		else
			self.highTimerRun:Stop()
		end
	end
end

function SpeakerBox:onMsgRun()
	local runTime = Time.time - self._startTime

	if runTime < TIME_RUN_WAIT then
		return
	end

	runTime = runTime - TIME_RUN_WAIT

	local count, rate = math.modf(runTime * SPD / self._textWidth)
	local x = -rate * self._textWidth

	if count > 0 then
		self.timerRun:Stop()

		return
	end

	self.text:setPosition(x)
end

function SpeakerBox:onHighMsgRun()
	local runTime = Time.time - self._highStartTime

	if runTime < TIME_RUN_WAIT then
		return
	end

	runTime = runTime - TIME_RUN_WAIT

	local count, rate = math.modf(runTime * SPD / self._highTextWidth)
	local x = -rate * self._highTextWidth

	if count > 0 then
		self.highTimerRun:Stop()

		return
	end

	self.txtSuperRedPacket:setPosition(x)
end

function SpeakerBox:onMsgReceive(msgData)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_SPEAKER_BOX) then
		return
	end

	local show, insert = self:isNeedShow(msgData)

	if not show then
		return
	end

	local datas = self:getInsertMsgData(msgData)

	if insert then
		table.insert(datas, 1, msgData)
	else
		table.insert(datas, msgData)
	end

	self:_updateMsgs()
end

function SpeakerBox:onMsgUpdate(msgDatas)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_SPEAKER_BOX) then
		return
	end

	self:clear()

	local time

	for _, msg in ipairs(msgDatas) do
		time = MsgManager.getLastBulletTime(msg.channel)

		if self:isNeedShow(msg, time) then
			local datas = self:getInsertMsgData(msg)

			table.insert(datas, msg)
		end
	end

	self:_updateMsgs()
end

function SpeakerBox:_updateMsgs()
	if #self.mMsgDatas > 0 then
		self.timerWait:Start()

		if self.mMsgCur == nil then
			self:onMsgCheck()
		end
	end

	if #self.mHighMsgDatas > 0 then
		self.highTimerWait:Start()

		if self.mHighMsgCur == nil then
			self:onHighMsgCheck()
		end
	end
end

function SpeakerBox:getInsertMsgData(msg)
	if MsgManager.isSuperRedPacket(msg) then
		return self.mHighMsgDatas
	elseif msg.share == Const.CHAT_SHARE_TYPE.SPE_NOTICE then
		if msg.share_content.specData.notice_type == Const.CHAT_SPEC_NOTICE_TYPE.TRIGGER then
			if msg.share_content.specData.background_type == SHOW_TYPE.HIGH then
				return self.mHighMsgDatas
			else
				return self.mMsgDatas
			end
		else
			return self.mMsgDatas
		end
	else
		return self.mMsgDatas
	end
end

function SpeakerBox:isNeedShow(msg, _time)
	if msg.is_unread == false then
		return false
	end

	if msg.share == Const.CHAT_SHARE_TYPE.SPE_NOTICE and msg.share_content.specData.notice_type == Const.CHAT_SPEC_NOTICE_TYPE.DRAW then
		return false
	end

	local channels = MsgManager.getBulletChannels()

	if channels[msg.channel] == nil or msg.sub_channel ~= Const.CHANNEL_NONE then
		msg.is_unread = false

		return self:checkCommonTime(msg, _time), true
	elseif self:isSpecialShareMsg(msg) then
		return false
	elseif self:isRedMsgRelate(msg) then
		local data = CurAvatar:parseMsgOtherInfo(msg.other)

		if data and (data[1] == Const.CUSTOM_MSG_DATA_TYPE.RED_THX or data[1] == Const.CUSTOM_MSG_DATA_TYPE.RED_CLAIM) then
			return false
		end

		local isFullTotay = false

		if CurAvatar.redPacketData and CurAvatar.redPacketData.day_get >= ResUpperLimit[1].red_package_diamond then
			isFullTotay = true
		end

		if isFullTotay then
			return false
		else
			return self:checkCommonTime(msg, _time), MsgManager.isNormalRedPacket(msg) or MsgManager.isSuperRedPacket(msg)
		end
	elseif channels[msg.channel] == false then
		return self:checkCommonTime(msg, _time)
	else
		return false
	end
end

function SpeakerBox:isSpecialShareMsg(msg)
	if msg.share == Const.CHAT_SHARE_TYPE.REPLAY then
		return true
	end

	if msg.share == Const.CHAT_SHARE_TYPE.SPE_NOTICE and msg.share_content.specData.notice_type == Const.CHAT_SPEC_NOTICE_TYPE.CIRCLE_SHARE then
		return true
	end
end

function SpeakerBox:checkCommonTime(msg, _time)
	if RegionUtils.isJP() and not GameSettings.showLamp and MsgManager.isAllBulletChannelOff() then
		return false
	end

	return MsgManager.checkShowMsg(_time, msg)
end

function SpeakerBox:isRedMsgRelate(msg)
	local _isRedMsgRelate = false

	if MsgManager.isNormalRedPacket(msg) or MsgManager.isSuperRedPacket(msg) then
		_isRedMsgRelate = true
	end

	if not _isRedMsgRelate then
		local data = CurAvatar:parseMsgOtherInfo(msg.other)

		if data and (data[1] == Const.CUSTOM_MSG_DATA_TYPE.RED_THX or data[1] == Const.CUSTOM_MSG_DATA_TYPE.RED_CLAIM) then
			_isRedMsgRelate = true
		end
	end

	return _isRedMsgRelate
end

function SpeakerBox:onStateEnter(nextState)
	if nextState == Const.STATE_LOGIN then
		self:clear()
	end
end

function SpeakerBox:onSensorClick(sender)
	if not self.mCurMsgItem then
		return
	end

	local ui = UIManager.getUI("chatDlg", nil, false)

	if ui then
		ui:openChannel(self.mCurMsgItem)
	else
		UIManager.getUI("chatDlg", true):openChannel(self.mCurMsgItem)
	end

	self:checkRedMsgToggle()
end

function SpeakerBox:onbtnHighSensorClick(...)
	if not self.mCurHighMsgItem then
		return
	end

	local ui = UIManager.getUI("chatDlg", nil, false)

	if ui then
		ui:openChannel(self.mCurHighMsgItem)
	else
		UIManager.getUI("chatDlg", true):openChannel(self.mCurHighMsgItem)
	end

	self:checkRedMsgToggle()
end

function SpeakerBox:checkRedMsgToggle(...)
	if not MsgManager.isHideRedMsg() then
		return
	end

	if CurAvatar.redPacketData and CurAvatar.redPacketData.day_get < ResUpperLimit[1].red_package_diamond then
		local content = Lang.get(31297)

		local function yesFunc(...)
			MsgManager.setHideRedMsg(false)
		end

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc, nil, nil)
	end
end

function SpeakerBox:showMsg(v)
	self.hideFlag = not v

	if self.hideFlag then
		self:_showMsg(v)
		self:_showHighMsg(v)
	end
end

function SpeakerBox:_showMsg(v)
	if self.hideFlag == true then
		self.imgBg:setVisible(false)

		return
	end

	self.imgBg:setVisible(v and not self.mHighMsgCur)
end

function SpeakerBox:_showHighMsg(v)
	if self.hideFlag == true then
		self.panelSuperRedPacket:setVisible(false)

		return
	end

	if v then
		self:_showMsg(false)
	end

	self.panelSuperRedPacket:setVisible(v)
end

return SpeakerBox
