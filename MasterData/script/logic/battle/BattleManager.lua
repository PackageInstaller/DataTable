local var_0_0 = lx
local var_0_1 = gamecore.user
local var_0_2 = lx.json_decode
local var_0_3 = string.format
local var_0_4 = gamecore.battle_processor

lx.define_class("BattleManager", function(arg_1_0)
	function arg_1_0:start()
		if self._battlefield then
			return
		end

		self:init()

		self._battle_processor = var_0_4:create()
		self._battlefield = gamecore.BattleField:create()

		self._battlefield:bind(self._battle_processor)
		self._battle_processor:bind(self._battlefield)
		self._battlefield:initBattleField({
			BattleRandom = self:get_random(),
			BattleTime = self:get_battletime(),
			BattleScene = self._scene,
			BattleObject = {
				player = self._players,
				enemy = self._enemys
			}
		})
	end

	function arg_1_0:loadRecord()
		if self._battlefield then
			return
		end

		local var_3_0 = var_0_2(var_0_1:get_battle_data().record)

		self._battlefield = gamecore.BattleField:create()
		self._battle_processor = var_0_4:create()

		self._battlefield:bind(self._battle_processor)
		self._battle_processor:bind(self._battlefield)

		if var_3_0 then
			self._battlefield:initBattleField({
				BattleRandom = var_3_0[1].param.seed,
				BattleTime = var_3_0[2].param,
				BattleScene = var_3_0[3].param.data,
				BattleObject = var_3_0[4].param.data
			})

			self._scene_data = var_3_0[3].param.data
			self._unit_data = var_3_0[4].param.data
		end
	end

	function arg_1_0:playRecordAll(arg_4_1)
		if self._battlefield then
			return
		end

		self._battlefield = gamecore.BattleField:create()
		self._battle_processor = var_0_4:create()

		self._battlefield:bind(self._battle_processor)
		self._battle_processor:bind(self._battlefield)

		self._play_record = true

		self._battlefield:playRecordAll(arg_4_1)
	end

	function arg_1_0:getPlayerFormation()
		if not self._battlefield then
			return
		end

		return self._battlefield:getBattleScene():get_player_course()
	end

	function arg_1_0:getEnmeyFormation()
		if not self._battlefield then
			return
		end

		return self._battlefield:getBattleScene():get_enemy_course()
	end

	function arg_1_0.setBattleResult(arg_7_0, arg_7_1)
		arg_7_0._battle_result = arg_7_1
	end

	function arg_1_0:getBattleResult()
		return self._battle_result
	end

	function arg_1_0.setBattleDamageResult(arg_9_0, arg_9_1)
		arg_9_0._battle_damage_result = arg_9_1
	end

	function arg_1_0:getBattleDamageResult()
		return self._battle_damage_result
	end

	function arg_1_0:exit(arg_11_1)
		if not self._battlefield then
			return
		end

		self._battlefield:exit()

		self._exit_call_func = arg_11_1
	end

	function arg_1_0:get_battle_result()
		if not self._battlefield then
			return
		end

		return self._battlefield:get_battle_result()
	end

	function arg_1_0:handleBattleScene(arg_13_1, arg_13_2)
		if not self._battlefield then
			return
		end

		self._battlefield:handleBattleScene(arg_13_1, arg_13_2)
	end

	function arg_1_0:startNightWar(arg_14_1)
		if not self._battlefield then
			return
		end

		self._battlefield:startNightWar(arg_14_1)
	end

	function arg_1_0:getSceneData()
		return self._scene_data
	end

	function arg_1_0:getUnitData()
		return self._unit_data
	end

	function arg_1_0.set_battle_damage_report(arg_17_0, arg_17_1)
		arg_17_0._battle_damage_report = var_0_0.json_format(arg_17_1)
	end

	function arg_1_0:get_battle_damage_report()
		if not self._battlefield then
			return
		end

		return self._battlefield:get_damage_result()
	end

	function arg_1_0:reset()
		self._battlefield = nil

		self._battle_processor:eventOnDestroy()

		self._battle_processor = nil
	end

	function arg_1_0:run_once(arg_20_1)
		self:__run_once_battle(arg_20_1)
	end

	function arg_1_0:__run_one_battle_func(arg_21_1)
		if self._battlefield then
			self._battlefield:run_once(arg_21_1)

			if self._battlefield:isAlreadyExit() then
				self._record_data = self._battlefield:getRecord()

				if self._exit_call_func then
					self._exit_call_func(self._record_data)
				end

				self._battle_processor:eventOnDestroy()

				self._battle_processor = nil
				self._battlefield = nil
				self._exit_call_func = nil
			end
		end
	end

	function arg_1_0:__run_once_battle(arg_22_1)
		local var_22_0, var_22_1 = xpcall(self.__run_one_battle_func, debug.traceback, self, arg_22_1)

		if not var_22_0 then
			log.errorlog(var_0_3("run one battle error, err:[%s]", var_22_1))
		end
	end

	function arg_1_0:checkInit()
		if self._battle_processor then
			self._battle_processor:checkInit()
		end
	end

	gamecore.extend_method(arg_1_0)
end)

return function()
	local var_24_0 = var_0_0.class("BattleManager")

	var_24_0._battlefield = nil
	var_24_0._battle_processor = nil
	var_24_0._scene_data = nil
	var_24_0._unit_data = nil

	gamecore.extend_obj(var_24_0)

	return var_24_0
end
