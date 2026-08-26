-- chunkname: @modules/logic/activity/view/LinkageActivity_Page2Video.lua

module("modules.logic.activity.view.LinkageActivity_Page2Video", package.seeall)

local Base = LinkageActivity_Page2VideoBase
local LinkageActivity_Page2Video = class("LinkageActivity_Page2Video", Base)

function LinkageActivity_Page2Video:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function LinkageActivity_Page2Video:addEvents()
	return
end

function LinkageActivity_Page2Video:removeEvents()
	return
end

function LinkageActivity_Page2Video:ctor(...)
	Base.ctor(self, ...)
end

function LinkageActivity_Page2Video:onDestroyView()
	local mo = self._mo

	if mo and mo.videoAudioStopId then
		AudioMgr.instance:trigger(mo.videoAudioStopId)
	end

	Base.onDestroyView(self)
end

function LinkageActivity_Page2Video:_editableInitView()
	LinkageActivity_Page2Video.super._editableInitView(self)
	self:setIsNeedLoadingCover(false)

	local videoGO = gohelper.findChild(self.viewGO, "Video")

	self:createVideoPlayer(videoGO)
end

function LinkageActivity_Page2Video:onUpdateMO(mo)
	Base.onUpdateMO(self, mo)

	local videoPath = langVideoUrl(mo.videoName)

	self:loadVideo(videoPath)
	self:run()
end

function LinkageActivity_Page2Video:run()
	if not self:_isPlaying() then
		self:play()
	end
end

function LinkageActivity_Page2Video:play()
	local mo = self._mo
	local audioId = mo.videoAudioId

	Base.play(self, audioId, true)
end

function LinkageActivity_Page2Video:stop()
	local mo = self._mo
	local stopAudioId = mo.videoAudioStopId

	Base.stop(self, stopAudioId)
end

function LinkageActivity_Page2Video:setEnabled(isEnable)
	if isEnable then
		self:play()
	else
		self:stop()
	end
end

return LinkageActivity_Page2Video
