-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneTimeAnimComp.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneTimeAnimComp", package.seeall)

local UdimoSceneTimeAnimComp = class("UdimoSceneTimeAnimComp", BaseSceneComp)

function UdimoSceneTimeAnimComp:onInit()
	return
end

function UdimoSceneTimeAnimComp:onSceneStart(sceneId, levelId)
	return
end

function UdimoSceneTimeAnimComp:init(sceneId, levelId)
	self:initTimeAnimator()
	self:addEventListeners()
	TaskDispatcher.cancelTask(self.everySecondCall, self)

	if self._animator then
		TaskDispatcher.runRepeat(self.everySecondCall, self, TimeUtil.OneSecond)
	end
end

function UdimoSceneTimeAnimComp:onScenePrepared(sceneId, levelId)
	return
end

function UdimoSceneTimeAnimComp:initTimeAnimator()
	local scene = self:getCurScene()
	local sceneObj = scene.level:getSceneGo()

	self._animator = sceneObj:GetComponent(typeof(UnityEngine.Animator))

	if self._animator then
		self._animator.speed = 0
		self._animator.enabled = true

		self:refreshTimeProgress()
	end
end

function UdimoSceneTimeAnimComp:everySecondCall()
	self:refreshTimeProgress()
end

function UdimoSceneTimeAnimComp:addEventListeners()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, self._onCloseFullView, self)
end

function UdimoSceneTimeAnimComp:removeEventListeners()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, self._onCloseFullView, self)
end

function UdimoSceneTimeAnimComp:_onCloseFullView(viewName)
	self:refreshTimeProgress()
end

local TIME_ANIM_NAME = "v3a2_m_s19_ytm_time"

function UdimoSceneTimeAnimComp:refreshTimeProgress()
	if not self._animator then
		return
	end

	local nowDate = ServerTime.nowDateInLocal()
	local todayZero = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = nowDate.year,
		month = nowDate.month,
		day = nowDate.day
	})
	local now = ServerTime.nowInLocal()
	local secondPassed = now - todayZero
	local progress = secondPassed / TimeUtil.OneDaySecond

	progress = GameUtil.clamp(progress, 0, 1)

	self._animator:Play(TIME_ANIM_NAME, 0, progress)
end

function UdimoSceneTimeAnimComp:onSceneClose()
	self:removeEventListeners()
	TaskDispatcher.cancelTask(self.everySecondCall, self)

	self._animator = nil
end

return UdimoSceneTimeAnimComp
