-- chunkname: @modules/logic/versionactivity1_3/astrology/view/VersionActivity1_3AstrologySuccessViewContainer.lua

module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologySuccessViewContainer", package.seeall)

local VersionActivity1_3AstrologySuccessViewContainer = class("VersionActivity1_3AstrologySuccessViewContainer", BaseViewContainer)

function VersionActivity1_3AstrologySuccessViewContainer:buildViews()
	return {
		VersionActivity1_3AstrologySuccessView.New()
	}
end

return VersionActivity1_3AstrologySuccessViewContainer
