-- chunkname: @modules/logic/versionactivity/view/VersionActivityVideoViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityVideoViewContainer", package.seeall)

local VersionActivityVideoViewContainer = class("VersionActivityVideoViewContainer", BaseViewContainer)

function VersionActivityVideoViewContainer:buildViews()
	return {
		VersionActivityVideoView.New()
	}
end

function VersionActivityVideoViewContainer:buildTabViews(tabContainerId)
	return
end

return VersionActivityVideoViewContainer
