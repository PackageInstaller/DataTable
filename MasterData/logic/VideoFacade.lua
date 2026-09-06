-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/video/facade/VideoFacade.lua

module("logic.extensions.video.facade.VideoFacade", package.seeall)

local VideoFacade = class("VideoFacade", BaseFacade)

function VideoFacade:play(movie, looping, aspectRatio, startHandler, finishHandler, target)
	VideoController.instance:play(movie, looping, aspectRatio, startHandler, finishHandler, target)
end

function VideoFacade:getCurrPlayingVideo()
	return VideoController.instance:getCurrPlayingVideo()
end

function VideoFacade:stopVideo(videoName)
	VideoController.instance:stopVideo(videoName)
end

function VideoFacade:stop()
	VideoController.instance:stop()
end

function VideoFacade:setVideoVolume(volume)
	VideoController.instance:setVideoVolume(volume)
end

function VideoFacade:setVideoVolumeRate(rate)
	VideoController.instance:setVideoVolumeRate(rate)
end

VideoFacade.instance = VideoFacade.New()

return VideoFacade
