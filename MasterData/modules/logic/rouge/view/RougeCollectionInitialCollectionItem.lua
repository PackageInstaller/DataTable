-- chunkname: @modules/logic/rouge/view/RougeCollectionInitialCollectionItem.lua

module("modules.logic.rouge.view.RougeCollectionInitialCollectionItem", package.seeall)

local RougeCollectionInitialCollectionItem = class("RougeCollectionInitialCollectionItem", RougeSimpleItemBase)

function RougeCollectionInitialCollectionItem:onInitView()
	self._goenchantlist = gohelper.findChild(self.viewGO, "#go_enchantlist")
	self._gohole = gohelper.findChild(self.viewGO, "#go_enchantlist/#go_hole")
	self._gogrid = gohelper.findChild(self.viewGO, "Grid/#go_grid")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#simage_collection")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._godescContent = gohelper.findChild(self.viewGO, "scroll_desc/Viewport/#go_descContent")
	self._godescitem = gohelper.findChild(self.viewGO, "scroll_desc/Viewport/#go_descContent/#go_descitem")
	self._gotags = gohelper.findChild(self.viewGO, "#go_tags")
	self._gotagitem = gohelper.findChild(self.viewGO, "#go_tags/#go_tagitem")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tags/#go_tagitem/#btn_click")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tags/#go_tips")
	self._txttagitem = gohelper.findChildText(self.viewGO, "#go_tags/#go_tips/#txt_tagitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionInitialCollectionItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeCollectionInitialCollectionItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RougeCollectionInitialCollectionItem:ctor(ctorParam)
	RougeSimpleItemBase.ctor(self, ctorParam)
end

function RougeCollectionInitialCollectionItem:_btnclickOnClick()
	return
end

function RougeCollectionInitialCollectionItem:_editableInitView()
	RougeSimpleItemBase._editableInitView(self)

	self._tagObjList = {}
	self._tipsTagObjList = {}
	self._itemInstTab = self:getUserDataTb_()
	self._descParams = {
		isAllActive = true
	}
	self._txttagitemGo = self._txttagitem.gameObject

	local scrollDescGo = gohelper.findChild(self.viewGO, "scroll_desc")

	self._gridGo = gohelper.findChild(self.viewGO, "Grid")
	self._scrollViewLimitScrollCmp = scrollDescGo:GetComponent(gohelper.Type_LimitedScrollRect)

	self:_onSetScrollParentGameObject(self._scrollViewLimitScrollCmp)
	gohelper.setActive(self._gotagitem, false)
	gohelper.setActive(self._txttagitemGo, false)
	self:_setActiveLTTips(false)
	RougeController.instance:registerCallback(RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function RougeCollectionInitialCollectionItem:onDestroyView()
	GameUtil.onDestroyViewMember_SImage(self, "_simagecollection")
	GameUtil.onDestroyViewMemberList(self, "_tagObjList")
	GameUtil.onDestroyViewMemberList(self, "_tipsTagObjList")
	RougeController.instance:unregisterCallback(RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function RougeCollectionInitialCollectionItem:setData(mo)
	local collectionCfgId = mo
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	if not collectionCfg then
		logError("not found collectionCfgId" .. tostring(collectionCfgId))

		return
	end

	self._collectionCfgId = collectionCfgId

	self._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(collectionCfgId))
	gohelper.CreateNumObjList(self._goenchantlist, self._gohole, collectionCfg.holeNum or 0)

	self._txtname.text = RougeCollectionConfig.instance:getCollectionName(collectionCfgId)

	RougeCollectionHelper.loadShapeGrid(collectionCfgId, self._gridGo, self._gogrid)
	self:_refreshDesc()
	self:_refreshTagList(collectionCfg.tags or {})
end

function RougeCollectionInitialCollectionItem:_refreshDesc()
	RougeCollectionDescHelper.setCollectionDescInfos2(self._collectionCfgId, nil, self._godescContent, self._itemInstTab, nil, self._descParams)
end

function RougeCollectionInitialCollectionItem:_refreshTagList(tagDataList)
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

function RougeCollectionInitialCollectionItem:_create_RougeCollectionInitialCollectionTagItem(index)
	local go = gohelper.cloneInPlace(self._gotagitem)
	local item = RougeCollectionInitialCollectionTagItem.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function RougeCollectionInitialCollectionItem:_create_RougeCollectionInitialCollectionTipsTagItem(index)
	local go = gohelper.cloneInPlace(self._txttagitemGo)
	local item = RougeCollectionInitialCollectionTipsTagItem.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function RougeCollectionInitialCollectionItem:setActiveTips(isActive)
	self:_setActiveLTTips(isActive)

	local p = self:parent()

	p:setActiveBlock(isActive)
end

function RougeCollectionInitialCollectionItem:onCloseBlock()
	self:_setActiveLTTips(false)
end

function RougeCollectionInitialCollectionItem:_setActiveLTTips(isActive)
	gohelper.setActive(self._gotips, isActive)
end

function RougeCollectionInitialCollectionItem:_onSwitchCollectionInfoType()
	self:_refreshDesc()
end

return RougeCollectionInitialCollectionItem
