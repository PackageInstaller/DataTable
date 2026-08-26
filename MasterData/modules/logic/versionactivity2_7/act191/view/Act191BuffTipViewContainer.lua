-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191BuffTipViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191BuffTipViewContainer", package.seeall)

local Act191BuffTipViewContainer = class("Act191BuffTipViewContainer", BaseViewContainer)

function Act191BuffTipViewContainer:buildViews()
	return {
		Act191BuffTipView.New()
	}
end

function Act191BuffTipViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Act191BuffTipViewContainer
