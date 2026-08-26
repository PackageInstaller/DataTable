-- chunkname: @modules/logic/gm/view/GMFightEntityBuffSearchItem.lua

module("modules.logic.gm.view.GMFightEntityBuffSearchItem", package.seeall)

local GMFightEntityBuffSearchItem = class("GMFightEntityBuffSearchItem", ListScrollCell)

function GMFightEntityBuffSearchItem:init(go)
	self._mo = nil
	self._itemClick = SLFramework.UGUI.UIClickListener.Get(go)

	self._itemClick:AddClickListener(self._onClickItem, self)

	self._img1 = gohelper.findChildImage(go, "img1")
	self._img2 = gohelper.findChildImage(go, "img2")
	self._txtName = gohelper.findChildText(go, "txtName")
	self._txtId = gohelper.findChildText(go, "txtId")
end

function GMFightEntityBuffSearchItem:onUpdateMO(mo)
	self._mo = mo

	gohelper.setActive(self._img1.gameObject, mo.id % 2 == 1)
	gohelper.setActive(self._img2.gameObject, mo.id % 2 == 0)

	self._txtName.text = self._mo.name
	self._txtId.text = self._mo.buffId
end

function GMFightEntityBuffSearchItem:_onClickItem()
	GMController.instance:dispatchEvent(GMFightEntityBuffView.ClickSearchItem, self._mo)
end

function GMFightEntityBuffSearchItem:onDestroy()
	if self._itemClick then
		self._itemClick:RemoveClickListener()

		self._itemClick = nil
	end
end

return GMFightEntityBuffSearchItem
