-- chunkname: @modules/logic/gm/view/GMFastAddHeroAddItem.lua

module("modules.logic.gm.view.GMFastAddHeroAddItem", package.seeall)

local GMFastAddHeroAddItem = class("GMFastAddHeroAddItem", ListScrollCell)
local ItemColor = {
	"#319b26",
	"#4d9af9",
	"#a368d1",
	"#fd913b",
	"#e11919"
}

function GMFastAddHeroAddItem:init(go)
	self._itemClick = SLFramework.UGUI.UIClickListener.Get(go)

	self._itemClick:AddClickListener(self._onClickItem, self)

	self._img1 = gohelper.findChildImage(go, "img1")
	self._img2 = gohelper.findChildImage(go, "img2")
	self._txtName = gohelper.findChildText(go, "txtName")
	self._txtId = gohelper.findChildText(go, "txtId")
end

function GMFastAddHeroAddItem:onUpdateMO(characterCo)
	self.characterCo = characterCo

	gohelper.setActive(self._img1.gameObject, characterCo.id % 2 == 1)
	gohelper.setActive(self._img2.gameObject, characterCo.id % 2 == 0)

	self._txtName.text = self.characterCo.name
	self._txtId.text = self.characterCo.id

	local colorStr = "#666666"

	if self.characterCo.rare then
		colorStr = ItemColor[tonumber(self.characterCo.rare)]
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._txtName, colorStr)

	self._txtId.color = GameUtil.parseColor(colorStr)
end

function GMFastAddHeroAddItem:_onClickItem()
	GMAddItemModel.instance:onOnClickItem(self.characterCo)
	GMFastAddHeroHadHeroItemModel.instance:setSelectMo(nil)
end

function GMFastAddHeroAddItem:onDestroy()
	if self._itemClick then
		self._itemClick:RemoveClickListener()

		self._itemClick = nil
	end
end

return GMFastAddHeroAddItem
