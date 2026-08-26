-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3DungeonAudioView.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonAudioView", package.seeall)

local VersionActivity1_3DungeonAudioView = class("VersionActivity1_3DungeonAudioView", BaseView)

function VersionActivity1_3DungeonAudioView:onInitView()
	return
end

function VersionActivity1_3DungeonAudioView:addEvents()
	return
end

function VersionActivity1_3DungeonAudioView:removeEvents()
	return
end

function VersionActivity1_3DungeonAudioView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity1_3DungeonAudioView:_onOpenView(viewName)
	if viewName == ViewName.StoryView then
		-- block empty
	end
end

function VersionActivity1_3DungeonAudioView:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		-- block empty
	end
end

function VersionActivity1_3DungeonAudioView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
end

function VersionActivity1_3DungeonAudioView:onDestroyView()
	return
end

return VersionActivity1_3DungeonAudioView
