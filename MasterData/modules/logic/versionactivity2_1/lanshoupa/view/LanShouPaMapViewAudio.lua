-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaMapViewAudio.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapViewAudio", package.seeall)

local LanShouPaMapViewAudio = class("LanShouPaMapViewAudio", BaseView)

function LanShouPaMapViewAudio:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanShouPaMapViewAudio:_editableInitView()
	return
end

function LanShouPaMapViewAudio:_onCloseGameView(viewName)
	if (viewName == ViewName.LanShouPaGameView or viewName == ViewName.StoryFrontView) and self:_isCanPlayAmbient() then
		self:playAmbientAudio()
	end
end

function LanShouPaMapViewAudio:_isCanPlayAmbient()
	if ViewMgr.instance:isOpen(ViewName.LanShouPaGameView) or ViewMgr.instance:isOpen(ViewName.StoryFrontView) then
		return false
	end

	return true
end

function LanShouPaMapViewAudio:_onOpenGameView(viewName)
	if viewName ~= ViewName.LanShouPaGameView and viewName == ViewName.StoryFrontView then
		-- block empty
	end
end

function LanShouPaMapViewAudio:onOpen()
	self:playAmbientAudio()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseGameView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenGameView, self)
end

function LanShouPaMapViewAudio:playAmbientAudio()
	return
end

function LanShouPaMapViewAudio:closeAmbientSound()
	if self._ambientAudioId then
		AudioMgr.instance:stopPlayingID(self._ambientAudioId)

		self._ambientAudioId = nil
	end
end

function LanShouPaMapViewAudio:onClose()
	return
end

return LanShouPaMapViewAudio
