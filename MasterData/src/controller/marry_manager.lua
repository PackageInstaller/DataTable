local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local marry_data = require("data.marry_data")
local favor_data = require("data.favor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local var_0_8 = MARRY_LEVEL
local var_0_9 = 107103000

function var_0_0.check_marry_flag(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		function()
			if marry_data[arg_1_1].ring then
				if item_manager:haveItem(marry_data[arg_1_1].ring) then
					return true
				elseif item_manager:haveItem(var_0_9) then
					return true
				else
					return false
				end
			else
				return item_manager:haveItem(var_0_9)
			end
		end,
		function()
			if arg_1_0:checkIsMarried(arg_1_1) then
				return false
			elseif playermodel.favor[arg_1_1].favorlevel >= var_0_8 then
				return true
			else
				return false
			end
		end
	}

	if arg_1_2 then
		return var_1_0[arg_1_2]()
	else
		for iter_1_0 = 1, 2 do
			if not var_1_0[iter_1_0]() then
				return false
			end
		end

		return true
	end
end

function var_0_0.checkIsMarried(arg_4_0, arg_4_1)
	if playermodel.marrytimes[arg_4_1] then
		return true, playermodel.marrytimes[arg_4_1]
	else
		return false
	end
end

function var_0_0:checkServantIsMarried(arg_5_1)
	return self:checkIsMarried(servant_data[arg_5_1].major)
end

function var_0_0:marry_with_major(arg_6_1, arg_6_2)
	if self:checkIsMarried(arg_6_1) then
		global_ShowBlockWords(L_MARRY_ERR[2])

		if arg_6_2 then
			arg_6_2(2)
		end

		return
	end

	if not self:check_marry_flag(arg_6_1, 2) then
		global_ShowBlockWords(string.format(L_MARRY_ERR[4], MARRY_LEVEL))

		if arg_6_2 then
			arg_6_2(4)
		end

		return
	end

	if not self:check_marry_flag(arg_6_1, 1) then
		if arg_6_2 then
			arg_6_2(3)
		end

		return
	end

	network:rpc("marry_with_major", {
		soulid = arg_6_1
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			playermodel.favor[arg_6_1].favorlevel = arg_7_0.favorlevel
			playermodel.favor[arg_6_1].favordegree = arg_7_0.favordegree
			playermodel.marrytimes[arg_6_1] = arg_7_0.marrytime

			local var_7_0 = {}

			if arg_7_0.items then
				for iter_7_0, iter_7_1 in pairs(arg_7_0.items) do
					local var_7_1 = item_manager:setItemByServerItem(iter_7_1)

					if var_7_1 and var_7_1 > 0 then
						if item_data[iter_7_1.itemid].bag_item_type == kITEM_SKIN then
							if not item_data[iter_7_1.itemid].skin_hide then
								playermodel.dress[arg_6_1] = iter_7_1.itemid

								local var_7_2 = cc.EventCustom:new("ON_SELECT_SKIN")

								var_7_2.modelid = item_data[iter_7_1.itemid].model

								cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_7_2)
							end
						else
							table.insert(var_7_0, {
								dropid = iter_7_1.itemid,
								dropNum = var_7_1,
								entityid = iter_7_1.entityid
							})
						end
					end
				end
			end

			if arg_7_0.cost_itemid then
				item_manager:deleteItem(arg_7_0.cost_itemid, 1)
			end

			if playermodel:isMajorInFight(arg_6_1) then
				FightManager.registerPlayerUpdate()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			if arg_7_0.servant_skin_list and next(arg_7_0.servant_skin_list) then
				for iter_7_2, iter_7_3 in pairs(arg_7_0.servant_skin_list) do
					playermodel.servantUsedskin[iter_7_3.servantid] = iter_7_3.skin

					local array_manager = require("controller.array_manager")
					local var_7_4 = array_manager:getArrayByServantID(iter_7_3.servantid)

					if var_7_4 and array_manager:isArrayCurHangup(var_7_4) then
						array_manager:registerHangupArrayChange()
						array_manager:executeHangupArrayChange()
					end

					AnalyticManager.servant_set_skin({
						servantid = iter_7_3.servantid,
						skin_itemid = iter_7_3.skin
					})
				end
			end

			AnalyticManager.marry_with_major({
				soulid = arg_6_1
			})

			if arg_6_2 then
				arg_6_2(arg_7_0.result, var_7_0)
			end
		elseif arg_7_0.result == 2 then
			global_ShowBlockWords(L_MARRY_ERR[2])
			cclog("已经誓约过了")

			if arg_6_2 then
				arg_6_2(arg_7_0.result)
			end
		elseif arg_7_0.result == 3 then
			global_ShowBlockWords(L_MARRY_ERR[3])

			if arg_6_2 then
				arg_6_2(arg_7_0.result)
			end

			cclog("没有戒指")
		elseif arg_7_0.result == 4 then
			global_ShowBlockWords(L_MARRY_ERR[4])
			cclog("好感度未达到要求")

			if arg_6_2 then
				arg_6_2(arg_7_0.result)
			end
		end
	end)
end

function var_0_0.get_ring_shop_list(arg_8_0, arg_8_1)
	arg_8_0.ringshops = nil

	network:rpc("get_marry_ring_data", nil, function(arg_9_0)
		if arg_9_0.shoplist then
			arg_8_0.ringshops = {}

			for iter_9_0, iter_9_1 in pairs(arg_9_0.shoplist) do
				itemtype = item_data[iter_9_1.shopinfo.itemtype].bag_item_type
				arg_8_0.ringshops[iter_9_1.soulid] = iter_9_1
			end

			if arg_8_1 then
				arg_8_1()
			end
		end
	end)
end

return var_0_0
