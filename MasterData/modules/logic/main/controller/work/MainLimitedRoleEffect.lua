-- chunkname: @modules/logic/main/controller/work/MainLimitedRoleEffect.lua

module("modules.logic.main.controller.work.MainLimitedRoleEffect", package.seeall)

local MainLimitedRoleEffect = class("MainLimitedRoleEffect", BaseWork)

function MainLimitedRoleEffect:onStart(context)
	local limitedCO = LimitedRoleController.instance:getNeedPlayLimitedCO()

	if limitedCO then
		local settingsMO = SettingsModel.instance.limitedRoleMO

		if settingsMO:isAuto() then
			if settingsMO:isEveryLogin() or not settingsMO:getTodayHasPlay() then
				SettingsModel.instance.limitedRoleMO:setTodayHasPlay()
				LimitedRoleController.instance:registerCallback(LimitedRoleController.VideoState, self._onVideoState, self)
				LimitedRoleController.instance:play(LimitedRoleEnum.Stage.FirstLogin, limitedCO, self._doneCallback, self)
			else
				GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
				self:onDone(true)
			end
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
			self:onDone(true)
		end
	else
		GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
		self:onDone(true)
	end
end

function MainLimitedRoleEffect:_doneCallback()
	if SDKMgr.instance:isEmulator() then
		PlayerPrefsHelper.save()
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
	self:onDone(true)
end

function MainLimitedRoleEffect:_onVideoState(state)
	if state == VideoEnum.PlayerStatus.Started then
		LimitedRoleController.instance:unregisterCallback(LimitedRoleController.VideoState, self._onVideoState, self)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
	end
end

function MainLimitedRoleEffect:clearWork()
	LimitedRoleController.instance:stop()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
	LimitedRoleController.instance:unregisterCallback(LimitedRoleController.VideoState, self._onVideoState, self)
end

return MainLimitedRoleEffect
