-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/nodes/VideoPlayerNode.lua

module("story", package.seeall)

VideoPlayerNode = class("VideoPlayerNode", StageNode)

register_stage_node("VideoPlayer", VideoPlayerNode)

local actions = {
	play = VideoPlayAction,
	stop = VideoStopAction
}

VideoPlayerNode:extendActionsForClass(actions)

function VideoPlayerNode:createRenderNode(config)
	local path = config.videoPath
	local video = ccexp.VideoPlayer:create()

	video:setFileName(path)
	video:setVisible(false)

	return video
end

function VideoPlayerNode:play(callback)
	local video = self:getRenderNode()

	video:setVisible(true)
	video:play()
	video:addEventListener(function(sender, event)
		if event == 3 then
			callback()

			return
		end
	end)
end

function VideoPlayerNode:stop()
	self:getRenderNode():stop()
end
