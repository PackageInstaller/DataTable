-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/config/PigraiseConfig.lua

module("logic.extensions.pigraise.config.PigraiseConfig", package.seeall)

local PigraiseConfig = class("PigraiseConfig", BaseConfig)

function PigraiseConfig:onInit()
	self._maxMoodVal = 100
	self._maxEnergyVal = 100
	self._moodDecInterval = 1800
	self._energyDecInterval = 600
	self._feedbackEventTimes = nil
	self._adventurePrizeCount = 60
	self._adventurePrizeInterval = 600
	self._feedCostItem = nil
	self._feedIncIntimacy = 100
	self._feedIncEnergy = 5
	self._touchDailyCount = 5
	self._touchCD = 900
	self._touchIncIntimacy = 200
	self._touchIncMood = 10
	self._renameCostItem = nil
	self._defineCfg = nil
	self._levelCfg = nil
	self._interactiveCfg = nil
	self._feedbackCfg = nil
	self._dialogueCfg = nil
	self._adventureCfg = nil
	self._modelinfoMap = nil
	self._animalSellCfgs = nil
end

function PigraiseConfig:getNames()
	return {
		"animals_params",
		"animals_define",
		"animals_level",
		"animals_interactive_event",
		"animals_feedback_event",
		"animals_dialogue",
		"animals_pig_adventure",
		"animals_modelinfo",
		"animals_sell"
	}
end

function PigraiseConfig:handleConfig(name, content)
	if name == "animals_params" then
		if content.MAX_MOOD_VAL then
			self._maxMoodVal = tonumber(content.MAX_MOOD_VAL.value)
		end

		if content.MAX_ENERGY_VAL then
			self._maxEnergyVal = tonumber(content.MAX_ENERGY_VAL.value)
		end

		if content.MOOD_DEC_INTERVAL then
			self._moodDecInterval = tonumber(content.MOOD_DEC_INTERVAL.value)
		end

		if content.ENERGY_DEC_INTERVAL then
			self._energyDecInterval = tonumber(content.ENERGY_DEC_INTERVAL.value)
		end

		if content.FEED_BACK_EVENT_TIMES then
			self._feedBackHours = {}

			local feedbackTimesCfgs = string.split(content.FEED_BACK_EVENT_TIMES.value, "|")

			for i = 1, #feedbackTimesCfgs do
				local timeStrs = string.split(feedbackTimesCfgs[i], ":")

				if not string.nilorempty(timeStrs[1]) then
					table.insert(self._feedBackHours, checkint(timeStrs[1]))
				end
			end
		end

		if content.ADVENTURE_PRIZE_COUNT then
			self._adventurePrizeCount = tonumber(content.ADVENTURE_PRIZE_COUNT.value)
		end

		if content.ADVENTURE_PRIZE_INTERVAL then
			self._adventurePrizeInterval = tonumber(content.ADVENTURE_PRIZE_INTERVAL.value)
		end

		if content.FEED_COST_ITEM then
			self._feedCostItem = tostring(content.FEED_COST_ITEM.value)
		end

		if content.RENAME_ITEM then
			self._renameCostItem = tostring(content.RENAME_ITEM.value)
		end

		if content.FEED_INC_INTIMACY then
			self._feedIncIntimacy = tonumber(content.FEED_INC_INTIMACY.value)
		end

		if content.FEED_INC_ENERGY then
			self._feedIncEnergy = tonumber(content.FEED_INC_ENERGY.value)
		end

		if content.TOUCH_DAILY_COUNT then
			self._touchDailyCount = tonumber(content.TOUCH_DAILY_COUNT.value)
		end

		if content.TOUCH_CD then
			self._touchCD = tonumber(content.TOUCH_CD.value)
		end

		if content.TOUCH_INC_INTIMACY then
			self._touchIncIntimacy = tonumber(content.TOUCH_INC_INTIMACY.value)
		end

		if content.TOUCH_INC_MOOD then
			self._touchIncMood = tonumber(content.TOUCH_INC_MOOD.value)
		end

		if content.PET_INFO then
			self._petInfo = tonumber(content.PET_INFO.value)
		end
	elseif name == "animals_define" then
		self._defineCfg = content.dataList
	elseif name == "animals_level" then
		self._levelCfg = {}

		for _, v in ipairs(content.dataList) do
			self._levelCfg[v.defineId] = self._levelCfg[v.defineId] or {}
			self._levelCfg[v.defineId][v.level] = v
		end
	elseif name == "animals_interactive_event" then
		self._interactiveCfg = content
	elseif name == "animals_feedback_event" then
		self._feedbackCfg = content
	elseif name == "animals_dialogue" then
		self._dialogueCfg = content
	elseif name == "animals_pig_adventure" then
		self._adventureCfg = content
	elseif name == "animals_modelinfo" then
		self._modelinfoMap = {}

		for _, v in ipairs(content.dataList) do
			self._modelinfoMap[v.petId] = self._modelinfoMap[v.petId] or {}
			self._modelinfoMap[v.petId][v.type] = self._modelinfoMap[v.petId][v.type] or {}
			self._modelinfoMap[v.petId][v.type][v.resId] = v
		end
	elseif name == "animals_sell" then
		self._animalSellCfgs = content
	end
end

function PigraiseConfig:getMaxMoodVal()
	return self._maxMoodVal or 100
end

function PigraiseConfig:getMaxEnergyVal()
	return self._maxEnergyVal or 100
end

function PigraiseConfig:getMoodDecInterval()
	return self._moodDecInterval or 1800
end

function PigraiseConfig:getEnergyDecInterval()
	return self._energyDecInterval or 600
end

function PigraiseConfig:getFeedbackEventHours()
	return self._feedBackHours or {}
end

function PigraiseConfig:getAdventurePrizeCount()
	return self._adventurePrizeCount or 60
end

function PigraiseConfig:getAdventurePrizeInterval()
	return self._adventurePrizeInterval or 600
end

function PigraiseConfig:getAdventureTotalTime()
	return self:getAdventurePrizeCount() * self:getAdventurePrizeInterval()
end

function PigraiseConfig:getFeedCostItem()
	return self._feedCostItem or "4:35:1"
end

function PigraiseConfig:getFeedIncIntimacy()
	return self._feedIncIntimacy or 100
end

function PigraiseConfig:getFeedIncEnergy()
	return self._feedIncEnergy or 5
end

function PigraiseConfig:getTouchDailyCount()
	return self._touchDailyCount or 5
end

function PigraiseConfig:getTouchCD()
	return self._touchCD or 900
end

function PigraiseConfig:getTouchIncIntimacy()
	return self._touchIncIntimacy or 200
end

function PigraiseConfig:getTouchIncMood()
	return self._touchIncMood or 10
end

function PigraiseConfig:getRenameCost()
	return self._renameCostItem or "8:1:5000"
end

function PigraiseConfig:getAllPetCfgs()
	return self._defineCfg
end

function PigraiseConfig:getPetCfgById(petId)
	if not petId or not self._defineCfg or not self._defineCfg[petId] then
		printError("pet Define Is nil Cfg")
	end

	return self._defineCfg[petId]
end

function PigraiseConfig:getLevelCfg(defineId)
	return self._levelCfg[defineId]
end

function PigraiseConfig:getLevelCfgById(defineId, level)
	if defineId == nil or self._levelCfg == nil then
		return
	end

	return self._levelCfg[defineId][level]
end

function PigraiseConfig:getMaxLevel(defineId)
	local cfgs = self:getLevelCfg(defineId)

	return #cfgs
end

function PigraiseConfig:getInteractiveCfgById(defineId)
	if defineId == nil or self._interactiveCfg == nil then
		return
	end

	return self._interactiveCfg[defineId]
end

function PigraiseConfig:getFeedbackCfgById(defineId)
	if defineId == nil or self._feedbackCfg == nil then
		return
	end

	return self._feedbackCfg[defineId]
end

function PigraiseConfig:getAdventureCfgById(defineId)
	if defineId == nil or self._adventureCfg == nil then
		return
	end

	return self._adventureCfg[defineId]
end

function PigraiseConfig:getModelinfoCfgById(petId, typeId, resId)
	if self._modelinfoMap then
		if petId and self._modelinfoMap[petId] then
			if typeId then
				if resId and self._modelinfoMap[petId][typeId] then
					return self._modelinfoMap[petId][typeId][resId]
				else
					return self._modelinfoMap[petId][typeId]
				end
			else
				return self._modelinfoMap[petId]
			end
		else
			return nil
		end
	end
end

function PigraiseConfig:getDialogueCfgById(defineId)
	if defineId == nil or self._dialogueCfg == nil then
		return
	end

	return self._dialogueCfg[defineId]
end

function PigraiseConfig:getDialogueHashTableById(dialogueId)
	if dialogueId == nil or self._dialogueCfg == nil then
		return
	end

	local hashTable = {}

	for _, cfg in pairs(self._dialogueCfg) do
		if cfg.id and dialogueId == checkint(cfg.dialogueId) then
			local keyTable = table.keys(hashTable)

			if table.indexof(keyTable, cfg.id) then
				print("哈希表出现重复键：" .. cfg.id)

				return nil
			else
				hashTable[cfg.id] = checkint(cfg.weight)
			end
		end
	end

	return hashTable
end

function PigraiseConfig:getAnimalSellCfgs(funcId)
	if funcId then
		return self._animalSellCfgs[checkint(funcId)]
	else
		return self._animalSellCfgs.dataList
	end
end

PigraiseConfig.instance = PigraiseConfig.New()

return PigraiseConfig
