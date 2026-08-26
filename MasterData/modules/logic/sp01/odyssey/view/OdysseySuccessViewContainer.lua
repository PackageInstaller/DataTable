-- chunkname: @modules/logic/sp01/odyssey/view/OdysseySuccessViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseySuccessViewContainer", package.seeall)

local OdysseySuccessViewContainer = class("OdysseySuccessViewContainer", BaseViewContainer)

function OdysseySuccessViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseySuccessView.New())

	return views
end

return OdysseySuccessViewContainer
