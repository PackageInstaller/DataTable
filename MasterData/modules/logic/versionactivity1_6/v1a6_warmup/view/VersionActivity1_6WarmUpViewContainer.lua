-- chunkname: @modules/logic/versionactivity1_6/v1a6_warmup/view/VersionActivity1_6WarmUpViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_warmup.view.VersionActivity1_6WarmUpViewContainer", package.seeall)

local VersionActivity1_6WarmUpViewContainer = class("VersionActivity1_6WarmUpViewContainer", BaseViewContainer)

function VersionActivity1_6WarmUpViewContainer:buildViews()
	return {
		VersionActivity1_6WarmUpView.New()
	}
end

return VersionActivity1_6WarmUpViewContainer
