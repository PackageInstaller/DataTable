-- chunkname: @modules/logic/sodache/view/inside/SodacheEscapeViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheEscapeViewContainer", package.seeall)

local SodacheEscapeViewContainer = class("SodacheEscapeViewContainer", BaseViewContainer)

function SodacheEscapeViewContainer:buildViews()
	return {
		SodacheEscapeView.New()
	}
end

return SodacheEscapeViewContainer
