-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\EditHeadDlg.lua

local ResGuideGet = require("ClientData/ResGuideGet")
local HeadHelper = require("UI/RoleInfo/HeadHelper")
local ResRoleHead = require("ClientData/ResRoleHead")
local ResHero = require("ClientData/ResHero")
local ResRoleHeadPendant = require("ClientData/ResRoleHeadPendant")
local ResRoleChatBubble = require("ClientData/ResRoleChatBubble")
local UserData = require("Helper/UserData")
local BTN_STATE = {
	USING = 4,
	POST = 3,
	USE = 2,
	NONE = 1
}
local ICON_PATH = "Atlas/CommonAtlas/GridAtlas/GridAtlas"
local HeadItem = Class("HeadItem", UIControls.ScrollViewLoopCell)

function HeadItem:ctor(...)
	self:initUI()
end

function HeadItem:initUI(...)
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onSensorClick)

	self.btnAdd = UIControls.Button(self, "BtnAdd")

	self.btnAdd:addEventClick(self.onBtnAddClick)

	self.imgHead = UIControls.Image(self, "Mask/IconPlayerHead")
	self.imgSelect = UIControls.Image(self, "ImgSel")
	self.imgState = UIControls.Image(self, "ImgState")
	self.txtState = UIControls.Label(self, "ImgState/Text")
	self.imgNew = UIControls.Image(self, "IconNew")
	self.imgMask = UIControls.Image(self, "ImgState/ImgMask")
	self.imgRed = UIControls.Image(self, "ImgState/ImgRed")
end

function HeadItem:setData(data)
	self.data = data

	if self.data.base == nil then
		self.data.base = ResRoleHead[Const.PERSONAL_HEAD_ID]
	end

	self.heroId = self.data.base.heroid or 1
	self.heroId = tonumber(self.heroId)

	self.btnAdd:setVisible(false)
	self.imgMask:setVisible(false)
	self.imgRed:setVisible(false)
	self.imgHead:setVisible(true)

	if Const.REVIEW_VERSION or ChannelUtil.isSteam() then
		self.headId = self.data.base.id
	elseif self.mIndex == 1 then
		self.headId = Const.PERSONAL_HEAD_ID

		if not HeadHelper.isPosted() then
			self.btnAdd:setVisible(true)
		end
	else
		self.headId = self.data.base.id
	end

	if self.headId == Const.PERSONAL_HEAD_ID then
		if HeadHelper.isPosted() then
			HeadHelper.forceSetCustomHead(self.imgHead)
		else
			self.imgHead:setVisible(false)
		end
	else
		HeadHelper.setHeadIcon(self.imgHead, self.headId)
	end

	if self.headId == Const.PERSONAL_HEAD_ID then
		local hint = HeadHelper.getHintByStatus(ClientUtils.record.headStatus)

		if hint then
			self.imgState:setVisible(true)
			self.txtState:setText(hint)
			self.imgMask:setVisible(true)
			self.imgRed:setVisible(self:isRedShow())
		elseif self:isUsing(self.headId) then
			self.imgState:setVisible(true)
			self.txtState:setText(Lang.get(901))
		else
			self.imgState:setVisible(false)
		end
	elseif self:isUsing(self.headId) then
		self.imgState:setVisible(true)
		self.txtState:setText(Lang.get(901))
	else
		self.imgState:setVisible(false)
	end

	self.imgNew:setVisible(CurAvatar.newHeadRecord[self.headId] ~= nil)
	self:setSelected(self.data.select)
end

function HeadItem:isUsing(headId)
	local customId, normalId, isCustom = HeadHelper.decodeHeadInfo(CurAvatar.head)

	if isCustom then
		return headId == Const.PERSONAL_HEAD_ID
	else
		return headId == normalId
	end
end

function HeadItem:isRedShow(...)
	return ClientUtils.record.headStatus == Const.CUSTOM_HEAD_STATUS.FORBID or ClientUtils.record.headStatus == Const.CUSTOM_HEAD_STATUS.UP_LOAD_FAILD
end

function HeadItem:setSelected(v)
	self.imgSelect:setVisible(v)
	self.sensor:setEnable(not v)
end

function HeadItem:onSensorClick()
	CurAvatar:setNewHeadState(self.headId)
	self.mWindow:onHeadItemClick(self.data)
end

function HeadItem:onBtnAddClick(...)
	self.mWindow:pickImage()
end

local HeadFrameItem = Class("HeadFrameItem", UIControls.ScrollViewLoopCell)

function HeadFrameItem:ctor(...)
	self:initUI()
end

function HeadFrameItem:initUI(...)
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onSensorClick)

	self.imgHeadFrame = UIControls.Image(self, "IconPlayerHeadFrame")
	self.imgSelect = UIControls.Image(self, "ImgSel")
	self.imgState = UIControls.Image(self, "ImgState")
	self.txtState = UIControls.Label(self, "ImgState/Text")
	self.imgNew = UIControls.Image(self, "IconNew")
	self.imgLimit = UIControls.Image(self, "IconLimit")
end

function HeadFrameItem:setSelected(v)
	self.imgSelect:setVisible(v)
	self.sensor:setEnable(not v)
end

function HeadFrameItem:setData(data)
	self.data = data

	if not self.data.base.id then
		self.data.base.id = Const.DEFAULT_HEAD_FRAME_ID
	end

	self.headFrameId = self.data.base.id
	self.getIds = self.data.base.get_ids

	if self.headFrameId == 0 or self.headFrameId == Const.DEFAULT_HEAD_FRAME_ID then
		HeadHelper.setHeadFrame(self.imgHeadFrame, self.headFrameId)
	else
		local iconPath = BaseObject.getItemIconPath(self.headFrameId)

		if iconPath then
			self.imgHeadFrame:setImage(iconPath[1], iconPath[2])
		end
	end

	self.imgState:setVisible(CurAvatar.headFrameId == self.headFrameId)
	self.txtState:setText(Lang.get(901))

	local isShowNew = CurAvatar.newHeadFrameRecord[self.headFrameId] ~= nil

	self.imgNew:setVisible(isShowNew)

	local isLimitShow

	if self.data.endTime then
		isLimitShow = true

		if self.data.endTime > ClientUtils.getServerTime() then
			self.imgHeadFrame:setObjGray(false)
			self.imgLimit:setImage(ICON_PATH, "TxtLimit01")
		else
			self.imgHeadFrame:setObjGray(true)
			self.imgLimit:setImage(ICON_PATH, "TxtLimit02")
		end
	else
		self.imgHeadFrame:setObjGray(false)

		isLimitShow = false
	end

	if isShowNew then
		self.imgLimit:setVisible(false)
	else
		self.imgLimit:setVisible(isLimitShow)
	end

	self:setSelected(self.data.select)
end

function HeadFrameItem:onSensorClick(...)
	CurAvatar:setNewHeadFrameState(self.headFrameId)
	self.mWindow:onHeadFrameItemClick(self.data)
end

local PendantItem = Class("PendantItem", UIControls.ScrollViewLoopCell)

function PendantItem:ctor(...)
	self:initUI()
end

function PendantItem:initUI(...)
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onSensorClick)

	self.imgPendant = UIControls.Image(self, "IconPendant")
	self.imgSelect = UIControls.Image(self, "ImgSel")
	self.imgState = UIControls.Image(self, "ImgState")
	self.txtState = UIControls.Label(self, "ImgState/Text")
	self.imgNew = UIControls.Image(self, "IconNew")
	self.imgLimit = UIControls.Image(self, "IconLimit")
end

function PendantItem:setSelected(v)
	self.imgSelect:setVisible(v)
	self.sensor:setEnable(not v)
end

function PendantItem:setData(data)
	self.data = data
	self.pendantId = self.data.base.head_pendant_id

	self.imgPendant:setImage(ResRoleHeadPendant[self.pendantId].picture_path, ResRoleHeadPendant[self.pendantId].picture_name)
	self.imgState:setVisible(CurAvatar.headPendantId == self.pendantId)
	self.txtState:setText(Lang.get(901))

	local isShowNew = CurAvatar.newHeadPendantRecord[self.pendantId] ~= nil

	self.imgNew:setVisible(isShowNew)

	local isLimitShow

	if self.data.endTime then
		isLimitShow = true

		if self.data.endTime > ClientUtils.getServerTime() then
			self.imgPendant:setObjGray(false)
			self.imgLimit:setImage(ICON_PATH, "TxtLimit01")
		else
			self.imgPendant:setObjGray(true)
			self.imgLimit:setImage(ICON_PATH, "TxtLimit02")
		end
	else
		self.imgPendant:setObjGray(false)

		isLimitShow = false
	end

	if isShowNew then
		self.imgLimit:setVisible(false)
	else
		self.imgLimit:setVisible(isLimitShow)
	end

	self:setSelected(self.data.select)
end

function PendantItem:onSensorClick()
	CurAvatar:setNewHeadPendantState(self.pendantId)
	self.mWindow:onPendantClick(self.data)
end

local ChatBubbleItem = Class("EditHeadDlg_ChatBubbleItem", UIControls.ScrollViewLoopCell)

function ChatBubbleItem:ctor()
	self.imgIcon = UIControls.Image(self, "IconPlayerHeadFrame")
	self.imgSelect = UIControls.Image(self, "ImgSel")
	self.imgState = UIControls.Image(self, "ImgState")
	self.imgLimit = UIControls.Image(self, "IconLimit")
	self.imgNew = UIControls.Image(self, "IconNew")
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onClickBtn)
end

function ChatBubbleItem:setData(data)
	self.data = data
	self.chatBubbleId = data.base.id

	local checkDefault = self.chatBubbleId == Const.DEFAULT_CHAT_BUBBLE_ID

	self.imgIcon:setVisible(not checkDefault)

	if not checkDefault then
		local path = BaseObject.getItemIconPath(self.chatBubbleId)

		if path then
			self.imgIcon:setImage(path[1], path[2])
		end
	end

	self.imgState:setVisible(self.chatBubbleId == CurAvatar.chatBubbleId)
	self:setSelect(self.data.select)

	local isShowNew = utils.getIndexByValue(CurAvatar.newChatBubbleRecord, self.chatBubbleId) > 0

	self.imgNew:setVisible(isShowNew)

	local isLimitShow

	if self.data.endTime then
		isLimitShow = true

		if self.data.endTime > ClientUtils.getServerTime() then
			self.imgIcon:setObjGray(false)
			self.imgLimit:setImage(ICON_PATH, "TxtLimit01")
		else
			self.imgIcon:setObjGray(true)
			self.imgLimit:setImage(ICON_PATH, "TxtLimit02")
		end
	else
		self.imgIcon:setObjGray(false)

		isLimitShow = false
	end

	self.imgLimit:setVisible(not isShowNew and isLimitShow)
end

function ChatBubbleItem:setSelect(value)
	self.imgSelect:setVisible(value)
end

function ChatBubbleItem:onClickBtn()
	CurAvatar:clearChatBubbleRed(self.chatBubbleId)
	self.mWindow:onChatBubbleItemClick(self.data)
end

local strClassName = "EditHeadDlg"
local EditHeadDlg = Class(strClassName, UIControls.Window)
local STATE = {}

STATE.HEAD = 1
STATE.HEAD_FRAME = 2
STATE.PENDANT = 3
STATE.CHAT_BUBBLE = 4

function EditHeadDlg:ctor(...)
	self:initUI()
end

function EditHeadDlg:initUI(...)
	self.txtTitle = UIControls.Label(self, "Bg/TextTitle")
	self.btnHead = UIControls.Button(self, "Bg/TabPanel/BtnChooseHead")

	self.btnHead:addEventClick(self.onTabButtonClick)

	self.redHintHead = UIControls.RedDot(self, "Bg/TabPanel/BtnChooseHead/IconNew")

	self.redHintHead:addHint({
		UIConst.RD_HINT_NEW_HEAD
	})

	self.btnHeadFrame = UIControls.Button(self, "Bg/TabPanel/BtnChooseHeadFrame")

	self.btnHeadFrame:addEventClick(self.onTabButtonClick)

	self.redHintHeadFrame = UIControls.RedDot(self, "Bg/TabPanel/BtnChooseHeadFrame/IconNew")

	self.redHintHeadFrame:addHint({
		UIConst.RD_HINT_NEW_HEAD_FRAME
	})

	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelHead = UIControls.Panel(self, "Bg/HeadListPanel")
	self.panelHeadFrame = UIControls.Panel(self, "Bg/HeadFrameListPanel")
	self.panelHeadPendant = UIControls.Panel(self, "Bg/PendantListPanel")
	self.imgHeadPreview = UIControls.Image(self, "Bg/PreviewPlayerHead/Mask/IconPlayerHead")
	self.imgHeadFramePreview = UIControls.Image(self, "Bg/PreviewPlayerHead/IconPlayerHeadFrame")
	self.imgPendantPreview = UIControls.Image(self, "Bg/PreviewPlayerHead/Mask/IconPendant")
	self.txtName = UIControls.Label(self, "Bg/TextName")
	self.txtGainWay = UIControls.Label(self, "Bg/TextGain")
	self.btnUse = UIControls.Button(self, "Bg/BtnState", "Text")

	self.btnUse:addEventClick(self.onBtnUseClick)

	self.btnReplace = UIControls.Button(self, "Bg/BtnReplace")

	self.btnReplace:addEventClick(self.onBtnReplaceClick)

	self.imgLimit = UIControls.Image(self, "Bg/TextName/IconLimit")

	self.imgLimit:setVisible(false)

	self.txtTime = UIControls.Label(self, "Bg/TextName/IconLimit/TextTime")
	self.scrollHeadView = UIControls.ScrollViewLoopV(self, "Bg/HeadListPanel", 0, self.onHeadCellChanged)
	self.scrollHeadFrameView = UIControls.ScrollViewLoopV(self, "Bg/HeadFrameListPanel", 0, self.onHeadFrameCellChanged)
	self.btnPendant = UIControls.Button(self, "Bg/TabPanel/BtnChoosePendant")

	self.btnPendant:addEventClick(self.onTabButtonClick)

	self.redHintPendant = UIControls.RedDot(self, "Bg/TabPanel/BtnChoosePendant/IconNew")

	self.redHintPendant:addHint({
		UIConst.RD_HINT_NEW_PENDANT
	})

	self.scrollPendant = UIControls.ScrollViewLoopV(self, "Bg/PendantListPanel", 0, self.onPendantCellChanged)
	self.panelAttr = UIControls.Panel(self, "Bg/AttrLessPanel")
	self.attrCells = {}

	for index = 1, 2 do
		local newCell = UIControls.AttrCellPanel(self, "Bg/AttrLessPanel/Attr" .. index)

		table.insert(self.attrCells, newCell)
	end

	self.btnAllAttr = UIControls.Button(self, "Bg/BtnAttrInfo")

	self.btnAllAttr:addEventClick(self.onAllAttrClick)

	self.btnChatBubble = UIControls.Button(self, "Bg/TabPanel/BtnChooseChatBubble")

	self.btnChatBubble:addEventClick(self.onTabButtonClick)

	self.redHintChatBubble = UIControls.RedDot(self, "Bg/TabPanel/BtnChooseChatBubble/IconNew")

	self.redHintChatBubble:addHint({
		UIConst.RD_HINT_NEW_CHAT_BUBBLE
	})

	self.panelChatBubble = UIControls.Panel(self, "Bg/ChatBubbleListPanel")
	self.scrollChatBubble = UIControls.ScrollViewLoopV(self, "Bg/ChatBubbleListPanel", 0, self.onChatBubbleCellChanged)
	self.chatBubblePanel = UIControls.Panel(self, "Bg/ChatBubblePanel")
	self.imgChatBubble = UIControls.Image(self, "Bg/ChatBubblePanel/ImgChatBubble")
	self.txtChatBubble = UIControls.Label(self, "Bg/ChatBubblePanel/Text")
	self.initialChatBubbleSprite = self.imgChatBubble:getComObj().sprite
end

function EditHeadDlg:initData(...)
	self.curHeadData = nil
	self.curHeadFrameItem = nil
	self.curPendantData = nil
	self.curChatBubbleData = nil
	self.state = nil
	self.headData = {}

	local data = HeadHelper.getOwnHead()
	local isMatch = false
	local customId, normalId, isCustom = HeadHelper.decodeHeadInfo(CurAvatar.head)

	for i, info in ipairs(data) do
		local d = {}

		d.select = false
		d.base = info

		if d.base.name == nil then
			local hid = tonumber(info.heroid)

			if ResHero[hid] then
				d.name = ResHero[hid].hero_name or ""
			end
		end

		if isCustom == false and info.id == normalId then
			d.select = true
			isMatch = true
			self.curHeadData = d
		end

		table.insert(self.headData, d)
	end

	table.sort(self.headData, function(v1, v2)
		local time1 = CurAvatar.newHeadRecord[v1.base.id] or 0
		local time2 = CurAvatar.newHeadRecord[v2.base.id] or 0

		if time1 == time2 then
			return v1.base.id < v2.base.id
		else
			return time2 < time1
		end
	end)

	if not Const.REVIEW_VERSION and not ChannelUtil.isSteam() then
		table.insert(self.headData, 1, {
			select = not isMatch,
			base = ResRoleHead[Const.PERSONAL_HEAD_ID]
		})
	end

	if isMatch == false then
		self.curHeadData = self.headData[1]
	end

	isMatch = false
	self.headFrameData = {}

	local data = HeadHelper.getOwnHeadFrame()

	for i = 1, #data do
		local d = {}

		d.select = false
		d.base = data[i]

		local endTime = self:isTimeLimitItem(d.base.id)

		if endTime then
			d.endTime = endTime
		end

		if d.base.id == CurAvatar.headFrameId then
			d.select = true
			isMatch = true
			self.curHeadFrameItem = d
		end

		table.insert(self.headFrameData, d)
	end

	table.sort(self.headFrameData, function(v1, v2)
		local time1 = CurAvatar.newHeadFrameRecord[v1.base.id] or 0
		local time2 = CurAvatar.newHeadFrameRecord[v2.base.id] or 0

		if time2 == time1 then
			return v1.base.id < v2.base.id
		else
			return time2 < time1
		end
	end)
	table.insert(self.headFrameData, 1, {
		select = not isMatch,
		base = {
			id = Const.DEFAULT_HEAD_FRAME_ID,
			name = Lang.get(30736)
		}
	})

	if isMatch == false then
		self.curHeadFrameItem = self.headFrameData[1]
	end

	isMatch = false
	self.pendantData = {}

	local pendantData = HeadHelper.getOwnHeadPendant()

	for i = 1, #pendantData do
		local d = {}

		d.select = false
		d.base = pendantData[i]

		local endTime = self:isTimeLimitPendant(d.base.head_pendant_id)

		if endTime then
			d.endTime = endTime
		end

		if d.base.head_pendant_id == CurAvatar.headPendantId then
			d.select = true
			isMatch = true
			self.curPendantData = d
		end

		table.insert(self.pendantData, d)
	end

	table.sort(self.pendantData, function(v1, v2)
		local time1 = CurAvatar.newHeadPendantRecord[v1.base.head_pendant_id] or 0
		local time2 = CurAvatar.newHeadPendantRecord[v2.base.head_pendant_id] or 0

		if time2 == time1 then
			return v1.base.head_pendant_id < v2.base.head_pendant_id
		else
			return time2 < time1
		end
	end)
	table.insert(self.pendantData, 1, {
		select = not isMatch,
		base = ResRoleHeadPendant[Const.DEFAULT_HEAD_PENDANT_ID]
	})

	if isMatch == false then
		self.curPendantData = self.pendantData[1]
	end

	self.btnPendant:setVisible(#self.pendantData > 0 and Const.OPEN_NEW_MAZE_PENDANT)

	isMatch = false
	self.chatBubbleData = {}

	local chatBubbleData = HeadHelper.getOwnChatBubble()

	for i = 1, #chatBubbleData do
		local d = {}

		d.select = false
		d.base = chatBubbleData[i]

		local endTime = self:isTimeLimitChatBubble(d.base.id)

		if endTime then
			d.endTime = endTime
		end

		if d.base.id == CurAvatar.chatBubbleId then
			d.select = true
			isMatch = true
			self.curChatBubbleData = d
		end

		table.insert(self.chatBubbleData, d)
	end

	table.insert(self.chatBubbleData, 1, {
		select = not isMatch,
		base = ResRoleChatBubble[Const.DEFAULT_CHAT_BUBBLE_ID]
	})

	if not isMatch then
		self.curChatBubbleData = self.chatBubbleData[1]
	end

	self.btnChatBubble:setVisible(#self.chatBubbleData > 1)

	local result, desc = ClientUtils.isForbideModifyInfo()

	if not result then
		self:onTabButtonClick(self.btnHead)
	else
		self:onTabButtonClick(self.btnHeadFrame)
	end
end

function EditHeadDlg:onOpen(...)
	EditHeadDlg.super.onOpen(self)
	self:initData()
	self:checkHeadFrameValid()
	self:checkHeadPendantValid()
end

function EditHeadDlg:checkHeadFrameValid(...)
	local time = CurAvatar:getHeadFrameEndTime(CurAvatar.headFrameId)

	if time ~= 0 and time <= ClientUtils.getServerTime() then
		self.curHeadFrameItem = self.headFrameData[1]

		CurAvatar:refreshMyAttr("headFrameId", Const.DEFAULT_HEAD_FRAME_ID)
		CurAvatar:refreshNameUI()

		local ui = UIManager.getUI("roleInfoPersonalDlg", nil, false)

		if ui then
			ui:refreshUI()
		end
	end

	self:refreshUI()
end

function EditHeadDlg:checkHeadPendantValid(...)
	local time = CurAvatar:getHeadPendantEndTime(CurAvatar.headPendantId)

	if time ~= 0 and time <= ClientUtils.getServerTime() then
		self.curPendantData = self.pendantData[1]

		CurAvatar:refreshMyAttr("headPendantId", Const.DEFAULT_HEAD_PENDANT_ID)

		CurAvatar.cacheHeadPendantId = self.curPendantData.base.head_pendant_id

		RPC.roleCommChangeHeadPendant(CurAvatar.cacheHeadPendantId)
	end

	self:refreshUI()
end

function EditHeadDlg:refreshState(state)
	local isHead = state == STATE.HEAD
	local isHeadFrame = state == STATE.HEAD_FRAME
	local isHeadPendant = state == STATE.PENDANT
	local isChatBubble = state == STATE.CHAT_BUBBLE

	self.btnHead:setEnable(not isHead)
	self.btnHeadFrame:setEnable(not isHeadFrame)
	self.btnPendant:setEnable(not isHeadPendant)
	self.btnChatBubble:setEnable(not isChatBubble)
	self.panelHead:setVisible(isHead)
	self.panelHeadFrame:setVisible(isHeadFrame)
	self.panelHeadPendant:setVisible(isHeadPendant)
	self.panelChatBubble:setVisible(isChatBubble)

	if isHead then
		self.txtTitle:setText(Lang.get(1547))
		self:onHeadItemClick(self.curHeadData)
		self.scrollHeadView:setTotalCount(#self.headData, 1)
	elseif isHeadFrame then
		self.btnReplace:setVisible(false)
		self.txtTitle:setText(Lang.get(30737))
		self:onHeadFrameItemClick(self.curHeadFrameItem)
		self.scrollHeadFrameView:setTotalCount(#self.headFrameData, 1)
	elseif isHeadPendant then
		self.btnReplace:setVisible(false)
		self.txtTitle:setText(Lang.get(66398))
		self:onPendantClick(self.curPendantData)
		self.scrollPendant:setTotalCount(#self.pendantData, 1)
	elseif isChatBubble then
		self.btnReplace:setVisible(false)
		self.txtTitle:setText(Lang.get(109186))
		self:onChatBubbleItemClick(self.curChatBubbleData)
		self.scrollChatBubble:setTotalCount(#self.chatBubbleData)
	end

	self.btnAllAttr:setVisible(state == STATE.PENDANT)
end

function EditHeadDlg:onHeadFrameCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = HeadFrameItem(sender, "System/Common/Grid/GridPlayerHeadFrame", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(self.headFrameData[newIdx])
end

function EditHeadDlg:onHeadCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = HeadItem(sender, "System/Common/Grid/GridPlayerHead", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(self.headData[newIdx])
end

function EditHeadDlg:onPendantCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = PendantItem(sender, "System/Common/Grid/GridPendant", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(self.pendantData[newIdx])
end

function EditHeadDlg:onChatBubbleCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ChatBubbleItem(sender, "System/Common/Grid/GridPlayerChatBubble", newIdx)
	else
		targetCell.mIndex = newIdx
	end

	targetCell:setData(self.chatBubbleData[newIdx])
end

function EditHeadDlg:onHeadItemClick(v)
	for i, data in ipairs(self.headData) do
		if v ~= data then
			data.select = false
		end
	end

	self.curHeadData = v
	v.select = true

	if self.curHeadData.base.id == Const.PERSONAL_HEAD_ID and HeadHelper.isPosted() then
		self.btnReplace:setVisible(true)
	else
		self.btnReplace:setVisible(false)
	end

	self.scrollHeadView:refreshCells()
	self:refreshCurItem()
	self:setUseBtnState()
end

function EditHeadDlg:onPendantClick(v)
	if v == nil then
		return
	end

	for i, data in ipairs(self.pendantData) do
		if v ~= data then
			data.select = false
		end
	end

	self.curPendantData = v
	v.select = true

	self.scrollPendant:refreshCells()
	self:refreshCurItem()
	self:setUseBtnState()
end

function EditHeadDlg:onHeadFrameItemClick(v)
	for i, data in ipairs(self.headFrameData) do
		if v ~= data then
			data.select = false
		end
	end

	self.curHeadFrameItem = v
	v.select = true

	self.scrollHeadFrameView:refreshCells()
	self:refreshCurItem()
	self:setUseBtnState()
end

function EditHeadDlg:onChatBubbleItemClick(v)
	for i, data in ipairs(self.chatBubbleData) do
		if v ~= data then
			data.select = false
		end
	end

	self.curChatBubbleData = v
	v.select = true

	self.scrollChatBubble:refreshCells()
	self:refreshCurItem()
	self:setUseBtnState()
end

function EditHeadDlg:refreshCurItem(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	self.txtGainWay:setVisible(false)
	self.imgPendantPreview:setVisible(false)
	self.chatBubblePanel:setVisible(false)

	local curAttr

	if self.state == STATE.HEAD then
		if self.curHeadData.base.id == Const.PERSONAL_HEAD_ID then
			HeadHelper.forceSetCustomHead(self.imgHeadPreview)
		else
			HeadHelper.setHeadIcon(self.imgHeadPreview, self.curHeadData.base.id)
		end

		self.txtName:setText(self.curHeadData.base.name or self.curHeadData.name)
		self.imgLimit:setVisible(false)
		self.imgHeadPreview:setVisible(true)
		self.imgHeadFramePreview:setVisible(true)
		HeadHelper.setHeadFrame(self.imgHeadFramePreview, CurAvatar.headFrameId)
	elseif self.state == STATE.HEAD_FRAME then
		local customId, normalId, isCustom = HeadHelper.decodeHeadInfo(CurAvatar.head)

		if isCustom then
			HeadHelper.forceSetCustomHead(self.imgHeadPreview)
		else
			HeadHelper.setHeadIcon(self.imgHeadPreview, CurAvatar.head)
		end

		self.txtName:setText(self.curHeadFrameItem.base.name)

		local desc = self:getGainDesc(self.curHeadFrameItem.base.id)

		if desc then
			self.txtGainWay:setVisible(true)
			self.txtGainWay:setText(desc)
		end

		if self.curHeadFrameItem.endTime then
			self.imgLimit:setVisible(true)

			if self.curHeadFrameItem.endTime > ClientUtils.getServerTime() then
				self.imgLimit:setImage(ICON_PATH, "TxtLimit01")
			else
				self.imgLimit:setImage(ICON_PATH, "TxtLimit02")
			end

			self:refreshTimeDown()
		else
			self.imgLimit:setVisible(false)
		end

		HeadHelper.setHeadFrame(self.imgHeadFramePreview, self.curHeadFrameItem.base.id)
		self.imgHeadFramePreview:setVisible(true)
		self.imgHeadPreview:setVisible(true)
	elseif self.state == STATE.PENDANT then
		self.txtName:setText(self.curPendantData.base.name or self.curPendantData.name)
		self.imgPendantPreview:setImage(self.curPendantData.base.picture_path, self.curPendantData.base.picture_name)
		self.imgPendantPreview:setVisible(true)
		self.imgHeadFramePreview:setVisible(false)
		self.imgHeadPreview:setVisible(false)

		if self.curPendantData.endTime then
			self.imgLimit:setVisible(true)

			if self.curPendantData.endTime > ClientUtils.getServerTime() then
				self.imgLimit:setImage(ICON_PATH, "TxtLimit01")
			else
				self.imgLimit:setImage(ICON_PATH, "TxtLimit02")
			end

			self:refreshPendantTimeDown()
		else
			self.imgLimit:setVisible(false)
		end

		if self.curPendantData.base.desc then
			self.txtGainWay:setVisible(true)
			self.txtGainWay:setText(self.curPendantData.base.desc)
		end

		local attr = self.curPendantData.base.attrs

		if attr and next(attr) then
			curAttr = attr
		end
	elseif self.state == STATE.CHAT_BUBBLE then
		self.imgHeadPreview:setVisible(true)
		self.imgHeadFramePreview:setVisible(true)
		self.txtGainWay:setVisible(true)

		local customId, normalId, isCustom = HeadHelper.decodeHeadInfo(CurAvatar.head)

		if isCustom then
			HeadHelper.forceSetCustomHead(self.imgHeadPreview)
		else
			HeadHelper.setHeadIcon(self.imgHeadPreview, CurAvatar.head)
		end

		HeadHelper.setHeadFrame(self.imgHeadFramePreview, CurAvatar.headFrameId)

		local bubbleConfig = self.curChatBubbleData.base

		self.txtName:setText(bubbleConfig.name)
		self.txtGainWay:setText(bubbleConfig.desc or "")
		self.chatBubblePanel:setVisible(true)
		self.imgChatBubble:setImage("Atlas/ChatAtlas/" .. bubbleConfig.picture_path, bubbleConfig.picture_name)

		if bubbleConfig.color then
			self.txtChatBubble:setColorByRGBA(bubbleConfig.color[1] / 255, bubbleConfig.color[2] / 255, bubbleConfig.color[3] / 255)
		else
			self.txtChatBubble:setColorByRGBA(1, 1, 1)
		end

		if self.bubbleChild then
			self.bubbleChild:destroy()

			self.bubbleChild = nil
		end

		if bubbleConfig.effect_path then
			self.bubbleChild = UIControls.Child(self, "Bg/ChatBubblePanel/ImgChatBubble", bubbleConfig.effect_path)

			self.bubbleChild:setVisible(true)
		end

		local checkEndTime = self.curChatBubbleData.endTime ~= nil and self.curChatBubbleData.endTime > 0

		self.imgLimit:setVisible(checkEndTime)

		if checkEndTime then
			if self.curChatBubbleData.endTime > ClientUtils.getServerTime() then
				self.imgLimit:setImage(ICON_PATH, "TxtLimit01")
			else
				self.imgLimit:setImage(ICON_PATH, "TxtLimit02")
			end

			self:refreshChatBubbleTimeDown()
		end
	end

	if curAttr then
		self.panelAttr:setVisible(true)

		for index, cell in ipairs(self.attrCells) do
			if curAttr[index] then
				cell:setVisible(true)
				cell:setTypeData(curAttr[index].type, curAttr[index].value)
			else
				cell:setVisible(false)
			end
		end
	else
		self.panelAttr:setVisible(false)
	end
end

function EditHeadDlg:refreshTimeDown(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	if self.curHeadFrameItem and self.curHeadFrameItem.endTime then
		local leftTime = self.curHeadFrameItem.endTime - ClientUtils.getServerTime()

		if leftTime > 0 then
			self.txtTime:setVisible(true)
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48659), Slot(self.checkHeadFrameValid, self), nil)
		else
			self.txtTime:setVisible(true)
			self.txtTime:setText(Lang.get(653))
		end
	else
		self.txtTime:setVisible(false)
	end
end

function EditHeadDlg:refreshPendantTimeDown(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	if self.curPendantData and self.curPendantData.endTime then
		local leftTime = self.curPendantData.endTime - ClientUtils.getServerTime()

		if leftTime > 0 then
			self.txtTime:setVisible(true)
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48659), Slot(self.checkHeadPendantValid, self), nil)
		else
			self.txtTime:setVisible(true)
			self.txtTime:setText(Lang.get(653))
		end
	else
		self.txtTime:setVisible(false)
	end
end

function EditHeadDlg:refreshChatBubbleTimeDown(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	if self.curChatBubbleData and self.curChatBubbleData.endTime then
		local leftTime = self.curChatBubbleData.endTime - ClientUtils.getServerTime()

		self.txtTime:setVisible(true)

		if leftTime > 0 then
			self.slotRefreshUI = self.slotRefreshUI or Slot(self.refreshUI, self)

			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48659), self.slotRefreshUI)
		else
			self.txtTime:setText(Lang.get(653))
		end
	else
		self.txtTime:setVisible(false)
	end
end

function EditHeadDlg:isTimeLimitItem(id)
	local time = CurAvatar:getHeadFrameEndTime(id)

	if time > 0 then
		return time
	end
end

function EditHeadDlg:isTimeLimitPendant(id)
	local time = CurAvatar:getHeadPendantEndTime(id)

	if time > 0 then
		return time
	end
end

function EditHeadDlg:isTimeLimitChatBubble(id)
	local time = CurAvatar:getChatBubbleEndTime(id)

	if time > 0 then
		return time
	end
end

function EditHeadDlg:getGainDesc(id)
	local info = HeadHelper.getHeadFrameInfoById(id)

	if info then
		return info.desc or ""
	end

	return ""
end

function EditHeadDlg:refreshBtnState(item)
	return
end

function EditHeadDlg:onAllAttrClick()
	UIManager.getUI("headPendantAttrDlg", true):onShow(self.pendantData)
end

function EditHeadDlg:setUseBtnState(...)
	local state = BTN_STATE.NONE
	local text = ""

	if self.state == STATE.HEAD then
		self.btnUse:setVisible(true)

		local customId, normalId, isCustom = HeadHelper.decodeHeadInfo(CurAvatar.head)

		if isCustom then
			if self.curHeadData.base.id == Const.PERSONAL_HEAD_ID then
				state = BTN_STATE.USING
				text = Lang.get(901)
			else
				text = Lang.get(588)
				state = BTN_STATE.USE
			end
		elseif self.curHeadData.base.id == normalId then
			state = BTN_STATE.USING
			text = Lang.get(901)
		else
			text = Lang.get(588)
			state = BTN_STATE.USE
		end
	elseif self.state == STATE.HEAD_FRAME then
		if self.curHeadFrameItem.endTime and self.curHeadFrameItem.endTime < ClientUtils.getServerTime() then
			self.btnUse:setVisible(false)
		else
			self.btnUse:setVisible(true)

			if self.curHeadFrameItem.base.id ~= CurAvatar.headFrameId then
				state = BTN_STATE.USE
				text = Lang.get(588)
			else
				state = BTN_STATE.USING
				text = Lang.get(901)
			end
		end
	elseif self.state == STATE.PENDANT then
		if self.curPendantData.endTime and self.curPendantData.endTime < ClientUtils.getServerTime() then
			self.btnUse:setVisible(false)
		else
			self.btnUse:setVisible(true)

			if self.curPendantData.base.head_pendant_id ~= CurAvatar.headPendantId then
				state = BTN_STATE.USE
				text = Lang.get(588)
			else
				state = BTN_STATE.USING
				text = Lang.get(901)
			end
		end
	elseif self.state == STATE.CHAT_BUBBLE then
		if self.curChatBubbleData.endTime and self.curChatBubbleData.endTime < ClientUtils.getServerTime() then
			self.btnUse:setVisible(false)
		else
			self.btnUse:setVisible(true)

			if self.curChatBubbleData.base.id ~= CurAvatar.chatBubbleId then
				state = BTN_STATE.USE
				text = Lang.get(588)
			else
				state = BTN_STATE.USING
				text = Lang.get(901)
			end
		end
	end

	self.btnUse.state = state

	self.btnUse:setText(text)
	self.btnUse:setEnable(state ~= BTN_STATE.USING)
end

function EditHeadDlg:setCustomHeadSelectState()
	for i, data in ipairs(self.headData) do
		if data.base.id == Const.PERSONAL_HEAD_ID then
			self:onHeadItemClick(data)

			break
		end
	end
end

function EditHeadDlg:refreshUI(...)
	if self.isDestroy == true then
		return
	end

	if self.state == STATE.HEAD then
		self.scrollHeadView:refreshCells()
	elseif self.state == STATE.HEAD_FRAME then
		self.scrollHeadFrameView:refreshCells()
	elseif self.state == STATE.PENDANT then
		self.scrollPendant:refreshCells()
	elseif self.state == STATE.CHAT_BUBBLE then
		self.scrollChatBubble:refreshCells()
	end

	self:refreshCurItem()
	self:setUseBtnState()
end

function EditHeadDlg:pickImage(...)
	local nextPostTime = UserData.loadCommonDataInt(CurAvatar.uid .. "_nextPostHeadTime")

	if nextPostTime ~= 0 and nextPostTime > ClientUtils.getServerTime() then
		local timeStr = utils.calcTimeTxt(nextPostTime - ClientUtils.getServerTime())

		MsgManager.notice(string.format(Lang.get(30735), timeStr))

		return
	end

	local curCustomId, curNormalId, curIsCustom = HeadHelper.decodeHeadInfo(CurAvatar.head)

	HeadHelper.pickImage(function(code, msg)
		local data = ClientUtils.string2Table(msg)

		HeadHelper.refreshMyHeadPostStatus(code, data.status)
		self:refreshUI()

		if ClientUtils.record.headStatus == Const.CUSTOM_HEAD_STATUS.POST_OK then
			self:setHeadPost()
		elseif ClientUtils.record.headStatus == Const.CUSTOM_HEAD_STATUS.REVIEWING then
			self:setHeadPost()
			HeadHelper.setDelayCheckTime()
		else
			self:refreshUI()
		end
	end, Slot(self.refreshUI, self), curCustomId + 1)
end

function EditHeadDlg:setHeadPost(...)
	HeadHelper.deleteMyCache()

	CurAvatar.cacheHeadId = self:getNewHeadId(Const.PERSONAL_HEAD_ID, true, false)

	RPC.roleCommChangeHead(CurAvatar.cacheHeadId)

	if HeadHelper.isCustomHead(CurAvatar.head) then
		CurAvatar.noNeedTipChangeHeadOk = true
	else
		local curCustomId, curNormalId, curIsCustom = HeadHelper.decodeHeadInfo(CurAvatar.head)

		if curCustomId > Const.PERSONAL_HEAD_ID then
			CurAvatar.noNeedTipChangeHeadOk = true
		end
	end

	local nextPostTime = ClientUtils.getServerTime() + Const.POST_HEAD_INTERVAL

	UserData.saveCommonDataInt(CurAvatar.uid .. "_nextPostHeadTime", nextPostTime)
end

function EditHeadDlg:getNewHeadId(headId, isCustom, isUse)
	local curCustomId, curNormalId, curIsCustom = HeadHelper.decodeHeadInfo(CurAvatar.head)

	if isCustom == true then
		if isUse ~= true then
			curCustomId = curCustomId + 1
		end

		for i, data in pairs(ResRoleHead) do
			if (not data.heroid or CurAvatar.handBookHeroDic[data.heroid]) and i ~= curNormalId then
				curNormalId = i

				break
			end
		end

		return HeadHelper.encodeHeadInfo(curCustomId, curNormalId, true)
	elseif headId then
		return HeadHelper.encodeHeadInfo(curCustomId, headId, false)
	end
end

function EditHeadDlg:_postCallBack(...)
	self:refreshUI()
	CurAvatar:refreshNameUI()
	CurAvatar:refreshRoleInfoUI()
end

function EditHeadDlg:onBtnReplaceClick(...)
	self:pickImage()
end

function EditHeadDlg:onBtnUseClick(...)
	local state = self.btnUse.state

	if state == BTN_STATE.USE then
		if self.state == STATE.HEAD then
			local hint = self:getClickHint()

			if hint then
				MsgManager.notice(hint)
			else
				CurAvatar.cacheHeadId = self:getNewHeadId(self.curHeadData.base.id, self.curHeadData.base.id == Const.PERSONAL_HEAD_ID, true)

				RPC.roleCommChangeHead(CurAvatar.cacheHeadId)
			end
		elseif self.state == STATE.HEAD_FRAME then
			CurAvatar.cacheHeadFrameId = self.curHeadFrameItem.base.id

			RPC.roleCommChangeHeadFrame(CurAvatar.cacheHeadFrameId)
		elseif self.state == STATE.PENDANT then
			CurAvatar.cacheHeadPendantId = self.curPendantData.base.head_pendant_id

			RPC.roleCommChangeHeadPendant(CurAvatar.cacheHeadPendantId)
		elseif self.state == STATE.CHAT_BUBBLE then
			local checkDefault = self.curChatBubbleData.base.id == Const.DEFAULT_CHAT_BUBBLE_ID

			if checkDefault then
				RPC.roleCommChangeBubble(0)
			else
				RPC.roleCommChangeBubble(self.curChatBubbleData.base.id)
			end
		end
	end
end

function EditHeadDlg:getClickHint()
	if self.curHeadData.base.id == Const.PERSONAL_HEAD_ID then
		local status = ClientUtils.record.headStatus

		if status == Const.CUSTOM_HEAD_STATUS.UP_LOADING then
			return Lang.get(30738)
		elseif status == Const.CUSTOM_HEAD_STATUS.REVIEWING then
			return Lang.get(30739)
		elseif status == Const.CUSTOM_HEAD_STATUS.FORBID then
			return Lang.get(30740)
		elseif status == Const.CUSTOM_HEAD_STATUS.UP_LOAD_FAILD then
			return Lang.get(30741)
		end
	end
end

function EditHeadDlg:onBtnCloseClick(...)
	if self.state == STATE.HEAD then
		CurAvatar:refreshNewHeadRecord()
	end

	if self.state == STATE.HEAD_FRAME then
		CurAvatar:refreshNewHeadFrameRecord()
	end

	if self.state == STATE.PENDANT then
		CurAvatar:refreshNewHeadPendantRecord()
	end

	if self.state == STATE.CHAT_BUBBLE then
		CurAvatar:clearChatBubbleRed(0)
	end

	self:setVisible(false)
end

function EditHeadDlg:onTabButtonClick(sender)
	if sender == self.btnHead then
		local result, desc = ClientUtils.isForbideModifyInfo()

		if result then
			MsgManager.notice(desc)

			return
		end

		self.state = STATE.HEAD

		self:refreshState(STATE.HEAD)
	elseif sender == self.btnHeadFrame then
		self.state = STATE.HEAD_FRAME

		self:refreshState(STATE.HEAD_FRAME)
	elseif sender == self.btnPendant then
		self.state = STATE.PENDANT

		self:refreshState(STATE.PENDANT)
	elseif sender == self.btnChatBubble then
		self.state = STATE.CHAT_BUBBLE

		self:refreshState(STATE.CHAT_BUBBLE)
	end
end

function EditHeadDlg:destroy(...)
	self.isDestroy = true

	EditHeadDlg.super.destroy(self)
end

return EditHeadDlg
