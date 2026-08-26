-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyMythSuccessViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyMythSuccessViewContainer", package.seeall)

local OdysseyMythSuccessViewContainer = class("OdysseyMythSuccessViewContainer", BaseViewContainer)

function OdysseyMythSuccessViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyMythSuccessView.New())

	return views
end

return OdysseyMythSuccessViewContainer
