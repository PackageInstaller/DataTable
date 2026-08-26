-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryTipViewContainer2.lua

module("modules.logic.necrologiststory.view.NecrologistStoryTipViewContainer2", package.seeall)

local NecrologistStoryTipViewContainer2 = class("NecrologistStoryTipViewContainer2", BaseViewContainer)

function NecrologistStoryTipViewContainer2:buildViews()
	local views = {}

	table.insert(views, NecrologistStoryTipView2.New())

	return views
end

return NecrologistStoryTipViewContainer2
