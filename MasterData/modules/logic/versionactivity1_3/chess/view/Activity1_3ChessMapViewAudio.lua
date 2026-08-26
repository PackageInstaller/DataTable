-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessMapViewAudio.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapViewAudio", package.seeall)

local Activity1_3ChessMapViewAudio = class("Activity1_3ChessMapViewAudio", BaseView)

function Activity1_3ChessMapViewAudio:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity1_3ChessMapViewAudio:_editableInitView()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseGameView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenGameView, self)
end

function Activity1_3ChessMapViewAudio:_onCloseGameView(viewName)
	if (viewName == ViewName.Activity1_3ChessGameView or viewName == ViewName.StoryFrontView) and self:_canPlayAmbient() then
		self:playAmbientAudio()
	end
end

function Activity1_3ChessMapViewAudio:_onOpenGameView(viewName)
	if viewName == ViewName.Activity1_3ChessGameView or viewName == ViewName.StoryFrontView then
		AudioMgr.instance:trigger(AudioEnum.Story.Stop_Plot_noise)
	end
end

function Activity1_3ChessMapViewAudio:onOpen()
	self:playEnterAudio()
	self:playAmbientAudio()
end

function Activity1_3ChessMapViewAudio:playEnterAudio()
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.EnterChessMap)
end

function Activity1_3ChessMapViewAudio:playAmbientAudio()
	self:closeAmbientSound()

	self._ambientAudioId = AudioMgr.instance:trigger(AudioEnum.Bgm.Activity1_3ChessMapViewAmbientBgm)
end

function Activity1_3ChessMapViewAudio:closeAmbientSound()
	if self._ambientAudioId then
		AudioMgr.instance:stopPlayingID(self._ambientAudioId)

		self._ambientAudioId = nil
	end
end

function Activity1_3ChessMapViewAudio:onClose()
	self:closeAmbientSound()
end

function Activity1_3ChessMapViewAudio:_canPlayAmbient()
	if ViewMgr.instance:isOpen(ViewName.Activity1_3ChessGameView) or ViewMgr.instance:isOpen(ViewName.StoryFrontView) then
		return false
	end

	return true
end

return Activity1_3ChessMapViewAudio
