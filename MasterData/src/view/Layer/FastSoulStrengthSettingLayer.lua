FastSoulStrengthSettingLayer = class("FastSoulStrengthSettingLayer", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = "FastSoulStrengthSettingLayer/"

function FastSoulStrengthSettingLayer:ctor()
	FastSoulStrengthSettingLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.fast_soulstrength_setting_manager"):getInstance()
end

function FastSoulStrengthSettingLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = FastSoulStrengthSettingLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function FastSoulStrengthSettingLayer:onEnter()
	FastSoulStrengthSettingLayer.super.onEnter(self)
	self._root:setScaleY(0.01)
	self._root:show()
	self._root:runAction(cc.ScaleTo:create(0.2, 1))
end

function FastSoulStrengthSettingLayer.onExit(arg_4_0)
	FastSoulStrengthSettingLayer.super.onExit(arg_4_0)
end

function FastSoulStrengthSettingLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function FastSoulStrengthSettingLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:align(cc.p(0.5, 0.5), self:getContentSize().width / 2, self:getContentSize().height / 2)
	var_6_0:hide()
	var_6_0:_setBack()
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(125)
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg("public/talk/new_yourenkuang.png", var_6_0)

	var_6_1:_addEvent(function()
		return
	end)
	var_6_1:setScale9Enabled(true)
	var_6_1:setCapInsets(cc.rect(0, 0, var_6_1:size().w, var_6_1:size().h))
	var_6_1:setContentSize(cc.size(var_6_0:size().w - 100, 300))
	var_6_1:center()

	local var_6_2 = TempWidget:CreateTempImg("public/title/fast_soulstrength.png", var_6_1)

	var_6_2:align(cc.p(0, 0), -5, var_6_1:size().h - 5)

	local var_6_3 = TempWidget:CreateTempBtn(var_0_2 .. "tips_btn.png", var_6_2)

	var_6_3:align(cc.p(0, 0.5), var_6_2:size().w + 5, var_6_2:size().h / 2)

	local var_6_4 = TempWidget:CreateTempLayout(var_6_3)

	var_6_4:setContentSize(cc.size(var_6_3:size().w + 30, var_6_3:size().h + 30))
	var_6_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_6_4:center()
	var_6_4:_addEvent(function()
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "strengthen_1"
		})
	end)

	local var_6_5 = TempWidget:CreateTempLabel("班长可选择下方强化内容，\n自动消耗对应材料进行强化。", FONT_DES, 23, var_6_1)

	var_6_5:_setColor("21d3ff")
	var_6_5:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
	var_6_5:align(cc.p(0.5, 1), var_6_1:size().w / 2, var_6_1:size().h - 25)

	local var_6_6 = TempWidget:CreateTempImg(var_0_2 .. "line.png", var_6_1)

	var_6_6:align(cc.p(0.5, 1), var_6_1:size().w / 2, var_6_5:pos().y - var_6_5:size().h - 25)

	local var_6_7 = TempWidget:CreateTempLayout(var_6_1)

	var_6_7:setContentSize(cc.size(150, 40))
	var_6_7:align(cc.p(0.5, 1), var_6_1:size().w / 2, var_6_6:pos().y - var_6_6:size().h - 20)
	var_6_7:setName("levelLayout")

	self.levelLayout = var_6_7

	local var_6_8 = TempWidget:CreateTempLabel("角色等级", FONT_DES, 22, var_6_7)

	var_6_8:align(cc.p(0, 0.5), 10, var_6_7:size().h / 2)

	local var_6_9 = TempWidget:CreateTempImg(var_0_2 .. "check_box_bg.png", var_6_7)

	var_6_9:align(cc.p(1, 0.5), var_6_7:size().w - 10, var_6_8:pos().y)
	var_6_9:setScale(1.5)

	local var_6_10 = TempWidget:CreateTempImg(var_0_2 .. "check_on.png", var_6_7)

	var_6_10:align(cc.p(1, 0.5), var_6_9:pos().x, var_6_9:pos().y)
	var_6_10:hide()
	var_6_10:setScale(1.5)

	self.levelLayout._checkOnImg = var_6_10

	local var_6_11 = TempWidget:CreateTempLayout(var_6_1)

	var_6_11:setContentSize(var_6_7:size())
	var_6_11:align(cc.p(0.5, 1), var_6_7:pos().x, var_6_7:pos().y - var_6_7:size().h - 20)
	var_6_11:setName("weaponLayout")

	self.weaponLayout = var_6_11

	local var_6_12 = TempWidget:CreateTempLabel("魂武等级", FONT_DES, 22, var_6_11)

	var_6_12:align(cc.p(0, 0.5), 10, var_6_11:size().h / 2)

	local var_6_13 = TempWidget:CreateTempImg(var_0_2 .. "check_box_bg.png", var_6_11)

	var_6_13:align(cc.p(1, 0.5), var_6_11:size().w - 10, var_6_12:pos().y)
	var_6_13:setScale(1.5)

	local var_6_14 = TempWidget:CreateTempImg(var_0_2 .. "check_on.png", var_6_11)

	var_6_14:align(cc.p(1, 0.5), var_6_13:pos().x, var_6_13:pos().y)
	var_6_14:hide()
	var_6_14:setScale(1.5)

	self.weaponLayout._checkOnImg = var_6_14

	local var_6_15 = TempWidget:CreateTempLayout(var_6_1)

	var_6_15:setContentSize(var_6_11:size())
	var_6_15:align(cc.p(0.5, 1), var_6_11:pos().x, var_6_11:pos().y - var_6_11:size().h - 20)
	var_6_15:setName("commponentLayout")

	self.commponentLayout = var_6_15

	local var_6_16 = TempWidget:CreateTempLabel("芯片等级", FONT_DES, 22, var_6_15)

	var_6_16:align(cc.p(0, 0.5), 10, var_6_15:size().h / 2)

	local var_6_17 = TempWidget:CreateTempImg(var_0_2 .. "check_box_bg.png", var_6_15)

	var_6_17:align(cc.p(1, 0.5), var_6_15:size().w - 10, var_6_16:pos().y)
	var_6_17:setScale(1.5)

	local var_6_18 = TempWidget:CreateTempImg(var_0_2 .. "check_on.png", var_6_15)

	var_6_18:align(cc.p(1, 0.5), var_6_17:pos().x, var_6_17:pos().y)
	var_6_18:hide()
	var_6_18:setScale(1.5)

	self.commponentLayout._checkOnImg = var_6_18

	self:updateLayer()
end

function FastSoulStrengthSettingLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.levelLayout:_addEvent(function()
		self.manager:setConfigure(self.manager.Setting_Type.Level, not self.manager:getConfigure(self.manager.Setting_Type.Level))
	end)
	self.weaponLayout:_addEvent(function()
		self.manager:setConfigure(self.manager.Setting_Type.Weapon, not self.manager:getConfigure(self.manager.Setting_Type.Weapon))
	end)
	self.commponentLayout:_addEvent(function()
		self.manager:setConfigure(self.manager.Setting_Type.Component, not self.manager:getConfigure(self.manager.Setting_Type.Component))
	end)
end

function FastSoulStrengthSettingLayer:updateLayer()
	self.levelLayout._checkOnImg:setVisible((self.manager:getConfigure(self.manager.Setting_Type.Level)))
	self.weaponLayout._checkOnImg:setVisible((self.manager:getConfigure(self.manager.Setting_Type.Weapon)))
	self.commponentLayout._checkOnImg:setVisible((self.manager:getConfigure(self.manager.Setting_Type.Component)))
end

function FastSoulStrengthSettingLayer.updateRed(arg_15_0)
	return
end

return FastSoulStrengthSettingLayer
