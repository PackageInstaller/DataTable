local var_0_0 = {}
local network = require("network.network")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local fitness_data = require("data.fitness_data")

var_0_0.playerid = nil
var_0_0.gold = nil
var_0_0.diamond = nil
var_0_0.honor = nil
var_0_0.exp = nil
var_0_0.totalexp = nil
var_0_0.exploreActions = nil
var_0_0.grade = nil
var_0_0.class = nil
var_0_0.level = nil
var_0_0.curLevel = nil
var_0_0.curMode = nil
var_0_0.curArray = nil
var_0_0.curSoul = {}
var_0_0.showgirl = nil
var_0_0.arrays = {}
var_0_0.arenaArray = nil
var_0_0.arenaAttackArray = nil
var_0_0.scorearenaAttackArray = nil
var_0_0.dormRoomConfig = {}
var_0_0.dormLiveRoomConfig = {}
var_0_0.weaponmodel = {}
var_0_0.readyPlots = {}
var_0_0.runningPlots = {}
var_0_0.invalidPlot = {}
var_0_0.patrolInfo = {}
var_0_0.levelmodeReward = {}
var_0_0.marrytimes = {}
var_0_0.explorelevel = {}
var_0_0.haveblackcard = false
var_0_0.haverechargeaward = false
var_0_0.haverecharge = false
var_0_0.rechargecount = 0
var_0_0.haveopenaward = false
var_0_0.havequickfight = false
var_0_0.showXPEffect = true
var_0_0.twistTenPop = false
var_0_0.novice_award_process = 0
var_0_0.mcard_last_afk_vaild = nil
var_0_0.qcard_last_afk_vaild = nil
var_0_0.fcard_last_afk_vaild = nil
var_0_0.ycard_last_afk_vaild = nil
var_0_0.quickfight_count = nil
var_0_0.rechargeamount = 0
var_0_0.rechargeamountxinxiya = 0
var_0_0.rechargeamountTGV = 0
var_0_0.novice_pass_level_award = {}
var_0_0.novice_award_process_xinxiya = 0
var_0_0.novice_award_process_lucun = 0
var_0_0.award_up_info = {}
var_0_0.newbee_card_finishtime = nil
var_0_0.exploreArrays = {}
var_0_0.isInitExploreArrays = false
var_0_0.bindmobilestatus = 0
var_0_0.horcruxDevour = {}
var_0_0.horcruxServants = {}
var_0_0.lastreturnbacktime = 0
var_0_0.is_new_player_guide = true

function var_0_0:init(arg_1_1, arg_1_2)
	self:resetPlayer()
	self:initSystemContants()
	self:initPlayerBasic(arg_1_1, arg_1_2)
	self:initPlayerStatus(arg_1_2)
	self:initPlayerCore()
	self:initPlayerSouls(arg_1_2)
	self:initPlayerArrays(arg_1_2)
	self:initPlayerDropCache(arg_1_2)
	self:initPlayerLevelMode(arg_1_2)
	self:initPlayerGuide(arg_1_2)
	self:initPlayerArenaData(arg_1_2)
	self:initPlayerScoreArenaData(arg_1_2)
	self:getServerTime(arg_1_2)
	self:initPlayerItems(arg_1_2)
	self:initDormRoom()
	self:initPlayerTask()
	self:initPlayerPlot()
	self:initActivityShopList()
	self:initCurActivities()
	self:initSignData()
	self:initPatrolInfo()
	self:initEventInfo()
	self:initHideSkinItem()
	self:initLevelmodeReward()
	self:initExploreLevelInfo()
	self:initBirthdayPartyInfo()
	self:initGameBuffInfo()
	self:initCourseDatas()
	self:initCostumeRoomCumulativeRewardInfo()
	self:initLimitTowerDefenceLevelInfo()
	self:initDailyWeeklyAlert()
	self:initPrivilege()
	self:initRechargePrivilege()
end

function var_0_0:reloadPlayerData(arg_2_1)
	self:reloadSystemAlert(arg_2_1)
	self:reloadPlayerBasic(arg_2_1)
	self:reloadPlayerStatus(arg_2_1)
	self:reloadPlayerSouls(arg_2_1)
	self:reloadPlayerArrays(arg_2_1)
	self:reloadPlayerDropCache(arg_2_1)
	self:reloadPlayerLevelMode(arg_2_1)
	self:reloadPlayerGuide(arg_2_1)
	self:reloadPlayerScoreArenaData(arg_2_1)
	self:getServerTime(arg_2_1)
	self:reloadPlayerItems(arg_2_1)
	self:initGameBuffInfo(arg_2_1)
	self:initPlayerTask()
	self:initExploreLevelInfo()
	require("controller.parse_server"):passOfflineFight(function(...)
		print(dump(...))
	end)
end

function var_0_0.initSignData(arg_4_0)
	require("controller.sign_manager"):init()
end

function var_0_0.initBirthdayPartyInfo(arg_5_0)
	require("controller.birthday_party_manager"):init()
end

function var_0_0.initCostumeRoomCumulativeRewardInfo(arg_6_0)
	require("controller.costume_room_cumulative_reward_manager"):getInstance():requestInfo()
end

function var_0_0.initLimitTowerDefenceLevelInfo(arg_7_0)
	require("controller.limit_tower_defence_level_manager"):getInstance():RequestInfo()
end

function var_0_0.initDailyWeeklyAlert(arg_8_0)
	require("controller/daily_weekly_manager"):getInstance():requestAlert()
end

function var_0_0.initPrivilege(arg_9_0)
	require("controller.supermarket_privilege_manager"):getInstance():requestInfo()
end

function var_0_0.initRechargePrivilege(arg_10_0)
	require("controller.supermarket_privilege_recharge_manager"):getInstance():requestInfo()
end

function var_0_0.initCourseDatas(arg_11_0)
	require("controller.course_cultivate_manager").getInstance()
end

function var_0_0.initPlayerBond(arg_12_0)
	require("controller.bond_manager"):init()
end

function var_0_0.updateBondInfo(arg_13_0, arg_13_1)
	require("controller.bond_manager"):updateDataInfo(arg_13_1)
end

function var_0_0:resetPlayer()
	self.gold = 0
	self.diamond = 0
	self.honor = 0
	self.explorecoin = 0
	self.exp = 0
	self.grade = 0
	self.class = 0
	self.level = 0
	self.curLevel = 0
	self.curMode = 0
	self.curArray = nil
	self.nickname = 0
	self.signment = 0
	self.head_sculpture = 0
	self.showgirl = 0
	self.background = 6300001
	self.lastOnlineTime = nil
	self.create_time = nil
	self.component_smeltnum = 0
	self.strengthpoint = 0
	self.assistlimit = 0
	self.verifylimit = 0
	self.bagweight = {}
	self.maxbagweight = 0
	self.cur_medal = 0
	self.autoXP = false
	self.haveSuit = {}
	self.soulContract = {}
	self.favor = {}
	self.fitness = {}
	self.component = {}
	self.gift_limit = {}
	self.activity = {}
	self.weaponId = {}
	self.cores = {}
	self.vote = {}
	self.souls_sanvalue = {}
	self.curSoul = {}
	self.arrays = {}
	self.items = {}
	self.dropcache = {}
	self.levelmode = {}
	self.arenaArray = nil
	self.arenaAttackArray = nil
	self.gameInitGuides = {}

	require("view.Layer.Guide.GuideListener"):reset()

	self.dormRoomConfig = {}
	self.dormLiveRoomConfig = {}

	require("controller.task_manager"):reset()

	self.weaponmodel = {}
	self.readyPlots = {}
	self.runningPlots = {}
	self.invalidPlot = {}
	self.hideSkinItemTbl = {}
	self.exploreLevel = {}
	self.marrytimes = {}
	self.addRollRarity = {}

	self:resetExploreArraysHpInherit()

	self.is_new_player_guide = true
end

function var_0_0.initSystemContants(arg_15_0)
	return
end

local function var_0_6(arg_16_0)
	local var_16_0 = {}
	local var_16_1

	while arg_16_0[1 * 2] do
		var_16_0[1] = {
			weight = tonumber(arg_16_0[1 * 2 - 1]),
			limit = tonumber(arg_16_0[1 * 2])
		}

		if var_16_0[1].weight >= var_16_0[1].limit and 1 ~= 2 then
			var_16_1 = true
		end
	end

	if var_16_1 then
		require("controller.alert_manager"):register_alert(ALERT_BAG)
	end

	return var_16_0
end

function var_0_0:initPlayerBasic(arg_17_1, arg_17_2)
	self.basicmodel = require("controller.model_manager").new()
	self.autoXP = RoleDefault:getInstance():getBoolForKey("fightauto", false)
	self.showXPEffect = cc.UserDefault:getInstance():getBoolForKey("XPeffect", true)
	self.twistTenPop = cc.UserDefault:getInstance():getBoolForKey("twistTenPop", false)

	self:loadPlayerBasicFromServer(arg_17_1, arg_17_2)
end

function var_0_0:reloadPlayerBasic(arg_18_1)
	self:loadPlayerBasicFromServer(self.playerid, arg_18_1)
end

function var_0_0.loadPlayerBasicFromServer(arg_19_0, arg_19_1, arg_19_2)
	local model_manager = require("controller.model_manager")
	local model_data = require("data.model_data")
	local background_data = require("data.background_data")

	network:rpc("get_player_basic", {
		playerid = arg_19_1
	}, function(arg_20_0)
		arg_19_0.playerid = arg_20_0.data.playerid
		arg_19_0.gold = tonumber(arg_20_0.data.gold)
		arg_19_0.diamond = arg_20_0.data.diamond
		arg_19_0.honor = arg_20_0.data.honor
		arg_19_0.exp = tonumber(arg_20_0.data.exp)
		arg_19_0.totalexp = tonumber(arg_20_0.data.totalexp)
		arg_19_0.grade = arg_20_0.data.grade
		arg_19_0.class = arg_20_0.data.class
		arg_19_0.level = arg_20_0.data.level
		arg_19_0.curLevel = arg_20_0.data.cur_stayin_level or 1
		arg_19_0.curMode = arg_20_0.data.cur_stayin_mode or 1
		arg_19_0.curArray = arg_20_0.data.cur_array
		arg_19_0.nickname = arg_20_0.data.nickname
		arg_19_0.signment = arg_20_0.data.signment
		arg_19_0.head_sculpture = arg_20_0.data.head_sculpture

		arg_19_0:updateShowGirl(arg_20_0.data.showgirl, arg_20_0.data.background)

		arg_19_0.lastOnlineTime = global_get_time_by_date(arg_20_0.data.last_login_time)
		arg_19_0.create_time = global_get_time_by_date(arg_20_0.data.create_time)
		arg_19_0.strengthpoint = arg_20_0.data.strengthpoint
		arg_19_0.bagweight = var_0_6(arg_20_0.data.bagweight)
		arg_19_0.cur_medal = arg_20_0.data.cur_medal or {
			0,
			0,
			0
		}
		arg_19_0.exploreActions = arg_20_0.data.explore_actions
		arg_19_0.lastDiamond = arg_20_0.data.diamond
		arg_19_0.medalsCoding = arg_20_0.data.medals or {}
		arg_19_0.mcard_last_afk_vaild = arg_20_0.data.mcard_last_afk_vaild
		arg_19_0.qcard_last_afk_vaild = arg_20_0.data.qcard_last_afk_vaild
		arg_19_0.fcard_last_afk_vaild = arg_20_0.data.fcard_last_afk_vaild
		arg_19_0.ycard_last_afk_vaild = arg_20_0.data.ycard_last_afk_vaild
		arg_19_0.quickfight_count = arg_20_0.data.quickfight_count
		arg_19_0.rechargeamount = arg_20_0.data.rechargeamount
		arg_19_0.rechargeamountxinxiya = arg_20_0.data.rechargeamountxinxiya
		arg_19_0.rechargeamountTGV = arg_20_0.data.rechargeamountTGV or 0
		arg_19_0.novice_pass_level_award = arg_20_0.data.novice_pass_level_award
		arg_19_0.award_up_info = json.decode(arg_20_0.data.award_up_info)
		arg_19_0.newbee_card_finishtime = arg_20_0.data.newbee_card_finishtime
		arg_19_0.common_update_time = arg_20_0.data.common_update_time

		if arg_19_2 then
			arg_19_2()
		end

		local account_manager = require("controller.account_manager")

		if account_manager.onLoginSuccess then
			account_manager:onLoginSuccess(arg_19_0)
		end
	end)
end

function var_0_0:initPlayerStatus(arg_21_1)
	self:loadPlayerStatusFromServer(arg_21_1)
end

function var_0_0:reloadPlayerStatus(arg_22_1)
	self:loadPlayerStatusFromServer(arg_22_1)
end

function var_0_0.loadPlayerStatusFromServer(arg_23_0, arg_23_1)
	local account_manager = require("controller.account_manager")

	network:rpc("get_player_status", {
		sdkver = "3.0",
		channelid = account_manager:getChannel(),
		uuid = account_manager:getUserID(),
		platform = account_manager:getPlatform()
	}, function(arg_24_0)
		hx_print("get_player_status")
		print_lua_table(arg_24_0)

		arg_23_0.haveblackcard = arg_24_0.haveblackcard
		arg_23_0.haverechargeaward = arg_24_0.haverechargeaward
		arg_23_0.rechargecount = arg_24_0.rechargecount or 0
		arg_23_0.haverecharge = arg_23_0.rechargecount > 0
		arg_23_0.haveopenaward = arg_24_0.haveopenaward
		arg_23_0.havequickfight = arg_24_0.havequickfight
		arg_23_0.pushopen = arg_24_0.pushopen
		arg_23_0.pushactivity = arg_24_0.pushactivity
		arg_23_0.pushlab = arg_24_0.pushlab
		arg_23_0.pushpatrol = arg_24_0.pushpatrol
		arg_23_0.pushoffline = arg_24_0.pushoffline

		if global_check_is_show_push_open() then
			umeng_pushSwitch(arg_24_0.pushopen)
		end

		arg_23_0.isShowGiftbag = arg_24_0.is_show_giftbag
		arg_23_0.novice_award_process = arg_24_0.novice_award_process
		arg_23_0.novice_pass_level_award = arg_24_0.novice_pass_level_award
		arg_23_0.novice_award_process_xinxiya = arg_24_0.novice_award_process_xinxiya
		arg_23_0.novice_award_process_lucun = arg_24_0.novice_award_process_lucun
		arg_23_0.lastreturnbacktime = arg_24_0.lastreturnbacktime
		arg_23_0.is_new_player_guide = arg_24_0.is_new_player_guide

		if STATIC_IS_OWOD and not arg_24_0.isharmony then
			global_revert_harmony_world()
		end

		if not arg_23_0.haverechargeaward then
			require("controller.alert_manager"):register_alert(ALERT_FIRST_RECHARGE)
		end

		arg_23_0.bindmobilestatus = arg_24_0.bindmobilestatus

		require("controller.share_manager"):enableChannelShare(arg_24_0.enableshare)

		if arg_23_1 then
			arg_23_1()
		end
	end)
end

function var_0_0.updatePushSetting(arg_25_0, arg_25_1, arg_25_2)
	network:rpc("set_player_push", {
		pushtype = arg_25_1,
		status = arg_25_2
	})

	arg_25_0[arg_25_1] = arg_25_2
end

function var_0_0.initPlayerCore(arg_26_0, arg_26_1)
	require("controller.core_manager"):init()

	if arg_26_1 then
		arg_26_1()
	end
end

function var_0_0:initPlayerSouls(arg_27_1)
	self.haveSuit = {}
	self.favor = setmetatable({}, {
		__index = function(arg_28_0, arg_28_1)
			if not arg_28_1 then
				print(debug.traceback())
			end

			local var_28_0 = {
				favorlevel = 0,
				favordegree = 0
			}

			arg_28_0[arg_28_1] = var_28_0

			return var_28_0
		end
	})
	self.fitness = setmetatable({}, {
		__index = function(arg_29_0, arg_29_1)
			return {
				fitnesslevel = 0,
				fitnessdegree = 0
			}
		end
	})
	self.dress = setmetatable({}, {
		__index = function(arg_30_0, arg_30_1)
			return -1
		end
	})
	self.souls_sanvalue = setmetatable({}, {
		__index = function(arg_31_0, arg_31_1)
			return fitness_data[0].sanvalue_up_limit
		end
	})
	self.gift_limit = setmetatable({}, {
		__index = function(arg_32_0, arg_32_1)
			return GIFT_LIMIT
		end
	})
	self.gift_send_times = setmetatable({}, {
		__index = function(arg_33_0, arg_33_1)
			return 0
		end
	})
	self.dormfavor_limit = setmetatable({}, {
		__index = function(arg_34_0, arg_34_1)
			return DORMFAVOR_LIMIT
		end
	})
	self.haveServant = {}
	self.soulContract = setmetatable({}, {
		__index = function(arg_35_0, arg_35_1)
			return -1
		end
	})
	self.servantNum = setmetatable({}, {
		__index = function(arg_36_0, arg_36_1)
			return 0
		end
	})
	self.weaponId = {}
	self.cores = setmetatable({}, {
		__index = function(arg_37_0, arg_37_1)
			return {
				extra = 0,
				exp = 0,
				coreid = 1
			}
		end
	})
	self.component = {}
	self.vote = setmetatable({}, {
		__index = function(arg_38_0, arg_38_1)
			return 0
		end
	})
	self.quickfight = setmetatable({}, {
		__index = function(arg_39_0, arg_39_1)
			return 0
		end
	})
	self.passiveLevel = setmetatable({}, {
		__index = function(arg_40_0, arg_40_1)
			return 0
		end
	})
	self.skill1Level = setmetatable({}, {
		__index = function(arg_41_0, arg_41_1)
			return 0
		end
	})
	self.newservants = {}
	self.newservantsArchives = {}
	self.servantUsedskin = setmetatable({}, {
		__index = function(arg_42_0, arg_42_1)
			return -1
		end
	})
	self.soulOverClock = setmetatable({}, {
		__index = function(arg_43_0, arg_43_1)
			return 0
		end
	})
	self.reinforce_component = setmetatable({}, {
		__index = function(arg_44_0, arg_44_1)
			return 0
		end
	})
	self.servant_unlock_time = setmetatable({}, {
		__index = function(arg_45_0, arg_45_1)
			return 0
		end
	})
	self.addRollRarity = setmetatable({}, {
		__index = function(arg_46_0, arg_46_1)
			return 0
		end
	})

	self:loadPlayerSoulsFromServer(arg_27_1)
end

function var_0_0:reloadPlayerSouls(arg_47_1)
	self:loadPlayerSoulsFromServer(arg_47_1)
end

function var_0_0.loadPlayerSoulsFromServer(arg_48_0, arg_48_1)
	network:rpc("get_player_soul", nil, function(arg_49_0)
		arg_48_0.horcruxServants = {}

		for iter_49_0, iter_49_1 in ipairs(arg_49_0.souls) do
			local var_49_0 = iter_49_1.soulid

			arg_48_0.haveSuit[iter_49_1.soulid] = iter_49_1.servant ~= nil and #iter_49_1.servant > 0
			arg_48_0.favor[var_49_0] = {
				favorlevel = iter_49_1.favorlevel,
				favordegree = iter_49_1.favordegree
			}

			local var_49_1 = {}

			var_49_1.fitnesslevel = iter_49_1.fitnesslevel or 0
			var_49_1.fitnessdegree = iter_49_1.fitnessdegree or 0
			arg_48_0.fitness[var_49_0] = var_49_1
			arg_48_0.dress[var_49_0] = iter_49_1.dress
			arg_48_0.souls_sanvalue[var_49_0] = iter_49_1.sanvalue

			if iter_49_1.giftfreelimit - iter_49_1.giftsendtimes > 0 then
				arg_48_0.gift_limit[var_49_0] = iter_49_1.giftfreelimit - iter_49_1.giftsendtimes or 0
			end

			arg_48_0.gift_send_times[var_49_0] = iter_49_1.giftsendtimes
			arg_48_0.marrytimes[var_49_0] = iter_49_1.marrytime
			arg_48_0.quickfight[var_49_0] = iter_49_1.quickfight

			for iter_49_2, iter_49_3 in ipairs(iter_49_1.servant or {}) do
				local var_49_2 = iter_49_3.id

				arg_48_0.haveServant[iter_49_3.id] = iter_49_3.contract >= 0
				arg_48_0.soulContract[var_49_2] = iter_49_3.contract
				arg_48_0.servantNum[var_49_2] = iter_49_3.own
				arg_48_0.weaponId[var_49_2] = iter_49_3.weaponid
				arg_48_0.cores[var_49_2] = iter_49_3.core
				arg_48_0.soulOverClock[var_49_2] = iter_49_3.overclock
				arg_48_0.reinforce_component[var_49_2] = iter_49_3.reinforce_component
				arg_48_0.servant_unlock_time[var_49_2] = iter_49_3.unlock_time
				arg_48_0.horcruxDevour[var_49_2] = {}
				iter_49_3.horcruxs = iter_49_3.horcruxs or {}

				for iter_49_4 = 1, HORCRUX_DEVOUR_MAX do
					arg_48_0.horcruxDevour[var_49_2][iter_49_4] = iter_49_3.horcruxs[iter_49_4] and iter_49_3.horcruxs[iter_49_4] or {}

					if iter_49_3.horcruxs[iter_49_4] and iter_49_3.horcruxs[iter_49_4].horcrux then
						arg_48_0.horcruxServants[iter_49_3.horcruxs[iter_49_4].horcrux] = var_49_2
					end
				end

				if iter_49_3.component then
					arg_48_0.component[var_49_2] = {}

					for iter_49_5, iter_49_6 in ipairs(iter_49_3.component) do
						arg_48_0.component[var_49_2][iter_49_6.pos] = iter_49_6
					end
				end

				if not iter_49_3.skillslevel then
					arg_48_0.passiveLevel[var_49_2] = 0
					arg_48_0.skill1Level[var_49_2] = 0
				else
					if not iter_49_3.skillslevel[1] then
						arg_48_0.passiveLevel[var_49_2] = 0
					end

					arg_48_0.skill1Level[var_49_2] = iter_49_3.skillslevel[2] or 0
				end

				arg_48_0.vote[var_49_2] = iter_49_3.vote
				arg_48_0.newservants[var_49_2] = iter_49_3.new
				arg_48_0.newservantsArchives[var_49_2] = iter_49_3.newarchives
				arg_48_0.servantUsedskin[var_49_2] = iter_49_3.usedskin
				arg_48_0.addRollRarity[var_49_2] = iter_49_3.addrollrarity
			end
		end

		arg_48_0.servantLockData = {}

		if arg_49_0.lockData and next(arg_49_0.lockData) then
			for iter_49_7, iter_49_8 in pairs(arg_49_0.lockData) do
				arg_48_0.servantLockData[iter_49_8.id] = iter_49_8
			end
		end

		arg_48_0:initPlayerBond()
		require("controller.alert_manager"):check_servant_update()

		if arg_48_1 then
			arg_48_1()
		end
	end)
end

function var_0_0:getOwnedServantNum()
	local var_50_0 = 0

	for iter_50_0, iter_50_1 in pairs(self.haveServant) do
		if iter_50_1 and not servant_data[iter_50_0].linkage then
			var_50_0 = var_50_0 + 1
		end
	end

	return var_50_0
end

function var_0_0:getSpecifiedAttributeServantNum(arg_51_1)
	if arg_51_1 == "all" then
		return self:getOwnedServantNum()
	end

	local var_51_0 = 0

	for iter_51_0, iter_51_1 in pairs(var_0_0.haveServant) do
		if iter_51_1 and global_get_model_attr(servant_data[iter_51_0].modelid) == arg_51_1 then
			var_51_0 = var_51_0 + 1
		end
	end

	return var_51_0
end

function var_0_0:getOwnedServantByCondition(arg_52_1)
	local souls_manager = require("controller.souls_manager")

	arg_52_1 = arg_52_1 or {}

	local var_52_1 = {}

	if arg_52_1.rare then
		local var_52_3 = tonumber(arg_52_1.rare)

		if var_52_3 == nil then
			print("招募条件不正确，策划检查一下")
			print("招募条件不正确，策划检查一下")
			print("招募条件不正确，策划检查一下")
		end

		for iter_52_0, iter_52_1 in pairs(self.haveServant) do
			if var_52_3 == souls_manager:get_servant_cur_roll_rarity(iter_52_0) and iter_52_1 and not servant_data[iter_52_0].linkage then
				var_52_1[iter_52_0] = iter_52_1
			end
		end
	else
		var_52_1 = cloneconf(self.haveServant)
	end

	local var_52_4 = var_52_1

	if arg_52_1.career then
		var_52_4 = {}

		for iter_52_2, iter_52_3 in pairs(var_52_1) do
			if arg_52_1.career == model_data[servant_data[iter_52_2].modelid].career and iter_52_3 and not servant_data[iter_52_2].linkage then
				var_52_4[iter_52_2] = iter_52_3
			end
		end
	end

	return var_52_4
end

function var_0_0:initPlayerArrays(arg_53_1)
	self.curSoul = {}

	self:loadPlayerArraysFromServer(arg_53_1)
end

function var_0_0:reloadPlayerArrays(arg_54_1)
	self:loadPlayerArraysFromServer(arg_54_1)
end

function var_0_0.loadPlayerArraysFromServer(arg_55_0, arg_55_1)
	network:rpc("get_player_arrays", nil, function(arg_56_0)
		arg_55_0.arrays = arg_56_0.arrays
		require("controller.array_manager").curArray = arg_55_0.curArray or 1

		if arg_55_1 then
			arg_55_1()
		end
	end)
end

function var_0_0:isServantInFight(arg_57_1)
	if not arg_57_1 then
		return false
	end

	for iter_57_0, iter_57_1 in pairs(self.curSoul) do
		if iter_57_1.fight_girl == arg_57_1 and iter_57_1.classtype == 1 then
			return true
		end
	end

	return false
end

var_0_0.isSoulInFight = var_0_0.isServantInFight

function var_0_0:isMajorInFight(arg_58_1)
	if not arg_58_1 then
		return false
	end

	for iter_58_0, iter_58_1 in pairs(self.curSoul) do
		if iter_58_1.fight_girl and servant_data[iter_58_1.fight_girl].major == arg_58_1 and iter_58_1.classtype == 1 then
			return true
		end
	end

	return false
end

function var_0_0:initPlayerItems(arg_59_1)
	self.items = {}

	require("controller.component_manager"):init()

	local horcrux_manager = require("controller.horcrux_manager")
	local alert_manager = require("controller.alert_manager")

	self:loadPlayerItemsFromServer(function()
		if not RoleDefault:getInstance():getBoolForKey("TWIST_IS_TEN", false) then
			if require("controller.item_manager"):getItemNumber(6800101) >= 10 then
				alert_manager:register_alert(ALERT_TWIST_TEN)
			else
				RoleDefault:getInstance():setBoolForKey("TWIST_IS_TEN", false)
			end
		end

		if arg_59_1 then
			arg_59_1()
		end
	end)
end

function var_0_0:reloadPlayerItems(arg_61_1)
	self:loadPlayerItemsFromServer(arg_61_1)
end

function var_0_0.loadPlayerItemsFromServer(arg_62_0, arg_62_1)
	local var_62_0 = {}
	local horcrux_manager = require("controller.horcrux_manager")
	local alert_manager = require("controller.alert_manager")

	local function var_62_4(arg_63_0, arg_63_1)
		network:rpc("get_player_items", {
			start = arg_63_0,
			count = arg_63_1
		}, function(arg_64_0)
			if arg_64_0.items then
				for iter_64_0, iter_64_1 in pairs(arg_64_0.items) do
					var_62_0[iter_64_1.entityid] = {
						entityid = iter_64_1.entityid,
						itemid = iter_64_1.itemid,
						itemtype = item_data[iter_64_1.itemid].bag_item_type,
						number = iter_64_1.itemcount,
						component_attr = iter_64_1.component_attr,
						eatable_attr = iter_64_1.eatable_attr,
						weapon_attr = iter_64_1.weapon_attr,
						horcrux_attr = iter_64_1.horcrux_attr,
						used = iter_64_1.used,
						new = iter_64_1.new
					}
				end
			end

			if arg_64_0.continue then
				arg_63_0 = arg_63_0 + arg_63_1

				var_62_4(arg_63_0, arg_63_1)
			else
				arg_62_0.items = var_62_0

				alert_manager:check_weapon_update()
				alert_manager:check_component_update()
				alert_manager:check_new_horcrux()
				alert_manager:check_new_servant()
				alert_manager:check_horcrux_strenghth()
				alert_manager:check_servant_breakout()
				alert_manager:check_servant_strenghth()

				if arg_62_1 then
					arg_62_1()
				end
			end
		end)
	end

	;(nil)(1, 500)
end

function var_0_0:initPlayerDropCache(arg_65_1)
	self.dropcache = {}
	self.dropcacheweight = {
		weight = 0,
		limit = 0
	}

	require("controller.dropcache_manager"):init()
	self:loadPlayerDropCacheFromServer(arg_65_1)
end

function var_0_0:reloadPlayerDropCache(arg_66_1)
	self:loadPlayerDropCacheFromServer(arg_66_1)
end

function var_0_0.loadPlayerDropCacheFromServer(arg_67_0, arg_67_1)
	local dropcache_manager = require("controller.dropcache_manager")

	network:rpc("get_player_dropcache", nil, function(arg_68_0)
		arg_67_0.dropcache = arg_68_0.items or {}
		arg_67_0.dropcacheweight.weight = tonumber(arg_68_0.weight)
		arg_67_0.dropcacheweight.limit = arg_68_0.limit

		dropcache_manager:resetCacheTime(arg_68_0.time)

		if arg_67_1 then
			arg_67_1()
		end
	end)
end

function var_0_0:initPlayerLevelMode(arg_69_1)
	local level_manager = require("controller.level_manager")
	local levelmode_data = require("data.levelmode_data")

	self.levelmode = {}
	self.citystat = {}

	self:loadPlayerLevelModeFromServer(function()
		if arg_69_1 then
			arg_69_1()
		end

		level_manager:checkIsAlertNew()
	end)
	level_manager:getModesLockState()
end

function var_0_0:reloadPlayerLevelMode(arg_71_1)
	self:loadPlayerLevelModeFromServer(arg_71_1)
	levelManager:getModesLockState()
end

function var_0_0.loadPlayerLevelModeFromServer(arg_72_0, arg_72_1)
	network:rpc("get_player_levelmode", nil, function(arg_73_0)
		if arg_73_0.city then
			for iter_73_0, iter_73_1 in pairs(arg_73_0.city) do
				arg_72_0.citystat[iter_73_1.city] = iter_73_1.stat
			end
		end

		if arg_73_0.mode then
			for iter_73_2, iter_73_3 in pairs(arg_73_0.mode) do
				arg_72_0.levelmode[iter_73_3.mode] = iter_73_3
			end
		end

		require("controller.alert_manager"):update_level_alert(arg_73_0.mode)

		if arg_72_1 then
			arg_72_1()
		end
	end)
end

function var_0_0:initPlayerArenaData(arg_74_1)
	self:loadPlayerArenaDataFromServer(arg_74_1)
end

function var_0_0:reloadPlayerArenaData(arg_75_1)
	self:loadPlayerArenaDataFromServer(arg_75_1)
end

function var_0_0.loadPlayerArenaDataFromServer(arg_76_0, arg_76_1)
	network:rpc("get_arena_battle_array", nil, function(arg_77_0)
		arg_76_0.arenaArray = arg_77_0.battlearray or {}
		arg_76_0.arenaAttackArray = arg_77_0.attackarray or {}

		if arg_76_1 then
			arg_76_1(arg_77_0.arenastatuses)
		end
	end)
end

function var_0_0:initPlayerScoreArenaData(arg_78_1)
	self.scorearenaAttackArray = RoleDefault:getInstance():getIntegerForKey("scorearenaAttackArray", self.curArray or 1)

	if arg_78_1 then
		arg_78_1()
	end
end

function var_0_0:reloadPlayerScoreArenaData(arg_79_1)
	self.scorearenaAttackArray = RoleDefault:getInstance():getIntegerForKey("scorearenaAttackArray", self.curArray or 1)

	if arg_79_1 then
		arg_79_1()
	end
end

function var_0_0:initPlayerGuide(arg_80_1)
	self:loadPlayerGuideFromServer(arg_80_1)
end

function var_0_0:reloadPlayerGuide(arg_81_1)
	require("view.Layer.Guide.GuideListener"):reset()
	self:loadPlayerGuideFromServer(arg_81_1)
end

function var_0_0.loadPlayerGuideFromServer(arg_82_0, arg_82_1)
	network:rpc("get_guide_step", nil, function(arg_83_0)
		local bit = require("bit")

		arg_82_0.gameInitGuides = {
			bit.band(arg_83_0.gameinit, 1) > 0,
			bit.band(arg_83_0.gameinit, 2) > 0,
			bit.band(arg_83_0.gameinit, 4) > 0
		}

		require("view.Layer.Guide.GuideListener"):init(arg_83_0.guides)

		if arg_82_1 then
			arg_82_1()
		end
	end)
end

function var_0_0.setPlayerGuide(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	network:rpc("set_guide_step", {
		guide = arg_84_1,
		step = arg_84_3
	}, function(arg_85_0)
		if arg_85_0.result == 1 and arg_84_2 then
			arg_84_2()
		end
	end)
end

function var_0_0.getServerTime(arg_86_0, arg_86_1)
	local time_check_manager = require("controller.time_check_manager")

	network:rpc("get_server_time", nil, function(arg_87_0)
		arg_86_0.onlineTime = tonumber(arg_87_0.time)

		time_check_manager:init(arg_86_0.onlineTime, arg_87_0.timezone)

		if arg_86_1 then
			arg_86_1()
		end

		require("controller.alert_manager"):check_new_shop_from_twist()
	end)
end

function var_0_0.initExploreInfo(arg_88_0, arg_88_1)
	require("controller.explore_manager"):getCurExploreConfig(arg_88_1)
end

function var_0_0.initExploreLevelInfo(arg_89_0, arg_89_1)
	network:rpc("get_explore_level_info", nil, function(arg_90_0)
		if arg_90_0.explore_level_info then
			arg_89_0.exploreLevel = {}

			for iter_90_0, iter_90_1 in pairs(arg_90_0.explore_level_info) do
				arg_89_0.exploreLevel[iter_90_1.classid] = iter_90_1
			end

			print(dump(arg_89_0.exploreLevel))
		end
	end)
end

function var_0_0:initSystemAlert(arg_91_1)
	local community_system_manager = require("controller.community_system_manager")
	local task_manager = require("controller.task_manager")

	community_system_manager:get_family_wish_record1()
	community_system_manager:get_family_wish_record2()

	if require("controller.twist_manager"):checkIsAlertNew() then
		require("controller.alert_manager"):register_alert(ALERT_NEW_TWIST)
	end

	require("controller.role_false_level_manager"):checkAlert()
	self:loadSystemAlertFromServer(arg_91_1)
end

function var_0_0:reloadSystemAlert(arg_92_1)
	self:loadSystemAlertFromServer(arg_92_1)
end

function var_0_0.loadSystemAlertFromServer(arg_93_0, arg_93_1)
	local alert_manager = require("controller.alert_manager")

	network:rpc("check_system_alert", nil, function(arg_94_0)
		if arg_94_0.alert_system ~= nil then
			for iter_94_0, iter_94_1 in pairs(arg_94_0.alert_system) do
				alert_manager:register_alert(iter_94_1)
			end
		end

		if arg_94_0.alert_activity then
			local activity_manager = require("controller.activity_manager")

			activity_manager:cleanAllActivityAlert()

			for iter_94_2, iter_94_3 in ipairs(arg_94_0.alert_activity) do
				activity_manager:updateActivityAlert(iter_94_3.alerttype, iter_94_3.activities)
			end
		end

		if arg_93_1 then
			arg_93_1()
		end
	end)
end

function var_0_0.initCookData(arg_95_0, arg_95_1)
	if arg_95_1 then
		arg_95_1()
	end
end

function var_0_0.initDormRoom(arg_96_0)
	network:rpc("get_dorm_room_config", nil, function(arg_97_0)
		for iter_97_0, iter_97_1 in pairs(arg_97_0.dorm.rooms) do
			arg_96_0.dormRoomConfig[iter_97_0] = iter_97_1
		end
	end)
end

function var_0_0.initPlayerTask(arg_98_0, arg_98_1)
	local task_manager = require("controller.task_manager")

	task_manager:get_player_tasks(arg_98_1)
	task_manager:get_task_info(function()
		require("controller.community_system_manager"):get_family_task_info()
	end)
end

function var_0_0.initPlayerPlot(arg_100_0)
	local plot_class_data = require("data.plot_class_data")

	network:rpc("get_plot_infos", nil, function(arg_101_0)
		if arg_101_0.runningPlots then
			for iter_101_0, iter_101_1 in pairs(arg_101_0.runningPlots) do
				if plot_class_data[iter_101_1.plotClassId] then
					arg_100_0.runningPlots[iter_101_1.plotClassId] = {
						iter_101_1.plotClassId,
						iter_101_1.step
					}
				end
			end
		end

		if arg_101_0.readyPlots then
			for iter_101_2, iter_101_3 in pairs(arg_101_0.readyPlots) do
				if plot_class_data[iter_101_3] then
					arg_100_0.readyPlots[iter_101_3] = true
				end
			end
		end

		if arg_101_0.invalidPlots then
			arg_100_0.invalidPlots = arg_101_0.invalidPlots
		end

		require("controller.plot_manager"):update_plot_layer_config()
	end)
end

function var_0_0.initPatrolInfo(arg_102_0)
	arg_102_0.patrolInfo = {}

	require("controller.patrol_manager"):init()
end

function var_0_0.initEventInfo(arg_103_0)
	require("controller.event_manager"):init()
end

function var_0_0.initActivityShopList(arg_104_0)
	local shop_manager = require("controller.shop_manager")

	network:rpc("get_active_shoptype", nil, function(arg_105_0)
		shop_manager:set_active_shoptype(arg_105_0.shoplist)
		shop_manager:set_active_markettype(arg_105_0.marketlist)
	end)
end

function var_0_0.initCurActivities(arg_106_0)
	local activity_manager = require("controller.activity_manager")
	local var_106_1 = {
		[112] = function()
			activity_manager:getActivityObj(112):get_subsystem_time()
		end,
		[100] = function()
			require("controller.spring_manager"):get_subsystem_time()
		end
	}

	activity_manager:initCurrentActivities(function()
		for iter_109_0, iter_109_1 in pairs((activity_manager:getCurrentActivites())) do
			if var_106_1[iter_109_0] then
				var_106_1[iter_109_0]()
			end
		end
	end)
end

function var_0_0.initLevelmodeReward(arg_110_0)
	local bit = require("bit")
	local level_manager = require("controller.level_manager")

	network:rpc("get_stars_reward_state", nil, function(arg_111_0)
		if arg_111_0.result == 1 then
			for iter_111_0, iter_111_1 in pairs(arg_111_0.reward_state_list) do
				if iter_111_1.modetype then
					local var_111_0 = level_manager:getModeListByModeType(iter_111_1.modetype)
					local var_111_1 = iter_111_1.reward_class

					for iter_111_2 = 1, 30 do
						local var_111_2 = var_111_0[iter_111_2 + (iter_111_1.num_id - 1) * 30]

						if var_111_0[iter_111_2 + (iter_111_1.num_id - 1) * 30] then
							arg_110_0.levelmodeReward[var_111_2] = arg_110_0.levelmodeReward[var_111_2] or {}
							arg_110_0.levelmodeReward[var_111_2][var_111_1] = bit.band(iter_111_1.state_info, 2^((iter_111_2 + (iter_111_1.num_id - 1) * 30 - 1) % 30 + 1 - 1)) > 0
						end
					end
				else
					local var_111_3 = iter_111_1.num_id
					local var_111_4 = iter_111_1.reward_class

					for iter_111_3 = 1, 30 do
						local var_111_5 = iter_111_3 + (var_111_3 - 1) * 30

						if not arg_110_0.levelmodeReward[iter_111_3 + (var_111_3 - 1) * 30] then
							arg_110_0.levelmodeReward[var_111_5] = {}
						end

						arg_110_0.levelmodeReward[var_111_5][var_111_4] = bit.band(iter_111_1.state_info, 2^((iter_111_3 + (var_111_3 - 1) * 30 - 1) % 30 + 1 - 1)) > 0
					end
				end
			end

			if require("controller.level_manager"):checkStarRewardAlert() then
				require("controller.alert_manager"):register_alert(ALERT_STAR_REWARD)
			end
		end
	end)
end

function var_0_0.initGameBuffInfo(arg_112_0, arg_112_1)
	local activity_return_manager = require("controller.activity_return_manager")

	network:rpc("get_game_buffs", nil, function(arg_113_0)
		if arg_113_0.result == 1 then
			activity_return_manager:setGameBuff(arg_113_0.buffs)

			if arg_112_1 then
				arg_112_1(arg_113_0)
			end
		elseif arg_112_1 then
			arg_112_1(arg_113_0)
		end
	end)
end

function var_0_0.unlockSoulToServer(arg_114_0, arg_114_1, arg_114_2, arg_114_3)
	print("unlockSoulToServer is Deprecated!!!, You Should UnlockSoul From Server")
end

function var_0_0:unlockServant(arg_115_1, arg_115_2)
	if self.haveServant[arg_115_1] then
		self.servantNum[arg_115_1] = self.servantNum[arg_115_1] + arg_115_2
	else
		self.haveSuit[require("data.servant_data")[arg_115_1].major] = true
		self.haveServant[arg_115_1] = true
		self.soulContract[arg_115_1] = 0
		self.servantNum[arg_115_1] = arg_115_2 - 1
		self.weaponId[arg_115_1] = nil
		self.cores[arg_115_1] = {
			coreid = 1,
			extra = 0
		}
		self.component[arg_115_1] = nil
		self.quickfight[arg_115_1] = 0
		self.vote[arg_115_1] = 0
		self.newservants[arg_115_1] = true
		self.newservantsArchives[arg_115_1] = true
		self.servant_unlock_time[arg_115_1] = require("controller.time_check_manager"):getCurTime()

		require("controller.filedownloader.download_manager"):updateOnGetNewRole(arg_115_1)
		AnalyticManager.getNewServant({
			servant = arg_115_1
		})
	end

	self:updateBondInfo(arg_115_1)
	require("controller.alert_manager"):check_servant_update(true)
end

var_0_0.unlockSoul = var_0_0.unlockServant

function var_0_0:playerOpenNewServant(arg_116_1)
	if not self.haveServant[arg_116_1] then
		return
	end

	if not self.newservants[arg_116_1] then
		return
	end

	self.newservants[arg_116_1] = nil

	network:rpc("player_open_new_servant", {
		servantid = arg_116_1
	})
end

function var_0_0:playerOpenNewServantArchives()
	local var_117_0 = {}

	for iter_117_0, iter_117_1 in pairs(self.newservantsArchives) do
		if self.haveServant[iter_117_0] then
			self.newservantsArchives[iter_117_0] = nil

			table.insert(var_117_0, iter_117_0)
		end
	end

	if next(var_117_0) == nil then
		return
	end

	network:rpc("player_open_new_servant_archives", {
		servantids = var_117_0
	})
end

function var_0_0:servantBreakOut(arg_118_1, arg_118_2, arg_118_3)
	local item_manager = require("controller.item_manager")

	if not self.haveServant[arg_118_1] then
		if arg_118_3 then
			arg_118_3(2)
		end

		return
	end

	if not require("controller.core_manager"):getUpgradeCostRoleCardNum(arg_118_1, self.soulContract[arg_118_1] + 1) then
		if arg_118_3 then
			arg_118_3(3)
		end

		return
	end

	if arg_118_1 == 215020 or arg_118_1 == 25920 then
		for iter_118_0, iter_118_1 in pairs(arg_118_2) do
			if iter_118_1.itemid == 1502104 then
				if arg_118_3 then
					arg_118_3(4)
				end

				global_ShowBlockWords("禄存,辛西娅只能使用学员卡哦~")

				return
			end
		end
	end

	network:rpc("servant_breakout", {
		servantid = arg_118_1,
		itemList = arg_118_2
	}, function(arg_119_0)
		if arg_119_0.result == 1 then
			print("servant_breakout ======== ", arg_119_0.consume_servant_cardNum, dump(arg_119_0.consumes))

			self.soulContract[arg_118_1] = self.soulContract[arg_118_1] + 1
			self.servantNum[arg_118_1] = self.servantNum[arg_118_1] - arg_119_0.consume_servant_cardNum

			require("controller.alert_manager"):check_servant_update(false)

			if arg_119_0.consumes then
				for iter_119_0, iter_119_1 in pairs(arg_119_0.consumes) do
					item_manager:deleteItem(iter_119_1.entityid, iter_119_1.num)
				end
			end

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			self:updateBondInfo(arg_118_1)

			if arg_118_3 then
				arg_118_3(1)
			end
		elseif arg_118_3 then
			arg_118_3(arg_119_0.result)
		end
	end)
end

function var_0_0:servantOverclock(arg_120_1, arg_120_2, arg_120_3)
	local item_manager = require("controller.item_manager")
	local core_manager = require("controller.core_manager")

	if not self.haveServant[arg_120_1] then
		if arg_120_3 then
			arg_120_3(2)
		end

		return
	end

	local var_120_2 = self.soulOverClock[arg_120_1] or 0
	local var_120_3 = self.servantNum[arg_120_1]
	local var_120_4 = core_manager:getOcCostCardNum(arg_120_1, var_120_2 + 1)
	local var_120_5 = core_manager:getOcCpuId(arg_120_1, var_120_2 + 1)

	if not core_manager:getOcCostCpuNum(arg_120_1, var_120_2 + 1) then
		-- block empty
	end

	if not servant_data[arg_120_1]["oc_isopen" .. var_120_2 + 1] then
		if arg_120_3 then
			arg_120_3(3)
		end

		return
	end

	if self:isServantOverclockLockByTime(arg_120_1) then
		if arg_120_3 then
			arg_120_3(3)
		end

		return
	end

	if arg_120_1 == 215020 then
		for iter_120_0, iter_120_1 in pairs(arg_120_2) do
			if iter_120_1.itemid == 1502104 then
				if arg_120_3 then
					arg_120_3(4)
				end

				global_ShowBlockWords("禄存只能使用学员卡哦~")

				return
			end
		end
	end

	network:rpc("servant_overclock", {
		servantid = arg_120_1,
		itemList = arg_120_2
	}, function(arg_121_0)
		if arg_121_0.result == 1 then
			print("servant_overclock ======== ", arg_121_0.consume_servant_cardNum, dump(arg_121_0.consumes), var_120_3)

			self.soulOverClock[arg_120_1] = self.soulOverClock[arg_120_1] + 1
			self.servantNum[arg_120_1] = self.servantNum[arg_120_1] - arg_121_0.consume_servant_cardNum

			require("controller.alert_manager"):check_servant_update(false)

			if arg_121_0.consumes then
				for iter_121_0, iter_121_1 in pairs(arg_121_0.consumes) do
					item_manager:deleteItem(iter_121_1.entityid, iter_121_1.num)
				end
			end

			if self:isServantInFight(arg_120_1) then
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			else
				GlobalUpdateContractAttr()
			end

			if arg_121_0.changeSkinResult == 1 then
				local var_121_0 = arg_121_0.item[1] and arg_121_0.item[1].itemid

				self.servantUsedskin[arg_120_1] = var_121_0

				local array_manager = require("controller.array_manager")
				local var_121_2 = array_manager:getArrayByServantID(arg_120_1)

				if var_121_2 and array_manager:isArrayCurHangup(var_121_2) then
					array_manager:registerHangupArrayChange()
					array_manager:executeHangupArrayChange()
				end

				AnalyticManager.servant_set_skin({
					servantid = arg_120_1,
					skin_itemid = var_121_0
				})
			end

			if arg_120_3 then
				arg_120_3(1, arg_121_0.item)
			end
		elseif arg_120_3 then
			arg_120_3(arg_121_0.result)
		end
	end)
end

function var_0_0.fastServantBreakOut(arg_122_0, arg_122_1)
	local item_manager = require("controller.item_manager")
	local var_122_1 = require("controller.core_manager"):getFastUpgradeData()

	print_lua_table(var_122_1)

	if #var_122_1 == 0 then
		arg_122_1({
			result = 2
		})

		return
	end

	network:rpc("one_key_servant_breakout", {
		servants = var_122_1
	}, function(arg_123_0)
		print("one_key_servant_breakout ======== ", dump(arg_123_0))

		if arg_123_0.result == 1 then
			arg_123_0.old_infos = arg_122_0:getServantOldInfos(arg_123_0.servantsInfos)

			for iter_123_0, iter_123_1 in ipairs(arg_123_0.servantsInfos) do
				arg_122_0.soulContract[iter_123_1.servantid] = arg_122_0.soulContract[iter_123_1.servantid] + iter_123_1.contract_count
				arg_122_0.servantNum[iter_123_1.servantid] = arg_122_0.servantNum[iter_123_1.servantid] - iter_123_1.consume_servant_cardNum

				arg_122_0:updateBondInfo(iter_123_1.servantid)

				if iter_123_1.consumes then
					for iter_123_2, iter_123_3 in pairs(iter_123_1.consumes) do
						item_manager:deleteItem(iter_123_3.entityid, iter_123_3.num)
					end
				end

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			require("controller.alert_manager"):check_servant_update(false)

			if arg_122_1 then
				arg_122_1(arg_123_0)
			end
		elseif arg_122_1 then
			arg_122_1(arg_123_0)
		end
	end)
end

function var_0_0:getServantOldInfos(arg_124_1)
	local model_data = require("data.model_data")
	local souls_manager = require("controller.souls_manager")
	local var_124_2 = {}

	for iter_124_0, iter_124_1 in ipairs(arg_124_1) do
		local var_124_3, var_124_4, var_124_5 = self:getServantInfo(iter_124_1.servantid)

		var_124_2[iter_124_1.servantid] = {
			old_contract = var_124_3,
			Hp = var_124_4,
			Damage = var_124_5
		}
	end

	return var_124_2
end

function var_0_0.getServantInfo(arg_125_0, arg_125_1)
	local model_data = require("data.model_data")
	local souls_manager = require("controller.souls_manager")
	local var_125_2 = arg_125_1
	local var_125_4 = var_0_0.soulOverClock[arg_125_1] or 0
	local var_125_6 = model_data[servant_data[arg_125_1].modelid].hpFactor + (servant_data[arg_125_1]["hpOverPlus" .. var_125_4] or 0)
	local var_125_7 = model_data[servant_data[arg_125_1].modelid].damageFactor + (servant_data[arg_125_1]["damageOverPlus" .. var_125_4] or 0)
	local var_125_9 = souls_manager:get_roll_rarity_str(var_125_2)

	return var_0_0.soulContract[arg_125_1], var_125_6 + souls_manager:get_add_hp_factor(var_125_2), var_125_7 + souls_manager:get_add_damage_factor(var_125_2)
end

function var_0_0:canServantOverClockNow(arg_126_1)
	if not self.haveServant[arg_126_1] then
		return false
	end

	if require("controller.core_manager"):getUpgradeCostRoleCardNum(arg_126_1, self.soulContract[arg_126_1] + 1) then
		return false
	end

	return true
end

function var_0_0:changeSoulDress(arg_127_1, arg_127_2, arg_127_3)
	if not self.haveSuit[arg_127_1] then
		if arg_127_3 then
			arg_127_3(2)
		end

		return
	end

	network:rpc("change_soul_dress", {
		soulid = arg_127_1,
		dress = arg_127_2
	}, function(arg_128_0)
		if arg_128_0.result == 1 then
			self.soulDress[arg_127_1] = arg_127_2

			if arg_128_0.favor and arg_128_0.favor > 0 then
				self.favor[arg_127_1].favorlevel = arg_128_0.favorlevel
				self.favor[arg_127_1].favordegree = arg_128_0.favordegree
			end

			for iter_128_0, iter_128_1 in pairs(self.curSoul) do
				if iter_128_1.fight_girl == arg_127_1 then
					FightManager.registerPlayerReplace()

					break
				end
			end

			if arg_127_3 then
				arg_127_3(1, arg_128_0.favor)
			end
		elseif arg_127_3 then
			arg_127_3(arg_128_0.result)
		end
	end)
end

var_0_0.changeSoulConfig = var_0_0.changeSoulDress

function var_0_0.setHeadSoul(arg_129_0, arg_129_1, arg_129_2)
	network:rpc("set_sculpture", {
		sculpture = arg_129_1
	}, function(arg_130_0)
		if arg_130_0.result == 1 then
			arg_129_0.head_sculpture = arg_129_1

			if arg_129_2 then
				arg_129_2(1)
			end
		elseif arg_130_0.result == 2 then
			if arg_129_2 then
				arg_129_2(2)
			end
		elseif arg_130_0.result == 3 then
			if arg_129_2 then
				arg_129_2(3)
			end
		elseif arg_129_2 then
			arg_129_2(0)
		end
	end)
end

function var_0_0.setInitHeadSoul(arg_131_0, arg_131_1)
	network:rpc("set_sculpture", {
		sculpture = arg_131_1
	}, function(arg_132_0)
		if arg_132_0.result == 1 then
			arg_131_0.head_sculpture = arg_131_1
		end
	end)
end

function var_0_0.setShowGirl(arg_133_0, arg_133_1, arg_133_2)
	local model_data = require("data.model_data")
	local background_data = require("data.background_data")

	network:rpc("set_showgirl", {
		modelid = arg_133_1
	}, function(arg_134_0)
		if arg_134_0.result == 1 then
			arg_133_0:updateShowGirl(arg_133_1)
			AnalyticManager.change_showgirl({
				modelid = arg_133_1
			})

			if arg_133_2 then
				arg_133_2(1)
			end
		elseif arg_134_0.result == 2 then
			if arg_133_2 then
				arg_133_2(2)
			end
		elseif arg_134_0.result == 3 then
			if arg_133_2 then
				arg_133_2(3)
			end
		elseif arg_133_2 then
			arg_133_2(0)
		end
	end)
end

function var_0_0.setInitShowGirl(arg_135_0, arg_135_1)
	network:rpc("set_showgirl", {
		modelid = arg_135_1
	}, function(arg_136_0)
		if arg_136_0.result == 1 then
			arg_135_0.showgirl = tostring(arg_135_1)

			require("controller.main_city_bg_select_manager"):getInstance():updateShowGirl(arg_135_0.showgirl)
		end
	end)
end

function var_0_0:updateShowGirl(arg_137_1, arg_137_2)
	if not arg_137_1 then
		return
	end

	local model_data = require("data.model_data")
	local background_data = require("data.background_data")

	if arg_137_1 == 0 then
		self.showgirl = NPC_ID_CATGIRL or arg_137_1
	end

	self.showgirl = tostring(self.showgirl)

	if arg_137_2 then
		self.background = arg_137_2

		local l2d_manager = require("controller.l2d_manager")

		l2d_manager:setNotRemoveModel(model_data[self.showgirl].live2d)
		l2d_manager:setNotRemoveBGModel(background_data[self.background].background_live2d)
		l2d_manager:setNotRemoveFrontModel(background_data[self.background].front_live2d)
		require("controller.main_city_bg_select_manager"):getInstance():updateShowGirl(self.showgirl, arg_137_2)
	end

	if model_data[self.showgirl].rolespine then
		SpineCacheManager:setNotRemoveShowGirlSpine(ROLE_SPINE_PATH .. model_data[self.showgirl].rolespine .. ".json")
	else
		SpineCacheManager:setNotRemoveShowGirlSpine()
	end

	if background_data[self.background].background_spine then
		SpineCacheManager:setNotRemoveBGSpine(BACKGROUND_SPINE_PATH .. background_data[self.background].background_spine .. ".json")
	else
		SpineCacheManager:setNotRemoveBGSpine()
	end
end

function var_0_0.setBackGround(arg_138_0, arg_138_1, arg_138_2)
	network:rpc("set_background", {
		itemid = arg_138_1
	}, function(arg_139_0)
		if arg_139_0.result == 1 then
			arg_138_0.background = arg_138_1

			if arg_138_2 then
				arg_138_2(1)
			end
		elseif arg_139_0.result == 2 then
			global_ShowBlockWords("未拥有该背景")
		elseif arg_138_2 then
			arg_138_2(0)
		end
	end)
end

function var_0_0.getTotalServantNum(arg_140_0)
	local var_140_0 = 0

	for iter_140_0, iter_140_1 in pairs(servant_data) do
		if iter_140_1.classtype == 1 and not servant_data[iter_140_0].linkage then
			var_140_0 = var_140_0 + 1
		end
	end

	return var_140_0
end

function var_0_0:getHavedServantNum()
	local var_141_0 = 0

	for iter_141_0, iter_141_1 in pairs(self.haveServant) do
		if iter_141_1 and not servant_data[iter_141_0].linkage then
			var_141_0 = var_141_0 + 1
		end
	end

	return var_141_0
end

function var_0_0:getHavedSoulNum()
	local var_142_0 = 0

	for iter_142_0, iter_142_1 in pairs(self.haveSuit) do
		var_142_0 = var_142_0 + 1
	end

	return var_142_0
end

function var_0_0.purchase_speed_up_ticket(arg_143_0, arg_143_1, arg_143_2)
	network:rpc("purchase_speed_up_ticket", {
		num = arg_143_1
	}, function(arg_144_0)
		if arg_144_0.result == 1 then
			arg_143_0.diamond = arg_143_0.diamond - item_data[16100501].price_diamond * arg_143_1

			global_update_gold_stone_diamond(nil, nil, item_data[16100501].price_diamond * arg_143_1)

			if arg_144_0.items and next(arg_144_0.items) then
				global_get({
					items = arg_144_0.items
				})
			end

			if arg_143_2 then
				arg_143_2(arg_144_0)
			end
		elseif arg_144_0.result == 0 then
			global_ShowBlockWords("物品不存在")
		elseif arg_144_0.result == 2 then
			global_ShowBlockWords("货币不足")
		end
	end)
end

function var_0_0.setServantUsedmodel(arg_145_0, arg_145_1, arg_145_2, arg_145_3)
	network:rpc("set_servant_usedskin", {
		servantid = arg_145_1,
		itemid = arg_145_2
	}, function(arg_146_0)
		if arg_146_0.result == 1 then
			arg_145_0.servantUsedskin[arg_145_1] = arg_145_2

			local array_manager = require("controller.array_manager")
			local var_146_1 = array_manager:getArrayByServantID(arg_145_1)

			if var_146_1 and array_manager:isArrayCurHangup(var_146_1) then
				array_manager:registerHangupArrayChange()
				array_manager:executeHangupArrayChange()
			end

			if arg_145_3 then
				arg_145_3(1)
			end

			AnalyticManager.servant_set_skin({
				servantid = arg_145_1,
				skin_itemid = arg_145_2
			})
		end
	end)
end

function var_0_0.getGainGoldDiamond(arg_147_0, arg_147_1)
	network:rpc("get_gain_gold_diamond", nil, function(arg_148_0)
		if arg_147_1 then
			arg_147_1(arg_148_0)
		end
	end)
end

function var_0_0.getCustomerServiceInfo(arg_149_0, arg_149_1)
	network:rpc("get_customer_service_info", {
		channelid = require("controller.account_manager"):getChannel()
	}, function(arg_150_0)
		if arg_149_1 then
			arg_149_1(arg_150_0)
		end
	end)
end

function var_0_0.initHideSkinItem(arg_151_0)
	network:rpc("get_hide_skin_itemid", {
		channelid = require("controller.account_manager"):getChannel()
	}, function(arg_152_0)
		if callback then
			callback(arg_152_0)
		end

		for iter_152_0, iter_152_1 in pairs(arg_152_0.skinitem) do
			arg_151_0.hideSkinItemTbl[iter_152_1] = iter_152_1
		end
	end)
end

function var_0_0:remain_servant_count(arg_153_1)
	local servant_data = require("data.servant_data")
	local core_manager = require("controller.core_manager")

	if self.soulContract[arg_153_1] < 0 then
		return 9
	end

	if not core_manager:getUpgradeCostRoleCardNum(arg_153_1, self.soulContract[arg_153_1] + 1) and not servant_data[arg_153_1]["oc_isopen" .. self.soulOverClock[arg_153_1] + 1] == 1 then
		return 0
	end

	local var_153_2 = 1
	local var_153_3 = 1

	while core_manager:getUpgradeCostRoleCardNum(arg_153_1, var_153_3) do
		var_153_2 = var_153_2 + core_manager:getUpgradeCostRoleCardNum(arg_153_1, var_153_3)
		var_153_3 = var_153_3 + 1
	end

	local var_153_4 = 1

	while servant_data[arg_153_1]["oc_isopen" .. var_153_4] == 1 and core_manager:getOcCostCardNum(arg_153_1, var_153_4) do
		var_153_2 = var_153_2 + core_manager:getOcCostCardNum(arg_153_1, var_153_4)
		var_153_4 = var_153_4 + 1
	end

	return var_153_2 - require("controller.item_manager"):getItemNumber(servant_data[arg_153_1].itemid)
end

function var_0_0.get_novice_pass_level_award(arg_154_0, arg_154_1, arg_154_2)
	network:rpc("get_novice_pass_level_award", {
		id = arg_154_1
	}, function(arg_155_0)
		if arg_155_0.result == 1 then
			global_gain(arg_155_0)
			global_update_gold_stone_diamond(nil, nil, arg_154_0.diamond)

			arg_154_0.novice_pass_level_award = arg_155_0.novice_pass_level_award

			AnalyticManager["novice_pass_level_award_" .. arg_154_1]({
				level = arg_154_0.grade,
				purchase = arg_154_0.rechargeamount
			})
		end

		if arg_154_2 then
			arg_154_2(arg_155_0)
		end
	end)
end

function var_0_0.get_novice_award(arg_156_0, arg_156_1, arg_156_2)
	network:rpc("get_novice_award", {
		selectType = arg_156_1
	}, function(arg_157_0)
		if arg_157_0.result == 1 then
			arg_156_0.gold = arg_156_0.gold + arg_157_0.gold

			global_update_gold_stone_diamond(nil, nil, arg_156_0.diamond)

			if arg_157_0.items and next(arg_157_0.items) then
				global_gain({
					items = arg_157_0.items,
					diamond = arg_157_0.diamond
				})
			end

			if arg_156_1 == 1 then
				arg_156_0.novice_award_process_xinxiya = arg_156_0.novice_award_process_xinxiya + 1

				AnalyticManager["ana_award_" .. arg_156_0.novice_award_process_xinxiya]({
					level = arg_156_0.grade,
					purchase = arg_156_0.rechargeamount
				})
			elseif arg_156_1 == 2 then
				arg_156_0.novice_award_process_lucun = arg_156_0.novice_award_process_lucun + 1

				AnalyticManager["ana_award_" .. arg_156_0.novice_award_process_lucun]({
					level = arg_156_0.grade,
					purchase = arg_156_0.rechargeamount
				})
			end
		end

		if arg_156_2 then
			arg_156_2(arg_157_0)
		end
	end)
end

function var_0_0:isServantLockByTime(arg_158_1)
	if not self.servantLockData or not next(self.servantLockData) then
		return false
	end

	if not self.servantLockData[arg_158_1] then
		return false
	end

	if self.haveServant[arg_158_1] then
		return false
	end

	if self.servantLockData[arg_158_1].starttime then
		if require("controller.time_check_manager"):getCurTime() < os.time(parse_time(self.servantLockData[arg_158_1].starttime)) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function var_0_0:isServantOverclockLockByTime(arg_159_1)
	if not self.servantLockData or not next(self.servantLockData) then
		return false
	end

	if not self.servantLockData[arg_159_1] then
		return false
	end

	if self.servantLockData[arg_159_1].overclock_starttime then
		if require("controller.time_check_manager"):getCurTime() < os.time(parse_time(self.servantLockData[arg_159_1].overclock_starttime)) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function var_0_0:initExploreArraysHpInherit()
	self.exploreArrays = cloneconf(self.arrays)
	self.isInitExploreArrays = true
end

function var_0_0.resetExploreArraysHpInherit(arg_161_0)
	arg_161_0.exploreArrays = {}
	arg_161_0.isInitExploreArrays = false
end

function var_0_0:updateExploreArrays(arg_162_1, arg_162_2)
	self.exploreArrays[arg_162_1] = {}

	for iter_162_0 = 1, FORMATION_SHOW_GIRL_NUM do
		self.exploreArrays[arg_162_1]["pos_" .. iter_162_0] = arg_162_2[iter_162_0] and {
			fight_girl = arg_162_2[iter_162_0].fight_girl,
			assist_girl = arg_162_2[iter_162_0].assist_girl
		} or {}
		self.exploreArrays[arg_162_1].id = arg_162_1
	end
end

function var_0_0.costDiamond(arg_163_0, arg_163_1)
	var_0_0.diamond = var_0_0.diamond - arg_163_1

	global_update_gold_stone_diamond(nil, nil, arg_163_1)
end

function var_0_0:getOfflineBuff()
	if not self.lastOnlineTime or self.lastOnlineTime <= 0 then
		return 1
	end

	local var_164_0 = require("controller.time_check_manager"):getCurTime() - self.lastOnlineTime

	if var_164_0 > 21600 and var_164_0 < 43200 then
		return 0.9
	elseif var_164_0 > 43200 and var_164_0 < 86400 then
		return 0.8
	elseif var_164_0 > 86400 and var_164_0 < 172800 then
		return 0.7
	elseif var_164_0 > 172800 and var_164_0 < 345600 then
		return 0.6
	elseif var_164_0 > 345600 and var_164_0 < 604800 then
		return 0.5
	elseif var_164_0 > 604800 then
		return 0.4
	else
		return 1
	end
end

function var_0_0.resetOfflineBuff(arg_165_0)
	arg_165_0.lastOnlineTime = 0
end

function var_0_0:updateLevelMode(arg_166_1)
	for iter_166_0, iter_166_1 in pairs(arg_166_1) do
		self.levelmode[iter_166_1.mode] = iter_166_1
	end
end

return var_0_0
