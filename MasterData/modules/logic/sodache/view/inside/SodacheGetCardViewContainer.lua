-- chunkname: @modules/logic/sodache/view/inside/SodacheGetCardViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheGetCardViewContainer", package.seeall)

local SodacheGetCardViewContainer = class("SodacheGetCardViewContainer", BaseViewContainer)

function SodacheGetCardViewContainer:buildViews()
	return {
		SodacheGetCardView.New()
	}
end

return SodacheGetCardViewContainer
