local MonopolyPlayerWinLayer = class("MonopolyPlayerWinLayer", (require("view.Layer.BaseUILayer")))
local var_0_1 = require("controller.monopoly.monopoly_manager"):getInstance()
local texture_manager = require("controller.texture_manager")
local component_manager = require("controller.component_manager")
local item_data = require("data.item_data")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_7

function MonopolyPlayerWinLayer:ctor()
	var_0_7 = "Monopoly_" .. var_0_1:getActivityId() .. "/MonopolyPlayerWinLayer/"

	MonopolyPlayerWinLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/monopoly/monopoly_player_win_manager"):getInstance()
	self._isplay = {
		[1] = true
	}
end

function MonopolyPlayerWinLayer:create(arg_2_1)
	texture_manager:loadPopLayerTextures({
		"Monopoly_" .. var_0_1:getActivityId() .. "_MonopolyPlayerWinLayer"
	})

	local var_2_0 = MonopolyPlayerWinLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolyPlayerWinLayer:onEnter()
	MonopolyPlayerWinLayer.super.onEnter(self)
end

function MonopolyPlayerWinLayer:onExit()
	MonopolyPlayerWinLayer.super.onExit(self)
end

function MonopolyPlayerWinLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function MonopolyPlayerWinLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(100)
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = L2Skeleton:create("spine/monopoly/victory.json", "spine/monopoly/victory.atlas")

	var_6_1:refreshSkeleton()
	var_6_1:setName("victorySpine")
	var_6_1:setPosition(cc.p(var_6_0:getContentSize().width / 2, var_6_0:getContentSize().height / 2))
	var_6_0:addChild(var_6_1)
	var_6_1:play("animation", false)
	var_6_1:registerListener(SP_ANIMATION_COMPLETE, function(arg_7_0)
		self._isplay[1] = false

		self._closeBtn:setOpacity(0)
		self._closeBtn:show()
		self._closeBtn:runAction(cc.FadeIn:create(0.3))
	end)

	local var_6_2 = TempWidget:CreateTempBtn(var_0_7 .. "next_level_btn.png", var_6_0)

	var_6_2:align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_0:size().h / 2 - 325)
	var_6_2:hide()

	self._nextLevelBtn = var_6_2

	if require("controller.monopoly.monopoly_manager"):getInstance():isLastLevel() then
		-- block empty
	else
		self._isplay[2] = true

		local var_6_3 = L2Skeleton:create("spine/monopoly/next.json", "spine/monopoly/next.atlas")

		var_6_3:refreshSkeleton()
		var_6_3:setName("nextSpine")
		var_6_3:setPosition(cc.p(var_6_0:getContentSize().width / 2, var_6_0:getContentSize().height / 2))
		var_6_0:addChild(var_6_3)
		var_6_3:play("animation", false)
		var_6_3:registerListener(SP_ANIMATION_COMPLETE, function(arg_8_0)
			var_6_3:setVisible(false)
			var_6_2:show()

			self._isplay[2] = false
		end)
	end

	local var_6_4 = TempWidget:CreateTempBtn(var_0_7 .. "close_btn.png", var_6_0)

	var_6_4:align(cc.p(0.5, 0.5), var_6_0:size().w - var_6_4:size().w / 2 - 20, var_6_0:size().h / 2 + 320)
	var_6_4:hide()

	self._closeBtn = var_6_4

	self:initRewardListView()
end

function MonopolyPlayerWinLayer:initListener()
	local var_9_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	self._root:_addEvent(function()
		for iter_10_0, iter_10_1 in pairs(self._isplay) do
			if iter_10_1 then
				return
			end
		end

		var_9_0:setNotes({
			type = var_9_0.NOTES_TYPE.WIN
		})
		LayerManager:removePopLayer(self.__queueindex)
	end)
	self._nextLevelBtn:_addEvent(function()
		for iter_11_0, iter_11_1 in pairs(self._isplay) do
			if iter_11_1 then
				return
			end
		end

		if not var_9_0:isLastLevel() then
			var_9_0:requestNextLevel()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
	performWithDelay(self._root, function()
		local var_12_0 = require("controller.monopoly.monopoly_manager"):getInstance()

		if var_12_0:isAuto() then
			if not var_12_0:isLastLevel() then
				var_12_0:requestNextLevel()
			else
				var_12_0:setAuto(false)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end
	end, 2)
	self._closeBtn:_addEvent(function()
		for iter_13_0, iter_13_1 in pairs(self._isplay) do
			if iter_13_1 then
				return
			end
		end

		var_9_0:setNotes({
			type = var_9_0.NOTES_TYPE.WIN
		})
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function MonopolyPlayerWinLayer:initRewardListView()
	local var_14_0 = (self._root:size().w - 30) / 3
	local var_14_1 = cc.size(var_14_0 * 3, 200)
	local var_14_2 = self.manager:getRewardInfo()

	if #var_14_2 < 3 then
		var_14_1.width = var_14_0 * #var_14_2
	end

	local var_14_3 = TempWidget:CreateTempListView(self._root)
	local var_14_4 = var_0_1:getAttrValue("reward_listview")

	var_14_3:setDirection(ccui.ListViewDirection.horizontal)
	var_14_3:setContentSize(var_14_1)
	var_14_3:setOpacity(0)
	var_14_3:align(cc.p(0.5, 0), self._root:size().w / 2 + var_14_4.x, self._root:size().h / 2 - 180 + var_14_4.y)

	for iter_14_0 = 1, #var_14_2 do
		local var_14_5 = TempWidget:CreateTempLayout()

		var_14_5:setContentSize(cc.size(var_14_0, 200))

		local var_14_6 = TempWidget:CreateTempImg(var_14_2[iter_14_0].bgPath, var_14_5)

		var_14_6:center()
		var_14_6:_addEvent(function()
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_14_2[iter_14_0].id
			})
		end)

		if item_data[var_14_2[iter_14_0].id].bag_item_type ~= kITEM_COMPONENT then
			local var_14_7 = TempWidget:CreateTempImg(var_14_2[iter_14_0].iconPath, var_14_6, 0)

			var_14_7:setScale(0.8)
			var_14_7:center()
		else
			local var_14_8 = component_manager:create_component_icon(var_14_2[iter_14_0].id)

			var_14_8:setScale(0.8)
			var_14_8:setPosition(cc.p(var_14_6:getContentSize().width / 2, var_14_6:getContentSize().height / 2))
			var_14_6:addChild(var_14_8)
		end

		local var_14_9 = TempWidget:CreateTempImg("public/box/word_black_bg.png", var_14_6)

		var_14_9:align(cc.p(0.5, 0), var_14_6:size().w / 2, 0)
		TempWidget:CreateTempLabel("x" .. var_14_2[iter_14_0].num, FONT_NAME, 20, var_14_9):center()
		var_14_3:pushBackCustomItem(var_14_5)
	end

	var_14_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.9), cc.FadeIn:create(0.5)))
end

function MonopolyPlayerWinLayer:updateLayer()
	return
end

function MonopolyPlayerWinLayer:updateRed()
	return
end

return MonopolyPlayerWinLayer
