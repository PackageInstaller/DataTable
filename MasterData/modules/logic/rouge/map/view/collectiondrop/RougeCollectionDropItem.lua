-- chunkname: @modules/logic/rouge/map/view/collectiondrop/RougeCollectionDropItem.lua

module("modules.logic.rouge.map.view.collectiondrop.RougeCollectionDropItem", package.seeall)

local RougeCollectionDropItem = class("RougeCollectionDropItem", UserDataDispose)

function RougeCollectionDropItem:init(go, parent)
	self:__onInit()

	self.go = go
	self.parent = parent

	self:_editableInitView()
end

function RougeCollectionDropItem:_editableInitView()
	self.animator = self.go:GetComponent(gohelper.Type_Animator)
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._goenchantlist = gohelper.findChild(self.go, "#go_enchantlist")
	self._gohole = gohelper.findChild(self.go, "#go_enchantlist/#go_hole")
	self._gridLayout = gohelper.findChild(self.go, "Grid")
	self._gogriditem = gohelper.findChild(self.go, "Grid/#go_grid")
	self._simagecollection = gohelper.findChildSingleImage(self.go, "#simage_collection")
	self._txtname = gohelper.findChildText(self.go, "#txt_name")
	self._scrollreward = gohelper.findChild(self.go, "scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._godescContent = gohelper.findChild(self.go, "scroll_desc/Viewport/#go_descContent")
	self._gotags = gohelper.findChild(self.go, "tagcontent/tags")
	self._gotagitem = gohelper.findChild(self.go, "tagcontent/tags/#go_tagitem")
	self._gotips = gohelper.findChild(self.go, "#go_tips")
	self._gotipscontent = gohelper.findChild(self.go, "#go_tips/#go_tipscontent")
	self._gotipitem = gohelper.findChild(self.go, "#go_tips/#go_tipscontent/#txt_tagitem")
	self._btnopentagtips = gohelper.findChildButtonWithAudio(self.go, "tagcontent/#btn_opentagtips")
	self._btnclosetagtips = gohelper.findChildButtonWithAudio(self.go, "#go_tips/#btn_closetips")
	self.holeGoList = self:getUserDataTb_()

	table.insert(self.holeGoList, self._gohole)

	self.gridList = self:getUserDataTb_()
	self._itemInstTab = self:getUserDataTb_()
	self.click = gohelper.getClickWithDefaultAudio(self.go)

	self.click:AddClickListener(self.onClickSelf, self)
	self._btnopentagtips:AddClickListener(self._opentagtipsOnClick, self)
	self._btnclosetagtips:AddClickListener(self._closetagtipsOnClick, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectDropChange, self.onSelectDropChange, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function RougeCollectionDropItem:onClickSelf()
	self.parent:selectPos(self.index)
	self:refreshSelect()
end

function RougeCollectionDropItem:_opentagtipsOnClick()
	gohelper.setActive(self._gotips, true)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(self.collectionId, nil, self._gotipscontent, self._gotipitem)
end

function RougeCollectionDropItem:_closetagtipsOnClick()
	gohelper.setActive(self._gotips, false)
end

function RougeCollectionDropItem:onSelectDropChange()
	self.select = self.parent:isSelect(self.index)

	self:refreshSelect()
end

function RougeCollectionDropItem:setParentScroll(parentScroll)
	self._scrollreward.parentGameObject = parentScroll
end

function RougeCollectionDropItem:update(index, collectionId)
	self.animator:Play("open", 0, 0)

	self.select = false
	self.index = index
	self.collectionId = tonumber(collectionId)
	self.collectionCo = RougeCollectionConfig.instance:getCollectionCfg(self.collectionId)

	self:refreshHole()
	RougeCollectionHelper.loadShapeGrid(self.collectionId, self._gridLayout, self._gogriditem, self.gridList)
	RougeCollectionHelper.loadCollectionTags(self.collectionId, self._gotags, self._gotagitem)
	self._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self.collectionId))

	self._txtname.text = RougeCollectionConfig.instance:getCollectionName(self.collectionId)

	self:refreshEffectDesc()
	self:refreshSelect()
end

function RougeCollectionDropItem:refreshHole()
	local holeNum = self.collectionCo.holeNum

	gohelper.setActive(self._goenchantlist, holeNum > 0)

	if holeNum > 1 then
		for i = 1, holeNum do
			local hole = self.holeGoList[i]

			if not hole then
				hole = gohelper.cloneInPlace(self._gohole)

				table.insert(self.holeGoList, hole)
			end

			gohelper.setActive(hole, true)
		end

		for i = holeNum + 1, #self.holeGoList do
			gohelper.setActive(self.holeGoList[i], false)
		end
	end
end

function RougeCollectionDropItem:refreshEffectDesc()
	self._allClicks = self._allClicks or self:getUserDataTb_()
	self._clickLen = self._clickLen or 0

	for i = 1, self._clickLen do
		self._allClicks[i]:RemoveClickListener()
	end

	self._clickLen = 0

	RougeCollectionDescHelper.setCollectionDescInfos2(self.collectionId, nil, self._godescContent, self._itemInstTab)

	local clicks = self._scrollreward.gameObject:GetComponentsInChildren(typeof(SLFramework.UGUI.UIClickListener), true)

	self._clickLen = clicks.Length

	for i = 0, self._clickLen - 1 do
		self._allClicks[i + 1] = clicks[i]

		self._allClicks[i + 1]:AddClickListener(self.onClickSelf, self)
		gohelper.addUIClickAudio(self._allClicks[i + 1].gameObject)
	end
end

function RougeCollectionDropItem:refreshSelect()
	gohelper.setActive(self._goselect, self.select)
end

function RougeCollectionDropItem:_onSwitchCollectionInfoType()
	self:refreshEffectDesc()
end

function RougeCollectionDropItem:hide()
	gohelper.setActive(self.go, false)
end

function RougeCollectionDropItem:show()
	gohelper.setActive(self.go, true)
end

function RougeCollectionDropItem:onClose()
	self.animator:Play(self.select and "close" or "normal", 0, 0)
end

function RougeCollectionDropItem:destroy()
	if self._clickLen then
		for i = 1, self._clickLen do
			self._allClicks[i]:RemoveClickListener()
		end
	end

	self.click:RemoveClickListener()
	self._btnopentagtips:RemoveClickListener()
	self._btnclosetagtips:RemoveClickListener()
	self._simagecollection:UnLoadImage()
	self:__onDispose()
end

return RougeCollectionDropItem
