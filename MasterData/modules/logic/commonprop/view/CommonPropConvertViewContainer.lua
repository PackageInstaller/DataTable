-- chunkname: @modules/logic/commonprop/view/CommonPropConvertViewContainer.lua

module("modules.logic.commonprop.view.CommonPropConvertViewContainer", package.seeall)

local CommonPropConvertViewContainer = class("CommonPropConvertViewContainer", BaseViewContainer)

function CommonPropConvertViewContainer:buildViews()
	local views = {}

	table.insert(views, CommonPropConvertView.New())

	return views
end

return CommonPropConvertViewContainer
