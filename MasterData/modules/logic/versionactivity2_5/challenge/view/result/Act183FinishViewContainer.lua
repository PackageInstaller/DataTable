-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183FinishViewContainer.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183FinishViewContainer", package.seeall)

local Act183FinishViewContainer = class("Act183FinishViewContainer", BaseViewContainer)

function Act183FinishViewContainer:buildViews()
	local views = {}

	table.insert(views, Act183FinishView.New())

	return views
end

return Act183FinishViewContainer
