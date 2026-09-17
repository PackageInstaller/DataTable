local MonopolyManager = class("MonopolyManager", (require("controller.base_manager")))

MonopolyManager.MULTITON_MSG = "MonopolyManager instancealready constructed!"
MonopolyManager.LEVEL_TALK_HISTORY = "monopoly_level_talk_history_%s"

require("controller.global_func")

MonopolyManager.DICE_TYPE = {
	ONE_TO_THREE = 1,
	ANY = 2
}
MonopolyManager.PLAYER_STATE = {
	DICE = 1,
	EVENT = 2
}
MonopolyManager.STATE = {
	CHALLENGE_SUCCESS = 2,
	CHALLENGE = 1,
	REWARD_GET = 3
}
MonopolyManager.EVENTS_TYPE = {
	PLAYER_SKIP = "player_skip",
	ADD_MONEY = "add_money",
	GET_BUFF = "get_buff",
	BUFF_MOVE = "buff_move",
	PLAYER_WIN = "player_win",
	BUFF_REMAIN = "buff_remain",
	REMOVE_BUFFS = "remove_buffs",
	TRANSFER_MONEY = "transfer_money",
	AWARD = "award",
	FIGHT = "fight",
	LOSE_MONEY = "lose_money",
	LEVEL_UP_TILE = "levelup_tile",
	TALK = "talk",
	WAIT_PLAYER = "wait_player",
	BUILDING_DOWN = "building_down",
	BUILDING_INCOME = "building_income",
	BUILDING_UP = "building_up",
	MOVE = "throw"
}
MonopolyManager.EVENTS_TARGET_TYPE = {
	AI = "ai",
	PLAYER = "player"
}
MonopolyManager.GRID_ACTION_TYPE = {
	LEVEL_UP = 1,
	FIGHT = 3,
	PASS = 2
}
MonopolyManager.GRID_ACTION_RESULT_TYPE = {
	SUCCESS = 1,
	FAIL = 2
}
MonopolyManager.TILE_BELOBG = {
	AI = 2,
	PLAYER = 1
}
MonopolyManager.FIGHT_STATE = {
	READY = 1,
	FINISH = 3,
	FIGHTING = 2,
	NONE = 0
}
MonopolyManager.FIGHT_RESULT = {
	SUCCESS = 1,
	FAIL = 2
}
MonopolyManager.NOTES_TYPE = {
	WIN = 1
}

function MonopolyManager:ctor()
	MonopolyManager.super.ctor(self)

	self._data = {
		diceType = MonopolyManager.DICE_TYPE.ONE_TO_THREE
	}
	self._info = {}
	self._activityId = nil
	self._events = {}
	self._levelConfig = require("data.monopoly_level_conf_data")
	self._pffsetPosConfig = require("data.monopoly_ui_conf_data")
	self._isAnyDiceThrow = false
	self._fightinfo = {
		state = MonopolyManager.FIGHT_STATE.NONE
	}
	self._notes = nil
	self._auto = false
	self._autoUpgradeBuilding = true
	self._autoUpgradeHignBuilding = true
end

function MonopolyManager:getAttrValue(arg_2_1)
	local var_2_0 = self._pffsetPosConfig[self:getActivityId()] or {}
	local var_2_1 = {
		money_color = 1,
		enemy_money_color = 1,
		talk_color = 1,
		build_color = 1,
		time_color = 1,
		result_color = 1
	}

	if arg_2_1 == "reward_listview" then
		local var_2_3 = string.split(var_2_0[arg_2_1] or "0,0", ",")

		return (cc.p(tonumber(var_2_3[1]), tonumber(var_2_3[2])))
	elseif var_2_1[arg_2_1] then
		return var_2_0[arg_2_1] or "000000"
	end

	return nil
end

function MonopolyManager:setAuto(arg_3_1)
	if arg_3_1 then
		if self:canAuto() then
			self._auto = arg_3_1

			self:setDiceType(MonopolyManager.DICE_TYPE.ONE_TO_THREE)
			self:requestThrow()
		end
	else
		self._auto = arg_3_1
	end

	if self.layer then
		self.layer:updateAutoDiceBtn()
	end
end

function MonopolyManager:isAuto()
	return self._auto
end

function MonopolyManager:setAutoUpgradeBuilding(arg_5_1)
	self._autoUpgradeBuilding = arg_5_1
end

function MonopolyManager:isAutoUpgradeBuilding()
	return self._autoUpgradeBuilding
end

function MonopolyManager:setAutoUpgradeHignBuilding(arg_7_1)
	self._autoUpgradeHignBuilding = arg_7_1
end

function MonopolyManager:isAutoUpgradeHignBuilding()
	return self._autoUpgradeHignBuilding
end

function MonopolyManager:setActivityId(arg_9_1)
	self._activityId = arg_9_1
end

function MonopolyManager:getActivityId()
	return self._activityId
end

function MonopolyManager:setNotes(arg_11_1)
	self._notes = arg_11_1
end

function MonopolyManager:resetNotes()
	self._notes = nil
end

function MonopolyManager:requestInfo(arg_13_1)
	local network = require("network.network")

	network:rpc("activity_monopoly_get_data", {
		activityid = self._activityId
	}, function(arg_14_0)
		if arg_14_0.result == 1 then
			if arg_14_0.data and arg_14_0.data.level then
				self:handlerInfo(arg_14_0)

				if arg_13_1 then
					arg_13_1(arg_14_0)
				end
			else
				network:rpc("activity_monopoly_start", {
					activityid = self._activityId
				}, function(arg_15_0)
					if arg_15_0.result == 1 then
						self:handlerInfo(arg_15_0)

						if arg_13_1 then
							arg_13_1(arg_15_0)
						end
					end
				end)
			end
		end
	end)
end

function MonopolyManager:requestThrow(arg_16_1)
	if self._notes and self._notes.type == MonopolyManager.NOTES_TYPE.WIN then
		LayerManager:pushInLayer("MonopolyPlayerWinLayer")

		return
	end

	if not self:canThrow() then
		print(L_MONOPOLY[21])
		dumpEx_3_10(self._events, L_MONOPOLY[21])

		return
	end

	if not self:isLevelStart() then
		self:setAuto(false)
		global_ShowBlockWords(L_MONOPOLY[22] .. self:getLevelStartTimeString() .. L_MONOPOLY[23])

		return
	end

	if arg_16_1 and self:getAnyDiceItemNum() <= 0 then
		LayerManager:pushInLayer("PopGoGainLayer", {
			item = self:getAnyDiceItemId(),
			cancelcallback = function()
				require("controller.monopoly.monopoly_manager"):getInstance():updateDiceNumText()
			end
		})

		return
	end

	require("network.network"):rpc("activity_monopoly_throw", {
		activityid = self._activityId,
		num = arg_16_1
	}, function(arg_18_0)
		if arg_18_0.result == 1 then
			if arg_16_1 then
				self._isAnyDiceThrow = true
			end

			if next(arg_18_0.events) then
				self._events = arg_18_0.events

				dumpEx_3_10(self._events, L_MONOPOLY[24])
			end

			self:handleEvents()
		elseif arg_18_0.result == 6 then
			global_ShowBlockWords(L_MONOPOLY[25])
			self:setAuto(false)
		end
	end)
end

function MonopolyManager:canAuto()
	if self._notes then
		return false
	end

	return true
end

function MonopolyManager:requestHandleTile(arg_20_1, arg_20_2)
	require("network.network"):rpc("activity_monopoly_handle_tile", {
		activityid = self._activityId,
		action = arg_20_1,
		result = arg_20_2
	}, function(arg_21_0)
		if arg_21_0.result == 1 then
			if next(arg_21_0.events) then
				self._events = arg_21_0.events

				dumpEx_3_10(self._events, L_MONOPOLY[24])
			end

			self:handleEvents()
		end
	end)
end

function MonopolyManager:canThrow()
	return self:getState() == MonopolyManager.PLAYER_STATE.DICE
end

function MonopolyManager:requestNextLevel()
	require("network.network"):rpc("activity_monopoly_start", {
		activityid = self._activityId,
		level = self:getNextLevel()
	}, function(arg_24_0)
		if arg_24_0.result == 1 then
			self:setAuto(false)
			self:resetNotes()
			UpdataTableData(self._info, arg_24_0.data)

			self._info.player.money = require("model.playermodel").gold
			self._info.tiles = {}

			require("controller/monopoly/monopoly_map_manager"):getInstance():intoNextLevel()
			self:intoNextLevel()
			self:checkLevelTalk()
		end
	end)
end

function MonopolyManager:reEnterGame()
	local var_25_0 = require("controller/monopoly/monopoly_map_manager"):getInstance()

	var_25_0:resetMapData()
	var_25_0:initMapData()
	require("controller/monopoly/monopoly_event_history_manager"):getInstance():cleanData()
end

function MonopolyManager:handlerInfo(arg_26_1)
	self._info = arg_26_1.data
	self._info.player.money = require("model.playermodel").gold

	self:initEvents()
	require("controller.monopoly.monopoly_map_manager"):getInstance():initMapData()
	self:updateLayer()

	if next(self._events) then
		self:handleEvents()
	end

	self:checkLevelTalk()
end

function MonopolyManager:checkLevelTalk()
	if not self:getLevelTalkHistory() then
		require("view.Layer.TalkLayer")

		local var_27_0 = self:getLevelTalkId()

		if var_27_0 then
			global_basic_scene:addChild(TalkLayer:create(var_27_0, nil, TALK_TYPE_NORMAL, nil, function(arg_28_0)
				self:setLevelTalkHistory()
			end), ZORDER_TALKLAYER)
		end
	end
end

function MonopolyManager:getLevelTalkId()
	return self:getLevelConfigByLevel((self:getLevel())).enter_talk
end

function MonopolyManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function MonopolyManager:setAIMoney(arg_32_1)
	self._info.ai.money = arg_32_1
end

function MonopolyManager:getLevelTalkHistory()
	return (require("controller.RoleDefault"):getInstance():getBoolForKey(string.format(MonopolyManager.LEVEL_TALK_HISTORY, self:getLevel()), false))
end

function MonopolyManager:setLevelTalkHistory()
	local var_34_0 = require("controller.RoleDefault"):getInstance():setBoolForKey(string.format(MonopolyManager.LEVEL_TALK_HISTORY, self:getLevel()), true)
end

function MonopolyManager:getAnyDiceItemId()
	return self:getLevelConfigByLevel((self:getLevel())).dice_id
end

function MonopolyManager:getAnyDiceItemNum()
	return (require("controller/item_manager"):getItemNumber((self:getAnyDiceItemId())))
end

function MonopolyManager:initEvents()
	self._events = {}

	if self._fightinfo.state == MonopolyManager.FIGHT_STATE.FINISH then
		self._fightinfo.state = MonopolyManager.FIGHT_STATE.NONE

		self:requestHandleTile(MonopolyManager.GRID_ACTION_TYPE.FIGHT, self._fightinfo.result)

		return
	end

	if self._info.player.st == MonopolyManager.PLAYER_STATE.EVENT then
		self._events[#self._events + 1] = not self._info.player.battleid and {
			type = MonopolyManager.EVENTS_TYPE.WAIT_PLAYER,
			data = {
				trigger = MonopolyManager.EVENTS_TARGET_TYPE.PLAYER
			}
		} or {
			type = MonopolyManager.EVENTS_TYPE.WAIT_PLAYER,
			data = {
				trigger = MonopolyManager.EVENTS_TARGET_TYPE.PLAYER,
				battleid = self._info.player.battleid,
				pos = self._info.player.pos
			}
		}
	end

	if self._info.st == MonopolyManager.STATE.REWARD_GET then
		self._events[#self._events + 1] = {
			type = MonopolyManager.EVENTS_TYPE.PLAYER_WIN
		}
	end
end

function MonopolyManager:switchDiceType()
	self._data.diceType = self._data.diceType == MonopolyManager.DICE_TYPE.ONE_TO_THREE and MonopolyManager.DICE_TYPE.ANY or MonopolyManager.DICE_TYPE.ONE_TO_THREE

	if self.layer then
		self.layer:updateDiceImg()
	end
end

function MonopolyManager:setDiceType(arg_39_1)
	self._data.diceType = arg_39_1

	if self.layer then
		self.layer:updateDiceImg()
	end
end

function MonopolyManager:getLevelConfig()
	return self._levelConfig
end

function MonopolyManager:getLevelConfigByLevel(arg_41_1)
	return self._levelConfig[arg_41_1]
end

function MonopolyManager:getCurLevelConfig()
	return self._levelConfig[self:getLevel()]
end

function MonopolyManager:getDiceType()
	return self._data.diceType
end

function MonopolyManager:getLevel()
	return self._info.level
end

function MonopolyManager:isLevelStart()
	return self:getLevelStartTime() <= require("controller.time_check_manager"):getCurTime()
end

function MonopolyManager:getLevelStartTime()
	return (global_get_time_by_date(self:getLevelConfigByLevel(self:getLevel()).start_time))
end

function MonopolyManager:getLevelStartTimeString()
	return (global_format_time_by_date(self:getLevelConfigByLevel(self:getLevel()).start_time, 1))
end

function MonopolyManager:getAiGold()
	return self._info.ai.money
end

function MonopolyManager:getPlayerGold()
	return self._info.player.money
end

function MonopolyManager:setPlayerGold(arg_50_1)
	self._info.player.money = tonumber(arg_50_1)
end

function MonopolyManager:getPlayerPos()
	return self._info.player.pos
end

function MonopolyManager:getAiPos()
	return self._info.ai.pos
end

function MonopolyManager:getState()
	return self._info.player.st
end

function MonopolyManager:handleEvents()
	local var_54_0 = require("controller.monopoly.monopoly_move_manager"):getInstance()
	local var_54_1 = require("controller.monopoly.monopoly_map_manager"):getInstance()
	local playermodel = require("model.playermodel")

	if next(self._events) then
		self:stopWobble()

		self._info.player.st = MonopolyManager.PLAYER_STATE.EVENT

		local var_54_3 = table.remove(self._events, 1)
		local var_54_4 = var_54_3.type

		if var_54_3.type == MonopolyManager.EVENTS_TYPE.MOVE then
			self:moveEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.BUFF_MOVE then
			self:buffMoveEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.WAIT_PLAYER then
			local var_54_5 = var_54_1:getPosByValue(self._info.player.pos)
			local var_54_6 = var_54_1:getMapData()[var_54_5.x][var_54_5.y].gridType

			if var_54_3.data.talk then
				LayerManager:pushInLayer("MonopolyTalkLayer", var_54_3)

				return
			end

			if var_54_3.data.battleid then
				print("Need Fight !!!!!!!!!!!!!!!!", var_54_3.data.battleid)
				print("Need Fight !!!!!!!!!!!!!!!!", var_54_3.data.battleid)
				print("Need Fight !!!!!!!!!!!!!!!!", var_54_3.data.battleid)
				print("Need Fight !!!!!!!!!!!!!!!!", var_54_3.data.battleid)
				self:initMonopolyFight(var_54_3.data.battleid)
			elseif var_54_6 == var_54_1.GridType.Sand or var_54_6 == var_54_1.GridType.HignSand then
				LayerManager:pushInLayer("MonopolySandcastleLayer", {
					value = self._info.player.pos
				})
			end
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.ADD_MONEY then
			self:addMoneyEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.LOSE_MONEY then
			self:loseMoneyEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.LEVEL_UP_TILE then
			if var_54_3.data.gold and var_54_3.data.gold > 0 or var_54_3.data.diamond and var_54_3.data.diamond > 0 or var_54_3.data.items and next(var_54_3.data.items) then
				self:getItems(var_54_3)
			else
				self:levelUpTile(var_54_3)
			end
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.TRANSFER_MONEY then
			self:transferMoney(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.BUILDING_INCOME then
			self:buildingIncome(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.REMOVE_BUFFS then
			self:removeBuffsEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.FIGHT then
			self:fightResult(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.GET_BUFF then
			self:getBuffEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.PLAYER_WIN then
			self:playerWinEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.PLAYER_SKIP then
			self:playerSkipEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.BUILDING_DOWN then
			self:buildingDownEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.BUILDING_UP then
			self:buildingUpEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.AWARD then
			self:awardEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.BUFF_REMAIN then
			self:buffRemainEvent(var_54_3)
		elseif var_54_4 == MonopolyManager.EVENTS_TYPE.TALK then
			self:talkEvent(var_54_3)
		else
			print(L_MONOPOLY[26] .. var_54_4 .. L_MONOPOLY[27])
		end

		if not var_54_3.haveTips then
			dumpEx_3_10(var_54_3, var_54_4, 10)
			print(L_MONOPOLY[28] .. playermodel.gold)
		end
	else
		self._info.player.st = MonopolyManager.PLAYER_STATE.DICE

		if self:isAuto() and self.layer then
			self:requestThrow()
		else
			self:startWobble()
		end
	end

	global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
end

function MonopolyManager:startWobble()
	if self.layer then
		self.layer:startWobble()
	end
end

function MonopolyManager:stopWobble()
	if self.layer then
		self.layer:stopWobble()
	end
end

function MonopolyManager:insertEvent(arg_57_1)
	table.insert(self._events, 1, arg_57_1)
end

function MonopolyManager:getEvents()
	return self._events
end

function MonopolyManager:getGridInfo(arg_59_1)
	if arg_59_1 then
		for iter_59_0, iter_59_1 in pairs(self._info.tiles) do
			if iter_59_1.pos == arg_59_1 then
				return iter_59_1
			end
		end
	end

	return nil
end

function MonopolyManager:setGridBuildLevel(arg_60_1, arg_60_2, arg_60_3)
	local var_60_0 = false

	for iter_60_0, iter_60_1 in pairs(self._info.tiles) do
		if iter_60_1.pos == arg_60_1 then
			iter_60_1.lv = arg_60_2
			var_60_0 = true

			break
		end
	end

	if not var_60_0 then
		table.insert(self._info.tiles, {
			pos = arg_60_1,
			lv = arg_60_2,
			belong = arg_60_3
		})
	end
end

function MonopolyManager:addAiMoney(arg_61_1)
	if self.layer then
		self.layer:addAiMoney(arg_61_1)
	else
		self:handleEvents()
	end
end

function MonopolyManager:loseAiMoney(arg_62_1)
	if self.layer then
		self.layer:loseAiMoney(arg_62_1)
	else
		self:handleEvents()
	end
end

function MonopolyManager:getBuildLevel(arg_63_1)
	for iter_63_0, iter_63_1 in pairs(self._info.tiles) do
		if iter_63_1.pos == arg_63_1 then
			return iter_63_1.lv
		end
	end

	return nil
end

function MonopolyManager:transferMoney(arg_64_1)
	if arg_64_1.haveTips then
		local var_64_0 = arg_64_1.data

		if arg_64_1.data.source == MonopolyManager.EVENTS_TARGET_TYPE.AI then
			self._info.ai.money = var_64_0.ai_money
		elseif arg_64_1.data.source == MonopolyManager.EVENTS_TARGET_TYPE.PLAYER then
			self._info.ai.money = var_64_0.ai_money
		end

		self:setPlayerGold(var_64_0.player_gold)
		require("controller.monopoly.monopoly_event_history_manager"):getInstance():pushEvent(arg_64_1)

		if self.layer then
			self.layer:transferMoney(arg_64_1)
		else
			self:handleEvents()
		end
	else
		LayerManager:pushInLayer("MonopolyTipsLayer", arg_64_1)
	end
end

function MonopolyManager:buildingIncome(arg_65_1)
	if arg_65_1.haveTips then
		local var_65_0 = arg_65_1.data

		if arg_65_1.data.source == MonopolyManager.EVENTS_TARGET_TYPE.AI then
			self._info.ai.money = var_65_0.ai_money
		elseif arg_65_1.data.source == MonopolyManager.EVENTS_TARGET_TYPE.PLAYER then
			self._info.ai.money = var_65_0.ai_money
		end

		self:setPlayerGold(var_65_0.player_gold)
		require("controller.monopoly.monopoly_event_history_manager"):getInstance():pushEvent(arg_65_1)

		if self.layer then
			self.layer:buildingIncome(arg_65_1)
		else
			self:handleEvents()
		end
	else
		LayerManager:pushInLayer("MonopolyTipsLayer", arg_65_1)
	end
end

function MonopolyManager:fightResult(arg_66_1)
	self:setPlayerGold(arg_66_1.data.player_gold)

	if arg_66_1.data.ai_money then
		self._info.ai.money = arg_66_1.data.ai_money
	end

	if arg_66_1.haveTips then
		require("controller.monopoly.monopoly_event_history_manager"):getInstance():pushEvent(arg_66_1)

		if self.layer then
			self.layer:fightResult(arg_66_1)
		end

		self:handleEvents()
	else
		LayerManager:pushInLayer("MonopolyTipsLayer", arg_66_1)
	end
end

function MonopolyManager:getBuffEvent(arg_67_1)
	if arg_67_1.data.talk then
		LayerManager:pushInLayer("MonopolyTalkLayer", arg_67_1)

		return
	end

	if arg_67_1.haveTips then
		self._info.player.buffs[#self._info.player.buffs + 1] = {
			id = arg_67_1.data.buff,
			remain = arg_67_1.data.remain
		}

		require("controller/monopoly/monopoly_buff_manager"):getInstance():getBuffEvent(arg_67_1)
		require("controller.monopoly.monopoly_event_history_manager"):getInstance():pushEvent(arg_67_1)

		if self.layer then
			self.layer:updateEventText(arg_67_1)
		end

		self:handleEvents()
	else
		LayerManager:pushInLayer("MonopolyTipsLayer", arg_67_1)
	end
end

function MonopolyManager:removeBuffsEvent(arg_68_1)
	for iter_68_0 = 1, #arg_68_1.data.buffs do
		for iter_68_1 = 1, #self._info.player.buffs do
			if self._info.player.buffs[iter_68_1].id == arg_68_1.data.buffs[iter_68_0] then
				table.remove(self._info.player.buffs, iter_68_1)

				break
			end
		end
	end

	require("controller/monopoly/monopoly_buff_manager"):getInstance():removeBuffsEvent(arg_68_1)
	self:handleEvents()
end

function MonopolyManager:getBuffs()
	return self._info.player.buffs
end

function MonopolyManager:getFightBuffs()
	local var_70_0 = {}
	local var_70_1 = require("controller/monopoly/monopoly_buff_manager"):getInstance():getBuffInfo()

	for iter_70_0 = 1, #var_70_1 do
		if var_70_1[iter_70_0].type == 1 then
			var_70_0[#var_70_0 + 1] = tonumber(var_70_1[iter_70_0].param1)
		end
	end

	return var_70_0
end

function MonopolyManager:playerWinEvent(arg_71_1)
	if arg_71_1.data then
		if (not arg_71_1.data.gold or arg_71_1.data.gold <= 0) and (not arg_71_1.data.diamond or arg_71_1.data.diamond <= 0) then
			if arg_71_1.data.items and next(arg_71_1.data.items) then
				global_get({
					gold = arg_71_1.data.gold,
					diamond = arg_71_1.data.diamond,
					items = arg_71_1.data.items
				})
			end
		end
	end

	self._info.st = MonopolyManager.STATE.REWARD_GET

	LayerManager:pushInLayer("MonopolyPlayerWinLayer")
	require("controller/monopoly/monopoly_map_manager"):getInstance():playerWinEvent(arg_71_1)

	if self.layer then
		self.layer:updateEventText(arg_71_1)
	end
end

function MonopolyManager:getLevelState()
	return self._info.st
end

function MonopolyManager:isLastLevel()
	local var_73_0 = self:getLevel()
	local var_73_1 = self:getLevelConfigByLevel(var_73_0).level_group_id
	local var_73_2 = {}

	for iter_73_0, iter_73_1 in pairs((self:getLevelConfig())) do
		if iter_73_1.level_group_id == var_73_1 then
			var_73_2[#var_73_2 + 1] = iter_73_1
		end
	end

	table.sort(var_73_2, function(arg_74_0, arg_74_1)
		return arg_74_0.level_id < arg_74_1.level_id
	end)

	return var_73_0 == var_73_2[#var_73_2].level_id
end

function MonopolyManager:getAllLevel()
	local var_75_0 = self:getLevelConfigByLevel((self:getLevel())).level_group_id
	local var_75_1 = {}

	for iter_75_0, iter_75_1 in pairs((self:getLevelConfig())) do
		if iter_75_1.level_group_id == var_75_0 then
			var_75_1[#var_75_1 + 1] = iter_75_1.level_id
		end
	end

	table.sort(var_75_1, function(arg_76_0, arg_76_1)
		return arg_76_0 < arg_76_1
	end)

	return var_75_1
end

function MonopolyManager:getNextLevel()
	if not self:isLastLevel() then
		local var_77_0 = self:getLevel()
		local var_77_1 = self:getLevelConfigByLevel(var_77_0).level_group_id
		local var_77_2 = {}

		for iter_77_0, iter_77_1 in pairs((self:getLevelConfig())) do
			if iter_77_1.level_group_id == var_77_1 then
				var_77_2[#var_77_2 + 1] = iter_77_1
			end
		end

		table.sort(var_77_2, function(arg_78_0, arg_78_1)
			return arg_78_0.level_id < arg_78_1.level_id
		end)

		for iter_77_2 = 1, #var_77_2 do
			if var_77_2[iter_77_2].level_id == var_77_0 then
				return var_77_2[iter_77_2 + 1].level_id
			end
		end
	end

	return nil
end

function MonopolyManager:getActivateRemain()
	local var_79_0 = require("data/activity_conf_data")[self._activityId]

	if var_79_0 then
		local var_79_1 = os.time({
			year = string.sub(var_79_0.finishtime, 1, 4),
			month = string.sub(var_79_0.finishtime, 6, 7),
			day = string.sub(var_79_0.finishtime, 9, 10),
			hour = string.sub(var_79_0.finishtime, 12, 13),
			min = string.sub(var_79_0.finishtime, 15, 16),
			sec = string.sub(var_79_0.finishtime, 18, 19)
		}) - require("controller.time_check_manager"):getCurTime()
		local var_79_2 = math.floor(var_79_1 / 86400)
		local var_79_3 = math.floor((var_79_1 - var_79_2 * 24 * 60 * 60) / 3600)
		local var_79_4 = var_79_1 - var_79_2 * 24 * 60 * 60 - var_79_3 * 60 * 60 - math.floor((var_79_1 - var_79_2 * 24 * 60 * 60 - var_79_3 * 60 * 60) / 60) * 60

		return string.format(L_MONOPOLY[29], var_79_2, var_79_3)
	end

	return 0
end

function MonopolyManager:getLevelTextStr()
	local var_80_0 = self:getLevel()
	local var_80_1 = self:getAllLevel()

	for iter_80_0 = 1, #var_80_1 do
		if var_80_1[iter_80_0] == var_80_0 then
			return string.format(L_MONOPOLY[30], iter_80_0)
		end
	end

	return L_MONOPOLY[31]
end

function MonopolyManager:levelUpTile(arg_81_1)
	require("controller/monopoly/monopoly_map_manager"):getInstance():levelUpTile(arg_81_1)
	require("controller.monopoly.monopoly_event_history_manager"):getInstance():pushEvent(arg_81_1)

	if self.layer then
		self.layer:levelUpTile(arg_81_1)
	end
end

function MonopolyManager:intoNextLevel()
	if self.layer then
		self.layer:intoNextLevel()
	end
end

function MonopolyManager:moveEvent(arg_83_1)
	if arg_83_1.data.trigger == MonopolyManager.EVENTS_TARGET_TYPE.AI then
		self._info.ai.pos = arg_83_1.data.target_pos
	elseif arg_83_1.data.trigger == MonopolyManager.EVENTS_TARGET_TYPE.PLAYER then
		self._info.player.pos = arg_83_1.data.target_pos
	end

	if arg_83_1.data.cost_items then
		local item_manager = require("controller/item_manager")

		for iter_83_0, iter_83_1 in pairs(arg_83_1.data.cost_items) do
			item_manager:deleteItem(iter_83_1.entityid, iter_83_1.num)
		end
	end

	if self.layer then
		self.layer:eventMove(arg_83_1)
	end
end

function MonopolyManager:buffMoveEvent(arg_84_1)
	if arg_84_1.data.talk then
		LayerManager:pushInLayer("MonopolyTalkLayer", arg_84_1)

		return
	end

	if arg_84_1.data.trigger == MonopolyManager.EVENTS_TARGET_TYPE.AI then
		self._info.ai.pos = arg_84_1.data.target_pos
	elseif arg_84_1.data.trigger == MonopolyManager.EVENTS_TARGET_TYPE.PLAYER then
		self._info.player.pos = arg_84_1.data.target_pos
	end

	if arg_84_1.data.cost_items then
		local item_manager = require("controller/item_manager")

		for iter_84_0, iter_84_1 in pairs(arg_84_1.data.cost_items) do
			item_manager:deleteItem(iter_84_1.entityid, iter_84_1.num)
		end
	end

	if self.layer then
		self.layer:eventBuffMove(arg_84_1)
	end
end

function MonopolyManager:playerSkipEvent(arg_85_1)
	self:handleEvents()
end

function MonopolyManager:isAnyDiceThrow()
	return self._isAnyDiceThrow
end

function MonopolyManager:setIsAnyDiceThrow(arg_87_1)
	self._isAnyDiceThrow = arg_87_1
end

function MonopolyManager:buildingDownEvent(arg_88_1)
	local var_88_0 = require("controller/monopoly/monopoly_map_manager"):getInstance()

	if arg_88_1.data.talk then
		LayerManager:pushInLayer("MonopolyTalkLayer", arg_88_1)

		return
	else
		require("controller/monopoly/monopoly_map_manager"):getInstance():levelDownTile(arg_88_1)
		require("controller.monopoly.monopoly_event_history_manager"):getInstance():pushEvent(arg_88_1)

		if self.layer then
			self.layer:updateEventText(arg_88_1)
		end
	end
end

function MonopolyManager:buildingUpEvent(arg_89_1)
	local var_89_0 = require("controller/monopoly/monopoly_map_manager"):getInstance()

	if arg_89_1.data.talk then
		LayerManager:pushInLayer("MonopolyTalkLayer", arg_89_1)

		return
	else
		self:levelUpTile(arg_89_1)
	end
end

function MonopolyManager:awardEvent(arg_90_1)
	if arg_90_1.data.talk then
		LayerManager:pushInLayer("MonopolyTalkLayer", arg_90_1)

		return
	end

	if arg_90_1.haveTips then
		if arg_90_1.data.gold or arg_90_1.data.diamond or arg_90_1.data.items and next(arg_90_1.data.items) then
			local var_90_0 = false

			global_gain({
				cancelcallback = function()
					if not var_90_0 then
						var_90_0 = true

						self:handleEvents()
					end
				end,
				intocallback = function(self)
					local var_92_0 = self.layer

					performWithDelay(self.layer, function()
						if self:isAuto() then
							LayerManager:removePopLayer(var_92_0.__queueindex)

							if not var_90_0 then
								var_90_0 = true

								self:handleEvents()
							end
						end
					end, 2)
				end,
				gold = arg_90_1.data.gold,
				diamond = arg_90_1.data.diamond,
				items = arg_90_1.data.items
			})
		end

		self:setPlayerGold(arg_90_1.data.player_gold)
		require("controller.monopoly.monopoly_event_history_manager"):getInstance():pushEvent(arg_90_1)

		if self.layer then
			self.layer:updateEventText(arg_90_1)
		end
	else
		LayerManager:pushInLayer("MonopolyTipsLayer", arg_90_1)
	end
end

function MonopolyManager:buffRemainEvent(arg_94_1)
	if arg_94_1.data.buffs then
		self._info.player.buffs = arg_94_1.data.buffs

		require("controller/monopoly/monopoly_buff_manager"):getInstance():buffRemainEvent(arg_94_1)
	end

	self:handleEvents()
end

function MonopolyManager:talkEvent(arg_95_1)
	if arg_95_1.data.talk then
		arg_95_1.data.justTalk = true

		LayerManager:pushInLayer("MonopolyTalkLayer", arg_95_1)
	end
end

function MonopolyManager:loseMoneyEvent(arg_96_1)
	if arg_96_1.data.talk then
		LayerManager:pushInLayer("MonopolyTalkLayer", arg_96_1)

		return
	end

	if arg_96_1.haveTips then
		require("controller.monopoly.monopoly_event_history_manager"):getInstance():pushEvent(arg_96_1)

		if arg_96_1.data.target == MonopolyManager.EVENTS_TARGET_TYPE.AI then
			self._info.ai.money = arg_96_1.data.ai_money

			self:loseAiMoney(arg_96_1)
		end

		if self.layer then
			self.layer:updateEventText(arg_96_1)
		end
	else
		LayerManager:pushInLayer("MonopolyTipsLayer", arg_96_1)
	end
end

function MonopolyManager:addMoneyEvent(arg_97_1)
	if arg_97_1.data.talk then
		LayerManager:pushInLayer("MonopolyTalkLayer", arg_97_1)

		return
	end

	if arg_97_1.haveTips then
		require("controller.monopoly.monopoly_event_history_manager"):getInstance():pushEvent(arg_97_1)

		if arg_97_1.data.target == MonopolyManager.EVENTS_TARGET_TYPE.AI then
			self._info.ai.money = arg_97_1.data.ai_money

			self:addAiMoney(arg_97_1)
		end

		if self.layer then
			self.layer:updateEventText(arg_97_1)
		end
	else
		LayerManager:pushInLayer("MonopolyTipsLayer", arg_97_1)
	end
end

function MonopolyManager:initMonopolyFight(arg_98_1)
	self._fightinfo = {
		battleid = arg_98_1,
		state = MonopolyManager.FIGHT_STATE.READY
	}

	if FightManager.refreshFightToType(FIGHTTYPE_MONOPOLY) then
		self._fightinfo.state = MonopolyManager.FIGHT_STATE.FIGHTING

		LayerManager:switchShowLayer("FightLayer")
	end
end

function MonopolyManager:initBossList(arg_99_1)
	arg_99_1 = arg_99_1 or self._fightinfo.battleid

	local var_99_0 = {}
	local explore_monster_data = require("data.explore.explore_monster_data")
	local explore_monster_team_data = require("data.explore.explore_monster_team_data")
	local explore_level_data = require("data.explore.explore_level_data")

	print(arg_99_1)

	local var_99_4 = explore_monster_team_data[explore_level_data[arg_99_1].boss_team]

	assert(explore_monster_team_data[explore_level_data[arg_99_1].boss_team] ~= nil, "there is no data of team " .. explore_level_data[arg_99_1].boss_team .. " in monster team data!!!")

	while var_99_4["monster" .. 1] do
		var_99_0[#var_99_0 + 1] = {}
		var_99_0[#var_99_0 + 1].id = var_99_4["monster" .. 1]
		var_99_0[#var_99_0 + 1].majorlist = explore_monster_data[var_99_4["monster" .. 1]]
		var_99_0[#var_99_0 + 1].pos = var_99_4["pos" .. 1]
		var_99_0[#var_99_0 + 1].posy = var_99_4["posy" .. 1]
		var_99_0[#var_99_0 + 1].delaytime = var_99_4["delay" .. 1]
		var_99_0[#var_99_0 + 1].offset = var_99_4["offset" .. 1]
	end

	if var_99_4.boss then
		var_99_0.boss = {}
		var_99_0.boss.id = var_99_4.boss
		var_99_0.boss.majorlist = explore_monster_data[var_99_4.boss]
		var_99_0.boss.pos = var_99_4.posboss
		var_99_0.boss.posy = var_99_4.posyboss
		var_99_0.boss.delaytime = var_99_4.delayboss
		var_99_0.boss.offset = var_99_4.offsetboss
	end

	return var_99_0
end

function MonopolyManager:getCurLevelData()
	return require("data.explore.explore_level_data")[self._fightinfo.battleid]
end

function MonopolyManager:fightSuccess()
	self._fightinfo.state = MonopolyManager.FIGHT_STATE.FINISH
	self._fightinfo.result = MonopolyManager.FIGHT_RESULT.SUCCESS

	LayerManager:switchShowLayer("MonopolyNewLayer")
end

function MonopolyManager:fightFail()
	self._fightinfo.state = MonopolyManager.FIGHT_STATE.FINISH
	self._fightinfo.result = MonopolyManager.FIGHT_RESULT.FAIL

	LayerManager:switchShowLayer("MonopolyNewLayer")
end

function MonopolyManager:getEventTextStr()
	return (require("controller/monopoly/monopoly_event_history_manager"):getInstance():getLastEventStr())
end

function MonopolyManager:getItems(arg_104_1)
	if arg_104_1.data.gold and arg_104_1.data.gold > 0 or arg_104_1.data.diamond and arg_104_1.data.diamond > 0 or arg_104_1.data.items and next(arg_104_1.data.items) then
		local var_104_0 = clone(arg_104_1)

		var_104_0.data.gold = nil
		var_104_0.data.diamond = nil
		var_104_0.data.items = nil

		local var_104_1 = false

		global_gain({
			cancelcallback = function()
				if not var_104_1 then
					var_104_1 = true

					self:insertEvent(var_104_0)
					self:handleEvents()
				end
			end,
			intocallback = function(self)
				local var_106_0 = self.layer

				performWithDelay(self.layer, function()
					if self:isAuto() then
						LayerManager:removePopLayer(var_106_0.__queueindex)

						if not var_104_1 then
							var_104_1 = true

							self:insertEvent(var_104_0)
							self:handleEvents()
						end
					end
				end, 2)
			end,
			gold = arg_104_1.data.gold,
			diamond = arg_104_1.data.diamond,
			items = arg_104_1.data.items
		})
	end
end

function MonopolyManager:updateDiceNumText()
	if self.layer then
		self.layer:updateDiceNumText()
	end
end

function MonopolyManager:updateOurBillText()
	if self.layer then
		self.layer:updateOurBillText()
	end
end

return MonopolyManager
