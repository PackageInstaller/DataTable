-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191HeroTipViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191HeroTipViewContainer", package.seeall)

local Act191HeroTipViewContainer = class("Act191HeroTipViewContainer", BaseViewContainer)

function Act191HeroTipViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191HeroTipView.New())

	return views
end

return Act191HeroTipViewContainer
