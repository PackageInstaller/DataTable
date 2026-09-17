local var_0_0 = {}
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local activity_return_manager = require("controller.activity_return_manager")
local item_data = require("data.item_data")
local activity_sign_conf = require("data.activity_modules.activity_sign_conf")
local network = require("network.network")
local hexie_manager = require("controller.hexie_manager")

function var_0_0.check_autopop_event(arg_1_0)
	network:rpc("check_autopop_sign", nil, function(arg_2_0)
		local var_2_0 = cc.EventCustom:new("INITIAL_POP_SIGN_LIST")

		var_2_0.list = arg_2_0.list

		if cc.UserDefault:getInstance():getIntegerForKey("nextAutoPopReturn", 0) < time_check_manager:getCurTime() then
			if var_2_0.list and next(var_2_0.list) then
				table.insert(var_2_0.list, 1, "returnpoplayer")
			else
				var_2_0.list = {
					"returnpoplayer"
				}
			end

			table.insert(var_2_0.list, "trans_overdue_item")
		end

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_2_0)
	end)
end

local function var_0_8(arg_3_0)
	activity_manager:check_red_packet(arg_3_0, function(arg_4_0, arg_4_1)
		if arg_4_0 == 1 and arg_4_1 == 1 then
			LayerManager:pushInLayer("PopBachelorWelfareLayer", {
				id = arg_3_0,
				exitcallback = function()
					cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
				end
			})
		else
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end
	end)
end

local function var_0_9(arg_6_0)
	LayerManager:pushInLayer("PopShowGirlPageLayer", {
		id = arg_6_0,
		exitcallback = function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end
	})
end

local function var_0_10(arg_8_0)
	LayerManager:pushInLayer("PopActivityDropInfoLayer", {
		activityId = arg_8_0,
		exitcallback = function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end
	})
end

local function var_0_11()
	LayerManager:pushInLayer("PopRechargePreviewLayer", {
		group = 401,
		callback = function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end
	})
end

local function var_0_12(arg_25_0)
	LayerManager:pushInLayer("PopAnswerQuestionLayer", {
		activityid = arg_25_0,
		callback = function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end
	})
end

local function var_0_13()
	LayerManager:pushInLayer("PopActivityCalendar", {
		callback = function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end
	})
end

local var_0_14 = setmetatable({
	[140] = function()
		LayerManager:pushInLayer("PopShowGirlPageLayer", {
			id = 140,
			exitcallback = function()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
			end
		})
	end
}, {
	__index = function(arg_31_0, arg_31_1)
		if tonumber(arg_31_1) - tonumber(arg_31_1) % 100000 == 1700000 or math.floor(tonumber(arg_31_1) / 100000) == 35 then
			return function(...)
				require("controller.goto_system_manager")
				goto_complete_system({
					jump_to_system = arg_31_1,
					config = {
						callback = function()
							cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
						end
					}
				})
			end
		elseif math.floor(arg_31_1 / 10000) == 888 then
			return function()
				LayerManager:pushInLayer("BirthPopBaseLayer", {
					id = arg_31_1,
					exitcallback = function()
						cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
					end
				})
			end
		else
			return function()
				LayerManager:pushInLayer("ActivityPopBaseLayer", {
					id = arg_31_1,
					exitcallback = function()
						cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
					end
				})
			end
		end

		return nil
	end
})
local var_0_15 = setmetatable({
	[2] = function()
		LayerManager:pushInLayer("ActivitySignBaseLayer", {
			activityid = 2,
			activityUIObjName = "ActivitySignFmlLayer",
			exit_set_bright_callback = function()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
			end
		})
	end,
	[152] = function(...)
		require("controller.goto_system_manager")
		goto_complete_system({
			jump_to_system = 3100001,
			config = {
				defaultsys = 2000152
			}
		})
	end
}, {
	__index = function(arg_41_0, arg_41_1)
		if not activity_sign_conf[arg_41_1] then
			return nil
		end

		if activity_sign_conf[arg_41_1].is_auto_pop ~= 1 then
			return nil
		end

		return function()
			LayerManager:pushInLayer("ActivitySignBaseLayer", {
				activityUIObjName = "ActivitySignTemplateLayer",
				exit_set_bright_callback = function()
					cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
				end,
				activityid = arg_41_1
			})
		end
	end
})
local var_0_16 = {
	MainLayer = setmetatable({
		returnpoplayer = function()
			local function var_10_0()
				local var_11_0 = cc.UserDefault:getInstance():getIntegerForKey("nextAutoPopReturn", 0)
				local var_11_1 = time_check_manager:getCurTime()

				if var_11_0 and var_11_1 < var_11_0 then
					return
				end

				local var_11_2 = os.date("*t", var_11_1)

				cc.UserDefault:getInstance():setIntegerForKey("nextAutoPopReturn", (os.time({
					hour = 23,
					min = 59,
					sec = 59,
					year = var_11_2.year,
					month = var_11_2.month,
					day = var_11_2.day
				})))
			end

			if activity_return_manager:get_mail_drop() then
				LayerManager:pushInLayer("PopActivityReturnDetailLayer", {
					callback = function()
						var_10_0()
						cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
					end
				})
			elseif activity_return_manager:get_exist_sign() then
				-- block empty
			else
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
			end
		end,
		arenatft = function()
			LayerManager:pushInLayer("PopTvtNewSeasonMainLayer", {
				exitcallback = function()
					cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
				end
			})
		end,
		trans_overdue_item = function(...)
			local time_check_manager = require("controller.time_check_manager")

			require("controller.item_manager"):trans_overdue_item(function(arg_16_0)
				if arg_16_0.result == 1 and next(arg_16_0.items) then
					-- block empty
				end
			end)
		end,
		act_birthdayparty = function(...)
			local birthday_party_manager = require("controller.birthday_party_manager")
			local var_17_1 = birthday_party_manager:getTodayBirthdayIndex()

			if var_17_1 ~= nil and birthday_party_manager:isOpenBirthdayParty() then
				LayerManager:pushInLayer("PopBirthdayPartyLayer", {
					startIndex = var_17_1
				})
			end
		end,
		pushopen = function(...)
			if global_check_is_show_push_open() then
				LayerManager:pushInLayer("PopPushOpenLayer")
			end
		end,
		managemoney = function(...)
			LayerManager:pushInLayer("ManageMoneyLayer", {
				ispop = true,
				exitcallback = function()
					cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
				end
			})
		end,
		twistreturn = function(...)
			LayerManager:pushInLayer("NewbeeTwistReturnLayer", {
				ispop = true,
				exitcallback = function()
					cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
				end
			})
		end
	}, {
		__index = function(arg_44_0, arg_44_1)
			print(arg_44_0, arg_44_1)

			if arg_44_1:find("^activitypop") then
				local var_44_0 = tonumber(arg_44_1:match("activitypop(%d+)"))

				if var_44_0 == 206320 and (hexie_manager:isChannelInShenheTime() or DeviceManager:getChannelID() == "270057") then
					return nil
				end

				if var_44_0 == 13002820 then
					return function()
						require("controller/novice_month_card_pop_manager"):getInstance():popLayer(arg_44_1)
					end
				elseif var_44_0 == 800050 then
					return function()
						LayerManager:pushInLayer("ReturnBackCardPopLayer", {
							daystr = arg_44_1,
							exitcallback = function()
								cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
							end
						})
					end
				elseif var_44_0 == 800115 and DeviceManager:getChannelID() == "270048" then
					return nil
				elseif activity_manager:can_show_activity_pop(var_44_0) then
					return var_0_14[var_44_0]
				else
					return nil
				end
			elseif arg_44_1:find("^activitysign") then
				return var_0_15[tonumber(arg_44_1:match("activitysign(%d+)"))]
			elseif arg_44_1:find("^redpacket") then
				local var_44_1 = tonumber(arg_44_1:match("redpacket(%d+)"))

				return function()
					var_0_8(var_44_1)
				end
			elseif arg_44_1:find("^showgrilpage") then
				local var_44_2 = tonumber(arg_44_1:match("showgrilpage(%d+)"))

				return function()
					var_0_9(var_44_2)
				end
			elseif arg_44_1:find("^dropinfo") then
				local var_44_3 = tonumber(arg_44_1:match("dropinfo(%d+)"))

				return function()
					var_0_10(var_44_3)
				end
			elseif arg_44_1:find("^recharge_daily_prize") then
				return function()
					LayerManager:pushInLayer("PopRechargeDailyPrizeLayer")
				end
			elseif arg_44_1:find("^recharge_daily") then
				return function()
					var_0_11(activityId)
				end
			elseif arg_44_1:find("^questiuon") then
				return function()
					var_0_12((tonumber(arg_44_1:match("questiuon(%d+)"))))
				end
			elseif arg_44_1:find("^act_calenda") then
				return function()
					var_0_13()
				end
			elseif arg_44_1:find("^entrance") then
				return function()
					LayerManager:switchShowLayer("ActivityEntranceLayer")
				end
			elseif arg_44_1:find("^phonebind") then
				return function()
					LayerManager:pushInLayer("PopPhoneNumberLayer")
				end
			elseif arg_44_1:find("^return_back_packs") then
				return function()
					LayerManager:pushInLayer("PopReturnBackPacksLayer")
				end
			elseif arg_44_1:find("^create_new_account") then
				return function()
					if require("controller.account_manager"):getAccountPlayerRealCount() < 6 then
						LayerManager:pushInLayer("PopCreateNewAccountLayer")
					else
						cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
					end
				end
			end

			return nil
		end
	})
}

function var_0_0:init_autopop_list_by_layername(arg_59_1, arg_59_2)
	if not var_0_16[arg_59_1] then
		return nil
	end

	local var_59_0 = var_0_16[arg_59_1]
	local var_59_1 = {}

	for iter_59_0, iter_59_1 in ipairs(arg_59_2) do
		if var_59_0[iter_59_1] then
			table.insert(var_59_1, iter_59_1)
		end
	end

	self._popsignlist = self._popsignlist or {}
	self._popsignlist[arg_59_1] = var_59_1
end

function var_0_0.get_autopop_func(arg_60_0, arg_60_1, arg_60_2)
	if not var_0_16[arg_60_1] then
		return nil
	end

	return var_0_16[arg_60_1][arg_60_2]
end

function var_0_0:get_popsignlist(arg_61_1)
	return (arg_61_1 and self._popsignlist or nil) and (self._popsignlist[arg_61_1] or {})
end

function var_0_0:is_empty_with_popsignlist(arg_62_1)
	if not self._popsignlist then
		return true
	end

	if not self._popsignlist[arg_62_1] then
		return true
	end

	if #self._popsignlist[arg_62_1] == 0 then
		return true
	end

	return false
end

function var_0_0:remove_popsignlist(arg_63_1, arg_63_2)
	if not self._popsignlist then
		return
	end

	if self._popsignlist[arg_63_1] and #self._popsignlist[arg_63_1] > 0 then
		return table.remove(self._popsignlist[arg_63_1], arg_63_2)
	else
		return nil
	end
end

return var_0_0
