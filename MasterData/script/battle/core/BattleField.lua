local var_0_0 = {}
local var_0_1 = lx
local var_0_3 = gamecore.BattleRandom
local var_0_4 = gamecore.BattleTime
local var_0_5 = gamecore.OrderManager
local var_0_6 = gamecore.BattleObjectManager
local var_0_7 = gamecore.BattleScene

lx.define_class("BattleField", function(arg_1_0)
	function arg_1_0:initBattleField(arg_2_1)
		self._order_mgr:initBattleRandom(arg_2_1.BattleRandom)
		self._order_mgr:initBattleTime(arg_2_1.BattleTime.speed, arg_2_1.BattleTime.frame_interval)
		self._order_mgr:initBattleScene(arg_2_1.BattleScene)
		self._order_mgr:initBattleObject(arg_2_1.BattleObject)
		self._order_mgr:executeInitOrder()
		self._order_mgr:startBattle()
	end

	function arg_1_0:startNightWar(arg_3_1)
		self._order_mgr:nightWarStart(arg_3_1)
	end

	function arg_1_0:playRecordAll(arg_4_1)
		self._order_mgr:setRecordData(arg_4_1)
		self._order_mgr:executeInitOrder()
		self._order_mgr:executeAllRecord()
	end

	function arg_1_0:bind(arg_5_1)
		self._battle_processor = arg_5_1

		self._order_mgr:bind()
		self._battle_obj_mgr:bind()
		self._battle_scene:bind()
	end

	function arg_1_0:getRecord()
		return self._order_mgr:serializeRecord()
	end

	function arg_1_0:exit()
		self._order_mgr:finishBattle()
	end

	function arg_1_0:isAlreadyExit()
		return self._already_exit
	end

	function arg_1_0:getBattleTime()
		return self._battle_time
	end

	function arg_1_0:getBattleRandom()
		return self._battle_random
	end

	function arg_1_0:getBattleScene()
		return self._battle_scene
	end

	function arg_1_0:getBattleObjectManager()
		return self._battle_obj_mgr
	end

	function arg_1_0:getBattleProcessor()
		return self._battle_processor
	end

	function arg_1_0:handleBattleObject(arg_14_1, arg_14_2, arg_14_3)
		self._order_mgr:executeBattleObjectOrder(arg_14_1, arg_14_2, arg_14_3)
	end

	function arg_1_0:handleBattleScene(arg_15_1, arg_15_2)
		self._order_mgr:executeBattleSceneOrder(arg_15_1, arg_15_2)
	end

	function arg_1_0:get_battle_result()
		return self._battle_result
	end

	function arg_1_0:run_once(arg_17_1)
		self._order_mgr:run_once(arg_17_1)

		if self._order_mgr:isAlreadyFinish() then
			self._already_exit = true
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_18_0)
	local var_18_0 = var_0_1.class("BattleField")

	var_18_0._battle_scene = var_0_7:create(var_18_0)
	var_18_0._battle_obj_mgr = var_0_6:create(var_18_0)
	var_18_0._battle_random = var_0_3:create(var_18_0)
	var_18_0._battle_time = var_0_4:create()
	var_18_0._order_mgr = var_0_5:create(var_18_0)
	var_18_0._battle_processor = nil
	var_18_0._damage_result = nil
	var_18_0._index = 1
	var_18_0._battle_result = nil
	var_18_0._battle_report = nil

	gamecore.extend_obj(var_18_0)

	return var_18_0
end

return var_0_0
