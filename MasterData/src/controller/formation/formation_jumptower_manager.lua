local FormationJumptowerManager = class("FormationJumptowerManager", (require("controller.formation.base_formation_manager")))
local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")

FormationJumptowerManager.MULTITON_MSG = "FormationJumptowerManager instancealready constructed!"

function FormationJumptowerManager:ctor()
	FormationJumptowerManager.super.ctor(self)
end

local var_0_3 = 5

function FormationJumptowerManager:requestInfo(arg_2_1, arg_2_2, arg_2_3)
	self._mode = arg_2_1
	self._formationInfo = {
		{}
	}

	for iter_2_0 = 1, var_0_3 do
		self._formationInfo[1][iter_2_0] = {
			pos = iter_2_0
		}
	end

	local var_2_0 = activity_manager:getJumptowerUnlockServant(arg_2_1) or 208120

	if playermodel.haveServant[var_2_0] then
		self._formationInfo[1][1].fight_girl = var_2_0
	end

	self:handlerInfo()
end

function FormationJumptowerManager:handlerInfo(arg_3_1)
	self:updateLayer()
end

function FormationJumptowerManager:updateFormationInfo(arg_4_1, arg_4_2, arg_4_3)
	self._formationInfo[1][arg_4_3].fight_girl = arg_4_2
end

function FormationJumptowerManager:getFormationInfo()
	return self._formationInfo
end

function FormationJumptowerManager:getAssistsInfo()
	local var_6_0 = {}
	local var_6_1 = self:getFormationInfo()

	for iter_6_0 = 1, #var_6_1 do
		var_6_0[iter_6_0] = var_6_1[iter_6_0].assist or {}
	end

	return var_6_0
end

function FormationJumptowerManager:checkAdventureArray()
	local var_7_0 = self._formationInfo[1] or {}
	local var_7_1 = 0

	for iter_7_0 = 1, var_0_3 do
		if var_7_0[iter_7_0].fight_girl then
			var_7_1 = var_7_1 + 1
		end
	end

	if var_7_1 <= 0 then
		return false, 1
	end

	return true
end

local var_0_4 = {
	wind = true,
	water = true,
	fire = true,
	light = true,
	dark = true
}

function FormationJumptowerManager:checkIsSameColorTeam(arg_8_1)
	local var_8_0 = true

	if not arg_8_1 then
		return var_8_0
	end

	local levelmode_data = require("data.levelmode_data")
	local servant_data = require("data.servant_data")
	local model_data = require("data.model_data")

	if not levelmode_data[arg_8_1] then
		return var_8_0
	end

	local var_8_4 = levelmode_data[arg_8_1].ele_type or levelmode_data[arg_8_1].element_type

	if not var_8_4 then
		return var_8_0
	end

	if levelmode_data[arg_8_1].ele_type_show then
		var_8_4 = levelmode_data[arg_8_1].ele_type_show .. ",imaginary"
	end

	local var_8_5 = {}
	local var_8_6 = {}

	for iter_8_0 = 1, var_0_3 do
		table.insert(var_8_6, true)
	end

	for iter_8_1 in var_8_4:gmatch("([^,]+)") do
		table.insert(var_8_5, iter_8_1)
	end

	local var_8_7 = 0

	for iter_8_2 = 1, var_0_3 do
		if self._formationInfo[1][iter_8_2].fight_girl then
			var_8_7 = var_8_7 + 1

			local var_8_8 = false
			local var_8_9 = false

			for iter_8_3, iter_8_4 in ipairs(var_8_5) do
				if model_data[servant_data[self._formationInfo[1][iter_8_2].fight_girl].modelid][iter_8_4] then
					var_8_8 = true

					break
				end

				if var_0_4[iter_8_4] then
					var_8_9 = true
				end
			end

			if not var_8_8 and var_8_9 and model_data[servant_data[self._formationInfo[1][iter_8_2].fight_girl].modelid].imaginary then
				var_8_8 = true
			end

			var_8_6[iter_8_2] = var_8_8
		end
	end

	for iter_8_5, iter_8_6 in pairs(var_8_6) do
		if not iter_8_6 then
			var_8_0 = false

			break
		end
	end

	if not var_8_0 then
		if #var_8_5 == 1 then
			global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. L_SORT_ATTR[ATTR_INDEX[var_8_5[1]]] .. L_SPECIAL_JUMPTOWERLAYER.other2)
		else
			local var_8_10 = 1
			local var_8_11 = ""

			while var_8_5[var_8_10] do
				var_8_11 = var_8_10 == #var_8_5 and var_8_11 .. L_SORT_ATTR[ATTR_INDEX[var_8_5[var_8_10]]] or var_8_11 .. L_SORT_ATTR[ATTR_INDEX[var_8_5[var_8_10]]] .. "/"
				var_8_10 = var_8_10 + 1
			end

			if #var_8_5 > 4 and #var_8_5 <= 5 then
				global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. var_8_11 .. L_SPECIAL_JUMPTOWERLAYER.other2, nil, nil, nil, nil, 26)
			elseif #var_8_5 > 5 then
				global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. var_8_11 .. L_SPECIAL_JUMPTOWERLAYER.other2, nil, nil, nil, nil, 24)
			else
				global_ShowBlockWords(L_SPECIAL_JUMPTOWERLAYER.other1 .. var_8_11 .. L_SPECIAL_JUMPTOWERLAYER.other2)
			end
		end
	end

	if var_8_7 == 0 then
		var_8_0 = false

		global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[1], RISE_WORDS_FAIL)
	end

	return var_8_0
end

function FormationJumptowerManager:requestUpdateJumptowerGirl(arg_9_1, arg_9_2, arg_9_3)
	self:updateFormationInfo(arg_9_1, arg_9_2, arg_9_3)
	self:updateGirl()
end

function FormationJumptowerManager:requestOneTimeUpdateArray(arg_10_1, arg_10_2, arg_10_3)
	arg_10_1 = arg_10_1 or 1

	local var_10_0 = self:getFormationInfo()[arg_10_1]
	local audio_manager = require("controller.audio_manager")

	arg_10_2.assist = arg_10_2.assist or var_10_0.assist or {}

	require("network.network"):rpc("update_adventure_array_onekey", {
		mode = self._mode,
		battlearray = arg_10_2
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			self:updateFormationInfo(arg_11_0.array)
			self:oneTimeUpdateSuccess()

			local var_11_0 = {}

			for iter_11_0, iter_11_1 in pairs(arg_10_2) do
				if type(iter_11_1) == "table" then
					var_11_0[iter_11_0] = iter_11_1
				end
			end

			if arg_10_3 then
				arg_10_3(arg_11_0)
			end

			self:playVoiceByArray(var_10_0, var_11_0)
		elseif arg_11_0.result == 2 then
			global_ShowBlockWords("角色未解锁")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_11_0.result == 3 then
			global_ShowBlockWords("无效魂器")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_11_0.result == 4 then
			global_ShowBlockWords("魂器对应位置未设置角色")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_11_0.result == 5 then
			global_ShowBlockWords("设置了重复角色和魂器")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_11_0.result == 6 then
			global_ShowBlockWords("挂机阵容不能为空")
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

function FormationJumptowerManager:getAdvanceForcesOneTimeArray()
	local playermodel = require("model.playermodel")
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in pairs(playermodel.arrays[playermodel.curArray]) do
		if type(iter_12_1) == "table" then
			var_12_1[iter_12_0] = iter_12_1
		end
	end

	return var_12_1
end

return FormationJumptowerManager
