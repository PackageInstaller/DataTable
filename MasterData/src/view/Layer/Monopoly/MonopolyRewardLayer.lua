local MonopolyRewardLayer = class("MonopolyRewardLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = require("controller.monopoly.monopoly_manager"):getInstance()
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5
local GoodsItem = require("view.Sprite.GoodsItem")

function MonopolyRewardLayer:ctor()
	var_0_5 = "Monopoly_" .. var_0_1:getActivityId() .. "/MonopolyRewardLayer/"

	MonopolyRewardLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.monopoly.monopoly_reward_manager"):getInstance()
end

function MonopolyRewardLayer:create(arg_2_1)
	texture_manager:loadPopLayerTextures({
		"Monopoly_" .. var_0_1:getActivityId() .. "_MonopolyRewardLayer"
	})

	local var_2_0 = MonopolyRewardLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyRewardLayer:onEnter()
	MonopolyRewardLayer.super.onEnter(self)
end

function MonopolyRewardLayer:onExit()
	MonopolyRewardLayer.super.onExit(self)
end

function MonopolyRewardLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function MonopolyRewardLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(100)
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg(var_0_5 .. "bg.png", var_6_0)

	var_6_1:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2 + 50)
	var_6_1:_addEvent(function()
		return
	end)

	local var_6_2 = TempWidget:CreateTempListView(var_6_1)

	var_6_2:setContentSize(cc.size(var_6_1:size().w - 80, var_6_1:size().h - 300))
	var_6_2:align(cc.p(0.5, 0), var_6_1:size().w / 2, 50)

	self._listView = var_6_2

	self:updateListView()
end

function MonopolyRewardLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function MonopolyRewardLayer:updateLayer()
	return
end

function MonopolyRewardLayer:updateRed()
	return
end

function MonopolyRewardLayer:updateListView()
	local var_12_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	self._listView:removeAllItems()

	local var_12_1 = var_12_0:getLevel()
	local var_12_2 = self.manager:getLevelShowRewardInfo()

	for iter_12_0 = 1, #var_12_2 do
		local var_12_3 = var_12_2[iter_12_0].lv
		local var_12_4 = TempWidget:CreateTempLayout()

		var_12_4:setContentSize(cc.size(self._listView:size().w, 130))

		local var_12_5 = TempWidget:CreateTempImg(var_0_5 .. "reward_bg.png", var_12_4)

		var_12_5:align(cc.p(0.5, 0.5), var_12_4:size().w / 2, var_12_4:size().h / 2)

		local var_12_6 = TempWidget:CreateTempLabel(string.format(L_MONOPOLY[30], iter_12_0), FONT_NAME, 26, var_12_5)

		var_12_6:align(cc.p(0.5, 0.5), 50, var_12_5:size().h / 2)
		var_12_6:setColor(cc.c3b(191, 72, 83))

		local var_12_7 = TempWidget:CreateTempListView(var_12_4)

		var_12_7:setContentSize(cc.size(var_12_4:size().w / 2 + 30, var_12_4:size().h))
		var_12_7:align(cc.p(0.5, 0.5), var_12_4:size().w / 2 - 5, var_12_4:size().h / 2)
		var_12_7:setDirection(ccui.ListViewDirection.horizontal)

		for iter_12_1 = 1, #var_12_2[iter_12_0].reward do
			local var_12_8 = GoodsItem:create({
				countTextColor = "#ffffff",
				itemId = var_12_2[iter_12_0].reward[iter_12_1].id,
				count = var_12_2[iter_12_0].reward[iter_12_1].num
			})

			var_12_8:setButtonSwallowTouches(false)

			local var_12_9 = TempWidget:CreateTempLayout()

			var_12_9:setContentSize(cc.size(100, var_12_7:size().h))
			var_12_9:addChild(var_12_8)
			var_12_8:setAnchorPoint(cc.p(0.5, 0.5))
			var_12_8:setPosition(cc.p(var_12_9:size().w / 2, var_12_9:size().h / 2))
			var_12_8:setScale(0.55)
			var_12_7:pushBackCustomItem(var_12_9)
		end

		self._listView:pushBackCustomItem(var_12_4)
		TempWidget:CreateTempImg(var_12_3 < var_12_1 and var_0_5 .. "completed.png" or var_12_1 == var_12_3 and (var_12_0:isLastLevel() and var_12_0:getLevelState() == var_12_0.STATE.REWARD_GET and var_0_5 .. "completed.png" or var_0_5 .. "underway.png") or var_0_5 .. "unlock.png", var_12_4):align(cc.p(0.5, 0.5), var_12_4:size().w - 80, var_12_4:size().h / 2)

		local var_12_11 = TempWidget:CreateTempImg(var_0_5 .. "mask.png", var_12_4)

		var_12_11:align(cc.p(0.5, 0.5), var_12_4:size().w / 2, var_12_4:size().h / 2)

		if var_12_3 <= var_12_1 then
			var_12_11:setVisible(false)
		else
			var_12_11:setVisible(true)
		end
	end
end

return MonopolyRewardLayer
