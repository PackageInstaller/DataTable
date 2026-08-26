-- chunkname: @modules/logic/limited/controller/LimitedRoleController.lua

module("modules.logic.limited.controller.LimitedRoleController", package.seeall)

local LimitedRoleController = class("LimitedRoleController", BaseController)

LimitedRoleController.PlayAction = GameUtil.getEventId()
LimitedRoleController.ManualSkip = GameUtil.getEventId()
LimitedRoleController.VideoState = GameUtil.getEventId()

function LimitedRoleController:onInit()
	self._isPlayingVideo = false
	self._isPlayingAction = false
end

function LimitedRoleController:reInit()
	self._isPlayingVideo = false
	self._isPlayingAction = false

	self.unregisterCallback(self, LimitedRoleController.PlayAction, self._playAction, self)
	self.unregisterCallback(self, LimitedRoleController.ManualSkip, self._manualSkip, self)
	self.unregisterCallback(self, LimitedRoleController.VideoState, self._onVideoState, self)
	TaskDispatcher.cancelTask(self._stopMainBgm, self)
	TaskDispatcher.cancelTask(self._HideMainView, self)
	self:_clearEffect()
	self:_stopVideoAudio()
end

function LimitedRoleController:play(stage, limitedCO, callback, callbackObj, callbackParam)
	if self._isPlayingVideo and isDebugBuild then
		logError("正在播放限定角色入场效果 " .. stage)

		return
	end

	self:_stopVideoAudio()
	self:_stopVoice()
	TaskDispatcher.cancelTask(self._clearActionState, self)

	self._isPlayingVideo = true
	self._stage = stage
	self._limitedCO = limitedCO
	self._callback = callback
	self._callbackObj = callbackObj
	self._callbackParam = callbackParam

	self.registerCallback(self, LimitedRoleController.PlayAction, self._playAction, self)
	self.registerCallback(self, LimitedRoleController.ManualSkip, self._manualSkip, self)
	ViewMgr.instance:openView(ViewName.LimitedRoleView, {
		limitedCO = limitedCO
	})
	self:_stopMainBgm()
	self:_HideMainView()
	AudioBgmManager.instance:registerCallback(AudioBgmEvent.onPlayBgm, self._stopMainBgm, self, LuaEventSystem.Low)
	TaskDispatcher.runDelay(self._HideMainView, self, 2)
	self.registerCallback(self, LimitedRoleController.VideoState, self._onVideoState, self)
end

function LimitedRoleController:_onVideoState(state)
	if state == AvProEnum.PlayerStatus.Started then
		self.unregisterCallback(self, LimitedRoleController.VideoState, self._onVideoState, self)

		if self._limitedCO and self._limitedCO.audio > 0 then
			AudioMgr.instance:trigger(self._limitedCO.audio, nil)
		end
	end
end

function LimitedRoleController:isPlayingVideo()
	return self._isPlayingVideo
end

function LimitedRoleController:isPlayingAction()
	return self._isPlayingAction
end

function LimitedRoleController:isPlaying()
	return self._isPlayingVideo or self._isPlayingAction
end

function LimitedRoleController:stop()
	self._isPlayingVideo = false
	self._callback = nil
	self._callbackObj = nil

	self.unregisterCallback(self, LimitedRoleController.PlayAction, self._playAction, self)
	self.unregisterCallback(self, LimitedRoleController.ManualSkip, self._manualSkip, self)
	self.unregisterCallback(self, LimitedRoleController.VideoState, self._onVideoState, self)
	AudioBgmManager.instance:unregisterCallback(AudioBgmEvent.onPlayBgm, self._stopMainBgm, self)
	TaskDispatcher.cancelTask(self._HideMainView, self)
	ViewMgr.instance:closeView(ViewName.LimitedRoleView)

	if self._stage and self._stage == LimitedRoleEnum.Stage.FirstLogin then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
	end
end

function LimitedRoleController:_stopMainBgm()
	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
end

function LimitedRoleController:_HideMainView()
	if self._stage == LimitedRoleEnum.Stage.FirstLogin and ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, false)
	end
end

function LimitedRoleController:_manualSkip()
	self.unregisterCallback(self, LimitedRoleController.PlayAction, self._playAction, self)
	self.unregisterCallback(self, LimitedRoleController.ManualSkip, self._manualSkip, self)
	self.unregisterCallback(self, LimitedRoleController.VideoState, self._onVideoState, self)

	self._isPlayingVideo = false
	self._isPlayingAction = false

	self:_clearEffect()
	self:_clearActionState()
end

function LimitedRoleController:_playAction()
	self.unregisterCallback(self, LimitedRoleController.PlayAction, self._playAction, self)
	self.unregisterCallback(self, LimitedRoleController.ManualSkip, self._manualSkip, self)
	self.unregisterCallback(self, LimitedRoleController.VideoState, self._onVideoState, self)
	AudioBgmManager.instance:unregisterCallback(AudioBgmEvent.onPlayBgm, self._stopMainBgm, self)
	TaskDispatcher.cancelTask(self._HideMainView, self)
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)

	if self._limitedCO then
		if self._limitedCO then
			local actionTime = self._limitedCO.actionTime

			if self._limitedCO then
				local effect = self._limitedCO.entranceEffect

				if self._limitedCO then
					local effectDuration = self._limitedCO.effectDuration
					local mainViewContainer = ViewMgr.instance:getContainer(ViewName.MainView)

					if mainViewContainer then
						if not string.nilorempty(effect) then
							self:_playEntranceEffect(effect, effectDuration)
						end

						local mainHeroView = mainViewContainer:getMainHeroView()
						local curHeroId, curSkinId = CharacterSwitchListModel.instance:getMainHero()
						local skinState = PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, curHeroId, 1)

						skinState = tonumber(skinState) or 1

						if not self._limitedCO[skinState] then
							local voiceId = 0

							if not actionTime[skinState] then
								local actionTime2 = 0

								if mainHeroView and voiceId > 0 then
									mainHeroView:checkSwitchShowInScene()

									local skinCO = lua_skin.configDict[self._limitedCO.id]
									local characterId = skinCO and skinCO.characterId
									local voiceCO = CharacterDataConfig.instance:getCharacterVoiceCO(characterId, voiceId)

									if voiceCO then
										if actionTime2 > 0 then
											if self._stage == LimitedRoleEnum.Stage.FirstLogin then
												self:_blockMainViewClick(actionTime2)
												MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, false)
											end

											self._isPlayingAction = true

											TaskDispatcher.runDelay(self._clearActionState, self, actionTime2)
										end

										mainHeroView:playVoice(voiceCO)
									else
										logError("限定角色语音配置不存在 " .. voiceId)
									end
								end
							end
						end
					end

					self._isPlayingVideo = false
				end
			end
		end
	end
end

function LimitedRoleController:_playEntranceEffect(effect, duration)
	local mainSceneRoot = GameSceneMgr.instance:getScene(SceneType.Main):getSceneContainerGO()

	self._effectRoot = gohelper.create3d(mainSceneRoot, "EntranceEffect")
	self._effectPrefabInstantiate = PrefabInstantiate.Create(self._effectRoot)

	self._effectPrefabInstantiate:startLoad(ResUrl.getEffect(effect))
	TaskDispatcher.runDelay(self._clearEffect, self, duration or 5)
end

function LimitedRoleController:_clearEffect()
	TaskDispatcher.cancelTask(self._clearEffect, self)

	if self._effectPrefabInstantiate then
		self._effectPrefabInstantiate:dispose()

		self._effectPrefabInstantiate = nil
	end

	if not gohelper.isNil(self._effectRoot) then
		gohelper.destroy(self._effectRoot)

		self._effectRoot = nil
	end
end

function LimitedRoleController:_stopVideoAudio()
	if self._limitedCO and self._limitedCO.stopAudio > 0 then
		AudioMgr.instance:trigger(self._limitedCO.stopAudio)
	end
end

function LimitedRoleController:_stopVoice()
	self._isPlayingAction = false

	MainController.instance:dispatchEvent(MainEvent.ForceStopVoice)
end

function LimitedRoleController:_clearActionState()
	self:_stopVideoAudio()
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)

	if self._stage == LimitedRoleEnum.Stage.FirstLogin then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
	end

	self:_cancelBlockMainViewClick()
	AudioBgmManager.instance:unregisterCallback(AudioBgmEvent.onPlayBgm, self._stopMainBgm, self)
	TaskDispatcher.cancelTask(self._HideMainView, self)

	self._stage = nil
	self._isPlayingAction = false
	self._limitedCO = nil

	local callback = self._callback
	local callbackObj = self._callbackObj
	local callbackParam = self._callbackParam

	self._callback = nil
	self._callbackObj = nil
	self._callbackParam = nil

	if callback then
		self._callback(callbackObj, callbackParam)
	end
end

function LimitedRoleController:getNeedPlayLimitedCO()
	if VersionValidator.instance:isInReviewing() then
		return nil
	end

	local curHeroId, curSkinId = CharacterSwitchListModel.instance:getMainHero(false)
	local limitedCO = lua_character_limited.configDict[curSkinId]

	if limitedCO and not string.nilorempty(limitedCO.entranceMv) then
		return limitedCO
	end

	return nil
end

function LimitedRoleController:_blockMainViewClick(cancelDelay)
	UIBlockMgr.instance:startBlock(UIBlockKey.LimitedRoleMainView)
	UIBlockMgrExtend.setNeedCircleMv(false)
	TaskDispatcher.cancelTask(self._cancelBlockMainViewClick, self)
	TaskDispatcher.runDelay(self._cancelBlockMainViewClick, self, cancelDelay or 10)
end

function LimitedRoleController:_cancelBlockMainViewClick()
	UIBlockMgr.instance:endBlock(UIBlockKey.LimitedRoleMainView)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(self._cancelBlockMainViewClick, self)
end

LimitedRoleController.instance = LimitedRoleController.New()

return LimitedRoleController
