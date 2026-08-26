-- chunkname: @modules/logic/sodache/view/inside/SodacheCardToastViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheCardToastViewContainer", package.seeall)

local SodacheCardToastViewContainer = class("SodacheCardToastViewContainer", BaseViewContainer)

function SodacheCardToastViewContainer:buildViews()
	return {
		SodacheCardToastView.New()
	}
end

return SodacheCardToastViewContainer
