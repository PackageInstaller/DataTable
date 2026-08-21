-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\ChatEmojiBox.lua

local ResChatDynamicIcon = require("ClientData/ResChatDynamicIcon")
local EMOJI_CONFIG = {
	[UIConst.EMOJI_TYPE_MOVE] = {
		tabShowFunc = "isMoveEmojiTabShow",
		panel = "panelMoveEmoji",
		refreshFunc = "initMoveEmoji",
		type = UIConst.EMOJI_TYPE_MOVE,
		redHint = UIConst.RD_HINT_CHAT_DYNAMIC_ICON_NEW
	},
	[UIConst.EMOJI_TYPE_LARGE] = {
		panel = "panelLargeEmoji",
		refreshFunc = "initLargeEmoji",
		type = UIConst.EMOJI_TYPE_LARGE
	},
	[UIConst.EMOJI_TYPE_PLAYER] = {
		tabShowFunc = "isPlayerEmojiTabShow",
		panel = "panelPlayerEmoji",
		refreshFunc = "initPlayerEmoji",
		type = UIConst.EMOJI_TYPE_PLAYER
	}
}
local MAX_PER_ROW = 6
local BaseEmojiCell = Class("BaseEmojiCell", UIControls.Child)

function BaseEmojiCell:ctor(...)
	self:initUI()
end

function BaseEmojiCell:initUI(...)
	self.btn = UIControls.Button(self, "", nil, true)

	self.btn:addEventClick(self.onEmojiSelect)

	self._emojiInfo = nil
	self.mEventEmojiSelect = nil
end

function BaseEmojiCell:setData(type, id, info)
	self._emojiInfo = id
	self.info = info

	self:setVisible(true)

	if type == UIConst.EMOJI_TYPE_MOVE and self.info then
		local prefabName = self.info.path

		UIControls.Child(self, "", "System/Chat/ChatMoveEmoji/" .. prefabName, 0, 0, true)
	end
end

function BaseEmojiCell:checkRedHint(...)
	local isNew = CurAvatar.remindNewIconMap and CurAvatar.remindNewIconMap[self.info.item_id]

	if not self.iconNew then
		self.iconNew = UIControls.Image(self, "IconNew")
	end

	self.iconNew:setVisible(isNew)

	return isNew
end

function BaseEmojiCell:setSize(size)
	return
end

function BaseEmojiCell:onEmojiSelect(sender)
	if self._emojiInfo ~= nil and self.mEventEmojiSelect ~= nil then
		self.mEventEmojiSelect(self._emojiInfo)
	end

	if CurAvatar.remindNewIconMap and self.info then
		CurAvatar.remindNewIconMap[self.info.item_id] = nil

		self:checkRedHint()
	end
end

local ChatEmojiCell = Class("ChatEmojiCell", BaseEmojiCell)

function ChatEmojiCell:ctor(window, url, prefabPath, x, y, defVisible)
	return
end

function ChatEmojiCell:initUI(...)
	ChatEmojiCell.super.initUI(self)

	self.txtContent = UIControls.Label(self, "EmojiText")
end

function ChatEmojiCell:setSize(size)
	self.txtContent:setFontSize(size)
end

function ChatEmojiCell:setData(type, name)
	self._emojiInfo = name

	self.txtContent:setText(self._emojiInfo)
	self:setVisible(true)
end

local strClassName = "ChatEmojiBox"
local ChatEmojiBox = Class(strClassName, UIControls.Window)

function ChatEmojiBox:ctor()
	self:initUI()

	self.foucsInput = nil
	self.sendFunc = nil
end

function ChatEmojiBox:initUI()
	self.btnClose = UIControls.Button(self, "EmoMainPanel/BtnClose")

	self.btnClose:addEventClick(self.onBoxClose)

	self.panelMoveEmoji = UIControls.Panel(self, "EmoMainPanel/MoveEmoPanel")
	self.panelLargeEmoji = UIControls.Panel(self, "EmoMainPanel/LargeEmoPanel")
	self.panelPlayerEmoji = UIControls.Panel(self, "EmoMainPanel/PlayerEmoPanel")
	self.scrollViewMoveEmoji = UIControls.ScrollView(self, "EmoMainPanel/MoveEmoPanel/LargeContentPanel")
	self.tabs = {}

	local config
	local count = utils.getTableElemCount(UIConst.EMOJI_DATA)

	for i = 1, count do
		local path = "EmoMainPanel/TabPanel/BtnEmo" .. i
		local tab = UIControls.Button(self, path)
		local type = UIConst.EMOJI_DATA[i].type

		config = EMOJI_CONFIG[type]
		tab.config = config
		tab.index = i

		if config.tabShowFunc and self[config.tabShowFunc] then
			tab:setVisible(self[config.tabShowFunc](self))
		end

		if config.redHint then
			tab.redHint = UIControls.RedDot(self, path .. "/IconNew")

			tab.redHint:addHint({
				config.redHint
			})
		end

		tab:addEventClick(self.onTabClick)
		table.insert(self.tabs, tab)
	end

	self.slot4MoveEmojiSelect = Slot(self.onMoveEmojiSelect, self)
	self.slot4LargeEmojiSelect = Slot(self.onLargeEmojiSelect, self)
	self.slot4PlayerEmojiSelect = Slot(self.onPlayerEmojiSelect, self)
	self.curType = nil
	self.cells = {}
	self.largeCells = {}
end

function ChatEmojiBox:show(inputControl, sendFunc, inVisibleFunc)
	self.foucsInput = inputControl
	self.sendFunc = sendFunc
	self.inVisibleFunc = inVisibleFunc

	if not self:getVisible() then
		self:setVisible(true)
	end

	local index = 2

	self.emojicells = {}

	self:onTabClick(self.tabs[index])
end

function ChatEmojiBox:isMoveEmojiTabShow(...)
	if not CurAvatar then
		return false
	end

	return utils.getTableElemCount(CurAvatar.dynamicIcons) > 0
end

function ChatEmojiBox:isPlayerEmojiTabShow()
	return Const.PLAYER_EMOJI_OPEN
end

function ChatEmojiBox:isOwnMoveEmoji(itemId)
	if CurAvatar.dynamicIcons then
		return CurAvatar.dynamicIcons[itemId] ~= nil
	end
end

function ChatEmojiBox:initMoveEmoji(tabType)
	if self.emojicells[tabType] then
		for i, cell in ipairs(self.cells) do
			cell:checkRedHint()
		end

		return
	end

	self.emojicells[tabType] = true

	local emojis = UIConst.EMOJI_DATA[tabType].data
	local newIndex = -1
	local index = #self.cells
	local haveItemInfos = {}

	for id, info in pairs(ResChatDynamicIcon) do
		if info.item_id and self:isOwnMoveEmoji(info.item_id) then
			table.insert(haveItemInfos, info)
		end
	end

	local function sortfun(a, b)
		return a.id < b.id
	end

	table.sort(haveItemInfos, sortfun)

	for i, info in pairs(haveItemInfos) do
		local cell = BaseEmojiCell(self, "EmoMainPanel/MoveEmoPanel/LargeContentPanel/Content", "System/Chat/ChatMoveEmoCell")

		cell.mEventEmojiSelect = self.slot4MoveEmojiSelect

		cell:setData(UIConst.EMOJI_TYPE_MOVE, info.item_id, info)

		index = index + 1
		self.cells[index] = cell

		if cell:checkRedHint() and newIndex == -1 then
			newIndex = i
		end
	end

	if newIndex ~= -1 then
		self.scrollViewMoveEmoji:gotoIndexVertical(math.ceil(newIndex / MAX_PER_ROW), 256)
	end

	CurAvatar.remindNewIconMap = {}

	CurAvatar:saveRemindNewIcon()
end

function ChatEmojiBox:initLargeEmoji(tabType)
	if self.emojicells[tabType] then
		return
	end

	self.emojicells[tabType] = true

	local emojis = UIConst.EMOJI_DATA[tabType].data

	for i, name in ipairs(emojis) do
		local cell = ChatEmojiCell(self, "EmoMainPanel/LargeEmoPanel/LargeContentPanel/Content", "System/Chat/ChatLargeEmoCell")

		cell.mEventEmojiSelect = self.slot4LargeEmojiSelect

		cell:setData(UIConst.EMOJI_TYPE_LARGE, name)
	end
end

function ChatEmojiBox:initPlayerEmoji(tabType)
	if self.emojicells[tabType] then
		return
	end

	self.emojicells[tabType] = true

	local emojis = UIConst.EMOJI_DATA[tabType].data

	for i, name in ipairs(emojis) do
		local cell = ChatEmojiCell(self, "EmoMainPanel/PlayerEmoPanel/LargeContentPanel/Content", "System/Chat/ChatLargeEmoCell")

		cell.mEventEmojiSelect = self.slot4PlayerEmojiSelect

		cell:setData(UIConst.EMOJI_TYPE_PLAYER, name)
	end
end

function ChatEmojiBox:onBoxClose(sender)
	self.foucsInput = nil
	self.sendFunc = nil

	if self.inVisibleFunc then
		self.inVisibleFunc()
	end

	self.inVisibleFunc = nil

	self:setVisible(false)
end

function ChatEmojiBox:destroy(...)
	self:onBoxClose()

	if self.cells then
		for i, cell in ipairs(self.cells) do
			cell:destroy()
		end
	end

	ChatEmojiBox.super.destroy(self)
end

function ChatEmojiBox:onInputDelete(sender)
	if self.foucsInput == nil then
		return
	end

	local text = self.foucsInput:getText()
	local lenText = string.len(text)
	local emojis = self.emojiMap[self.curType]

	for i, name in ipairs(emojis) do
		local emoji = name
		local l = string.len(emoji)

		if l <= lenText and string.sub(text, -l, -1) == emoji then
			self.foucsInput:setText(string.sub(text, 1, -l - 1))

			return
		end
	end

	self.foucsInput:setText(string.sub(text, 1, -2))
end

function ChatEmojiBox:onTabClick(sender)
	for i, tab in ipairs(self.tabs) do
		if tab ~= sender then
			tab:setEnable(true)
			self[tab.config.panel]:setVisible(false)
		end
	end

	sender:setEnable(false)

	if sender.redHint then
		RedDotManager.setKeyState(sender.config.redHint, false)
	end

	self.curType = sender.config.type

	self[sender.config.panel]:setVisible(true)
	self[sender.config.refreshFunc](self, sender.index)
end

function ChatEmojiBox:onMsgSend(sender, content, func, info)
	if self.sendFunc ~= nil then
		self.sendFunc(sender, content, func, info)
	end
end

function ChatEmojiBox:onLargeEmojiSelect(emojiInfo)
	self:onMsgSend(nil, emojiInfo)
end

function ChatEmojiBox:onMoveEmojiSelect(id)
	local info = ResChatDynamicIcon[id]

	if info then
		local function func(channel, uid)
			RPC.dynamicExpressionUse(info.item_id, channel, uid)
		end

		self:onMsgSend(nil, info.icon_name, func, info)
	end
end

function ChatEmojiBox:onPlayerEmojiSelect(emojiInfo)
	self:onMsgSend(nil, emojiInfo)
end

return ChatEmojiBox
