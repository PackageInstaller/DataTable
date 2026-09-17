local HorcruxDevourManager = class("HorcruxDevourManager", (require("controller.base_manager")))

HorcruxDevourManager.MULTITON_MSG = "HorcruxDevourManager instancealready constructed!"

local total_skill_data = require("data.total_skill_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")

function HorcruxDevourManager:ctor()
	HorcruxDevourManager.super.ctor(self)

	self._data = {}
	self._eatHorcruxSlotData = require("data/eat_horcrux_slot_data")
	self._eatHorcruxLimitData = require("data/eat_horcrux_limit_data")
	self._eatHorcruxRaceData = require("data/eat_horcrux_race_data")
end

function HorcruxDevourManager:requestInfo(arg_2_1)
	return
end

function HorcruxDevourManager:requestDisassembleHorcrux(arg_3_1, arg_3_2, arg_3_3)
	local playermodel = require("model.playermodel")

	require("network.network"):rpc("servant_disassemble_horcrux", {
		servantid = arg_3_1,
		pos = arg_3_2
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			playermodel.horcruxDevour[arg_3_1] = {}

			for iter_4_0 = 1, HORCRUX_DEVOUR_MAX do
				playermodel.horcruxDevour[arg_3_1][iter_4_0] = arg_4_0.servant_horcrux[iter_4_0] and arg_4_0.servant_horcrux[iter_4_0] or {}
			end

			if arg_4_0.cost_items and next(arg_4_0.cost_items) then
				local item_manager = require("controller.item_manager")

				for iter_4_1, iter_4_2 in pairs(arg_4_0.cost_items) do
					if iter_4_2.entityid and iter_4_2.num then
						item_manager:deleteItem(iter_4_2.entityid, iter_4_2.num)
					end
				end
			end

			if arg_4_0.horcrux then
				playermodel.items[arg_4_0.horcrux.entityid] = arg_4_0.horcrux
				playermodel.items[arg_4_0.horcrux.entityid].number = arg_4_0.horcrux.itemcount
				playermodel.horcruxServants[arg_4_0.horcrux.entityid] = nil
			end

			if arg_3_3 then
				arg_3_3()
			end

			sendNotification("DisassembleHorcruxSuccess")
			sendNotification("refreshHorcruxLayout")
		elseif arg_4_0.result == 2 then
			global_ShowBlockWords("学员不存在")
		elseif arg_4_0.result == 3 then
			global_ShowBlockWords("物品不足")
		elseif arg_4_0.result == 4 then
			global_ShowBlockWords("魂器不存在")
		elseif arg_4_0.result == 5 then
			global_ShowBlockWords("魂器信息错误")
		end
	end)
end

function HorcruxDevourManager:handlerInfo(arg_5_1)
	return
end

function HorcruxDevourManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function HorcruxDevourManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function HorcruxDevourManager:getTypeSkillId(arg_8_1)
	return self._eatHorcruxRaceData[arg_8_1].skill
end

function HorcruxDevourManager:getHorcruxDevourData(arg_9_1)
	local playermodel = require("model.playermodel")

	if playermodel.horcruxDevour[arg_9_1] then
		return playermodel.horcruxDevour[arg_9_1]
	end

	local var_9_1 = {}

	for iter_9_0 = 1, HORCRUX_DEVOUR_MAX do
		var_9_1[iter_9_0] = {}
	end

	return var_9_1
end

function HorcruxDevourManager:getUnlockLevel(arg_10_1)
	if self._eatHorcruxSlotData[arg_10_1] then
		return self._eatHorcruxSlotData[arg_10_1].lv
	end

	return 999
end

function HorcruxDevourManager:isUnlock(arg_11_1, arg_11_2)
	local playermodel = require("model.playermodel")

	if playermodel.haveServant[arg_11_1] then
		return (playermodel.cores[arg_11_1].level or 0) >= self:getUnlockLevel(arg_11_2)
	end

	return false
end

function HorcruxDevourManager:getCostItemId(arg_12_1)
	local var_12_1 = 0

	for iter_12_0 = 1, HORCRUX_DEVOUR_MAX do
		if self:getSkillInfo(arg_12_1, iter_12_0) then
			var_12_1 = iter_12_0
		else
			break
		end
	end

	return self._eatHorcruxLimitData[var_12_1].material_id, self._eatHorcruxLimitData[var_12_1].num
end

function HorcruxDevourManager:getSkillInfo(arg_13_1, arg_13_2)
	local playermodel = require("model.playermodel")

	if playermodel.horcruxDevour[arg_13_1] then
		if next(playermodel.horcruxDevour[arg_13_1][arg_13_2]) then
			playermodel.horcruxDevour[arg_13_1][arg_13_2].skillid2 = playermodel.horcruxDevour[arg_13_1][arg_13_2].skillid2 or 9000000

			return playermodel.horcruxDevour[arg_13_1][arg_13_2]
		end
	end

	return nil
end

function HorcruxDevourManager:getDevourHorcruxMinData(arg_14_1, arg_14_2)
	local playermodel = require("model.playermodel")
	local var_14_1 = 0

	while 1 <= HORCRUX_DEVOUR_MAX and self:isUnlock(arg_14_1, 1) do
		local var_14_2

		if playermodel.horcruxDevour[arg_14_1] then
			if next(playermodel.horcruxDevour[arg_14_1][1]) then
				var_14_1 = var_14_1 + 1
			end

			var_14_2 = 1 + 1
		else
			break
		end
	end

	return arg_14_2 and {
		star = self._eatHorcruxLimitData[var_14_1].ex_star,
		level = self._eatHorcruxLimitData[var_14_1].ex_lv
	} or {
		star = self._eatHorcruxLimitData[var_14_1].star,
		level = self._eatHorcruxLimitData[var_14_1].lv
	}
end

function HorcruxDevourManager:getDevourHorcruxMinDataFromIndex(arg_15_1, arg_15_2, arg_15_3)
	return arg_15_3 and {
		star = self._eatHorcruxLimitData[arg_15_2].ex_star,
		level = self._eatHorcruxLimitData[arg_15_2].ex_lv
	} or {
		star = self._eatHorcruxLimitData[arg_15_2].star,
		level = self._eatHorcruxLimitData[arg_15_2].lv
	}
end

function HorcruxDevourManager:getAttrBonus(arg_16_1)
	local var_16_0 = setmetatable({}, {
		__index = function(arg_17_0, arg_17_1)
			arg_17_0[arg_17_1] = 0

			return 0
		end
	})
	local playermodel = require("model.playermodel")

	if playermodel.horcruxDevour[arg_16_1] then
		for iter_16_0 = 1, HORCRUX_DEVOUR_MAX do
			if next(playermodel.horcruxDevour[arg_16_1][iter_16_0]) then
				var_16_0.damage = var_16_0.damage + (playermodel.horcruxDevour[arg_16_1][iter_16_0].damage or 0)
				var_16_0.hp = var_16_0.hp + (playermodel.horcruxDevour[arg_16_1][iter_16_0].hp or 0)
			end
		end
	end

	return var_16_0
end

function HorcruxDevourManager:getHorcruxSkillName(arg_18_1, arg_18_2)
	local playermodel = require("model.playermodel")
	local var_18_1 = total_skill_data[arg_18_1].name

	if playermodel.items[arg_18_2].horcrux_attr.enable_skill_idxs then
		local var_18_2 = playermodel.items[arg_18_2].horcrux_attr.star or 0

		if playermodel.items[arg_18_2].horcrux_attr.enable_skill_idxs[1] == 1 then
			if var_18_2 == 6 then
				var_18_1 = var_18_1 .. "+"
			elseif var_18_2 == 7 then
				var_18_1 = var_18_1 .. "++"
			elseif var_18_2 == 8 then
				var_18_1 = var_18_1 .. "Max"
			end
		end
	end

	return var_18_1
end

function HorcruxDevourManager:getHorcruxAttrs(arg_19_1)
	local playermodel = require("model.playermodel")
	local var_19_1 = self:getHorcruxDevourData(arg_19_1)
	local var_19_2 = {}

	for iter_19_0 = 1, #var_19_1 do
		if next(var_19_1[iter_19_0]) then
			var_19_2[item_data[playermodel.items[var_19_1[iter_19_0].horcrux].itemid].attr] = iter_19_0
		end
	end

	return var_19_2
end

function HorcruxDevourManager:hasHorcruxRaceTypeSkill(arg_20_1, arg_20_2)
	return servant_data[arg_20_1].race1 == require("controller/horcrux_manager"):getRaceByEntityid(arg_20_2)
end

function HorcruxDevourManager:hasHorcruxRaceTypeSkillByItemId(arg_21_1, arg_21_2)
	if not arg_21_2 then
		return false
	end

	return servant_data[arg_21_1].race1 == require("controller/horcrux_manager"):getRaceByItemid(arg_21_2)
end

function HorcruxDevourManager:getMinExCount(arg_22_1)
	local playermodel = require("model.playermodel")
	local var_22_1 = 0

	while 1 <= HORCRUX_DEVOUR_MAX and self:isUnlock(arg_22_1, 1) do
		local var_22_2

		if playermodel.horcruxDevour[arg_22_1] then
			if next(playermodel.horcruxDevour[arg_22_1][1]) then
				var_22_1 = var_22_1 + 1
			end

			var_22_2 = 1 + 1
		else
			break
		end
	end

	return self._eatHorcruxLimitData[var_22_1].ex_count
end

function HorcruxDevourManager:getExCountByIndex(arg_23_1, arg_23_2)
	local playermodel = require("model.playermodel")

	if arg_23_2 <= HORCRUX_DEVOUR_MAX and self:isUnlock(arg_23_1, arg_23_2) then
		if playermodel.horcruxDevour[arg_23_1] and next(playermodel.horcruxDevour[arg_23_1][arg_23_2]) then
			return self._eatHorcruxLimitData[arg_23_2 - 1].ex_count
		end

		return self:getMinExCount(arg_23_1)
	else
		return self:getMinExCount(arg_23_1)
	end
end

return HorcruxDevourManager
