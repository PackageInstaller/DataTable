-- chunkname: @modules/logic/necrologiststory/game/v3a4/V3A4_RoleStoryAudioView.lua

module("modules.logic.necrologiststory.game.v3a4.V3A4_RoleStoryAudioView", package.seeall)

local V3A4_RoleStoryAudioView = class("V3A4_RoleStoryAudioView", BaseView)

function V3A4_RoleStoryAudioView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A4_RoleStoryAudioView:addEvents()
	return
end

function V3A4_RoleStoryAudioView:removeEvents()
	return
end

function V3A4_RoleStoryAudioView:_editableInitView()
	return
end

function V3A4_RoleStoryAudioView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gt_yishi_jiemian)
	self:refreshParam()
end

function V3A4_RoleStoryAudioView:onOpenFinish()
	self:playAudio()
end

function V3A4_RoleStoryAudioView:refreshParam()
	self.audioId = self.viewParam.audioId
	self.time = self.viewParam.audioTime or 0
end

function V3A4_RoleStoryAudioView:playAudio()
	self:stopAudio()

	if self.audioId > 0 then
		self.playingId = AudioMgr.instance:trigger(self.audioId)
	end

	TaskDispatcher.runDelay(self.onPlayFinish, self, self.time)
end

function V3A4_RoleStoryAudioView:stopAudio()
	if self.playingId then
		AudioMgr.instance:stopPlayingID(self.playingId)

		self.playingId = nil
	end
end

function V3A4_RoleStoryAudioView:onPlayFinish()
	self:closeThis()
end

function V3A4_RoleStoryAudioView:onDestroyView()
	TaskDispatcher.cancelTask(self.onPlayFinish, self)
	self:stopAudio()
end

return V3A4_RoleStoryAudioView
