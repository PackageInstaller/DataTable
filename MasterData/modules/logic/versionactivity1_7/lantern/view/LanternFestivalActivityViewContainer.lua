-- chunkname: @modules/logic/versionactivity1_7/lantern/view/LanternFestivalActivityViewContainer.lua

module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalActivityViewContainer", package.seeall)

local LanternFestivalActivityViewContainer = class("LanternFestivalActivityViewContainer", BaseViewContainer)

function LanternFestivalActivityViewContainer:buildViews()
	return {
		LanternFestivalActivityView.New()
	}
end

return LanternFestivalActivityViewContainer
