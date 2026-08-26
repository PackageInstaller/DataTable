-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianMapAudioView.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapAudioView", package.seeall)

local YaXianMapAudioView = class("YaXianMapAudioView", BaseView)

function YaXianMapAudioView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianMapAudioView:addEvents()
	return
end

function YaXianMapAudioView:removeEvents()
	return
end

function YaXianMapAudioView:_editableInitView()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, YaXianController.instance, YaXianEvent.OnSelectChapterChange, self.onSelectChapterChange, self)
end

function YaXianMapAudioView:_onCloseView(viewName)
	if viewName == ViewName.YaXianGameView then
		self:playAmbientAudio()
	end
end

function YaXianMapAudioView:_onOpenView(viewName)
	if viewName == ViewName.YaXianGameView then
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end
end

function YaXianMapAudioView:onOpen()
	self:playAmbientAudio()
end

function YaXianMapAudioView:playAmbientAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)

	local chapterCo = YaXianConfig.instance:getChapterConfig(self.viewContainer.chapterId)

	AudioMgr.instance:trigger(chapterCo.ambientAudio)
end

function YaXianMapAudioView:onSelectChapterChange()
	self:playAmbientAudio()
end

function YaXianMapAudioView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

return YaXianMapAudioView
