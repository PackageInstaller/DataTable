-- chunkname: @modules/logic/rouge/view/RougeCollectionGiftViewItem.lua

module("modules.logic.rouge.view.RougeCollectionGiftViewItem", package.seeall)

local RougeCollectionGiftViewItem = class("RougeCollectionGiftViewItem", RougeSimpleItemBase)

function RougeCollectionGiftViewItem:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._gotagitem = gohelper.findChild(self.viewGO, "tags/#go_tagitem")
	self._gotips = gohelper.findChild(self.viewGO, "tags/#go_tips")
	self._txttagitem = gohelper.findChildText(self.viewGO, "tags/#go_tips/#txt_tagitem")
	self._goenchantlist = gohelper.findChild(self.viewGO, "#go_enchantlist")
	self._gohole = gohelper.findChild(self.viewGO, "#go_enchantlist/#go_hole")
	self._gogrid = gohelper.findChild(self.viewGO, "Grid/#go_grid")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#simage_collection")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._goskillcontainer = gohelper.findChild(self.viewGO, "scroll_desc/Viewport/#go_skillcontainer")
	self._goskillitem = gohelper.findChild(self.viewGO, "scroll_desc/Viewport/#go_skillcontainer/#go_skillitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionGiftViewItem:addEvents()
	return
end

function RougeCollectionGiftViewItem:removeEvents()
	return
end

function RougeCollectionGiftViewItem:ctor(ctorParam)
	RougeSimpleItemBase.ctor(self, ctorParam)
end

function RougeCollectionGiftViewItem:_btnclickOnClick()
	return
end

function RougeCollectionGiftViewItem:addEventListeners()
	RougeSimpleItemBase.addEventListeners(self)
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function RougeCollectionGiftViewItem:removeEventListeners()
	RougeSimpleItemBase.removeEventListeners(self)
	GameUtil.onDestroyViewMember_ClickListener(self, "_itemClick")
end

function RougeCollectionGiftViewItem:onDestroyView()
	RougeSimpleItemBase.onDestroyView(self)
	self._simagecollection:UnLoadImage()
	GameUtil.onDestroyViewMemberList(self, "_tagObjList")
	GameUtil.onDestroyViewMemberList(self, "_tipsTagObjList")
end

function RougeCollectionGiftViewItem:_onItemClick()
	local c = self:baseViewContainer()

	c:dispatchEvent(RougeEvent.RougeCollectionGiftView_OnSelectIndex, self:index())
end

function RougeCollectionGiftViewItem:setSelected(isSelected)
	gohelper.setActive(self._goselect, isSelected)
end

function RougeCollectionGiftViewItem:_editableInitView()
	RougeSimpleItemBase._editableInitView(self)

	self._gridList = self:getUserDataTb_()
	self._tagObjList = {}
	self._tipsTagObjList = {}

	local scrolldescGO = gohelper.findChild(self.viewGO, "scroll_desc")

	self:_onSetScrollParentGameObject(scrolldescGO:GetComponent(gohelper.Type_LimitedScrollRect))

	self._itemClick = gohelper.getClickWithAudio(self.viewGO)
	self._gridLayout = gohelper.findChild(self.viewGO, "Grid")
	self._txttagitemGo = self._txttagitem.gameObject

	gohelper.setActive(self._gohole, false)
	gohelper.setActive(self._gogrid, false)
	gohelper.setActive(self._gotagitem, false)
	gohelper.setActive(self._txttagitemGo, false)
	self:setSelected(false)
	self:_setActiveLTTips(false)
end

function RougeCollectionGiftViewItem:setData(mo)
	local type = mo.type

	if type == RougeCollectionGiftView.Type.DropGroup then
		self:_onUpdateMO_DropGroup(mo)
	else
		self:_onUpdateMO_default(mo)
	end
end

function RougeCollectionGiftViewItem:_onUpdateMO_default(mo)
	self:_createDescList(mo.descList)
	GameUtil.loadSImage(self._simagecollection, mo.resUrl)

	self._txtname.text = mo.title
end

function RougeCollectionGiftViewItem:_onUpdateMO_DropGroup(mo)
	local data = mo.data
	local collectionId = data.collectionId

	self:_createDescList(mo.descList)

	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionId)

	self:_refreshHole(collectionCfg.holeNum)
	self:_refreshGrids(collectionId)
	self:_refreshTagList(collectionCfg.tags or {})
	GameUtil.loadSImage(self._simagecollection, RougeCollectionHelper.getCollectionIconUrl(collectionId))

	self._txtname.text = RougeCollectionConfig.instance:getCollectionName(collectionId)
end

function RougeCollectionGiftViewItem:_refreshHole(holeNum)
	gohelper.CreateNumObjList(self._goenchantlist, self._gohole, holeNum or 0)
end

function RougeCollectionGiftViewItem:_refreshGrids(collectionId)
	RougeCollectionHelper.loadShapeGrid(collectionId, self._gridLayout, self._gogrid, self._gridList)
end

function RougeCollectionGiftViewItem:_createDescList(descList)
	gohelper.CreateObjList(self, self._descListCallback, descList, self._goskillcontainer, self._goskillitem)
end

function RougeCollectionGiftViewItem:_descListCallback(obj, str, index)
	local txtDesc = gohelper.findChildText(obj, "txt_desc")

	txtDesc.text = str
end

function RougeCollectionGiftViewItem:_refreshTagList(tagDataList)
	for i, v in ipairs(tagDataList) do
		local item1

		if i > #self._tagObjList then
			item1 = self:_create_RougeCollectionInitialCollectionTagItem(i)

			table.insert(self._tagObjList, item1)
		else
			item1 = self._tagObjList[i]
		end

		item1:onUpdateMO(v)
		item1:setActive(true)

		local item2

		if i > #self._tipsTagObjList then
			item2 = self:_create_RougeCollectionInitialCollectionTipsTagItem(i)

			table.insert(self._tipsTagObjList, item2)
		else
			item2 = self._tipsTagObjList[i]
		end

		item2:onUpdateMO(v)
		item2:setActive(true)
	end

	local n = math.max(#self._tagObjList, #self._tipsTagObjList)

	for i = #tagDataList + 1, n do
		local item1 = self._tagObjList[i]

		if item1 then
			item1:setActive(false)
		end

		local item2 = self._tipsTagObjList[i]

		if item2 then
			item2:setActive(false)
		end
	end
end

function RougeCollectionGiftViewItem:_create_RougeCollectionInitialCollectionTagItem(index)
	local go = gohelper.cloneInPlace(self._gotagitem)
	local item = RougeCollectionInitialCollectionTagItem.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function RougeCollectionGiftViewItem:_create_RougeCollectionInitialCollectionTipsTagItem(index)
	local go = gohelper.cloneInPlace(self._txttagitemGo)
	local item = RougeCollectionInitialCollectionTipsTagItem.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function RougeCollectionGiftViewItem:setActiveTips(isActive)
	gohelper.setActive(self._gotips, isActive)

	local p = self:parent()

	p:setActiveBlock(isActive)
end

function RougeCollectionGiftViewItem:onCloseBlock()
	self:_setActiveLTTips(false)
end

function RougeCollectionGiftViewItem:_setActiveLTTips(isActive)
	gohelper.setActive(self._gotips, isActive)
end

return RougeCollectionGiftViewItem
