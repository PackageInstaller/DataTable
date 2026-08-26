-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/actbp/Anniversary3ActBpPropViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.actbp.Anniversary3ActBpPropViewContainer", package.seeall)

local Anniversary3ActBpPropViewContainer = class("Anniversary3ActBpPropViewContainer", BaseViewContainer)

function Anniversary3ActBpPropViewContainer:buildViews()
	return {
		Anniversary3ActBpPropView.New()
	}
end

return Anniversary3ActBpPropViewContainer
