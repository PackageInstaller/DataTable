-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateMapAudioView.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapAudioView", package.seeall)

local EliminateMapAudioView = class("EliminateMapAudioView", BaseView)

function EliminateMapAudioView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateMapAudioView:addEvents()
	return
end

function EliminateMapAudioView:removeEvents()
	return
end

function EliminateMapAudioView:_editableInitView()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.OnSelectChapterChange, self.onSelectChapterChange, self)
end

function EliminateMapAudioView:_onCloseView(viewName)
	return
end

function EliminateMapAudioView:_onOpenView(viewName)
	return
end

function EliminateMapAudioView:onOpen()
	self:playAmbientAudio()
end

function EliminateMapAudioView:playAmbientAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

function EliminateMapAudioView:onSelectChapterChange()
	self:playAmbientAudio()
end

function EliminateMapAudioView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

return EliminateMapAudioView
