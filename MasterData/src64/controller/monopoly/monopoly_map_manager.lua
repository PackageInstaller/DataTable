local MonopolyMapManager = class("MonopolyMapManager", (require("controller.base_manager")))

MonopolyMapManager.MULTITON_MSG = "MonopolyMapManager instancealready constructed!"

local var_0_1 = string.format

MonopolyMapManager.GridType = {
	HignSandOccupyPlayer = 302,
	Sand = 2,
	SandOccupyPlayer = 202,
	Forward = 8,
	PlayerStartingPoint = 5,
	AiStartingPoint = 6,
	HignSand = 3,
	Lucky = 10,
	Fight = 7,
	SandOccupyAi = 201,
	NormalBuilding = 999,
	HighBuilding = 1000,
	HignSandOccupyAi = 301,
	Unlucky = 9,
	RandomEvent = 4,
	None = 1
}
MonopolyMapManager.BuildDir = {
	Down = 3,
	Up = 1,
	Right = 2,
	Left = 4
}
MonopolyMapManager.MoveDir = {
	Down = 3,
	Up = 1,
	Right = 2,
	Left = 4
}

local var_0_2 = tostring

function MonopolyMapManager:ctor()
	MonopolyMapManager.super.ctor(self)

	self._data = {
		num = 6
	}
	self._config = require("data.monopoly_map_data")
	self._monopolyTileData = {}

	for iter_1_0, iter_1_1 in pairs((require("data.monopoly_tile_conf_data"))) do
		self._monopolyTileData[iter_1_1.level_id] = self._monopolyTileData[iter_1_1.level_id] or {}
		self._monopolyTileData[iter_1_1.level_id][iter_1_1.tile_id] = iter_1_1
	end

	self._buildDir = require("data.monopoly_builddirection_data")

	self:resetMapData()
end

function MonopolyMapManager:resetMapData()
	self._mapData = {}

	local var_2_0 = {}

	for iter_2_0 = 1, self._data.num + 2 do
		self._mapData[iter_2_0] = {}

		for iter_2_1 = 1, self._data.num do
			self._mapData[iter_2_0][iter_2_1] = {
				pos = cc.p(iter_2_0, iter_2_1)
			}

			if self._config[iter_2_1] and self._config[iter_2_1]["y" .. iter_2_0 - 1] then
				self._mapData[iter_2_0][iter_2_1].isNull = false
				self._mapData[iter_2_0][iter_2_1].isRoad = true
				self._mapData[iter_2_0][iter_2_1].value = self._config[iter_2_0 - 1]["y" .. iter_2_1]
				var_2_0[self._mapData[iter_2_0][iter_2_1].value] = cc.p(iter_2_0, iter_2_1)
			else
				self._mapData[iter_2_0][iter_2_1].isNull = true
			end
		end
	end

	self._valueMapPos = var_2_0

	for iter_2_2 = 1, #self._mapData do
		for iter_2_3 = 1, #self._mapData[iter_2_2] do
			if self._mapData[iter_2_2][iter_2_3].isRoad then
				local var_2_2 = var_2_0[(not self._buildDir[self._mapData[iter_2_2][iter_2_3].value + 1] or nil) and 1].y

				self._mapData[iter_2_2][iter_2_3].nextPos = cc.p(var_2_0[(not self._buildDir[self._mapData[iter_2_2][iter_2_3].value + 1] or nil) and 1].x, var_2_0[(not self._buildDir[self._mapData[iter_2_2][iter_2_3].value + 1] or nil) and 1].y)

				if self._mapData[iter_2_2][iter_2_3].pos.x == var_2_0[(not self._buildDir[self._mapData[iter_2_2][iter_2_3].value + 1] or nil) and 1].x then
					if self._mapData[iter_2_2][iter_2_3].pos.y - var_2_2 == 1 then
						self._mapData[iter_2_2][iter_2_3].moveDir = MonopolyMapManager.BuildDir.Left
					elseif self._mapData[iter_2_2][iter_2_3].pos.y - var_2_2 == -1 then
						self._mapData[iter_2_2][iter_2_3].moveDir = MonopolyMapManager.BuildDir.Right
					end
				elseif self._mapData[iter_2_2][iter_2_3].pos.y == var_2_2 then
					if self._mapData[iter_2_2][iter_2_3].pos.x - var_2_0[(not self._buildDir[self._mapData[iter_2_2][iter_2_3].value + 1] or nil) and 1].x == 1 then
						self._mapData[iter_2_2][iter_2_3].moveDir = MonopolyMapManager.BuildDir.Right
					elseif self._mapData[iter_2_2][iter_2_3].pos.x - var_2_0[(not self._buildDir[self._mapData[iter_2_2][iter_2_3].value + 1] or nil) and 1].x == -1 then
						self._mapData[iter_2_2][iter_2_3].moveDir = MonopolyMapManager.BuildDir.Left
					end
				end
			end
		end
	end
end

function MonopolyMapManager:requestInfo(arg_3_1)
	return
end

function MonopolyMapManager:handlerInfo(arg_4_1)
	return
end

function MonopolyMapManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyMapManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function MonopolyMapManager:getNum()
	return self._data.num
end

function MonopolyMapManager:initMapData()
	local var_8_0 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_8_1 = var_8_0:getLevel()
	local var_8_2 = self:getGridSize()
	local var_8_3 = self:getGridDistanceX()
	local var_8_4 = self:getMapSize()

	if self._monopolyTileData[var_8_1] then
		for iter_8_0, iter_8_1 in pairs(self._monopolyTileData[var_8_1]) do
			for iter_8_2, iter_8_3 in pairs(self._mapData) do
				local var_8_5 = false

				for iter_8_4, iter_8_5 in pairs(iter_8_3) do
					if iter_8_5.value == iter_8_1.tile_align then
						iter_8_5.picture = iter_8_1.picture
						iter_8_5.gridId = iter_8_1.tile_id

						local var_8_6 = iter_8_1.tile_type

						iter_8_5.gridType = iter_8_1.tile_type

						if var_8_6 == MonopolyMapManager.GridType.Sand or var_8_6 == MonopolyMapManager.GridType.HignSand then
							local var_8_7 = self._buildDir[iter_8_1.tile_align]

							if self._buildDir[iter_8_1.tile_align] and var_8_7.direction then
								local var_8_8
								local var_8_9
								local var_8_10

								if var_8_7.direction == MonopolyMapManager.BuildDir.Up then
									var_8_9 = iter_8_5.pos.x - 1
									var_8_10 = iter_8_5.pos.y
								elseif var_8_7.direction == MonopolyMapManager.BuildDir.Right then
									var_8_9 = iter_8_5.pos.x
									var_8_10 = iter_8_5.pos.y + 1
								elseif var_8_7.direction == MonopolyMapManager.BuildDir.Down then
									var_8_9 = iter_8_5.pos.x + 1
									var_8_10 = iter_8_5.pos.y
								elseif var_8_7.direction == MonopolyMapManager.BuildDir.Left then
									var_8_9 = iter_8_5.pos.x
									var_8_10 = iter_8_5.pos.y - 1
								end

								if self._mapData[var_8_9] and self._mapData[var_8_9][var_8_10] then
									var_8_8 = self._mapData[var_8_9][var_8_10]
								end

								if var_8_8 then
									var_8_8.isNull = false
									var_8_8.isBuild = true

									if var_8_6 == MonopolyMapManager.GridType.Sand then
										var_8_8.gridType = MonopolyMapManager.GridType.NormalBuilding
									elseif var_8_6 == MonopolyMapManager.GridType.HignSand then
										var_8_8.gridType = MonopolyMapManager.GridType.HighBuilding
									end

									var_8_8.buildSlave = iter_8_5.pos
									iter_8_5.buildPos = cc.p(var_8_9, var_8_10)
								end
							end

							local var_8_11 = var_8_0:getGridInfo(iter_8_5.value)

							if var_8_11 then
								if var_8_11.belong == var_8_0.TILE_BELOBG.AI then
									if var_8_6 == MonopolyMapManager.GridType.Sand then
										iter_8_5.slave = MonopolyMapManager.GridType.SandOccupyAi
									elseif var_8_6 == MonopolyMapManager.GridType.HignSand then
										iter_8_5.slave = MonopolyMapManager.GridType.HignSandOccupyAi
									end
								elseif var_8_11.belong == var_8_0.TILE_BELOBG.PLAYER then
									if var_8_6 == MonopolyMapManager.GridType.Sand then
										iter_8_5.slave = MonopolyMapManager.GridType.SandOccupyPlayer
									elseif var_8_6 == MonopolyMapManager.GridType.HignSand then
										iter_8_5.slave = MonopolyMapManager.GridType.HignSandOccupyPlayer
									end
								end
							end
						end

						iter_8_5.movePos = cc.p(var_8_2.width / 2 + (iter_8_5.pos.y - 1) * (var_8_2.width + var_8_3), var_8_4.height - var_8_2.height / 2 - (iter_8_5.pos.x - 1) * (var_8_2.height + var_8_3))
						var_8_5 = true
					end
				end

				if var_8_5 then
					break
				end
			end
		end
	end
end

function MonopolyMapManager:getMapShowInfo()
	local var_9_0 = "Monopoly_" .. require("controller.monopoly.monopoly_manager"):getInstance():getActivityId() .. "/MonopolyMapLayer/"
	local var_9_1 = {}

	for iter_9_0 = 1, #self._mapData do
		var_9_1[iter_9_0] = {}

		for iter_9_1 = 1, #self._mapData[iter_9_0] do
			local var_9_2 = self._mapData[iter_9_0][iter_9_1]

			var_9_1[iter_9_0][iter_9_1] = {
				isNull = self._mapData[iter_9_0][iter_9_1].isNull,
				value = self._mapData[iter_9_0][iter_9_1].value
			}

			if not self._mapData[iter_9_0][iter_9_1].isNull then
				if var_9_2.gridType then
					var_9_1[iter_9_0][iter_9_1].bg = var_9_0 .. "bg_type_" .. ((var_9_2.slave or nil) and var_9_2.slave) .. ".png"
					var_9_1[iter_9_0][iter_9_1].gridType = var_9_2.gridType
				end

				if var_9_2.gridType ~= MonopolyMapManager.GridType.NormalBuilding then
					if var_9_2.gridType == MonopolyMapManager.GridType.HighBuilding then
						local var_9_4 = self:getBuildLevel(self._mapData[var_9_2.buildSlave.x][var_9_2.buildSlave.y].value)

						if var_9_4 then
							if var_9_2.gridType == MonopolyMapManager.GridType.NormalBuilding then
								var_9_1[iter_9_0][iter_9_1].buildImgPath = var_9_0 .. "sand_" .. var_9_4 .. ".png"
							elseif var_9_2.gridType == MonopolyMapManager.GridType.HighBuilding then
								var_9_1[iter_9_0][iter_9_1].buildImgPath = var_9_0 .. "high_sand_" .. var_9_4 .. ".png"
							end
						end
					end

					if MonopolyMapManager.GridType.RandomEvent == var_9_2.gridType and var_9_2.picture then
						var_9_1[iter_9_0][iter_9_1].bg = var_9_0 .. var_9_2.picture .. ".png"
					elseif MonopolyMapManager.GridType.Forward == var_9_2.gridType and var_9_2.picture then
						var_9_1[iter_9_0][iter_9_1].bg = var_9_0 .. var_9_2.picture .. ".png"
					end
				end
			end
		end
	end

	return var_9_1
end

function MonopolyMapManager:getGridSize()
	local var_10_0 = self:getGridDistanceX()
	local var_10_1 = self:getNum()
	local var_10_2 = ((GameDisplay.getUiScreenSize().width - 55 - var_10_0 * (var_10_1 - 1)) / var_10_1 - 4) * (var_10_1 + 2) + var_10_0 * (var_10_1 - 1)

	return (cc.size((GameDisplay.getUiScreenSize().width - 55 - var_10_0 * (var_10_1 - 1)) / var_10_1, (GameDisplay.getUiScreenSize().width - 55 - var_10_0 * (var_10_1 - 1)) / var_10_1 - 4))
end

function MonopolyMapManager:getMapSize()
	local var_11_0 = GameDisplay.getUiScreenSize().width - 55
	local var_11_1 = self:getGridDistanceX()
	local var_11_2 = self:getNum()

	return (cc.size(var_11_0, ((var_11_0 - var_11_1 * (var_11_2 - 1)) / var_11_2 - 4) * (var_11_2 + 2) + var_11_1 * (var_11_2 - 1)))
end

function MonopolyMapManager:getGridDistanceX()
	return 3
end

function MonopolyMapManager:getMoveInfo()
	return self._mapData
end

function MonopolyMapManager:getMapData()
	return self._mapData
end

function MonopolyMapManager:getPosByValue(arg_15_1)
	return self._valueMapPos[arg_15_1]
end

function MonopolyMapManager:levelUpTile(arg_16_1)
	local playermodel = require("model.playermodel")
	local var_16_1 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_16_2 = "Monopoly_" .. var_16_1:getActivityId() .. "/MonopolyMapLayer/"

	var_16_1:setGridBuildLevel(arg_16_1.data.tile_pos, arg_16_1.data.tile_lv, (arg_16_1.data.target == var_16_1.EVENTS_TARGET_TYPE.AI or nil) and var_16_1.TILE_BELOBG.AI)

	if arg_16_1.data.target == var_16_1.EVENTS_TARGET_TYPE.AI then
		if arg_16_1.data.ai_money then
			var_16_1:setAIMoney(arg_16_1.data.ai_money)
		end
	elseif arg_16_1.data.target == var_16_1.EVENTS_TARGET_TYPE.PLAYER then
		if arg_16_1.data.cost_gold then
			var_16_1:setPlayerGold(arg_16_1.data.player_gold)
		end

		if arg_16_1.data.cost_diamond then
			playermodel.diamond = playermodel.diamond - arg_16_1.data.cost_diamond
		end
	end

	local var_16_4 = {}
	local var_16_5 = self:getMapData()
	local var_16_6 = self:getPosByValue(arg_16_1.data.tile_pos)
	local var_16_7 = var_16_5[var_16_6.x][var_16_6.y]

	if arg_16_1.data.target == var_16_1.EVENTS_TARGET_TYPE.AI then
		if var_16_7.gridType == MonopolyMapManager.GridType.Sand then
			var_16_7.slave = MonopolyMapManager.GridType.SandOccupyAi
		elseif var_16_7.gridType == MonopolyMapManager.GridType.HignSand then
			var_16_7.slave = MonopolyMapManager.GridType.HignSandOccupyAi
		end
	elseif arg_16_1.data.target == var_16_1.EVENTS_TARGET_TYPE.PLAYER then
		if var_16_7.gridType == MonopolyMapManager.GridType.Sand then
			var_16_7.slave = MonopolyMapManager.GridType.SandOccupyPlayer
		elseif var_16_7.gridType == MonopolyMapManager.GridType.HignSand then
			var_16_7.slave = MonopolyMapManager.GridType.HignSandOccupyPlayer
		end
	end

	local var_16_9 = clone(var_16_7)

	var_16_9.bg = var_16_2 .. "bg_type_" .. var_16_9.slave .. ".png"
	var_16_4[#var_16_4 + 1] = var_16_9

	local var_16_10 = clone(var_16_5[var_16_7.buildPos.x][var_16_7.buildPos.y])
	local var_16_11 = 1
	local var_16_12 = var_16_1:getGridInfo(var_16_9.value)

	if var_16_12 then
		var_16_11 = var_16_12.lv
	end

	if var_16_10.gridType == MonopolyMapManager.GridType.NormalBuilding then
		var_16_10.buildImgPath = var_16_2 .. "sand_" .. var_16_11 .. ".png"
	elseif var_16_10.gridType == MonopolyMapManager.GridType.HighBuilding then
		var_16_10.buildImgPath = var_16_2 .. "high_sand_" .. var_16_11 .. ".png"
	end

	var_16_4[#var_16_4 + 1] = var_16_10

	if self.layer then
		self.layer:levelUpTile(var_16_4, arg_16_1)
	end
end

function MonopolyMapManager:levelDownTile(arg_17_1)
	local var_17_0 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_17_1 = "Monopoly_" .. var_17_0:getActivityId() .. "/MonopolyMapLayer/"

	var_17_0:setGridBuildLevel(arg_17_1.data.tile_pos, arg_17_1.data.tile_lv, (arg_17_1.data.target == var_17_0.EVENTS_TARGET_TYPE.AI or nil) and var_17_0.TILE_BELOBG.AI)

	local var_17_3 = {}
	local var_17_4 = self:getMapData()
	local var_17_5 = self:getPosByValue(arg_17_1.data.tile_pos)
	local var_17_6 = var_17_4[var_17_5.x][var_17_5.y]
	local var_17_7 = arg_17_1.data.tile_lv

	if arg_17_1.data.target == var_17_0.EVENTS_TARGET_TYPE.AI then
		if var_17_6.gridType == MonopolyMapManager.GridType.Sand then
			var_17_6.slave = MonopolyMapManager.GridType.SandOccupyAi
		elseif var_17_6.gridType == MonopolyMapManager.GridType.HignSand then
			var_17_6.slave = MonopolyMapManager.GridType.HignSandOccupyAi
		end
	elseif arg_17_1.data.target == var_17_0.EVENTS_TARGET_TYPE.PLAYER then
		if var_17_6.gridType == MonopolyMapManager.GridType.Sand then
			var_17_6.slave = MonopolyMapManager.GridType.SandOccupyPlayer
		elseif var_17_6.gridType == MonopolyMapManager.GridType.HignSand then
			var_17_6.slave = MonopolyMapManager.GridType.HignSandOccupyPlayer
		end
	end

	local var_17_8 = clone(var_17_6)

	var_17_8.bg = var_17_1 .. "bg_type_" .. var_17_8.slave .. ".png"
	var_17_3[#var_17_3 + 1] = var_17_8

	local var_17_9 = clone(var_17_4[var_17_6.buildPos.x][var_17_6.buildPos.y])

	if var_17_9.gridType == MonopolyMapManager.GridType.NormalBuilding then
		var_17_9.buildImgPath = var_17_1 .. "sand_" .. var_17_7 .. ".png"
	elseif var_17_9.gridType == MonopolyMapManager.GridType.HighBuilding then
		var_17_9.buildImgPath = var_17_1 .. "high_sand_" .. var_17_7 .. ".png"
	end

	var_17_3[#var_17_3 + 1] = var_17_9

	if self.layer then
		self.layer:levelDownTile(var_17_3, arg_17_1)
	end
end

function MonopolyMapManager:getBuildLevel(arg_18_1)
	return (require("controller/monopoly/monopoly_manager"):getInstance():getBuildLevel(arg_18_1))
end

function MonopolyMapManager:getLevelState()
	return (require("controller.monopoly.monopoly_manager"):getInstance():getLevelState())
end

function MonopolyMapManager:playerWinEvent(arg_20_1)
	if self.layer then
		self.layer:playerWinEvent(arg_20_1)
	end
end

function MonopolyMapManager:isLastLevel()
	return require("controller.monopoly.monopoly_manager"):getInstance():isLastLevel()
end

function MonopolyMapManager:getRewardInfo()
	return (require("controller.monopoly.monopoly_player_win_manager"):getInstance():getRewardInfo())
end

function MonopolyMapManager:intoNextLevel()
	self:resetMapData()
	self:initMapData()
end

function MonopolyMapManager:lookBuildInfo(arg_24_1, arg_24_2)
	local var_24_0 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_24_1 = require("controller.monopoly.monopoly_sandcastle_manager"):getInstance()
	local var_24_2 = require("controller.monopoly.monopoly_buff_manager"):getInstance()
	local var_24_3 = "Monopoly_" .. var_24_0:getActivityId() .. "/MonopolyBuildInfoLayer/"

	local function var_24_4(arg_25_0)
		local var_25_0 = var_24_0:getGridInfo(self._mapData[arg_25_0.buildSlave.x][arg_25_0.buildSlave.y].value)

		if var_25_0 then
			return clone(var_25_0)
		else
			return nil
		end
	end

	local var_24_5 = var_24_0:getBuffs()

	if self._mapData[arg_24_1][arg_24_2].gridType == MonopolyMapManager.GridType.NormalBuilding then
		print(L_MONOPOLY[32])

		local var_24_6 = var_24_4(self._mapData[arg_24_1][arg_24_2])

		if var_24_6 then
			local var_24_7 = var_24_0:getLevelConfigByLevel(var_24_0:getLevel())

			var_24_6.name = var_24_6.lv .. L_MONOPOLY[33]
			var_24_6.imgPath = var_24_3 .. var_0_1("sand_%d.png", var_24_6.lv)
			var_24_6.currencyPath = "public/currency/UI_battleEnd_gold.png"
			var_24_6.incomePath = "public/currency/UI_battleEnd_gold.png"
			var_24_6.income = var_24_7["build_income_" .. var_24_6.lv]

			local var_24_8 = var_24_6.pos

			var_24_6.costNum = var_24_1:isMaxLevel(var_24_6.pos) and L_MONOPOLY[34] or var_24_7["up_money_" .. var_24_6.lv + 1]

			if var_24_6.belong == var_24_0.TILE_BELOBG.PLAYER then
				local var_24_9 = 0
				local var_24_10 = 0

				for iter_24_0 = 1, #var_24_5 do
					local var_24_11 = var_24_2:getConfigById((var_0_2(var_24_5[iter_24_0].id)))

					if not var_24_1:isMaxLevel(var_24_8) and var_24_11.type == var_24_2.BUFF_VALUE_TYPE.BUILD_COST_GOLD then
						if var_24_11.buff_or_debuff == var_24_2.BUFF_TYPE.BUFF then
							var_24_9 = var_24_9 - tonumber(var_24_11.param1)
						elseif var_24_11.buff_or_debuff == var_24_2.BUFF_TYPE.DEBUFF then
							var_24_9 = var_24_9 + tonumber(var_24_11.param1)
						end
					end

					if var_24_11.type == var_24_2.BUFF_VALUE_TYPE.BUILD_INCOME then
						if var_24_11.buff_or_debuff == var_24_2.BUFF_TYPE.BUFF then
							var_24_10 = var_24_10 + tonumber(var_24_11.param1)
						elseif var_24_11.buff_or_debuff == var_24_2.BUFF_TYPE.DEBUFF then
							var_24_10 = var_24_10 - tonumber(var_24_11.param1)
						end
					end
				end

				if var_24_9 ~= 0 then
					if var_24_9 > 0 then
						var_24_6.costState = var_24_1.COST_STATE.UP
						var_24_6.costTextColor = "ff0000"
					else
						var_24_6.costState = var_24_1.COST_STATE.DOWN
						var_24_6.costTextColor = "00ff00"
					end

					var_24_6.costNum = var_24_6.costNum * (1 + var_24_9)
				end

				if var_24_10 ~= 0 then
					if var_24_10 > 0 then
						var_24_6.incomeState = var_24_1.INCOME_STATE.UP
						var_24_6.incomeTextColor = "00ff00"
					else
						var_24_6.incomeState = var_24_1.INCOME_STATE.DOWN
						var_24_6.incomeTextColor = "ff0000"
					end

					var_24_6.income = var_24_6.income * (1 + var_24_10)
				end
			end

			LayerManager:pushInLayer("MonopolyBuildInfoLayer", var_24_6)
		end
	elseif self._mapData[arg_24_1][arg_24_2].gridType == MonopolyMapManager.GridType.HighBuilding then
		print(L_MONOPOLY[35])

		local var_24_12 = var_24_4(self._mapData[arg_24_1][arg_24_2])

		if var_24_12 then
			local var_24_13 = var_24_0:getLevelConfigByLevel(var_24_0:getLevel())

			var_24_12.name = L_MONOPOLY[36] .. var_24_12.lv .. L_MONOPOLY[33]
			var_24_12.imgPath = var_24_3 .. var_0_1("high_sand_%d.png", var_24_12.lv)
			var_24_12.currencyPath = "public/currency/UI_battleEnd_diamond.png"
			var_24_12.incomePath = "public/currency/UI_battleEnd_gold.png"
			var_24_12.income = var_24_13["highbuild_income_" .. var_24_12.lv]
			var_24_12.costNum = var_24_1:isMaxLevel(var_24_12.pos) and L_MONOPOLY[34] or var_24_13["highup_money_" .. var_24_12.lv + 1]

			if var_24_12.belong == var_24_0.TILE_BELOBG.PLAYER then
				local var_24_14 = 0

				for iter_24_1 = 1, #var_24_5 do
					local var_24_15 = var_24_2:getConfigById((var_0_2(var_24_5[iter_24_1].id)))

					if var_24_15.type == var_24_2.BUFF_VALUE_TYPE.BUILD_INCOME then
						if var_24_15.buff_or_debuff == var_24_2.BUFF_TYPE.BUFF then
							var_24_14 = var_24_14 + tonumber(var_24_15.param1)
						elseif var_24_15.buff_or_debuff == var_24_2.BUFF_TYPE.DEBUFF then
							var_24_14 = var_24_14 - tonumber(var_24_15.param1)
						end
					end
				end

				if var_24_14 ~= 0 then
					if var_24_14 > 0 then
						var_24_12.incomeState = var_24_1.INCOME_STATE.UP
						var_24_12.incomeTextColor = "00ff00"
					else
						var_24_12.incomeState = var_24_1.INCOME_STATE.DOWN
						var_24_12.incomeTextColor = "ff0000"
					end

					var_24_12.income = var_24_12.income * (1 + var_24_14)
				end
			end

			LayerManager:pushInLayer("MonopolyBuildInfoLayer", var_24_12)
		end
	end
end

function MonopolyMapManager:getBuildImgScale()
	local var_26_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	return var_26_0:getLevelConfigByLevel(var_26_0:getLevel()).house_scale or 0.7
end

return MonopolyMapManager
