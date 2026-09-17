local audio_manager = require("controller.audio_manager")
local var_0_1 = {}
local var_0_2 = {
	fall_freeze_scale = 0.5,
	player_move_speed = 200,
	game_time = 60,
	move_freeze_scale = 0.5,
	init_height = 950,
	gift_conf = {
		{
			score = 1,
			fall_speed_max = 200,
			fall_speed_min = 150,
			random = 0.7
		},
		{
			score = 3,
			fall_speed_max = 200,
			fall_speed_min = 150,
			random = 0.1
		},
		{
			score = 1,
			fall_speed_max = 200,
			fall_speed_min = 150,
			random = 0.1,
			freeze_time = 3
		},
		{
			score = 1,
			fall_speed_max = 200,
			fall_speed_min = 150,
			random = 0.1,
			freeze_time = 3
		}
	},
	stage_conf = {
		{
			time = 0,
			gift_spawn_time = 1.2,
			speed_scale = 1
		},
		{
			time = 20,
			gift_spawn_time = 0.9,
			speed_scale = 1.2
		},
		{
			time = 40,
			gift_spawn_time = 0.6,
			speed_scale = 1.5
		}
	}
}
local var_0_5 = 3
local var_0_6 = 4
local var_0_7 = 130
local var_0_8 = 30
local var_0_9 = 90
local var_0_10 = 50
local var_0_11 = 590

function var_0_1.resetData(arg_1_0)
	arg_1_0.score = 0
	arg_1_0.game_time = 0
	arg_1_0.time = 0
	arg_1_0.stage = 0
	arg_1_0.spawntime = 0
	arg_1_0.fall_freeze_time = 0
	arg_1_0.move_freeze_time = 0
	arg_1_0.player_posX = 0
	arg_1_0.targetX = 0
	arg_1_0.gifts = {}
end

function var_0_1.initData(arg_2_0)
	arg_2_0.score = 0
	arg_2_0.game_time = var_0_2.game_time
	arg_2_0.time = 0
	arg_2_0.stage = 1
	arg_2_0.spawntime = 0
	arg_2_0.fall_freeze_time = 0
	arg_2_0.move_freeze_time = 0
	arg_2_0.player_posX = 320
	arg_2_0.targetX = 320
	arg_2_0.gifts = {}
end

function var_0_1.registerUIRef(arg_3_0, arg_3_1)
	arg_3_0.uiref = arg_3_1
end

function var_0_1.unregisterUIRef(arg_4_0)
	arg_4_0.uiref = nil
end

function var_0_1:exitGame()
	self:unloop()
	self:resetData()
	self:unregisterUIRef()

	self.gameEvents = {}
end

function var_0_1:registerGameEvent(arg_6_1, arg_6_2, arg_6_3)
	self.gameEvents = self.gameEvents or {}
	self.gameEvents[arg_6_1] = self.gameEvents[arg_6_1] or {}

	table.insert(self.gameEvents[arg_6_1], {
		obj = arg_6_2,
		handler = arg_6_3
	})
end

function var_0_1:unregisterGameEvent(arg_7_1, arg_7_2)
	if self.gameEvents[arg_7_1] then
		for iter_7_0, iter_7_1 in pairs(self.gameEvents[arg_7_1]) do
			if iter_7_1.handler == arg_7_2 then
				table.remove(self.gameEvents[arg_7_1], iter_7_1)
			end
		end
	end
end

function var_0_1:dispatcherEvent(arg_8_1, ...)
	if self.gameEvents[arg_8_1] then
		for iter_8_0, iter_8_1 in pairs(self.gameEvents[arg_8_1]) do
			iter_8_1.handler(iter_8_1.obj, ...)
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

function var_0_1:gameUpdate(arg_10_1)
	if not self.mainloop then
		return
	end

	if self.gamePaused then
		return
	end

	self.time = self.time + arg_10_1

	if self.time > self.game_time then
		self:gameEnd()

		return
	end

	if var_0_2.stage_conf[self.stage + 1] and self.time > var_0_2.stage_conf[self.stage + 1].time then
		self.stage = self.stage + 1
	end

	if self.spawntime > var_0_2.stage_conf[self.stage].gift_spawn_time then
		self:spawnGift()

		self.spawntime = 0
	else
		self.spawntime = self.spawntime + arg_10_1
	end

	if self.fall_freeze_time > 0 then
		self.fall_freeze_time = math.max(self.fall_freeze_time - arg_10_1, 0)
	end

	if self.move_freeze_time > 0 then
		self.move_freeze_time = math.max(self.move_freeze_time - arg_10_1, 0)
	end

	if self.fall_freeze_time <= 0 or not var_0_2.fall_freeze_scale then
		-- block empty
	end

	if self.move_freeze_time > 0 then
		local var_10_1 = var_0_2.move_freeze_scale or 1

		if self.targetX ~= self.player_posX then
			self.player_posX = math.abs(self.player_posX - self.targetX) < var_0_2.player_move_speed * arg_10_1 * var_10_1 and self.targetX or self.player_posX - (self.player_posX - self.targetX) / math.abs(self.player_posX - self.targetX) * var_0_2.player_move_speed * arg_10_1 * var_10_1
		end
	end

	self:checkGift(arg_10_1)
	self:dispatcherEvent("UPDATE_GAMEDATA", {
		score = self.score,
		time = math.max(self.game_time - self.time, 0),
		player_posX = self.player_posX
	})
end

function var_0_1:spawnGift()
	local var_11_0 = {}
	local var_11_1 = 0

	for iter_11_0, iter_11_1 in ipairs(var_0_2.gift_conf) do
		var_11_1 = var_11_1 + iter_11_1.random

		table.insert(var_11_0, var_11_1)
	end

	local var_11_2 = math.random()
	local var_11_3

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		if var_11_2 <= iter_11_3 then
			var_11_3 = iter_11_2

			break
		end
	end

	local var_11_4 = {
		posX = math.random(var_0_10, var_0_11),
		posY = var_0_2.init_height,
		type = var_11_3,
		score = var_0_2.gift_conf[var_11_3].score,
		speed = math.random(var_0_2.gift_conf[var_11_3].fall_speed_min, var_0_2.gift_conf[var_11_3].fall_speed_max)
	}

	var_11_4.freeze_time = var_0_2.gift_conf[var_11_3].freeze_time

	self:dispatcherEvent("ADD_GIFT", var_11_4)
	table.insert(self.gifts, var_11_4)
end

function var_0_1:checkGift(arg_12_1)
	local var_12_0 = var_0_2.stage_conf[self.stage]

	for iter_12_0, iter_12_1 in pairs(self.gifts) do
		iter_12_1.posY = iter_12_1.posY - iter_12_1.speed * arg_12_1 * var_12_0.speed_scale * ((self.fall_freeze_time > 0 or nil) and (var_0_2.fall_freeze_scale or 1))

		if iter_12_1.node then
			iter_12_1.node:setPositionY(iter_12_1.posY)
		end

		if math.abs(iter_12_1.posY - var_0_7) < var_0_8 and math.abs(iter_12_1.posX - self.player_posX) < var_0_9 then
			local var_12_1 = iter_12_1

			self.gifts[iter_12_0] = nil
			self.score = self.score + var_12_1.score

			if var_12_1.type == var_0_5 then
				self.fall_freeze_time = self.fall_freeze_time + var_12_1.freeze_time
			elseif var_12_1.type == var_0_6 then
				self.move_freeze_time = self.move_freeze_time + var_12_1.freeze_time
			end

			self:dispatcherEvent("DELETE_GIFT", var_12_1)
		end
	end
end

function var_0_1:TouchMove(arg_13_1)
	if not self.mainloop then
		return
	end

	self.targetX = arg_13_1
end

function var_0_1:TouchMoveEnd()
	if not self.mainloop then
		return
	end

	self.targetX = self.player_posX
end

function var_0_1:checkGameEnd()
	if self.hp_score < 0 then
		self:gameEnd()
	end
end

function var_0_1:gameEnd()
	self:unloop()
	self:dispatcherEvent("GAME_END", {
		score = self.score
	})
	self:resetData()
end

function var_0_1:createMainLoop()
	self.mainloop = self.mainloop or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_18_0)
		self:gameUpdate(arg_18_0)
	end, 0, false)
end

function var_0_1:unloop()
	if self.mainloop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.mainloop)

		self.mainloop = nil
	end
end

return var_0_1
