-- chunkname: @modules/logic/versionactivity3_9/bird/view/load/V3a9BirdLoadingView.lua

module("modules.logic.versionactivity3_9.bird.view.load.V3a9BirdLoadingView", package.seeall)

local V3a9BirdLoadingView = class("V3a9BirdLoadingView", BaseView)

function V3a9BirdLoadingView:onInitView()
	self._gofull = gohelper.findChild(self.viewGO, "#go_full")
	self._imagelogo1 = gohelper.findChildImage(self.viewGO, "#go_full/3/#image_logo_1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9BirdLoadingView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
end

function V3a9BirdLoadingView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function V3a9BirdLoadingView:_editableInitView()
	return
end

function V3a9BirdLoadingView:_onOpenViewFinish(viewName)
	if viewName == ViewName.V3a9BirdGameView then
		local deltaTime = self._openAnimLength - (Time.time - self._openTime)

		if deltaTime > 0 then
			TaskDispatcher.runDelay(self._playCloseAnim, self, deltaTime)
		else
			self:_playCloseAnim()
		end
	end
end

function V3a9BirdLoadingView:_playCloseAnim()
	self._animatorPlayer:Play("gameclose", self._animDone, self)
	AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_beiai_water_absorb)
end

function V3a9BirdLoadingView:_animDone()
	self:closeThis()
end

function V3a9BirdLoadingView:onOpen()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._openTime = Time.time
	self._openAnimLength = 1.4

	self._animatorPlayer:Play("gameopen", self._openAnimDone, self)
	AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_beiai_wave_appear)
	V3a9BirdController.instance:enterGame(self.viewParam.episodeId)
end

function V3a9BirdLoadingView:_openAnimDone()
	AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_bulaochuan_floor_shiny)
end

function V3a9BirdLoadingView:onClose()
	V3a9BirdController.instance:dispatchEvent(V3a9BirdEvent.CloseFinishLoadingView)
	TaskDispatcher.cancelTask(self._playCloseAnim, self)
end

function V3a9BirdLoadingView:onDestroyView()
	return
end

return V3a9BirdLoadingView
