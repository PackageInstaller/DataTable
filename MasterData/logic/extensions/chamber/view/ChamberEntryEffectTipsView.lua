-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/view/ChamberEntryEffectTipsView.lua

module("logic.extensions.chamber.view.ChamberEntryEffectTipsView", package.seeall)

local M = class("ChamberEntryEffectTipsView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("1&middle_tips_common_bg_-1205189576")
	self._goContent = self:getGoByPath("scrollView/ViewPort/content")
	self._goItem = goutil.findChild(self._goContent, "secret_time_impression_effect_item")
	self._arrayItem = {}
end

function M:destroyUI()
	self._arrayItem = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:refreshView()
end

function M:onExit()
	self:_clearItems()
end

function M:refreshView()
	self:_clearItems()

	local entryCOs = ChamberModel.instance:getAllEntrys()

	for _, CO in ipairs(entryCOs) do
		local itemGO = goutil.cloneAndSetParent(self._goItem, self._goContent.transform)

		goutil.setActive(itemGO, true)

		local item = Astral.SimpleLuaComponentContainer.Add(itemGO, ChamberEntryItem)

		item:setEntryCO(CO, true)
		table.insert(self._arrayItem, itemGO)
	end
end

function M:_clearItems()
	for _, item in ipairs(self._arrayItem) do
		goutil.destroy(item)
	end

	table.clear(self._arrayItem)
end

function M:_onClickBtnClose()
	self:close()
end

return M
