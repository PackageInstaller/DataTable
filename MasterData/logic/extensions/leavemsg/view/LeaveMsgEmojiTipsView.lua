-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/view/LeaveMsgEmojiTipsView.lua

module("logic.extensions.leavemsg.view.LeaveMsgEmojiTipsView", package.seeall)

local M = class("LeaveMsgEmojiTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnCloseOutSide = self:getBtn("0&universal_second_tips_common_bg_-1467035629")
	self._btnClose = self:getBtn("0&universal_second_tips_common_bg_1201003252")
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGo("2&btn_left_-1571983320"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self:getGo("3&btn_right_1251431307"), CommButton)
	self._scroll = self:getUIComponent("leave_message_emoji_tips_-1148821532", UIComponentType.ScrollRect)
	self._loopList = LoopGridViewHelper.New(self._scroll.gameObject)

	self._loopList:InitGridView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	for _, value in pairs(self._itemData or {}) do
		value.destroyUI()
	end

	self._itemData = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnCloseOutSide:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnCloseOutSide:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:setSelectIndex(1)
	self:refreshView(true)
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickClose()
	self:close()
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickConfirm()
	local index = self:getSelectIndex()
	local id = self._moLst[index].id
	local info = self:getFirstParam()

	info.context:setEmoji(id)
	GlobalDispatcher:dispatchEvent(LeaveMsgEventType.ON_EDIT_MSG_PART_CHANGE, 1, LeaveMsgEnum.MsgPartType.Emoji, id)
	info.context:dispatchCurPreview()
	self:close()
end

function M:getSelectIndex()
	return self._selectIndex
end

function M:setSelectIndex(index, refreshSelect)
	self._selectIndex = index

	if refreshSelect then
		for _, cell in pairs(self._itemData or {}) do
			cell.updateSelect()
		end
	end
end

function M:refreshView(resetPos)
	self._moLst = LeaveMsgModel.instance:getCfgListChatEmoji()

	local len = self._moLst and #self._moLst or 0

	if len > 0 then
		if resetPos then
			self._loopList:ClearCells()
		end

		self._loopList:SetListItemCount(len, resetPos)
		self._loopList:RefreshAllShownItem()
	else
		self._loopList:ClearCells()
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("chat_emoji_item1")

	self:_updateCell(item.gameObject, curIndex)

	return item
end

function M:_updateCell(go, index)
	if not self._itemData then
		self._itemData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemData[key]

	if not theItem then
		theItem = {
			go = go,
			goSelect = goutil.findChild(go, "select").gameObject,
			goNone = goutil.findChild(go, "noneType").gameObject,
			goNew = goutil.findChild(go, "imgNew").gameObject,
			imgIcon = goutil.findChildComponent(go, "imgEmoji", UIComponentType.Image),
			btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)
		}

		function theItem.getIndex()
			return theItem.index
		end

		function theItem.updateSelect()
			goutil.setActive(theItem.goSelect, theItem.getIndex() == self:getSelectIndex())
		end

		theItem.btnClick:AddClickListener(function()
			self:_onCellClick(theItem.getIndex())
		end, self)

		function theItem.destroyUI()
			theItem.btnClick:RemoveClickListener()
		end

		self._itemData[key] = theItem
	end

	theItem.index = index

	local id = self._moLst[index].id

	goutil.setActive(theItem.goNone, id <= 0)
	goutil.setActive(theItem.imgIcon.gameObject, id > 0)

	if id > 0 then
		IconLoader.setSprite(theItem.imgIcon, IconType.ChatEmoji, self._moLst[index].icon)
	end

	theItem.updateSelect()
end

function M:_onCellClick(index)
	self:setSelectIndex(index, true)
end

return M
