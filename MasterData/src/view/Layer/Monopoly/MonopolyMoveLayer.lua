local MonopolyMoveLayer = class("MonopolyMoveLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = require("controller.monopoly.monopoly_manager"):getInstance()
local TempWidget = require("view.Sprite.TempWidget")
local var_0_4
local var_0_5 = -20

function MonopolyMoveLayer:ctor()
	var_0_4 = "Monopoly_" .. var_0_1:getActivityId() .. "/MonopolyNewLayer/"

	MonopolyMoveLayer.super.ctor(self)

	self.manager = require("controller/monopoly/monopoly_move_manager"):getInstance()
end

function MonopolyMoveLayer:create(arg_2_1)
	local var_2_0 = MonopolyMoveLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyMoveLayer:onEnter()
	MonopolyMoveLayer.super.onEnter(self)
end

function MonopolyMoveLayer:onExit()
	MonopolyMoveLayer.super.onExit(self)
end

function MonopolyMoveLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function MonopolyMoveLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempLayout(self)

	var_6_1:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_1

	local var_6_2 = self.manager:getMapSize()
	local var_6_3 = self.manager:getGridSize()
	local var_6_4 = self.manager:getNum()
	local var_6_7 = self.manager:getGridDistanceX()
	local var_6_8 = TempWidget:CreateTempLayout(var_6_1)

	var_6_8:setContentSize(cc.size(var_6_2.width, var_6_2.height))
	var_6_8:align(cc.p(0.5, 0.5), var_6_1:size().w / 2, var_6_1:size().h / 2 - 120)

	self._moveLayout = var_6_8
end

function MonopolyMoveLayer:initListener()
	return
end

function MonopolyMoveLayer:initPlayerSpine()
	if self._playerSpine then
		self._playerSpine:resetL2Skeleton("spine/test/" .. self.manager:getPlayerModelId() .. ".json", "spine/test/" .. self.manager:getPlayerModelId() .. ".atlas")
		self._playerSpine:refreshSkeleton()
		self._playerSpine:play("idle", true)
		self._playerSpineIntoLayout:setScale(self.manager:getPlayerModelScale())

		return
	end

	local var_8_0 = TempWidget:CreateTempLayout(self._moveLayout)

	var_8_0:setContentSize((self.manager:getGridSize()))
	var_8_0:setAnchorPoint(cc.p(0.5, 0.5))

	self._playerSpineLayout = var_8_0

	local var_8_1 = TempWidget:CreateTempLayout(var_8_0)

	var_8_1:setContentSize(var_8_0:size())
	var_8_1:align(cc.p(0.5, 0.5), var_8_0:size().w / 2, var_8_0:size().h / 2 + GameDisplay.fix_y)
	var_8_1:setScale(self.manager:getPlayerModelScale())

	self._playerSpineIntoLayout = var_8_1

	local var_8_2 = L2Skeleton:create("spine/test/" .. self.manager:getPlayerModelId() .. ".json", "spine/test/" .. self.manager:getPlayerModelId() .. ".atlas")

	var_8_2:refreshSkeleton()
	var_8_2:play("idle", true)
	var_8_2:setVisible(false)
	var_8_2:registerListener(SP_ANIMATION_COMPLETE, function(arg_9_0)
		return
	end)
	var_8_2:setPosition(cc.p(var_8_1:size().w / 2, var_8_1:size().h / 2))
	var_8_1:addChild(var_8_2)

	self._playerSpine = var_8_2

	local var_8_3 = TempWidget:CreateTempImg(var_0_4 .. "role_arrows.png", var_8_0)

	var_8_3:align(cc.p(0.5, 0), var_8_0:size().w / 2, var_8_0:size().h + 80 + GameDisplay.fix_y)
	var_8_3:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(1, cc.p(0, -10)), cc.MoveBy:create(1, cc.p(0, 10)))))
end

function MonopolyMoveLayer:initAISpine()
	if self._aiSpine then
		self._aiSpine:resetL2Skeleton("spine/test/" .. self.manager:getAIModelId() .. ".json", "spine/test/" .. self.manager:getAIModelId() .. ".atlas")
		self._aiSpine:refreshSkeleton()
		self._aiSpine:play("idle", true)
		self._aiSpineIntoLayout:setScale(self.manager:getAIModelScale())

		return
	end

	local var_10_0 = TempWidget:CreateTempLayout(self._moveLayout)

	var_10_0:setContentSize((self.manager:getGridSize()))
	var_10_0:setAnchorPoint(cc.p(0.5, 0.5))

	self._aiSpineLayout = var_10_0

	local var_10_1 = TempWidget:CreateTempLayout(var_10_0)

	var_10_1:setContentSize(var_10_0:size())
	var_10_1:align(cc.p(0.5, 0.5), var_10_0:size().w / 2, var_10_0:size().h / 2 + GameDisplay.fix_y)
	var_10_1:setScale(self.manager:getAIModelScale())

	self._aiSpineIntoLayout = var_10_1

	local var_10_2 = L2Skeleton:create("spine/test/" .. self.manager:getAIModelId() .. ".json", "spine/test/" .. self.manager:getAIModelId() .. ".atlas")

	var_10_2:refreshSkeleton()
	var_10_2:play("idle", true)
	var_10_2:setVisible(false)
	var_10_2:registerListener(SP_ANIMATION_COMPLETE, function(arg_11_0)
		return
	end)
	var_10_2:setPosition(cc.p(var_10_1:size().w / 2, var_10_1:size().h / 2))
	var_10_1:addChild(var_10_2)

	self._aiSpine = var_10_2
end

function MonopolyMoveLayer:updateLayer()
	return
end

function MonopolyMoveLayer:updateRed()
	return
end

function MonopolyMoveLayer:updateMoveLayout()
	self:initPlayerSpine()
	self:initAISpine()

	local var_14_0 = self.manager:getMoveInfo()
	local var_14_1 = self.manager:getPlayerPos()
	local var_14_2 = self._playerSpine

	self._playerSpineLayout:setPosition(var_14_0[var_14_1.x][var_14_1.y].movePos.x, var_14_0[var_14_1.x][var_14_1.y].movePos.y + var_0_5)
	self._playerSpine:setVisible(true)

	self._playerSpine._value = var_14_0[var_14_1.x][var_14_1.y].value

	function self._playerSpine._updateDir()
		local var_15_0 = require("controller.monopoly.monopoly_map_manager"):getInstance()
		local var_15_1 = var_15_0:getPosByValue(var_14_2._value)

		if var_14_0[var_15_1.x][var_15_1.y].moveDir == var_15_0.MoveDir.Left then
			var_14_2:setScaleX(-1)
		elseif var_14_0[var_15_1.x][var_15_1.y].moveDir == var_15_0.MoveDir.Right then
			var_14_2:setScaleX(1)
		end
	end

	self._playerSpine._updateDir()

	local var_14_3 = self.manager:getAiPos()
	local var_14_4 = self._aiSpine

	self._aiSpineLayout:setPosition(var_14_0[var_14_3.x][var_14_3.y].movePos.x, var_14_0[var_14_3.x][var_14_3.y].movePos.y + var_0_5)
	self._aiSpine:setVisible(true)

	self._aiSpine._value = var_14_0[var_14_3.x][var_14_3.y].value

	function self._aiSpine._updateDir()
		local var_16_0 = require("controller.monopoly.monopoly_map_manager"):getInstance()
		local var_16_1 = var_16_0:getPosByValue(var_14_4._value)

		if var_14_0[var_16_1.x][var_16_1.y].moveDir == var_16_0.MoveDir.Left then
			var_14_4:setScaleX(-1)
		elseif var_14_0[var_16_1.x][var_16_1.y].moveDir == var_16_0.MoveDir.Right then
			var_14_4:setScaleX(1)
		end
	end

	self._aiSpine._updateDir()
end

function MonopolyMoveLayer:eventMove(arg_17_1)
	local var_17_0 = require("controller.monopoly.monopoly_map_manager"):getInstance()
	local var_17_1 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_17_2 = self.manager:getMoveInfo()
	local var_17_3 = self.manager:getPlayerPos()
	local var_17_4 = self._playerSpine
	local var_17_5 = self._playerSpineLayout

	if arg_17_1 and arg_17_1.data and arg_17_1.data.trigger == var_17_1.EVENTS_TARGET_TYPE.AI then
		var_17_3 = self.manager:getAiPos()
		var_17_4 = self._aiSpine
		var_17_5 = self._aiSpineLayout
	end

	local var_17_6 = 0.1

	local function var_17_8()
		if var_17_4._value ~= var_17_2[var_17_3.x][var_17_3.y].value then
			local var_18_0 = var_17_0:getPosByValue(var_17_4._value)
			local var_18_2 = var_17_2[var_17_2[var_18_0.x][var_18_0.y].nextPos.x][var_17_2[var_18_0.x][var_18_0.y].nextPos.y]

			var_17_5:stopAllActions()
			var_17_4:play("run", true)
			var_17_5:runAction(cc.Sequence:create(cc.MoveTo:create(var_17_6, cc.p(var_18_2.movePos.x, var_18_2.movePos.y + var_0_5)), cc.CallFunc:create(function()
				var_17_4._value = var_18_2.value

				var_17_4._updateDir()
				var_17_8()
			end)))
		else
			var_17_4:play("idle", true)
			var_17_5:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				var_17_1:handleEvents()
			end)))
		end
	end

	;(nil)()
end

function MonopolyMoveLayer:eventBuffMove(arg_21_1)
	local var_21_0 = require("controller.monopoly.monopoly_map_manager"):getInstance()
	local var_21_1 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_21_2 = self.manager:getMoveInfo()
	local var_21_3 = self.manager:getPlayerPos()
	local var_21_4 = self._playerSpine
	local var_21_5 = self._playerSpineLayout

	if arg_21_1 and arg_21_1.data and arg_21_1.data.trigger == var_21_1.EVENTS_TARGET_TYPE.AI then
		var_21_3 = self.manager:getAiPos()
		var_21_4 = self._aiSpine
		var_21_5 = self._aiSpineLayout
	end

	local var_21_6 = 0.1

	local function var_21_8()
		if var_21_4._value ~= var_21_2[var_21_3.x][var_21_3.y].value then
			local var_22_0 = var_21_0:getPosByValue(var_21_4._value)
			local var_22_2 = var_21_2[var_21_2[var_22_0.x][var_22_0.y].nextPos.x][var_21_2[var_22_0.x][var_22_0.y].nextPos.y]

			var_21_5:stopAllActions()
			var_21_4:play("run", true)
			var_21_5:runAction(cc.Sequence:create(cc.MoveTo:create(var_21_6, cc.p(var_22_2.movePos.x, var_22_2.movePos.y + var_0_5)), cc.CallFunc:create(function()
				var_21_4._value = var_22_2.value

				var_21_4._updateDir()
				var_21_8()
			end)))
		else
			var_21_4:play("idle", true)
			var_21_5:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				var_21_1:handleEvents()
			end)))
		end
	end

	;(nil)()
end

return MonopolyMoveLayer
