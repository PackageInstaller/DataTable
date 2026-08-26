-- chunkname: @modules/logic/sodache/view/inside/SodacheTakeViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheTakeViewContainer", package.seeall)

local SodacheTakeViewContainer = class("SodacheTakeViewContainer", BaseViewContainer)

function SodacheTakeViewContainer:buildViews()
	return {
		SodacheTakeView.New()
	}
end

return SodacheTakeViewContainer
