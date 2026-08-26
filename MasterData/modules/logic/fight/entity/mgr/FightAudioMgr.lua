-- chunkname: @modules/logic/fight/entity/mgr/FightAudioMgr.lua

module("modules.logic.fight.entity.mgr.FightAudioMgr", package.seeall)

local FightAudioMgr = class("FightAudioMgr")

function FightAudioMgr:init()
	self._str2Id = {}
	self._cardAudio = {}
	self._fightAudio = {}
	self._fightAudioStartTime = {}
	self._fightAudio2LangDict = {}
	self._playingBnk2Lang = {}
	self._playingBnk2AudioIds = {}
end

function FightAudioMgr:dispose()
	self:clearCardAudio()
	self:stopAllFightAudio()
end

function FightAudioMgr:onDirectPlayAudio(audioId)
	if audioId then
		self._fightAudioStartTime[audioId] = Time.time
	end
end

function FightAudioMgr:playAudio(audioId)
	if not audioId or audioId <= 0 then
		return
	end

	local now = Time.time
	local lastTime = self._fightAudioStartTime[audioId]

	self._fightAudioStartTime[audioId] = now

	local isPlaying = AudioEffectMgr.instance:isPlaying(audioId)

	if isPlaying and lastTime and now - lastTime < 0.01 then
		return
	end

	local audioCfg = AudioConfig.instance:getAudioCOById(audioId)

	if audioCfg then
		local bnkName = audioCfg.bankName
		local defaultLang = GameConfig:GetCurVoiceShortcut()

		if self._playingBnk2Lang[bnkName] and self._playingBnk2Lang[bnkName] ~= defaultLang then
			local sameBnkAudioIds = self._playingBnk2AudioIds[bnkName]

			if sameBnkAudioIds then
				for i, id in ipairs(sameBnkAudioIds) do
					AudioEffectMgr.instance:stopAudio(id)
				end

				self._playingBnk2AudioIds[bnkName] = {}
			end
		end

		self._playingBnk2Lang[bnkName] = defaultLang
		self._playingBnk2AudioIds[bnkName] = self._playingBnk2AudioIds[bnkName] or {}

		table.insert(self._playingBnk2AudioIds[bnkName], audioId)
	end

	if isPlaying then
		AudioEffectMgr.instance:stopAudio(audioId)
	end

	AudioEffectMgr.instance:playAudio(audioId)

	if not tabletool.indexOf(self._fightAudio, audioId) then
		table.insert(self._fightAudio, audioId)
	end
end

function FightAudioMgr:playAudioWithLang(audioId, audioLang)
	if not audioLang then
		self:playAudio(audioId)

		return
	end

	if not audioId or audioId <= 0 then
		return
	end

	local now = Time.time
	local lastTime = self._fightAudioStartTime[audioId]

	self._fightAudioStartTime[audioId] = now

	local isPlaying = AudioEffectMgr.instance:isPlaying(audioId)

	if isPlaying and lastTime and now - lastTime < 0.01 then
		return
	end

	local audioCfg = AudioConfig.instance:getAudioCOById(audioId)

	if audioCfg then
		local bnkName = audioCfg.bankName

		if self._playingBnk2Lang[bnkName] then
			local isOtherLangBnkPlaying = self._playingBnk2Lang[bnkName] ~= audioLang

			if isOtherLangBnkPlaying then
				local sameBnkAudioIds = self._playingBnk2AudioIds[bnkName]

				if sameBnkAudioIds then
					for i, id in ipairs(sameBnkAudioIds) do
						AudioEffectMgr.instance:stopAudio(id)
					end

					self._playingBnk2AudioIds[bnkName] = {}
				end
			end

			self._playingBnk2Lang[bnkName] = audioLang
			self._playingBnk2AudioIds[bnkName] = self._playingBnk2AudioIds[bnkName] or {}

			table.insert(self._playingBnk2AudioIds[bnkName], audioId)

			if isPlaying and self._fightAudio2LangDict[audioId] and self._fightAudio2LangDict[audioId] ~= audioLang then
				AudioEffectMgr.instance:stopAudio(audioId)
			end

			self._fightAudio2LangDict[audioId] = audioLang
		end
	end

	if isPlaying then
		AudioEffectMgr.instance:stopAudio(audioId)
	end

	AudioEffectMgr.instance:playAudio(audioId, nil, audioLang)

	if not tabletool.indexOf(self._fightAudio, audioId) then
		table.insert(self._fightAudio, audioId)
	end
end

function FightAudioMgr:stopAudio(audioId)
	if audioId and audioId > 0 then
		tabletool.removeValue(self._fightAudio, audioId)
		AudioEffectMgr.instance:stopAudio(audioId, 0)
	end
end

function FightAudioMgr:playCardAudio(entityId, audioId, heroId)
	self:stopCardAudio(entityId)

	self._cardAudio[entityId] = audioId

	local audioLang

	if heroId then
		local charVoiceLangId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)
		local charVoiceLang = LangSettings.shortcutTab[charVoiceLangId]

		if not string.nilorempty(charVoiceLang) and not usingDefaultLang then
			audioLang = charVoiceLang
		end
	end

	AudioEffectMgr.instance:playAudio(audioId, nil, audioLang)

	local switchGroup = AudioMgr.instance:getIdFromString("card_voc")
	local switchState = AudioMgr.instance:getIdFromString("fightingvoc")

	AudioEffectMgr.instance:setSwitch(audioId, switchGroup, switchState)
end

function FightAudioMgr:stopAllFightAudio()
	if not self._fightAudio then
		return
	end

	for _, audioId in ipairs(self._fightAudio) do
		AudioEffectMgr.instance:stopAudio(audioId)
	end

	self._fightAudio = {}
end

function FightAudioMgr:stopAllCardAudio()
	if not self._cardAudio then
		return
	end

	for k, audioId in pairs(self._cardAudio) do
		AudioEffectMgr.instance:stopAudio(audioId)
	end
end

function FightAudioMgr:clearCardAudio()
	self._cardAudio = {}
end

function FightAudioMgr:stopCardAudio(entityId)
	local audioId = self._cardAudio[entityId]

	if audioId then
		AudioEffectMgr.instance:stopAudio(audioId)
	end
end

function FightAudioMgr:playHeroVoiceRandom(heroId, voiceType)
	local id = self:getHeroVoiceRandom(heroId, voiceType)

	if id then
		local audioLang

		if heroId then
			local charVoiceLangId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)
			local charVoiceLang = LangSettings.shortcutTab[charVoiceLangId]

			if not string.nilorempty(charVoiceLang) and not usingDefaultLang then
				audioLang = charVoiceLang
			end
		end

		self:playAudioWithLang(id, audioLang)
	end
end

function FightAudioMgr:getHeroVoiceRandom(heroId, voiceType, entityId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)
	local voiceCOs = self:_getHeroVoiceCOs(heroId, voiceType, entityMO and entityMO.skin)

	if not voiceCOs or #voiceCOs == 0 then
		return
	end

	local num = #voiceCOs

	if num == 1 then
		local voiceCO = voiceCOs[num]

		return voiceCO.audio
	end

	while true do
		local voiceCO = voiceCOs[math.random(num)]

		if not entityId or voiceCO.audio ~= self._cardAudio[entityId] then
			return voiceCO.audio
		end
	end
end

function FightAudioMgr:playHitVoice(heroId, targetLang)
	local voiceType = CharacterEnum.VoiceType.FightBehit
	local audioId = self:getHeroVoiceWithWeight(heroId, voiceType)

	if audioId then
		self:playAudioWithLang(audioId, targetLang)

		local switchGroup = AudioMgr.instance:getIdFromString("Hitvoc")
		local switchState = AudioMgr.instance:getIdFromString("commbatuihitvoc")

		AudioEffectMgr.instance:setSwitch(audioId, switchGroup, switchState)
	end
end

function FightAudioMgr:getHeroVoiceWithWeight(heroId, voiceType)
	local voiceCOs = self:_getHeroVoiceCOs(heroId, voiceType)

	if voiceCOs and #voiceCOs > 0 then
		local totalWeight = 0

		for i, voiceCO in ipairs(voiceCOs) do
			totalWeight = totalWeight + (tonumber(voiceCO.param) or 0)
		end

		local random = math.random()
		local accumulate = 0

		for i, voiceCO in ipairs(voiceCOs) do
			accumulate = accumulate + (tonumber(voiceCO.param) or 0)

			if random <= accumulate / totalWeight then
				return voiceCO.audio
			end
		end
	end
end

function FightAudioMgr:_getHeroVoiceCOs(heroId, voiceType, targetSkinId)
	if CharacterDataConfig.instance:getCharacterVoicesCo(heroId) then
		if HeroModel.instance:getByHeroId(heroId) then
			return HeroModel.instance:getVoiceConfig(heroId, voiceType, nil, targetSkinId)
		else
			return CharacterDataConfig.instance:getCharacterTypeVoicesCO(heroId, voiceType, targetSkinId)
		end
	else
		local config = lua_monster.configDict[heroId]

		if config then
			local skin_config = FightConfig.instance:getSkinCO(config.skinId)

			if skin_config then
				return CharacterDataConfig.instance:getCharacterTypeVoicesCO(skin_config.characterId, voiceType, config.skinId)
			end
		end
	end
end

function FightAudioMgr:playHit(audioId, skinId, isCrit)
	local skinCO = FightConfig.instance:getSkinCO(skinId)

	if skinCO then
		local hitId = isCrit and 2 or 1
		local matId = skinCO.matId

		AudioMgr.instance:setSwitch(self:getId(FightEnum.HitStatusGroupName), self:getId(FightEnum.HitStatusArr[hitId]))
		AudioMgr.instance:setSwitch(self:getId(FightEnum.HitMaterialGroupName), self:getId(FightEnum.HitMaterialArr[matId]))
		AudioMgr.instance:trigger(audioId)
	end
end

function FightAudioMgr:playHitByAtkAudioId(atkAudioId, skinId, isCrit)
	if not atkAudioId then
		return
	end

	local atkAudioCO = lua_fight_audio.configDict[atkAudioId]
	local skinCO = FightConfig.instance:getSkinCO(skinId)

	if atkAudioCO and skinCO then
		local weaponId = tonumber(atkAudioCO.weapon) or 0

		if weaponId == 99 then
			return
		end

		if not FightEnum.WeaponHitSwitchNames[weaponId] then
			local weaponName = ""
			local hitId = isCrit and 2 or 1
			local matId = skinCO.matId

			AudioMgr.instance:setSwitch(self:getId(FightEnum.HitStatusGroupName), self:getId(FightEnum.HitStatusArr[hitId]))
			AudioMgr.instance:setSwitch(self:getId(FightEnum.HitMaterialGroupName), self:getId(FightEnum.HitMaterialArr[matId]))
			AudioMgr.instance:setSwitch(self:getId(FightEnum.WeaponHitSwitchGroup), self:getId(weaponName))
			AudioMgr.instance:trigger(FightEnum.UniformDefAudioId)
		end
	end
end

function FightAudioMgr:setSwitch(switchStr)
	AudioMgr.instance:setSwitch(self:getId(FightEnum.AudioSwitchGroup), self:getId(switchStr))
end

function FightAudioMgr:getId(str)
	local id = self._str2Id[str]

	if not id then
		id = AudioMgr.instance:getIdFromString(str)
		self._str2Id[str] = id
	end

	return id
end

function FightAudioMgr:obscureBgm(state)
	self.mainObscureCount = self.mainObscureCount or 0

	local stateCount = state and 1 or -1

	self.mainObscureCount = self.mainObscureCount + stateCount

	if not state and self.mainObscureCount ~= 0 then
		return
	end

	if state and self.mainObscureCount ~= 1 then
		return
	end

	if GameSceneMgr.instance:isFightScene() then
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("main_obscure"), AudioMgr.instance:getIdFromString(state and "yes" or "no"))
	end
end

FightAudioMgr.instance = FightAudioMgr.New()

return FightAudioMgr
