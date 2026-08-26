-- chunkname: @modules/logic/gm/view/GMCommandHistoryView.lua

module("modules.logic.gm.view.GMCommandHistoryView", package.seeall)

local GMCommandHistoryView = class("GMCommandHistoryView", BaseView)

GMCommandHistoryView.LevelType = "人物等级"
GMCommandHistoryView.HeroAttr = "英雄提升"
GMCommandHistoryView.ClickItem = "ClickItem"
GMCommandHistoryView.Return = "Return"

function GMCommandHistoryView:ctor()
	return
end

function GMCommandHistoryView:onInitView()
	self._maskGO = gohelper.findChild(self.viewGO, "addItem")
	self._inpItem = SLFramework.UGUI.InputFieldWrap.GetWithPath(self.viewGO, "viewport/content/item1/inpText")

	self:_hideScroll()
end

function GMCommandHistoryView:addEvents()
	SLFramework.UGUI.UIClickListener.Get(self._inpItem.gameObject):AddClickListener(self._onClickInpItem, self, nil)
	SLFramework.UGUI.UIClickListener.Get(self._maskGO):AddClickListener(self._onClickMask, self, nil)
	self._inpItem:AddOnValueChanged(self._onInpValueChanged, self)
end

function GMCommandHistoryView:removeEvents()
	SLFramework.UGUI.UIClickListener.Get(self._inpItem.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._maskGO):RemoveClickListener()
	self._inpItem:RemoveOnValueChanged()
end

function GMCommandHistoryView:onOpen()
	GMController.instance:registerCallback(GMCommandHistoryView.ClickItem, self._onClickItem, self)
end

function GMCommandHistoryView:onClose()
	GMController.instance:unregisterCallback(GMCommandHistoryView.ClickItem, self._onClickItem, self)
end

function GMCommandHistoryView:_onClickInpItem()
	self:_showScroll()
end

function GMCommandHistoryView:_onClickMask()
	self:_hideScroll()
end

function GMCommandHistoryView:_showScroll()
	gohelper.setActive(self._maskGO, true)
	recthelper.setAnchorX(self._maskGO.transform, -600)
	self:_showDefaultItems()
end

function GMCommandHistoryView:_hideScroll()
	gohelper.setActive(self._maskGO, false)
	recthelper.setAnchorX(self._maskGO.transform, 0)
	GMAddItemModel.instance:clear()
end

local deleteTip = "左ctrl + 点击删除对应记录"

function GMCommandHistoryView:_onClickItem(mo)
	if mo.type then
		return
	end

	if mo.name == deleteTip then
		return
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		GMCommandHistoryModel.instance:removeCommandHistory(mo.name)
		self:_showDefaultItems()

		return
	end

	self._inpItem:SetText(mo.name)
	self:_hideScroll()
end

function GMCommandHistoryView:_onInpValueChanged(inputStr)
	if string.nilorempty(inputStr) then
		self:_showDefaultItems()
	else
		self:_showTargetItems()
	end
end

function GMCommandHistoryView:_showDefaultItems()
	local list = GMCommandHistoryModel.instance:getCommandHistory()

	if #list == 0 then
		self:_hideScroll()

		return
	end

	local result = {
		{
			name = deleteTip
		}
	}

	for i, v in ipairs(list) do
		table.insert(result, {
			name = v
		})
	end

	GMAddItemModel.instance:setList(result)
end

function GMCommandHistoryView:_showTargetItems()
	local list = GMCommandHistoryModel.instance:getCommandHistory()
	local itemIdStr = self._inpItem:GetText()
	local toShowItems = {}

	for i = 1, #list do
		local item = list[i]

		if string.find(item, itemIdStr) then
			table.insert(toShowItems, {
				name = item
			})
		end
	end

	GMAddItemModel.instance:setList(toShowItems)
end

return GMCommandHistoryView
