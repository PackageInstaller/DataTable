-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaTalkViewContainer.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaTalkViewContainer", package.seeall)

local TianShiNaNaTalkViewContainer = class("TianShiNaNaTalkViewContainer", BaseViewContainer)

function TianShiNaNaTalkViewContainer:buildViews()
	return {
		TianShiNaNaTalkView.New()
	}
end

return TianShiNaNaTalkViewContainer
