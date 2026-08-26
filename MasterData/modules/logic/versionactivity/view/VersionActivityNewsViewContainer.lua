-- chunkname: @modules/logic/versionactivity/view/VersionActivityNewsViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityNewsViewContainer", package.seeall)

local VersionActivityNewsViewContainer = class("VersionActivityNewsViewContainer", BaseViewContainer)

function VersionActivityNewsViewContainer:buildViews()
	return {
		VersionActivityNewsView.New()
	}
end

function VersionActivityNewsViewContainer:buildTabViews(tabContainerId)
	return
end

return VersionActivityNewsViewContainer
