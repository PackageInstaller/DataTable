-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/config/CharacterUnlockContentConfig.lua

module("logic.extensions.charactersystem.config.CharacterUnlockContentConfig", package.seeall)

local M = class("CharacterUnlockContentConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.CharacterUnlockContent,
		ConfigName.CharacterCarryItem
	}
end

function M:onInit()
	self._cfgTable = {}
	self._cfgCarryItem = {}
end

function M:handleConfig(name, content)
	self._cfgTable[name] = content

	if name == ConfigName.CharacterUnlockContent then
		self:initHeroUnlockData()
	elseif name == ConfigName.CharacterCarryItem then
		for k, v in pairs(content.dataList or {}) do
			if not self._cfgCarryItem[v.id] then
				self._cfgCarryItem[v.id] = {}
			end

			table.insert(self._cfgCarryItem[v.id], v)
		end
	end
end

function M:getUnlockCO(infoId)
	local list = self._cfgTable[ConfigName.CharacterUnlockContent]

	if list then
		local unlockCO = list[infoId]

		if unlockCO then
			return unlockCO
		end
	end
end

function M:getUnlockConfigData()
	local list = self._cfgTable[ConfigName.CharacterUnlockContent]

	if list then
		return list.dataList
	end
end

function M:initHeroUnlockData()
	self._heroIdAndPastIdToConfig = {}
	self._heroIdAndVoiceIdToConfig = {}
	self._heroIdToConfig = {}

	local list = self:getUnlockConfigData()

	for heroId, v in pairs(list) do
		if v.pastId > 0 then
			self._heroIdAndPastIdToConfig[v.code * 100 + v.pastId] = v
		end

		if v.voiceId > 0 then
			self._heroIdAndVoiceIdToConfig[v.code * 100 + v.voiceId] = v
		end

		if self._heroIdToConfig[v.code] then
			table.insert(self._heroIdToConfig[v.code], v)
		else
			self._heroIdToConfig[v.code] = {
				v
			}
		end
	end
end

function M:getUnlockConfigByHeroIdAndPastId(heroId, pastId)
	return self._heroIdAndPastIdToConfig[heroId * 100 + pastId]
end

function M:getUnlockConfigByHeroIdAndVoiceId(heroId, voidId)
	return self._heroIdAndVoiceIdToConfig[heroId * 100 + voidId]
end

function M:getUnlockConfigListByHeroId(heroId)
	return self._heroIdToConfig[heroId]
end

function M:getCarryItemLst(heroId)
	if self._cfgCarryItem[heroId] then
		return self._cfgCarryItem[heroId]
	end

	return {}
end

function M:getCarryItemCo(heroId, carryId)
	local lst = self:getCarryItemLst(heroId)
	local returnCfg

	for _, cfg in ipairs(lst or {}) do
		if cfg.carryId == carryId then
			returnCfg = cfg
		end
	end

	return returnCfg
end

function M:getCarryItemOnline(heroId, carryId)
	local carryItemCfg = self:getCarryItemCo(heroId, carryId)
	local online = carryItemCfg and carryItemCfg.online > 0

	return online
end

function M:getCarryItem(heroId, carryId)
	if self._cfgTable[ConfigName.CharacterCarryItem][heroId] then
		return self._cfgTable[ConfigName.CharacterCarryItem][heroId][carryId]
	end

	return nil
end

function M:getConditionLstPastId(heroId, pastId)
	local conditionLst
	local cfgUnlockSp = self:getUnlockConfigByHeroIdAndPastId(heroId, pastId)

	if cfgUnlockSp then
		conditionLst = cfgUnlockSp.condition
	else
		local cfgUniversal = PastInfoConfig.instance:getUniversallyUnlockConfig(pastId + 1000)

		if cfgUniversal then
			conditionLst = cfgUniversal.condition
		end
	end

	if pastId > 100 and pastId < 200 then
		local cfg = PastInfoConfig.instance:getCharacterInfoSpfile(heroId, pastId)

		if not cfg then
			conditionLst = nil
		end
	elseif pastId > 200 and pastId < 300 then
		local cfg = self:getCarryItem(heroId, pastId)

		if not cfg then
			conditionLst = nil
		end
	end

	return conditionLst
end

function M:getConditionLstVoice(heroId, audioId)
	local conditionLst
	local cfgUnlockSp = self:getUnlockConfigByHeroIdAndVoiceId(heroId, audioId)

	if cfgUnlockSp then
		conditionLst = cfgUnlockSp.condition
	else
		local cfgUniversal = PastInfoConfig.instance:getUniversallyUnlockConfig(audioId + 3000)

		if cfgUniversal then
			conditionLst = cfgUniversal.condition
		end
	end

	return conditionLst
end

function M:getFavorUnlockIds(heroId, curLevel, oldLevel)
	local result = {}
	local infoUnlockType = CharacterInfoEnum.UnlockTyp

	for keyStr, valInt in pairs(infoUnlockType) do
		local conditionLst = self:getConditionLstPastId(heroId, valInt)

		for _, conDef in ipairs(conditionLst or {}) do
			if conDef.type == CommEnum.ConditionType.HERO_TACIT_LV then
				local val = tonumber(conDef.value)

				if oldLevel < val and val <= curLevel then
					table.insert(result, valInt)
				end
			end
		end
	end

	local cgfList = CharacterAudioConfig.instance:getCharacterAudiosById(heroId, true) or {}

	for _, _cfg in pairs(cgfList) do
		local conditionLst = self:getConditionLstVoice(heroId, _cfg.audioId)

		for _, conDef in ipairs(conditionLst or {}) do
			if conDef.type == CommEnum.ConditionType.HERO_TACIT_LV then
				local val = tonumber(conDef.value)

				if oldLevel < val and val <= curLevel and CharacterInformationModel.instance:getIsVoiceResExist(heroId, _cfg.audioId) then
					table.insert(result, _cfg.audioId + 3000)
				end
			end
		end
	end

	return result
end

function M:getPowerLevelUnlock(heroId, powerLevel)
	local list = self:getUnlockConfigListByHeroId(heroId)

	if list then
		for _, v in pairs(list) do
			if v.condition then
				for ck, cv in pairs(v.condition) do
					if cv.type == "powerLv" then
						local level = tonumber(cv.value)

						if level == powerLevel then
							return v
						end
					end
				end
			end
		end
	end
end

function M:getExpressionIdByInfoId(infoId)
	if not infoId or infoId == 0 then
		return 1
	end

	if infoId > 2000 then
		infoId = infoId - 2000
	end

	return infoId
end

M.instance = M.New()

return M
