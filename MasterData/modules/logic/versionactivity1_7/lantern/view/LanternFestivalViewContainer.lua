-- chunkname: @modules/logic/versionactivity1_7/lantern/view/LanternFestivalViewContainer.lua

module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalViewContainer", package.seeall)

local LanternFestivalViewContainer = class("LanternFestivalViewContainer", BaseViewContainer)

function LanternFestivalViewContainer:buildViews()
	return {
		LanternFestivalView.New()
	}
end

return LanternFestivalViewContainer
