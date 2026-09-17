ActivityFlopLayer_197 = class("ActivityFlopLayer_197", function()
	return ActivityFlopBaseNewLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_5 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSpriteFlop")

local item_data = require("data.item_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local activity_flop_condition_conf = require("data.activity_modules.activity_flop_condition_conf")
local activity_flop_ui_conf_data = require("data.activity_flop.uiconfig.activity_flop_ui_conf_data")

function ActivityFlopLayer_197.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityFlopLayer_197.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityFlopLayer_197:initDynaticPara(arg_3_1)
	self.layerName = "ActivityFlopLayer_" .. arg_3_1.activityid or "ActivityFlopLayer_149"
	self.id = arg_3_1.activityid or 10000
	self.bgPath = "activitiesRes/activity" .. self.id .. "/flop/flop_bg.png"
	self.rolebg = "activitiesRes/activity" .. self.id .. "/flop/"
	self.texturePath = "Activities/activity" .. self.id .. "/flop/"

	self:getParamFromUIConf()
end

function ActivityFlopLayer_197:initDrawBg()
	local var_4_0 = ccui.ImageView:create(self.texturePath .. "champion_bg1.png", var_0_5)

	var_4_0:setAnchorPoint(cc.p(0.5, 0))
	var_4_0:setPosition(cc.p(self.rootLayer:getContentSize().width / 2 - 200, 750))
	self.rootLayer:addChild(var_4_0, 1)

	local var_4_1 = ccui.ImageView:create(self.texturePath .. "draw_bg.png", var_0_5)

	var_4_1:setAnchorPoint(cc.p(0.5, 1))
	var_4_1:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, var_4_0:getPositionY() - 20))
	self.rootLayer:addChild(var_4_1, 1)

	self.championBg = var_4_0
	self.drawBg = var_4_1

	self.drawBg:setTouchEnabled(true)
end

function ActivityFlopLayer_197.updateChampionTipLabel(arg_5_0)
	return
end

function ActivityFlopLayer_197:fullScreen()
	self.championBg:setPositionY(self.championBg:getPositionY() + GameDisplay.fix_y * 0.8)
	self.drawBg:setPositionY(self.championBg:getPositionY())
	self.Title:setPositionX(self.Title:getPositionX())

	self.bottomList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomList:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomList:setPositionY(0)
	self.changeSkinBtn:setPositionY(self.shopbtn:getPositionY() - (self.shopbtn:getPositionY() - self.drawBg:getPositionY() - 50) / 2)
end

function ActivityFlopLayer_197:initOther()
	local var_7_0 = ccui.ImageView:create(self.texturePath .. "champion_bg1.png", var_0_5)

	var_7_0:setAnchorPoint(cc.p(0.5, 1))
	var_7_0:setVisible(false)
	var_7_0:setPosition(cc.p(320, self.rootLayer:getContentSize().height * 0.6))
	self.rootLayer:addChild(var_7_0)

	self.bigRole = var_7_0

	local var_7_1 = ccui.ImageView:create(self.texturePath .. "champion_detail_2.png", var_0_5)

	self.drawBg:addChild(var_7_1)
	var_7_1:setAnchorPoint(cc.p(1, 0))
	var_7_1:setPosition(cc.p(self.drawBg:getContentSize().width - 10, self.drawBg:getContentSize().height + 7))
end

function ActivityFlopLayer_197.updateSkin(arg_8_0)
	return
end
