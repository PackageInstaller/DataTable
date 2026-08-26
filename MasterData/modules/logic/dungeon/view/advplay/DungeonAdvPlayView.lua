-- chunkname: @modules/logic/dungeon/view/advplay/DungeonAdvPlayView.lua

module("modules.logic.dungeon.view.advplay.DungeonAdvPlayView", package.seeall)

local DungeonAdvPlayView = class("DungeonAdvPlayView", BaseView)

function DungeonAdvPlayView:onInitView()
	self.go_fragments = gohelper.findChild(self.viewGO, "#go_fragments")
	self.content = gohelper.findChild(self.viewGO, "#scroll_chapterlist/viewport/content")
	self.DungeonAdvPlayTabItem_1 = gohelper.findChild(self.content, "DungeonAdvPlayTabItem_1")
	self.DungeonAdvPlayTabItem_2 = gohelper.findChild(self.content, "DungeonAdvPlayTabItem_2")
	self.infos = {
		{
			tab = self.DungeonAdvPlayTabItem_1,
			advPlayType = DungeonEnum.AdvPlayType.Survival,
			isOpenFunc = SurvivalController.instance.isOpenSurvival,
			tabRedDot = RedDotEnum.DotNode.AdvPlay_Survival,
			fragment = DungeonSurvivalComp
		},
		{
			tab = self.DungeonAdvPlayTabItem_2,
			advPlayType = DungeonEnum.AdvPlayType.Explore,
			isOpenFunc = ExploreSimpleModel.instance.isShowExplore,
			tabRedDot = RedDotEnum.DotNode.AdvPlay_Explore,
			fragment = DungeonExploreComp
		}
	}

	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = DungeonAdvPlayTabItem
	self.tabList = GameFacade.createSimpleListComp(self.content, scrollParam, nil, self.viewContainer)

	self.tabList:setOnClickItem(function(self, item)
		self.tabList:setSelect(item.itemIndex)
	end, self)
	self.tabList:setOnSelectChange(function(self, item)
		self.fragmentList:setSelect(item.itemIndex)
	end, self)

	self.fragmentList = GameFacade.createSimpleListComp(self.go_fragments, nil, nil, self.viewContainer)

	for i, v in ipairs(self.infos) do
		local transName = string.lower(v.fragment.__cname)
		local goFragment = gohelper.findChild(self.go_fragments, transName)

		gohelper.setActive(v.tab, v.isOpen)
		gohelper.setActive(goFragment, v.isOpen)
		self.tabList:addCustomItem(v.tab)
		self.fragmentList:addCustomItem(goFragment, v.fragment)
	end
end

function DungeonAdvPlayView:addEvents()
	return
end

function DungeonAdvPlayView:onOpen()
	if self.viewParam then
		self.advPlayJumpType = self.viewParam.advPlayJumpType
	end

	local data = {}
	local select

	for i, v in ipairs(self.infos) do
		local isOpenFunc = v.isOpenFunc
		local isOpen = isOpenFunc and isOpenFunc()

		table.insert(data, {
			tabRedDot = v.tabRedDot,
			isOpen = isOpen
		})

		if isOpen and (not select or self.advPlayJumpType and self.advPlayJumpType == v.advPlayType) then
			select = i
		end
	end

	self.fragmentList:setData(data)
	self.tabList:setData(data)
	self.tabList:setSelect(select)
end

function DungeonAdvPlayView:onClose()
	return
end

function DungeonAdvPlayView:onDestroyView()
	return
end

return DungeonAdvPlayView
