-- chunkname: @modules/logic/versionactivity/view/VersionActivityTipsViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityTipsViewContainer", package.seeall)

local VersionActivityTipsViewContainer = class("VersionActivityTipsViewContainer", BaseViewContainer)

function VersionActivityTipsViewContainer:buildViews()
	return {
		VersionActivityTipsView.New()
	}
end

function VersionActivityTipsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return VersionActivityTipsViewContainer
