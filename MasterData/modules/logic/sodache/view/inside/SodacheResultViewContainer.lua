-- chunkname: @modules/logic/sodache/view/inside/SodacheResultViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheResultViewContainer", package.seeall)

local SodacheResultViewContainer = class("SodacheResultViewContainer", BaseViewContainer)

function SodacheResultViewContainer:buildViews()
	return {
		SodacheResultView.New()
	}
end

return SodacheResultViewContainer
