-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaHandbookViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaHandbookViewContainer", package.seeall)

local AiZiLaHandbookViewContainer = class("AiZiLaHandbookViewContainer", BaseViewContainer)

function AiZiLaHandbookViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Right/#scroll_Items"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = AiZiLaGoodsItem.prefabPath
	scrollParam.cellClass = AiZiLaHandbookItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 286
	scrollParam.cellHeight = 236
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(AiZiLaHandbookListModel.instance, scrollParam))
	table.insert(views, AiZiLaHandbookView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function AiZiLaHandbookViewContainer:onContainerClickModalMask()
	return
end

function AiZiLaHandbookViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return AiZiLaHandbookViewContainer
