-- chunkname: @modules/logic/explore/view/ExploreBackpackView.lua

module("modules.logic.explore.view.ExploreBackpackView", package.seeall)

local ExploreBackpackView = class("ExploreBackpackView", BaseView)

function ExploreBackpackView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gohasprop = gohelper.findChild(self.viewGO, "#go_hasprop")
	self._scrollprop = gohelper.findChildScrollRect(self.viewGO, "#scroll_prop")
	self._propcontent = gohelper.findChild(self.viewGO, "mask/#scroll_prop/viewport/propcontent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreBackpackView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.OnItemChange, self._updateItem, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyThirdDoorItemSelect, self.OnItemKeyDown, self)
end

function ExploreBackpackView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.OnItemChange, self._updateItem, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyThirdDoorItemSelect, self.OnItemKeyDown, self)
end

function ExploreBackpackView:_btncloseOnClick()
	self:closeThis()
end

function ExploreBackpackView:_editableInitView()
	self.itemList = {}
end

function ExploreBackpackView:onOpen()
	self:_updateItem()
end

function ExploreBackpackView:_updateItem()
	local items = ExploreBackpackModel.instance:getList()
	local path = self.viewContainer:getSetting().otherRes[1]

	for i, v in ipairs(items) do
		local item = self.itemList[i]

		if item == nil then
			local itemGO = self:getResInst(path, self._propcontent, "item")

			item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, ExploreBackpackPropListItem)
		end

		gohelper.setActive(item.go, true)
		item:onUpdateMO(v)

		self.itemList[i] = item

		local keytipsGo = gohelper.findChild(item.go, "#go_pcbtn")

		PCInputController.instance:showkeyTips(keytipsGo, PCInputModel.Activity.thrityDoor, PCInputModel.thrityDoorFun.Item1 + i - 1)
	end

	for i = #items + 1, #self.itemList do
		gohelper.setActive(self.itemList[i].go, false)
	end

	gohelper.setActive(self._goempty, #items == 0)
	gohelper.setActive(self._gohasprop, #items > 0)
end

function ExploreBackpackView:onDestroyView()
	for i, v in ipairs(self.itemList) do
		v:onDestroyView()
	end

	self.itemList = nil
end

function ExploreBackpackView:OnItemKeyDown(index)
	if PCInputController.instance:isPopUpViewOpen({
		ViewName.ExploreBackpackView
	}) then
		return
	end

	if self.itemList[index] then
		self.itemList[index]:_onItemClick()
	end
end

return ExploreBackpackView
