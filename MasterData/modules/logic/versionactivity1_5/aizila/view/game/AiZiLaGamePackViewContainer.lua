-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGamePackViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGamePackViewContainer", package.seeall)

local AiZiLaGamePackViewContainer = class("AiZiLaGamePackViewContainer", BaseViewContainer)

function AiZiLaGamePackViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_Items"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = AiZiLaGoodsItem.prefabPath
	scrollParam.cellClass = AiZiLaGoodsItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 270
	scrollParam.cellHeight = 250
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(AiZiLaGamePackListModel.instance, scrollParam))
	table.insert(views, AiZiLaGamePackView.New())

	return views
end

function AiZiLaGamePackViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function AiZiLaGamePackViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return AiZiLaGamePackViewContainer
