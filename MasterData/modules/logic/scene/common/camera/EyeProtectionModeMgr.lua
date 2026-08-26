-- chunkname: @modules/logic/scene/common/camera/EyeProtectionModeMgr.lua

module("modules.logic.scene.common.camera.EyeProtectionModeMgr", package.seeall)

local EyeProtectionModeMgr = class("EyeProtectionModeMgr")

function EyeProtectionModeMgr:ctor()
	self.m_ppVolumeGo = nil

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self.onEnterSceneFinish, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, self.onExistScene, self)
end

function EyeProtectionModeMgr:onEnterSceneFinish()
	self:trySetPPVolumeValue()
end

function EyeProtectionModeMgr:onExistScene()
	self:trySetPPVolumeValue()
end

function EyeProtectionModeMgr:changeEyeModeActive()
	local active = not self:getEyeModeActive()

	self:setEyeModeActive(active)
end

function EyeProtectionModeMgr:setEyeModeActive(active)
	local value = active and 1 or 0
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EyeModeActive)

	PlayerPrefsHelper.setNumber(key, value)
	self:trySetPPVolumeValue()
end

function EyeProtectionModeMgr:getEyeModeActive()
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EyeModeActive)
	local value = PlayerPrefsHelper.getNumber(key, 0)

	return value == 1
end

local ActiveIntensityValue = 0.65
local ActiveFactorValue = 0.99

function EyeProtectionModeMgr:trySetPPVolumeValue()
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EyeModeActive)
	local active = PlayerPrefsHelper.getNumber(key, 0) == 1
	local inFightScene = GameSceneMgr.instance:getCurSceneType() == SceneType.Fight

	if active and inFightScene then
		self:setPPVolumeValue(ActiveIntensityValue, ActiveFactorValue)
	else
		self:setPPVolumeValue(1, 0)
	end
end

function EyeProtectionModeMgr:_getPPVolume()
	if not self.m_ppVolumeGo then
		local unitGo = CameraMgr.instance:getUnitCameraGO()

		self.m_ppVolumeGo = gohelper.findChild(unitGo, "PPVolume")
	end

	return self.m_ppVolumeGo
end

function EyeProtectionModeMgr:changeProFile()
	local targetProfile = PostProcessingMgr.instance:getProfile()

	if targetProfile == self.preProfile then
		return
	end

	self.preProfile = targetProfile

	local pp = self:_getPPVolume()
	local wrap = pp:GetComponent(PostProcessingMgr.PPVolumeWrapType)
	local intensityValue = wrap.uberBrightnessIntensity
	local factorValue = wrap.uberBrightnessFactor

	wrap:SetProfile(targetProfile)

	wrap.uberBrightnessIntensity = intensityValue
	wrap.UberBrightnessIntensity = intensityValue
	wrap.uberBrightnessFactor = factorValue
	wrap.UberBrightnessFactor = factorValue

	wrap:Load()
end

function EyeProtectionModeMgr:setPPVolumeValue(intensityValue, factorValue)
	local pp = self:_getPPVolume()
	local wrap = pp:GetComponent(PostProcessingMgr.PPVolumeWrapType)

	wrap.uberBrightnessIntensity = intensityValue
	wrap.UberBrightnessIntensity = intensityValue
	wrap.uberBrightnessFactor = factorValue
	wrap.UberBrightnessFactor = factorValue

	wrap:Load()
	self:changeProFile()
end

function EyeProtectionModeMgr:setIntensityValue(intensityValue)
	local pp = self:_getPPVolume()
	local wrap = pp:GetComponent(PostProcessingMgr.PPVolumeWrapType)

	wrap.uberBrightnessIntensity = intensityValue
	wrap.UberBrightnessIntensity = intensityValue

	wrap:Load()
	self:changeProFile()
end

function EyeProtectionModeMgr:getIntensityValue()
	local pp = self:_getPPVolume()
	local wrap = pp:GetComponent(PostProcessingMgr.PPVolumeWrapType)

	return wrap.uberBrightnessIntensity
end

function EyeProtectionModeMgr:setFactorValue(factorValue)
	local pp = self:_getPPVolume()
	local wrap = pp:GetComponent(PostProcessingMgr.PPVolumeWrapType)

	wrap.uberBrightnessFactor = factorValue
	wrap.UberBrightnessFactor = factorValue

	wrap:Load()
	self:changeProFile()
end

function EyeProtectionModeMgr:getFactorValue()
	local pp = self:_getPPVolume()
	local wrap = pp:GetComponent(PostProcessingMgr.PPVolumeWrapType)

	return wrap.uberBrightnessFactor
end

function EyeProtectionModeMgr:active()
	return
end

EyeProtectionModeMgr.instance = EyeProtectionModeMgr.New()

return EyeProtectionModeMgr
