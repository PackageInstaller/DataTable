-- chunkname: @modules/logic/summon/view/SP02_SummonPoolProgressRewardSelectViewContainer.lua

module("modules.logic.summon.view.SP02_SummonPoolProgressRewardSelectViewContainer", package.seeall)

local SP02_SummonPoolProgressRewardSelectViewContainer = class("SP02_SummonPoolProgressRewardSelectViewContainer", BaseViewContainer)

function SP02_SummonPoolProgressRewardSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, SP02_SummonPoolProgressRewardSelectView.New())

	return views
end

return SP02_SummonPoolProgressRewardSelectViewContainer
