-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoResultViewContainer.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoResultViewContainer", package.seeall)

local FeiLinShiDuoResultViewContainer = class("FeiLinShiDuoResultViewContainer", BaseViewContainer)

function FeiLinShiDuoResultViewContainer:buildViews()
	local views = {}

	table.insert(views, FeiLinShiDuoResultView.New())

	return views
end

return FeiLinShiDuoResultViewContainer
