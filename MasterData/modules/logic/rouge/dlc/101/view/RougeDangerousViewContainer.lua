-- chunkname: @modules/logic/rouge/dlc/101/view/RougeDangerousViewContainer.lua

module("modules.logic.rouge.dlc.101.view.RougeDangerousViewContainer", package.seeall)

local RougeDangerousViewContainer = class("RougeDangerousViewContainer", BaseViewContainer)

function RougeDangerousViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeDangerousView.New())

	return views
end

function RougeDangerousViewContainer:playOpenTransition()
	RougeDangerousViewContainer.super.playOpenTransition(self, {
		noBlock = true,
		duration = RougeDangerousView.OpenViewDuration
	})
end

return RougeDangerousViewContainer
