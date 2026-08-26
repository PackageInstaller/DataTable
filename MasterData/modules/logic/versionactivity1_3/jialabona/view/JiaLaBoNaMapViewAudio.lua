-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaMapViewAudio.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapViewAudio", package.seeall)

local JiaLaBoNaMapViewAudio = class("JiaLaBoNaMapViewAudio", BaseView)

function JiaLaBoNaMapViewAudio:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function JiaLaBoNaMapViewAudio:_editableInitView()
	return
end

function JiaLaBoNaMapViewAudio:_onCloseGameView(viewName)
	if (viewName == ViewName.JiaLaBoNaGameView or viewName == ViewName.StoryFrontView) and self:_isCanPlayAmbient() then
		self:playAmbientAudio()
	end
end

function JiaLaBoNaMapViewAudio:_isCanPlayAmbient()
	if ViewMgr.instance:isOpen(ViewName.JiaLaBoNaGameView) or ViewMgr.instance:isOpen(ViewName.StoryFrontView) then
		return false
	end

	return true
end

function JiaLaBoNaMapViewAudio:_onOpenGameView(viewName)
	if viewName == ViewName.JiaLaBoNaGameView or viewName == ViewName.StoryFrontView then
		self:closeAmbientSound()
	end
end

function JiaLaBoNaMapViewAudio:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_ilbn_open)
	self:playAmbientAudio()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseGameView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenGameView, self)
end

function JiaLaBoNaMapViewAudio:playAmbientAudio()
	self:closeAmbientSound()

	self._ambientAudioId = AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_amb_activity_molu1_3_ganapona)
end

function JiaLaBoNaMapViewAudio:closeAmbientSound()
	if self._ambientAudioId then
		AudioMgr.instance:stopPlayingID(self._ambientAudioId)

		self._ambientAudioId = nil
	end
end

function JiaLaBoNaMapViewAudio:onClose()
	self:closeAmbientSound()
end

return JiaLaBoNaMapViewAudio
