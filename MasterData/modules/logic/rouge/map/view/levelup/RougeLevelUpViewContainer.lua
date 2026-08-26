-- chunkname: @modules/logic/rouge/map/view/levelup/RougeLevelUpViewContainer.lua

module("modules.logic.rouge.map.view.levelup.RougeLevelUpViewContainer", package.seeall)

local RougeLevelUpViewContainer = class("RougeLevelUpViewContainer", BaseViewContainer)

function RougeLevelUpViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeLevelUpView.New())

	return views
end

return RougeLevelUpViewContainer
