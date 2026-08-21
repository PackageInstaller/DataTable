-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatEmojiItemCell.lua

module("logic.extensions.chat.view.ChatEmojiItemCell", package.seeall)

local M = class("ChatEmojiItemCell")

function M:ctor(go)
	self._go = go
	self._registry = ViewElementsRegistry.New(go)

	self:_buildUI()
end

function M:_buildUI()
	self._imgEmoji = self._registry:getImage("chat_emoji_item1_-98144409")
	self._btnClick = self._registry:getBtn("chat_emoji_item1_-146576200")
	self._goNewMark = self._registry:getGo("chat_emoji_item1_1158219991")
	self._goNoneMark = self._registry:getGo("chat_emoji_item1_239094894")

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClickBtnClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:updateData(data)
	self:setNoneMarkVisible(not data)

	self._data = data

	if self._data then
		IconLoader.setSprite(self._imgEmoji, IconType.ChatEmoji, data.icon)
	end
end

function M:setNewMarkVisible(visible)
	goutil.setActive(self._goNewMark, visible)
end

function M:setNoneMarkVisible(visible)
	goutil.setActive(self._goNoneMark, visible)
	goutil.setActive(self._imgEmoji.gameObject, not visible)
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()
end

function M:_onClickBtnClick()
	local id = self._data and self._data.id or nil

	GlobalDispatcher:dispatchEvent(EventType.CHAT_EMOJI_SELECTED, id)
end

return M
