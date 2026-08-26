-- chunkname: @modules/logic/versionactivity1_6/enter/view/VersionActivity1_6EnterVideoViewContainer.lua

module("modules.logic.versionactivity1_6.enter.view.VersionActivity1_6EnterVideoViewContainer", package.seeall)

local VersionActivity1_6EnterVideoViewContainer = class("VersionActivity1_6EnterVideoViewContainer", BaseViewContainer)

function VersionActivity1_6EnterVideoViewContainer:buildViews()
	return {
		VersionActivity1_6EnterVideoView.New()
	}
end

return VersionActivity1_6EnterVideoViewContainer
