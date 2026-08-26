-- chunkname: @modules/logic/partycloth/view/item/PartyClothPartItem.lua

module("modules.logic.partycloth.view.item.PartyClothPartItem", package.seeall)

local PartyClothPartItem = class("PartyClothPartItem", ListScrollCell)

function PartyClothPartItem:init(go)
	self.go = go
	self.imageQuality = gohelper.findChildImage(go, "image_Quality")
	self.simageIcon = gohelper.findChildSingleImage(go, "simage_Icon")
	self.goLock = gohelper.findChild(go, "go_Lock")
	self.goWear = gohelper.findChild(go, "go_Wear")
	self.goSelect = gohelper.findChild(go, "go_Select")
	self.goNew = gohelper.findChild(go, "go_New")
	self.btnClick = gohelper.findChildButton(go, "btn_Click")

	self.addClickCb(self, self.btnClick, self.onClick, self)
end

function PartyClothPartItem:onUpdateMO(mo)
	self.config = mo.config

	self.simageIcon:LoadImage(ResUrl.getV3a4PartySingleBg(self.config.image, "cloth"))
	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self.imageQuality, "partycloth_quality" .. tostring(self.config.rare))
	gohelper.setActive(self.goWear, false)
	gohelper.setActive(self.goWear, mo.isWear == 1)

	if mo.isWear then
		self:refreshNewTag()
	end
end

function PartyClothPartItem:onClick()
	if self.config and not self.isSelect then
		PartyClothController.instance:dispatchEvent(PartyClothEvent.ClickClothPartItem, self.config.clothId)
	end
end

function PartyClothPartItem:onSelect(isSelect)
	if isSelect and self.isNew then
		PartyClothModel.instance:setNewTagInvalid({
			self.config.clothId
		})
		PartyClothController.instance:dispatchEvent(PartyClothEvent.NewTagChange, self.config.partId)
		self:refreshNewTag()
	end

	self.isSelect = isSelect

	gohelper.setActive(self.goSelect, isSelect)
end

function PartyClothPartItem:refreshNewTag()
	self.isNew = PartyClothModel.instance:hasNewTag(self.config.clothId)

	gohelper.setActive(self.goNew, self.isNew)
end

return PartyClothPartItem
