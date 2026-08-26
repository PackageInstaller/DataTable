-- chunkname: @modules/logic/summon/view/SummonPoolPogressRewardViewContainer.lua

module("modules.logic.summon.view.SummonPoolPogressRewardViewContainer", package.seeall)

local SummonPoolPogressRewardViewContainer = class("SummonPoolPogressRewardViewContainer", BaseViewContainer)

function SummonPoolPogressRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonPoolPogressRewardView.New())

	return views
end

return SummonPoolPogressRewardViewContainer
