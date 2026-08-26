-- chunkname: @modules/logic/rouge/view/RougeCollectionHandBookItem.lua

module("modules.logic.rouge.view.RougeCollectionHandBookItem", package.seeall)

local RougeCollectionHandBookItem = class("RougeCollectionHandBookItem", ListScrollCellExtend)

function RougeCollectionHandBookItem:onInitView()
	self._imagebg = gohelper.findChildImage(self.viewGO, "normal/#image_bg")
	self._txtindex = gohelper.findChildText(self.viewGO, "normal/#txt_index")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "normal/#simage_collection")
	self._goselected = gohelper.findChild(self.viewGO, "go_selected")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")
end

function RougeCollectionHandBookItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeCollectionHandBookItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RougeCollectionHandBookItem:_editableRemoveEvents()
	return
end

function RougeCollectionHandBookItem:_btnclickOnClick()
	RougeController.instance:dispatchEvent(RougeEvent.OnSelectCollectionHandBookItem, self._mo.id)
end

function RougeCollectionHandBookItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function RougeCollectionHandBookItem:refreshUI()
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(self._mo.product)

	UISpriteSetMgr.instance:setRougeSprite(self._imagebg, "rouge_episode_collectionbg_" .. tostring(collectionCfg.showRare))

	local isSelect = RougeCollectionHandBookListModel.instance:isCurSelectTargetId(self._mo.id)

	gohelper.setActive(self._goselected, isSelect)
	self._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self._mo.product))

	self._txtindex.text = self._index
end

function RougeCollectionHandBookItem:onSelect(isSelect)
	gohelper.setActive(self._goselected, isSelect)
end

function RougeCollectionHandBookItem:onDestroyView()
	self._simagecollection:UnLoadImage()
end

return RougeCollectionHandBookItem
