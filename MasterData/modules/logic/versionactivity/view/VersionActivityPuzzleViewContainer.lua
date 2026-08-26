-- chunkname: @modules/logic/versionactivity/view/VersionActivityPuzzleViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityPuzzleViewContainer", package.seeall)

local VersionActivityPuzzleViewContainer = class("VersionActivityPuzzleViewContainer", BaseViewContainer)

function VersionActivityPuzzleViewContainer:buildViews()
	return {
		VersionActivityPuzzleView.New()
	}
end

function VersionActivityPuzzleViewContainer:buildTabViews(tabContainerId)
	return
end

return VersionActivityPuzzleViewContainer
