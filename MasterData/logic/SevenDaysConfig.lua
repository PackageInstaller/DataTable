-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/config/SevenDaysConfig.lua

module("logic.extensions.sevendays.config.SevenDaysConfig", package.seeall)

local SevenDaysConfig = class("SevenDaysConfig", BaseConfig)

function SevenDaysConfig:onInit()
	SevenDaysConfig.super.onInit(self)

	self.sevenDyasTaskCfg = nil
	self.sevenDaysScoreList = nil
	self.sevenDyasPrizeCfg = nil
	self.sevenDyasTitleCfg = nil
	self.sevenDyasBaseCfg = nil
	self.commonCfg = nil
end

function SevenDaysConfig:getNames()
	return {
		"seven_day_task",
		"seven_day_task_prize",
		"seven_day_task_title",
		"seven_day_task_params"
	}
end

function SevenDaysConfig:handleConfig(name, content)
	if name == "seven_day_task" then
		self:ClassificationTaskType(content)
	elseif name == "seven_day_task_prize" then
		if content == nil or next(content) == nil then
			return
		end

		self.sevenDyasPrizeCfg = {}

		for _, info in pairs(content) do
			if info and not string.nilorempty(info.prize) then
				table.insert(self.sevenDyasPrizeCfg, {
					score = info.needScore,
					goods = info.prize
				})
			end
		end

		if #self.sevenDyasPrizeCfg > 1 then
			table.sort(self.sevenDyasPrizeCfg, function(a, b)
				return a.score < b.score
			end)
		end
	elseif name == "seven_day_task_title" then
		self.sevenDyasTitleCfg = content
	elseif name == "seven_day_task_params" then
		if self.commonCfg == nil then
			self.commonCfg = {}
		end

		if content.duration then
			self.commonCfg.maxDays = tonumber(content.duration.paramVal)
		end

		if content.PetBattleId then
			local str = string.split(content.PetBattleId.paramVal, ";")

			if str and #str > 0 then
				self.commonCfg.teamA = str[1] and tonumber(str[1]) or 127
				self.commonCfg.teamB = str[2] and tonumber(str[2]) or self.commonCfg.teamA + 1
			end
		end
	end
end

function SevenDaysConfig:ClassificationTaskType(data)
	if data == nil or next(data) == nil then
		return
	end

	self.sevenDyasTaskCfg = {}
	self.sevenDaysScoreList = {}

	for k, cfg in pairs(data) do
		if type(k) == "number" and cfg then
			local daysId = cfg.day

			self.sevenDyasTaskCfg[daysId] = self.sevenDyasTaskCfg[daysId] or {}

			table.insert(self.sevenDyasTaskCfg[daysId], cfg)

			self.sevenDaysScoreList[cfg.id] = cfg.score
		end
	end
end

function SevenDaysConfig:GetSevenDaysScoreById(baseId)
	if baseId == nil or baseId <= 0 then
		return 0
	end

	if self.sevenDaysScoreList == nil or self.sevenDaysScoreList[baseId] == nil then
		return 0
	end

	return self.sevenDaysScoreList[baseId]
end

function SevenDaysConfig:GetSevenDaysTask(dayId)
	if dayId == nil or dayId == 0 then
		return self.sevenDyasTaskCfg
	end

	if self.sevenDyasTaskCfg == nil or self.sevenDyasTaskCfg[dayId] == nil then
		return
	end

	return self.sevenDyasTaskCfg[dayId]
end

function SevenDaysConfig:GetSevenDaysPrize(index)
	if index == nil or index == 0 then
		return self.sevenDyasPrizeCfg
	end

	if self.sevenDyasPrizeCfg == nil or self.sevenDyasPrizeCfg[index] then
		return
	end

	return self.sevenDyasPrizeCfg[index]
end

function SevenDaysConfig:GetSevenDaysTitle(index)
	if index == nil or index == 0 then
		return self.sevenDyasTitleCfg
	end

	if self.sevenDyasTitleCfg == nil or self.sevenDyasTitleCfg[index] == nil then
		return "其他"
	end

	return self.sevenDyasTitleCfg[index].desc
end

function SevenDaysConfig:GetMaxSevenDaysNum()
	self.commonCfg = self.commonCfg or {}

	if self.commonCfg.maxDays == nil or self.commonCfg.maxDays < 0 then
		self.commonCfg.maxDays = 7
	end

	return self.commonCfg.maxDays
end

function SevenDaysConfig:GetPetBattleIds()
	self.commonCfg = self.commonCfg or {}

	if self.commonCfg.teamA == nil or self.commonCfg.teamA < 0 then
		self.commonCfg.teamA = 127
		self.commonCfg.teamB = 128
	end

	return self.commonCfg.teamA, self.commonCfg.teamB
end

SevenDaysConfig.instance = SevenDaysConfig.New()

return SevenDaysConfig
