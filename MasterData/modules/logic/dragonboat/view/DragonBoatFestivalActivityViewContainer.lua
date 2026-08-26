-- chunkname: @modules/logic/dragonboat/view/DragonBoatFestivalActivityViewContainer.lua

module("modules.logic.dragonboat.view.DragonBoatFestivalActivityViewContainer", package.seeall)

local DragonBoatFestivalActivityViewContainer = class("DragonBoatFestivalActivityViewContainer", BaseViewContainer)

function DragonBoatFestivalActivityViewContainer:buildViews()
	return {
		DragonBoatFestivalActivityView.New()
	}
end

return DragonBoatFestivalActivityViewContainer
