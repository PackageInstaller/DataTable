-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8BossStoryLoadingView.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStoryLoadingView", package.seeall)

local VersionActivity2_8BossStoryLoadingView = class("VersionActivity2_8BossStoryLoadingView", BaseView)

function VersionActivity2_8BossStoryLoadingView:onInitView()
	self._gosnow = gohelper.findChild(self.viewGO, "#go_snow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_8BossStoryLoadingView:addEvents()
	return
end

function VersionActivity2_8BossStoryLoadingView:removeEvents()
	return
end

function VersionActivity2_8BossStoryLoadingView:_editableInitView()
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.CanCloseLoading, self._onCanCloseLoading, self)
end

function VersionActivity2_8BossStoryLoadingView:_onCanCloseLoading()
	self._canClose = true

	self:_checkClose()
end

function VersionActivity2_8BossStoryLoadingView:onUpdateParam()
	return
end

function VersionActivity2_8BossStoryLoadingView:onOpen()
	self:_showSnowEffect()
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.runDelay(self.closeThis, self, 10)
end

function VersionActivity2_8BossStoryLoadingView:_showSnowEffect()
	if not self._snowGo then
		local path = self.viewContainer._viewSetting.otherRes[1]

		self._snowGo = self:getResInst(path, self._gosnow)
	end

	gohelper.setActive(self._gosnow, true)

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self._snowGo)

	self._animatorPlayer:Play("start", self._onStartDone, self)
	AudioMgr.instance:trigger(AudioEnum2_8.BossStory.play_ui_fuleyuan_boss_snow)
end

function VersionActivity2_8BossStoryLoadingView:_onStartDone()
	self._startAnimDone = true

	self:_checkClose()
end

function VersionActivity2_8BossStoryLoadingView:_checkClose()
	if self._canClose and self._startAnimDone then
		TaskDispatcher.cancelTask(self.closeThis, self)
		TaskDispatcher.runDelay(self.closeThis, self, 1)
		self._animatorPlayer:Play("end", self._onEndDone, self)
	end
end

function VersionActivity2_8BossStoryLoadingView:_onEndDone()
	self:closeThis()
end

function VersionActivity2_8BossStoryLoadingView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function VersionActivity2_8BossStoryLoadingView:onDestroyView()
	return
end

return VersionActivity2_8BossStoryLoadingView
