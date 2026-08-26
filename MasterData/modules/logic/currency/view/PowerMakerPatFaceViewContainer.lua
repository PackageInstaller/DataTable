-- chunkname: @modules/logic/currency/view/PowerMakerPatFaceViewContainer.lua

module("modules.logic.currency.view.PowerMakerPatFaceViewContainer", package.seeall)

local PowerMakerPatFaceViewContainer = class("PowerMakerPatFaceViewContainer", BaseViewContainer)

function PowerMakerPatFaceViewContainer:buildViews()
	local views = {}

	table.insert(views, PowerMakerPatFaceView.New())

	return views
end

return PowerMakerPatFaceViewContainer
