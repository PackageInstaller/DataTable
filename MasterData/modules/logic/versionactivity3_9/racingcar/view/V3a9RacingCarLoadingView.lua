-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarLoadingView.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarLoadingView", package.seeall)

local V3a9RacingCarLoadingView = class("V3a9RacingCarLoadingView", BaseView)

function V3a9RacingCarLoadingView:onInitView()
	self._gofull = gohelper.findChild(self.viewGO, "#go_full")
	self._imagelogo1 = gohelper.findChildImage(self.viewGO, "#go_full/3/#image_logo_1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingCarLoadingView:addEvents()
	return
end

function V3a9RacingCarLoadingView:removeEvents()
	return
end

function V3a9RacingCarLoadingView:_editableInitView()
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.CanCloseLoading, self._onCanCloseLoading, self)
end

function V3a9RacingCarLoadingView:_onCanCloseLoading()
	local deltaTime = self._openAnimLength - (Time.time - self._openTime)

	if deltaTime > 0 then
		TaskDispatcher.runDelay(self._playCloseAnim, self, deltaTime)
	else
		self:_playCloseAnim()
	end
end

function V3a9RacingCarLoadingView:_playCloseAnim()
	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayBeiaiWaterAbsorb)

	if self._sceneType == SceneType.RacingCar then
		self._animatorPlayer:Play("gameclose", self._animDone, self)
	else
		self._animatorPlayer:Play("mainclose", self._animDone, self)
	end
end

function V3a9RacingCarLoadingView:_animDone()
	self:closeThis()
end

function V3a9RacingCarLoadingView:onOpen()
	self._sceneType = self.viewParam
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._openTime = Time.time
	self._openAnimLength = 1.4

	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayBeiaiWaveAppear)

	if self._sceneType == SceneType.RacingCar then
		self._animatorPlayer:Play("gameopen", self._openAnimDone, self)
	else
		self._animatorPlayer:Play("mainopen", self._openAnimDone, self)
	end
end

function V3a9RacingCarLoadingView:_openAnimDone()
	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayBulaochuanFloorShiny)
end

function V3a9RacingCarLoadingView:onClose()
	TaskDispatcher.cancelTask(self._playCloseAnim, self)
end

function V3a9RacingCarLoadingView:onDestroyView()
	return
end

return V3a9RacingCarLoadingView
