-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142CollectView.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142CollectView", package.seeall)

local Activity142CollectView = class("Activity142CollectView", BaseView)

function Activity142CollectView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#simage_blackbg/#btn_close")
	self._goScroll = gohelper.findChild(self.viewGO, "#simage_blackbg/#scroll_reward")
	self._goContent = gohelper.findChild(self.viewGO, "#simage_blackbg/#scroll_reward/Viewport/#go_content")
	self._scrollRect = gohelper.findChildScrollRect(self.viewGO, "#simage_blackbg/#scroll_reward")

	if not gohelper.isNil(self._goContent) then
		self._gridLayout = self._goContent:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
	end

	self._gonodeitem = gohelper.findChild(self.viewGO, "#simage_blackbg/#scroll_reward/Viewport/#go_content/#go_nodeitem")
	self._txtnum = gohelper.findChildText(self.viewGO, "#simage_blackbg/bottom/cn/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity142CollectView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function Activity142CollectView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Activity142CollectView:_editableInitView()
	gohelper.setActive(self._gonodeitem, false)

	self.collectionItemList = {}
end

function Activity142CollectView:onOpen()
	self:refresh()
end

function Activity142CollectView:refresh()
	local actId = Activity142Model.instance:getActivityId()
	local collectionList = Activity142Config.instance:getCollectionList(actId)
	local totalCollectionCount = #collectionList

	self._txtnum.text = Activity142Model.instance:getHadCollectionCount() .. "/" .. totalCollectionCount

	local lastPlayUnlockAnimIndex

	for index, collectionId in ipairs(collectionList) do
		local collectionItem = self:createCollectionItem()
		local isLast = index ~= totalCollectionCount

		collectionItem:setData(index, collectionId, isLast, self._goScroll)

		local isHasCollection = Activity142Model.instance:isHasCollection(collectionId)
		local cacheKey = string.format("%s_%s", Activity142Enum.COLLECTION_CACHE_KEY, collectionId)
		local isPlayUnlockAnim = not Activity142Controller.instance:havePlayedUnlockAni(cacheKey)

		if isHasCollection and isPlayUnlockAnim then
			lastPlayUnlockAnimIndex = index
		end
	end

	ZProj.UGUIHelper.RebuildLayout(self._goContent.transform)

	local scrollPos = 0

	if lastPlayUnlockAnimIndex and not gohelper.isNil(self._goContent) and not gohelper.isNil(self._gridLayout) then
		local goScrollWidth = recthelper.getWidth(self._goScroll.transform)
		local goContentWidth = recthelper.getWidth(self._goContent.transform)
		local itemWidth = self._gridLayout.cellSize.x
		local endOffset = goContentWidth - goScrollWidth
		local curOffset = endOffset - (totalCollectionCount - lastPlayUnlockAnimIndex) * itemWidth

		scrollPos = Mathf.Clamp(curOffset / endOffset + Activity142Enum.COLLECTION_VIEW_OFFSET, 0, 1)
	end

	self._scrollRect.horizontalNormalizedPosition = scrollPos
end

function Activity142CollectView:createCollectionItem()
	local itemGO = gohelper.cloneInPlace(self._gonodeitem)
	local collectionItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, Activity142CollectionItem)

	table.insert(self.collectionItemList, collectionItem)

	return collectionItem
end

function Activity142CollectView:onDestroyView()
	self.collectionItemList = {}

	Activity142StatController.instance:statCollectionViewEnd()
end

return Activity142CollectView
