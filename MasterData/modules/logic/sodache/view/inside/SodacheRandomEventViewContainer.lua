-- chunkname: @modules/logic/sodache/view/inside/SodacheRandomEventViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheRandomEventViewContainer", package.seeall)

local SodacheRandomEventViewContainer = class("SodacheRandomEventViewContainer", BaseViewContainer)

function SodacheRandomEventViewContainer:buildViews()
	return {
		SodacheRandomEventView.New()
	}
end

return SodacheRandomEventViewContainer
