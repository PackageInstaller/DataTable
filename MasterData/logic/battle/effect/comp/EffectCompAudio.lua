-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/EffectCompAudio.lua

module("logic.battle.effect.comp.EffectCompAudio", package.seeall)

local EffectCompAudio = class("EffectCompAudio", IEffectComp)

function EffectCompAudio:onInit()
	self._audioName = false
	self._unit = false
	self._effectCO = false
end

function EffectCompAudio:setEffectAudioName(effectCO, unit)
	self._effectCode = effectCO and effectCO.code or 0
	self._audioName = effectCO and effectCO.audioName or ""
	self._unit = unit
end

function EffectCompAudio:setSEName(seName, unit)
	self._effectCode = 0
	self._audioName = seName
	self._unit = unit
end

function EffectCompAudio:onResourceLoaded()
	self:onPlayEffectSE()
end

function EffectCompAudio:onReset()
	self:onStopEffectSE()
	self:clear()
end

function EffectCompAudio:onDestroy()
	self:onStopEffectSE()
	self:clear()
end

function EffectCompAudio:onPlayEffectSE()
	if self._audioName and not string.nilorempty(self._audioName) and self._unit then
		if BattleLog.enableLog then
			BattleLog.log("Battle Effect Play SE", self._effectCode, self._audioName)
		end

		CriwareAudioFacade.instance:playSEByName(self._audioName, self._unit.mainGO)
	end
end

function EffectCompAudio:onStopEffectSE()
	if self._audioName and not string.nilorempty(self._audioName) then
		local audioCO = CriwareAudioConfig.instance:getCOByName(self._audioName)

		if audioCO then
			local seId = audioCO.code

			CriwareAudioPlayer.instance:stopSoundById(seId)

			if BattleLog.enableLog then
				BattleLog.log("Battle Effect Stop SE", self._effectCode, self._audioName, seId)
			end
		end
	end
end

function EffectCompAudio:clear()
	self._audioName = false
	self._unit = false
	self._effectCO = false
end

return EffectCompAudio
