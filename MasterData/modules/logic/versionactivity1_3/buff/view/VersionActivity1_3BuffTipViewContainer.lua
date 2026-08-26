-- chunkname: @modules/logic/versionactivity1_3/buff/view/VersionActivity1_3BuffTipViewContainer.lua

module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffTipViewContainer", package.seeall)

local VersionActivity1_3BuffTipViewContainer = class("VersionActivity1_3BuffTipViewContainer", BaseViewContainer)

function VersionActivity1_3BuffTipViewContainer:buildViews()
	self.buffTipView = VersionActivity1_3BuffTipView.New()

	return {
		self.buffTipView
	}
end

return VersionActivity1_3BuffTipViewContainer
