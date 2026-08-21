-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatEmojiView.lua

module("logic.extensions.chat.view.ChatEmojiView", package.seeall)

local M = class("ChatEmojiView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()

	self._allEmojiCfgs = ChatConfig.instance:getAllEmojiCfgs()
end

function M:_buildUI()
	local emojiScroll = goutil.findChild(self._mainGo, "emojiScroll")

	self._emojiScroll = LoopGridViewHelper.New(emojiScroll)

	self._emojiScroll:InitGridView(0, self._onCellUpdate, self)
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._emojiScroll:Dispose()

	self._emojiScroll = nil
end

function M:getMainGo()
	return self._mainGo
end

function M:getData(curIndex)
	return self._allEmojiCfgs[curIndex]
end

function M:getDataLength()
	return self._allEmojiCfgs and #self._allEmojiCfgs or 0
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)

	if visible then
		self._emojiScroll:SetListItemCount(self:getDataLength(), true)
		self._emojiScroll:RefreshAllShownItem()
	else
		self._emojiScroll:ClearCells()
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._emojiScroll:NewListViewItem("chat_emoji_item1")
	local view = Astral.LuaComponentContainer.Add(item.gameObject, ChatEmojiItemCell)

	view:updateData(self:getData(curIndex))

	return item
end

return M
