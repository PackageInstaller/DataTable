local MonopolyMapLayer = class("MonopolyMapLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = require("controller.monopoly.monopoly_manager"):getInstance()
local item_data = require("data.item_data")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5
local component_manager = require("controller.component_manager")
local MonopolyMoveLayer = require("view.Layer.Monopoly.MonopolyMoveLayer")
local texture_manager = require("controller.texture_manager")

function MonopolyMapLayer:ctor()
	var_0_5 = "Monopoly_" .. var_0_1:getActivityId() .. "/MonopolyMapLayer/"

	MonopolyMapLayer.super.ctor(self)

	self.manager = require("controller.monopoly.monopoly_map_manager"):getInstance()
end

function MonopolyMapLayer:create(arg_2_1)
	texture_manager:loadPopLayerTextures({
		"Monopoly_" .. arg_2_1.activityid .. "_MonopolyMapLayer"
	})

	local var_2_0 = MonopolyMapLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyMapLayer:onEnter()
	MonopolyMapLayer.super.onEnter(self)
end

function MonopolyMapLayer:onExit()
	MonopolyMapLayer.super.onExit(self)
end

function MonopolyMapLayer:init(arg_5_1)
	self.data = arg_5_1

	self:initLayer()
	self:initListener()

	return true
end

function MonopolyMapLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = self.manager:getMapSize()
	local var_6_2 = self.manager:getGridSize()
	local var_6_3 = self.manager:getNum()
	local var_6_4 = self.manager:getGridDistanceX()
	local var_6_5 = TempWidget:CreateTempLayout(var_6_0)

	var_6_5:setContentSize(cc.size(var_6_1.width, var_6_1.height))
	var_6_5:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2 - 120 + GameDisplay.fix_y)

	self._mapLayout = var_6_5

	local var_6_6 = {}

	for iter_6_0 = 1, var_6_3 + 2 do
		var_6_6[iter_6_0] = {}

		for iter_6_1 = 1, var_6_3 do
			local var_6_7 = TempWidget:CreateTempLayout(var_6_5)

			var_6_7:setContentSize(cc.size(var_6_2.width, var_6_2.height))
			var_6_7:align(cc.p(0.5, 0.5), var_6_2.width / 2 + (var_6_4 + var_6_2.width) * (iter_6_1 - 1), var_6_5:size().h - var_6_2.height / 2 - (var_6_4 + var_6_2.height) * (iter_6_0 - 1))

			var_6_6[iter_6_0][iter_6_1] = var_6_7

			var_6_7:_addEvent(function()
				self.manager:lookBuildInfo(iter_6_0, iter_6_1)
			end)

			local var_6_8 = TempWidget:CreateTempImg(nil, var_6_7)

			var_6_8:align(cc.p(0.5, 0.5), var_6_7:size().w / 2, var_6_7:size().h / 2)
			var_6_8:hide()
			var_6_8:setName("showBg")

			local var_6_9 = TempWidget:CreateTempImg(nil, var_6_7)

			var_6_9:align(cc.p(0.5, 0.5), var_6_7:size().w / 2, var_6_7:size().h / 2 + 10)
			var_6_9:hide()
			var_6_9:setName("buildImg")
		end
	end

	self._mapGridLayoutTable = var_6_6

	local var_6_10 = MonopolyMoveLayer:create()

	var_6_0:addChild(var_6_10)

	self._monopolyMoveLayer = var_6_10

	local var_6_11 = TempWidget:CreateTempImg(var_0_5 .. "reward_bg.png", var_6_0)

	var_6_11:align(cc.p(0.5, 0.5), var_6_5:pos().x, var_6_5:pos().y + 50)
	var_6_11:setLocalZOrder(var_6_5:getLocalZOrder() - 1)

	local var_6_12 = TempWidget:CreateTempLayout(var_6_11)

	var_6_12:setContentSize(cc.size(var_6_11:size().w - 50, 120))
	var_6_12:align(cc.p(0.5, 0.5), var_6_11:size().w / 2, var_6_11:size().h / 2 - 20)

	self._rewardLayout = var_6_12

	local var_6_13 = TempWidget:CreateTempImg(var_0_5 .. "reward_bottom_tips.png", var_6_11)

	var_6_13:align(cc.p(0.5, 1), var_6_11:size().w / 2, -20)

	self._stateImg = var_6_13
end

function MonopolyMapLayer:initListener()
	self._rewardLayout:_addEvent(function()
		LayerManager:pushInLayer("MonopolyRewardLayer")
	end)
end

function MonopolyMapLayer:updateLayer()
	return
end

function MonopolyMapLayer:updateMapLayout()
	local var_11_0 = self.manager:getMapShowInfo()

	for iter_11_0 = 1, #var_11_0 do
		for iter_11_1 = 1, #var_11_0[iter_11_0] do
			local var_11_1 = self._mapGridLayoutTable[iter_11_0][iter_11_1]:getChildByName("showBg")
			local var_11_2 = self._mapGridLayoutTable[iter_11_0][iter_11_1]:getChildByName("buildImg")

			var_11_2:setScale(self.manager:getBuildImgScale())

			if self._mapGridLayoutTable[iter_11_0][iter_11_1] then
				if var_11_0[iter_11_0][iter_11_1] and not var_11_0[iter_11_0][iter_11_1].isNull then
					self._mapGridLayoutTable[iter_11_0][iter_11_1]:show()
					var_11_1:loadTextureEx(var_11_0[iter_11_0][iter_11_1].bg)
					var_11_1:show()

					if var_11_0[iter_11_0][iter_11_1].buildImgPath then
						var_11_2:loadTextureEx(var_11_0[iter_11_0][iter_11_1].buildImgPath)
						var_11_2:show()
					else
						var_11_2:hide()
					end
				else
					self._mapGridLayoutTable[iter_11_0][iter_11_1]:hide()
				end
			end
		end
	end

	self._monopolyMoveLayer:updateMoveLayout()
	self:updateStateImg()
	self:updateReward()
end

function MonopolyMapLayer:updateRed()
	return
end

function MonopolyMapLayer:levelUpTile(arg_13_1, arg_13_2)
	local var_13_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	for iter_13_0 = 1, #arg_13_1 do
		local var_13_1 = arg_13_1[iter_13_0]
		local var_13_2 = self._mapGridLayoutTable[arg_13_1[iter_13_0].pos.x][arg_13_1[iter_13_0].pos.y]
		local var_13_3 = var_13_2:getChildByName("showBg")

		if arg_13_1[iter_13_0].bg then
			var_13_3:show()
			var_13_3:loadTextureEx(arg_13_1[iter_13_0].bg)
		end

		local var_13_4 = var_13_2:getChildByName("buildImg")

		if arg_13_1[iter_13_0].buildImgPath then
			var_13_4:show()
			var_13_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.7), cc.CallFunc:create(function()
				var_13_4:loadTextureEx(var_13_1.buildImgPath)
			end)))

			local var_13_5 = var_13_2:getChildByName("castle")

			if not var_13_5 then
				var_13_5 = L2Skeleton:create("spine/monopoly/castle.json", "spine/monopoly/castle.atlas")

				var_13_5:setName("castle")
				var_13_5:refreshSkeleton()
				self._root:addChild(var_13_5)
			end

			var_13_5:setPosition((var_13_2:convertToWorldSpace((cc.p(var_13_2:getContentSize().width / 2, var_13_2:getContentSize().height / 2)))))
			var_13_5:setVisible(true)
			var_13_5:play("levelup", false)
			var_13_5:registerListener(SP_ANIMATION_COMPLETE, function(arg_15_0)
				var_13_5:setVisible(false)

				local var_15_0 = clone(arg_13_2)

				var_15_0.justTips = true

				LayerManager:pushInLayer("MonopolyTipsLayer", var_15_0)
			end)
		end
	end
end

function MonopolyMapLayer:levelDownTile(arg_16_1, arg_16_2)
	local var_16_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	for iter_16_0 = 1, #arg_16_1 do
		local var_16_1 = arg_16_1[iter_16_0]
		local var_16_2 = self._mapGridLayoutTable[arg_16_1[iter_16_0].pos.x][arg_16_1[iter_16_0].pos.y]
		local var_16_3 = var_16_2:getChildByName("showBg")

		if arg_16_1[iter_16_0].bg then
			var_16_3:show()
			var_16_3:loadTextureEx(arg_16_1[iter_16_0].bg)
		end

		local var_16_4 = var_16_2:getChildByName("buildImg")

		if arg_16_1[iter_16_0].buildImgPath then
			var_16_4:show()
			var_16_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.7), cc.CallFunc:create(function()
				var_16_4:loadTextureEx(var_16_1.buildImgPath)
			end)))

			local var_16_5 = var_16_2:getChildByName("castle")

			if not var_16_5 then
				var_16_5 = L2Skeleton:create("spine/monopoly/castle.json", "spine/monopoly/castle.atlas")

				var_16_5:setName("castle")
				var_16_5:refreshSkeleton()
				self._root:addChild(var_16_5)
			end

			var_16_5:setPosition((var_16_2:convertToWorldSpace((cc.p(var_16_2:getContentSize().width / 2, var_16_2:getContentSize().height / 2)))))
			var_16_5:setVisible(true)
			var_16_5:play("leveldown", false)
			var_16_5:registerListener(SP_ANIMATION_COMPLETE, function(arg_18_0)
				var_16_5:setVisible(false)

				local var_18_0 = clone(arg_16_2)

				var_18_0.justTips = true

				LayerManager:pushInLayer("MonopolyTipsLayer", var_18_0)
			end)
		end
	end
end

function MonopolyMapLayer:updateStateImg()
	self._stateImg:_addEvent(function()
		return
	end)

	local var_19_0 = ""
	local var_19_1 = self.manager:getLevelState()
	local var_19_2 = require("controller.monopoly.monopoly_manager"):getInstance()

	if var_19_1 == var_19_2.STATE.CHALLENGE then
		var_19_0 = var_0_5 .. "reward_bottom_tips.png"
	elseif var_19_1 == var_19_2.STATE.REWARD_GET then
		if self.manager:isLastLevel() then
			var_19_0 = var_0_5 .. "over_tips.png"
		else
			var_19_0 = var_0_5 .. "netx_tips_btn.png"

			self._stateImg:_addEvent(function()
				var_19_2:requestNextLevel()
			end)
		end
	end

	self._stateImg:loadTextureEx(var_19_0)
end

function MonopolyMapLayer:updateReward()
	self._rewardLayout:removeAllChildren()

	local var_22_0 = self.manager:getRewardInfo()
	local var_22_1 = {}

	for iter_22_0 = 1, #var_22_0 do
		local var_22_2

		if item_data[var_22_0[iter_22_0].id].bag_item_type ~= kITEM_COMPONENT then
			var_22_2 = TempWidget:CreateTempImg(var_22_0[iter_22_0].iconPath, self._rewardLayout, 0)

			var_22_2:center()

			if var_22_2:size().w > self._rewardLayout:size().w or var_22_2:size().h > self._rewardLayout:size().h then
				var_22_2:setScale(math.min(self._rewardLayout:size().w / var_22_2:size().w, self._rewardLayout:size().h / var_22_2:size().h))
			end
		else
			var_22_2 = component_manager:create_component_icon(var_22_0[iter_22_0].id)

			var_22_2:setScale(0.8)
			var_22_2:setPosition(cc.p(self._rewardLayout:getContentSize().width / 2, self._rewardLayout:getContentSize().height / 2))
			self._rewardLayout:addChild(var_22_2)
		end

		var_22_2:setOpacity(0)

		var_22_1[#var_22_1 + 1] = var_22_2

		if iter_22_0 == 1 then
			var_22_2:setOpacity(255)
		end
	end

	if #var_22_0 > 1 then
		local var_22_3 = 1

		self._rewardLayout:stopAllActions()
		self._rewardLayout:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
			var_22_3 = var_22_3 + 1

			if var_22_3 > #var_22_1 then
				var_22_3 = 1
			end

			if not tolua.isnull(var_22_1[var_22_3]) then
				var_22_1[var_22_3]:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
					if var_22_1[var_22_3] then
						var_22_1[var_22_3]:runAction(cc.Sequence:create(cc.FadeIn:create(0.5)))
					end
				end)))
			end
		end))))
	end
end

function MonopolyMapLayer:playerWinEvent(arg_25_1)
	self:updateStateImg()
end

function MonopolyMapLayer:intoNextLevel()
	self:updateMapLayout()
end

return MonopolyMapLayer
