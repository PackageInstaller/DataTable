-- chunkname: @modules/logic/versionactivity1_3/buff/view/VersionActivity1_3FairyLandViewContainer.lua

module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3FairyLandViewContainer", package.seeall)

local VersionActivity1_3FairyLandViewContainer = class("VersionActivity1_3FairyLandViewContainer", BaseViewContainer)

function VersionActivity1_3FairyLandViewContainer:buildViews()
	self.buffView = VersionActivity1_3FairyLandView.New()

	return {
		self.buffView
	}
end

return VersionActivity1_3FairyLandViewContainer
