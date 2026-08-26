-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookStoryComp.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookStoryComp", package.seeall)

local SurvivalHandbookStoryComp = class("SurvivalHandbookStoryComp", SurvivalHandbookViewComp)

function SurvivalHandbookStoryComp:ctor(parentView)
	self._parentView = parentView
	self.viewContainer = self._parentView.viewContainer
	self.handbookType = SurvivalEnum.HandBookType.Story
end

function SurvivalHandbookStoryComp:init(viewGO)
	SurvivalHandbookStoryComp.super.init(self, viewGO)

	self.tabScroll = gohelper.findChild(viewGO, "tabScroll/Viewport/#tabContent")
	self.go_storyScroll = gohelper.findChild(viewGO, "#go_storyscroll/viewport/content/#go_story")
	self.subItems = gohelper.findChild(viewGO, "tag/items")
	self.goEmpty = gohelper.findChild(viewGO, "goEmpty")

	local param = SimpleListParam.New()

	param.cellClass = SurvivalHandbookStoryTab
	self.scroll = GameFacade.createSimpleListComp(self.tabScroll, param, nil, self.viewContainer)

	self.scroll:setOnClickItem(self.onClickItem, self)
	self.scroll:setOnSelectChange(self.onSelectChange, self)

	param = SimpleListParam.New()
	param.cellClass = SurvivalHandbookStorySubTab
	self.subTabList = GameFacade.createSimpleListComp(self.subItems, param, nil, self.viewContainer)

	self.subTabList:setOnClickItem(self.onClickSubItem, self)
	self.subTabList:setOnSelectChange(self.onSelectSubChange, self)
	self.subTabList:addCustomItem(gohelper.findChild(self.subItems, "1"))
	self.subTabList:addCustomItem(gohelper.findChild(self.subItems, "2"))

	param = SimpleListParam.New()
	param.cellClass = SurvivalHandbookStoryItem
	self.storyScroll = GameFacade.createSimpleListComp(self.go_storyScroll, param, nil, self.viewContainer)
end

function SurvivalHandbookStoryComp:onClickItem(item)
	self.scroll:setSelect(item.itemIndex)
end

function SurvivalHandbookStoryComp:onSelectChange(item)
	local datas = {}

	for i, v in ipairs(item.subTypes) do
		table.insert(datas, {
			subType = v,
			type = self.handbookType,
			tabIndex = item.itemIndex
		})
	end

	self.subTabList:setData(datas)
	self.subTabList:setSelect(1)
end

function SurvivalHandbookStoryComp:onClickSubItem(item)
	self.subTabList:setSelect(item.itemIndex)
end

function SurvivalHandbookStoryComp:onSelectSubChange(item)
	SurvivalHandbookController.instance:markNewHandbook(self.handbookType, item.subType)
	self:refreshStoryList()
end

function SurvivalHandbookStoryComp:onOpen()
	local data = {
		{
			roleId = 1,
			subTypes = {
				SurvivalEnum.HandBookRoleSubType.Role_1_1,
				SurvivalEnum.HandBookRoleSubType.Role_1_2
			}
		},
		{
			roleId = 2,
			subTypes = {
				SurvivalEnum.HandBookRoleSubType.Role_2_1,
				SurvivalEnum.HandBookRoleSubType.Role_2_2
			}
		}
	}

	self.scroll:setData(data)
	self.scroll:setSelect(1)
	self.scroll:rebuildLayout()
end

function SurvivalHandbookStoryComp:refreshStoryList()
	local subItem = self.subTabList:getCurSelectItem()
	local subType = subItem.subType
	local survivalHandbookMos = SurvivalHandbookModel.instance:getHandBookUnlockDatas(self.handbookType, subType)

	table.sort(survivalHandbookMos, SurvivalHandbookModel.instance.handBookStorySortFunc)

	local data = {}

	for i, survivalHandbookMo in ipairs(survivalHandbookMos) do
		local isFinish = survivalHandbookMo:isStoryFinish()

		table.insert(data, {
			survivalHandbookMo = survivalHandbookMo,
			isFinish = isFinish
		})
	end

	self.storyScroll:setRefreshAnimation(true, 0.03, nil, 0)
	self.storyScroll:setData(data)
	gohelper.setActive(self.goEmpty, #data == 0)
end

return SurvivalHandbookStoryComp
