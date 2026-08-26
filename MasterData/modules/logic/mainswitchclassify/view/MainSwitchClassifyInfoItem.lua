-- chunkname: @modules/logic/mainswitchclassify/view/MainSwitchClassifyInfoItem.lua

module("modules.logic.mainswitchclassify.view.MainSwitchClassifyInfoItem", package.seeall)

local MainSwitchClassifyInfoItem = class("MainSwitchClassifyInfoItem", MainSwitchClassifyItem)

function MainSwitchClassifyInfoItem:initInternal(go, view)
	self._go = go
	self._view = view
	self._viewContainer = self._view.viewContainer
	self._goreddot = gohelper.findChild(self._go, "reddot")
end

function MainSwitchClassifyInfoItem:onUpdateMO(mo)
	self._mo = mo
	self._index = mo.Sort

	self:setTxt(luaLang(mo.Title))

	local count = #MainSwitchClassifyListModel.instance:getList()

	self:showLine(count > self._index)

	local isShowReddot = self:_checkReddot()

	gohelper.setActive(self._goreddot, isShowReddot)
end

function MainSwitchClassifyInfoItem:_btnclickOnClick()
	MainSwitchClassifyInfoItem.super._btnclickOnClick(self)
	MainSwitchClassifyListModel.instance:selectCell(self._index, true)
	self._viewContainer:switchClassifyTab(self._index)

	if self._mo.Classify == MainSwitchClassifyEnum.Classify.Click and ClickUISwitchModel.instance:hasReddot() then
		ClickUISwitchModel.instance:cancelReddot()
		ClickUISwitchController.instance:dispatchEvent(ClickUISwitchEvent.CancelReddot)
		MainSwitchClassifyListModel.instance:onModelUpdate()
	end
end

function MainSwitchClassifyInfoItem:_checkReddot()
	if self._mo.Classify == MainSwitchClassifyEnum.Classify.Click and ClickUISwitchModel.instance:hasReddot() then
		return true
	end
end

return MainSwitchClassifyInfoItem
