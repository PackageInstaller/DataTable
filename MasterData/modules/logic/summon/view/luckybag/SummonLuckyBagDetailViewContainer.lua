-- chunkname: @modules/logic/summon/view/luckybag/SummonLuckyBagDetailViewContainer.lua

module("modules.logic.summon.view.luckybag.SummonLuckyBagDetailViewContainer", package.seeall)

local SummonLuckyBagDetailViewContainer = class("SummonLuckyBagDetailViewContainer", BaseViewContainer)

function SummonLuckyBagDetailViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "category/#scroll_category"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SummonPoolDetailCategoryItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 380
	scrollParam.cellHeight = 116
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 4

	table.insert(views, LuaListScrollView.New(SummonPoolDetailCategoryListModel.instance, scrollParam))
	table.insert(views, SummonPoolDetailView.New())
	table.insert(views, TabViewGroup.New(1, "info"))

	return views
end

function SummonLuckyBagDetailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			MultiView.New({
				SummonPoolDetailDescView.New(),
				SummonLuckyBagDescProbUpView.New()
			}),
			SummonLuckyBagProbabilityView.New()
		}
	end
end

function SummonLuckyBagDetailViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return SummonLuckyBagDetailViewContainer
