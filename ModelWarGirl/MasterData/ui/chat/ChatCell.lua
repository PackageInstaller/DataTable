-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\ChatCell.lua

local ChatBox = require("UI/Chat/ChatBox")
local UIConst = UIConst
local TOTAL_HEIGHT = 100
local TIME_TEXT_INITY = -90
local TIME_TEXT_OFFSET = 54
local WORLD_WIDTH = 886
local PRIVATE_WIDTH = 605
local MIN_SYS_HEIGHT = 51
local SYS_UP_GAP = 20
local SYS_CONTENT_WIDTH = 742
local RED_THX_WIDTH = 820
local MIN_RED_HEIGHT = 42
local strClassName = "ChatCell"
local ChatCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function ChatCell:ctor()
	self:initUI()

	self.mSysWidth = 740
end

function ChatCell:initUI()
	self.contentSelf = ChatBox(self, "ChatSelfPanel", true)
	self.contentOther = ChatBox(self, "ChatOthersPanel", false)
	self.contentSys = UIControls.Panel(self, "ChatSystemPanel")
	self.contentGuildPanel = UIControls.Panel(self, "ChatGuildPanel")
	self.contentRedPacketRecord = UIControls.Panel(self, "RedMoneyPanel")
	self.iconChannelSys = UIControls.Image(self, "ChatSystemPanel/IconChannel")
	self.labelContextSys = UIControls.Label(self, "ChatSystemPanel/TextMessage", true)
	self.txtTime = UIControls.Label(self, "TextTime")
	self.txtRedPacketInfo = UIControls.Label(self, "RedMoneyPanel/Text")
	self.btnMore = UIControls.Button(self, "RedMoneyPanel/Text/BtnMore")

	self.btnMore:addEventClick(self.onBtnMoreClick)

	self.imgRedMoreArrow = UIControls.Image(self, "RedMoneyPanel/Text/BtnMore/Img")
	self.timeHeight = self.txtTime:getHeight()
end

function ChatCell:setData(msgItem, showTime)
	local avatar = CurAvatar

	self.msgItem = msgItem
	self.isSys = msgItem.channel == Const.MAIN_CHANNEL_SYSTEM or msgItem.sub_channel == Const.WORLD_CHANNEL_SYSTEM or msgItem.sub_channel == Const.GUILD_CHANNEL_SYSTEM
	self.isGUildNotice = false
	self.isRedPacketRecord = false

	local data = CurAvatar:parseMsgOtherInfo(msgItem.other)

	if data and #data > 0 then
		if #data == 1 then
			self.isRedPacketRecord = true
		else
			self.isRedPacketRecord = data[1] == Const.CUSTOM_MSG_DATA_TYPE.RED_CLAIM
		end
	end

	self.isSelf = avatar ~= nil and msgItem.suid == avatar.uid
	self.showTime = showTime

	self.contentSys:setVisible(self.isSys)
	self.contentGuildPanel:setVisible(self.isGUildNotice)
	self.contentRedPacketRecord:setVisible(self.isRedPacketRecord)

	if not self.isSys and not self.isGUildNotice and not self.isRedPacketRecord then
		self.contentSelf:setVisible(self.isSelf)
		self.contentOther:setVisible(not self.isSelf)
	else
		self.contentSelf:setVisible(false)
		self.contentOther:setVisible(false)
	end

	if showTime then
		self.txtTime:setVisible(true)
		self.txtTime:setText(ClientUtils.getServerTimeData(self.msgItem.time, Lang.get(30157)))
	else
		self.txtTime:setVisible(false)
	end

	self:setWidth(msgItem.channel)

	local h = 0

	if self.isSys then
		local config = MsgManager.getChannelUIConfig(msgItem)

		if config then
			self.iconChannelSys:setImage("Atlas/ChatAtlas/ChatAtlas", config.icon)
		end

		self.labelContextSys:setSize(SYS_CONTENT_WIDTH, h)
		self.labelContextSys:setText(msgItem.content)

		h = self.labelContextSys:getHeight()

		self.labelContextSys:setSize(SYS_CONTENT_WIDTH, h)

		if h > MIN_SYS_HEIGHT then
			h = h + SYS_UP_GAP
		else
			h = MIN_SYS_HEIGHT
		end

		self.contentSys:setRectSize(0, h)
	elseif self.isRedPacketRecord then
		h = self:setRedPacketThxUI()
	elseif self.isSelf then
		self.msgItem.sattr.head = avatar.head
		self.msgItem.sattr.head_frame_id = avatar.headFrameId
		h = self.contentSelf:setData(msgItem)
	else
		h = self.contentOther:setData(msgItem)
	end

	self:setHeight(h)
end

function ChatCell:setHeight(h)
	if self.showTime then
		h = h + self.timeHeight
	end

	self:setLayoutSize(nil, h)
end

function ChatCell:setWidth(channel)
	local width = PRIVATE_WIDTH
	local h = 150

	if channel ~= Const.CHANNEL_PRIVATE then
		width = WORLD_WIDTH
	end

	self:setLayoutSize(width, nil)

	self.width = width
end

function ChatCell:outSetWidth(checkWide)
	local width = checkWide and WORLD_WIDTH or PRIVATE_WIDTH

	self:setLayoutSize(width, nil)

	self.width = width
end

function ChatCell:offsetMove(offset)
	self.contentSelf:setPosition(nil, offset)
	self.contentOther:setPosition(nil, offset)
	self.contentSys:setPosition(nil, offset)
	self.contentGuildPanel:setPosition(nil, offset)
end

function ChatCell:setRedPacketThxUI(...)
	local h = 0

	if self.msgItem.redPacketData.index == Const.FOLD_MSG_NUM then
		self.btnMore:setVisible(#self.msgItem.redPacketData.more > 0)

		if not self.msgItem.redPacketData.isFold then
			self.imgRedMoreArrow:setRotate(0)

			local content = self.msgItem.content

			for i, msg in ipairs(self.msgItem.redPacketData.more) do
				content = content .. "\n" .. msg.content
			end

			self.txtRedPacketInfo:setText(content)

			h = MIN_RED_HEIGHT * (#self.msgItem.redPacketData.more + 1)

			self.txtRedPacketInfo:setSize(RED_THX_WIDTH, h)
		else
			self.imgRedMoreArrow:setRotate(180)

			local content = self.msgItem.content

			self.txtRedPacketInfo:setText(content)

			h = MIN_RED_HEIGHT

			self.txtRedPacketInfo:setSize(RED_THX_WIDTH, h)
		end
	else
		self.btnMore:setVisible(false)
		self.txtRedPacketInfo:setText(self.msgItem.content)

		h = MIN_RED_HEIGHT
	end

	return h
end

function ChatCell:onBtnMoreClick(...)
	self.msgItem.redPacketData.isFold = not self.msgItem.redPacketData.isFold

	local h = self:setRedPacketThxUI()

	self:setHeight(h)
end

return ChatCell
