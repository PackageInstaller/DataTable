local MonopolySandcastleLayer = class("MonopolySandcastleLayer", (require("view.Layer.BaseUILayer")))
local monopoly_manager = require("controller.monopoly.monopoly_manager")
local var_0_2 = monopoly_manager:getInstance()
local var_0_3 = require("controller.monopoly.monopoly_map_manager").getInstance(monopoly_manager)
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_6 = config._DEBUG and 0 or 1
local var_0_7
local playermodel = require("model.playermodel")

function MonopolySandcastleLayer:ctor()
	var_0_7 = "Monopoly_" .. var_0_2:getActivityId() .. "/MonopolySandcastleLayer/"

	MonopolySandcastleLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.monopoly.monopoly_sandcastle_manager"):getInstance()
end

function MonopolySandcastleLayer:create(arg_2_1)
	texture_manager:loadPopLayerTextures({
		"Monopoly_" .. var_0_2:getActivityId() .. "_MonopolySandcastleLayer"
	})

	local var_2_0 = MonopolySandcastleLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MonopolySandcastleLayer:onEnter()
	MonopolySandcastleLayer.super.onEnter(self)
end

function MonopolySandcastleLayer:onExit()
	MonopolySandcastleLayer.super.onExit(self)
end

function MonopolySandcastleLayer:init(arg_5_1)
	self:initData(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function MonopolySandcastleLayer:initData(arg_6_1)
	self._value = arg_6_1.value
end

function MonopolySandcastleLayer:initLayer()
	local var_7_0 = TempWidget:CreateTempLayout(self)

	var_7_0:_setBack()
	var_7_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_7_0:setBackGroundColorOpacity(100)
	var_7_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_7_0

	local var_7_1 = self.manager:getCostInfo(self._value)

	self.costInfo = var_7_1

	local var_7_2 = TempWidget:CreateTempImg(var_0_7 .. "bg.png", var_7_0)

	var_7_2:align(cc.p(0.5, 0.5), var_7_0:size().w / 2, var_7_0:size().h / 2 + 50)
	var_7_2:_addEvent(function()
		return
	end)

	if var_7_1.curLv == 0 then
		TempWidget:CreateTempImg(var_7_1.nextBuildImg, var_7_2):align(cc.p(0.5, 0.5), var_7_2:size().w / 2, var_7_2:size().h / 2 + 20)
	else
		TempWidget:CreateTempImg(var_7_1.buildImg, var_7_2):align(cc.p(0.5, 0.5), var_7_2:size().w / 2 - 100, var_7_2:size().h / 2 + 20)
		TempWidget:CreateTempImg(var_0_7 .. "into.png", var_7_2):align(cc.p(0.5, 0.5), var_7_2:size().w / 2, var_7_2:size().h / 2 + 20)
		TempWidget:CreateTempImg(var_7_1.nextBuildImg, var_7_2):align(cc.p(0.5, 0.5), var_7_2:size().w / 2 + 100, var_7_2:size().h / 2 + 20)
	end

	local var_7_3 = TempWidget:CreateTempLayout(var_7_2)

	var_7_3:setContentSize(cc.size(var_7_2:size().w, 60))
	var_7_3:align(cc.p(0.5, 0.5), var_7_2:size().w / 2, var_7_2:size().h / 2 - 130)

	local var_7_5 = TempWidget:CreateTempImg((var_7_1.curLv ~= 0 or nil) and var_0_7 .. "upgrade_tips.png", var_7_3)

	var_7_5:align(cc.p(0.5, 0.5), 120, var_7_3:size().h / 2)

	local var_7_6 = TempWidget:CreateTempImg(var_0_7 .. "money_bg.png", var_7_3)

	var_7_6:align(cc.p(0.5, 0.5), var_7_3:size().w / 2 + 80, var_7_3:size().h / 2)
	TempWidget:CreateTempImg(var_7_1.currencyPath, var_7_6):align(cc.p(0.5, 0.5), 50, var_7_6:size().h / 2)

	local var_7_7 = TempWidget:CreateTempLabel(var_7_1.costNum, FONT_NAME, 38, var_7_6)

	var_7_7:_setColor(var_7_1.costTextColor)
	var_7_7:align(cc.p(0.5, 0.5), var_7_6:size().w / 2, var_7_6:size().h / 2)

	self._costMoneyText = var_7_7

	local var_7_8 = TempWidget:CreateTempLayout(var_7_2)

	var_7_8:setContentSize(cc.size(var_7_2:size().w, var_7_3:size().h))
	var_7_8:align(cc.p(0.5, 0.5), var_7_2:size().w / 2, var_7_3:pos().y - var_7_3:size().h)
	TempWidget:CreateTempImg(var_0_7 .. "earnings_tips.png", var_7_8):align(cc.p(0.5, 0.5), var_7_5:pos().x, var_7_8:size().h / 2)

	local var_7_9 = TempWidget:CreateTempImg(var_0_7 .. "money_bg.png", var_7_8)

	var_7_9:align(cc.p(0.5, 0.5), var_7_8:size().w / 2 + 80, var_7_8:size().h / 2)
	TempWidget:CreateTempImg(var_7_1.incomePath, var_7_9):align(cc.p(0.5, 0.5), 50, var_7_9:size().h / 2)

	local var_7_10 = TempWidget:CreateTempLabel(var_7_1.income, FONT_NAME, 38, var_7_9)

	var_7_10:_setColor(var_7_1.incomeTextColor)
	var_7_10:align(cc.p(0.5, 0.5), var_7_7:pos().x, var_7_9:size().h / 2)

	self._earningsMoneyText = var_7_10

	local var_7_11 = TempWidget:CreateTempLabel(L_MONOPOLY[41], FONT_NAME, 22, var_7_2)

	var_7_11:_setColor("938bff")
	var_7_11:align(cc.p(0.5, 0.5), var_7_2:size().w / 2, 30)

	local var_7_12 = var_0_2:getAttrValue("build_color")

	if var_7_12 then
		var_7_11:_setColor(var_7_12)
	end

	local var_7_13 = TempWidget:CreateTempBtn(var_0_7 .. "cancel_btn.png", var_7_2)

	var_7_13:align(cc.p(0.5, 1), var_7_2:size().w / 2 - 150, -10)

	self._cancelBtn = var_7_13

	local var_7_14 = TempWidget:CreateTempBtn(var_0_7 .. "sure_on_btn.png", var_7_2)

	var_7_14:align(cc.p(0.5, 1), var_7_2:size().w / 2 + 150, -10)

	self._sureBtn = var_7_14

	self:updateSureButton()
end

function MonopolySandcastleLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self._cancelBtn:_addEvent(function()
		self.manager:requestPassLevelUp()
		LayerManager:removePopLayer(self.__queueindex)
	end)
	self._sureBtn:_addEvent(function()
		if self.costInfo.costType == self.manager.COST_TYPE.GOLD then
			if require("controller/monopoly/monopoly_manager"):getInstance():getPlayerGold() >= self.costInfo.costNum then
				self.manager:requestLevelUp()
				LayerManager:removePopLayer(self.__queueindex)
			else
				LayerManager:pushInLayer("HandOfMidasLayer", {
					callback = function()
						require("controller.monopoly.monopoly_sandcastle_manager"):getInstance():updateSureButton()
					end
				})
			end
		elseif self.costInfo.costType == self.manager.COST_TYPE.DIAMOND then
			if playermodel.diamond >= self.costInfo.costNum then
				self.manager:requestLevelUp()
				LayerManager:removePopLayer(self.__queueindex)
			else
				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = 1,
					callback = function()
						require("controller.monopoly.monopoly_sandcastle_manager"):getInstance():updateSureButton()
					end
				})
			end
		end
	end)
	performWithDelay(self._root, function()
		if require("controller.monopoly.monopoly_manager"):getInstance():isAuto() then
			local var_15_0 = require("controller/monopoly/monopoly_manager"):getInstance()

			if self.costInfo.costType == self.manager.COST_TYPE.GOLD then
				if var_15_0:getPlayerGold() >= self.costInfo.costNum then
					if var_15_0:isAutoUpgradeBuilding() then
						self.manager:requestLevelUp()
					else
						self.manager:requestPassLevelUp()
					end
				else
					self.manager:requestPassLevelUp()
				end
			elseif self.costInfo.costType == self.manager.COST_TYPE.DIAMOND then
				if playermodel.diamond >= self.costInfo.costNum then
					if var_15_0:isAutoUpgradeHignBuilding() then
						self.manager:requestLevelUp()
					else
						self.manager:requestPassLevelUp()
					end
				else
					self.manager:requestPassLevelUp()
				end
			end

			LayerManager:removePopLayer(self.__queueindex)
		end
	end, 2)
end

function MonopolySandcastleLayer:updateLayer()
	return
end

function MonopolySandcastleLayer:updateRed()
	return
end

function MonopolySandcastleLayer:updateSureButton()
	local var_18_0 = var_0_7 .. "build_on_btn.png"

	if self.costInfo.costType == self.manager.COST_TYPE.GOLD then
		var_18_0 = require("controller/monopoly/monopoly_manager"):getInstance():getPlayerGold() < self.costInfo.costNum and (self.costInfo.curLv == 0 and var_0_7 .. "build_off_btn.png" or var_0_7 .. "upgrade_off_btn.png") or self.costInfo.curLv == 0 and var_0_7 .. "build_on_btn.png" or var_0_7 .. "upgrade_on_btn.png"
	elseif self.costInfo.costType == self.manager.COST_TYPE.DIAMOND then
		var_18_0 = playermodel.diamond < self.costInfo.costNum and (self.costInfo.curLv == 0 and var_0_7 .. "build_off_btn.png" or var_0_7 .. "upgrade_off_btn.png") or self.costInfo.curLv == 0 and var_0_7 .. "build_on_btn.png" or var_0_7 .. "upgrade_on_btn.png"
	end

	self._sureBtn:loadTextureNormal(var_18_0, var_0_6)
end

return MonopolySandcastleLayer
