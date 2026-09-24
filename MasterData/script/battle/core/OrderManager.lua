local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = table.insert
local var_0_3 = table.remove
local var_0_5 = lx.json_encode

lx.define_class("OrderManager", function(arg_1_0)
	function arg_1_0:executeInitOrder()
		self:__push_action__from_record(4)

		self._need_run = true

		self:__execute_order()

		self._need_run = false

		self:__push_action__from_record()
	end

	function arg_1_0:isAlreadyFinish()
		return self._already_finish
	end

	function arg_1_0.setRecordData(arg_4_0, arg_4_1)
		local var_4_0 = var_0_1.json_decode(arg_4_1)

		if not var_4_0 then
			var_0_1.error("setRecordData, decode data failed.")
		end

		arg_4_0._total_frame = var_4_0[#var_4_0].frame
		var_4_0[#var_4_0] = nil
		arg_4_0._play_record = true
		arg_4_0._record_data = var_4_0
		arg_4_0._record_data_num = #var_4_0
	end

	function arg_1_0:executeAllRecord()
		self:__check_start_order(var_0_1.Time:getTime())

		local var_5_0 = self._battle_time:getFrame()

		while self._record_data_idx < self._record_data_num or var_5_0 <= self._total_frame do
			local var_5_1 = self._battle_time:getTime()

			self._battle_scene:eventOnFrame(var_5_1)
			self._battle_obj_mgr:eventOnFrame(var_5_1)
			self._battle_processor:eventOnFrame(var_5_1)
			self:__check_push_record(var_5_0)
			self:__execute_order()

			var_5_0 = var_5_0 + 1

			self._battle_time:setFrame(var_5_0)
		end
	end

	function arg_1_0:serializeRecord()
		return var_0_5(self._order_record)
	end

	function arg_1_0:initBattleRandom(arg_7_1)
		self:__push_orderqueue("BattleRandom", {
			seed = arg_7_1
		})
	end

	function arg_1_0:initBattleTime(arg_8_1, arg_8_2)
		self:__push_orderqueue("BattleTime", {
			speed = arg_8_1,
			frame_interval = arg_8_2
		})
	end

	function arg_1_0:initBattleScene(arg_9_1)
		self:__push_orderqueue("BattleScene", {
			data = arg_9_1
		})
	end

	function arg_1_0:initBattleObject(arg_10_1)
		self:__push_orderqueue("BattleObject", {
			data = arg_10_1
		})
	end

	function arg_1_0:dayWarEnd(arg_11_1)
		self:__push_orderqueue("DayWarEnd", {
			data = arg_11_1
		})
	end

	function arg_1_0:nightWarStart(arg_12_1)
		self:__push_orderqueue("NightWarStart", {
			data = arg_12_1
		})
	end

	function arg_1_0:startBattle()
		self:__push_orderqueue("StartBattle", {})
	end

	function arg_1_0:finishBattle()
		self:__push_orderqueue("FinishBattle", {})
	end

	function arg_1_0:executeBattleObjectOrder(arg_15_1, arg_15_2, arg_15_3)
		self:__push_orderqueue("ExecuteBattleObject", {
			id = arg_15_1,
			action = arg_15_2,
			data = arg_15_3
		})
	end

	function arg_1_0:executeBattleSceneOrder(arg_16_1, arg_16_2)
		self:__push_orderqueue("ExecuteBattleScene", {
			action = arg_16_1,
			data = arg_16_2
		})
	end

	function arg_1_0:__on_order_BattleRandom(arg_17_1)
		self._battle_random:initRandom(arg_17_1.param.seed)
	end

	function arg_1_0:__on_order_BattleTime(arg_18_1)
		self._battle_time:initTime(arg_18_1.param.speed, arg_18_1.param.frame_interval)
	end

	function arg_1_0:__on_order_BattleScene(arg_19_1)
		self._battle_scene:initData(arg_19_1.param.data)
	end

	function arg_1_0:__on_order_BattleObject(arg_20_1)
		self._battle_obj_mgr:initData(arg_20_1.param.data)
	end

	function arg_1_0:__on_order_DayWarEnd(arg_21_1)
		self._battle_processor:eventOnRecord(self._battlefield:getRecord(), self._battlefield:get_battle_result(), (self._battlefield:get_damage_result()))
	end

	function arg_1_0:__on_order_NightWarStart(arg_22_1)
		self._battlefield:on_night_war(arg_22_1.param.data)
	end

	function arg_1_0:__on_order_StartBattle(arg_23_1)
		self._need_run = true

		self._battlefield:start()
	end

	function arg_1_0:__on_order_FinishBattle(arg_24_1)
		self._need_run = false
		self._already_finish = true

		self._battle_scene:eventOnDestroy()
		self._battle_obj_mgr:eventOnDestroy()
	end

	function arg_1_0:__on_order_ExecuteBattleObject(arg_25_1)
		local var_25_0 = self._battle_obj_mgr:findObject(arg_25_1.param.id)

		if not var_25_0 then
			var_0_1.error(string.format("battle object not found, id:[%s], action:[%s]", tostring(arg_25_1.param.id), tostring(arg_25_1.param.action)))

			return
		end

		var_25_0:execute(arg_25_1.param.action, arg_25_1.param.data)
	end

	function arg_1_0:__on_order_ExecuteBattleScene(arg_26_1)
		self._battle_scene:execute(arg_26_1.param.action, arg_26_1.param.data)
	end

	function arg_1_0:__push_orderqueue(arg_27_1, arg_27_2)
		self._order_queue = self._order_queue or {}

		var_0_2(self._order_queue, {
			name = arg_27_1,
			param = arg_27_2
		})
	end

	function arg_1_0:__push_order_record(arg_28_1)
		self._order_record = self._order_record or {}

		var_0_2(self._order_record, arg_28_1)
	end

	function arg_1_0:__execute_order()
		while self._need_run do
			if not self._order_queue[1] then
				break
			end

			self:__do_order_func(self._order_queue[1])
			var_0_3(self._order_queue, 1)
		end
	end

	function arg_1_0:__do_order_func(arg_30_1)
		self:__push_order_record(arg_30_1)

		local var_30_0 = string.format("__on_order_%s", arg_30_1.name)

		if not self[var_30_0] then
			return
		end

		arg_30_1.frame = self._battle_time:getFrame()

		self[var_30_0](self, arg_30_1)
	end

	function arg_1_0:run_once(arg_31_1)
		if not self._need_run then
			self:__check_start_order(arg_31_1)

			return
		end

		self._battle_time:run_once(arg_31_1)
		self:__check_run_order()
	end

	function arg_1_0:__push_action__from_record(arg_32_1)
		if not self._play_record then
			return
		end

		arg_32_1 = arg_32_1 or 1

		while arg_32_1 > 0 do
			if self._record_data_idx > self._record_data_num then
				break
			end

			self:__push_orderqueue(self._record_data[self._record_data_idx].name, self._record_data[self._record_data_idx].param)

			self._record_data_idx = self._record_data_idx + 1
			arg_32_1 = arg_32_1 - 1
		end
	end

	function arg_1_0:__check_start_order(arg_33_1)
		if self._order_queue[1] and self._order_queue[1].name == "StartBattle" then
			self:__do_order_func(self._order_queue[1])
			var_0_3(self._order_queue, 1)
			self._battle_time:setStartTime(arg_33_1)
		end
	end

	function arg_1_0:__check_run_order()
		while self._need_run and self._battle_time:hasFrame() do
			local var_34_0 = self._battle_time:getTime()

			self._battle_scene:eventOnFrame(var_34_0)
			self._battle_obj_mgr:eventOnFrame(var_34_0)
			self._battle_processor:eventOnFrame(var_34_0)
			self:__execute_order()
			self._battle_time:nextFrame()
		end
	end

	function arg_1_0:__check_push_record(arg_35_1)
		if not self._play_record then
			return
		end

		while true do
			if self._record_data_idx > self._record_data_num then
				break
			end

			local var_35_0 = self._record_data[self._record_data_idx]

			if self._record_data[self._record_data_idx].frame ~= arg_35_1 then
				break
			end

			if var_35_0.name ~= "pause" and var_35_0.name ~= "resume" then
				self:__action_sequence__push(var_35_0)
			end

			self._record_data_idx = self._record_data_idx + 1
		end
	end

	function arg_1_0:bind()
		self._battle_random = self._battlefield:getBattleRandom()
		self._battle_time = self._battlefield:getBattleTime()
		self._battle_scene = self._battlefield:getBattleScene()
		self._battle_obj_mgr = self._battlefield:getBattleObjectManager()
		self._battle_processor = self._battlefield:getBattleProcessor()
	end
end)

function var_0_0.create(arg_37_0, arg_37_1)
	local var_37_0 = var_0_1.class("OrderManager")

	var_37_0._order_queue = nil
	var_37_0._order_record = {}
	var_37_0._battlefield = arg_37_1
	var_37_0._battle_scene = nil
	var_37_0._battle_time = nil
	var_37_0._battle_random = nil
	var_37_0._battle_obj_mgr = nil
	var_37_0._battle_processor = nil
	var_37_0._need_run = false
	var_37_0._record_data_idx = 1

	return var_37_0
end

return var_0_0
