local MonopolyMoveManager = class("MonopolyMoveManager", (require("controller.base_manager")))

MonopolyMoveManager.MULTITON_MSG = "MonopolyMoveManager instancealready constructed!"

function MonopolyMoveManager:ctor()
	MonopolyMoveManager.super.ctor(self)

	self._data = {}
end

function MonopolyMoveManager:requestInfo(arg_2_1)
	return
end

function MonopolyMoveManager:handlerInfo(arg_3_1)
	return
end

function MonopolyMoveManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyMoveManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function MonopolyMoveManager:getMoveInfo()
	return (require("controller.monopoly.monopoly_map_manager"):getInstance():getMoveInfo())
end

function MonopolyMoveManager:getMapSize()
	return (require("controller.monopoly.monopoly_map_manager"):getInstance():getMapSize())
end

function MonopolyMoveManager:getGridSize()
	return (require("controller.monopoly.monopoly_map_manager"):getInstance():getGridSize())
end

function MonopolyMoveManager:getNum()
	return (require("controller.monopoly.monopoly_map_manager"):getInstance():getNum())
end

function MonopolyMoveManager:getGridDistanceX()
	return (require("controller.monopoly.monopoly_map_manager"):getInstance():getGridDistanceX())
end

function MonopolyMoveManager:getPlayerPos()
	local var_11_0 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_11_1 = var_11_0:getPlayerPos()
	local var_11_2 = var_11_0:getLevel()
	local var_11_3 = require("controller.monopoly.monopoly_map_manager"):getInstance():getMapData()

	for iter_11_0 = 1, #var_11_3 do
		for iter_11_1 = 1, #var_11_3[iter_11_0] do
			if var_11_3[iter_11_0][iter_11_1].value == var_11_1 then
				return {
					x = var_11_3[iter_11_0][iter_11_1].pos.x,
					y = var_11_3[iter_11_0][iter_11_1].pos.y
				}
			end
		end
	end

	return cc.p(1, 1)
end

function MonopolyMoveManager:getAiPos()
	local var_12_0 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_12_1 = var_12_0:getAiPos()
	local var_12_2 = var_12_0:getLevel()
	local var_12_3 = require("controller.monopoly.monopoly_map_manager"):getInstance():getMapData()

	for iter_12_0 = 1, #var_12_3 do
		for iter_12_1 = 1, #var_12_3[iter_12_0] do
			if var_12_3[iter_12_0][iter_12_1].value == var_12_1 then
				return {
					x = var_12_3[iter_12_0][iter_12_1].pos.x,
					y = var_12_3[iter_12_0][iter_12_1].pos.y
				}
			end
		end
	end

	return cc.p(1, 1)
end

function MonopolyMoveManager:eventMove(arg_13_1)
	if self.layer then
		self.layer:eventMove(arg_13_1)
	end
end

function MonopolyMoveManager:eventBuffMove(arg_14_1)
	if self.layer then
		self.layer:eventBuffMove(arg_14_1)
	end
end

function MonopolyMoveManager:getPlayerModelId()
	local var_15_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	return var_15_0:getLevelConfigByLevel(var_15_0:getLevel()).model
end

function MonopolyMoveManager:getPlayerModelScale()
	local var_16_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	return var_16_0:getLevelConfigByLevel(var_16_0:getLevel()).model_scale or 1
end

function MonopolyMoveManager:getAIModelId()
	local var_17_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	return var_17_0:getLevelConfigByLevel(var_17_0:getLevel()).enemy_model
end

function MonopolyMoveManager:getAIModelScale()
	local var_18_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	return var_18_0:getLevelConfigByLevel(var_18_0:getLevel()).enemy_model_scale or 1
end

return MonopolyMoveManager
