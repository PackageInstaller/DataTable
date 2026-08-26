-- chunkname: @modules/logic/versionactivity1_5/act146/view/VersionActivity1_5WarmUpViewContainer.lua

module("modules.logic.versionactivity1_5.act146.view.VersionActivity1_5WarmUpViewContainer", package.seeall)

local VersionActivity1_5WarmUpViewContainer = class("VersionActivity1_5WarmUpViewContainer", BaseViewContainer)

function VersionActivity1_5WarmUpViewContainer:buildViews()
	return {
		VersionActivity1_5WarmUpView.New(),
		VersionActivity1_5WarmUpInteract.New()
	}
end

return VersionActivity1_5WarmUpViewContainer
