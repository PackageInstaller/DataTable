-- chunkname: @modules/logic/sodache/view/inside/SodacheAltarViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheAltarViewContainer", package.seeall)

local SodacheAltarViewContainer = class("SodacheAltarViewContainer", BaseViewContainer)

function SodacheAltarViewContainer:buildViews()
	return {
		SodacheAltarView.New()
	}
end

return SodacheAltarViewContainer
