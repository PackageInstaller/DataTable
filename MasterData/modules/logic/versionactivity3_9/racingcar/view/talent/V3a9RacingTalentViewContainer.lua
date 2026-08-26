-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/talent/V3a9RacingTalentViewContainer.lua

module("modules.logic.versionactivity3_9.racingcar.view.talent.V3a9RacingTalentViewContainer", package.seeall)

local V3a9RacingTalentViewContainer = class("V3a9RacingTalentViewContainer", BaseViewContainer)

function V3a9RacingTalentViewContainer:buildViews()
	local views = {}

	self._view = V3a9RacingTalentView.New()

	table.insert(views, self._view)
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/panel"))

	return views
end

function V3a9RacingTalentViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		local scrollParam = ListScrollParam.New()

		scrollParam.scrollGOPath = "scroll_itemlist"
		scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		scrollParam.prefabUrl = self._viewSetting.otherRes.itemRes
		scrollParam.cellClass = V3a9RacingTalentRoleItem
		scrollParam.scrollDir = ScrollEnum.ScrollDirH
		scrollParam.startSpace = 50
		scrollParam.cellWidth = 450
		scrollParam.cellHeight = 600
		scrollParam.cellSpaceH = 60
		self._roleScrollview = LuaListScrollView.New(V3a9RacingRoleListModel.instance, scrollParam)

		return {
			V3a9RacingTalentPanel.New(),
			(MultiView.New({
				V3a9RacingRolePanel.New(),
				self._roleScrollview
			}))
		}
	end
end

function V3a9RacingTalentViewContainer:selectActTab(jumpTabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, jumpTabId)
end

function V3a9RacingTalentViewContainer:onContainerInit()
	if not self.viewParam.defaultTabId then
		self.viewParam.defaultTabIds = {}
		self.viewParam.defaultTabIds[1] = self.viewParam.defaultTabId
	end
end

return V3a9RacingTalentViewContainer
