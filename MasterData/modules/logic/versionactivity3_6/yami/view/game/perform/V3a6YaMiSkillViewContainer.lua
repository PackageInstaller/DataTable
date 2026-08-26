-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/perform/V3a6YaMiSkillViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.game.perform.V3a6YaMiSkillViewContainer", package.seeall)

local V3a6YaMiSkillViewContainer = class("V3a6YaMiSkillViewContainer", BaseViewContainer)

function V3a6YaMiSkillViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/scroll_employeelist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = V3a6YaMiSkillHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = V3a6YaMiEnum.HeroHandbookRowCount
	scrollParam.cellWidth = 275
	scrollParam.cellHeight = V3a6YaMiEnum.HeroHandbookItemHight
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 10
	self._listModel = V3a6YaMiHeroSkillListModel.instance
	self._scrollview = LuaListScrollView.New(self._listModel, scrollParam)

	table.insert(views, self._scrollview)
	table.insert(views, V3a6YaMiSkillView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/#go_panel"))

	return views
end

function V3a6YaMiSkillViewContainer:buildTabViews(tabContainerId)
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
		self.detailView = V3a6YaMiHeroHandbookDetailView.New()

		return {
			self.detailView
		}
	end
end

function V3a6YaMiSkillViewContainer:isForceHideUnlockBtn()
	return true
end

function V3a6YaMiSkillViewContainer:getListModel()
	return self._listModel
end

return V3a6YaMiSkillViewContainer
