local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_ShipRename(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.ShipRenameReq", {
			id = arg_2_1.id,
			name = arg_2_1.name
		})
	end

	function arg_1_0.req_ShipLock(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.ShipLockReq", {
			id = arg_3_1.id
		})
	end

	function arg_1_0.req_ChangeSecretary(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.ChangeSecretaryReq", {
			id = arg_4_1.id
		})
	end

	function arg_1_0.req_ResetSecretary(arg_5_0)
		var_0_1:sendMsg("user.ResetSecretaryReq", {})
	end

	function arg_1_0.req_ShipEquip(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.ShipEquipReq", {
			id = arg_6_1.id,
			pos = arg_6_1.pos,
			equip_id = arg_6_1.equip_id
		})
	end

	function arg_1_0.req_ShipRemoveEquip(arg_7_0, arg_7_1)
		var_0_1:sendMsg("user.ShipRemoveEquipReq", {
			id = arg_7_1.id,
			pos = arg_7_1.pos
		})
	end

	function arg_1_0.req_EquipLock(arg_8_0, arg_8_1)
		var_0_1:sendMsg("user.EquipLockReq", {
			id = arg_8_1.id
		})
	end

	function arg_1_0.req_ShipMarry(arg_9_0, arg_9_1)
		var_0_1:sendMsg("user.ShipMarryReq", {
			id = arg_9_1.id
		})
	end

	function arg_1_0.req_ShipChangeTactics(arg_10_0, arg_10_1)
		var_0_1:sendMsg("user.ShipChangeTacticsReq", {
			id = arg_10_1.id,
			type = arg_10_1.type,
			tactics_id = arg_10_1.tactics_id
		})
	end

	function arg_1_0.req_IntensifyShip(arg_11_0, arg_11_1)
		var_0_1:sendMsg("user.IntensifyShipReq", {
			id = arg_11_1.id,
			consumables = arg_11_1.consumables
		})
	end

	function arg_1_0.req_IntensifySkill(arg_12_0, arg_12_1)
		var_0_1:sendMsg("user.IntensifySkillReq", {
			id = arg_12_1
		})
	end

	function arg_1_0.req_ShipChangeSkill(arg_13_0, arg_13_1)
		var_0_1:sendMsg("user.ShipChangeSkillReq", {
			id = arg_13_1.id,
			skill_id = arg_13_1.skill_id,
			is_evo = arg_13_1.is_evo
		})
	end

	function arg_1_0.req_ShipEvo(arg_14_0, arg_14_1)
		var_0_1:sendMsg("user.ShipEvoReq", {
			id = arg_14_1
		})
	end

	function arg_1_0.req_ShipEquipRecord(arg_15_0, arg_15_1)
		var_0_1:sendMsg("user.ShipEquipRecordReq", {
			id = arg_15_1.id,
			index = arg_15_1.index
		})
	end

	function arg_1_0.req_UseEquipRecord(arg_16_0, arg_16_1)
		var_0_1:sendMsg("user.UseEquipRecordReq", {
			id = arg_16_1.id,
			index = arg_16_1.index
		})
	end

	function arg_1_0.req_ShipChangeSkin(arg_17_0, arg_17_1)
		var_0_1:sendMsg("user.ShipChangeSkinReq", {
			id = arg_17_1.id,
			skin_id = arg_17_1.skin_id
		})
	end

	function arg_1_0.req_MultiShipChangeSkin(arg_18_0, arg_18_1)
		var_0_1:sendMsg("user.MultiShipChangeSkinReq", {
			ids = arg_18_1.ids,
			skin_id = arg_18_1.skin_id
		})
	end
end

function var_0_0.extend_obj(arg_19_0)
	return
end

return var_0_0
