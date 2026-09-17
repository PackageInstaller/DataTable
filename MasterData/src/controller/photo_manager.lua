local var_0_0 = {}

require("data.constants")

local network = require("network.network")
local playermodel = require("model.playermodel")
local horcrux_data = require("data.horcrux_data")
local item_data = require("data.item_data")
local travel_photo_data = require("data.travel_photo_data")
local explore_photo_data = require("data.explore_photo_data")
local var_0_7 = require("data.horcrux_data")
local postcard_data = require("data.postcard_data")
local major_factor_data = require("data.major_factor_data")
local photogoods_component_data = require("data.photogoods_component_data")
local servant_data = require("data.servant_data")
local horcrux_manager = require("controller.horcrux_manager")
local item_manager = require("controller.item_manager")
local var_0_14 = require("controller.item_manager")
local level_manager = require("controller.level_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_17 = {
	photofile_nightmare_xmasfile_data = "file_nightmare_xmasfile",
	photofile_ai3_data = "file_enemy4",
	photofile_ai1_data = "file_enemy2",
	photofile_data = "file_player",
	photofile_foundationai_data = "file_enemy9",
	photofile_foundation_data = "file_enemy8",
	photofile_ai2_data = "file_enemy3",
	photofile_activity_data = "file_enemy12",
	photofile_military_data = "file_enemy6",
	photofile_talk_level_data = "photofile_talk_level_data",
	photofile_militaryai_data = "file_enemy7",
	photofile_killer_data = "file_enemy10",
	photofile_ai4_data = "file_enemy5",
	photofile_ai5_data = "file_enemy_ai5",
	photofile_xmasfile_data = "file_enemy1",
	photofile_activityai_data = "file_enemy11"
}
local var_0_18 = {
	photofile_military_data = "file_enemy6",
	photofile_xmasfile_data = "file_enemy1",
	photofile_data = "file_player",
	photofile_killer_data = "file_enemy10",
	photofile_nightmare_xmasfile_data = "file_nightmare_xmasfile",
	photofile_foundation_data = "file_enemy8",
	photofile_activity_data = "file_enemy12"
}

function var_0_0.getFileType(arg_1_0, arg_1_1)
	return var_0_17[arg_1_1]
end

function var_0_0.isBigPicture(arg_2_0, arg_2_1)
	return var_0_18[arg_2_1]
end

local function var_0_19(arg_3_0, arg_3_1)
	arg_3_0 = tostring(arg_3_0)
	arg_3_1 = tostring(arg_3_1)

	if arg_3_1 == "" then
		return false
	end

	local var_3_0 = 0
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in function()
		return string.find(arg_3_0, arg_3_1, var_3_0, true)
	end do
		table.insert(var_3_1, string.sub(arg_3_0, var_3_0, iter_3_0 - 1))

		var_3_0 = iter_3_1 + 1
	end

	table.insert(var_3_1, string.sub(arg_3_0, var_3_0))

	return var_3_1
end

local function var_0_20(arg_5_0)
	arg_5_0 = arg_5_0 or {}

	local var_5_0 = {}
	local var_5_1 = 1

	for iter_5_0, iter_5_1 in pairs(arg_5_0) do
		var_5_0[var_5_1] = iter_5_1.id
		var_5_1 = var_5_1 + 1
	end

	table.sort(var_5_0)

	local var_5_2 = {}
	local var_5_3 = 1

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		var_5_2[var_5_3] = {}
		var_5_2[var_5_3].id = iter_5_3
		var_5_2[var_5_3].sort = arg_5_0[iter_5_3].sort
		var_5_2[var_5_3].unlock = arg_5_0[iter_5_3].unlock
		var_5_2[var_5_3].class = arg_5_0[iter_5_3].class
		var_5_2[var_5_3].name = arg_5_0[iter_5_3].name
		var_5_2[var_5_3].easy_name = arg_5_0[iter_5_3].easy_name
		var_5_2[var_5_3].modelId = arg_5_0[iter_5_3].modelId
		var_5_2[var_5_3].servantid = arg_5_0[iter_5_3].servantid
		var_5_3 = var_5_3 + 1
	end

	return var_5_2
end

local food_photo_data = require("data.food_photo_data")
local medal_data = require("data.medal_data")
local weapon_data = require("data.weapon_data")

function var_0_0:initFoodTable(arg_6_1)
	self.foodInfo = {}

	for iter_6_0, iter_6_1 in pairs(food_photo_data) do
		self.foodInfo[#self.foodInfo + 1] = {
			unlock = 1,
			id = iter_6_1.id
		}
	end

	if self.foodInfo ~= nil then
		self:setUnlockFoodData()
	else
		network:rpc("get_server_date", {
			playerid = "0"
		}, function(arg_7_0)
			self.setUnlockFoodData()

			self.foodInfo = var_0_20(self.foodInfo)
		end)
	end
end

function var_0_0:setUnlockFoodData()
	self.foodUnlockInfo = {}

	for iter_8_0, iter_8_1 in pairs(self.foodInfo) do
		if iter_8_1.unlock == 1 then
			self.foodUnlockInfo[1] = {}
			self.foodUnlockInfo[1].id = iter_8_1.id
			self.foodUnlockInfo[1].unlock = iter_8_1.unlock
		end
	end
end

function var_0_0:getFoodData()
	return self.foodInfo
end

function var_0_0:getFoodNumber()
	return #self.foodInfo
end

function var_0_0:getUnlockFoodData()
	return self.foodUnlockInfo
end

function var_0_0:getUnlockFoodNumber()
	return #self.foodUnlockInfo
end

function var_0_0:initMedalTable(arg_13_1)
	self.medalInfo = {}

	for iter_13_0, iter_13_1 in pairs(medal_data) do
		self.medalInfo[#self.medalInfo + 1] = {}
		self.medalInfo[#self.medalInfo].id = iter_13_1.id
		self.medalInfo[#self.medalInfo].unlock = 0
		self.medalInfo[#self.medalInfo].equip_quality = iter_13_1.equip_quality

		if var_0_14:getItemNumber(iter_13_1.id) > 0 then
			self.medalInfo[#self.medalInfo].unlock = 1
		end
	end

	local var_13_0 = {
		[3] = {
			weight = 3,
			func = function(self, arg_15_1)
				if not self.unlock then
					return "=="
				else
					if self.unlock == arg_15_1.unlock then
						return "=="
					end

					return self.unlock > arg_15_1.unlock
				end
			end
		},
		[2] = {
			weight = 2,
			func = function(self, arg_14_1)
				if not self.equip_quality then
					return "=="
				else
					if self.equip_quality == arg_14_1.equip_quality then
						return "=="
					end

					return self.equip_quality > arg_14_1.equip_quality
				end
			end
		},
		{
			weight = 1,
			func = function(self, arg_16_1)
				if not self.id then
					return false
				else
					return self.id < arg_16_1.id
				end
			end
		}
	}

	table.sort(var_13_0, function(arg_17_0, arg_17_1)
		return arg_17_0.weight > arg_17_1.weight
	end)
	table.sort(self.medalInfo, function(arg_18_0, arg_18_1)
		for iter_18_0 = 1, #var_13_0 do
			if var_13_0[iter_18_0].func(arg_18_0, arg_18_1) ~= "==" then
				return var_13_0[iter_18_0].func(arg_18_0, arg_18_1)
			end
		end
	end)

	if self.medalInfo ~= nil then
		self:setUnlockMedalData()
	end
end

function var_0_0:setUnlockMedalData()
	self.medalUnlockInfo = {}

	for iter_19_0, iter_19_1 in pairs(medal_data) do
		if var_0_14:getItemNumber(iter_19_1.id) > 0 then
			self.medalUnlockInfo[#self.medalUnlockInfo + 1] = {}
			self.medalUnlockInfo[#self.medalUnlockInfo].id = iter_19_1.id
			self.medalUnlockInfo[#self.medalUnlockInfo].unlock = 1
			self.medalUnlockInfo[#self.medalUnlockInfo].equip_quality = iter_19_1.equip_quality
		end
	end

	local var_19_0 = {
		[2] = {
			weight = 2,
			func = function(self, arg_20_1)
				if not self.equip_quality then
					return "=="
				else
					if self.equip_quality == arg_20_1.equip_quality then
						return "=="
					end

					return self.equip_quality > arg_20_1.equip_quality
				end
			end
		},
		{
			weight = 1,
			func = function(self, arg_21_1)
				if not self.id then
					return "=="
				else
					return self.id < arg_21_1.id
				end
			end
		}
	}

	table.sort(var_19_0, function(arg_22_0, arg_22_1)
		return arg_22_0.weight > arg_22_1.weight
	end)
	table.sort(self.medalUnlockInfo, function(arg_23_0, arg_23_1)
		for iter_23_0 = 1, #var_19_0 do
			if var_19_0[iter_23_0].func(arg_23_0, arg_23_1) ~= "==" then
				return var_19_0[iter_23_0].func(arg_23_0, arg_23_1)
			end
		end
	end)
end

function var_0_0:getMedalData()
	return self.medalInfo
end

function var_0_0:getMedalNumber()
	return #self.medalInfo
end

function var_0_0:getUnlockMedalData()
	return self.medalUnlockInfo
end

function var_0_0:getUnlockMedalNumber()
	return #self.medalUnlockInfo
end

function var_0_0:initPartsTable(arg_28_1)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(playermodel.items) do
		if iter_28_1.itemtype == kITEM_COMPONENT then
			for iter_28_2, iter_28_3 in pairs(var_28_0) do
				if iter_28_1.component_attr.effect == iter_28_3 then
					break
				end

				if iter_28_2 == #var_28_0 and iter_28_1.component_attr ~= iter_28_3 then
					var_28_0[#var_28_0 + 1] = iter_28_1.component_attr.effect
				end
			end

			if #var_28_0 == 0 then
				var_28_0[#var_28_0 + 1] = iter_28_1.component_attr.effect
			end
		end
	end

	local function var_28_1(arg_29_0)
		for iter_29_0, iter_29_1 in pairs(var_28_0) do
			if arg_29_0 == iter_29_1 then
				return true
			end
		end

		return false
	end

	self.partsInfo = {}
	self.partsUnlockInfo = {}

	for iter_28_4, iter_28_5 in pairs(photogoods_component_data) do
		self.partsInfo[#self.partsInfo + 1] = {}
		self.partsInfo[#self.partsInfo].id = iter_28_5.id

		if var_28_1(iter_28_5.image_id - 1) then
			self.partsInfo[#self.partsInfo].unlock = 1
			self.partsUnlockInfo[#self.partsUnlockInfo + 1] = {}
			self.partsUnlockInfo[#self.partsUnlockInfo].id = iter_28_5.id
			self.partsUnlockInfo[#self.partsUnlockInfo].unlock = 1
		else
			self.partsInfo[#self.partsInfo].unlock = 0
		end
	end
end

function var_0_0:setUnlockPartsData()
	self.partsUnlockInfo = {}

	for iter_30_0, iter_30_1 in pairs(self.partsInfo) do
		if iter_30_1.unlock == 1 then
			self.partsUnlockInfo[1] = {}
			self.partsUnlockInfo[1].id = iter_30_1.id
			self.partsUnlockInfo[1].unlock = iter_30_1.unlock
		end
	end
end

function var_0_0:getPartsData()
	return self.partsInfo
end

function var_0_0:getPartsNumber()
	return #self.partsInfo
end

function var_0_0:getUnlockPartsData()
	return self.partsUnlockInfo
end

function var_0_0:getUnlockPartsNumber()
	return #self.partsUnlockInfo
end

function var_0_0:initWeaponData()
	local var_35_0 = require("controller.item_manager"):filterItem({
		kITEM_WEAPON
	})
	local var_35_2 = {}

	for iter_35_0, iter_35_1 in pairs((require("data.photofile_weapon_data"))) do
		var_35_2[#var_35_2 + 1] = {}
		var_35_2[#var_35_2].id = iter_35_1.id
	end

	self.weaponInfo = {}
	self.weaponUnlockInfo = {}

	for iter_35_2, iter_35_3 in pairs(var_35_2) do
		local var_35_4 = 1

		self.weaponInfo[#self.weaponInfo + 1] = {}
		self.weaponInfo[#self.weaponInfo].id = iter_35_3.id

		if iter_35_3.id and weapon_data[iter_35_3.id] then
			self.weaponInfo[#self.weaponInfo].name = weapon_data[iter_35_3.id].name or L_WEAPON_UNIVERSE
		end

		self.weaponInfo[#self.weaponInfo].unlock = var_35_4

		if var_35_4 == 1 then
			self.weaponUnlockInfo[#self.weaponUnlockInfo + 1] = {}
			self.weaponUnlockInfo[#self.weaponUnlockInfo].id = iter_35_3.id
			self.weaponUnlockInfo[#self.weaponUnlockInfo].unlock = var_35_4
		end
	end
end

function var_0_0:getWeaponData()
	return self.weaponInfo
end

function var_0_0:getUnlockWeaponData()
	return self.weaponUnlockInfo
end

function var_0_0:getWeaponNumber()
	return #self.weaponInfo
end

function var_0_0:getUnlockWeaponNumber()
	return #self.weaponUnlockInfo
end

local photo_data = require("data.photo_data")
local photo_extension_data = require("data.photo_extension_data")

function var_0_0.checkHaveData(arg_40_0, arg_40_1, arg_40_2)
	arg_40_1 = tostring(arg_40_1)
	arg_40_2 = tostring(arg_40_2)

	for iter_40_0, iter_40_1 in pairs(photo_data) do
		if iter_40_1.unlock_level then
			local var_40_0 = string.split(iter_40_1.unlock_level, "#")

			if var_40_0[1] == arg_40_1 and string.split(arg_40_2, "-")[1] == string.split(var_40_0[2], "-")[1] then
				return true
			end
		end
	end

	return false
end

function var_0_0.checkHaveDataByModeAndChapter(arg_41_0, arg_41_1, arg_41_2)
	arg_41_1 = tostring(arg_41_1)
	arg_41_2 = tostring(arg_41_2)

	for iter_41_0, iter_41_1 in pairs(photo_data) do
		if iter_41_1.unlock_level then
			if var_0_19(iter_41_1.unlock_level, "#")[1] == arg_41_1 and string.split(var_0_19(iter_41_1.unlock_level, "#")[2], "-")[1] == arg_41_2 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getPhotoDataNameByModeAndLevel(arg_42_0, arg_42_1, arg_42_2)
	arg_42_1 = tostring(arg_42_1)
	arg_42_2 = tostring(arg_42_2)

	local var_42_0 = string.split(arg_42_2, "-")[1]

	for iter_42_0, iter_42_1 in pairs(photo_data) do
		if iter_42_1.unlock_level then
			local var_42_1 = string.split(iter_42_1.unlock_level, "#")

			if var_42_1[1] == arg_42_1 and string.split(var_42_1[2], "-")[1] == var_42_0 then
				return iter_42_1.name or ""
			end
		end
	end

	return ""
end

function var_0_0:initThreadStoryData()
	self:initWeaponData()

	if not self.threadStoryInfo then
		self.threadStoryInfo = {}
		self.threadUnlockInfo = {}

		for iter_43_0, iter_43_1 in pairs(photo_data) do
			if iter_43_1.pv then
				self.threadStoryInfo[iter_43_1.id] = {
					unlock = 1,
					id = iter_43_1.id
				}
				self.threadUnlockInfo[iter_43_1.id] = self.threadStoryInfo[iter_43_1.id]
			else
				self.threadStoryInfo[iter_43_1.id] = {}
				self.threadStoryInfo[iter_43_1.id].id = iter_43_1.id

				local var_43_0 = var_0_19(iter_43_1.unlock_level, "#")[1]
				local var_43_1 = var_0_19(iter_43_1.unlock_level, "#")[2]
				local var_43_2 = tonumber(var_0_19(var_43_1, "-")[1])

				if var_43_2 < playermodel.levelmode[tonumber(var_43_0)].status or var_43_2 <= tonumber(var_0_19(playermodel.levelmode[tonumber(var_43_0)].level, "-")[1]) and tonumber(var_0_19(var_43_1, "-")[2]) < tonumber(var_0_19(playermodel.levelmode[tonumber(var_43_0)].level, "-")[2]) then
					self.threadStoryInfo[iter_43_1.id].unlock = 1
					self.threadUnlockInfo[iter_43_1.id] = self.threadStoryInfo[iter_43_1.id]
				else
					self.threadStoryInfo[iter_43_1.id].unlock = 0
				end
			end
		end

		self.threadUnlockInfo = self.threadUnlockInfo or {}
		self.threadStoryInfo = var_0_20(self.threadStoryInfo)
		self.threadUnlockInfo = var_0_20(self.threadUnlockInfo)
	else
		for iter_43_2, iter_43_3 in pairs(self.threadStoryInfo) do
			if not photo_data[iter_43_3.id].pv then
				local var_43_5 = var_0_19(iter_43_3.unlock_level, "#")[1]
				local var_43_6 = var_0_19(iter_43_3.unlock_level, "#")[2]
				local var_43_7 = tonumber(var_0_19(var_43_6, "-")[1])

				if var_43_7 < playermodel.levelmode[tonumber(var_43_5)].status or var_43_7 <= tonumber(var_0_19(playermodel.levelmode[tonumber(var_43_5)].level, "-")[1]) and tonumber(var_0_19(var_43_6, "-")[2]) < tonumber(var_0_19(playermodel.levelmode[tonumber(var_43_5)].level, "-")[2]) then
					self.threadStoryInfo[iter_43_2].unlock = 1
				end
			end
		end
	end
end

function var_0_0:getThreadStoryData()
	return self.threadStoryInfo
end

function var_0_0:getUnlockThreadData()
	return self.threadUnlockInfo
end

function var_0_0:getThreadStoryNumber()
	return #self.threadStoryInfo
end

function var_0_0:getTreadUnlockNumber()
	return #self.threadUnlockInfo
end

function var_0_0:initBranchStoryData()
	if not self.branchStoryInfo then
		self.branchStoryInfo = {}
		self.branchUnlockInfo = {}

		for iter_48_0, iter_48_1 in pairs(photo_extension_data) do
			self.branchStoryInfo[iter_48_1.id] = {}
			self.branchStoryInfo[iter_48_1.id].id = iter_48_1.id

			local var_48_0 = playermodel.levelmode[tonumber(var_0_19(iter_48_1.unlock_level, "#")[1])]

			self.branchStoryInfo[iter_48_1.id].unlock = 1
			self.branchUnlockInfo[iter_48_1.id] = self.branchStoryInfo[iter_48_1.id]
		end

		self.branchUnlockInfo = self.branchUnlockInfo or {}
		self.branchStoryInfo = var_0_20(self.branchStoryInfo)
		self.branchUnlockInfo = var_0_20(self.branchUnlockInfo)
	end
end

function var_0_0:getBranchStoryData()
	return self.branchStoryInfo
end

function var_0_0:getUnlockBranchData()
	return self.branchUnlockInfo
end

function var_0_0:getBranchStoryNumber()
	return #self.branchStoryInfo
end

function var_0_0:getBranchUnlockNumber()
	return #self.branchUnlockInfo
end

function var_0_0:initEventStoryData()
	if not self.eventStoryInfo then
		self.eventStoryInfo = {}
		self.eventUnlockInfo = {}

		for iter_53_0, iter_53_1 in ipairs(travel_photo_data) do
			if iter_53_1.is_invalid ~= 1 and (not iter_53_1.starttime or time_check_manager:getCurTime() >= os.time(parse_time(iter_53_1.starttime))) then
				local var_53_0 = postcard_data[iter_53_1.postcard_id]

				if not iter_53_1.isunlock then
					if self.postcardTaskInfo[iter_53_1.id] then
						self.eventStoryInfo[iter_53_1.id] = {}
						self.eventStoryInfo[iter_53_1.id].id = iter_53_1.id
						self.eventStoryInfo[iter_53_1.id].image = var_53_0.image
						self.eventStoryInfo[iter_53_1.id].unlock = 1
						self.eventUnlockInfo[iter_53_1.id] = self.eventStoryInfo[iter_53_1.id]
					else
						self.eventStoryInfo[iter_53_1.id] = {}
						self.eventStoryInfo[iter_53_1.id].id = iter_53_1.id
						self.eventStoryInfo[iter_53_1.id].image = var_53_0.image
						self.eventStoryInfo[iter_53_1.id].unlock = 0
					end
				elseif iter_53_1.isunlock == 1 then
					self.eventStoryInfo[iter_53_1.id] = {}
					self.eventStoryInfo[iter_53_1.id].id = iter_53_1.id
					self.eventStoryInfo[iter_53_1.id].image = var_53_0.image
					self.eventStoryInfo[iter_53_1.id].unlock = 1
					self.eventUnlockInfo[iter_53_1.id] = self.eventStoryInfo[iter_53_1.id]
				end
			end
		end

		self.eventUnlockInfo = self.eventUnlockInfo or {}
		self.eventStoryInfo = var_0_20(self.eventStoryInfo)

		table.sort(self.eventStoryInfo, function(arg_54_0, arg_54_1)
			return travel_photo_data[arg_54_0.id].order < travel_photo_data[arg_54_1.id].order
		end)

		self.eventUnlockInfo = var_0_20(self.eventUnlockInfo)
	end
end

function var_0_0:getEventStoryData()
	return self.eventStoryInfo
end

function var_0_0:getUnlockEventData()
	return self.eventUnlockInfo
end

function var_0_0:getEventStoryNumber()
	return #self.eventStoryInfo
end

function var_0_0:getEventUnlockNumber()
	return #self.eventUnlockInfo
end

function var_0_0.getPostcardTaskData(arg_59_0, arg_59_1)
	local bit = require("bit")

	arg_59_0.postcardTaskInfo = {}

	network:rpc("get_travel_list", nil, function(arg_60_0)
		if arg_60_0.travel.photoCoding then
			for iter_60_0, iter_60_1 in pairs(travel_photo_data) do
				if iter_60_1.order ~= nil then
					local var_60_0 = math.floor((iter_60_1.order - 1) / 30) + 1

					if arg_60_0.travel.photoCoding[var_60_0] and bit.band(arg_60_0.travel.photoCoding[var_60_0], 2^((iter_60_1.order - 1) % 30 + 1 - 1)) > 0 then
						arg_59_0.postcardTaskInfo[iter_60_1.order] = 1
					end
				end
			end
		end

		if arg_59_1 then
			arg_59_1()
		end
	end)
end

function var_0_0:initExploreStoryData(arg_61_1)
	if not self.exploreStoryInfo then
		self.exploreStoryInfo = {}
		self.exploreUnlockInfo = {}

		for iter_61_0, iter_61_1 in pairs(explore_photo_data) do
			self.exploreStoryInfo[iter_61_1.id] = {}
			self.exploreStoryInfo[iter_61_1.id].id = iter_61_1.id

			if arg_61_1[iter_61_1.plotclassid] then
				self.exploreStoryInfo[iter_61_1.id].unlock = 1
				self.exploreUnlockInfo[iter_61_1.id] = self.exploreStoryInfo[iter_61_1.id]
			else
				self.exploreStoryInfo[iter_61_1.id].unlock = 0
			end
		end

		self.exploreStoryInfo = var_0_20(self.exploreStoryInfo)
		self.exploreUnlockInfo = var_0_20(self.exploreUnlockInfo)
	end
end

function var_0_0:getExploreStoryData()
	return self.exploreStoryInfo
end

function var_0_0:getExploreStoryNumber()
	return #self.exploreStoryInfo
end

function var_0_0:getEventUnlockNumber()
	return #self.exploreUnlockInfo
end

local photofile_data = require("data.photofile_data")
local photofile_HelpGirl_data = require("data.photofile_HelpGirl_data")
local account_manager = require("controller.account_manager")
local var_0_29 = require("data.servant_data")

function var_0_0:initGirlData()
	if not self.girlInfo then
		self.girlInfo = {}
		self.girlUnlockInfo = {}

		for iter_65_0, iter_65_1 in pairs(photofile_data) do
			if (not var_0_29[tonumber(iter_65_1.servant_id)].linkage or var_0_29[tonumber(iter_65_1.servant_id)].linkage and playermodel.haveServant[tonumber(iter_65_1.servant_id)]) and not playermodel:isServantLockByTime(tonumber(iter_65_1.servant_id)) then
				self.girlInfo[iter_65_1.id] = {}
				self.girlInfo[iter_65_1.id].id = iter_65_1.id
				self.girlInfo[iter_65_1.id].sort = iter_65_1.sort
				self.girlInfo[iter_65_1.id].modelId = iter_65_1.model_id
				self.girlInfo[iter_65_1.id].servantid = iter_65_1.servant_id
				self.girlInfo[iter_65_1.id].name = iter_65_1.title
				self.girlInfo[iter_65_1.id].easy_name = iter_65_1.easy_name

				if playermodel.haveServant[tonumber(iter_65_1.servant_id)] then
					self.girlInfo[iter_65_1.id].unlock = 1
					self.girlUnlockInfo[iter_65_1.id] = self.girlInfo[iter_65_1.id]
				else
					self.girlInfo[iter_65_1.id].unlock = 0
				end
			end
		end

		self.girlUnlockInfo = self.girlUnlockInfo or {}
		self.girlInfo = var_0_20(self.girlInfo)
		self.girlUnlockInfo = var_0_20(self.girlUnlockInfo)
	end
end

function var_0_0:getGirlData()
	table.sort(self.girlInfo, function(arg_67_0, arg_67_1)
		return arg_67_0.sort < arg_67_1.sort
	end)

	return self.girlInfo
end

function var_0_0:getUnlockGirlData()
	table.sort(self.girlUnlockInfo, function(arg_69_0, arg_69_1)
		return arg_69_0.sort < arg_69_1.sort
	end)

	return self.girlUnlockInfo
end

function var_0_0:getGirlNumber()
	return #self.girlInfo
end

function var_0_0:getUnlockGirlNumber()
	return #self.girlUnlockInfo
end

function var_0_0:initHelpGirlData()
	self.ownedHorcruxType = {}

	for iter_72_0, iter_72_1 in pairs(playermodel.items) do
		if iter_72_1.itemtype ~= kITEM_HORCRUX or self.ownedHorcruxType[var_0_7[iter_72_1.itemid].horcruxtype] then
			-- block empty
		else
			self.ownedHorcruxType[var_0_7[iter_72_1.itemid].horcruxtype] = true
		end
	end

	local function var_72_0(arg_73_0)
		return self.ownedHorcruxType[arg_73_0]
	end

	local var_72_1 = account_manager:getChannel()

	if not self.helpGirlInfo then
		self.helpGirlInfo = {}
		self.helpGirlUnlockInfo = {}

		for iter_72_2, iter_72_3 in pairs(photofile_HelpGirl_data) do
			if iter_72_3.show_channel and var_72_1 == iter_72_3.show_channel then
				self.helpGirlInfo[iter_72_3.id] = {}
				self.helpGirlInfo[iter_72_3.id].id = iter_72_3.id
				self.helpGirlInfo[iter_72_3.id].sort = iter_72_3.sort
				self.helpGirlInfo[iter_72_3.id].class = horcrux_data[iter_72_3.item_id].class

				if var_72_0(horcrux_data[iter_72_3.item_id].horcruxtype) then
					self.helpGirlInfo[iter_72_3.id].unlock = 1
					self.helpGirlUnlockInfo[iter_72_3.id] = self.helpGirlInfo[iter_72_3.id]
				else
					self.helpGirlInfo[iter_72_3.id].unlock = 0
				end
			elseif not iter_72_3.show_channel then
				self.helpGirlInfo[iter_72_3.id] = {}
				self.helpGirlInfo[iter_72_3.id].id = iter_72_3.id
				self.helpGirlInfo[iter_72_3.id].sort = iter_72_3.sort
				self.helpGirlInfo[iter_72_3.id].class = horcrux_data[iter_72_3.item_id].class

				if var_72_0(horcrux_data[iter_72_3.item_id].horcruxtype) then
					self.helpGirlInfo[iter_72_3.id].unlock = 1
					self.helpGirlUnlockInfo[iter_72_3.id] = self.helpGirlInfo[iter_72_3.id]
				else
					self.helpGirlInfo[iter_72_3.id].unlock = 0
				end
			end
		end

		self.helpGirlUnlockInfo = self.helpGirlUnlockInfo or {}
		self.helpGirlInfo = var_0_20(self.helpGirlInfo)
		self.helpGirlUnlockInfo = var_0_20(self.helpGirlUnlockInfo)
	end
end

function var_0_0:getHelpGirlData()
	table.sort(self.helpGirlInfo, function(arg_75_0, arg_75_1)
		if arg_75_0.sort ~= arg_75_1.sort then
			return arg_75_0.sort < arg_75_1.sort
		end
	end)

	return self.helpGirlInfo
end

function var_0_0:getUnlockHelpGirlData()
	table.sort(self.helpGirlUnlockInfo, function(arg_77_0, arg_77_1)
		if arg_77_0.sort ~= arg_77_1.sort then
			return arg_77_0.sort < arg_77_1.sort
		end
	end)

	return self.helpGirlUnlockInfo
end

function var_0_0:getHelpGirlNumber()
	return #self.helpGirlInfo
end

function var_0_0:getUnlockHelpGirlNumber()
	return #self.helpGirlUnlockInfo
end

local photofile_npcfiles_data = require("data.photofile_npcfiles_data")

function var_0_0:initTeacherData()
	if not self.teacherInfo then
		self.teacherInfo = {}
		self.teacherUnlockInfo = {}

		for iter_80_0, iter_80_1 in pairs(photofile_npcfiles_data) do
			local var_80_0 = {
				id = iter_80_1.id,
				sort = iter_80_1.sort,
				modelId = iter_80_1.model_id
			}

			var_80_0.unlock = 1

			table.insert(self.teacherInfo, var_80_0)
		end
	end
end

function var_0_0:getTeacherData()
	print("getTeacherData: ", dump(self.teacherInfo))
	table.sort(self.teacherInfo, function(arg_82_0, arg_82_1)
		if arg_82_0.sort ~= arg_82_1.sort then
			return arg_82_0.sort < arg_82_1.sort
		end
	end)

	return self.teacherInfo
end

function var_0_0:getUnlockTeacherData(arg_83_1)
	table.sort(self.teacherInfo, function(arg_84_0, arg_84_1)
		if arg_84_0.sort ~= arg_84_1.sort then
			return arg_84_0.sort < arg_84_1.sort
		end
	end)

	return self.teacherInfo
end

function var_0_0:getTeacherNumber(arg_85_1)
	return (self.teacherInfo or nil) and (#self.teacherInfo or 0)
end

function var_0_0:getUnlockTeacherNumber(arg_86_1)
	return (self.teacherInfo or nil) and (#self.teacherInfo or 0)
end

local photofile_ai5_data = require("data.photofile_ai5_data")
local var_0_32 = require("data.photofile_ai5_data")
local var_0_33 = {
	require("data.photofile_xmasfile_data"),
	require("data.photofile_ai1_data"),
	require("data.photofile_ai2_data"),
	require("data.photofile_ai3_data"),
	require("data.photofile_ai4_data"),
	require("data.photofile_military_data"),
	require("data.photofile_militaryai_data"),
	require("data.photofile_foundation_data"),
	require("data.photofile_foundationai_data"),
	require("data.photofile_killer_data"),
	require("data.photofile_nightmare_xmasfile_data"),
	var_0_32,
	var_0_32
}

function var_0_0:initEnemyData()
	if not self.enemyInfo then
		self.enemyInfo = {}
		self.enemyUnlockInfo = {}

		for iter_87_0, iter_87_1 in pairs(var_0_33) do
			for iter_87_2, iter_87_3 in pairs(iter_87_1) do
				self.enemyInfo[iter_87_0] = self.enemyInfo[iter_87_0] or {}
				self.enemyInfo[iter_87_0][#self.enemyInfo[iter_87_0] + 1] = {}
				self.enemyInfo[iter_87_0][#self.enemyInfo[iter_87_0]].id = iter_87_3.id
				self.enemyInfo[iter_87_0][#self.enemyInfo[iter_87_0]].sort = iter_87_3.sort
				self.enemyInfo[iter_87_0][#self.enemyInfo[iter_87_0]].modelId = iter_87_3.model_id

				if level_manager:isPlayerPassLevel(iter_87_3.first_fight) then
					self.enemyInfo[iter_87_0][#self.enemyInfo[iter_87_0]].unlock = 1
					self.enemyUnlockInfo[iter_87_0] = self.enemyUnlockInfo[iter_87_0] or {}
					self.enemyUnlockInfo[iter_87_0][#self.enemyUnlockInfo[iter_87_0] + 1] = self.enemyInfo[iter_87_0][#self.enemyInfo[iter_87_0]]
				else
					self.enemyInfo[iter_87_0][#self.enemyInfo[iter_87_0]].unlock = 0
				end
			end

			self.enemyUnlockInfo = self.enemyUnlockInfo or {}
		end
	end
end

function var_0_0:getEnemyData(arg_88_1)
	table.sort(self.enemyInfo[arg_88_1], function(arg_89_0, arg_89_1)
		if arg_89_0.sort ~= arg_89_1.sort then
			return arg_89_0.sort < arg_89_1.sort
		end
	end)

	return self.enemyInfo[arg_88_1]
end

function var_0_0:getUnlockEnemyData(arg_90_1)
	table.sort(self.enemyUnlockInfo[arg_90_1], function(arg_91_0, arg_91_1)
		if arg_91_0.sort ~= arg_91_1.sort then
			return arg_91_0.sort < arg_91_1.sort
		end
	end)

	return self.enemyUnlockInfo[arg_90_1]
end

function var_0_0:getEnemyNumber(arg_92_1)
	return (self.enemyInfo[arg_92_1] or nil) and (#self.enemyInfo[arg_92_1] or 0)
end

function var_0_0:getUnlockEnemyNumber(arg_93_1)
	return (self.enemyUnlockInfo[arg_93_1] or nil) and (#self.enemyUnlockInfo[arg_93_1] or 0)
end

function var_0_0.releaseAllData(arg_94_0)
	arg_94_0.threadStoryInfo = nil
	arg_94_0.threadUnlockInfo = nil
	arg_94_0.branchStoryInfo = nil
	arg_94_0.branchUnlockInfo = nil
	arg_94_0.eventStoryInfo = nil
	arg_94_0.eventUnlockInfo = nil
	arg_94_0.exploreStoryInfo = nil
	arg_94_0.exploreUnlockInfo = nil
	arg_94_0.girlInfo = nil
	arg_94_0.girlUnlockInfo = nil
	arg_94_0.helpGirlInfo = nil
	arg_94_0.helpGirlUnlockInfo = nil
	arg_94_0.teacherInfo = nil
	arg_94_0.enemyInfo = nil
	arg_94_0.enemyUnlockInfo = nil
	arg_94_0.foodInfo = nil
	arg_94_0.foodUnlockInfo = nil
	arg_94_0.partsInfo = nil
	arg_94_0.partsUnlockInfo = nil
	arg_94_0.medalInfo = nil
	arg_94_0.medalUnlockInfo = nil
	arg_94_0.weaponInfo = nil
	arg_94_0.weaponUnlockInfo = nil
end

return var_0_0
