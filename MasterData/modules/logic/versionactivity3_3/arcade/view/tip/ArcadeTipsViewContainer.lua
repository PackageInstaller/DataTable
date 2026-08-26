-- chunkname: @modules/logic/versionactivity3_3/arcade/view/tip/ArcadeTipsViewContainer.lua

module("modules.logic.versionactivity3_3.arcade.view.tip.ArcadeTipsViewContainer", package.seeall)

local ArcadeTipsViewContainer = class("ArcadeTipsViewContainer", BaseViewContainer)

function ArcadeTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeTipsView.New())

	return views
end

return ArcadeTipsViewContainer
