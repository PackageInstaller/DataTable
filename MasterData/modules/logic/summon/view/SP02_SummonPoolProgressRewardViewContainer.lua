-- chunkname: @modules/logic/summon/view/SP02_SummonPoolProgressRewardViewContainer.lua

module("modules.logic.summon.view.SP02_SummonPoolProgressRewardViewContainer", package.seeall)

local SP02_SummonPoolProgressRewardViewContainer = class("SP02_SummonPoolProgressRewardViewContainer", BaseViewContainer)

function SP02_SummonPoolProgressRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, SP02_SummonPoolProgressRewardView.New())

	return views
end

return SP02_SummonPoolProgressRewardViewContainer
