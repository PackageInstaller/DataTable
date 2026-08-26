-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultUnlockInfoViewContainer.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultUnlockInfoViewContainer", package.seeall)

local Rouge2_ResultUnlockInfoViewContainer = class("Rouge2_ResultUnlockInfoViewContainer", BaseViewContainer)

function Rouge2_ResultUnlockInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_ResultUnlockInfoView.New())

	return views
end

return Rouge2_ResultUnlockInfoViewContainer
