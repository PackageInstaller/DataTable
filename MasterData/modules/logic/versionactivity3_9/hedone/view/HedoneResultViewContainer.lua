-- chunkname: @modules/logic/versionactivity3_9/hedone/view/HedoneResultViewContainer.lua

module("modules.logic.versionactivity3_9.hedone.view.HedoneResultViewContainer", package.seeall)

local HedoneResultViewContainer = class("HedoneResultViewContainer", BaseViewContainer)

function HedoneResultViewContainer:buildViews()
	local views = {}

	table.insert(views, HedoneResultView.New())

	return views
end

return HedoneResultViewContainer
