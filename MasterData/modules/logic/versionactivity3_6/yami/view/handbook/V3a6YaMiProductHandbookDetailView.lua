-- chunkname: @modules/logic/versionactivity3_6/yami/view/handbook/V3a6YaMiProductHandbookDetailView.lua

module("modules.logic.versionactivity3_6.yami.view.handbook.V3a6YaMiProductHandbookDetailView", package.seeall)

local V3a6YaMiProductHandbookDetailView = class("V3a6YaMiProductHandbookDetailView", BaseView)

function V3a6YaMiProductHandbookDetailView:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "root/#go_normal")
	self._txtname = gohelper.findChildText(self.viewGO, "root/#go_normal/#txt_name")
	self._imagelevel = gohelper.findChildImage(self.viewGO, "root/#go_normal/#simage_level")
	self._simagecurrentproducts = gohelper.findChildSingleImage(self.viewGO, "root/#go_normal/Att/#simage_currentproducts")
	self._gorecipe = gohelper.findChild(self.viewGO, "root/#go_normal/recipe")
	self._txtfunding = gohelper.findChildText(self.viewGO, "root/#go_normal/recipe/#txt_funding")
	self._simageprop1 = gohelper.findChildSingleImage(self.viewGO, "root/#go_normal/recipe/#simage_prop1")
	self._btnuse = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_use")
	self._golock = gohelper.findChild(self.viewGO, "root/#go_lock")
	self._txtlocktips = gohelper.findChildText(self.viewGO, "root/#go_lock/#txt_locktips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiProductHandbookDetailView:addEvents()
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectHandbookProduct, self._onSelectHandbookProduct, self)
end

function V3a6YaMiProductHandbookDetailView:removeEvents()
	self._btnuse:RemoveClickListener()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectHandbookProduct, self._onSelectHandbookProduct, self)
end

function V3a6YaMiProductHandbookDetailView:_btnuseOnClick()
	V3a6YaMiModel.instance:onSelectProductRecipe(self._mo.id)
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onConfirmProductRecipe, self._mo.id)
	self:closeThis()
end

function V3a6YaMiProductHandbookDetailView:_editableInitView()
	self._listModel = V3a6YaMiProductHandbookListModel.instance
	self._gomaterialroot = gohelper.findChild(self.viewGO, "root/#go_normal/recipe/#scroll_Recipe/Viewport/Content")
	self._materialItems = self:getUserDataTb_()
	self._attrPanel = MonoHelper.addNoUpdateLuaComOnceToGo(self._gonormal, V3a6YaMiAttrPanel)
end

function V3a6YaMiProductHandbookDetailView:_onSelectHandbookProduct(id)
	self:_refreshProduct()
end

function V3a6YaMiProductHandbookDetailView:_onUnlockHero()
	self:_refreshProduct()
end

function V3a6YaMiProductHandbookDetailView:onUpdateParam()
	return
end

function V3a6YaMiProductHandbookDetailView:onOpen()
	self:_refreshProduct()
end

function V3a6YaMiProductHandbookDetailView:_refreshProduct()
	self._mo = self._listModel:getSelectMo()

	if self._mo.isLock then
		self._txtlocktips.text = self._mo.co.unlockCondition
	end

	local cost = V3a6YaMiModel.instance:getCurSelectMaterialCost()

	self._txtname.text = self._mo.co.name
	self._txtfunding.text = self._mo:getCost()

	self:_refreshMaterials()
	self._attrPanel:onRefresh(self._mo:getAttrMo(), false)

	local orginView = self.viewParam.orginView
	local ratingCo = V3a6YaMiConfig.instance:getRatingCo(self._mo.rating)

	if ratingCo and not string.nilorempty(ratingCo.icon) then
		UISpriteSetMgr.instance:setV3a6YaMiSprite(self._imagelevel, ratingCo.icon)
	end

	gohelper.setActive(self._golock, self._mo.isLock)
	gohelper.setActive(self._gonormal, not self._mo.isLock)
	gohelper.setActive(self._btnuse, (not self._mo.isLock or nil) and self._mo and orginView == ViewName.V3a6YaMiProductView)

	local icon = ResUrl.getV3a6YaMiItemSingleBg(self._mo.co.icon)

	self._simagecurrentproducts:LoadImage(icon)
end

function V3a6YaMiProductHandbookDetailView:_refreshMaterials()
	local count = 0
	local isTrash = self._mo:isTrash()

	if not isTrash and not self._mo.isLock then
		local subType = self._mo.subType

		if subType then
			local co = V3a6YaMiConfig.instance:getMaterialCo(subType)
			local icon = ResUrl.getV3a6YaMiCollectionSingleBg(co.icon)

			self._simageprop1:LoadImage(icon)
		end

		local materials = self._mo.materials

		if materials then
			for i, id in ipairs(materials) do
				local item = self:_getMaterialItem(i)
				local co = V3a6YaMiConfig.instance:getMaterialCo(id)
				local icon = ResUrl.getV3a6YaMiCollectionSingleBg(co.icon)

				item.simgIcon:LoadImage(icon)

				count = count + 1
			end
		end
	end

	gohelper.setActive(self._gorecipe, not isTrash)

	for i = 1, #self._materialItems do
		gohelper.setActive(self._materialItems[i].go, i <= count)
	end
end

function V3a6YaMiProductHandbookDetailView:_getMaterialItem(index)
	local item = self._materialItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._simageprop1.gameObject, self._gomaterialroot)
		item.simgIcon = gohelper.findChildSingleImage(item.go, "")
		self._materialItems[index] = item
	end

	return item
end

function V3a6YaMiProductHandbookDetailView:onClose()
	return
end

function V3a6YaMiProductHandbookDetailView:onDestroyView()
	self._simagecurrentproducts:UnLoadImage()
	self._simageprop1:UnLoadImage()

	for _, item in ipairs(self._materialItems) do
		item.simgIcon:UnLoadImage()
	end
end

return V3a6YaMiProductHandbookDetailView
