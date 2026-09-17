local var_0_0 = {}
local servant_data = require("data.servant_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local npc_data = require("data.npc_data")

function var_0_0.getElementsInfoByFightGirl(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_2 = arg_1_1.modelid

	if not arg_1_1.modelid then
		if arg_1_1.fight_girl then
			if servant_data[arg_1_1.fight_girl] then
				var_1_2 = servant_data[arg_1_1.fight_girl].modelid or arg_1_1.fight_girl or arg_1_1.majorlist and arg_1_1.majorlist.modelid

				if arg_1_1.npcid then
					if npc_fightconfig_data[arg_1_1.npcid].npcsoulid then
						local var_1_3 = global_get_all_model_attrs(npc_data[npc_fightconfig_data[arg_1_1.npcid].npcsoulid].model)

						table.insert(var_1_0, var_1_3.main)

						if var_1_3.sub then
							for iter_1_0, iter_1_1 in ipairs(var_1_3.sub) do
								table.insert(var_1_0, iter_1_1)
							end
						end
					else
						local var_1_4 = global_get_all_model_attrs(servant_data[npc_fightconfig_data[arg_1_1.npcid].servantid].modelid)

						table.insert(var_1_0, var_1_4.main)

						if var_1_4.sub then
							for iter_1_2, iter_1_3 in ipairs(var_1_4.sub) do
								table.insert(var_1_0, iter_1_3)
							end
						end
					end
				elseif var_1_2 then
					local var_1_5 = global_get_all_model_attrs(var_1_2)

					if not var_1_5.main then
						print("modelid not attr", var_1_2)

						var_1_5.main = "imaginary"
					end

					table.insert(var_1_0, var_1_5.main)

					if var_1_5.sub then
						for iter_1_4, iter_1_5 in ipairs(var_1_5.sub) do
							table.insert(var_1_0, iter_1_5)
						end
					end
				end
			end
		end
	end

	return var_1_0
end

function var_0_0:getTeamRestrainByArrayTbl(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = {}
	local var_2_1 = 0
	local var_2_2 = false

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		for iter_2_2, iter_2_3 in pairs((self:getElementsInfoByFightGirl(iter_2_1))) do
			if var_2_0[iter_2_3] == nil then
				var_2_0[iter_2_3] = {}
			end

			if iter_2_3 == "imaginary" then
				var_2_2 = true
			end

			table.insert(var_2_0[iter_2_3], iter_2_0)

			if ATTR_INDEX[iter_2_3] <= 5 and var_2_1 < #var_2_0[iter_2_3] then
				var_2_1 = #var_2_0[iter_2_3]
			end
		end
	end

	local var_2_3 = {}

	if var_2_1 > 0 and var_2_2 == true then
		for iter_2_4, iter_2_5 in pairs(var_2_0) do
			if #iter_2_5 == var_2_1 and ATTR_INDEX[iter_2_4] <= 5 then
				table.insert(var_2_3, iter_2_4)
			end
		end
	elseif var_2_1 == 0 and var_2_2 == true then
		table.insert(var_2_3, "imaginary")
	end

	return var_2_3
end

return var_0_0
