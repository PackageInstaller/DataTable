-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepWaitGameStart.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepWaitGameStart", package.seeall)

local XugoujiGameStepWaitGameStart = class("XugoujiGameStepWaitGameStart", XugoujiGameStepBase)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji

function XugoujiGameStepWaitGameStart:start()
	XugoujiController.instance:registerCallback(XugoujiEvent.OpenGameViewFinish, self.onOpenGameViewFinish, self)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.UnOperatable)
end

function XugoujiGameStepWaitGameStart:onOpenGameViewFinish()
	XugoujiController.instance:unregisterCallback(XugoujiEvent.OpenGameViewFinish, self.onOpenGameViewFinish, self)
	self:_showGameTargetTips()
end

function XugoujiGameStepWaitGameStart:_showGameTargetTips()
	local targetWaitTimeConstId = 5
	local targetShowTimeConstId = 4
	local targetWaitTime = tonumber(Activity188Config.instance:getConstCfg(actId, targetWaitTimeConstId).value2)
	local targetShowTime = tonumber(Activity188Config.instance:getConstCfg(actId, targetShowTimeConstId).value2)
	local isDoingXugoujiGuide = Activity188Model.instance:isGameGuideMode()

	if not isDoingXugoujiGuide then
		TaskDispatcher.runDelay(self._autoCloseTargetTips, self, targetShowTime)
		TaskDispatcher.runDelay(self._showSkillTips, self, targetWaitTime)
	elseif Activity188Model.instance:getCurEpisodeId() ~= XugoujiEnum.FirstEpisodeId then
		TaskDispatcher.runDelay(self._autoCloseTargetTips, self, targetShowTime)
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoShowTargetTips)
	XugoujiController.instance:registerCallback(XugoujiEvent.HideTargetTips, self._showTargetTipsDone, self)
end

function XugoujiGameStepWaitGameStart:_autoCloseTargetTips()
	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoHideTargetTips)
end

function XugoujiGameStepWaitGameStart:_showTargetTipsDone()
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideTargetTips, self._showTargetTipsDone, self)

	if self._showingSkill then
		return
	else
		TaskDispatcher.cancelTask(self._autoCloseTargetTips, self)
		TaskDispatcher.cancelTask(self._showSkillTips, self)
		self:_showSkillTips()
	end
end

function XugoujiGameStepWaitGameStart:_showSkillTips()
	self._showingSkill = true

	local skillShowTimeConstId = 6
	local skillShowWaitTimeConstId = 7
	local skillShowTime = tonumber(Activity188Config.instance:getConstCfg(actId, skillShowTimeConstId).value2)
	local skillShowWaitTime = tonumber(Activity188Config.instance:getConstCfg(actId, skillShowWaitTimeConstId).value2)
	local isDoingXugoujiGuide = Activity188Model.instance:isGameGuideMode()

	if not isDoingXugoujiGuide then
		TaskDispatcher.runDelay(self.finish, self, skillShowWaitTime)
		TaskDispatcher.runDelay(self._autoCloseSkillTips, self, skillShowTime)
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoShowSkillTips)
	XugoujiController.instance:registerCallback(XugoujiEvent.HideSkillTips, self._showSkillTipsDone, self)
end

function XugoujiGameStepWaitGameStart:_autoCloseSkillTips()
	self.autoSkillTipsClosed = true

	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoHideSkillTips)
end

function XugoujiGameStepWaitGameStart:_showSkillTipsDone()
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideSkillTips, self._showSkillTipsDone, self)

	if self._finish then
		return
	else
		TaskDispatcher.cancelTask(self.finish, self)
		TaskDispatcher.cancelTask(self._autoCloseSkillTips, self)
		self:finish()
	end
end

function XugoujiGameStepWaitGameStart:finish()
	self._finish = true

	if not self.autoSkillTipsClosed then
		XugoujiController.instance:unregisterCallback(XugoujiEvent.HideSkillTips, self._showSkillTipsDone, self)
		TaskDispatcher.cancelTask(self._autoCloseSkillTips, self)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoHideSkillTips)
	end

	XugoujiGameStepBase.finish(self)
end

function XugoujiGameStepWaitGameStart:dispose()
	XugoujiController.instance:unregisterCallback(XugoujiEvent.OpenGameViewFinish, self.onOpenGameViewFinish, self)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideSkillTips, self._showSkillTipsDone, self)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideTargetTips, self._showTargetTipsDone, self)
	TaskDispatcher.cancelTask(self._autoCloseTargetTips, self)
	TaskDispatcher.cancelTask(self._showSkillTips, self)
	TaskDispatcher.cancelTask(self.finish, self)
	TaskDispatcher.cancelTask(self._autoCloseSkillTips, self)
	XugoujiGameStepBase.dispose(self)
end

return XugoujiGameStepWaitGameStart
