-- chunkname: @modules/logic/video/define/VideoEvent.lua

module("modules.logic.video.define.VideoEvent", package.seeall)

local VideoEvent = _M

VideoEvent.OnVideoPlayFinished = 1
VideoEvent.OnVideoPlayOverTime = 2
VideoEvent.OnVideoStarted = 3
VideoEvent.OnVideoFirstFrameReady = 4

return VideoEvent
