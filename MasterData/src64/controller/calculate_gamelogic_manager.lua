local audio_manager = require("controller.audio_manager")
local var_0_1 = {}
local var_0_2 = {}

var_0_2.__index = var_0_2

function var_0_2.new()
	return setmetatable({
		first = 0,
		last = -1
	}, var_0_2)
end

function var_0_2:push(arg_2_1)
	self.last = self.last + 1
	self[self.last] = arg_2_1
end

function var_0_2:pop()
	if self.first > self.last then
		error("Queue is empty")
	end

	self[self.first] = nil
	self.first = self.first + 1

	return self[self.first]
end

function var_0_2:front()
	if self.first > self.last then
		return nil
	end

	return self[self.first]
end

function var_0_2:back()
	if self.first > self.last then
		return nil
	end

	return self[self.last]
end

function var_0_2:size()
	return self.last - self.first + 1
end

function var_0_2:empty()
	return self.first > self.last
end

local var_0_3 = {
	init_speed = 240,
	max_speed = 480,
	init_height = 950,
	add_speed = 2
}
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3
local var_0_7 = 4
local var_0_8 = 180
local var_0_9 = 30

function var_0_1.resetData(arg_8_0)
	arg_8_0.channel_num = 3
	arg_8_0.channels = {}
	arg_8_0.game_conf = nil
	arg_8_0.distance_score = 0
	arg_8_0.hp_score = 0
	arg_8_0.time = 0
	arg_8_0.speed = 0
	arg_8_0.next_turn_distance = 0
	arg_8_0.cur_turn = 0
	arg_8_0.cur_channel = 2
	arg_8_0.obstacle_turn = 0
end

function var_0_1:initData()
	self.channel_num = 3
	self.channels = {}

	for iter_9_0 = 1, self.channel_num do
		table.insert(self.channels, (var_0_2.new()))
	end

	self.game_conf = var_0_3
	self.distance_score = 0
	self.hp_score = 0
	self.time = 0
	self.speed = self.game_conf.init_speed
	self.next_turn_distance = self.speed * 1
	self.cur_turn = 0
	self.cur_channel = 2
	self.obstacle_turn = 0
end

function var_0_1.registerUIRef(arg_10_0, arg_10_1)
	arg_10_0.uiref = arg_10_1
end

function var_0_1.unregisterUIRef(arg_11_0)
	arg_11_0.uiref = nil
end

function var_0_1:exitGame()
	self:unloop()
	self:resetData()
	self:unregisterUIRef()

	self.gameEvents = {}
end

function var_0_1:registerGameEvent(arg_13_1, arg_13_2, arg_13_3)
	self.gameEvents = self.gameEvents or {}
	self.gameEvents[arg_13_1] = self.gameEvents[arg_13_1] or {}

	table.insert(self.gameEvents[arg_13_1], {
		obj = arg_13_2,
		handler = arg_13_3
	})
end

function var_0_1:unregisterGameEvent(arg_14_1, arg_14_2)
	if self.gameEvents[arg_14_1] then
		for iter_14_0, iter_14_1 in pairs(self.gameEvents[arg_14_1]) do
			if iter_14_1.handler == arg_14_2 then
				table.remove(self.gameEvents[arg_14_1], iter_14_1)
			end
		end
	end
end

function var_0_1:dispatcherEvent(arg_15_1, ...)
	if self.gameEvents[arg_15_1] then
		for iter_15_0, iter_15_1 in pairs(self.gameEvents[arg_15_1]) do
			iter_15_1.handler(iter_15_1.obj, ...)
		end
	end
end

function var_0_1:gameStart()
	if not self.uiref then
		return
	end

	if self.mainloop then
		return
	end

	self:initData()
	self:createMainLoop()
end

function var_0_1:gameUpdate(arg_17_1)
	if not self.mainloop then
		return
	end

	if self.gamePaused then
		return
	end

	self.time = self.time + arg_17_1

	if self.speed < self.game_conf.max_speed then
		self.speed = math.min(self.game_conf.max_speed, self.speed + arg_17_1 * self.game_conf.add_speed)
	end

	self.distance_score = self.distance_score + arg_17_1 * self.speed

	self:dispatcherEvent("UPDATE_GAMEDATA", {
		distance_score = self.distance_score / 100,
		hp_score = self.hp_score
	})

	if self.distance_score > self.next_turn_distance then
		self.next_turn_distance = self.distance_score + 500 - self.speed * 0.5

		self:spawnObstacles()
	end

	self:checkObstacles(arg_17_1)
	self:checkGameEnd()
end

function var_0_1:spawnObstacles()
	local var_18_0 = math.floor(5 * (1 + self.distance_score / 1000) + self.hp_score * 0.08)
	local var_18_1 = math.floor(self.hp_score * 0.4 + 10 * (1 + self.distance_score / 1000))

	self.obstacle_turn = self.obstacle_turn + 1

	local var_18_2 = {
		1,
		2,
		3
	}

	for iter_18_0, iter_18_1 in ipairs(var_18_2) do
		local var_18_3 = math.random(3)

		var_18_2[iter_18_0], var_18_2[var_18_3] = var_18_2[var_18_3], var_18_2[iter_18_0]
	end

	local function var_18_4(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = {
			type = arg_19_0,
			value = arg_19_1,
			height = self.game_conf.init_height,
			turn = self.obstacle_turn
		}

		self:dispatcherEvent("CHANNEL_ADD_OBSTACLE", {
			index = arg_19_2,
			obstacle = var_19_0
		})

		return var_19_0
	end

	local var_18_5 = {
		{
			0.1,
			0.3,
			0.5,
			0.7,
			0.9,
			0.99
		},
		{
			0.1,
			0.25,
			0.6,
			0.8,
			0.9,
			0.99
		},
		{
			0.1,
			0.25,
			0.5,
			0.7,
			0.85,
			0.99
		},
		{
			0.1,
			0.2,
			0.4,
			0.7,
			0.8,
			0.95
		},
		{
			0.05,
			0.15,
			0.3,
			0.5,
			0.7,
			0.9
		},
		{
			0.01,
			0.1,
			0.3,
			0.4,
			0.6,
			0.8
		}
	}
	local var_18_6 = 0

	for iter_18_2, iter_18_3 in ipairs({
		0,
		100,
		150,
		200,
		250,
		300
	}) do
		if iter_18_3 <= self.distance_score / 100 then
			var_18_6 = iter_18_2
		else
			break
		end
	end

	local var_18_7 = var_18_5[var_18_6]
	local var_18_8 = math.random()

	if var_18_8 < var_18_5[var_18_6][1] then
		self.channels[var_18_2[1]]:push(var_18_4(var_0_4, math.floor(var_18_1 * 0.9), var_18_2[1]))
		self.channels[var_18_2[2]]:push(var_18_4(var_0_4, math.floor(var_18_1 * 1.1), var_18_2[2]))
		self.channels[var_18_2[3]]:push(var_18_4(var_0_6, math.floor((1.2 + math.random() * 0.3) * 10) / 10, var_18_2[3]))
	elseif var_18_8 < var_18_7[2] then
		self.channels[var_18_2[1]]:push(var_18_4(var_0_4, var_18_0, var_18_2[1]))
		self.channels[var_18_2[2]]:push(var_18_4(var_0_6, math.floor((1.2 + math.random() * 0.5) * 10) / 10, var_18_2[2]))
	elseif var_18_8 < var_18_7[3] then
		self.channels[var_18_2[1]]:push(var_18_4(var_0_4, var_18_0, var_18_2[1]))
		self.channels[var_18_2[2]]:push(var_18_4(var_0_6, math.floor((1.2 + math.random() * 0.5) * 10) / 10, var_18_2[2]))
		self.channels[var_18_2[3]]:push(var_18_4(var_0_5, var_18_1, var_18_2[3]))
	elseif var_18_8 < var_18_7[4] then
		self.channels[var_18_2[1]]:push(var_18_4(var_0_4, var_18_0, var_18_2[1]))
		self.channels[var_18_2[2]]:push(var_18_4(var_0_7, 2, var_18_2[2]))
		self.channels[var_18_2[3]]:push(var_18_4(var_0_5, var_18_1, var_18_2[3]))
	elseif var_18_8 < var_18_7[5] then
		self.channels[var_18_2[1]]:push(var_18_4(var_0_7, math.floor((1.5 + math.random()) * 10) / 10, var_18_2[1]))
		self.channels[var_18_2[2]]:push(var_18_4(var_0_5, var_18_1, var_18_2[2]))
	elseif var_18_8 < var_18_7[6] then
		self.channels[var_18_2[1]]:push(var_18_4(var_0_5, math.floor(var_18_1 * 0.9), var_18_2[1]))
		self.channels[var_18_2[2]]:push(var_18_4(var_0_5, math.floor(var_18_1 * 1.1), var_18_2[2]))
	else
		self.channels[var_18_2[1]]:push(var_18_4(var_0_7, math.floor((1.5 + 2 * math.random()) * 10) / 10, var_18_2[1]))
		self.channels[var_18_2[2]]:push(var_18_4(var_0_5, math.floor(var_18_1 * 1.2), var_18_2[2]))
		self.channels[var_18_2[2]]:push(var_18_4(var_0_5, math.floor(var_18_1 * 1.4), var_18_2[3]))
	end
end

function var_0_1:checkObstacles(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(self.channels) do
		if not iter_20_1:empty() then
			for iter_20_2 = iter_20_1.first, iter_20_1.last do
				iter_20_1[iter_20_2].height = iter_20_1[iter_20_2].height - self.speed * arg_20_1

				if iter_20_1[iter_20_2].node then
					iter_20_1[iter_20_2].node:setPositionY(iter_20_1[iter_20_2].height)
				end
			end

			if math.abs(iter_20_1[iter_20_1.first].height - var_0_8) < var_0_9 then
				if self.cur_channel == iter_20_0 then
					self:handleCollision(iter_20_1[iter_20_1.first])
				end
			elseif var_0_8 - iter_20_1[iter_20_1.first].height > 2 * var_0_9 then
				iter_20_1:pop()
				self:dispatcherEvent("DELETE_OBSTACLE", iter_20_1[iter_20_1.first])
			end
		end
	end
end

function var_0_1:handleCollision(arg_21_1)
	if self.cur_turn >= arg_21_1.turn then
		return
	end

	if arg_21_1.type == var_0_4 then
		self.hp_score = self.hp_score + arg_21_1.value
	elseif arg_21_1.type == var_0_5 then
		self.hp_score = self.hp_score - arg_21_1.value
	elseif arg_21_1.type == var_0_6 then
		self.hp_score = math.floor(self.hp_score * arg_21_1.value)
	elseif arg_21_1.type == var_0_7 then
		self.hp_score = math.floor(self.hp_score / arg_21_1.value)
	end

	self.cur_turn = arg_21_1.turn

	self:dispatcherEvent("UPDATE_GAMEDATA", {
		distance_score = self.distance_score / 100,
		hp_score = self.hp_score
	})
	self.channels[self.cur_channel]:pop()
	self:dispatcherEvent("DELETE_OBSTACLE", arg_21_1)
end

function var_0_1:TouchMoveEnd(arg_22_1)
	if not self.mainloop then
		return
	end

	local var_22_0 = arg_22_1 > 0 and 1 or -1

	if self.cur_channel + (arg_22_1 > 0 and 1 or -1) < 1 or self.cur_channel + var_22_0 > 3 then
		return
	end

	self.cur_channel = self.cur_channel + var_22_0

	self:dispatcherEvent("MAINICON_MOVE", {
		channel = self.cur_channel
	})
end

function var_0_1:checkGameEnd()
	if self.hp_score < 0 then
		self:gameEnd()
	end
end

function var_0_1:gameEnd()
	self:unloop()
	self:dispatcherEvent("GAME_END", {
		distance_score = self.distance_score / 100,
		hp_score = self.hp_score
	})
	self:resetData()
end

function var_0_1:createMainLoop()
	self.mainloop = self.mainloop or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_26_0)
		self:gameUpdate(arg_26_0)
	end, 0, false)
end

function var_0_1:unloop()
	if self.mainloop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.mainloop)

		self.mainloop = nil
	end
end

return var_0_1
