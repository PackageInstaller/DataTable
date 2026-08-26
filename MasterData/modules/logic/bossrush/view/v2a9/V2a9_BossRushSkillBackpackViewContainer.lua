-- chunkname: @modules/logic/bossrush/view/v2a9/V2a9_BossRushSkillBackpackViewContainer.lua

module("modules.logic.bossrush.view.v2a9.V2a9_BossRushSkillBackpackViewContainer", package.seeall)

local V2a9_BossRushSkillBackpackViewContainer = class("V2a9_BossRushSkillBackpackViewContainer", BaseViewContainer)

function V2a9_BossRushSkillBackpackViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "root/#scroll_item/viewport/content/#go_item"
	scrollParam.cellClass = V2a9_BossRushSkillBackpackItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 230
	scrollParam.cellHeight = 230
	scrollParam.cellSpaceV = 40
	scrollParam.cellSpaceH = 40

	table.insert(views, LuaListScrollView.New(V2a9BossRushSkillBackpackListModel.instance, scrollParam))
	table.insert(views, V2a9_BossRushSkillBackpackView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function V2a9_BossRushSkillBackpackViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return V2a9_BossRushSkillBackpackViewContainer
