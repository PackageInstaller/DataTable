-- chunkname: @modules/logic/rouge/dlc/102/view/RougeCollectionLevelUpViewContainer.lua

module("modules.logic.rouge.dlc.102.view.RougeCollectionLevelUpViewContainer", package.seeall)

local RougeCollectionLevelUpViewContainer = class("RougeCollectionLevelUpViewContainer", BaseViewContainer)

function RougeCollectionLevelUpViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeCollectionLevelUpView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, TabViewGroup.New(2, "#go_rougemapdetailcontainer"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Left/#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = RougeEnum.ResPath.CollectionLevelUpLeftItem
	scrollParam.cellClass = RougeCollectionLevelUpLeftItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 850
	scrollParam.cellHeight = 180
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 8
	scrollParam.startSpace = 0
	self.scrollView = LuaListScrollView.New(RougeCollectionLevelUpListModel.instance, scrollParam)

	table.insert(views, self.scrollView)

	return views
end

function RougeCollectionLevelUpViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		if self.viewParam then
			self.navigateView = NavigateButtonsView.New({
				self.viewParam,
				false,
				false
			})

			return {
				self.navigateView
			}
		end
	elseif tabContainerId == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function RougeCollectionLevelUpViewContainer:onContainerInit()
	self.listRemoveComp = ListScrollAnimRemoveItem.Get(self.scrollView)

	self.listRemoveComp:setMoveInterval(0)
end

function RougeCollectionLevelUpViewContainer:getListRemoveComp()
	return self.listRemoveComp
end

function RougeCollectionLevelUpViewContainer:getNavigateView()
	return self.navigateView
end

return RougeCollectionLevelUpViewContainer
