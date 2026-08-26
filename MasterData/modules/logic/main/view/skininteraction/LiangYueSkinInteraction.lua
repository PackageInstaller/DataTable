-- chunkname: @modules/logic/main/view/skininteraction/LiangYueSkinInteraction.lua

module("modules.logic.main.view.skininteraction.LiangYueSkinInteraction", package.seeall)

local LiangYueSkinInteraction = class("LiangYueSkinInteraction", CommonSkinInteraction)
local specialAudioId = 1311090
local dragDuration = 0.2
local dragArea = 5
local dragAreaIndex = 1
local effectPath = "ui/viewres/effect/live2d/roleeffect_ly_jh.prefab"
local b_jiaohu_03 = "b_jiaohu_03"
local jiaohu_03_timeout = 6.2

function LiangYueSkinInteraction:_onBodyChange(prevBodyName, curBodyName)
	self._curBodyName = curBodyName

	if self._curBodyName == b_jiaohu_03 then
		TaskDispatcher.runDelay(self._waitTimeout, self, jiaohu_03_timeout)
	end
end

function LiangYueSkinInteraction:_onPlayVoice()
	self:_onStopVoice()
	gohelper.setActive(self._effectGo, false)

	self._isSpecialAudio = self._voiceConfig.audio == specialAudioId
	self._isSpecialInteraction = self._voiceConfig.type == CharacterEnum.VoiceType.MainViewSpecialInteraction or self._isSpecialAudio

	if self._isSpecialInteraction then
		local id = tonumber(self._voiceConfig.param2)

		if not id then
			logError(string.format("CommonSkinInteraction _onPlayVoice param2:%s is error, voiceConfig: %s", self._voiceConfig.param2, tostring(self._voiceConfig.audio)))

			return
		end

		local config = lua_character_special_interaction_voice.configDict[id]

		self._startTime = Time.time
		self._protectionTime = config.protectionTime or 0
		self._waitTime = config.time
		self._waitVoice = config.waitVoice

		self:_initWaitVoiceParams(config.waitVoiceParams)

		self._timeoutVoiceConfig = lua_character_voice.configDict[self._voiceConfig.heroId][config.timeoutVoice]
		self._skipChangeStatus = config.statusParams == CharacterVoiceEnum.StatusParams.Luxi_NoChangeStatus

		CharacterVoiceController.instance:trackSpecialInteraction(self._voiceConfig.heroId, self._voiceConfig.audio, CharacterVoiceController.instance:getSpecialInteractionPlayType())
	end

	if self._isSpecialAudio and not self._effectLoader then
		self._effectPath = effectPath
		self._effectLoader = MultiAbLoader.New()

		self._effectLoader:addPath(self._effectPath)
		self._effectLoader:startLoad(self._loadEffectFinished, self)
	end
end

function LiangYueSkinInteraction:_loadEffectFinished()
	local assetUrl = self._effectPath
	local assetItem = self._effectLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)
	local sceneLevelComp = GameSceneMgr.instance:getCurScene().level

	if sceneLevelComp then
		local sceneGO = sceneLevelComp:getSceneGo()

		self._effectGo = gohelper.clone(mainPrefab, sceneGO)

		gohelper.setActive(self._effectGo, self._isSpecialAudio)
	end
end

function LiangYueSkinInteraction:isCustomDrag()
	return true
end

function LiangYueSkinInteraction:_onPlayVoiceFinish(config)
	if self._isDragging then
		return
	end

	self._voiceConfig = nil

	if self._curBodyName == b_jiaohu_03 then
		return
	end

	if self._isSpecialInteraction then
		TaskDispatcher.runDelay(self._waitTimeout, self, self._waitTime)
	end
end

function LiangYueSkinInteraction:beginDrag()
	self._isDragging = true
end

function LiangYueSkinInteraction:endDrag()
	self._isDragging = false
end

function LiangYueSkinInteraction:beforeBeginDrag(view, config, skinConfig)
	if self._isSpecialAudio then
		local pos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), view._golightspinecontrol.transform)
		local areaId = dragArea
		local areaIndex = dragAreaIndex

		if view:checkSpecialTouchByKey(areaId, pos, areaIndex) then
			self._dragTime = Time.time

			gohelper.setActive(self._effectGo, true)

			return true
		end
	end
end

local zeroPos = Vector3()

function LiangYueSkinInteraction:beforeOnDrag(pos)
	if gohelper.isNil(self._effectGo) then
		return
	end

	local mainCamera = CameraMgr.instance:getMainCamera()
	local worldpos = recthelper.screenPosToWorldPos(GamepadController.instance:getMousePosition(), mainCamera, zeroPos)

	transformhelper.setPos(self._effectGo.transform, worldpos.x, worldpos.y, worldpos.z)
	self:_playDragAudio()
end

function LiangYueSkinInteraction:_playDragAudio()
	if self._dragMoveTime and Time.time - self._dragMoveTime <= 0.9 then
		return
	end

	self._dragMoveTime = Time.time

	AudioMgr.instance:trigger(AudioEnum.UI.play_hero311003_mainsfx_jiaohu_6)
end

function LiangYueSkinInteraction:beforeEndDrag()
	gohelper.setActive(self._effectGo, false)
	self:_checkInteractionSuccessful()
end

function LiangYueSkinInteraction:_checkInteractionSuccessful()
	if self._dragTime and Time.time - self._dragTime > dragDuration then
		self._dragTime = nil

		if not self._waitVoiceParamsObj then
			logError("LiangYueSkinInteraction:_checkInteractionSuccessful waitVoiceParamsObj is nil")

			return false
		end

		local voiceId = self._waitVoiceParamsObj:getSuccessVoiceId()

		if voiceId then
			if not lua_character_voice.configDict[self._timeoutVoiceConfig.heroId][voiceId] then
				local config = self._timeoutVoiceConfig

				self:playVoice(config)

				self._isRespondType = true

				return true
			end
		end
	end
end

function LiangYueSkinInteraction:_waitTimeout()
	self._isSpecialInteraction = nil

	if self:_checkInteractionSuccessful() then
		return
	end

	self:playVoice(self._timeoutVoiceConfig)
end

function LiangYueSkinInteraction:_onDestroy()
	LiangYueSkinInteraction.super._onDestroy(self)

	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	if self._effectGo then
		gohelper.destroy(self._effectGo)

		self._effectGo = nil
	end
end

return LiangYueSkinInteraction
