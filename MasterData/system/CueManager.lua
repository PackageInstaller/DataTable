-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\CueManager.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local CueDataBank = require("System/CueDataBank")
local EffectManager = EffectManager
local ImageEffectMgr = Framework.EffectSystem.ImageEffectManager
local ModelEffectManager = require("System/ModelEffectManager")
local CameraManager = Framework.CameraSystem.CameraManager
local AudioManager = require("System/AudioManager")
local ResStateBGM = require("ClientData/ResStateBGM")
local ResUIBGM = require("ClientData/ResUIBGM")
local ResHeroVocal = require("ClientData/ResHeroVocal")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local EffectPreloadConfig = require("DesignerScript/EffectPreloadConfig")
local ResBattleBGMConfig = require("ClientData/ResBattleBGMConfig")
local Const = Const
local logerror = logerror
local Vector3 = Vector3
local UnityEngine = UnityEngine
local EffectLifeMode = Const.EFFECT_LIFE_MODE
local CueManager = {}
local self = CueManager

function CueManager.initCueManager()
	assert(CueManager._instance == nil, "[ERROR] The CueManager instance is created already!")

	self.logicGroups = {
		[0] = true
	}
	self.logicControlEffects = {}
	self.audios = {}
	self.postProcessStay = {}
	self.postProcessTimer = {}

	CueDataBank.initCueData("Common")

	self.audioMgr = AudioManager()
	self.modelEffectMgr = ModelEffectManager()

	self._initPostProcess()
end

function CueManager.destroy()
	self.audioMgr:destroy()
	self.modelEffectMgr:destroy()
end

function CueManager.shouldPlayCue(cueId, actorIsPlayer, atkerIsPlayer)
	local cueData = CueDataBank.getCueData(cueId)

	if not cueData then
		return false
	end

	if not cueData.OnlyPlayer and not cueData.OnlyAttacker then
		return true
	end

	if cueData.OnlyPlayer and not cueData.OnlyAttacker then
		return actorIsPlayer
	elseif not cueData.OnlyPlayer and cueData.OnlyAttacker then
		return atkerIsPlayer
	elseif cueData.OnlyPlayer and cueData.OnlyAttacker then
		local result = atkerIsPlayer or actorIsPlayer

		return result
	end

	return true
end

function CueManager.cueIsAudio(cueId)
	local cueData = CueDataBank.getCueData(cueId)

	if not cueData then
		return false
	end

	local cueType = cueData.TypeString

	return cueType == "Audio"
end

function CueManager.playCue(actor, cueId, player, fashionTag)
	local cueData = CueDataBank.getCueData(cueId)

	if not cueData then
		return
	end

	local cueType = cueData.TypeString

	if cueType == "Effect" then
		return self._playCueEffect(actor, cueData, player, nil, fashionTag)
	elseif cueType == "Audio" then
		local audioSource = cueData.AudioCue.sourcePath
		local volume = cueData.AudioCue.volume
		local pitch = cueData.AudioCue.pitch

		if audioSource and audioSource ~= "" then
			self.audioMgr:playSFX(audioSource, volume, pitch)
		end
	elseif cueType == "GroupCue" then
		local cueList = cueData.GroupCue.CueList

		if cueList and next(cueList) ~= nil then
			local insIdList = {}

			for i, elemId in ipairs(cueList) do
				if elemId ~= cueId then
					local insId = self.playCue(actor, elemId, player)

					if insId then
						if type(insId) == "number" then
							table.insert(insIdList, insId)
						elseif type(insId) == "table" then
							for i, tempId in ipairs(insId) do
								table.insert(insIdList, tempId)
							end
						end
					end
				end
			end

			return insIdList
		end
	elseif cueType == "CueShake" then
		local shakeSource = cueData.CueShake.Source

		if shakeSource and shakeSource ~= "" then
			CameraManager.ScreenShake(shakeSource)
		end
	elseif cueType == "CueCamera" then
		local cameraSource = cueData.Camera.SourcePath

		if cameraSource and cameraSource ~= "" then
			actor:playCamera(cameraSource)
		end
	elseif cueType == "PostProcess" then
		self.playPostProcess(cueId, nil, actor)
	elseif cueType == "ModelEffect" then
		local effectID = cueData.CueID
		local effectInfo = cueData.ModelEffect

		self.modelEffectMgr:playModelEffect(actor, effectID, effectInfo)
	elseif cueType == "BattleDialog" then
		local dialogId = cueData.BattleDialog.DialogId

		self.playBattleDialog(actor, dialogId)
	elseif cueType == "SequenceFrame" then
		local sequenceInfo = cueData.SequenceFrame

		self.playUIAnimation(sequenceInfo, actor, fashionTag)
	elseif cueType == "TargetCamera" then
		local targetCameraInfo = cueData.TargetCamera

		self.playTargetCamera(actor, targetCameraInfo)
	end
end

function CueManager.releaseCue(actor, cueId, insId)
	local cueData = CueDataBank.getCueData(cueId)
	local cueType = cueData.TypeString

	if cueType == "Effect" then
		self.releaseEffect(insId)
	elseif cueType == "PostProcess" then
		self.stopPostProcess(cueId, nil, actor)
	elseif cueType == "GroupCue" then
		local cueList = cueData.GroupCue.CueList

		if cueList and #cueList > 0 then
			for i, cueid in ipairs(cueList) do
				local cuedata = CueDataBank.getCueData(cueid)
				local cuetype = cuedata.TypeString

				if cuetype == "GroupCue" then
					self.releaseCue(actor, cueid, insId)
				elseif cuetype == "Effect" then
					if insId and insId[1] then
						local theInsId = insId[1]

						self.releaseCue(actor, cueid, theInsId)
						table.remove(insId, 1)
					end
				else
					self.releaseCue(actor, cueid)
				end
			end
		end
	elseif cueType == "ModelEffect" then
		local effectID = cueData.CueID

		self.modelEffectMgr:recoverModelEffect(actor, effectID)
	elseif cueType == "TargetCamera" then
		self.stopTargetCamera()
	end
end

function CueManager.playCueEffect(actor, cueId, target, delayTime, fashionTag)
	local cueData = CueDataBank.getCueData(cueId)

	if not cueData then
		return
	end

	return self._playCueEffect(actor, cueData, target, delayTime, fashionTag)
end

function CueManager._playCueEffect(actor, cueData, target, delayTime, fashionTag)
	if not cueData then
		return
	end

	local cueType = cueData.TypeString

	if cueType ~= "Effect" then
		return
	end

	local effectData = cueData.EffectCue

	if not effectData or not effectData.SourcePath then
		return
	end

	local mode = effectData.motionMode
	local insId
	local actorTransform, actorIsGO = self._getActorTransform(actor)
	local logicTag = effectData.logicTag or not actorIsGO and actor.entityId or 0

	self.logicGroups[logicTag] = true

	local logicMirror = not actorIsGO and actor.oriMirror or false

	if mode == BattleConst.EFFECT_MODE.Normal then
		insId = EffectManager:playNormalEffectAsync(actorTransform, effectData, EffectLifeMode.LogicControl, logicTag, logicMirror, fashionTag)
	elseif mode == BattleConst.EFFECT_MODE.Parabola then
		local targetTransform = self._getActorTransform(target)

		if actorTransform and targetTransform and delayTime then
			insId = EffectManager:playThrowEffectAsync(actorTransform, targetTransform, effectData, delayTime, EffectLifeMode.LogicControl, logicTag, fashionTag)
		end
	elseif mode == BattleConst.EFFECT_MODE.Link then
		local targetTransform = self._getActorTransform(target)

		if actorTransform and targetTransform then
			insId = EffectManager:playLinkEffectAsync(targetTransform, actorTransform, effectData, EffectLifeMode.LogicControl, logicTag, fashionTag)
		end
	elseif mode == BattleConst.EFFECT_MODE.Screen then
		if Const.SKIP_SCREEN_EFX then
			return
		end

		local effectMirrored = false

		if actor and not actorIsGO and actor.modelIsMirror then
			effectMirrored = true
		end

		insId = EffectManager:playUIEffectAsync(effectData, nil, EffectLifeMode.LogicControl, effectMirrored, fashionTag)
	end

	return insId
end

function CueManager.isNormalEffect(cueId)
	local cueData = CueDataBank.getCueData(cueId)

	if cueData and cueData.TypeString == "Effect" and cueData.EffectCue and cueData.EffectCue.motionMode == BattleConst.EFFECT_MODE.Normal then
		return true
	end

	return false
end

function CueManager.playLinkEffect(cueId, startActor, endActor, fashionTag)
	local cueData = CueDataBank.getCueData(cueId)
	local startTransform, actorIsGO = self._getActorTransform(startActor)
	local endTransform = self._getActorTransform(endActor)

	if not cueData or cueData.TypeString ~= "Effect" or cueData.EffectCue.motionMode ~= BattleConst.EFFECT_MODE.Link or not startTransform or not endTransform then
		return
	end

	local effectData = cueData.EffectCue
	local logicTag = effectData.logicTag or not actorIsGO and startActor.entityId or 0
	local insId = EffectManager:playLinkEffectAsync(startTransform, endTransform, effectData, EffectLifeMode.LogicControl, logicTag, fashionTag)

	return insId
end

function CueManager.isLinkEffect(cueId)
	local cueData = CueDataBank.getCueData(cueId)

	if cueData and cueData.TypeString == "Effect" and cueData.EffectCue and cueData.EffectCue.motionMode == BattleConst.EFFECT_MODE.Link then
		return true
	end

	return false
end

function CueManager._getActorTransform(actor)
	if not actor then
		return
	end

	local actorTransform
	local isEntity = false
	local isGO = false

	if type(actor) == "userdata" then
		isGO = true
	elseif actor.entityType then
		isEntity = true
	end

	if isGO then
		-- block empty
	elseif isEntity then
		if actor:isModelLoaded() then
			actorTransform = actor.entityModel.modelGameObject.transform
		end
	elseif actor.entityModel then
		actorTransform = actor.entityModel.modelGameObject.transform
	end

	if not actorTransform and actor.gameObject then
		actorTransform = actor.gameObject.transform
	end

	return actorTransform, isGO
end

function CueManager.releaseEffect(insId)
	EffectManager:releaseEffect(insId)
end

function CueManager.releaseEffectByGroup(logicGroup)
	EffectManager:batchReleaseEffects(logicGroup)
end

function CueManager.setEffectForceQuality(quality)
	EffectManager:setForceQuality(quality)
end

function CueManager.clearEffectForceQuality()
	EffectManager:clearForceQuality()
end

local ImageEffectType = {
	Tonemapping = 8,
	Bloom = 1,
	TintColor = 4,
	Lut = 0,
	BlackOcclusion = 5,
	RadialBlur = 2,
	DepthOfField = 6,
	TiltShift = 3,
	MotionBlur = 7
}

function CueManager._initPostProcess(...)
	if not self.postProcessInited then
		self.postProcessInited = true
	end
end

function CueManager.playPostProcess(cueId, cam, actor)
	CueManager.forceStopDof()

	local cueData = CueDataBank.getCueData(cueId)

	if not cueData.PostProcess then
		return
	end

	local effectInfo = cueData.PostProcess
	local effectType = effectInfo.type
	local fadeIn = effectInfo.fadeIn
	local cullingPlayer = effectInfo.cullingPlayer or 0

	if cullingPlayer == 2 and actor and actor.entityModel then
		actor.entityModel:setModelLayer(Const.LAYER_MAINPLAYER)
	end

	if effectType == ImageEffectType.Lut then
		local texture = effectInfo.lutParam.texturePath

		if fadeIn == nil or fadeIn == 0 then
			ImageEffectMgr.StartLUT(cam, texture, cullingPlayer)
		else
			local blendParam = {
				LutTexture = texture
			}

			ImageEffectMgr.FadeInLUT(cam, blendParam, fadeIn, cullingPlayer)
		end
	elseif effectType == ImageEffectType.Bloom then
		local bloomSettings = effectInfo.bloomParam
		local config = {}
		local useColorBloom = bloomSettings.useColorBloom

		config.useColorBloom = useColorBloom

		if useColorBloom then
			config.colorBloomIntensity = bloomSettings.colorBloomIntensity
			config.colorBloomR = bloomSettings.colorBloomR
			config.colorBloomG = bloomSettings.colorBloomG
			config.colorBloomB = bloomSettings.colorBloomB
			config.colorBloomBlurTheta = bloomSettings.colorBloomBlurTheta
		else
			config.intensity = bloomSettings.intensity
			config.threshold = bloomSettings.threshold
			config.softKnee = bloomSettings.softKnee
			config.radius = bloomSettings.radius
			config.prefilterScale = 4
			config.clamp = 2
		end

		ImageEffectMgr.StartBloom(cam, config)
	elseif effectType == ImageEffectType.RadialBlur then
		local blurStrength = effectInfo.radialBlurParam.blurStrength or 4
		local sampleDist = effectInfo.radialBlurParam.sampleDist or 0.5
		local centerU = effectInfo.radialBlurParam.centerU or 0.5
		local centerV = effectInfo.radialBlurParam.centerV or 0.5

		if fadeIn == nil or fadeIn == 0 then
			ImageEffectMgr.StartRadialBlur(cam, blurStrength, sampleDist, centerU, centerV, cullingPlayer)
		else
			local blendParam = {
				BlurCenterU = centerU,
				BlurCenterV = centerV,
				SampleDist = sampleDist,
				BlurStrength = blurStrength
			}

			ImageEffectMgr.FadeInRadialBlur(cam, blendParam, fadeIn, cullingPlayer)
		end
	elseif effectType == ImageEffectType.MotionBlur then
		local blurSize = effectInfo.motionBlurParam.blurSize

		ImageEffectMgr.StartMotionBlur(cam, blurSize, cullingPlayer)
	elseif effectType == ImageEffectType.TiltShift then
		local blurArea = effectInfo.tiltShiftParam.blurArea or 1
		local maxBlurSize = effectInfo.tiltShiftParam.maxBlurSize or 5

		if fadeIn == nil or fadeIn == 0 then
			ImageEffectMgr.StartTiltShift(cam, blurArea, maxBlurSize, cullingPlayer)
		else
			local blendParam = {
				BlurArea = blurArea,
				MaxBlurSize = maxBlurSize
			}

			ImageEffectMgr.FadeInTiltShift(cam, blendParam, fadeIn, cullingPlayer)
		end
	elseif effectType == ImageEffectType.TintColor then
		local colorR = effectInfo.tintColorParam.R
		local colorG = effectInfo.tintColorParam.G
		local colorB = effectInfo.tintColorParam.B
		local colorA = effectInfo.tintColorParam.A
		local blendMode = effectInfo.tintColorParam.blendMode or false

		if fadeIn == nil or fadeIn == 0 then
			ImageEffectMgr.StartTintColor(cam, UnityEngine.Color(colorR, colorG, colorB, colorA), blendMode, cullingPlayer)
		else
			ImageEffectMgr.FadeInTintColor(cam, UnityEngine.Color(colorR, colorG, colorB, colorA), blendMode, fadeIn, cullingPlayer)
		end
	elseif effectType == ImageEffectType.BlackOcclusion then
		ImageEffectMgr.StartSceneOcclusion(cam, UnityEngine.Color(0, 0, 0, 1))
	elseif effectType == ImageEffectType.DepthOfField then
		local focusDistance = effectInfo.depthParam.focusDistance
		local aperture = effectInfo.depthParam.aperture
		local focalLength = effectInfo.depthParam.focalLength
		local kernelSize = effectInfo.depthParam.blurSize

		if fadeIn == nil or fadeIn == 0 then
			ImageEffectMgr.StartDof(cam, focusDistance, aperture, focalLength, kernelSize)
		else
			ImageEffectMgr.FadeInDoF(cam, focusDistance, aperture, focalLength, fadeIn, kernelSize)
		end
	elseif effectType == ImageEffectType.Tonemapping then
		local postExposure = effectInfo.tonemappingParam.PostExposure or -0.7

		ImageEffectMgr.StartTonemapping(cam, postExposure)
	end

	local length = effectInfo.length
	local fadeOut = effectInfo.fadeOut

	if length > 0 then
		if self.postProcessTimer[effectType] then
			self.postProcessTimer[effectType]:Stop()

			self.postProcessTimer[effectType] = nil
		end

		self.postProcessTimer[effectType] = Timer.New(Functor(self.stopPostProcessByTimer, effectType, cam, fadeOut, actor, cullingPlayer), length, 1, true)

		self.postProcessTimer[effectType]:Start()
	else
		self.postProcessStay[effectType] = cueId
	end
end

local stopFuncMap = {
	[ImageEffectType.Lut] = ImageEffectMgr.StopLUT,
	[ImageEffectType.Bloom] = ImageEffectMgr.StopBloom,
	[ImageEffectType.RadialBlur] = ImageEffectMgr.StopRadialBlur,
	[ImageEffectType.TiltShift] = ImageEffectMgr.StopTiltShift,
	[ImageEffectType.TintColor] = ImageEffectMgr.StopTintColor,
	[ImageEffectType.BlackOcclusion] = ImageEffectMgr.StopSceneOcclusion,
	[ImageEffectType.DepthOfField] = ImageEffectMgr.StopDoF,
	[ImageEffectType.MotionBlur] = ImageEffectMgr.StopMotionBlur,
	[ImageEffectType.Tonemapping] = ImageEffectMgr.StopTonemapping
}
local fadeoutFuncMap = {
	[ImageEffectType.Lut] = ImageEffectMgr.FadeOutLUT,
	[ImageEffectType.RadialBlur] = ImageEffectMgr.FadeOutRadialBlur,
	[ImageEffectType.TiltShift] = ImageEffectMgr.FadeOutTiltShift,
	[ImageEffectType.TintColor] = ImageEffectMgr.FadeOutTintColor
}

function CueManager.stopPostProcess(cueId, cam, actor)
	local cueData = CueDataBank.getCueData(cueId)

	if not cueData.PostProcess then
		return
	end

	local effectInfo = cueData.PostProcess
	local effectType = effectInfo.type
	local fadeOut = effectInfo.fadeOut
	local cullingPlayer = effectInfo.cullingPlayer or 0

	self.stopPostProcessByType(effectType, cam, nil, actor, cullingPlayer)
end

function CueManager.stopPostProcessByType(effectType, cam, fadeOut, actor, cullingPlayer)
	if cullingPlayer == 2 and actor and actor.entityModel then
		actor.entityModel:setModelLayer(actor:getLayer())
	end

	if fadeOut == nil or fadeOut == 0 or fadeoutFuncMap[effectType] == nil then
		if stopFuncMap[effectType] then
			stopFuncMap[effectType](cam)
		end
	else
		fadeoutFuncMap[effectType](cam, fadeOut, cullingPlayer)
	end

	if self.postProcessTimer[effectType] then
		self.postProcessTimer[effectType]:Stop()

		self.postProcessTimer[effectType] = nil
	end

	if self.postProcessStay[effectType] then
		self.postProcessStay[effectType] = nil
	end
end

function CueManager.stopPostProcessByTimer(effectType, cam, fadeOut, actor, cullingPlayer)
	if self.postProcessStay[effectType] then
		local cueId = self.postProcessStay[effectType]

		self.playPostProcess(cueId, cam, actor)
	else
		self.stopPostProcessByType(effectType, cam, fadeOut, actor, cullingPlayer)
	end
end

function CueManager.pausePostProcess()
	for effectType, timer in pairs(self.postProcessTimer) do
		timer:Pause()
	end
end

function CueManager.resumePostProcess()
	for effectType, timer in pairs(self.postProcessTimer) do
		timer:Resume()
	end
end

function CueManager.revertImageEffects(cam)
	ImageEffectMgr.ClearAllImageEffect(cam)
end

function CueManager.applySceneImageEffects(ppbType)
	ImageEffectMgr.ApplyScenePostFxProfile(nil, ppbType, false)
end

function CueManager.startPostOutline(cam)
	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	ImageEffectMgr.StartPostOutline(cam)
end

function CueManager.stopPostOutline(cam)
	ImageEffectMgr.StopPostOutline(cam)
end

function CueManager.forceStopDof(cam)
	ImageEffectMgr.ForceStopDof(cam)
end

function CueManager.revertForceStopDof(cam)
	ImageEffectMgr.RevertForceStopDof(cam)
end

function CueManager.updatePostDepth(cam)
	ImageEffectMgr.CaptureDepth(cam)
end

function CueManager.playBattleDialog(actor, dialogId)
	if actor and actor.showDialog then
		actor:showDialog(dialogId)
	end
end

function CueManager.playTargetCamera(actor, cameraInfo)
	if not cameraInfo then
		return
	end

	local actorTransform = self._getActorTransform(actor)
	local animPath = cameraInfo.SourcePath
	local length = cameraInfo.Length or 1
	local fadeIn = cameraInfo.FadeIn or 0
	local fadeOut = cameraInfo.FadeOut or 0
	local fixedAngle = 0

	if actor.getCameraAngleFix then
		fixedAngle = actor:getCameraAngleFix()
	end

	CameraManager.PlayCameraAnimator(animPath, actorTransform, nil, fadeIn, fixedAngle, 0)

	self.coTargetCamera = coroutine.start(self._coRecoverTargetCamera, length, fadeOut)
end

function CueManager._coRecoverTargetCamera(duration, fadeOut)
	coroutine.wait(duration)
	CameraManager.SwitchToNode(fadeOut, 0)

	self.coTargetCamera = nil
end

function CueManager.stopTargetCamera()
	if self.coTargetCamera then
		coroutine.stop(self.coTargetCamera)

		self.coTargetCamera = nil
	end

	CameraManager.SwitchToNode(0.3, 0)
end

function CueManager.playUIAnimation(uiAnimateInfo, actor, fashionTag)
	if not uiAnimateInfo or not uiAnimateInfo.SequenceType then
		return
	end

	local animateType = uiAnimateInfo.SequenceType

	if animateType == 0 then
		CueManager.playSequenceFrame(uiAnimateInfo)
	elseif animateType == 1 then
		CueManager.play2DAnimation(uiAnimateInfo)
	elseif animateType == 2 then
		local videoMirrored = false

		if actor and actor.modelIsMirror then
			videoMirrored = true
		end

		CueManager.playUIVideo(uiAnimateInfo, videoMirrored, fashionTag)
	elseif animateType == 3 then
		local stageMirrored = false
		local actorModelAux

		if actor then
			if actor.modelIsMirror then
				stageMirrored = true
			end

			if actor.entityModel.modelAux then
				actorModelAux = actor.entityModel.modelAux
			end
		end

		CueManager.playRealtimeStage(uiAnimateInfo, stageMirrored, actorModelAux)
	end
end

function CueManager.playSequenceFrame(sequenceInfo)
	if not sequenceInfo or not sequenceInfo.SequenceName then
		return
	end

	local name = sequenceInfo.SequenceName
	local frameCount = sequenceInfo.FrameCount or 30

	local function callback(...)
		CueManager.stopSequenceFrame()
	end

	local playerDlg = UIManager.getUI("sequenceFramePlayer", true)

	playerDlg:setSequenceFrame(name, frameCount, callback)
end

function CueManager.stopSequenceFrame()
	local dlg = UIManager.getUI("sequenceFramePlayer", nil, false)

	if dlg then
		dlg:setVisible(false)
	end
end

function CueManager.play2DAnimation(animationInfo)
	if not animationInfo or not animationInfo.SequenceName then
		return
	end

	local animationPath = animationInfo.SequenceName
	local playerDlg = UIManager.getUI("sequenceFramePlayer", true)

	playerDlg:set2DAnimation(animationPath, true)
end

function CueManager.stop2DAnimation()
	local playerDlg = UIManager.getUI("sequenceFramePlayer", nil, false)

	if playerDlg then
		playerDlg:stop2DAnimation()
		playerDlg:setVisible(false)
	end
end

function CueManager.playUIVideo(videoInfo, mirror, fashionTag)
	if not videoInfo or not videoInfo.SequenceName then
		return
	end

	local videoPath = utils.fixFashionPath(videoInfo.SequenceName, fashionTag)
	local playerDlg = UIManager.getUI("sequenceFramePlayer", true)

	playerDlg:playVideo(videoPath, mirror, nil, false)
end

function CueManager.stopUIVideo(...)
	local playerDlg = UIManager.getUI("sequenceFramePlayer", nil, false)

	if playerDlg then
		playerDlg:stopVideo()
		playerDlg:setVisible(false)
	end
end

function CueManager.pauseUIVideo(...)
	local playerDlg = UIManager.getUI("sequenceFramePlayer", nil, false)

	if playerDlg then
		playerDlg:pauseCurrentMedia()
	end
end

function CueManager.resumeUIVideo(...)
	local playerDlg = UIManager.getUI("sequenceFramePlayer", nil, false)

	if playerDlg then
		playerDlg:resumeCurrentMedia()
	end
end

function CueManager.playRealtimeStage(stageInfo, mirror, actor)
	if not stageInfo or not stageInfo.SequenceName then
		return
	end

	local stagePath = stageInfo.SequenceName
	local playerDlg = UIManager.getUI("sequenceFramePlayer", true)

	playerDlg:playRealtimeStage(stagePath, actor, mirror)
end

function CueManager.setBaseBGMByState(stateName)
	if ResStateBGM[stateName] then
		self.setBaseBGM(ResStateBGM[stateName].bgm)
	end
end

function CueManager.setUIBgmById(uiId)
	if ResUIBGM[uiId] then
		self.playUIBGM(ResUIBGM[uiId].bgm)
	end
end

function CueManager.setBaseBGM(bgmId)
	self.baseBGM = bgmId
end

function CueManager._revertBGM()
	if self.curAvgBGM then
		self.audioMgr:switchBGM(self.curAvgBGM)
	elseif self.curUIBGM then
		self.audioMgr:switchBGM(self.curUIBGM)
	elseif self.baseBGM then
		self.audioMgr:switchBGM(self.baseBGM)
	end
end

function CueManager.stopBGM()
	self.audioMgr:clearBGMCache()
	self.audioMgr:stopMusic()
end

function CueManager.fadeOutBGM(...)
	self.audioMgr:setBGMVolume(0, UIMiscConfig.FADE_BGM_DURATION)
end

function CueManager.playBaseBGM()
	if self.baseBGM and not self.curUIBGM and not self.curAvgBGM then
		self.audioMgr:switchBGM(self.baseBGM)
	end
end

function CueManager.playUIBGM(bgmId)
	if bgmId and bgmId ~= self.curUIBGM then
		self.audioMgr:playBGMById(bgmId)

		self.curUIBGM = bgmId
	end
end

function CueManager.stopUIBGM()
	if self.curUIBGM then
		self.curUIBGM = nil

		self._revertBGM()
	end
end

function CueManager.playAvgBGM(bgmId)
	if bgmId then
		self.audioMgr:playBGMById(bgmId)

		self.curAvgBGM = bgmId
	end
end

function CueManager.stopAvgBGM()
	if self.curAvgBGM then
		self.curAvgBGM = nil

		self._revertBGM()
	end
end

function CueManager.setBGMLoop(isLoop)
	self.audioMgr:setBGMLoop(isLoop)
end

function CueManager.getBattleBGMConfig(battleType, whereToUse)
	if ResBattleBGMConfig[battleType] and ResBattleBGMConfig[battleType][whereToUse] then
		return ResBattleBGMConfig[battleType][whereToUse]
	end
end

function CueManager.getRelicBGM(...)
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		return battleBGM
	end
end

local GROUP_VOCAL = {
	[Const.HERO_VOCAL_ULTIMATEX1] = true,
	[Const.HERO_VOCAL_ULTIMATESHORTX1] = true,
	[Const.HERO_VOCAL_ULTIMATEX2] = true,
	[Const.HERO_VOCAL_ULTIMATESHORTX2] = true
}

function CueManager.playHeroVocal(heroId, vocalType, fashionTag)
	if ResHeroVocal[heroId] and ResHeroVocal[heroId][vocalType] then
		if GROUP_VOCAL[vocalType] then
			self.playGroupVocal(ResHeroVocal[heroId][vocalType], fashionTag)
		else
			self.playVocal(ResHeroVocal[heroId][vocalType], nil, fashionTag)
		end
	end
end

function CueManager.heroHasVocal(heroId, vocalType)
	return ResHeroVocal[heroId] ~= nil and ResHeroVocal[heroId][vocalType] ~= nil
end

function CueManager.playVocal(vocalId, logicPriority, fashionTag)
	self.audioMgr:playVocalById(vocalId, logicPriority, fashionTag)
end

function CueManager.playGroupVocal(groupId, fashionTag)
	if self.audioMgr:hasGroup(groupId) then
		self.audioMgr:playVocalGroup(groupId)
	else
		self.audioMgr:playVocalById(groupId, nil, fashionTag)
	end
end

function CueManager.playVocalByPath(voicePath, priority, volume, fashionTag)
	self.audioMgr:playVocal(voicePath, priority, volume)
end

function CueManager.stopVocal()
	self.audioMgr:stopVocal()
end

function CueManager.playUiSfx(path, priority, volume)
	self.audioMgr:playUISfx(path, priority, volume)
end

function CueManager.playNoise(noiseId)
	self.audioMgr:playNoiseById(noiseId)
end

function CueManager.stopNoise()
	self.audioMgr:stopNoise()
end

function CueManager.setSfxSpeed(speed)
	self.audioMgr:setSfxSpeed(speed)
end

function CueManager.getFootStepGroupId(heroId)
	return self.audioMgr:getFootStepGroup(heroId)
end

function CueManager.setMuteAudios(audioPathList, isMute)
	for _, path in ipairs(audioPathList) do
		self.audioMgr:setMuteByPath(path, isMute)
	end
end

function CueManager.pauseTimerCue(...)
	self.pausePostProcess()
	self.pauseUIVideo()
end

function CueManager.resumeTimerCue(...)
	self.resumePostProcess()
	self.resumeUIVideo()
end

function CueManager.clearCue(logicGroup, actor)
	self.releaseEffectByGroup(logicGroup)

	if actor then
		self.modelEffectMgr:clearEntityModelEffect(actor)
	end

	self.logicGroups[logicGroup] = nil
end

function CueManager.clearAllCue()
	for group, _ in pairs(self.logicGroups) do
		self.releaseEffectByGroup(group)
	end

	self.logicGroups = {
		[0] = {}
	}

	EffectManager:despawnUnuseEffect()
	EffectManager:stopUIEffect()
	self.audioMgr:cleanAllLoadedSFX()
	self.modelEffectMgr:stopAllTimer()
	CameraManager.ReleaseScreenShake()
	self.stopSequenceFrame()

	self.audios = {}
	self.postProcessStay = {}

	for effectType, timer in pairs(self.postProcessTimer) do
		timer:Stop()
	end

	self.postProcessTimer = {}

	self.revertImageEffects()
end

function CueManager.preloadCue(group)
	if EffectPreloadConfig.PreloadWhiteList[group] then
		EffectManager:preloadEffect(EffectPreloadConfig.PreloadWhiteList[group])
	end
end

function CueManager.preloadEffectList(effList, callback)
	if effList then
		EffectManager:preloadEffectOneByOne(effList, callback)
	end
end

return CueManager
