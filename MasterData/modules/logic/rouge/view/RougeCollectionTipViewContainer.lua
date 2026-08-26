-- chunkname: @modules/logic/rouge/view/RougeCollectionTipViewContainer.lua

module("modules.logic.rouge.view.RougeCollectionTipViewContainer", package.seeall)

local RougeCollectionTipViewContainer = class("RougeCollectionTipViewContainer", BaseViewContainer)

function RougeCollectionTipViewContainer:buildViews()
	return {
		RougeCollectionTipView.New()
	}
end

function RougeCollectionTipViewContainer:buildTabViews(tabContainerId)
	return
end

return RougeCollectionTipViewContainer
