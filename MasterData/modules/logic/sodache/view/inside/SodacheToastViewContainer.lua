-- chunkname: @modules/logic/sodache/view/inside/SodacheToastViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheToastViewContainer", package.seeall)

local SodacheToastViewContainer = class("SodacheToastViewContainer", BaseViewContainer)

function SodacheToastViewContainer:buildViews()
	return {
		SodacheToastView.New()
	}
end

return SodacheToastViewContainer
