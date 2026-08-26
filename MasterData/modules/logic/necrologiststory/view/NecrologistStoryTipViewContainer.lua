-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryTipViewContainer.lua

module("modules.logic.necrologiststory.view.NecrologistStoryTipViewContainer", package.seeall)

local NecrologistStoryTipViewContainer = class("NecrologistStoryTipViewContainer", BaseViewContainer)

function NecrologistStoryTipViewContainer:buildViews()
	local views = {}

	table.insert(views, NecrologistStoryTipView.New())

	return views
end

return NecrologistStoryTipViewContainer
