-- chunkname: @modules/logic/dungeon/view/rouge/DungeonRougeView.lua

module("modules.logic.dungeon.view.rouge.DungeonRougeView", package.seeall)

local DungeonRougeView = class("DungeonRougeView", BaseViewExtended)

function DungeonRougeView:onInitView()
	self.go_fragments = gohelper.findChild(self.viewGO, "#go_fragments")
	self.content = gohelper.findChild(self.viewGO, "#scroll_chapterlist/viewport/content")
	self.DungeonPlayTabItem_1 = gohelper.findChild(self.content, "DungeonAdvPlayTabItem_1")
	self.DungeonPlayTabItem_2 = gohelper.findChild(self.content, "DungeonAdvPlayTabItem_2")

	local tabResList = self.viewContainer._viewSetting.tabRes
	local subTabResList = tabResList and tabResList[2]

	self._viewResList = subTabResList and subTabResList[6]
	self.infos = self:getUserDataTb_()

	table.insert(self.infos, {
		tab = self.DungeonPlayTabItem_1,
		type = DungeonEnum.ChapterType.Rouge,
		isOpenFunc = RougeOutsideModel.isUnlock,
		isOpenFuncObj = RougeOutsideModel.instance,
		openFunc = self.openRougeMainView,
		openFuncObj = self,
		tabRedDot = RedDotEnum.DotNode.RougeEnter
	})
	table.insert(self.infos, {
		tab = self.DungeonPlayTabItem_2,
		type = DungeonEnum.ChapterType.Rouge2,
		isOpenFunc = Rouge2_Controller.checkIsOpen,
		isOpenFuncObj = Rouge2_Controller.instance,
		openFunc = self.openRouge2MainView,
		openFuncObj = self,
		tabRedDot = RedDotEnum.DotNode.V3a2_Rouge_Entry
	})

	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = DungeonRougeTabItem
	self.tabList = GameFacade.createSimpleListComp(self.content, scrollParam, nil, self.viewContainer)

	self.tabList:setOnClickItem(function(self, item)
		self.tabList:setSelect(item.itemIndex)
	end, self)
	self.tabList:setOnSelectChange(function(self, item)
		if item.data.openFunc then
			item.data.openFunc(item.data.openFuncObj)
		end
	end, self)

	for _, v in ipairs(self.infos) do
		gohelper.setActive(v.tab, v.isOpen)
		self.tabList:addCustomItem(v.tab)
	end
end

function DungeonRougeView:addEvents()
	return
end

function DungeonRougeView:onOpen()
	local curChapterType = DungeonModel.instance.curChapterType
	local data = {}
	local select

	for i, v in ipairs(self.infos) do
		local isOpenFunc = v.isOpenFunc
		local isOpenFuncObj = v.isOpenFuncObj
		local isOpen = isOpenFunc and v.isOpenFunc(isOpenFuncObj)

		v.isOpen = isOpen

		table.insert(data, v)

		if isOpen and (not select or curChapterType and curChapterType == v.type) then
			select = i
		end
	end

	self.tabList:setData(data)
	self.tabList:setSelect(select)
end

function DungeonRougeView:openRougeMainView()
	self:openExclusiveView(1, 1, RougeActivityView, self._viewResList[2], self.go_fragments)
end

function DungeonRougeView:openRouge2MainView()
	self:openExclusiveView(1, 2, Rouge2_ActivityView, self._viewResList[3], self.go_fragments)
end

function DungeonRougeView:onClose()
	return
end

function DungeonRougeView:onDestroyView()
	return
end

return DungeonRougeView
