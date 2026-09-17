local var_0_0 = {}
local playermodel = require("model.playermodel")
local model_manager = require("controller.model_manager")
local component_manager = require("controller.component_manager")
local weapon_manager = require("controller.weapon_manager")
local horcrux_manager = require("controller.horcrux_manager")
local array_manager = require("controller.array_manager")
local core_manager = require("controller.core_manager")
local photo_manager = require("controller.photo_manager")
local total_skill_data = require("data.total_skill_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local horcrux_data = require("data.horcrux_data")
local level_manager = require("controller.level_manager")
local chapter_data = require("data.chapter_data")
local var_0_17 = require("data.item_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local var_0_21 = 1
local var_0_22 = cc.c3b(255, 255, 255)
local var_0_23 = cc.c3b(0, 0, 0)
local var_0_24 = cc.c3b(255, 227, 72)
local var_0_25 = cc.c3b(0, 0, 0)

function var_0_0:getSoulFightCapacity(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
	local var_1_1 = arg_1_3
	local var_1_3

	if not arg_1_3 then
		var_1_1 = model_manager.new()

		var_0_0:initPlayerAttribute(var_1_1, arg_1_1, arg_1_7, arg_1_8)

		local var_1_4

		var_1_4, var_1_3 = component_manager:getSoulComponentlist(arg_1_1)

		var_0_0:updateComponentAttr(var_1_1, var_1_4)
	else
		local var_1_5

		var_1_5, var_1_3 = component_manager:getSoulComponentlist(arg_1_1)
	end

	var_1_3 = arg_1_5 and next(arg_1_5) and self:assumeUseOtherEquip(var_1_1, arg_1_1, arg_1_5) or var_1_3

	local var_1_6 = var_0_0:computeFightCapacity(var_1_1, var_1_3[1], arg_1_1, arg_1_4)

	if arg_1_2 ~= "number" then
		var_1_6 = global_trans_number(var_1_6)
	end

	return var_1_6
end

function var_0_0.initPlayerAttribute(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_1:initPlayerAttribute(arg_2_2)
	arg_2_1:updateFalseLevel(arg_2_3, arg_2_4)

	if playermodel.haveServant[arg_2_2] and playermodel.weaponId[arg_2_2] then
		arg_2_1:updateWeaponAttr((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_2_2]], nil, arg_2_2)))
	end
end

function var_0_0.updateComponentAttr(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:updateComponentAttr(arg_3_2)
end

function var_0_0.assumeUseOtherEquip(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.useComponent then
		local var_4_0 = {}

		if playermodel.component[arg_4_2] then
			for iter_4_0, iter_4_1 in pairs(playermodel.component[arg_4_2]) do
				table.insert(var_4_0, {
					itemid = playermodel.items[iter_4_1.id].itemid,
					attr = playermodel.items[iter_4_1.id].component_attr.attr,
					effect = playermodel.items[iter_4_1.id].component_attr.effect,
					extra = playermodel.items[iter_4_1.id].component_attr.extra
				})
			end
		end

		local var_4_1, var_4_2 = component_manager:getComponentlistByData(var_4_0, (require("controller.core_manager"):getServantCoreRank(arg_4_2)))

		var_0_0:updateComponentAttr(arg_4_1, var_4_1)

		return var_4_2
	end

	if arg_4_3.unuseComponent then
		local var_4_3 = {}

		for iter_4_2, iter_4_3 in pairs(playermodel.component[arg_4_2]) do
			local var_4_4 = {}

			if iter_4_3.id ~= arg_4_3.unuseComponent then
				var_4_4.itemid = playermodel.items[iter_4_3.id].itemid
				var_4_4.attr = playermodel.items[iter_4_3.id].component_attr.attr
				var_4_4.effect = playermodel.items[iter_4_3.id].component_attr.effect
				var_4_4.extra = playermodel.items[iter_4_3.id].component_attr.extra

				table.insert(var_4_3, var_4_4)
			end
		end

		local var_4_5, var_4_6 = component_manager:getComponentlistByData(var_4_3, (require("controller.core_manager"):getServantCoreRank(arg_4_2)))

		var_0_0:updateComponentAttr(arg_4_1, var_4_5)

		return var_4_6
	end

	if arg_4_3.useWeapon then
		arg_4_1:updateWeaponAttr((weapon_manager:getWeaponConfig(playermodel.items[arg_4_3.useWeapon], nil, arg_4_2)))
	end

	if arg_4_3.unuseWeapon then
		arg_4_1:updateWeaponAttr({})
	end
end

function var_0_0:isChangeEquipAfterCanPatrol(arg_5_1, arg_5_2)
	local var_5_0, var_5_1 = array_manager:getPatrolChpater(arg_5_1)

	if (chapter_data[var_5_0 .. "-" .. var_5_1].patrol_fight_power or 0) > self:getArrayFightCapacity(array_manager:getBattleArrayData(arg_5_1), arg_5_2) then
		return false
	end

	return true
end

function var_0_0:saveSoulAttr(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2
	local var_6_2

	self.servantid = arg_6_1

	if not var_6_0 then
		var_6_0 = model_manager.new()

		var_0_0:initPlayerAttribute(var_6_0, self.servantid)

		local var_6_3

		var_6_3, var_6_2 = component_manager:getSoulComponentlist(self.servantid)

		var_0_0:updateComponentAttr(var_6_0, var_6_3)
	else
		local var_6_4

		var_6_4, var_6_2 = component_manager:getSoulComponentlist(self.servantid)
	end

	self.componentAttrTbl = {}
	self.oldSoulAttr = {}

	for iter_6_0, iter_6_1 in pairs(COMPONENT_SUB_ATTR_INTRO) do
		self.componentAttrTbl[#self.componentAttrTbl + 1] = iter_6_0
	end

	for iter_6_2 = 1, #self.componentAttrTbl do
		self.oldSoulAttr[#self.oldSoulAttr + 1] = self.componentAttrTbl[iter_6_2] == "attackspeed" and var_6_0:getAttribute(self.componentAttrTbl[iter_6_2]) * (1 + var_6_0:getAttribute("extra_attackspeed")) or var_6_0:getAttribute(self.componentAttrTbl[iter_6_2])
		self.oldSoulAttr[iter_6_2] = self.oldSoulAttr[iter_6_2] or 0
	end

	self.oldSoulAttr[#self.oldSoulAttr + 1] = var_0_0:computeFightCapacity(var_6_0, var_6_2[1], self.servantid)
end

function var_0_0.getSoulAttrChangeValue(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = var_0_0:displaySoulAttrChangeValue(arg_7_1, arg_7_2, arg_7_3, true)
	local var_7_1 = {
		{},
		{},
		{}
	}

	for iter_7_0 = 1, #var_7_0[1] do
		local var_7_2 = split(var_7_0[1][iter_7_0], ":")

		var_7_1[1][#var_7_1[1] + 1] = var_7_2[1]
		var_7_1[2][#var_7_1[2] + 1] = var_7_2[2]
		var_7_1[3][#var_7_1[3] + 1] = var_7_0[2][iter_7_0]
	end

	return var_7_1
end

function var_0_0:displaySoulAttrChangeValue(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = arg_8_3
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = {}
	local var_8_5

	if not arg_8_3 then
		var_8_0 = model_manager.new()

		var_0_0:initPlayerAttribute(var_8_0, self.servantid, FIGHTTYPE_NORMAL)

		local var_8_6

		var_8_6, var_8_5 = component_manager:getSoulComponentlist(self.servantid)

		var_0_0:updateComponentAttr(var_8_0, var_8_6)
	else
		local var_8_7

		var_8_7, var_8_5 = component_manager:getSoulComponentlist(self.servantid)
	end

	for iter_8_0 = 1, #self.oldSoulAttr do
		if iter_8_0 == #self.oldSoulAttr then
			var_8_1[iter_8_0] = var_0_0:computeFightCapacity(var_8_0, var_8_5[1], self.servantid)
		else
			var_8_1[iter_8_0] = self.componentAttrTbl[iter_8_0] == "attackspeed" and var_8_0:getAttribute(self.componentAttrTbl[iter_8_0]) * (1 + var_8_0:getAttribute("extra_attackspeed")) or var_8_0:getAttribute(self.componentAttrTbl[iter_8_0])
			var_8_1[iter_8_0] = var_8_1[iter_8_0] or 0
		end

		local var_8_8 = var_8_1[iter_8_0] - self.oldSoulAttr[iter_8_0]

		if var_8_1[iter_8_0] - self.oldSoulAttr[iter_8_0] > 0 then
			var_8_8 = string.format("%f", var_8_8)
			var_8_8 = tonumber(var_8_8)
			var_8_8 = var_8_8 * 1000
			var_8_8 = math.floor(var_8_8)
			var_8_8 = var_8_8 / 1000
			var_8_2[iter_8_0] = FIGHT_ATTR_FORMAT(self.componentAttrTbl[iter_8_0], var_8_8)
			var_8_3[iter_8_0] = var_8_8
		else
			local var_8_9 = math.ceil(tonumber((string.format("%f", var_8_8))) * 1000) / 1000

			var_8_2[iter_8_0] = FIGHT_ATTR_FORMAT(self.componentAttrTbl[iter_8_0], var_8_9)
			var_8_3[iter_8_0] = var_8_9
		end
	end

	local var_8_10 = {
		{},
		{}
	}

	for iter_8_1 = 1, #var_8_2 - 1 do
		if var_8_3[iter_8_1] > 0 then
			var_8_10[1][#var_8_10[1] + 1] = (iter_8_1 == #var_8_2 and L_FIGHT_CAPACITY or COMPONENT_SUB_ATTR_INTRO[self.componentAttrTbl[iter_8_1]] or " ") .. ":+" .. var_8_2[iter_8_1]
			var_8_10[2][#var_8_10[2] + 1] = var_0_22
		end
	end

	for iter_8_2 = 1, #var_8_2 - 1 do
		if var_8_3[iter_8_2] < 0 then
			var_8_10[1][#var_8_10[1] + 1] = (iter_8_2 == #var_8_2 and L_FIGHT_CAPACITY or COMPONENT_SUB_ATTR_INTRO[self.componentAttrTbl[iter_8_2]] or " ") .. ":" .. var_8_2[iter_8_2]
			var_8_10[2][#var_8_10[2] + 1] = var_0_25
		end
	end

	if var_8_3[#var_8_2] < 0 then
		var_8_10[1][#var_8_10[1] + 1] = L_FIGHT_CAPACITY .. ":" .. var_8_2[#var_8_2]
		var_8_10[2][#var_8_10[2] + 1] = var_0_25
	end

	if var_8_3[#var_8_2] > 0 then
		var_8_10[1][#var_8_10[1] + 1] = L_FIGHT_CAPACITY .. ":+" .. var_8_2[#var_8_2]
		var_8_10[2][#var_8_10[2] + 1] = var_0_24
	end

	if arg_8_1 then
		for iter_8_3, iter_8_4 in pairs(arg_8_1) do
			var_8_10[1][#var_8_10[1] + 1] = iter_8_4
			var_8_10[2][#var_8_10[2] + 1] = arg_8_2[iter_8_3]
		end
	end

	if arg_8_4 then
		return var_8_10
	elseif #var_8_10[1] > 0 then
		LayerManager:pushInLayer("PopFightPowerLayer", {
			msg1 = var_8_10[1],
			finishCallback = arg_8_5
		})
	end
end

function var_0_0.saveArrayFightCapacity(arg_9_0, arg_9_1)
	arg_9_0.oldFightCapacityNum = var_0_0:getArrayFightCapacity(arg_9_1)
	arg_9_0.oldBattleInfo = arg_9_1
end

function var_0_0:displayArrayChangeValue(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = {
		{},
		{}
	}
	local var_10_1 = 0
	local var_10_2 = 0
	local var_10_4
	local var_10_5
	local var_10_6

	if arg_10_2 == 1 then
		for iter_10_0, iter_10_1 in pairs(self.oldBattleInfo) do
			if iter_10_1.fight_girl == arg_10_1[iter_10_0].fight_girl and iter_10_1.fight_girl ~= nil and iter_10_1.assist_girl ~= arg_10_1[iter_10_0].assist_girl then
				local var_10_8 = var_0_0:getAttr(iter_10_1.fight_girl)
				local var_10_9 = core_manager:getServantCoreRank(arg_10_1[iter_10_0].fight_girl)

				if arg_10_1[iter_10_0].assist_girl then
					var_10_4 = horcrux_manager:getHorcruxAssistConfigWithServant(arg_10_1[iter_10_0].assist_girl, var_10_9)
					var_10_6 = var_0_0:getAttr(horcrux_manager:getHorcruxItemid(arg_10_1[iter_10_0].assist_girl))

					local var_10_10 = horcrux_manager:getServantAttrAddPercent(var_10_6, global_get_all_servant_attrs(arg_10_1[iter_10_0].fight_girl))

					var_10_4.damage = var_10_4.damage * var_10_10.damage
					var_10_4.hp = var_10_4.hp * var_10_10.hp
					var_10_4.hp = math.floor(var_10_4.hp)
					var_10_4.damage = math.floor(var_10_4.damage)

					local var_10_11 = horcrux_manager:getHorcruxHLV(arg_10_1[iter_10_0].assist_girl)
				end

				if iter_10_1.assist_girl then
					var_10_5 = horcrux_manager:getHorcruxAssistConfigWithServant(iter_10_1.assist_girl, var_10_9)

					local var_10_12 = horcrux_manager:getServantAttrAddPercent(var_0_0:getAttr(horcrux_manager:getHorcruxItemid(iter_10_1.assist_girl)), global_get_all_servant_attrs(arg_10_1[iter_10_0].fight_girl))

					var_10_5.damage = var_10_5.damage * var_10_12.damage
					var_10_5.hp = var_10_5.hp * var_10_12.hp
					var_10_5.hp = math.floor(var_10_5.hp)
					var_10_5.damage = math.floor(var_10_5.damage)
				end

				local var_10_13

				if var_10_4 then
					var_10_13 = var_10_4.hp or 0

					local var_10_14

					if var_10_5 then
						var_10_14 = var_10_5.hp or 0
					end
				end

				var_10_1 = var_10_13 - var_10_14

				local var_10_15

				if var_10_4 then
					var_10_15 = var_10_4.damage or 0

					local var_10_16

					if var_10_5 then
						var_10_16 = var_10_5.damage or 0
					end
				end

				var_10_2 = var_10_15 - var_10_16

				if var_10_6 ~= nil then
					-- block empty
				end
			end
		end

		if nil ~= nil then
			if nil then
				var_10_0[1][#var_10_0[1] + 1] = L_FIGHT_CAPACITY_CHANGE_VALUE.Girls[1]
				var_10_0[2][#var_10_0[2] + 1] = var_0_22
			else
				var_10_0[1][#var_10_0[1] + 1] = L_FIGHT_CAPACITY_CHANGE_VALUE.Girls[2]
				var_10_0[2][#var_10_0[2] + 1] = var_0_23
			end
		end

		if var_10_1 > 0 then
			var_10_0[1][#var_10_0[1] + 1] = L_FIGHT_CAPACITY_ATTR[1] .. " +" .. var_10_1
			var_10_0[2][#var_10_0[2] + 1] = var_0_22
		else
			var_10_0[1][#var_10_0[1] + 1] = L_FIGHT_CAPACITY_ATTR[1] .. " " .. var_10_1
			var_10_0[2][#var_10_0[2] + 1] = var_0_23
		end

		if var_10_2 > 0 then
			var_10_0[1][#var_10_0[1] + 1] = L_FIGHT_CAPACITY_ATTR[2] .. " +" .. var_10_2
			var_10_0[2][#var_10_0[2] + 1] = var_0_22
		else
			var_10_0[1][#var_10_0[1] + 1] = L_FIGHT_CAPACITY_ATTR[2] .. " " .. var_10_2
			var_10_0[2][#var_10_0[2] + 1] = var_0_23
		end
	end

	local var_10_18 = var_0_0:getArrayFightCapacity(arg_10_1)

	if var_10_18 ~= self.oldFightCapacityNum then
		if var_10_18 > self.oldFightCapacityNum then
			var_10_0[1][#var_10_0[1] + 1] = L_FIGHT_CAPACITY .. ":+" .. global_trans_number(var_10_18 - self.oldFightCapacityNum)
			var_10_0[2][#var_10_0[2] + 1] = var_0_24
		else
			var_10_0[1][#var_10_0[1] + 1] = L_FIGHT_CAPACITY .. ":-" .. global_trans_number(self.oldFightCapacityNum - var_10_18)
			var_10_0[2][#var_10_0[2] + 1] = var_0_25
		end
	end

	var_10_0[1].finishCallback = arg_10_3

	if #var_10_0[1] == 0 then
		return
	end

	LayerManager:pushInLayer("PopFightPowerLayer", var_10_0[1], arg_10_4)
end

function var_0_0.displayNpcArrayChangeValue(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = {
		{},
		{}
	}
	local var_11_1 = 0
	local var_11_2 = 0
	local var_11_4
	local var_11_5
	local var_11_6

	for iter_11_0, iter_11_1 in pairs(arg_11_2) do
		if iter_11_1.girlInfo then
			iter_11_1.girlInfo.servantid = iter_11_1.girlInfo.servantId
		end

		if (function()
			if iter_11_1.npcid or arg_11_1[iter_11_0].npcid then
				return false
			end

			if iter_11_1.horcruxInfo and arg_11_1[iter_11_0].horcruxInfo and iter_11_1.horcruxInfo.entityid == arg_11_1[iter_11_0].horcruxInfo.entityid then
				return false
			end

			if not iter_11_1.horcruxInfo and not arg_11_1[iter_11_0].horcruxInfo then
				return false
			end

			if not iter_11_1.girlInfo then
				return false
			end

			return true
		end)() then
			local var_11_8 = var_0_0:getAttr(iter_11_1.girlInfo.servantid)
			local var_11_9 = iter_11_1.girlInfo.rank

			if arg_11_1[iter_11_0].horcruxInfo and arg_11_1[iter_11_0].horcruxInfo.entityid then
				var_11_4 = horcrux_manager:getHorcruxAssistConfigWithServant(arg_11_1[iter_11_0].horcruxInfo.entityid, var_11_9)
				var_11_6 = var_0_0:getAttr(horcrux_manager:getHorcruxItemid(arg_11_1[iter_11_0].horcruxInfo.entityid))

				local var_11_10 = horcrux_manager:getServantAttrAddPercent(var_11_6, global_get_all_servant_attrs(iter_11_1.girlInfo.servantid))

				var_11_4.damage = var_11_4.damage * var_11_10.damage
				var_11_4.hp = var_11_4.hp * var_11_10.hp
				var_11_4.hp = math.floor(var_11_4.hp)
				var_11_4.damage = math.floor(var_11_4.damage)

				local var_11_11 = horcrux_manager:getHorcruxHLV(arg_11_1[iter_11_0].horcruxInfo.entityid)
			else
				var_11_4 = {}
				var_11_6 = nil
			end

			if iter_11_1.horcruxInfo and iter_11_1.horcruxInfo.entityid then
				var_11_5 = horcrux_manager:getHorcruxAssistConfigWithServant(iter_11_1.horcruxInfo.entityid, var_11_9)

				local var_11_12 = var_0_0:getAttr(horcrux_manager:getHorcruxItemid(iter_11_1.horcruxInfo.entityid))
				local var_11_13 = horcrux_manager:getServantAttrAddPercent(var_11_6, global_get_all_servant_attrs(iter_11_1.girlInfo.servantid))

				var_11_5.damage = var_11_5.damage * var_11_13.damage
				var_11_5.hp = var_11_5.hp * var_11_13.hp
				var_11_5.hp = math.floor(var_11_5.hp)
				var_11_5.damage = math.floor(var_11_5.damage)
			else
				var_11_5 = {}
			end

			local var_11_15

			if var_11_4 then
				var_11_15 = var_11_4.hp or 0

				local var_11_16

				if var_11_5 then
					var_11_16 = var_11_5.hp or 0
				end
			end

			var_11_1 = var_11_15 - var_11_16

			local var_11_17

			if var_11_4 then
				var_11_17 = var_11_4.damage or 0

				local var_11_18

				if var_11_5 then
					var_11_18 = var_11_5.damage or 0
				end
			end

			var_11_2 = var_11_17 - var_11_18

			if var_11_6 ~= nil then
				-- block empty
			end
		end
	end

	if nil ~= nil then
		if nil then
			var_11_0[1][#var_11_0[1] + 1] = L_FIGHT_CAPACITY_CHANGE_VALUE.Girls[1]
			var_11_0[2][#var_11_0[2] + 1] = var_0_22
		else
			var_11_0[1][#var_11_0[1] + 1] = L_FIGHT_CAPACITY_CHANGE_VALUE.Girls[2]
			var_11_0[2][#var_11_0[2] + 1] = var_0_23
		end
	end

	if var_11_1 > 0 then
		var_11_0[1][#var_11_0[1] + 1] = L_FIGHT_CAPACITY_ATTR[1] .. " +" .. var_11_1
		var_11_0[2][#var_11_0[2] + 1] = var_0_22
	else
		var_11_0[1][#var_11_0[1] + 1] = L_FIGHT_CAPACITY_ATTR[1] .. " " .. var_11_1
		var_11_0[2][#var_11_0[2] + 1] = var_0_23
	end

	if var_11_2 > 0 then
		var_11_0[1][#var_11_0[1] + 1] = L_FIGHT_CAPACITY_ATTR[2] .. " +" .. var_11_2
		var_11_0[2][#var_11_0[2] + 1] = var_0_22
	else
		var_11_0[1][#var_11_0[1] + 1] = L_FIGHT_CAPACITY_ATTR[2] .. " " .. var_11_2
		var_11_0[2][#var_11_0[2] + 1] = var_0_23
	end

	local var_11_20 = var_0_0:getNpcArrayFightCapacity(arg_11_1)

	if var_11_20 ~= arg_11_3 then
		if arg_11_3 < var_11_20 then
			var_11_0[1][#var_11_0[1] + 1] = L_FIGHT_CAPACITY .. ":+" .. global_trans_number(var_11_20 - arg_11_3)
			var_11_0[2][#var_11_0[2] + 1] = var_0_24
		else
			var_11_0[1][#var_11_0[1] + 1] = L_FIGHT_CAPACITY .. ":-" .. global_trans_number(arg_11_3 - var_11_20)
			var_11_0[2][#var_11_0[2] + 1] = var_0_25
		end
	end

	var_11_0[1].finishCallback = arg_11_4

	if #var_11_0[1] == 0 then
		return
	end

	LayerManager:pushInLayer("PopFightPowerLayer", var_11_0[1])
end

function var_0_0.getAttr(arg_13_0, arg_13_1)
	if servant_data[arg_13_1] then
		return global_get_model_attr(servant_data[arg_13_1].modelid)
	else
		return global_get_model_attr(horcrux_data[arg_13_1].model)
	end
end

function var_0_0.getArrayFightCapacity(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_1) do
		if iter_14_1.fight_girl then
			var_14_0 = arg_14_2 and iter_14_1.fight_girl == arg_14_2.servantid and var_14_0 + var_0_0:getSoulFightCapacity(iter_14_1.fight_girl, "number", nil, iter_14_1.assist_girl, arg_14_2, arg_14_3 or arg_14_1, arg_14_4, arg_14_5) or var_14_0 + var_0_0:getSoulFightCapacity(iter_14_1.fight_girl, "number", nil, iter_14_1.assist_girl, nil, arg_14_3 or arg_14_1, arg_14_4, arg_14_5)
		end
	end

	return var_14_0
end

local function var_0_26(arg_15_0)
	local var_15_0 = {
		majorlist = {
			science_point = arg_15_0.science_point,
			star = arg_15_0.star,
			soulid = arg_15_0.soulid,
			servantid = arg_15_0.servantid,
			contract = arg_15_0.contract,
			servantskin = arg_15_0.servantskin
		},
		component = arg_15_0.component,
		horcrux = arg_15_0.horcrux
	}

	if arg_15_0.weapon then
		local var_15_1 = {
			itemid = arg_15_0.weapon.itemid
		}
		local var_15_2 = {
			exp = arg_15_0.weapon.exp,
			level = arg_15_0.weapon.level
		}

		var_15_2.nowStars = arg_15_0.weapon.nowStars or 0
		var_15_1.weapon_attr = var_15_2
		var_15_0.weapon = var_15_1
	end

	return var_15_0
end

function var_0_0.getNpcFightCapacity(arg_16_0, arg_16_1)
	if npc_fightconfig_data[arg_16_1].npcsoulid then
		return 0
	end

	local var_16_0 = var_0_26(npc_fightconfig_data[arg_16_1])
	local var_16_1 = model_manager.new()

	var_16_1:initPvpAttribute(var_16_0.majorlist)

	local var_16_2, var_16_3 = component_manager:getComponentlistByData(var_16_0.component)

	var_16_1:updateComponentAttr(var_16_2)

	if var_16_0.weapon then
		var_16_1:updateWeaponAttr((weapon_manager:getWeaponConfig(var_16_0.weapon, var_16_0.majorlist.skill1Level)))
	end

	local var_16_4 = var_0_0:computeFightCapacity(var_16_1, var_16_3[1], npc_fightconfig_data[arg_16_1], npc_fightconfig_data[arg_16_1].horcrux)

	if type(var_16_4) ~= "number" then
		var_16_4 = global_trans_number(var_16_4)
	end

	return var_16_4
end

function var_0_0.getSubUsingFightCapacity(arg_17_0, arg_17_1)
	local var_17_0 = var_0_26(arg_17_1)
	local var_17_1 = model_manager.new()

	var_17_1:initPvpAttribute(var_17_0.majorlist)

	local var_17_2, var_17_3 = component_manager:getComponentlistByData(var_17_0.component)

	var_17_1:updateComponentAttr(var_17_2)

	if var_17_0.weapon then
		var_17_1:updateWeaponAttr((weapon_manager:getWeaponConfig(var_17_0.weapon, var_17_0.majorlist.skill1Level)))
	end

	local var_17_4 = var_0_0:computeSubFightCapacityNew(var_17_1, var_17_3[1], arg_17_1, arg_17_1.horcrux)

	if type(var_17_4) ~= "number" then
		var_17_4 = global_trans_number(var_17_4)
	end

	return var_17_4
end

function var_0_0.getSubUsingArrayFightCapacity(arg_18_0, arg_18_1)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		var_18_0 = var_18_0 + var_0_0:getSubUsingFightCapacity(iter_18_1)
	end

	return var_18_0
end

function var_0_0.getNpcArrayFightCapacity(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in pairs(arg_19_1) do
		if iter_19_1.npcid then
			var_19_0 = var_19_0 + var_0_0:getNpcFightCapacity(iter_19_1.npcid)
		elseif iter_19_1.girlInfo then
			var_19_0 = var_19_0 + var_0_0:getSoulFightCapacity(iter_19_1.girlInfo.servantId, "number", nil, (iter_19_1.horcruxInfo or nil) and (iter_19_1.horcruxInfo.entityid or nil), nil, arg_19_2 or arg_19_1)
		end
	end

	return var_19_0
end

function var_0_0.split(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = {}

	while true do
		local var_20_1 = string.find(arg_20_1, arg_20_2, 1)

		if not var_20_1 then
			var_20_0[1] = string.sub(arg_20_1, 1, string.len(arg_20_1))

			break
		end

		var_20_0[1] = string.sub(arg_20_1, 1, var_20_1 - 1)

		local var_20_2 = var_20_1 + string.len(arg_20_2)
	end

	return var_20_0
end

function var_0_0:showUpgrade(arg_21_1, arg_21_2)
	local var_21_0 = {}
	local var_21_1 = {}

	for iter_21_0 = 1, #arg_21_1 do
		if string.find(arg_21_1[iter_21_0], L_FIGHT_CAPACITY) then
			var_21_1[1] = self:split(arg_21_1[iter_21_0], ":")
		elseif string.find(arg_21_1[iter_21_0], "+") then
			var_21_0[1] = self:split(arg_21_1[iter_21_0], ":")
		end
	end

	local var_21_7 = math.floor(math.floor(#var_21_0 / 2 + #var_21_0 % 2) / 2)
	local var_21_8 = ""

	for iter_21_1 = 1, #var_21_0 do
		if iter_21_1 ~= 1 then
			var_21_8 = var_21_8 .. "   "
		end

		var_21_8 = var_21_8 .. var_21_0[iter_21_1][1] .. ":" .. var_21_0[iter_21_1][2]
	end

	global_ShowBlockWords(var_21_8, arg_21_2 or cc.c3b(1, 181, 253))
end

function var_0_0.getHorcruxAddition(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_3 and horcrux_manager:getHorcruxAssistConfigWithServant(arg_22_1, (core_manager:getServantCoreRank(arg_22_3))) or horcrux_manager:getHorcruxAssistConfig(arg_22_1)
	local var_22_1 = (math.floor(var_22_0.hp) / 30 + math.floor(var_22_0.damage)) * math.pow(1.25, #horcrux_manager:getHorcruxSkills(arg_22_1)) * var_0_21

	if arg_22_2 then
		return var_22_1
	else
		return global_trans_number(var_22_1)
	end
end

function var_0_0.setTestSciencePoint(arg_23_0, arg_23_1)
	arg_23_0.testSciencePoint = arg_23_1
end

setmetatable(FIGHT_CAPACITY_TRANS, {
	__index = function(arg_25_0, arg_25_1)
		return 1
	end
})

function var_0_0:computeSubFightCapacityNew(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_1 = {
		hp = 0,
		damage = 0
	}

	if arg_26_4 then
		local var_26_2 = self:getAttr(arg_26_3.servantid)
		local var_26_3 = horcrux_manager:getSubHorcruxAssistConfigWithServant(arg_26_4, arg_26_3.servantrank)

		var_26_1 = {
			hp = var_26_3.hp,
			damage = var_26_3.damage
		}

		local var_26_4 = horcrux_manager:getServantAttrAddPercent(self:getAttr(arg_26_4.itemid), global_get_all_servant_attrs(arg_26_3.servantid))

		var_26_1.damage = var_26_1.damage * var_26_4.damage
		var_26_1.hp = var_26_1.hp * var_26_4.hp
		var_26_1.hp = math.floor(var_26_1.hp)
		var_26_1.damage = math.floor(var_26_1.damage)
	end

	local function var_26_6(arg_27_0)
		local var_27_0 = 1

		if arg_27_0 == "add_hp" then
			var_27_0 = arg_26_1:getAttribute("hp") - arg_26_1:getInitialHp()
		elseif arg_27_0 == "hp" then
			var_27_0 = arg_26_1:getAttribute(arg_27_0) or 1

			if FIGHT_CAPACITY_TRANS[arg_27_0] then
				var_27_0 = var_27_0 * FIGHT_CAPACITY_TRANS[arg_27_0]
			end

			var_27_0 = var_27_0 + var_26_1.hp
		elseif arg_27_0 == "damage" then
			var_27_0 = arg_26_1:getAttribute(arg_27_0) or 1

			if FIGHT_CAPACITY_TRANS[arg_27_0] then
				var_27_0 = var_27_0 * FIGHT_CAPACITY_TRANS[arg_27_0]
			end

			var_27_0 = var_27_0 + var_26_1.damage
		else
			var_27_0 = arg_26_1:getAttribute(arg_27_0) or 1

			if FIGHT_CAPACITY_TRANS[arg_27_0] then
				var_27_0 = var_27_0 * FIGHT_CAPACITY_TRANS[arg_27_0]
			end
		end

		return var_27_0
	end

	return var_26_6("science_point") * (math.pow(var_26_6("range") / 120, 0.5) + var_26_6("attackspeed") + var_26_6("strike") * (0.5 + var_26_6("strike_damage_add")) + var_26_6("critical") * (1 + var_26_6("cri_damage_add")) + var_26_6("extra_attack") + var_26_6("hematophagy") / 6 * 2.5 + var_26_6("extra_rage") * 1.25 + var_26_6("dodge") * var_26_6("dodge_damage_add") * 2.5 / 2.25 + var_26_6("defence") / (var_26_6("defence") + 600) + var_26_6("healpoint") * 20 + var_26_6("extra_defence")) + var_26_6("hp") / 60 + var_26_6("damage") / 2 + (servant_data[arg_26_3.servantid].skill_change or 0) * var_26_6("science_point")
end

function var_0_0:computeFightCapacityNew(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0 = 0

	if type(arg_28_3) == "table" then
		local var_28_1 = {
			hp = 0,
			damage = 0
		}

		if arg_28_4 and type(arg_28_4) == "table" then
			var_28_1.hp = arg_28_4.hfac * (arg_28_4.hlv + 2)
			var_28_1.damage = arg_28_4.dfac * (arg_28_4.hlv + 2)
		end

		local var_28_2 = servant_data[arg_28_3.servantid].modelid

		local function var_28_3(arg_29_0)
			local var_29_0 = 1

			if arg_29_0 == "add_hp" then
				var_29_0 = 0
			elseif arg_29_0 == "hp" then
				var_29_0 = model_data[var_28_2].hpFactor * arg_28_3.science_point
			elseif arg_29_0 == "damage" then
				var_29_0 = model_data[var_28_2].damageFactor * arg_28_3.science_point
			elseif arg_29_0 == "hpFactor" then
				var_29_0 = model_data[var_28_2].damageFactor
			else
				var_29_0 = model_data[var_28_2][arg_29_0] or 0

				if FIGHT_CAPACITY_TRANS[arg_29_0] then
					var_29_0 = var_29_0 * FIGHT_CAPACITY_TRANS[arg_29_0]
				end
			end

			return var_29_0
		end

		var_28_0 = var_28_3("science_point") * (math.pow(var_28_3("range") / 120, 0.5) + var_28_3("attackspeed") + var_28_3("strike") * (0.5 + var_28_3("strike_damage_add")) + var_28_3("critical") * (1 + var_28_3("cri_damage_add")) + var_28_3("extra_attack") + var_28_3("hematophagy") / 6 * 2.5 + var_28_3("extra_rage") * 1.25 + var_28_3("dodge") * var_28_3("dodge_damage_add") * 2.5 / 2.25 + var_28_3("defence") / (var_28_3("defence") + 600) + var_28_3("healpoint") * 20 + var_28_3("extra_defence")) + var_28_3("hp") / 60 + var_28_3("damage") / 2 + (servant_data[arg_28_3.servantid].skill_change or 0) * var_28_3("science_point")
	else
		local var_28_4 = {
			hp = 0,
			damage = 0
		}

		if arg_28_4 then
			local var_28_5 = self:getAttr(arg_28_3)
			local var_28_6 = horcrux_manager:getHorcruxAssistConfigWithServant(arg_28_4, (core_manager:getServantCoreRank(arg_28_3)))

			var_28_4 = {
				hp = var_28_6.hp,
				damage = var_28_6.damage
			}

			local var_28_7 = horcrux_manager:getServantAttrAddPercent(self:getAttr(horcrux_manager:getHorcruxItemid(arg_28_4)), global_get_all_servant_attrs(arg_28_3))

			var_28_4.damage = var_28_4.damage * var_28_7.damage
			var_28_4.hp = var_28_4.hp * var_28_7.hp
			var_28_4.hp = math.floor(var_28_4.hp)
			var_28_4.damage = math.floor(var_28_4.damage)
		end

		local var_28_8 = {}

		table.insert(var_28_8, "servantid = " .. arg_28_3)

		local function var_28_9(arg_30_0)
			local var_30_0 = 1

			if arg_30_0 == "add_hp" then
				var_30_0 = arg_28_1:getAttribute("hp") - arg_28_1:getAttribute("science_point") * arg_28_1:getFactorAttribute("hpFactor")
			elseif arg_30_0 == "hp" then
				var_30_0 = arg_28_1:getAttribute(arg_30_0) or 1

				if FIGHT_CAPACITY_TRANS[arg_30_0] then
					var_30_0 = var_30_0 * FIGHT_CAPACITY_TRANS[arg_30_0]
				end

				var_30_0 = var_30_0 + var_28_4.hp
			elseif arg_30_0 == "damage" then
				var_30_0 = arg_28_1:getAttribute(arg_30_0) or 1

				if FIGHT_CAPACITY_TRANS[arg_30_0] then
					var_30_0 = var_30_0 * FIGHT_CAPACITY_TRANS[arg_30_0]
				end

				var_30_0 = var_30_0 + var_28_4.damage
			else
				var_30_0 = arg_28_1:getAttribute(arg_30_0) or 1

				if FIGHT_CAPACITY_TRANS[arg_30_0] then
					var_30_0 = var_30_0 * FIGHT_CAPACITY_TRANS[arg_30_0]
				end
			end

			table.insert(var_28_8, arg_30_0 .. " = " .. var_30_0)

			return var_30_0
		end

		var_28_0 = var_28_9("science_point") * (math.pow(var_28_9("range") / 120, 0.5) + var_28_9("attackspeed") + var_28_9("strike") * (0.5 + var_28_9("strike_damage_add")) + var_28_9("critical") * (1 + var_28_9("cri_damage_add")) + var_28_9("extra_attack") + var_28_9("hematophagy") / 6 * 2.5 + var_28_9("extra_rage") * 1.25 + var_28_9("dodge") * var_28_9("dodge_damage_add") * 2.5 / 2.25 + var_28_9("defence") / (var_28_9("defence") + 600) + var_28_9("healpoint") * 20 + var_28_9("extra_defence")) + var_28_9("hp") / 60 + var_28_9("damage") / 2 + (servant_data[arg_28_3].skill_change or 0) * var_28_9("science_point")
	end

	return var_28_0
end

function var_0_0:computeFightCapacity(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	return math.ceil(self:computeFightCapacityNew(arg_31_1, arg_31_2, arg_31_3, arg_31_4))
end

function var_0_0.getEnemyArrayFightPower(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = var_0_0:GetBossOrEnemyInfo(arg_32_1, arg_32_2)
	local var_32_1 = 0

	if var_32_0.boss then
		var_32_1 = var_32_1 + var_0_0:getEnemyFightCapacity(arg_32_1, var_32_0.boss.id)
	end

	if var_32_0.monster then
		for iter_32_0 = 1, #var_32_0.monster do
			var_32_1 = var_32_1 + var_0_0:getEnemyFightCapacity(arg_32_1, var_32_0.monster[iter_32_0].id)
		end
	end

	return var_32_1
end

function var_0_0.getBossOrEnemyInfo(arg_33_0, arg_33_1, arg_33_2)
	chapter_data = require("data.chapter_data")

	local var_33_1 = level_manager.loadLevelData(arg_33_1)
	local var_33_4 = level_manager.loadMonsterData(arg_33_1)
	local var_33_6 = (function(arg_34_0)
		local var_34_0 = {
			monster = {}
		}

		if arg_34_0.boss then
			var_34_0.boss = arg_34_0.boss
		end

		local var_34_1 = 1

		while arg_34_0["monster" .. var_34_1] do
			var_34_0.monster[var_34_1] = arg_34_0["monster" .. var_34_1]
			var_34_1 = var_34_1 + 1
		end

		local var_34_2 = level_manager.loadMonsterTeamData(arg_33_1)

		if arg_34_0["subteam" .. var_34_1] then
			var_34_0.boss = {}
		end

		while arg_34_0["subteam" .. var_34_1] do
			if var_34_2[arg_34_0["subteam" .. var_34_1]].boss then
				table.insert(var_34_0.boss, var_34_2[arg_34_0["subteam" .. var_34_1]].boss)
			end

			local var_34_3 = 1

			while var_34_2[arg_34_0["subteam" .. var_34_1]]["monster" .. var_34_3] do
				table.insert(var_34_0.monster, var_34_2[arg_34_0["subteam" .. var_34_1]]["monster" .. var_34_3])

				var_34_3 = var_34_3 + 1
			end

			var_34_1 = var_34_1 + 1
		end

		return var_34_0
	end)(level_manager.loadMonsterTeamData(arg_33_1)[tostring(chapter_data[arg_33_1 .. "-" .. arg_33_2].bigboss)])
	local var_33_7 = {}

	if var_33_6.boss then
		if type(var_33_6.boss) ~= "table" then
			local var_33_8 = {}

			var_33_8.name = model_data[var_33_4[var_33_6.boss].modelid].main_name or model_data[var_33_4[var_33_6.boss].modelid].name
			var_33_7.boss = var_33_8
			var_33_7.boss.icon = model_data[var_33_4[var_33_6.boss].modelid].cute_role
			var_33_7.boss.level = var_33_4[var_33_6.boss].monster_level
			var_33_7.boss.modelid = var_33_4[var_33_6.boss].modelid
			var_33_7.boss.id = var_33_6.boss
		elseif next(var_33_6.boss) ~= nil then
			var_33_7.boss = {}

			for iter_33_0 = 1, #var_33_6.boss do
				assert(var_33_4[var_33_6.boss[iter_33_0]], var_33_6.boss[iter_33_0])

				local var_33_9 = {}

				var_33_9.name = model_data[var_33_4[var_33_6.boss[iter_33_0]].modelid].main_name or model_data[var_33_4[var_33_6.boss[iter_33_0]].modelid].name
				var_33_7.boss[iter_33_0] = var_33_9
				var_33_7.boss[iter_33_0].icon = model_data[var_33_4[var_33_6.boss[iter_33_0]].modelid].cute_role
				var_33_7.boss[iter_33_0].level = var_33_4[var_33_6.boss[iter_33_0]].monster_level
				var_33_7.boss[iter_33_0].modelid = var_33_4[var_33_6.boss[iter_33_0]].modelid
				var_33_7.boss[iter_33_0].id = var_33_6.monster[iter_33_0]
			end
		end
	end

	if next(var_33_6.monster) ~= nil then
		var_33_7.monster = {}

		for iter_33_1 = 1, #var_33_6.monster do
			assert(var_33_4[var_33_6.monster[iter_33_1]], var_33_6.monster[iter_33_1])

			local var_33_10 = {}

			var_33_10.name = model_data[var_33_4[var_33_6.monster[iter_33_1]].modelid].main_name or model_data[var_33_4[var_33_6.monster[iter_33_1]].modelid].name
			var_33_7.monster[iter_33_1] = var_33_10
			var_33_7.monster[iter_33_1].icon = model_data[var_33_4[var_33_6.monster[iter_33_1]].modelid].cute_role
			var_33_7.monster[iter_33_1].modelid = var_33_4[var_33_6.monster[iter_33_1]].modelid
			var_33_7.monster[iter_33_1].id = var_33_6.monster[iter_33_1]
		end
	end

	return var_33_7
end

local var_0_29 = FIGHT_CAPACITY_TRANS

setmetatable(FIGHT_CAPACITY_TRANS, {
	__index = function(arg_35_0, arg_35_1)
		return 1
	end
})

function var_0_0.getEnemyFightCapacity(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = level_manager.loadMonsterData(arg_36_1 or 1)[arg_36_2 or 120006001]

	while var_36_0["horcruxskill_" .. 1] do
		-- block empty
	end

	local var_36_2 = {}

	var_36_2.strike = var_36_0.strike or 0
	var_36_2.strike_damage_add = var_36_0.strike_damage_add or 0
	var_36_2.critical = var_36_0.critical or 0
	var_36_2.cri_damage_add = var_36_0.cri_damage_add or 0
	var_36_2.science = var_36_0.damage_point or 0
	var_36_2.add_damage = var_36_0.damage or 0
	var_36_2.force = model_data[var_36_0.modelid].force or 0
	var_36_2.extra_attack = var_36_0.extra_attack or 0
	var_36_2.add_hp = var_36_0.hp or 0
	var_36_2.damageFactor = model_data[var_36_0.modelid].damageFactor
	var_36_2.hpFactor = model_data[var_36_0.modelid].hpFactor
	var_36_2.healpoint = var_36_0.healpoint or 0
	var_36_2.healrate = var_36_0.healrate or 0
	var_36_2.extra_defence = var_36_0.extra_defence or 0
	var_36_2.defence = (var_36_0.defence or 0) + (model_data[var_36_0.modelid].defence or 0)
	var_36_2.dodge = var_36_0.dodge or 0
	var_36_2.dodge_damage_add = var_36_0.dodge_damage_add or 0
	var_36_2.reforce = model_data[var_36_0.modelid].reforce or 0
	var_36_2.range = model_data[var_36_0.modelid].range or 0
	var_36_2.attackspeed = model_data[var_36_0.modelid].attackspeed or 1
	var_36_2.hematophagy = var_36_0.hematophagy or 0
	var_36_2.extra_rage = var_36_0.extra_rage or 0

	if arg_36_3 then
		-- block empty
	end

	local function var_36_5(arg_39_0)
		local var_39_0 = {
			science_point = function()
				return var_36_2.science
			end,
			range = function()
				return var_36_2.range
			end,
			attackspeed = function(...)
				return var_36_2.attackspeed
			end,
			strike = function(...)
				return var_36_2.strike
			end,
			strike_damage_add = function(...)
				return var_36_2.strike_damage_add
			end,
			critical = function(...)
				return var_36_2.critical
			end,
			cri_damage_add = function(...)
				return var_36_2.cri_damage_add
			end,
			extra_attack = function(...)
				return var_36_2.extra_attack
			end,
			hematophagy = function(...)
				return var_36_2.hematophagy
			end,
			dodge = function(...)
				return var_36_2.dodge
			end,
			extra_rage = function(...)
				return var_36_2.extra_rage
			end,
			dodge_damage_add = function(...)
				return var_36_2.dodge_damage_add
			end,
			defence = function(...)
				return var_36_2.defence
			end,
			healrate = function(...)
				return var_36_2.healrate
			end,
			extra_defence = function(...)
				return var_36_2.extra_defence
			end,
			hp = function(...)
				return var_36_2.add_hp + var_36_2.science * var_36_2.hpFactor
			end,
			damage = function(...)
				return var_36_2.add_damage + var_36_2.science * var_36_2.damageFactor
			end,
			healpoint = function(...)
				return var_36_2.healpoint
			end
		}
		local var_39_1 = 0

		if var_39_0[arg_39_0] then
			var_39_1 = var_39_0[arg_39_0]()
			var_39_1 = var_39_1 * var_0_29[arg_39_0]
		end

		return var_39_1
	end

	return math.ceil(var_36_5("science_point") * (math.pow(var_36_5("range") / 120, 0.5) + var_36_5("attackspeed") + var_36_5("strike") * (0.5 + var_36_5("strike_damage_add")) + var_36_5("critical") * (1 + var_36_5("cri_damage_add")) + var_36_5("extra_attack") * 2.5 + var_36_5("hematophagy") / 2 * 2.5 + var_36_5("extra_rage") * 1.25 + var_36_5("dodge") * var_36_5("dodge_damage_add") / 2 * 5 + var_36_5("defence") / (var_36_5("defence") + 600) + var_36_5("healpoint") * 20 + var_36_5("extra_defence")) + var_36_5("hp") / 60 + var_36_5("damage") / 2)
end

function var_0_0.getExploreEnemyFightCapacity(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	local var_58_0 = require("controller.explore_manager").getCurData("monster", arg_58_1 or 1)[arg_58_2 or 120006001]

	if not var_58_0.hp_correct then
		-- block empty
	end

	if not var_58_0.damage_correct then
		-- block empty
	end

	local var_58_3 = 0

	while var_58_0["horcruxskill_" .. 1] do
		var_58_3 = var_58_3 + 1
	end

	local var_58_5 = {}

	var_58_5.strike = var_58_0.strike or 0
	var_58_5.strike_damage_add = var_58_0.strike_damage_add or 0
	var_58_5.critical = var_58_0.critical or 0
	var_58_5.cri_damage_add = var_58_0.cri_damage_add or 0
	var_58_5.science = var_58_0.damage_point or 0
	var_58_5.add_damage = var_58_0.damage or 0
	var_58_5.force = model_data[var_58_0.modelid].force or 0
	var_58_5.extra_attack = var_58_0.extra_attack or 0
	var_58_5.add_hp = var_58_0.hp or 0
	var_58_5.damageFactor = model_data[var_58_0.modelid].damageFactor
	var_58_5.hpFactor = model_data[var_58_0.modelid].hpFactor
	var_58_5.healpoint = var_58_0.healpoint or 0
	var_58_5.healrate = var_58_0.healrate or 0
	var_58_5.extra_defence = var_58_0.extra_defence or 0
	var_58_5.defence = (var_58_0.defence or 0) + (model_data[var_58_0.modelid].defence or 0)
	var_58_5.dodge = var_58_0.dodge or 0
	var_58_5.dodge_damage_add = var_58_0.dodge_damage_add or 0
	var_58_5.reforce = model_data[var_58_0.modelid].reforce or 0
	var_58_5.range = model_data[var_58_0.modelid].range or 0
	var_58_5.attackspeed = model_data[var_58_0.modelid].attackspeed or 1
	var_58_5.hematophagy = var_58_0.hematophagy or 0
	var_58_5.extra_rage = var_58_0.extra_rage or 0

	if arg_58_3 then
		-- block empty
	end

	local function var_58_8(arg_61_0)
		local var_61_0 = {
			science_point = function()
				return var_58_5.science
			end,
			range = function()
				return var_58_5.range
			end,
			attackspeed = function(...)
				return var_58_5.attackspeed
			end,
			strike = function(...)
				return var_58_5.strike
			end,
			strike_damage_add = function(...)
				return var_58_5.strike_damage_add
			end,
			critical = function(...)
				return var_58_5.critical
			end,
			cri_damage_add = function(...)
				return var_58_5.cri_damage_add
			end,
			extra_attack = function(...)
				return var_58_5.extra_attack
			end,
			hematophagy = function(...)
				return var_58_5.hematophagy
			end,
			dodge = function(...)
				return var_58_5.dodge
			end,
			extra_rage = function(...)
				return var_58_5.extra_rage
			end,
			dodge_damage_add = function(...)
				return var_58_5.dodge_damage_add
			end,
			defence = function(...)
				return var_58_5.defence
			end,
			healrate = function(...)
				return var_58_5.healrate
			end,
			extra_defence = function(...)
				return var_58_5.extra_defence
			end,
			hp = function(...)
				return var_58_5.add_hp + var_58_5.science * var_58_5.hpFactor
			end,
			damage = function(...)
				return var_58_5.add_damage + var_58_5.science * var_58_5.damageFactor
			end,
			healpoint = function(...)
				return var_58_5.healpoint
			end
		}
		local var_61_1 = var_61_0[arg_61_0] and var_61_0[arg_61_0]() or 0

		if var_61_0[arg_61_0] then
			var_61_1 = var_61_0[arg_61_0]()
			var_61_1 = var_61_1 * var_0_29[arg_61_0]
		end

		return var_61_1
	end

	return math.ceil(var_58_8("science_point") * (math.pow(var_58_8("range") / 120, 0.5) + var_58_8("attackspeed") + var_58_8("strike") * (0.5 + var_58_8("strike_damage_add")) + var_58_8("critical") * (1 + var_58_8("cri_damage_add")) + var_58_8("extra_attack") * 2.5 + var_58_8("hematophagy") / 2 * 2.5 + var_58_8("extra_rage") * 1.25 + var_58_8("dodge") * var_58_8("dodge_damage_add") / 2 * 5 + var_58_8("defence") / (var_58_8("defence") + 600) + var_58_8("healpoint") * 20 + var_58_8("extra_defence")) + var_58_8("hp") / 60 + var_58_8("damage") / 2)
end

local function var_0_30(arg_80_0)
	local var_80_0 = io.open("./src/fight_capacity.txt", "a+")

	var_80_0:write((string.format(arg_80_0)))
	var_80_0:flush()
	var_80_0:close()
end

function var_0_0.test(arg_81_0)
	local var_81_0 = {}

	for iter_81_0 = 1, 22 do
		for iter_81_1 = 1, 10 do
			table.insert(var_81_0, iter_81_0 .. "-" .. iter_81_1)
		end
	end

	local var_81_3 = {}
	local var_81_4 = false

	;(function()
		local chapter_data = require("data.chapter_data")

		for iter_82_0, iter_82_1 in pairs(var_81_0) do
			local var_82_1 = split(iter_82_1, "-")[1]
			local var_82_2 = level_manager.loadMonsterTeamData(var_82_1)

			if var_81_4 then
				var_0_30(L_LEVELS .. ":" .. iter_82_1 .. ",")
			else
				print("-------------------关卡" .. iter_82_1 .. "--------------------------")
			end

			if chapter_data[iter_82_1] and chapter_data[iter_82_1].bigboss and var_82_2[chapter_data[iter_82_1].bigboss] then
				local var_82_3 = 1
				local var_82_4 = 0

				while var_82_2[chapter_data[iter_82_1].bigboss]["monster" .. var_82_3] do
					local var_82_5 = var_0_0:getEnemyFightCapacity(var_82_1, var_82_2[chapter_data[iter_82_1].bigboss]["monster" .. var_82_3], var_81_3[iter_82_1])

					if var_81_4 then
						var_0_30("monster:" .. var_82_2[chapter_data[iter_82_1].bigboss]["monster" .. var_82_3] .. "," .. L_FIGHT_CAPACITY_MSG.Common .. " " .. var_82_5 .. ",")
					else
						print("monster:" .. var_82_2[chapter_data[iter_82_1].bigboss]["monster" .. var_82_3] .. "  " .. L_FIGHT_CAPACITY_MSG.Common .. " " .. var_82_5)
					end

					var_82_4 = var_82_4 + var_82_5
					var_82_3 = var_82_3 + 1
				end

				if not var_82_2[chapter_data[iter_82_1].bigboss].monster1 then
					local var_82_6 = var_0_0:getEnemyFightCapacity(var_82_1, var_82_2[chapter_data[iter_82_1].bigboss].boss, var_81_3[iter_82_1])

					if var_81_4 then
						var_0_30(",,")
						var_0_30("boss:" .. var_82_2[chapter_data[iter_82_1].bigboss].boss .. "," .. L_FIGHT_CAPACITY_MSG.Common .. " " .. var_82_6 .. ",")
					else
						print("boss:" .. var_82_2[chapter_data[iter_82_1].bigboss].boss .. "  " .. L_FIGHT_CAPACITY_MSG.Common .. " " .. var_82_6)
					end

					var_82_4 = var_82_4 + var_82_6
				elseif var_81_4 then
					var_0_30(",")
				end

				if var_81_4 then
					var_0_30(L_FIGHT_CAPACITY_MSG.total .. var_82_4 .. "\n")
				else
					print("总战力:" .. var_82_4)
					print("-------------------------------------------------------\n")
				end
			end
		end
	end)()
end

return var_0_0
