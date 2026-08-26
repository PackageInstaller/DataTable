-- chunkname: @modules/logic/versionactivity/view/VersionActivityDungeonAudioView.lua

module("modules.logic.versionactivity.view.VersionActivityDungeonAudioView", package.seeall)

local VersionActivityDungeonAudioView = class("VersionActivityDungeonAudioView", BaseView)

function VersionActivityDungeonAudioView:onInitView()
	return
end

function VersionActivityDungeonAudioView:addEvents()
	return
end

function VersionActivityDungeonAudioView:removeEvents()
	return
end

function VersionActivityDungeonAudioView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivityDungeonAudioView:_onOpenView(viewName)
	if viewName == ViewName.StoryView then
		-- block empty
	end
end

function VersionActivityDungeonAudioView:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		-- block empty
	end
end

function VersionActivityDungeonAudioView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
end

function VersionActivityDungeonAudioView:onDestroyView()
	return
end

return VersionActivityDungeonAudioView
