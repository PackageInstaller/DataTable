local var_0_0 = {}
local var_0_1 = 12
local var_0_2 = 4
local var_0_4 = {
	tips_time_reduce = 0.2,
	error_cd_time = 1,
	min_tips_time = 0.4,
	tips_time = 1,
	error_scroe = 1,
	tips_time_add = 0.2,
	limit_time = 60,
	right_scroe = {
		2,
		2,
		4,
		6,
		8,
		10,
		12,
		14,
		16,
		18
	}
}

function var_0_0.initData(arg_1_0)
	arg_1_0.material = {}
	arg_1_0.material_order = {}
	arg_1_0.cur_index = 0
	arg_1_0.turns = 0
	arg_1_0.time = 0
	arg_1_0.limit_time = var_0_4.limit_time
	arg_1_0.tips_time = var_0_4.tips_time
	arg_1_0.error_cd_time = 0
	arg_1_0.cd_time = 0
	arg_1_0.combo = 0
	arg_1_0.score = 0
	arg_1_0.turn_allright = false
	arg_1_0.gameEvents = {}
end

function var_0_0.registerUIRef(arg_2_0, arg_2_1)
	arg_2_0.uiref = arg_2_1
end

function var_0_0.unregisterUIRef(arg_3_0)
	arg_3_0.uiref = nil
end

function var_0_0:exitGame()
	self:unloop()
	self:initData()
	self:unregisterUIRef()
end

function var_0_0:registerGameEvent(arg_5_1, arg_5_2, arg_5_3)
	self.gameEvents[arg_5_1] = self.gameEvents[arg_5_1] or {}

	table.insert(self.gameEvents[arg_5_1], {
		obj = arg_5_2,
		handler = arg_5_3
	})
end

function var_0_0:unregisterGameEvent(arg_6_1, arg_6_2)
	if self.gameEvents[arg_6_1] then
		for iter_6_0, iter_6_1 in pairs(self.gameEvents[arg_6_1]) do
			if iter_6_1.handler == arg_6_2 then
				table.remove(self.gameEvents[arg_6_1], iter_6_1)
			end
		end
	end
end

function var_0_0:dispatcherEvent(arg_7_1, ...)
	if self.gameEvents[arg_7_1] then
		for iter_7_0, iter_7_1 in pairs(self.gameEvents[arg_7_1]) do
			iter_7_1.handler(iter_7_1.obj, ...)
		end
	end
end

function var_0_0:gameStart()
	if not self.uiref then
		return
	end

	if self.mainloop then
		return
	end

	self:initData()
	self.uiref:registerGameEvent()
	self:createMainLoop()
	self:next_turn()
end

function var_0_0:gameUpdate(arg_9_1)
	if self.gamePaused then
		return
	end

	if self.time < self.limit_time then
		self.time = self.time + arg_9_1
	else
		self:gameEnd()
	end

	if self.cd_time < self.error_cd_time then
		self.cd_time = self.cd_time + arg_9_1
	end

	self:dispatcherEvent("UPDATE_UI", {
		time = self.time,
		limit_time = self.limit_time,
		cd_time = self.cd_time,
		error_cd_time = self.error_cd_time,
		score = self.score
	})
end

function var_0_0:addMaterial(arg_10_1)
	if not self.mainloop then
		return
	end

	if self.cd_time < self.error_cd_time then
		global_ShowBlockWords("冷却中")

		return
	end

	if self.cur_index > var_0_2 then
		return
	end

	local var_10_1

	if arg_10_1 == self.material_order[self.cur_index] then
		self.score = self.score + (var_0_4.right_scroe[math.max(1, self.combo)] or var_0_4.right_scroe[#var_0_4.right_scroe])
		var_10_1 = true
	else
		self.turn_allright = false
		self.combo = 0
		self.error_cd_time = var_0_4.error_cd_time
		self.cd_time = 0
		var_10_1 = false
	end

	self.cur_index = self.cur_index + 1

	self:dispatcherEvent("ADD_MATERIAL_RESULT", {
		result = var_10_1,
		index = arg_10_1,
		cur_index = self.cur_index
	})

	if self.cur_index > var_0_2 then
		self:next_turn()
	elseif not var_10_1 then
		global_ShowBlockWords("材料投错啦！进入冷却")
	end
end

function var_0_0:next_turn(arg_11_1)
	if self.turn_allright then
		self.tips_time = math.max(var_0_4.min_tips_time, self.tips_time - var_0_4.tips_time_reduce)
		self.combo = self.combo + 1
	else
		self.tips_time = self.tips_time + var_0_4.tips_time_add
		self.combo = 0
	end

	self.turn_allright = true
	self.turns = self.turns + 1
	self.cur_index = 1
	self.material = {}

	local var_11_0 = {}

	for iter_11_0 = 1, var_0_2 do
		local var_11_1 = math.random(1, var_0_1)

		while var_11_0[var_11_1] do
			var_11_1 = math.random(1, var_0_1)
		end

		var_11_0[var_11_1] = true

		table.insert(self.material, var_11_1)
	end

	self.material_order = {}

	for iter_11_1 = 1, var_0_2 do
		table.insert(self.material_order, iter_11_1)
	end

	for iter_11_2, iter_11_3 in ipairs(self.material_order) do
		local var_11_2 = math.random(1, var_0_2)

		self.material_order[iter_11_2], self.material_order[var_11_2] = self.material_order[var_11_2], self.material_order[iter_11_2]
	end

	self:dispatcherEvent("NEW_TURNS", {
		material = self.material,
		material_order = self.material_order,
		combo = self.combo,
		tips_time = self.tips_time,
		turns = self.turns
	})
end

function var_0_0:gameEnd()
	self:unloop()
	self:dispatcherEvent("GAME_END", {
		score = self.score
	})
	self:initData()
end

function var_0_0:createMainLoop()
	self.mainloop = self.mainloop or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_14_0)
		self:gameUpdate(arg_14_0)
	end, 0, false)
end

function var_0_0:unloop()
	if self.mainloop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.mainloop)

		self.mainloop = nil
	end
end

return var_0_0
