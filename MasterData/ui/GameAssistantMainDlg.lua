-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\GameAssistantMainDlg.lua

local ResGameAssistant = require("ClientData/ResGameAssistant")
local ResGameAssistantLink = require("ClientData/ResGameAssistantLink")
local WebView = require("SDK/Plugin/WebView")
local UserData = require("Helper/UserData")
local strClassName = "BtnGameAssistantWord"
local BtnGameAssistantWord = Class(strClassName, UIControls.Child)

function BtnGameAssistantWord:ctor()
	self.btnNml = UIControls.Button(self, "BtnNml")

	self.btnNml:addEventClick(self.onBtnNmlClick)

	self.textWord = UIControls.Label(self, "BtnNml/TextWord1")
end

function BtnGameAssistantWord:setData(type, resId)
	self.type = type
	self.resId = resId

	if self.type == Const.ASSIST_MSG_TYPE.Link then
		self.data = ResGameAssistantLink[resId]

		self.textWord:setText(self.data.link_title)
	elseif self.type == Const.ASSIST_MSG_TYPE.Assist then
		self.data = ResGameAssistant[resId]

		self.textWord:setText(self.data.title)
	elseif self.type == Const.ASSIST_MSG_TYPE.History then
		self.data = ResGameAssistant[resId]

		self.textWord:setText(self.data.title)
	end
end

function BtnGameAssistantWord:onBtnNmlClick()
	if self.type == Const.ASSIST_MSG_TYPE.Link then
		local url = self.data.link_address

		WebView.unityOpenUrl(url)
	elseif self.type == Const.ASSIST_MSG_TYPE.Assist then
		self.mWindow.gameAssistantChatPanel:onMsgSend(nil, self.data.title or "")
	elseif self.type == Const.ASSIST_MSG_TYPE.History then
		self.mWindow.gameAssistantChatPanel:onMsgSend(nil, self.data.title or "")
	end
end

local SPACE_HEIGHT = 20
local TOTAL_WIDTH = 500
local BG_WIDTH = 64
local MY_TEXT_MIN_HEIGHT = 30
local strClassName = "GameAssistantChatCell"
local GameAssistantChatCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function GameAssistantChatCell:ctor()
	self.chatSelfPanel = UIControls.Panel(self, "ChatSelfPanel")
	self.chatOthersPanel = UIControls.Panel(self, "ChatOthersPanel")
	self.textMyMessage = UIControls.Label(self, "ChatSelfPanel/BgMessage/TextMessage")
	self.bgMessage = UIControls.Panel(self, "ChatSelfPanel/BgMessage")
	self.textDesc = UIControls.Label(self, "ChatOthersPanel/BgMessage/TextDesc")
	self.linkCells = {}
	self.assistCells = {}
	self.recommendPanel = UIControls.Panel(self, "ChatOthersPanel/BgMessage/RecommendPanel")
	self.recommendPanel1 = UIControls.Panel(self, "ChatOthersPanel/BgMessage/RecommendPanel1")
	self.linkPanel = UIControls.Panel(self, "ChatOthersPanel/BgMessage/LinkPanel")
	self.textTitle = UIControls.Label(self, "ChatOthersPanel/BgMessage/TextTitle")
end

function GameAssistantChatCell:setData(data)
	local h = SPACE_HEIGHT

	if data.id == Const.DEFAULT_ASSIST_MSG_MY then
		self.chatSelfPanel:setVisible(true)
		self.chatOthersPanel:setVisible(false)
		self.textMyMessage:setText(data.content or "")

		if self.btnHead == nil then
			self.btnHead = UIControls.PlayerHeadGridChild(self, "ChatSelfPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

			self.btnHead:setEnable(false)
		end

		self.btnHead:setCommInfo(CurAvatar:getMyCommInfo(), false, self)

		local width = self.textMyMessage:getWidth()
		local w = math.min(width, TOTAL_WIDTH)
		local h = math.max(self.textMyMessage:getHeight(), MY_TEXT_MIN_HEIGHT)

		self.textMyMessage:setSize(w, h)

		h = h + self.textMyMessage:getHeight() + SPACE_HEIGHT

		self.bgMessage:setRectSize(w + BG_WIDTH, h)
		self.chatSelfPanel:setRectSize(0, h)
		self:setLayoutSize(nil, h + SPACE_HEIGHT)
	else
		self.chatSelfPanel:setVisible(false)
		self.chatOthersPanel:setVisible(true)

		local replyData = ResGameAssistant[data.id]

		if replyData then
			self.textTitle:setText(replyData.title or "")
			self.textDesc:setText(replyData.content or "")
			self.linkPanel:setVisible(replyData.link_id ~= nil and #replyData.link_id ~= 0)
			self.recommendPanel:setVisible(replyData.assist_id ~= nil and #replyData.assist_id ~= 0)
			self.recommendPanel1:setVisible(replyData.assist_id ~= nil and #replyData.assist_id > 3)

			for i, v in ipairs(replyData.link_id or {}) do
				local linkCell = self.linkCells[i]

				if linkCell == nil then
					linkCell = BtnGameAssistantWord(self, "ChatOthersPanel/BgMessage/LinkPanel", "System/GameAssistant/BtnGameAssistantWord1", 0, 0, true)
				end

				linkCell:setData(Const.ASSIST_MSG_TYPE.Link, v)

				self.linkCells[i] = linkCell
			end

			local linkNum = replyData.link_id and #replyData.link_id or 0

			if linkNum < #self.linkCells then
				for i = linkNum + 1, #self.linkCells do
					self.linkCells[i]:destroy()

					self.linkCells[i] = nil
				end
			end

			for i, v in ipairs(replyData.assist_id or {}) do
				local path = "ChatOthersPanel/BgMessage/RecommendPanel"

				if i > 3 then
					path = "ChatOthersPanel/BgMessage/RecommendPanel1"
				end

				local assistCell = self.assistCells[i]

				if assistCell == nil then
					assistCell = BtnGameAssistantWord(self, path, "System/GameAssistant/BtnGameAssistantWord2", 0, 0, true)
				end

				assistCell:setData(Const.ASSIST_MSG_TYPE.Assist, v)

				self.assistCells[i] = assistCell
			end

			local assistNum = replyData.assist_id and #replyData.assist_id or 0

			if assistNum < #self.assistCells then
				for i = assistNum + 1, #self.assistCells do
					self.assistCells[i]:destroy()

					self.assistCells[i] = nil
				end
			end

			h = h + self.textTitle:getHeight() + SPACE_HEIGHT + self.textDesc:getHeight() + SPACE_HEIGHT

			if self.linkPanel:getVisible() then
				local size = self.linkPanel:getRectSize()

				h = h + size.height + SPACE_HEIGHT
			end

			if self.recommendPanel:getVisible() then
				local size = self.recommendPanel:getRectSize()

				h = h + size.height + SPACE_HEIGHT
			end

			if self.recommendPanel1:getVisible() then
				local size = self.recommendPanel1:getRectSize()

				h = h + size.height + SPACE_HEIGHT
			end

			self.chatOthersPanel:setRectSize(0, h)
			self:setLayoutSize(nil, h + SPACE_HEIGHT)
		end
	end
end

local strClassName = "GameAssistantChatPanel"
local GameAssistantChatPanel = Class(strClassName, UIControls.Child)

function GameAssistantChatPanel:ctor()
	self.showText = UIControls.Label(self, "ShowPanel/BgText/Text")

	self.showText:setText(ClientUtils.getClientNotice(779))

	self.btnHistory = UIControls.Button(self, "ShowPanel/BtnHistory")

	self.btnHistory:addEventClick(self.onBtnHistoryClick)

	self.historyPanel = UIControls.Panel(self, "HistoryPanel")
	self.uIClickThrough = UIControls.Button(self, "UIClickThrough")

	self.uIClickThrough:addEventClick(self.onUIClickThroughClick)

	self.btnSend = UIControls.Button(self, "ChatMainPanel/InputPanel/BtnSend")

	self.btnSend:addEventClick(self.onMsgSend)

	self.editInput = UIControls.Input(self, "ChatMainPanel/InputPanel/InputTextPanel/InputText")
	self.imgUnread = UIControls.Button(self, "ChatMainPanel/ImgUnread")

	self.imgUnread:addEventClick(self.onBtnUnreadClick)

	self.cells = {}
	self.view = UIControls.ScrollViewLoopV(self, "ChatMainPanel/MessagePanel")

	self.view:addEventCellChanged(self.onCellChanged)

	self.listHistoryScroll = UIControls.ScrollViewLoopV(self, "HistoryPanel/ListHistory", 0, self.onHistoryChanged)
	self.historyCells = {}
end

function GameAssistantChatPanel:setData(pushList)
	self.mMsgDatas = {}
	self.historyData = {}

	local assistHistoryStr = UserData.loadCommonData("GameAssistantHistory" .. CurAvatar.uid)
	local assistHistoryTable = ClientUtils.string2Table(assistHistoryStr) or {}

	for _, assist_id in pairs(assistHistoryTable) do
		table.insert(self.historyData, assist_id)
	end

	for i, v in ipairs(pushList or {}) do
		self:addChatDataById(v.assist_id)
	end

	self:refreshHistoryCell()
	self.imgUnread:setVisible(#pushList >= 2)
end

function GameAssistantChatPanel:addChatDataById(assistId)
	local inputContent = ResGameAssistant[assistId].title

	table.insert(self.mMsgDatas, {
		id = Const.DEFAULT_ASSIST_MSG_MY,
		content = inputContent
	})
	table.insert(self.mMsgDatas, {
		id = assistId
	})
	self:refreshList(1)
end

function GameAssistantChatPanel:addChatData(inputContent)
	table.insert(self.mMsgDatas, {
		id = Const.DEFAULT_ASSIST_MSG_MY,
		content = inputContent
	})

	local replyId = self:getReplyData(inputContent)

	table.insert(self.mMsgDatas, {
		id = replyId
	})
	self:refreshList(1)
end

function GameAssistantChatPanel:getReplyData(inputContent)
	for id, data in ipairs(ResGameAssistant) do
		if id ~= Const.DEFAULT_ASSIST_MSG_ID then
			for _, c in pairs(data.key_word or {}) do
				local isMatch = string.find(c, inputContent)

				if isMatch then
					return id
				end
			end

			if string.find(data.title, inputContent) ~= nil then
				return id
			end
		end
	end

	return Const.DEFAULT_ASSIST_MSG_ID
end

function GameAssistantChatPanel:refreshListTop(...)
	self:refreshList(#self.mMsgDatas)
end

function GameAssistantChatPanel:refreshList(jumpIdx)
	local count = #self.mMsgDatas

	self.view:setTotalCount(count, jumpIdx)
end

function GameAssistantChatPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = GameAssistantChatCell(sender, "System/GameAssistant/GameAssistantChatCell", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setVisible(false)
	targetCell:setData(self.mMsgDatas[newIdx])
	targetCell:setVisible(true)

	self.cells[newIdx] = targetCell
end

function GameAssistantChatPanel:onMsgSend(sender, content)
	local clear = true
	local text = ""

	if content then
		clear = false
		text = content
	else
		text = self.editInput:getText()
	end

	if text == "" then
		MsgManager.notice(Lang.get(30165))

		return
	end

	if self:_checkMsgLength(text) == false then
		return
	end

	local res = self:checkContent(text)

	if clear then
		self.editInput:setText("")
	end

	self:addChatData(res)
end

function GameAssistantChatPanel:_checkMsgLength(text)
	local len = utils.utf8len(text, 2)

	if len > Const.MAX_CHAT_CHARACTER then
		MsgManager.notice(Lang.get(30166))

		return false
	end

	return true
end

function GameAssistantChatPanel:checkContent(text)
	local res = string.gsub(text, "\r\n", "")

	for s in string.gmatch(res, "<.->") do
		res = string.gsub(res, s, "")
	end

	return res
end

function GameAssistantChatPanel:refreshHistoryCell()
	for i, id in pairs(self.historyData or {}) do
		local cell = self.historyCells[i]

		if cell == nil then
			cell = BtnGameAssistantWord(self, "HistoryPanel/ListHistory/Content", "System/GameAssistant/BtnGameAssistantHistory", 0, 0, true)
		end

		self.historyCells[i] = cell

		cell:setData(Const.ASSIST_MSG_TYPE.History, id)
	end

	if #self.historyCells > #self.historyData then
		for i = #self.historyData + 1, #self.historyCells do
			self.historyCells[i]:destroy()

			self.historyCells[i] = nil
		end
	end
end

function GameAssistantChatPanel:onBtnUnreadClick()
	self.imgUnread:setVisible(false)
	self:refreshListTop()
end

function GameAssistantChatPanel:onBtnHistoryClick()
	self.historyPanel:setVisible(true)
	self.uIClickThrough:setVisible(true)
end

function GameAssistantChatPanel:onUIClickThroughClick()
	self.historyPanel:setVisible(false)
	self.uIClickThrough:setVisible(false)
end

local strClassName = "GameAssistantMainDlg"
local GameAssistantMainDlg = Class(strClassName, UIControls.Window)

function GameAssistantMainDlg:ctor()
	self:initUI()
end

function GameAssistantMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.tabPanel = UIControls.Panel(self, "MainInfoPanel/TabPanel")

	self.tabPanel:setVisible(false)

	self.gameAssistantChatPanel = GameAssistantChatPanel(self, "MainInfoPanel", "System/GameAssistant/GameAssistantChatPanel", 0, 0, true)
end

function GameAssistantMainDlg:setData()
	self.pushList = {}

	for i, v in ipairs(CurAvatar.pushAssistDataCache or {}) do
		table.insert(self.pushList, v)
	end

	CurAvatar.pushAssistDataCache = {}

	RedDotManager.setKeyState(UIConst.RD_HINT_GAME_ASSISTANT, false)
	self.gameAssistantChatPanel:setData(self.pushList)
end

function GameAssistantMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

function GameAssistantMainDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_GAME_ASSISTANT)
end

return GameAssistantMainDlg
