-- chunkname: @modules/logic/versionactivity3_3/arcade/view/develop/ArcadeDevelopViewContainer.lua

module("modules.logic.versionactivity3_3.arcade.view.develop.ArcadeDevelopViewContainer", package.seeall)

local ArcadeDevelopViewContainer = class("ArcadeDevelopViewContainer", BaseViewContainer)

function ArcadeDevelopViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeDevelopView.New())
	table.insert(views, TabViewGroupFit.New(1, "#go_view"))
	table.insert(views, TabViewGroup.New(2, "#go_currency"))

	return views
end

function ArcadeDevelopViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local scrollParam = ListScrollParam.New()

		scrollParam.scrollGOPath = "root/#scroll_talent"
		scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
		scrollParam.prefabUrl = "root/#go_item"
		scrollParam.cellClass = ArcadeTalentItem
		scrollParam.scrollDir = ScrollEnum.ScrollDirH
		scrollParam.cellWidth = 508
		scrollParam.cellHeight = 900
		scrollParam.cellSpaceH = 26
		self._talentScrollview = LuaListScrollView.New(ArcadeTalentListModel.instance, scrollParam)

		return {
			ArcadeHeroView.New(),
			(MultiView.New({
				ArcadeTalentView.New(),
				self._talentScrollview
			}))
		}
	elseif tabContainerId == 2 then
		self._curencyView = ArcadeCurrencyView.New({
			ArcadeEnum.AttributeConst.DiamondCount
		})

		return {
			self._curencyView
		}
	end
end

function ArcadeDevelopViewContainer:refreshCurrencyView()
	self._curencyView:refreshView()
end

function ArcadeDevelopViewContainer:selectActTab(jumpTabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, jumpTabId)
end

function ArcadeDevelopViewContainer:onContainerInit()
	if not self.viewParam.defaultTabId then
		self.viewParam.defaultTabIds = {}
		self.viewParam.defaultTabIds[1] = self.viewParam.defaultTabId
	end
end

return ArcadeDevelopViewContainer
