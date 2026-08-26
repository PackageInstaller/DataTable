-- chunkname: @modules/logic/autochess/main/view/game/AutoChessMallLevelUpViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessMallLevelUpViewContainer", package.seeall)

local AutoChessMallLevelUpViewContainer = class("AutoChessMallLevelUpViewContainer", BaseViewContainer)

function AutoChessMallLevelUpViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessMallLevelUpView.New())

	return views
end

return AutoChessMallLevelUpViewContainer
