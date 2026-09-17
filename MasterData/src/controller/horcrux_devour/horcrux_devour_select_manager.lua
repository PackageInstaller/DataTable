local HorcruxDevourSelectManager = class("HorcruxDevourSelectManager", (require("controller.base_manager")))

HorcruxDevourSelectManager.MULTITON_MSG = "HorcruxDevourSelectManager instancealready constructed!"

local total_skill_data = require("data.total_skill_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local horcrux_data = require("data.horcrux_data")

function HorcruxDevourSelectManager:ctor()
	HorcruxDevourSelectManager.super.ctor(self)

	self._data = {}
	self._servantId = nil
	self._devourEntityId = nil
	self._materials = {}
	self._config = {}

	for iter_1_0, iter_1_1 in pairs((require("data/eat_horcrux_ele_data"))) do
		self._config[iter_1_1.ele] = iter_1_1
	end
end

function HorcruxDevourSelectManager:requestInfo(arg_2_1)
	return
end

function HorcruxDevourSelectManager:requestHorcruxDevour(arg_3_1)
	local playermodel = require("model.playermodel")
	local var_3_1 = {
		servantid = self._servantId,
		horcruxid = self._devourEntityId,
		materials = self._materials,
		pos = arg_3_1
	}

	require("network.network"):rpc("servant_eat_horcrux", var_3_1, function(arg_4_0)
		if arg_4_0.result == 1 then
			local var_4_0 = {
				isAddSkill = false
			}
			local var_4_1 = playermodel.horcruxDevour[self._servantId] or {}
			local var_4_2 = 0

			for iter_4_0 = 1, #var_4_1 do
				if next(var_4_1[iter_4_0]) then
					var_4_2 = var_4_2 + 1
				end
			end

			if var_4_2 == #arg_4_0.servant_horcrux then
				for iter_4_1 = 1, #arg_4_0.servant_horcrux do
					if arg_4_0.servant_horcrux[iter_4_1].newskill then
						var_4_0.oldSkillInfo = var_4_1[iter_4_1]
						var_4_0.newSkillInfo = arg_4_0.servant_horcrux[iter_4_1]
						var_4_0.oldHp = var_4_1[iter_4_1].hp
						var_4_0.newHp = arg_4_0.servant_horcrux[iter_4_1].newhp
						var_4_0.oldDamage = var_4_1[iter_4_1].damage
						var_4_0.newDamage = arg_4_0.servant_horcrux[iter_4_1].newdamage
						var_4_0.changedHp = arg_4_0.servant_horcrux[iter_4_1].newhp - var_4_1[iter_4_1].hp
						var_4_0.changedDamage = arg_4_0.servant_horcrux[iter_4_1].newdamage - var_4_1[iter_4_1].damage

						break
					end
				end
			elseif #arg_4_0.servant_horcrux - var_4_2 == 1 then
				local var_4_6 = arg_4_0.servant_horcrux[#arg_4_0.servant_horcrux]

				var_4_0.newSkillInfo = arg_4_0.servant_horcrux[#arg_4_0.servant_horcrux]
				var_4_0.oldHp = 0
				var_4_0.newHp = var_4_6.hp
				var_4_0.oldDamage = 0
				var_4_0.newDamage = var_4_6.damage
				var_4_0.changedHp = var_4_6.hp
				var_4_0.changedDamage = var_4_6.damage
				var_4_0.isAddSkill = true
				playermodel.horcruxServants[arg_4_0.servant_horcrux[#arg_4_0.servant_horcrux].horcrux] = self._servantId
			end

			playermodel.horcruxDevour[self._servantId] = {}

			for iter_4_2 = 1, HORCRUX_DEVOUR_MAX do
				playermodel.horcruxDevour[self._servantId][iter_4_2] = arg_4_0.servant_horcrux[iter_4_2] and arg_4_0.servant_horcrux[iter_4_2] or {}
			end

			if var_4_0.isAddSkill then
				if playermodel.items[var_3_1.horcruxid] then
					playermodel.items[var_3_1.horcruxid].horcrux_attr.owner = var_3_1.servantid
				end
			end

			if arg_4_0.cost_items and next(arg_4_0.cost_items) then
				local item_manager = require("controller.item_manager")

				for iter_4_3, iter_4_4 in pairs(arg_4_0.cost_items) do
					if iter_4_4.entityid and iter_4_4.num then
						item_manager:deleteItem(iter_4_4.entityid, iter_4_4.num)
					end
				end
			end

			if arg_4_0.horcrux then
				playermodel.items[arg_4_0.horcrux.entityid] = arg_4_0.horcrux
				playermodel.items[arg_4_0.horcrux.entityid].number = arg_4_0.horcrux.itemcount
			end

			sendNotification("HorcruxDevourSucceeded", var_4_0)
			sendNotification("refreshHorcruxLayout")
		else
			global_ShowBlockWords(L_HORCRUX_DEVOUR[20 + arg_4_0.result])
		end
	end)
end

function HorcruxDevourSelectManager:confirmNewSkill(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_3.horcruxId
	local var_5_1 = arg_5_1.replace
	local var_5_2 = arg_5_1.servantid
	local playermodel = require("model.playermodel")

	require("network.network"):rpc("servant_confirm_newskill", arg_5_1, function(arg_6_0)
		if arg_6_0.result == 1 then
			playermodel.horcruxDevour[self._servantId] = {}

			for iter_6_0 = 1, HORCRUX_DEVOUR_MAX do
				if arg_6_0.servant_horcrux[iter_6_0] then
					playermodel.horcruxDevour[self._servantId][iter_6_0] = arg_6_0.servant_horcrux[iter_6_0]
					playermodel.horcruxServants[arg_6_0.servant_horcrux[iter_6_0].horcrux] = self._servantId
				else
					playermodel.horcruxDevour[self._servantId][iter_6_0] = {}
				end
			end

			if var_5_1 then
				if playermodel.items[var_5_0] then
					playermodel.items[var_5_0].horcrux_attr.owner = var_5_2
				end
			end

			if arg_6_0.old_horcrux then
				playermodel.items[arg_6_0.old_horcrux.entityid] = arg_6_0.old_horcrux
				playermodel.items[arg_6_0.old_horcrux.entityid].number = arg_6_0.old_horcrux.itemcount
				playermodel.horcruxServants[arg_6_0.old_horcrux.entityid] = nil
			end

			if arg_6_0.horcrux then
				playermodel.items[arg_6_0.horcrux.entityid] = arg_6_0.horcrux
				playermodel.items[arg_6_0.horcrux.entityid].number = arg_6_0.horcrux.itemcount
			end

			if arg_5_2 then
				arg_5_2()
			end

			sendNotification("HorcruxDevourConfirmNewSkillSucceeded")
		elseif arg_6_0.result == 2 then
			global_ShowBlockWords("学员不存在")
		elseif arg_6_0.result == 3 then
			global_ShowBlockWords("不存在需要二次确认的技能")

			if arg_5_2 then
				arg_5_2()
			end
		else
			global_ShowBlockWords("Server Error")
		end
	end)
end

function HorcruxDevourSelectManager:setServantId(arg_7_1)
	self._servantId = arg_7_1
end

function HorcruxDevourSelectManager:setSelectIndex(arg_8_1)
	self._selectIndex = arg_8_1
end

function HorcruxDevourSelectManager:setMaterialsByIndex(arg_9_1, arg_9_2)
	self._materials[arg_9_1] = arg_9_2
end

function HorcruxDevourSelectManager:setMaterials(arg_10_1)
	self._materials = arg_10_1
end

function HorcruxDevourSelectManager:getMaterials()
	return self._materials
end

function HorcruxDevourSelectManager:getMaterialsByIndex(arg_12_1)
	return self._materials[arg_12_1]
end

function HorcruxDevourSelectManager:setDevourEntityId(arg_13_1)
	self._devourEntityId = arg_13_1
end

function HorcruxDevourSelectManager:getDevourEntityId()
	return self._devourEntityId
end

function HorcruxDevourSelectManager:getOutSideHorcruxs(arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or {}

	if not arg_15_2.attrFilter then
		-- block empty
	end

	local var_15_1 = arg_15_2.index or 1
	local var_15_3

	if not arg_15_2.selectIndex then
		var_15_3 = require("controller/horcrux_devour/horcrux_devour_manager"):getInstance()
	end

	local var_15_4 = var_15_3:getDevourHorcruxMinData(arg_15_1, var_15_1 >= 2)
	local var_15_5 = var_15_3:getHorcruxAttrs(arg_15_1)
	local var_15_6 = {}

	for iter_15_0, iter_15_1 in pairs(ATTR_ID) do
		if iter_15_0 ~= 0 and model_data[servant_data[arg_15_1].modelid][iter_15_1] then
			for iter_15_2, iter_15_3 in pairs(ATTR_ID) do
				if self._config[iter_15_1][iter_15_3] then
					var_15_6[iter_15_2] = iter_15_3
				end
			end
		end
	end

	local var_15_7 = {}

	for iter_15_4, iter_15_5 in pairs(require("model.playermodel").items) do
		if item_data[iter_15_5.itemid].bag_item_type == kITEM_HORCRUX then
			if not iter_15_5.horcrux_attr.owner or iter_15_5.horcrux_attr.owner <= 0 then
				if iter_15_5.horcrux_attr.hlv < var_15_4.level or iter_15_5.horcrux_attr.star < var_15_4.star then
					table.insert(var_15_7, iter_15_5.entityid)
				end
			else
				table.insert(var_15_7, iter_15_5.entityid)
			end
		end
	end

	return var_15_7
end

function HorcruxDevourSelectManager:getMaterialsNum()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(self._materials) do
		var_16_0 = var_16_0 + 1
	end

	return var_16_0
end

function HorcruxDevourSelectManager:getSelectIndex()
	return self._selectIndex
end

function HorcruxDevourSelectManager:getSkillReplaceProbability()
	local playermodel = require("model.playermodel")
	local var_18_1 = {
		50,
		50
	}

	if self._devourEntityId and playermodel.items[self._devourEntityId] then
		if playermodel.items[self._devourEntityId].horcrux_attr.star > 5 then
			var_18_1[1] = 50 - (playermodel.items[self._devourEntityId].horcrux_attr.star - 5) * 5
			var_18_1[2] = 100 - var_18_1[1]
		end

		if playermodel.items[self._devourEntityId].horcrux_attr.enable_skill_idxs then
			for iter_18_0, iter_18_1 in pairs(playermodel.items[self._devourEntityId].horcrux_attr.enable_skill_idxs) do
				for iter_18_2, iter_18_3 in pairs(var_18_1) do
					var_18_1[iter_18_2] = iter_18_2 == iter_18_1 and 100 or 0
				end

				break
			end
		end
	end

	return var_18_1
end

function HorcruxDevourSelectManager:setDevourHorcrux(arg_19_1, arg_19_2)
	if not arg_19_1 then
		return
	end

	local var_19_0 = require("controller/horcrux_devour/horcrux_devour_manager"):getInstance():getDevourHorcruxMinData(self._servantId, self._selectIndex >= 2)
	local var_19_1 = require("model.playermodel").items[arg_19_1]

	if var_19_1.horcrux_attr.lock then
		global_ShowBlockWords(L_HORCRUX_DEVOUR[9])

		return
	end

	local var_19_2 = var_19_1.horcrux_attr.star

	if self._selectIndex == 1 then
		if var_19_2 < var_19_0.star or var_19_1.horcrux_attr.hlv < var_19_0.level then
			global_ShowBlockWords(string.format(L_HORCRUX_DEVOUR[10], var_19_0.star, var_19_0.level))

			return
		end

		self._devourEntityId = arg_19_1
		self._materials = {}
	else
		if var_19_2 < var_19_0.star or var_19_1.horcrux_attr.hlv < var_19_0.level then
			global_ShowBlockWords(string.format(L_HORCRUX_DEVOUR[10], var_19_0.star, var_19_0.level))

			return
		end

		self._materials[self._selectIndex - 1] = arg_19_1
	end

	if arg_19_2 then
		arg_19_2(1)
	end

	if self.layer then
		self.layer:setDevourHorcrux(arg_19_1)
	end
end

function HorcruxDevourSelectManager:handlerInfo(arg_20_1)
	return
end

function HorcruxDevourSelectManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function HorcruxDevourSelectManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function HorcruxDevourSelectManager:getLayerSkillInfo(arg_23_1, arg_23_2)
	local horcrux_devour_manager = require("controller/horcrux_devour/horcrux_devour_manager")
	local var_23_1 = horcrux_devour_manager:getInstance():getSkillInfo(arg_23_1, arg_23_2)

	if horcrux_devour_manager then
		local var_23_2 = clone(var_23_1)
		local var_23_3 = math.abs(var_23_2.skillid)

		var_23_2.path = "skill_new/skill/" .. total_skill_data[var_23_3].icon .. ".png"
		var_23_2.skillName = total_skill_data[var_23_3].name
		var_23_2.horcruxPath = "roleimage/role/wuji/" .. model_data[horcrux_data[var_23_1.itemid].model].head_image .. ".png"
		var_23_2.horcruxName = horcrux_data[var_23_1.itemid].name

		return var_23_2
	end

	return nil
end

return HorcruxDevourSelectManager
