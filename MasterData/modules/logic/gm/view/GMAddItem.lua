-- chunkname: @modules/logic/gm/view/GMAddItem.lua

module("modules.logic.gm.view.GMAddItem", package.seeall)

local GMAddItem = class("GMAddItem", ListScrollCell)
local ItemColor = {
	"#319b26",
	"#4d9af9",
	"#a368d1",
	"#fd913b",
	"#e11919"
}

function GMAddItem:init(go)
	self._mo = nil
	self._itemClick = SLFramework.UGUI.UIClickListener.Get(go)

	self._itemClick:AddClickListener(self._onClickItem, self)

	self._img1 = gohelper.findChildImage(go, "img1")
	self._img2 = gohelper.findChildImage(go, "img2")
	self._txtName = gohelper.findChildText(go, "txtName")
	self._txtId = gohelper.findChildText(go, "txtId")
end

function GMAddItem:onUpdateMO(mo)
	self._mo = mo

	gohelper.setActive(self._img1.gameObject, mo.id % 2 == 1)
	gohelper.setActive(self._img2.gameObject, mo.id % 2 == 0)

	self._txtName.text = self._mo.name
	self._txtId.text = self._mo.itemId and self._mo.itemId or ""

	local colorStr = "#666666"

	if self._mo.rare then
		colorStr = ItemColor[tonumber(self._mo.rare)]
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._txtName, colorStr)

	self._txtId.color = GameUtil.parseColor(colorStr)
end

function GMAddItem:_onClickItem()
	if self._mo.type == 0 then
		GMController.instance:dispatchEvent(GMAddItemView.Return, self._mo)
	else
		GMController.instance:dispatchEvent(GMAddItemView.ClickItem, self._mo)
	end
end

function GMAddItem:onDestroy()
	if self._itemClick then
		self._itemClick:RemoveClickListener()

		self._itemClick = nil
	end
end

return GMAddItem
