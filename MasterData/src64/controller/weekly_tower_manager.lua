local var_0_0 = {}
local playermodel = require("model.playermodel")
local buff_data = require("data.buff_data")
local total_skill_data = require("data.total_skill_data")
local levelmode_data = require("data.levelmode_data")
local chapter_data = require("data.chapter_data")
local skill_pool_21_data = require("data.skill_pool_21_data")
local skill_data = require("data.skill_data")
local city_data = require("data.city_data")
local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local monster_manager = require("controller.monster_manager")
local component_manager = require("controller.component_manager")
local horcrux_manager = require("controller.horcrux_manager")
local time_check_manager = require("controller.time_check_manager")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")

var_0_0.instance = nil

function var_0_0.new(arg_1_0, ...)
	local var_1_0 = {}

	setmetatable(var_1_0, arg_1_0)

	arg_1_0.__index = arg_1_0

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.getInstance()
	var_0_0.instance = var_0_0.instance or var_0_0:new()

	return var_0_0.instance
end

function var_0_0:init(...)
	self.modeDatas = {}
	self.levelDatas = {}
	self.isEnterFight = false

	self:initModeData()
	self:initHaveTriggerGuideListInfo()
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_WEEKLY_TOWER_INFO, handler(self, self.handleGetWeeklyTowerInfo), 99)
	EventManager:subscribe(self, EventManager.EVENT_IDS.SET_WEEKLY_TOWER_SKILL, handler(self, self.handleSetWeeklyTowerSkill), 99)
end

function var_0_0:initHaveTriggerGuideListInfo()
	self.haveTriggerGuideList = {}

	for iter_4_0, iter_4_1 in pairs((string.split((RoleDefault or nil) and (RoleDefault:getInstance():getStringForKey("weeklytower") or ""), ","))) do
		self.haveTriggerGuideList[tonumber(iter_4_1)] = 1
	end
end

function var_0_0:setModeToHaveTriggerGuideList(arg_5_1)
	if self.haveTriggerGuideList[arg_5_1] == 1 then
		return
	end

	self.haveTriggerGuideList[arg_5_1] = 1

	local var_5_0 = ""

	for iter_5_0, iter_5_1 in pairs(self.haveTriggerGuideList) do
		var_5_0 = var_5_0 .. iter_5_0 .. ","
	end

	RoleDefault:getInstance():setStringForKey("weeklytower", var_5_0)
end

function var_0_0:isHaveTriggeredGuide(arg_6_1)
	return self.haveTriggerGuideList[arg_6_1] == 1
end

function var_0_0:handleGetWeeklyTowerInfo(arg_7_1)
	if not arg_7_1 then
		return
	end

	if arg_7_1 and arg_7_1.result == 1 then
		if arg_7_1.modelist and next(arg_7_1.modelist) then
			self:resetModeData(arg_7_1.modelist)
		end

		self:updateModeData(arg_7_1.citylist)
	end
end

function var_0_0:updateModeData(arg_8_1)
	self.modeDatas = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if levelmode_data[iter_8_1.cityid] then
			local var_8_0 = {
				mode = levelmode_data[iter_8_1.cityid].mode,
				modeType = levelmode_data[iter_8_1.cityid].modetype
			}

			var_8_0.curLevel = playermodel.levelmode and playermodel.levelmode[levelmode_data[iter_8_1.cityid].mode] and playermodel.levelmode[levelmode_data[iter_8_1.cityid].mode].status
			var_8_0.totalLevel = levelmode_data[iter_8_1.cityid].totalchapter
			var_8_0.levelType = levelmode_data[iter_8_1.cityid].element_type or "other"
			var_8_0.res_element = levelmode_data[iter_8_1.cityid].res_element
			var_8_0.skills = self:parseLevelSkill(iter_8_1.skills)
			var_8_0.startTime = levelmode_data[iter_8_1.cityid].starttime
			var_8_0.endTime = levelmode_data[iter_8_1.cityid].endtime
			var_8_0.order = levelmode_data[iter_8_1.cityid].order
			var_8_0.open_week_days = levelmode_data[iter_8_1.cityid].open_week_days
			var_8_0.show_type = levelmode_data[iter_8_1.cityid].show_type
			self.modeDatas[#self.modeDatas + 1] = var_8_0
		else
			print("error: miss levelmode", iter_8_1.cityid)
		end
	end
end

function var_0_0.resetModeData(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		playermodel.levelmode[iter_9_1.mode] = iter_9_1
	end
end

function var_0_0.parseLevelSkill(arg_10_0, arg_10_1)
	local var_10_0 = {}

	if arg_10_1 then
		for iter_10_0 in string.gmatch(arg_10_1, "(%d+,%d+)") do
			local var_10_1, var_10_2 = string.match(iter_10_0, "(%d+),(%d+)")

			var_10_0[tonumber(var_10_1)] = tonumber(var_10_2)
		end
	end

	return var_10_0
end

function var_0_0:requestSetWeeklyTowerSkill(arg_11_1, arg_11_2, arg_11_3)
	self.modeId = arg_11_1
	self.chapterId = arg_11_2
	self.skillId = arg_11_3

	EventManager:requestSetWeeklyTowerSkill(self:convertMode(arg_11_1), arg_11_2, arg_11_3)
end

function var_0_0:handleSetWeeklyTowerSkill(arg_12_1)
	if not arg_12_1 then
		return
	end

	if arg_12_1.result == 1 then
		if not self.modeId or not self.chapterId or not self.skillId then
			return
		end

		self:updateLevelSkill(self:convertMode(self.modeId), self.chapterId, self.skillId)
	else
		self.modeId = nil
		self.chapterId = nil
		self.skillId = nil
	end
end

function var_0_0:updateLevelSkill(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = Utility:indexOf(self.modeDatas, function(arg_14_0)
		return arg_14_0.mode == arg_13_1
	end)

	if var_13_0 < 0 then
		return
	end

	self.modeDatas[var_13_0].skills[arg_13_2] = arg_13_3
end

function var_0_0:queryLevelsByMode(arg_15_1)
	if not self.levelDatas[arg_15_1] then
		self:initLevelDatas(arg_15_1)
	end

	return self.levelDatas[arg_15_1] or {}
end

function var_0_0:queryLevelDatas(arg_16_1, arg_16_2)
	if not self.levelDatas[arg_16_1] then
		self:initLevelDatas(arg_16_1)
	end

	return self.levelDatas[arg_16_1][arg_16_2]
end

function var_0_0:initLevelDatas(arg_17_1)
	local var_17_0 = {}

	for iter_17_0 = 1, level_manager:getModeTotalChapter(arg_17_1) do
		local var_17_1 = monster_manager.getLevelBoss(arg_17_1, iter_17_0 .. "-1")
		local var_17_2 = {
			index = iter_17_0,
			bossModel = var_17_1.majorlist.modelid,
			drops = Utility:getDropData((level_manager:getLevelDropID(arg_17_1, iter_17_0 .. "-1"))),
			isBigBoss = var_17_1.isFinal
		}

		if chapter_data[arg_17_1 .. "-" .. iter_17_0] then
			var_17_2.skillPool = chapter_data[arg_17_1 .. "-" .. iter_17_0].skill_pool_id or nil
		end

		local var_17_3 = horcrux_manager:getMonsterHorcruxAssistConfig(var_17_1.majorlist)

		var_17_2.bossSkills = {}

		if var_17_3 then
			for iter_17_1, iter_17_2 in ipairs(var_17_3.skills) do
				var_17_2.bossSkills[iter_17_1] = {
					id = iter_17_2,
					name = total_skill_data[iter_17_2].name,
					des = string.format("%s。", total_skill_data[iter_17_2].description),
					icon = total_skill_data[iter_17_2].icon
				}
			end
		end

		var_17_0[iter_17_0] = var_17_2
	end

	self.levelDatas[arg_17_1] = var_17_0
end

function var_0_0:getDropDatasByMode(arg_18_1)
	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = {}

	for iter_18_0, iter_18_1 in pairs((self:getCityDifficulties(arg_18_1))) do
		for iter_18_2, iter_18_3 in ipairs((self:queryLevelsByMode(iter_18_1))) do
			for iter_18_4, iter_18_5 in ipairs(iter_18_3.drops) do
				if not var_18_2[iter_18_5.itemid] then
					var_18_2[iter_18_5.itemid] = true
					var_18_0[#var_18_0 + 1] = iter_18_5.itemid
					var_18_1[iter_18_5.itemid] = iter_18_5.num
				else
					var_18_1[iter_18_5.itemid] = var_18_1[iter_18_5.itemid] + iter_18_5.num
				end
			end
		end
	end

	local item_data = require("data.item_data")

	local function var_18_4(arg_19_0)
		if arg_19_0 == "gold" then
			return 1
		elseif arg_19_0 == "diamond" then
			return 6
		else
			return item_data[arg_19_0].equip_quality
		end
	end

	table.sort(var_18_0, function(arg_20_0, arg_20_1)
		return var_18_4(arg_20_0) > var_18_4(arg_20_1)
	end)

	local var_18_5 = {}

	for iter_18_6 = 1, #var_18_0 do
		var_18_5[iter_18_6] = var_18_1[var_18_0[iter_18_6]]
	end

	return var_18_0, var_18_5
end

function var_0_0.canSelectSkill(arg_21_0, arg_21_1, arg_21_2)
	return false
end

function var_0_0.convertMode(arg_22_0, arg_22_1)
	if arg_22_1 >= 2101 and arg_22_1 <= 2199 then
		arg_22_1 = 2101 + (math.ceil(arg_22_1 % 2100 / 3) - 1) * 3
	end

	return arg_22_1
end

function var_0_0:queryModeSkill(arg_23_1, arg_23_2)
	arg_23_1 = self:convertMode(arg_23_1)

	local var_23_0 = Utility:indexOf(self.modeDatas, function(arg_24_0)
		return arg_24_0.mode == arg_23_1
	end)

	if var_23_0 < 0 then
		return {}
	end

	if arg_23_2 then
		return self.modeDatas[var_23_0].skills
	end

	local var_23_1 = {}

	for iter_23_0, iter_23_1 in pairs(self.modeDatas[var_23_0].skills) do
		local var_23_2 = {
			skillId = total_skill_data[iter_23_1].skill1,
			name = total_skill_data[iter_23_1].name,
			des = total_skill_data[iter_23_1].description,
			icon = total_skill_data[iter_23_1].icon
		}

		var_23_2.rarity = total_skill_data[iter_23_1].skill_rare or 1
		var_23_1[#var_23_1 + 1] = var_23_2
	end

	return var_23_1
end

function var_0_0:qeueryLevelSkill(arg_25_1, arg_25_2)
	local var_25_0 = self:queryLevelDatas(arg_25_1, arg_25_2)

	if not var_25_0 then
		return {}
	end

	if not var_25_0.skillPool then
		return {}
	end

	local var_25_1 = skill_pool_21_data[var_25_0.skillPool]
	local var_25_2 = {}

	while var_25_1["skill_" .. 1] do
		local var_25_3 = {
			skillId = var_25_1["skill_" .. 1],
			name = total_skill_data[var_25_1["skill_" .. 1]].name,
			des = total_skill_data[var_25_1["skill_" .. 1]].description,
			icon = total_skill_data[var_25_1["skill_" .. 1]].icon
		}

		var_25_3.rarity = total_skill_data[var_25_1["skill_" .. 1]].skill_rare or 1
		var_25_2[#var_25_2 + 1] = var_25_3
	end

	return self:randomSelectSkill(var_25_2)
end

function var_0_0.randomSelectSkill(arg_26_0, arg_26_1)
	if #arg_26_1 <= 3 then
		return arg_26_1
	end

	local var_26_0 = 0
	local var_26_1 = {}

	while var_26_0 < 3 do
		local var_26_2 = math.random(1, #arg_26_1)

		var_26_0 = var_26_0 + 1
		var_26_1[var_26_0] = arg_26_1[var_26_2]

		Utility:splice(arg_26_1, var_26_2, 1)
	end

	return var_26_1
end

function var_0_0:getSkillAdditions()
	if not self.isEnterFight then
		return
	end

	if not self.modeId or not self.chapterId then
		return
	end

	return (self:queryModeSkill(self.modeId))
end

function var_0_0.setModeChapter(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0.modeId = arg_28_1
	arg_28_0.chapterId = arg_28_2
end

function var_0_0.setFightFlag(arg_29_0, arg_29_1)
	arg_29_0.isEnterFight = arg_29_1
end

function var_0_0:getEndTime()
	local var_30_0
	local var_30_1 = time_check_manager:getCurTime()

	for iter_30_0, iter_30_1 in ipairs(self.modeDatas) do
		if Utility:isTimeRangeValid(iter_30_1.startTime, iter_30_1.endTime) and iter_30_1.endTime then
			local var_30_2 = global_get_time_by_date(iter_30_1.endTime)

			if var_30_2 > (var_30_0 or 0) then
				var_30_0 = var_30_2
			end
		end
	end

	return var_30_0
end

function var_0_0.queryEndTime(arg_31_0)
	local var_31_0 = 0
	local var_31_1 = time_check_manager:getCurTime()

	for iter_31_0, iter_31_1 in pairs((require("data.levelmode_boss2101_data"))) do
		if Utility:isTimeRangeValid(iter_31_1.starttime, iter_31_1.endtime) then
			local var_31_2 = global_get_time_by_date(iter_31_1.endtime)

			if var_31_0 < var_31_2 then
				var_31_0 = var_31_2
			end
		end
	end

	return var_31_0
end

function var_0_0:initModeData()
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(city_data) do
		if iter_32_1.citytype == 21 then
			table.insert(var_32_0, {
				cityid = iter_32_1.id
			})
		end
	end

	self:updateModeData(var_32_0)
end

function var_0_0.isWeeklyTowerModetpye(arg_33_0, arg_33_1)
	return arg_33_1 == 21
end

function var_0_0.getCityDifficulties(arg_34_0, arg_34_1)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs((level_manager:getCityDifficulties((level_manager:getCityByMode(arg_34_1))))) do
		table.insert(var_34_0, iter_34_1.mode)
	end

	return var_34_0
end

function var_0_0:selectDefaultSkill(arg_35_1)
	if self:canSelectSkill(arg_35_1.mode, playermodel.levelmode[arg_35_1.mode].status) then
		self:requestSetWeeklyTowerSkill(arg_35_1.mode, playermodel.levelmode[arg_35_1.mode].status, self:qeueryLevelSkill(arg_35_1.mode, playermodel.levelmode[arg_35_1.mode].status)[1].skillId)
	end
end

return var_0_0
