-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaResultViewContainer.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaResultViewContainer", package.seeall)

local TianShiNaNaResultViewContainer = class("TianShiNaNaResultViewContainer", BaseViewContainer)

function TianShiNaNaResultViewContainer:buildViews()
	return {
		TianShiNaNaResultView.New()
	}
end

return TianShiNaNaResultViewContainer
