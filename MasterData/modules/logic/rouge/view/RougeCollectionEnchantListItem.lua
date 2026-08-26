-- chunkname: @modules/logic/rouge/view/RougeCollectionEnchantListItem.lua

module("modules.logic.rouge.view.RougeCollectionEnchantListItem", package.seeall)

local RougeCollectionEnchantListItem = class("RougeCollectionEnchantListItem", ListScrollCellExtend)

function RougeCollectionEnchantListItem:onInitView()
	self._imagerare = gohelper.findChildImage(self.viewGO, "image_rare")
	self._simagecollectionicon = gohelper.findChildSingleImage(self.viewGO, "simage_collectionicon")
	self._goenchant = gohelper.findChild(self.viewGO, "go_enchant")
	self._simageenchanticon = gohelper.findChildSingleImage(self.viewGO, "go_enchant/simage_enchanticon")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._btnclick = gohelper.findChildButton(self.viewGO, "btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionEnchantListItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeCollectionEnchantListItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RougeCollectionEnchantListItem:_btnclickOnClick()
	local curSelectHoleIndex = RougeCollectionUnEnchantListModel.instance:getCurSelectHoleIndex()
	local curSelectCollectionId = RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	RougeCollectionEnchantController.instance:onSelectEnchantItem(curSelectCollectionId, self._mo.id, curSelectHoleIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.CollectionEnchant)
end

function RougeCollectionEnchantListItem:_editableInitView()
	return
end

function RougeCollectionEnchantListItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function RougeCollectionEnchantListItem:refreshUI()
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(self._mo.cfgId)

	if collectionCfg then
		self._simagecollectionicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self._mo.cfgId))
		UISpriteSetMgr.instance:setRougeSprite(self._imagerare, string.format("rouge_collection_grid_big_%s", collectionCfg.showRare))
		self:refreshCollectionUI()
	end
end

function RougeCollectionEnchantListItem:refreshCollectionUI()
	local enchantTargetId = self._mo:getEnchantTargetId()
	local enchantTargetMO = RougeCollectionModel.instance:getCollectionByUid(enchantTargetId)

	gohelper.setActive(self._goenchant, enchantTargetMO ~= nil)

	if enchantTargetMO then
		self._simageenchanticon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(enchantTargetMO.cfgId))
	end
end

function RougeCollectionEnchantListItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function RougeCollectionEnchantListItem:onDestroyView()
	self._simagecollectionicon:UnLoadImage()
	self._simageenchanticon:UnLoadImage()
end

return RougeCollectionEnchantListItem
