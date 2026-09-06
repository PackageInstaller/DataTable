-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/video/view/VideoPlayingViewPresentor.lua

module("logic.extensions.video.view.VideoPlayingViewPresentor", package.seeall)

local VideoPlayingViewPresentor = class("VideoPlayingViewPresentor", ViewPresentor)

function VideoPlayingViewPresentor:attachToWhichRoot()
	return
end

function VideoPlayingViewPresentor:dependWhatResources()
	return {
		CommonResPath.UIVideoPlaying
	}
end

function VideoPlayingViewPresentor:buildViews()
	return {
		VideoPlayingView.New()
	}
end

return VideoPlayingViewPresentor
