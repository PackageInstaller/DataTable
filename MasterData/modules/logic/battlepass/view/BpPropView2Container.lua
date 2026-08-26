-- chunkname: @modules/logic/battlepass/view/BpPropView2Container.lua

module("modules.logic.battlepass.view.BpPropView2Container", package.seeall)

local BpPropView2Container = class("BpPropView2Container", BaseViewContainer)

function BpPropView2Container:buildViews()
	return {
		BpPropView2.New()
	}
end

return BpPropView2Container
