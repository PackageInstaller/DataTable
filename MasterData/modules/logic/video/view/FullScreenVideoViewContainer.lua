-- chunkname: @modules/logic/video/view/FullScreenVideoViewContainer.lua

module("modules.logic.video.view.FullScreenVideoViewContainer", package.seeall)

local FullScreenVideoViewContainer = class("FullScreenVideoViewContainer", BaseViewContainer)

function FullScreenVideoViewContainer:buildViews()
	return {
		FullScreenVideoView.New()
	}
end

return FullScreenVideoViewContainer
