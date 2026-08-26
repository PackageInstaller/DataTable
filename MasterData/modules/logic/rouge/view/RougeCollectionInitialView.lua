-- chunkname: @modules/logic/rouge/view/RougeCollectionInitialView.lua

module("modules.logic.rouge.view.RougeCollectionInitialView", package.seeall)

local RougeCollectionInitialView = class("RougeCollectionInitialView", BaseView)

function RougeCollectionInitialView:onInitView()
	self._simagemaskbg = gohelper.findChildSingleImage(self.viewGO, "#simage_maskbg")
	self._gocontent = gohelper.findChild(self.viewGO, "scroll_view/Viewport/#go_content")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "scroll_view/Viewport/#go_content/#go_collectionitem")
	self._btnemptyBlock = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyBlock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionInitialView:addEvents()
	self._btnemptyBlock:AddClickListener(self._btnemptyBlockOnClick, self)
end

function RougeCollectionInitialView:removeEvents()
	self._btnemptyBlock:RemoveClickListener()
end

function RougeCollectionInitialView:_btnemptyBlockOnClick()
	self:setActiveBlock(false)
end

function RougeCollectionInitialView:_editableInitView()
	self._btnemptyBlockGo = self._btnemptyBlock.gameObject
	self._collectionObjList = {}
	self._scrollView = gohelper.findChildScrollRect(self.viewGO, "scroll_view")
	self._scrollViewGo = self._scrollView.gameObject

	self._simagemaskbg:LoadImage("singlebg/rouge/rouge_talent_bg.png")
	gohelper.setActive(self._gocollectionitem, false)
	self:setActiveBlock(false)
end

function RougeCollectionInitialView:setActiveBlock(isActive)
	if self._isBlocked == isActive then
		return
	end

	self._isBlocked = isActive

	gohelper.setActive(self._btnemptyBlockGo, isActive)

	if not isActive then
		for _, item in ipairs(self._collectionObjList) do
			item:onCloseBlock()
		end
	end
end

function RougeCollectionInitialView:getScrollViewGo()
	return self._scrollViewGo
end

function RougeCollectionInitialView:onUpdateParam()
	self:_refresh()
end

function RougeCollectionInitialView:onOpen()
	self._isBlocked = nil

	self:onUpdateParam()

	self._scrollView.horizontalNormalizedPosition = 0
end

function RougeCollectionInitialView:onOpenFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open_20190323)
end

function RougeCollectionInitialView:_refresh()
	self:_refreshList()
end

function RougeCollectionInitialView:_refreshList()
	local collectionCfgIdList = self:_collectionCfgIdList()

	for i, collectionCfgId in ipairs(collectionCfgIdList) do
		local item

		if i > #self._collectionObjList then
			item = self:_create_RougeCollectionInitialCollectionItem(i)

			table.insert(self._collectionObjList, item)
		else
			item = self._collectionObjList[i]
		end

		item:onUpdateMO(collectionCfgId)
		item:setActive(true)
	end

	for i = #collectionCfgIdList + 1, #self._collectionObjList do
		local item = self._collectionObjList[i]

		item:setActive(false)
	end
end

function RougeCollectionInitialView:_collectionCfgIdList()
	return (self.viewParam or nil) and (self.viewParam.collectionCfgIds or {})
end

function RougeCollectionInitialView:onClose()
	GameUtil.onDestroyViewMember_SImage(self, "_simagemaskbg")
	GameUtil.onDestroyViewMemberList(self, "_collectionObjList")
end

function RougeCollectionInitialView:onDestroyView()
	return
end

function RougeCollectionInitialView:_create_RougeCollectionInitialCollectionItem(index)
	local go = gohelper.cloneInPlace(self._gocollectionitem)
	local item = RougeCollectionInitialCollectionItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

return RougeCollectionInitialView
