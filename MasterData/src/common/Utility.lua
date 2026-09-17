local var_0_0 = {
	registerNodeEvent = function(arg_1_0, arg_1_1)
		if not arg_1_1 then
			return
		end

		arg_1_1:registerScriptHandler(function(arg_2_0)
			if arg_2_0 == "exit" and arg_1_1.onExit then
				arg_1_1:onExit()
			elseif arg_2_0 == "enter" and arg_1_1.onEnter then
				arg_1_1:onEnter()
			end
		end)
	end,
	quickAddTouchListener = function(arg_3_0, arg_3_1)
		if not arg_3_1 then
			return
		end

		arg_3_1:addTouchEventListener(function(arg_4_0, arg_4_1)
			if arg_4_1 == ccui.TouchEventType.began then
				if arg_3_1.onTouchBegin then
					arg_3_1:onTouchBegin(arg_4_0, arg_4_1)
				end
			elseif arg_4_1 == ccui.TouchEventType.moved then
				if arg_3_1.onTouchMove then
					arg_3_1:onTouchMove(arg_4_0, arg_4_1)
				end
			elseif arg_4_1 == ccui.TouchEventType.ended then
				if arg_3_1.onTouchEnded then
					arg_3_1:onTouchEnded(arg_4_0, arg_4_1)
				end
			elseif arg_4_1 == ccui.TouchEventType.canceled and arg_3_1.onTouchCancel then
				arg_3_1:onTouchCancel(arg_4_0, arg_4_1)
			end
		end)
	end,
	registerTouchEventListener = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = arg_5_1:getEventDispatcher()
		local var_5_1 = arg_5_1.listener
		local var_5_2 = false

		if not arg_5_1.listener then
			var_5_1 = cc.EventListenerTouchOneByOne:create()

			var_5_1:setSwallowTouches(true)

			var_5_2 = true
		end

		if arg_5_2 == cc.Handler.EVENT_TOUCH_BEGAN then
			var_5_1:registerScriptHandler(arg_5_3, cc.Handler.EVENT_TOUCH_BEGAN)
		elseif arg_5_2 == cc.Handler.EVENT_TOUCH_MOVED then
			var_5_1:registerScriptHandler(arg_5_3, cc.Handler.EVENT_TOUCH_MOVED)
		elseif arg_5_2 == cc.Handler.EVENT_TOUCH_ENDED then
			var_5_1:registerScriptHandler(arg_5_3, cc.Handler.EVENT_TOUCH_ENDED)
		elseif arg_5_2 == cc.Handler.EVENT_TOUCH_CANCELLED then
			var_5_1:registerScriptHandler(arg_5_3, cc.Handler.EVENT_TOUCH_CANCELLED)
		end

		if var_5_2 then
			arg_5_1.listener = var_5_1

			var_5_0:addEventListenerWithSceneGraphPriority(var_5_1, arg_5_1)
		end

		return var_5_1
	end,
	addLastTouchEventListener = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
		local var_6_0 = false

		arg_6_1:addTouchEventListener(function(arg_7_0, arg_7_1)
			if arg_7_1 == ccui.TouchEventType.began then
				arg_7_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_6_2), cc.CallFunc:create(function()
					var_6_0 = true

					arg_7_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(arg_6_4), cc.DelayTime:create(arg_6_3))))
				end)))
			elseif arg_7_1 == ccui.TouchEventType.moved then
				if arg_6_5.moved and not var_6_0 then
					arg_6_5.moved()
				end
			elseif arg_7_1 == ccui.TouchEventType.ended then
				arg_7_0:stopAllActions()

				if arg_6_5.ended and not var_6_0 then
					arg_6_5.ended()
				end

				var_6_0 = false
			elseif arg_7_1 == ccui.TouchEventType.canceled then
				arg_7_0:stopAllActions()

				if arg_6_5.cancel and not var_6_0 then
					arg_6_5.cancel()
				end

				var_6_0 = false
			end
		end)
	end,
	addClickEventListener = function(arg_9_0, arg_9_1, arg_9_2, ...)
		if not arg_9_1 then
			return
		end

		arg_9_1:setTouchEnabled(true)

		local var_9_0 = {
			...
		}

		arg_9_1:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 == ccui.TouchEventType.ended then
				if math.abs(arg_10_0:getTouchBeganPosition().y - arg_10_0:getTouchEndPosition().y) > 50 then
					return
				end

				if arg_9_2 then
					arg_9_2(arg_10_0, unpack(var_9_0))
				end
			end
		end)
	end
}

function var_0_0.seekChildByName(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_1 or not arg_11_2 then
		return nil
	end

	local var_11_0 = arg_11_1:getChildByName(arg_11_2)

	if var_11_0 then
		return var_11_0
	end

	for iter_11_0, iter_11_1 in ipairs((arg_11_1:getChildren())) do
		local var_11_1 = var_0_0:seekChildByName(iter_11_1, arg_11_2)

		if var_11_1 then
			return var_11_1
		end
	end
end

function var_0_0.clamp(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_1 or not arg_12_2 or not arg_12_3 then
		return
	end

	if arg_12_3 < arg_12_2 then
		arg_12_3 = arg_12_2
		arg_12_2 = arg_12_3
	end

	if arg_12_1 < arg_12_2 then
		arg_12_1 = arg_12_2
	end

	if arg_12_3 < arg_12_1 then
		arg_12_1 = arg_12_3
	end

	return arg_12_1
end

function var_0_0.alignPanelByParent(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1:getContentSize()
	local var_13_1 = arg_13_2:getContentSize()

	arg_13_1:setAnchorPoint(0, 0)
	arg_13_1:setPositionX((var_13_1.width - var_13_0.width) / 2)
	arg_13_1:setPositionY((var_13_1.height - var_13_0.height) / 2)
end

function var_0_0.replaceNodeByName(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, ...)
	local var_14_0 = arg_14_4:create(...)
	local var_14_1 = var_0_0:seekChildByName(arg_14_1, arg_14_2)

	if var_14_1 then
		var_14_0:setPosition(var_14_1:getPosition())
		var_14_0:setRotation(var_14_1:getRotation())
		var_14_0:setVisible(var_14_1:isVisible())

		local var_14_2 = var_14_1:getParent()

		var_14_2:removeChild(var_14_1)
		var_14_2:addChild(var_14_0, arg_14_3 or 0)
	else
		arg_14_1:addChild(var_14_0, arg_14_3 or 0)
	end

	return var_14_0
end

function var_0_0.replaceNodeByNode(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = var_0_0:seekChildByName(arg_15_1, arg_15_2)

	if var_15_0 then
		arg_15_3:setPosition(var_15_0:getPosition())
		arg_15_3:setRotation(var_15_0:getRotation())
		arg_15_3:setVisible(var_15_0:isVisible())
		arg_15_3:setLocalZOrder(var_15_0:getLocalZOrder())
		arg_15_3:setName(arg_15_2)

		local var_15_1 = var_15_0:getParent()

		var_15_1:removeChild(var_15_0)
		var_15_1:addChild(arg_15_3)
	else
		arg_15_1:addChild(arg_15_3)
	end
end

function var_0_0.hexStrToColor3B(arg_16_0, arg_16_1)
	local var_16_0 = cc.c3b(255, 255, 255)

	var_16_0.r = tonumber("0x" .. string.sub(arg_16_1, 2, 3))
	var_16_0.g = tonumber("0x" .. string.sub(arg_16_1, 4, 5))
	var_16_0.b = tonumber("0x" .. string.sub(arg_16_1, 6, 7))

	return var_16_0
end

function var_0_0.getItemById(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(require("model.playermodel").items) do
		if iter_17_1.itemid == arg_17_1 then
			return {
				count = iter_17_1.number,
				type = iter_17_1.itemtype,
				id = iter_17_1.itemid
			}
		end
	end

	return {
		id = 0,
		count = 0,
		type = 0
	}
end

function var_0_0.indexOf(arg_18_0, arg_18_1, arg_18_2)
	if type(arg_18_2) == "function" then
		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			if arg_18_2(iter_18_1) then
				return iter_18_0
			end
		end
	else
		for iter_18_2, iter_18_3 in ipairs(arg_18_1) do
			if iter_18_3 == arg_18_2 then
				return iter_18_2
			end
		end
	end

	return -1
end

function var_0_0.generateGoConfig(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local time_check_manager = require("controller.time_check_manager")
	local item_data = require("data.item_data")

	local function var_19_2(arg_20_0, arg_20_1)
		if not item_data[arg_20_0]["targetactivity" .. arg_20_1] then
			if item_data[arg_20_0]["targetlayer_starttime_" .. arg_20_1] and time_check_manager:getCurTime() < os.time(parse_time(item_data[arg_20_0]["targetlayer_starttime_" .. arg_20_1])) then
				return false
			end

			if item_data[arg_20_0]["targetlayer_finishtime_" .. arg_20_1] and os.time(parse_time(item_data[arg_20_0]["targetlayer_finishtime_" .. arg_20_1])) < time_check_manager:getCurTime() then
				return false
			end

			return true
		else
			local var_20_0 = require("controller.activity_manager"):getActivityObj(tonumber(item_data[arg_20_0]["targetactivity" .. arg_20_1]))

			if not var_20_0 then
				return false
			elseif var_20_0:getStatus() ~= 2 then
				return false
			else
				return true
			end
		end

		return true
	end

	if arg_19_1 == "gold" then
		return {
			{
				systemid = 111,
				des = L_GO_CONFIG_DES.midas,
				callback = arg_19_2
			},
			{
				systemid = 201,
				des = L_GO_CONFIG_DES.quick_find
			},
			{
				systemid = 154,
				des = L_GO_CONFIG_DES.recycle_shop
			},
			{
				systemid = 500,
				des = L_GO_CONFIG_DES.sell
			}
		}
	elseif arg_19_1 == "horcrux" then
		return {
			{
				systemid = 180,
				des = L_GO_CONFIG_DES.twist
			},
			{
				systemid = 502,
				des = L_GO_CONFIG_DES.horcrux_compound
			}
		}
	else
		local var_19_3 = {}
		local var_19_4 = 1

		while item_data[arg_19_1]["targetdes" .. var_19_4] do
			var_19_4 = var_19_4 + 1
		end

		for iter_19_0 = 1, var_19_4 - 1 do
			if var_19_2(arg_19_1, iter_19_0) then
				if SYSTEMID[item_data[arg_19_1]["targetlayer" .. iter_19_0]] == "InstanceLayer" or SYSTEMID[item_data[arg_19_1]["targetlayer" .. iter_19_0]] == "MarketLayer" then
					table.insert(var_19_3, {
						des = item_data[arg_19_1]["targetdes" .. iter_19_0],
						targetlayer = SYSTEMID[item_data[arg_19_1]["targetlayer" .. iter_19_0]],
						returnlayer = arg_19_3,
						systemid = item_data[arg_19_1]["targetlayer" .. iter_19_0]
					})
				elseif item_data[arg_19_1]["targetdes" .. iter_19_0] and item_data[arg_19_1]["targetlayer" .. iter_19_0] then
					table.insert(var_19_3, {
						des = item_data[arg_19_1]["targetdes" .. iter_19_0],
						targetlayer = SYSTEMID[item_data[arg_19_1]["targetlayer" .. iter_19_0]],
						systemid = item_data[arg_19_1]["targetlayer" .. iter_19_0]
					})
				end
			end
		end

		return var_19_3
	end
end

function var_0_0.executeLayerJump(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	local audio_manager = require("controller.audio_manager")
	local shop_currency_data = require("data.shop_currency_data")

	if require("controller.arenatft_manager"):getLayerBtnLock() then
		global_ShowBlockWords(L_TVT_FIGHT_BTN_LOCK)

		return
	end

	if arg_21_3 then
		arg_21_3(arg_21_1.targetlayer)
	end

	if arg_21_1.targetlayer == "ShareLayer" then
		global_ShowBlockWords(L_POPGOGAIN_SYSTEM_CLOSE.ShareLayer)
		audio_manager:playeffectMusicTest("sound/invalid")
	else
		local var_21_2 = cc.EventCustom:new("switchShowLayer")

		if arg_21_1.targetlayer == "CommandLayer" or arg_21_1.targetlayer == "SmeltLayer" or arg_21_1.targetlayer == "CompoundLabLayer" then
			var_21_2.layerName = "LabLayer"

			require("view.Layer.LabLayer")
			LabLayer:setSwitchLabType(arg_21_1.targetlayer)
		else
			var_21_2.layerName = arg_21_1.targetlayer
		end

		if arg_21_1.targettype then
			local var_21_3

			if arg_21_1.targetlayer == "MarketLayer" then
				var_21_3 = {
					shoptype = arg_21_1.targettype,
					returnLayer = arg_21_1.returnlayer
				}
			elseif arg_21_1.targetlayer == "InstanceLayer" then
				global_ShowBlockWords(L_POPGOGAIN_SYSTEM_CLOSE.InstanceLayer)
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end

			var_21_2.initparam = var_21_3
		end

		local var_21_4

		require("controller.goto_system_manager")

		var_21_4 = type(arg_21_1.systemid) == "string" and (arg_21_1.systemid:find("@") and arg_21_1.systemid or tonumber(arg_21_1.systemid)) or arg_21_1.systemid

		if var_21_4 == 130 then
			LayerManager:pushInLayer("SignLayerNew")
		elseif var_21_4 == 111 then
			LayerManager:pushInLayer("HandOfMidasLayer", {
				callback = arg_21_1.callback
			})
		elseif var_21_4 == 123000 then
			if communitySystemManage:getCurfamilyid() then
				local var_21_5 = cc.EventCustom:new("switchShowLayer")

				var_21_5.layerName = "MarketLayer"
				var_21_5.initparam = {
					returnLayer = "MainLayer",
					singleMarket = {
						"1-123000"
					}
				}

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_21_5)
			else
				global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips5)
			end
		elseif var_21_4 == 3051 then
			if communitySystemManage:getCurfamilyid() then
				LayerManager:switchShowLayer("CommunityTaskShowLayer")
			else
				global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips5)
			end
		elseif var_21_4 == 3070 then
			LayerManager:pushInLayer("PopTurnOverItemsLayer", arg_21_1.initparam)
		else
			local var_21_6 = {
				jump_to_system = arg_21_2,
				cur_system_id = arg_21_2,
				config = arg_21_5
			}
			local var_21_7 = {
				jump_to_system = var_21_4,
				cur_system_id = arg_21_2
			}

			var_21_7.config = system_jump_config[SYSTEMID[var_21_4]] and global_deepCopy(system_jump_config[SYSTEMID[var_21_4]].config)

			if var_21_2.initparam then
				var_21_7.config = var_21_2.initparam
			end

			if arg_21_2 and var_21_7.config and (not system_jump_config[SYSTEMID[arg_21_2]] or not system_jump_config[SYSTEMID[arg_21_2]].popLayer) then
				if var_21_7.config.exitCallbackType == "function" then
					var_21_7.config.exitCallback = createExitCallback(var_21_6)
				end

				if var_21_7.config.exitCallbackType == "string" then
					var_21_7.config = SYSTEMID[arg_21_2]
				end
			end

			if system_jump_config[SYSTEMID[var_21_4]] and system_jump_config[SYSTEMID[var_21_4]].layerName == "MarketLayer" then
				local var_21_8 = cc.EventCustom:new("switchShowLayer")

				var_21_8.layerName = "MarketLayer"
				var_21_8.initparam = {
					singleMarket = system_jump_config[SYSTEMID[var_21_4]].config.singleMarket,
					itemid = arg_21_4
				}

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_21_8)
			else
				print(dump(var_21_7))
				goto_complete_system(var_21_7)
			end

			if type(var_21_4) == "number" and var_21_4 >= 1500 and var_21_4 <= 1599 then
				local var_21_9 = cc.EventCustom:new("switchLeftBtn")

				var_21_9.name = shop_currency_data[var_21_4 % 1500].shop_type

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_21_9)
			end
		end
	end
end

function var_0_0.enumeration(arg_22_0, arg_22_1)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		var_22_0[iter_22_1] = iter_22_0
	end

	return var_0_0:readonlyTbl(var_22_0)
end

function var_0_0.readonlyTbl(arg_23_0, arg_23_1)
	return (setmetatable({}, {
		__index = function(arg_24_0, arg_24_1)
			if not arg_23_1[arg_24_1] then
				error(string.format("invalid enumaterated key: %s", arg_24_1))
			end

			return arg_23_1[arg_24_1]
		end,
		__newindex = function()
			error("can't set readonly table")
		end
	}))
end

function var_0_0.formatTimeStr(arg_26_0, arg_26_1)
	if arg_26_1 >= 86400 then
		return string.format("%02d天%02d小时", math.floor(arg_26_1 / 86400), math.floor(arg_26_1 % 86400 / 3600))
	elseif arg_26_1 >= 3600 then
		return string.format("%02d小时%02d分钟", math.floor(arg_26_1 / 3600), math.floor(arg_26_1 % 3600 / 60))
	else
		return string.format("%02d分钟%02d秒", math.floor(arg_26_1 / 60), math.floor(arg_26_1 % 60))
	end
end

function var_0_0.getDropData(arg_27_0, arg_27_1)
	local drop_data = require("data.drop_data")
	local var_27_1 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_27_2 = drop_data[arg_27_1] or {}

	if var_27_2.gold then
		var_27_1.gold = var_27_1.gold + var_27_2.gold
	end

	if var_27_2.diamond then
		var_27_1.diamond = var_27_1.diamond + var_27_2.diamond
	end

	local var_27_3 = 1

	if var_27_2["drop_id" .. 1] then
		local var_27_4 = 1

		while var_27_2["drop_id" .. var_27_4] do
			var_27_1.items[var_27_3] = {
				itemid = var_27_2["drop_id" .. var_27_4],
				num = var_27_2["drop_num" .. var_27_4]
			}
			var_27_4 = var_27_4 + 1
			var_27_3 = var_27_3 + 1
		end
	end

	if var_27_2["dropmodel_id" .. 1] then
		local var_27_5 = 1

		while var_27_2["dropmodel_id" .. var_27_5] do
			if drop_data[var_27_2["dropmodel_id" .. var_27_5]].gold then
				var_27_1.gold = var_27_1.gold + drop_data[var_27_2["dropmodel_id" .. var_27_5]].gold
			end

			if drop_data[var_27_2["dropmodel_id" .. var_27_5]].diamond then
				var_27_1.diamond = var_27_1.diamond + drop_data[var_27_2["dropmodel_id" .. var_27_5]].diamond
			end

			if drop_data[var_27_2["dropmodel_id" .. var_27_5]]["drop_id" .. 1] then
				local var_27_6 = 1

				while drop_data[var_27_2["dropmodel_id" .. var_27_5]]["drop_id" .. var_27_6] do
					var_27_1.items[var_27_3] = {
						itemid = drop_data[var_27_2["dropmodel_id" .. var_27_5]]["drop_id" .. var_27_6],
						num = drop_data[var_27_2["dropmodel_id" .. var_27_5]]["drop_num" .. var_27_6]
					}
					var_27_6 = var_27_6 + 1
					var_27_3 = var_27_3 + 1
				end
			end

			if drop_data[var_27_2["dropmodel_id" .. var_27_5]]["rd_drop_id" .. 1] then
				local var_27_7 = 1

				while drop_data[var_27_2["dropmodel_id" .. var_27_5]]["rd_drop_id" .. var_27_7] do
					var_27_1.items[var_27_3] = {
						itemid = drop_data[var_27_2["dropmodel_id" .. var_27_5]]["rd_drop_id" .. var_27_7],
						num = drop_data[var_27_2["dropmodel_id" .. var_27_5]]["rd_drop_num" .. var_27_7]
					}
					var_27_7 = var_27_7 + 1
					var_27_3 = var_27_3 + 1
				end
			end

			var_27_5 = var_27_5 + 1
		end
	end

	if var_27_2["rd_drop_id" .. 1] then
		local var_27_8 = 1

		while var_27_2["rd_drop_id" .. var_27_8] do
			var_27_1.items[var_27_3] = {
				itemid = var_27_2["rd_drop_id" .. var_27_8],
				num = var_27_2["rd_drop_num" .. var_27_8]
			}
			var_27_8 = var_27_8 + 1
			var_27_3 = var_27_3 + 1
		end
	end

	if var_27_2["rd_dropmodel_id" .. 1] then
		local var_27_9 = 1

		while var_27_2["rd_dropmodel_id" .. var_27_9] do
			if drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]].gold then
				var_27_1.gold = var_27_1.gold + drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]].gold
			end

			if drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]].diamond then
				var_27_1.diamond = var_27_1.diamond + drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]].diamond
			end

			if drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]]["drop_id" .. 1] then
				local var_27_10 = 1

				while drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]]["drop_id" .. var_27_10] do
					var_27_1.items[var_27_3] = {
						itemid = drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]]["drop_id" .. var_27_10],
						num = drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]]["drop_num" .. var_27_10]
					}
					var_27_10 = var_27_10 + 1
					var_27_3 = var_27_3 + 1
				end
			end

			if drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]]["rd_drop_id" .. 1] then
				local var_27_11 = 1

				while drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]]["rd_drop_id" .. var_27_11] do
					var_27_1.items[var_27_3] = {
						itemid = drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]]["rd_drop_id" .. var_27_11],
						num = drop_data[var_27_2["rd_dropmodel_id" .. var_27_9]]["rd_drop_num" .. var_27_11]
					}
					var_27_11 = var_27_11 + 1
					var_27_3 = var_27_3 + 1
				end
			end

			var_27_9 = var_27_9 + 1
		end
	end

	local var_27_12 = var_27_1.items
	local var_27_13 = {}

	if var_27_1.items and #var_27_12 > 0 then
		for iter_27_0, iter_27_1 in ipairs(var_27_12) do
			if iter_27_1.num and iter_27_1.num > 0 then
				table.insert(var_27_13, {
					num = iter_27_1.num,
					itemid = iter_27_1.itemid
				})
			end
		end
	end

	if var_27_1.gold and var_27_1.gold > 0 then
		table.insert(var_27_13, {
			itemid = "gold",
			num = var_27_1.gold
		})
	end

	if var_27_1.diamond and var_27_1.diamond > 0 then
		table.insert(var_27_13, {
			itemid = "diamond",
			num = var_27_1.diamond
		})
	end

	return var_27_13
end

function var_0_0.createClockTimerAction(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	local var_28_0 = 1024

	if type(arg_28_1) ~= "userdata" then
		return
	end

	local var_28_1 = arg_28_2 or 1
	local var_28_2 = arg_28_3 or 4294967296
	local var_28_3 = cc.Sequence:create(cc.DelayTime:create(arg_28_5 or 0), cc.CallFunc:create(function()
		local var_29_0 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(arg_28_2), cc.CallFunc:create(function()
			var_28_2 = var_28_2 - var_28_1

			if arg_28_4 then
				arg_28_4(var_28_2, var_28_1)
			end

			if var_28_2 <= 0 then
				arg_28_1:stopActionByTag(var_28_0)

				return
			end
		end)))

		var_29_0:setTag(var_28_0)
		arg_28_1:runAction(var_29_0)
	end))

	var_28_3:setTag(1024)

	return var_28_3, 1024
end

function var_0_0.removeElement(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = 0
	local var_31_1 = 1
	local var_31_2 = #arg_31_1
	local var_31_3 = type(arg_31_2)
	local var_31_5

	while var_31_1 <= var_31_2 do
		if var_31_3 == "function" and arg_31_2(arg_31_1[var_31_1]) or arg_31_1[var_31_1] == arg_31_2 then
			var_31_5 = table.remove(arg_31_1, var_31_1)
			var_31_0 = var_31_0 + 1
			var_31_1 = var_31_1 - 1
			var_31_2 = var_31_2 - 1

			if not arg_31_3 then
				break
			end
		end

		var_31_1 = var_31_1 + 1
	end

	return var_31_5, var_31_0
end

function var_0_0.splice(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = {}

	if arg_32_3 > #arg_32_1 - arg_32_2 + 1 then
		arg_32_3 = #arg_32_1 - arg_32_2 + 1
	end

	for iter_32_0 = 0, arg_32_3 - 1 do
		var_32_0[#var_32_0 + 1] = arg_32_1[arg_32_2 + iter_32_0]
	end

	for iter_32_1 = 0, arg_32_3 - 1 do
		arg_32_1[arg_32_2 + iter_32_1] = nil
	end

	for iter_32_2 = 0, #arg_32_1 - arg_32_3 - arg_32_2 + 1 - 1 do
		arg_32_1[arg_32_2 + arg_32_3 + iter_32_2] = arg_32_1[arg_32_2 + iter_32_2]
		arg_32_1[arg_32_2 + iter_32_2] = arg_32_1[arg_32_2 + arg_32_3 + iter_32_2]
	end

	return var_32_0
end

function var_0_0.replaceTextFieldByEditBox(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = cc.EditBox:create(arg_33_1:getContentSize(), cc.Scale9Sprite:create())

	var_33_0:setAnchorPoint(arg_33_1:getAnchorPoint())
	var_33_0:setPosition(arg_33_1:getPosition())
	var_33_0:setPlaceHolder(arg_33_1:getPlaceHolder())
	var_33_0:setMaxLength(arg_33_2 or 12)
	var_33_0:setPlaceholderFontColor(cc.c4b(255, 255, 255, 255))
	var_33_0:setFontSize(arg_33_1:getFontSize())
	var_33_0:setFontColor(arg_33_1:getColor())
	var_33_0:setFontName(arg_33_1:getFontName())
	var_33_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DEFAULT)
	var_33_0:setInputMode(arg_33_3 or cc.EDITBOX_INPUT_MODE_NUMERIC)
	var_33_0:setInputFlag(arg_33_4 or 1)
	arg_33_1:getParent():addChild(var_33_0)
	arg_33_1:removeFromParent()

	return var_33_0
end

function var_0_0.replaceLabelByRichTextPro(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = require("view.Sprite.RichTextPro"):create()

	var_34_0:setSize(arg_34_4 or arg_34_1:getFontSize())
	var_34_0:setFontName(arg_34_1:getFontName())
	var_34_0:setMaxWidth(arg_34_2 or arg_34_1:getContentSize().width)
	var_34_0:setLineSpace(arg_34_3 or 0)
	var_34_0:setPosition(arg_34_1:getPosition())
	arg_34_1:getParent():addChild(var_34_0)
	arg_34_1:removeFromParent()

	return var_34_0
end

function var_0_0.replaceListViewByTableView(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	if not arg_35_1 or not arg_35_2 then
		return
	end

	local var_35_0 = arg_35_1:getChildByName(arg_35_2)

	if not var_35_0 then
		print("don't have child: ", arg_35_2)

		return
	end

	local var_35_2 = cc.TableView:create(cc.size(var_35_0:getContentSize().width, var_35_0:getContentSize().height + ((arg_35_3 or nil) and (GameDisplay.height - GameDisplay.origin_design_y or 0))))

	var_35_2:setDirection(var_35_0:getDirection())
	var_35_2:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_35_2:setDelegate()
	arg_35_1:addChild(var_35_2, arg_35_4 or 0)
	var_35_0:removeFromParent()

	return var_35_2
end

var_0_0.blockTime = nil
var_0_0.blockCount = 0

function var_0_0.blockEvents(arg_36_0, arg_36_1)
	arg_36_1 = arg_36_1 or 1

	local var_36_0 = require("socket").gettime()

	var_0_0.blockCount = var_0_0.blockCount + 1

	if not var_0_0.blockTime then
		var_0_0.blockTime = var_36_0
		var_0_0.blockCount = 0

		return true
	end

	if var_36_0 - var_0_0.blockTime <= 1 then
		return arg_36_1 >= var_0_0.blockCount
	else
		var_0_0.blockTime = var_36_0
		var_0_0.blockCount = 0

		return true
	end
end

function var_0_0.isTimeRangeValid(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = require("controller.time_check_manager"):getCurTime()

	if arg_37_1 then
		if type(arg_37_1) ~= "number" then
			arg_37_1 = global_get_time_by_date(arg_37_1)
		end

		if var_37_0 < arg_37_1 then
			return false
		end
	end

	if arg_37_2 then
		if type(arg_37_2) ~= "number" then
			arg_37_2 = global_get_time_by_date(arg_37_2)
		end

		if arg_37_2 < var_37_0 then
			return false
		end
	end

	return true
end

function var_0_0.sortByProps(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	arg_38_2 = arg_38_2 or {}
	arg_38_3 = arg_38_3 and (arg_38_3 > 0 and 1 or -1) or -1

	local function var_38_0(arg_39_0, arg_39_1, arg_39_2)
		if not next(arg_39_2) then
			if arg_38_3 == -1 then
				return arg_39_0 < arg_39_1
			else
				return arg_39_1 < arg_39_0
			end
		end

		local var_39_0 = {}

		for iter_39_0, iter_39_1 in ipairs(arg_39_2) do
			if not arg_39_0[iter_39_1] or not arg_39_1[iter_39_1] then
				print("data do not have element: ", iter_39_1)
			end

			var_39_0[#var_39_0 + 1] = arg_39_0[iter_39_1] > arg_39_1[iter_39_1] and 1 or arg_39_0[iter_39_1] < arg_39_1[iter_39_1] and -1 or 0
		end

		for iter_39_2, iter_39_3 in ipairs(var_39_0) do
			if iter_39_3 ~= 0 then
				return iter_39_3 == arg_38_3
			end
		end
	end

	table.sort(arg_38_1, function(arg_40_0, arg_40_1)
		return var_38_0(arg_40_0, arg_40_1, arg_38_2)
	end)
end

function var_0_0.reverse(arg_41_0, arg_41_1)
	local var_41_0 = {}

	for iter_41_0 = #arg_41_1, 1, -1 do
		var_41_0[#var_41_0 + 1] = arg_41_1[iter_41_0]
	end

	return var_41_0
end

function var_0_0.getTableView(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6)
	local var_42_0 = cc.TableView:create(arg_42_3)

	var_42_0:setVisible(false)
	var_42_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
	var_42_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_42_0:setDelegate()
	var_42_0:registerScriptHandler(function(arg_43_0)
		return arg_42_1
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_42_0:registerScriptHandler(function(arg_44_0)
		if type(arg_42_6) == "function" then
			arg_42_6(arg_44_0)
		end
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_42_0:registerScriptHandler(function(arg_45_0, arg_45_1)
		if type(arg_42_5) == "function" then
			arg_42_5(arg_45_0, arg_45_1)
		end
	end, cc.TABLECELL_TOUCHED)
	var_42_0:registerScriptHandler(function(arg_46_0, arg_46_1)
		local var_46_0 = 100
		local var_46_1 = 100

		if type(arg_42_2) == "function" then
			var_46_0, var_46_1 = arg_42_2(arg_46_1)
		end

		return var_46_0, var_46_1
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_42_0:registerScriptHandler(function(arg_47_0, arg_47_1)
		return arg_42_4(arg_47_0, arg_47_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_42_0:reloadData()
	var_42_0:setAnchorPoint(cc.p(0, 1))

	return var_42_0
end

function var_0_0.setTglContainerCallback(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	if arg_48_1 == nil then
		return
	end

	arg_48_1.toggleContainer = {}
	arg_48_3 = arg_48_3 or 1

	local function var_48_0(arg_49_0, arg_49_1)
		if arg_49_1 == arg_49_0.isShow then
			return
		end

		local var_49_0 = arg_49_0:getChildByName("click")

		if arg_49_0.isShow == true then
			arg_49_0.isShow = false

			var_49_0:setVisible(false)
		else
			arg_49_0.isShow = true

			var_49_0:setVisible(true)
			arg_48_2(arg_49_0.index)
		end
	end

	local function var_48_1(arg_50_0)
		for iter_50_0 = 1, #arg_48_1.toggleContainer do
			if arg_50_0 == iter_50_0 then
				var_48_0(arg_48_1.toggleContainer[iter_50_0], true)
			else
				var_48_0(arg_48_1.toggleContainer[iter_50_0], false)
			end
		end
	end

	while arg_48_1:getChildByName("toggle" .. 1) do
		local var_48_2 = arg_48_1:getChildByName("toggle" .. 1)

		var_48_2.index = 1
		var_48_2.isShow = false

		var_48_2:addTouchEventListener(function(arg_51_0, arg_51_1)
			if arg_51_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_48_1(arg_51_0.index)
		end)
		var_48_2:getChildByName("click"):setVisible(false)

		arg_48_1.toggleContainer[1] = var_48_2
	end

	var_48_1(arg_48_3)
end

function var_0_0.setToggleCallback(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	if arg_52_1 == nil then
		return
	end

	arg_52_3 = arg_52_3 or false

	local function var_52_0(arg_53_0)
		local var_53_0 = arg_52_1:getChildByName("click")

		if arg_53_0 == true then
			arg_53_0 = false

			var_53_0:setVisible(false)
		else
			arg_53_0 = true

			var_53_0:setVisible(true)
		end

		arg_52_1.tglStatus = arg_53_0

		arg_52_2(arg_53_0)
	end

	arg_52_1:addTouchEventListener(function(arg_54_0, arg_54_1)
		if arg_54_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_52_0(arg_54_0.tglStatus)
	end)
	var_52_0(not arg_52_3)
end

function var_0_0.getEditBox(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	local var_55_0 = cc.EditBox:create(arg_55_2, (config._DEBUG or nil) and (cc.Scale9Sprite:create(arg_55_1) or cc.Scale9Sprite:createWithSpriteFrameName(arg_55_1)))

	var_55_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_55_0:registerScriptEditBoxHandler(function(arg_56_0)
		if type(arg_55_3) == "function" then
			arg_55_3(arg_56_0, var_55_0)
		end
	end)

	return var_55_0
end

function var_0_0.getNewStack(arg_57_0)
	local var_57_0 = {
		num = 0
	}

	function var_57_0.pushItem(arg_58_0)
		if var_57_0.head == nil then
			var_57_0.head = {
				value = arg_58_0
			}
			var_57_0.num = var_57_0.num + 1
		else
			local var_58_0 = var_57_0.head

			while var_58_0 and var_58_0.next do
				var_58_0 = var_58_0.next
			end

			var_58_0.next = {
				value = arg_58_0
			}
			var_57_0.num = var_57_0.num + 1
		end
	end

	function var_57_0.popItem()
		local var_59_0

		if var_57_0.head == nil then
			var_57_0.num = 0
		else
			local var_59_1 = var_57_0.head

			while var_59_1 and var_59_1.next do
				var_59_1 = var_59_1.next
			end

			var_59_0 = cloneconf(var_59_1.value)
			var_57_0.num = var_57_0.num - 1
		end

		return var_59_0
	end

	return var_57_0
end

function var_0_0.haveFileExist(arg_60_0, arg_60_1)
	if io.exists(arg_60_1) then
		return true
	else
		return false
	end
end

function var_0_0:createNewFile(arg_61_1)
	if not self:haveFileExist(arg_61_1) then
		local var_61_0 = io.open(arg_61_1, "w+b")

		var_61_0:write(" local value_list = {} \n\n\nreturn value_list\n")
		var_61_0:flush()
		var_61_0:close()
	else
		return false
	end
end

function var_0_0.parseDataByElement(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = {}

	if type(arg_62_1) ~= "table" then
		return var_62_0
	end

	local var_62_1 = 1

	while true do
		local var_62_2 = 0
		local var_62_3 = {}

		for iter_62_0, iter_62_1 in ipairs(arg_62_2) do
			if iter_62_1.hyphen then
				local var_62_4 = iter_62_1.index .. iter_62_1.hyphen .. var_62_1 or "" .. iter_62_1.index .. var_62_1

				if arg_62_1[var_62_4] then
					var_62_2 = var_62_2 + 1
					var_62_3[iter_62_1.name] = arg_62_1[var_62_4]
				end
			end
		end

		local var_62_5

		if var_62_2 == 0 then
			var_62_5 = false
		else
			var_62_0[#var_62_0 + 1] = var_62_3
			var_62_1 = var_62_1 + 1
		end
	end

	return var_62_0
end

function var_0_0.createProgressBar(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	local var_63_0 = ccui.Slider:create()

	var_63_0:loadBarTexture(arg_63_1, arg_63_3)
	var_63_0:loadProgressBarTexture(arg_63_2, arg_63_3)
	var_63_0:setPercent(0)

	return var_63_0
end

function var_0_0.compare(arg_64_0, arg_64_1, arg_64_2)
	if type(arg_64_1) ~= "table" and type(arg_64_2) ~= "table" then
		return arg_64_1 == arg_64_2
	elseif type(arg_64_1) ~= type(arg_64_2) then
		return false
	end

	for iter_64_0, iter_64_1 in pairs(arg_64_1) do
		if not var_0_0:compare(arg_64_1[iter_64_0], arg_64_2[iter_64_0]) then
			return false
		end
	end

	return true
end

function var_0_0.convertTableToSequence(arg_65_0, arg_65_1, arg_65_2)
	local var_65_0 = {}

	for iter_65_0, iter_65_1 in pairs(arg_65_1) do
		var_65_0[#var_65_0 + 1] = iter_65_1
	end

	table.sort(var_65_0, arg_65_2)

	return var_65_0
end

function var_0_0.getFormatString(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	local var_66_0 = math.min(string.utf8len(arg_66_1), arg_66_2)

	arg_66_1 = require("controller.utf8").sub(arg_66_1, 1, var_66_0)

	if var_66_0 == arg_66_2 then
		arg_66_1 = arg_66_1 .. arg_66_3
	end

	return arg_66_1
end

function var_0_0.checkWeekday(arg_67_0, arg_67_1)
	local var_67_0 = {}

	for iter_67_0, iter_67_1 in pairs(string.split(arg_67_1, ",")) do
		table.insert(var_67_0, tonumber(iter_67_1))
	end

	local var_67_1 = tonumber(os.date("%w", (require("controller.time_check_manager"):getCurTime())))

	for iter_67_2, iter_67_3 in pairs(var_67_0) do
		if iter_67_3 % 7 == var_67_1 then
			return true
		end
	end

	return false
end

function var_0_0.numbterStrToChinese(arg_68_0, arg_68_1)
	local var_68_0 = ""

	for iter_68_0, iter_68_1 in pairs(string.split(arg_68_1, ",")) do
		var_68_0 = var_68_0 == "" and L_WEEK_TEXT_SIMPLE[iter_68_1] or var_68_0 .. "、" .. L_WEEK_TEXT_SIMPLE[iter_68_1]
	end

	return var_68_0
end

return var_0_0
