-- chunkname: @modules/logic/story/view/StoryBackgroundVideoComp.lua

module("modules.logic.story.view.StoryBackgroundVideoComp", package.seeall)

local StoryBackgroundVideoComp = class("StoryBackgroundVideoComp", StoryCompBase)

function StoryBackgroundVideoComp:onInit()
	return
end

function StoryBackgroundVideoComp:playVideo(config)
	if not config then
		return
	end

	self:setVisible(true)

	local videoName = config.bgImg

	self._videoItem = self._videoItem or StoryActivityVideoItem.New(self.compGO)

	local videoCo = {
		loop = true
	}

	self._videoItem:playVideo(videoName, videoCo)
end

function StoryBackgroundVideoComp:setVisible(visible)
	if self._visible == visible then
		return
	end

	self._visible = visible

	gohelper.setActive(self.compGO, visible)

	if not visible and self._videoItem then
		self._videoItem:hide()
	end
end

function StoryBackgroundVideoComp:onDestroy()
	if self._videoItem then
		self._videoItem:onDestroy()

		self._videoItem = nil
	end
end

return StoryBackgroundVideoComp
