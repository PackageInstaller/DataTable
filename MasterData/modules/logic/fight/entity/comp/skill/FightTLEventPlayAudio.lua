-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventPlayAudio.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventPlayAudio", package.seeall)

local FightTLEventPlayAudio = class("FightTLEventPlayAudio", FightTimelineTrackItem)

function FightTLEventPlayAudio:onTrackStart(fightStepData, duration, paramsArr)
	if FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill and paramsArr[2] == "1" then
		if FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill <= 0 then
			return
		end

		FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill = FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill - 1
	end

	local audioId = tonumber(paramsArr[1])
	local entity = FightHelper.getEntity(fightStepData.fromId)

	if not entity then
		return
	end

	local entityMO = entity:getMO()

	if fightStepData.supportHeroId ~= 0 then
		if not fightStepData.supportHeroId then
			if entityMO then
				::label_1_0::

				local modelId = entityMO.modelId
				local isMySide = entity:isMySide()
				local customAudioLang

				if modelId then
					if isMySide then
						local charVoiceLangId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(modelId)

						if usingDefaultLang then
							FightAudioMgr.instance:playAudio(audioId)
						else
							local charVoiceLang = LangSettings.shortcutTab[charVoiceLangId]

							if not string.nilorempty(charVoiceLang) then
								customAudioLang = charVoiceLang
							end

							FightAudioMgr.instance:playAudioWithLang(audioId, customAudioLang)
						end
					else
						customAudioLang = GameConfig:GetCurVoiceShortcut()

						FightAudioMgr.instance:playAudioWithLang(audioId, customAudioLang)
					end
				else
					FightAudioMgr.instance:playAudio(audioId)
				end

				fightStepData.atkAudioId = audioId
				self._audioId = audioId
			end
		end
	end
end

function FightTLEventPlayAudio:skipSkill()
	FightAudioMgr.instance:stopAudio(self._audioId)
end

return FightTLEventPlayAudio
