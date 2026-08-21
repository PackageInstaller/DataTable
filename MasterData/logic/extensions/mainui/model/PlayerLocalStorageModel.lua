-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/model/PlayerLocalStorageModel.lua

module("logic.extensions.mainui.model.PlayerLocalStorageModel", package.seeall)

local M = class("PlayerLocalStorageModel")
local kFrameBackup = "FrameBackup"
local kSoundMainSwitch = "SoundMainSwitch"
local kBgmVolume = "BgmVolume"
local kSoundEffVolume = "SoundEffVolume"
local kDubVolume = "DubVolume"
local kBgmVolumeHistory = "BgmVolumeHistory"
local kSoundEffVolumeHistory = "SoundEffVolumeHistory"
local kDubVolumeHistory = "DubVolumeHistory"
local kPowerSavingSwitch = "PowerSavingSwitch"
local kOpenHdr = "OpenHdr"
local kAntialiasingQuality = "AntialiasingQuality"
local kAntialiasingSwitch = "AntialiasingSwitch"
local kGraphicsSettingQuality = "GraphicsSettingQuality"
local kGraphicsQualityLevel = "GraphicsQualityLevel"
local kResolutionRatioQuality = "ResolutionRatioQuality"
local kEffectQuality = "EffectQuality100"
local kGameFrame = "GameFrame"
local kSpecialShapedScreenAdaptation = "SpecialShapedScreenAdaptation"
local kBattleAnimationQuality = "BattleAnimationQuality"
local kAutoEnd = "AutoEnd"
local kClickEnsure = "ClickEnsure"
local kDoubleClickStandby = "DoubleClickStandby"
local kAutoShowDangerous = "AutoShowDangerous"
local kTargetPrediction = "TargetPrediction"
local kSimpleSkillCast = "SimpleSkillCast"
local kSpeedAdjust = "SpeedAdjust"
local kNoneTarget = "NoneTarget"
local kLotteryNewFlag = "lottery_card_new_flag"
local kBattleShake = "BattleShake"
local kPlayListKey = "RetrievePlayListKey"
local kToPlayListKey = "RetrieveToPlayListKey"
local LocalStorageIns = Astral.LocalStorage.Instance

function M:getStoreKey(key, distinguishPlayer)
	if distinguishPlayer then
		return key .. PlayerModel.instance:getId()
	end

	return key
end

function M:getSoundMainSwitch()
	local key = self:getStoreKey(kSoundMainSwitch)
	local i = LocalStorageIns:GetInt(key, 1)

	return i == 1
end

function M:setSoundMainSwitch(isOn)
	local key = self:getStoreKey(kSoundMainSwitch)

	LocalStorageIns:SetInt(key, isOn and 1 or 0)
end

function M:getBgmVolume()
	local key = self:getStoreKey(kBgmVolume)

	return LocalStorageIns:GetFloat(key, 1)
end

function M:setBgmVolume(value)
	local key = self:getStoreKey(kBgmVolume)

	LocalStorageIns:SetFloat(key, value)

	if value > 0 then
		self:setBgmVolumeHistory(value)
	end
end

function M:getBgmVolumeHistory()
	local key = self:getStoreKey(kBgmVolumeHistory)

	return LocalStorageIns:GetFloat(key, 1)
end

function M:setBgmVolumeHistory(value)
	local key = self:getStoreKey(kBgmVolumeHistory)

	LocalStorageIns:SetFloat(key, value)
end

function M:getSoundEffVolume()
	local key = self:getStoreKey(kSoundEffVolume)

	return LocalStorageIns:GetFloat(key, 1)
end

function M:setSoundEffVolume(value)
	local key = self:getStoreKey(kSoundEffVolume)

	LocalStorageIns:SetFloat(key, value)

	if value > 0 then
		self:setSoundEffVolumeHistory(value)
	end
end

function M:getSoundEffVolumeHistory()
	local key = self:getStoreKey(kSoundEffVolumeHistory)

	return LocalStorageIns:GetFloat(key, 1)
end

function M:setSoundEffVolumeHistory(value)
	local key = self:getStoreKey(kSoundEffVolumeHistory)

	LocalStorageIns:SetFloat(key, value)
end

function M:getDubVolume()
	local key = self:getStoreKey(kDubVolume)

	return LocalStorageIns:GetFloat(key, 1)
end

function M:setDubVolume(value)
	local key = self:getStoreKey(kDubVolume)

	LocalStorageIns:SetFloat(key, value)

	if value > 0 then
		self:setDubVolumeHistory(value)
	end
end

function M:getDubVolumeHistory()
	local key = self:getStoreKey(kDubVolumeHistory)

	return LocalStorageIns:GetFloat(key, 1)
end

function M:setDubVolumeHistory(value)
	local key = self:getStoreKey(kDubVolumeHistory)

	LocalStorageIns:SetFloat(key, value)
end

function M:getPowerSavingSwitch()
	local key = self:getStoreKey(kPowerSavingSwitch)
	local i = LocalStorageIns:GetInt(key, 0)

	return i == 1
end

function M:setPowerSavingSwitch(isOn)
	local key = self:getStoreKey(kPowerSavingSwitch)

	LocalStorageIns:SetInt(key, isOn and 1 or 0)
end

function M:getOpenHdr()
	local key = self:getStoreKey(kOpenHdr)
	local i = LocalStorageIns:GetInt(key, 0)

	return i == 1
end

function M:setOpenHdr(isOn)
	local key = self:getStoreKey(kOpenHdr)

	LocalStorageIns:SetInt(key, isOn and 1 or 0)
end

function M:getAntialiasingQuality()
	local key = self:getStoreKey(kAntialiasingQuality)

	return LocalStorageIns:GetInt(key, -1)
end

function M:setAntialiasingQuality(value)
	local key = self:getStoreKey(kAntialiasingQuality)

	LocalStorageIns:SetInt(key, value)
end

function M:getAntialiasingSwitch()
	local key = self:getStoreKey(kAntialiasingSwitch)

	return LocalStorageIns:GetInt(key, 0) == 1
end

function M:setAntialiasingSwitch(isOn)
	local key = self:getStoreKey(kAntialiasingSwitch)

	LocalStorageIns:SetInt(key, isOn and 1 or 0)
end

function M:getGraphicsQualityLevel()
	local key = self:getStoreKey(kGraphicsQualityLevel)

	return LocalStorageIns:GetInt(key, -1)
end

function M:setGraphicsQualityLevel(value)
	local key = self:getStoreKey(kGraphicsQualityLevel)

	LocalStorageIns:SetInt(key, value)
end

function M:getGraphicsSettingQuality()
	local key = self:getStoreKey(kGraphicsSettingQuality)

	return LocalStorageIns:GetInt(key, -1)
end

function M:setGraphicsSettingQuality(value)
	local key = self:getStoreKey(kGraphicsSettingQuality)

	LocalStorageIns:SetInt(key, value)
end

function M:getResolutionRatioQuality()
	local key = self:getStoreKey(kResolutionRatioQuality)

	return LocalStorageIns:GetInt(key, -1)
end

function M:setResolutionRatioQuality(value)
	local key = self:getStoreKey(kResolutionRatioQuality)

	LocalStorageIns:SetInt(key, value)
end

function M:getEffectQuality()
	local key = self:getStoreKey(kEffectQuality)

	return LocalStorageIns:GetInt(key, 2)
end

function M:setEffectQuality(value)
	local key = self:getStoreKey(kEffectQuality)

	LocalStorageIns:SetInt(key, value)
end

function M:getGameFrame()
	local key = self:getStoreKey(kGameFrame)

	return LocalStorageIns:GetInt(key, -1)
end

function M:setGameFrame(value)
	local key = self:getStoreKey(kGameFrame)

	LocalStorageIns:SetInt(key, value)
end

function M:saveLastFrameSetting()
	LocalStorageIns:SetInt(kGraphicsSettingQuality .. kFrameBackup, self:getGraphicsSettingQuality())
	LocalStorageIns:SetInt(kGraphicsQualityLevel .. kFrameBackup, self:getGraphicsQualityLevel())
	LocalStorageIns:SetInt(kResolutionRatioQuality .. kFrameBackup, self:getResolutionRatioQuality())
	LocalStorageIns:SetInt(kEffectQuality .. kFrameBackup, self:getEffectQuality())
	LocalStorageIns:SetInt(kGameFrame .. kFrameBackup, self:getGameFrame())
	LocalStorageIns:SetInt(kOpenHdr .. kFrameBackup, self:getOpenHdr() and 1 or 0)
	LocalStorageIns:SetInt(kAntialiasingSwitch .. kFrameBackup, self:getAntialiasingSwitch() and 1 or 0)
end

function M:getLastFrameSetting()
	local v1 = LocalStorageIns:GetInt(kGraphicsSettingQuality .. kFrameBackup)
	local v2 = LocalStorageIns:GetInt(kGraphicsQualityLevel .. kFrameBackup)
	local v3 = LocalStorageIns:GetInt(kResolutionRatioQuality .. kFrameBackup)
	local v4 = LocalStorageIns:GetInt(kEffectQuality .. kFrameBackup)
	local v5 = LocalStorageIns:GetInt(kGameFrame .. kFrameBackup)
	local v6 = LocalStorageIns:GetInt(kOpenHdr .. kFrameBackup)
	local v7 = LocalStorageIns:GetInt(kAntialiasingSwitch .. kFrameBackup)

	return v1, v2, v3, v4, v5, v6, v7
end

function M:getSpecialShapedScreenAdaptation()
	local key = self:getStoreKey(kSpecialShapedScreenAdaptation)

	return LocalStorageIns:GetFloat(key, 1)
end

function M:setSpecialShapedScreenAdaptation(value)
	local key = self:getStoreKey(kSpecialShapedScreenAdaptation)

	LocalStorageInse:SetFloat(key, value)
end

function M:getBattleAnimationQuality()
	local key = self:getStoreKey(kBattleAnimationQuality, true)

	return LocalStorageIns:GetInt(key, 1)
end

function M:setBattleAnimationQuality(value)
	local key = self:getStoreKey(kBattleAnimationQuality, true)

	LocalStorageIns:SetInt(key, value)
end

function M:getAutoEnd()
	local key = self:getStoreKey(kAutoEnd, true)

	return LocalStorageIns:GetInt(key, 1) == 1
end

function M:setAutoEnd(isOn)
	local key = self:getStoreKey(kAutoEnd, true)
	local value = isOn and 1 or 0

	LocalStorageIns:SetInt(key, value)
end

function M:getClickEnsure()
	local key = self:getStoreKey(kClickEnsure, true)

	return LocalStorageIns:GetInt(key, 0) == 1
end

function M:setClickEnsure(isOn)
	local key = self:getStoreKey(kClickEnsure, true)
	local value = isOn and 1 or 0

	LocalStorageIns:SetInt(key, value)
end

function M:getDoubleClickStandby()
	local key = self:getStoreKey(kDoubleClickStandby, true)

	return LocalStorageIns:GetInt(key, 0) == 1
end

function M:setDoubleClickStandby(isOn)
	local key = self:getStoreKey(kDoubleClickStandby, true)
	local value = isOn and 1 or 0

	LocalStorageIns:SetInt(key, value)
end

function M:getAutoShowDangerous()
	local key = self:getStoreKey(kAutoShowDangerous, true)

	return LocalStorageIns:GetInt(key, 0) == 1
end

function M:setAutoShowDangerous(isOn)
	local key = self:getStoreKey(kAutoShowDangerous, true)
	local value = isOn and 1 or 0

	LocalStorageIns:SetInt(key, value)
end

function M:getTargetPrediction()
	local key = self:getStoreKey(kTargetPrediction, true)

	return LocalStorageIns:GetInt(key, 1) == 1
end

function M:setTargetPrediction(isOn)
	local key = self:getStoreKey(kTargetPrediction, true)
	local value = isOn and 1 or 0

	LocalStorageIns:SetInt(key, value)
end

function M:getSimpleSkillCast()
	local key = self:getStoreKey(kSimpleSkillCast, true)

	return LocalStorageIns:GetInt(key, 1) == 1
end

function M:setSimpleSkillCast(isOn)
	local key = self:getStoreKey(kSimpleSkillCast, true)
	local value = isOn and 1 or 0

	LocalStorageIns:SetInt(key, value)
end

function M:getNoneTarget()
	local key = self:getStoreKey(kNoneTarget, true)

	return LocalStorageIns:GetInt(key, 1) == 1
end

function M:setNoneTarget(isOn)
	local key = self:getStoreKey(kNoneTarget, true)
	local value = isOn and 1 or 0

	LocalStorageIns:SetInt(key, value)
end

function M:getSpeedAdjust()
	local key = self:getStoreKey(kSpeedAdjust, true)

	return LocalStorageIns:GetFloat(key, 1)
end

function M:setSpeedAdjust(value)
	local key = self:getStoreKey(kSpeedAdjust, true)

	LocalStorageIns:SetFloat(key, value)
end

function M:setPoolNewFlag(poolCode, isNew)
	local targetKey = string.format("%s_%s", poolCode, kLotteryNewFlag)
	local key = self:getStoreKey(targetKey, true)
	local value = isNew and 1 or 0

	LocalStorageIns:SetInt(key, value)
end

function M:getPoolNewFlag(poolCode)
	local targetKey = string.format("%s_%s", poolCode, kLotteryNewFlag)
	local key = self:getStoreKey(targetKey, true)

	return LocalStorageIns:GetInt(key, 1) == 1
end

function M:getShakeEnable()
	local key = self:getStoreKey(kBattleShake, true)

	return LocalStorageIns:GetInt(key, 1) == 1
end

function M:setShakeEnable(isOn)
	local key = self:getStoreKey(kBattleShake, true)
	local value = isOn and 1 or 0

	LocalStorageIns:SetInt(key, value)
end

function M:getRetrievePlayList()
	local key = self:getStoreKey(kPlayListKey, true)

	return LocalStorageIns:GetString(key)
end

function M:setRetrievePlayList(playListStr)
	local key = self:getStoreKey(kPlayListKey, true)

	LocalStorageIns:SetString(key, playListStr)
end

function M:getRetrieveToPlayList()
	local key = self:getStoreKey(kToPlayListKey, true)

	return LocalStorageIns:GetString(key)
end

function M:setRetrieveToPlayList(playListStr)
	local key = self:getStoreKey(kToPlayListKey, true)

	LocalStorageIns:SetString(key, playListStr)
end

M.instance = M.New()

return M
