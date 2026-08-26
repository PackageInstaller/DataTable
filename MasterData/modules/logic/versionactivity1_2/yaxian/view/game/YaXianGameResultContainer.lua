-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/YaXianGameResultContainer.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameResultContainer", package.seeall)

local YaXianGameResultContainer = class("YaXianGameResultContainer", BaseViewContainer)

function YaXianGameResultContainer:buildViews()
	return {
		YaXianGameResultView.New()
	}
end

function YaXianGameResultContainer:buildTabViews(tabContainerId)
	return
end

return YaXianGameResultContainer
