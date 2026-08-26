-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/YaXianGameTipViewContainer.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameTipViewContainer", package.seeall)

local YaXianGameTipViewContainer = class("YaXianGameTipViewContainer", BaseViewContainer)

function YaXianGameTipViewContainer:buildViews()
	local views = {}

	table.insert(views, YaXianGameTipView.New())

	return views
end

function YaXianGameTipViewContainer:buildTabViews(tabContainerId)
	return
end

return YaXianGameTipViewContainer
