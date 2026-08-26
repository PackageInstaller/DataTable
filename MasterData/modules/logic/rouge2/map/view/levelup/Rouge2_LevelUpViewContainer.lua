-- chunkname: @modules/logic/rouge2/map/view/levelup/Rouge2_LevelUpViewContainer.lua

module("modules.logic.rouge2.map.view.levelup.Rouge2_LevelUpViewContainer", package.seeall)

local Rouge2_LevelUpViewContainer = class("Rouge2_LevelUpViewContainer", BaseViewContainer)

function Rouge2_LevelUpViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_LevelUpView.New())

	return views
end

return Rouge2_LevelUpViewContainer
