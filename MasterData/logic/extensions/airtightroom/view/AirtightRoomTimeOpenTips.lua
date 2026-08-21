-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/view/AirtightRoomTimeOpenTips.lua

module("logic.extensions.airtightroom.view.AirtightRoomTimeOpenTips", package.seeall)

local M = class("AirtightRoomTimeOpenTips", ViewComponent)

function M:buildUI()
	self._txtTitle = self:getTextByPath("universal_second_tips_common_bg/content/txtTitle")
	self._txtInfo = self:getTextByPath("content/txtContent")
	self._btnClose = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._btnCancel = self:getBtnByPath("content/btnCancel")
	self._btnConfirm = self:getBtnByPath("content/btnConfirm")
	self._item = Astral.SimpleLuaComponentContainer.Add(self:getGoByPath("content/backpack_item"), ItemCell)

	self._item:setShowSelectedEffect(false)
end

function M:destroyUI()
	self._txtInfo = nil
	self._btnCancel = nil
	self._btnConfirm = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self._txtTitle.text = lang("tip_airtighttime_open_time")

	local nowTime = AirtightRoomModel.instance:getServerTime()
	local itemId = AirtightRoomUtil.getItemId()
	local co = BackpackConfig.instance:getItemInfoByItemId(itemId)
	local itemName = co and co.name or ""
	local itemOpenTime = co and co.exInfo or 0

	itemOpenTime = tonumber(itemOpenTime)

	local nowTimeStr = os.date("%H:%M", nowTime)
	local openToTime = nowTime + itemOpenTime * 60
	local openToTimeStr = os.date("%H:%M", openToTime)

	if not ServerTime.isToday(openToTime) then
		openToTimeStr = string.format("%s%s", lang("tip_tomorrow"), openToTimeStr)
	end

	self._txtInfo.text = string.format(lang("tip_airtighttime_notice"), itemOpenTime, nowTimeStr, openToTimeStr)

	local count = ItemModel.instance:getItemCountByItemId(itemId)
	local itemData = ItemUtil.createItemData({
		itemId = itemId
	})

	self._item:updateData(itemData)
	self._item:getComponent("num"):setCountText("")
	self._item:getComponent("num"):setCostText(string.format("%s/%s", count, 1))

	if count == 0 then
		printWarn(string.format("道具[%s][%s]数量不足", itemId, itemName))
		self:close()

		return
	end
end

function M:onExit()
	return
end

function M:_onClickClose()
	self:close()
end

function M:_onClickConfirm()
	AirtightRoomAgent.instance:sendEnterAirtightRoomRequest()
	self:close()
end

return M
