-- chunkname: @modules/logic/versionactivity/view/VersionActivityExchangeTaskViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityExchangeTaskViewContainer", package.seeall)

local VersionActivityExchangeTaskViewContainer = class("VersionActivityExchangeTaskViewContainer", BaseViewContainer)

function VersionActivityExchangeTaskViewContainer:buildViews()
	return {
		VersionActivityExchangeTaskView.New()
	}
end

return VersionActivityExchangeTaskViewContainer
