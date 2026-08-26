-- chunkname: @modules/logic/video/controller/VideoController.lua

module("modules.logic.video.controller.VideoController", package.seeall)

local VideoController = class("VideoController", BaseController)

function VideoController:openFullScreenVideoView(videoPath, videoAudio, videoDuration, doneCb, doneCbObj, params)
	ViewMgr.instance:openView(ViewName.FullScreenVideoView, {
		videoPath = videoPath,
		videoAudio = videoAudio,
		videoDuration = videoDuration,
		doneCb = doneCb,
		doneCbObj = doneCbObj,
		waitViewOpen = params and params.waitViewOpen,
		noShowBlackBg = params and params.noShowBlackBg,
		getVideoPlayer = params and params.getVideoPlayer,
		setVideoPlayer = params and params.setVideoPlayer,
		couldSkip = params and params.couldSkip
	})
end

VideoController.instance = VideoController.New()

LuaEventSystem.addEventMechanism(VideoController.instance)

return VideoController
