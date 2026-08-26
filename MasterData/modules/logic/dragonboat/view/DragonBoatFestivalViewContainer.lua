-- chunkname: @modules/logic/dragonboat/view/DragonBoatFestivalViewContainer.lua

module("modules.logic.dragonboat.view.DragonBoatFestivalViewContainer", package.seeall)

local DragonBoatFestivalViewContainer = class("DragonBoatFestivalViewContainer", BaseViewContainer)

function DragonBoatFestivalViewContainer:buildViews()
	return {
		DragonBoatFestivalView.New()
	}
end

return DragonBoatFestivalViewContainer
