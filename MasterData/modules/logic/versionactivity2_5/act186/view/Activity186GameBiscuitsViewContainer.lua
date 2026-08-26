-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186GameBiscuitsViewContainer.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186GameBiscuitsViewContainer", package.seeall)

local Activity186GameBiscuitsViewContainer = class("Activity186GameBiscuitsViewContainer", BaseViewContainer)

function Activity186GameBiscuitsViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity186GameBiscuitsView.New())

	return views
end

return Activity186GameBiscuitsViewContainer
