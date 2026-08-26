-- chunkname: @modules/logic/login/controller/work/LoginEnterMainSceneWork.lua

module("modules.logic.login.controller.work.LoginEnterMainSceneWork", package.seeall)

local LoginEnterMainSceneWork = class("LoginEnterMainSceneWork", BaseWork)

function LoginEnterMainSceneWork:ctor()
	return
end

function LoginEnterMainSceneWork:onStart(context)
	local cameraGo = CameraMgr.instance:getCameraRootGO()

	transformhelper.setLocalPos(cameraGo.transform, 0, 0, 0)

	local voiceType = GameConfig:GetCurVoiceShortcut()

	if LangSettings.instance:isOverseas() == false then
		local forceNeedKrJpActivityId = tonumber(CommonConfig.instance:getConstStr(ConstEnum.ForceNeedKrJpActivityId))
		local needKrJp = forceNeedKrJpActivityId == 1

		if not needKrJp and (voiceType == LangSettings.shortcutTab[LangSettings.jp] or voiceType == LangSettings.shortcutTab[LangSettings.kr]) then
			local roleList = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.S01SpRole), "#")
			local hasRole = false

			for _, heroId in ipairs(roleList) do
				if HeroModel.instance:getByHeroId(heroId) then
					hasRole = true

					break
				end
			end

			if hasRole == false then
				SettingsVoicePackageController.instance:switchVoiceType(LangSettings.en, "", true)
			end
		end
	end

	MainController.instance:enterMainScene()
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._enterSceneFinish, self)
	TaskDispatcher.runDelay(self._delayDone, self, 20)
end

function LoginEnterMainSceneWork:_enterSceneFinish(sceneType, sceneId)
	if sceneType == SceneType.Main then
		if ViewMgr.instance:isOpen(ViewName.LoadingView) then
			local settingsMO = SettingsModel.instance.limitedRoleMO

			if LimitedRoleController.instance:getNeedPlayLimitedCO() and settingsMO:isAuto() then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.SetManualClose)
				self:onDone(true)
			else
				ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
			end
		else
			self:onDone(true)
		end
	end
end

function LoginEnterMainSceneWork:_onCloseViewFinish(viewName)
	if viewName == ViewName.LoadingView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:onDone(true)
	end
end

function LoginEnterMainSceneWork:_delayDone()
	logError("登录流程，进入主场景超时了！")
	TimeDispatcher.instance:startTick()
	LoginController.instance:dispatchEvent(LoginEvent.OnLoginEnterMainScene)

	LoginController.instance.enteredGame = true

	self:onDone(false)
end

function LoginEnterMainSceneWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._enterSceneFinish, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return LoginEnterMainSceneWork
