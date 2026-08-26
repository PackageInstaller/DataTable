-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3DecomposeFilterView.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3DecomposeFilterView", package.seeall)

local Season123_2_3DecomposeFilterView = class("Season123_2_3DecomposeFilterView", BaseView)

function Season123_2_3DecomposeFilterView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gorare = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_rare")
	self._gorareContainer = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_rare/#go_rareContainer")
	self._gorareItem = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_rare/#go_rareContainer/#go_rareItem")
	self._gotag = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_tag")
	self._scrolltag = gohelper.findChildScrollRect(self.viewGO, "container/layoutgroup/#go_tag/#scroll_tag")
	self._gotagContainer = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_tag/#scroll_tag/Viewport/#go_tagContainer")
	self._gotagItem = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_tag/#scroll_tag/Viewport/#go_tagContainer/#go_tagItem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_reset")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_3DecomposeFilterView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function Season123_2_3DecomposeFilterView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function Season123_2_3DecomposeFilterView:_btncloseOnClick()
	self:closeThis()
end

function Season123_2_3DecomposeFilterView:_btnresetOnClick()
	for index, v in pairs(self.rareSelectTab) do
		self.rareSelectTab[index] = false
	end

	for index, v in pairs(self.tagSelectTab) do
		self.tagSelectTab[index] = false
	end

	for index, rareItem in pairs(self.rareItemTab) do
		gohelper.setActive(rareItem.goSelected, false)
		gohelper.setActive(rareItem.goUnSelected, true)
	end

	for index, tagItem in pairs(self.tagItemTab) do
		gohelper.setActive(tagItem.goSelected, false)
		gohelper.setActive(tagItem.goUnSelected, true)
	end
end

function Season123_2_3DecomposeFilterView:_btnconfirmOnClick()
	Season123DecomposeModel.instance:setRareSelectItem(self.rareSelectTab)
	Season123DecomposeModel.instance:setTagSelectItem(self.tagSelectTab)
	Season123DecomposeModel.instance:clearCurSelectItem()
	Season123DecomposeModel.instance:initList()
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnResetBatchDecomposeView)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnDecomposeItemSelect)
	self:closeThis()
end

function Season123_2_3DecomposeFilterView:_editableInitView()
	gohelper.setActive(self._gorareItem, false)

	self.rareItemTab = self:getUserDataTb_()
	self.rareSelectTab = {}
	self.tagItemTab = self:getUserDataTb_()
	self.tagSelectTab = {}
end

function Season123_2_3DecomposeFilterView:onOpen()
	self:createRareItem()
	self:createTagItem()
	self:refreshUI()
end

function Season123_2_3DecomposeFilterView:refreshUI()
	self:refreshRareSelectUI()
	self:refreshTagSelectUI()
end

function Season123_2_3DecomposeFilterView:refreshRareSelectUI()
	self.rareSelectTab = tabletool.copy(Season123DecomposeModel.instance.rareSelectTab)

	for index, rareItem in pairs(self.rareItemTab) do
		gohelper.setActive(rareItem.goSelected, self.rareSelectTab[index])
		gohelper.setActive(rareItem.goUnSelected, not self.rareSelectTab[index])
	end
end

function Season123_2_3DecomposeFilterView:refreshTagSelectUI()
	self.tagSelectTab = tabletool.copy(Season123DecomposeModel.instance.tagSelectTab)

	for index, tagItem in pairs(self.tagItemTab) do
		local tagId = tagItem.data.id

		gohelper.setActive(tagItem.goSelected, self.tagSelectTab[tagId])
		gohelper.setActive(tagItem.goUnSelected, not self.tagSelectTab[tagId])
	end
end

function Season123_2_3DecomposeFilterView:createRareItem()
	for i = 5, 1, -1 do
		local rareItem = self.rareItemTab[i]

		if not rareItem then
			rareItem = {
				rare = i,
				go = gohelper.clone(self._gorareItem, self._gorareContainer, "rare" .. i)
			}
			rareItem.goSelected = gohelper.findChild(rareItem.go, "selected")
			rareItem.goUnSelected = gohelper.findChild(rareItem.go, "unselected")
			rareItem.icon = gohelper.findChildImage(rareItem.go, "image_rareicon")
			rareItem.txt = gohelper.findChildText(rareItem.go, "tagText")
			rareItem.click = gohelper.findChildButtonWithAudio(rareItem.go, "click")
			self.rareItemTab[i] = rareItem
		end

		gohelper.setActive(rareItem.go, true)
		gohelper.setActive(rareItem.goUnSelected, true)
		gohelper.setActive(rareItem.goSelected, false)
		UISpriteSetMgr.instance:setSeason123Sprite(rareItem.icon, "v1a7_season_cardcareer_" .. i, true)
		SLFramework.UGUI.GuiHelper.SetColor(rareItem.txt, "#C1C1C1")

		rareItem.txt.text = luaLang("Season123Rare_" .. i)

		rareItem.click:AddClickListener(self.rareItemOnClick, self, i)
	end
end

function Season123_2_3DecomposeFilterView:rareItemOnClick(rare)
	self:setRareSelectState(rare)

	local isSelected = self.rareSelectTab[rare]

	SLFramework.UGUI.GuiHelper.SetColor(self.rareItemTab[rare].txt, isSelected and "#FF7C41" or "#C1C1C1")
	gohelper.setActive(self.rareItemTab[rare].goSelected, isSelected)
	gohelper.setActive(self.rareItemTab[rare].goUnSelected, not isSelected)
end

function Season123_2_3DecomposeFilterView:setRareSelectState(itemRare)
	self.rareSelectTab[itemRare] = not self.rareSelectTab[itemRare]
end

function Season123_2_3DecomposeFilterView:createTagItem()
	local curSeasonId = Season123DecomposeModel.instance.curActId
	local tagConfig = Season123Config.instance:getSeasonTagDesc(curSeasonId)
	local tagConfigData = self:tagItemSort(tagConfig)

	gohelper.CreateObjList(self, self.tagItemShow, tagConfigData, self._gotagContainer, self._gotagItem)
end

function Season123_2_3DecomposeFilterView:tagItemSort(tagConfig)
	local tagConfigData = {}
	local tagConfigTemp = tabletool.copy(tagConfig)

	for _, config in pairs(tagConfigTemp) do
		table.insert(tagConfigData, config)
	end

	table.sort(tagConfigData, function(a, b)
		return a.order < b.order
	end)

	return tagConfigData
end

function Season123_2_3DecomposeFilterView:tagItemShow(obj, data, index)
	local tagItem = {}

	tagItem.data = data
	tagItem.go = obj
	tagItem.goSelected = gohelper.findChild(tagItem.go, "selected")
	tagItem.goUnSelected = gohelper.findChild(tagItem.go, "unselected")
	tagItem.tagText = gohelper.findChildText(tagItem.go, "tagText")
	tagItem.click = gohelper.findChildButtonWithAudio(tagItem.go, "click")

	tagItem.click:AddClickListener(self.tagItemOnClick, self, data)
	gohelper.setActive(tagItem.goSelected, false)
	gohelper.setActive(tagItem.goUnSelected, true)
	SLFramework.UGUI.GuiHelper.SetColor(tagItem.tagText, "#C1C1C1")

	tagItem.tagText.text = data.desc
	self.tagItemTab[data.id] = tagItem
end

function Season123_2_3DecomposeFilterView:tagItemOnClick(data)
	local tagId = data.id

	self:setTagSelectState(tagId)

	local isSelected = self.tagSelectTab[tagId]

	SLFramework.UGUI.GuiHelper.SetColor(self.tagItemTab[tagId].tagText, isSelected and "#FF7C41" or "#C1C1C1")
	gohelper.setActive(self.tagItemTab[tagId].goSelected, isSelected)
	gohelper.setActive(self.tagItemTab[tagId].goUnSelected, not isSelected)
end

function Season123_2_3DecomposeFilterView:setTagSelectState(tagId)
	self.tagSelectTab[tagId] = not self.tagSelectTab[tagId]
end

function Season123_2_3DecomposeFilterView:onClose()
	return
end

function Season123_2_3DecomposeFilterView:onDestroyView()
	for _, item in pairs(self.rareItemTab) do
		item.click:RemoveClickListener()
	end

	for _, item in pairs(self.tagItemTab) do
		item.click:RemoveClickListener()
	end
end

return Season123_2_3DecomposeFilterView
