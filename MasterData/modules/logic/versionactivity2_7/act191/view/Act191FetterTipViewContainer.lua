-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191FetterTipViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191FetterTipViewContainer", package.seeall)

local Act191FetterTipViewContainer = class("Act191FetterTipViewContainer", BaseViewContainer)

function Act191FetterTipViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191FetterTipView.New())

	return views
end

return Act191FetterTipViewContainer
