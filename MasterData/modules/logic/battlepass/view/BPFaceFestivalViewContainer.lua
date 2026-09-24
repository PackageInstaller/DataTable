-- chunkname: @modules/logic/battlepass/view/BPFaceFestivalViewContainer.lua

module("modules.logic.battlepass.view.BPFaceFestivalViewContainer", package.seeall)

local BPFaceFestivalViewContainer = class("BPFaceFestivalViewContainer", BaseViewContainer)

function BPFaceFestivalViewContainer:buildViews()
	return {
		BPFaceFestivalView2.New()
	}
end

return BPFaceFestivalViewContainer
