-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_FacilityTipsViewContainer.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_FacilityTipsViewContainer", package.seeall)

local VersionActivity_1_2_FacilityTipsViewContainer = class("VersionActivity_1_2_FacilityTipsViewContainer", BaseViewContainer)

function VersionActivity_1_2_FacilityTipsViewContainer:buildViews()
	return {
		VersionActivity_1_2_FacilityTipsView.New()
	}
end

return VersionActivity_1_2_FacilityTipsViewContainer
