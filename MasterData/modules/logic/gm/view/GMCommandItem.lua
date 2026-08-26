-- chunkname: @modules/logic/gm/view/GMCommandItem.lua

module("modules.logic.gm.view.GMCommandItem", package.seeall)

local GMCommandItem = class("GMCommandItem", ListScrollCell)

function GMCommandItem:init(go)
	self._mo = nil
	self._itemClick = SLFramework.UGUI.UIClickListener.Get(go)

	self._itemClick:AddClickListener(self._onClickItem, self)

	self._selectGO = gohelper.findChild(go, "imgSelect")
	self._txtName = gohelper.findChildText(go, "txtName")
end

function GMCommandItem:onUpdateMO(mo)
	self._mo = mo
	self._txtName.text = self._mo.id .. ". " .. self._mo.name
end

function GMCommandItem:onSelect(isSelect)
	self._hasSelected = isSelect

	gohelper.setActive(self._selectGO, isSelect)
end

function GMCommandItem:_onClickItem()
	GMController.instance:dispatchEvent(GMCommandView.ClickItem, self._mo)

	if self._hasSelected then
		GMController.instance:dispatchEvent(GMCommandView.ClickItemAgain, self._mo)
	end

	self._view:setSelect(self._mo)
end

function GMCommandItem:onDestroy()
	if self._itemClick then
		self._itemClick:RemoveClickListener()

		self._itemClick = nil
	end
end

return GMCommandItem
