ActivityLayer_bianhua_Main = class("ActivityLayer_bianhua_Main", function()
	return cc.Layer:create()
end)

require("view.Sprite.BottomBtnList")
require("controller.goto_system_manager")

local activity_bianhua_manager = require("controller.activity_bianhua_manager")
local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4
local var_0_5 = 2091
local var_0_7 = {}
local var_0_8 = "sign_id1"
local var_0_9 = {
	ActivitySignLayer_9_1 = {
		Name = "ActivitySignLayer_9_1",
		type = "PopLayer",
		createLayer = function(...)
			require("controller.sign_manager"):createActivitySignLayer(...)
		end
	}
}

function ActivityLayer_bianhua_Main.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityLayer_bianhua_Main.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ActivityLayer_bianhua_Main.getInstance()
	return var_0_4
end

function ActivityLayer_bianhua_Main:init()
	var_0_4 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_bianhua_main.json" or "Activity_bianhua_main.ExportJson")

	self:addChild(self.rootLayer)
	self:registerActivityEventListener()
	self:initData()
	self:updateData()
	self:initUI()
	self:updateUI()
	self:fullScreen()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.callback then
				self.callback()
			end

			var_0_4 = nil

			activity_manager:releaseEventListenerByName("ActivityLayer_bianhua_Main")
		end
	end)
	AnalyticManager.BAH_main_layer_click()
end

function ActivityLayer_bianhua_Main.initData(arg_7_0)
	arg_7_0.id = activity_bianhua_manager:getActivityId()
end

function ActivityLayer_bianhua_Main.updateData(arg_8_0)
	return
end

function ActivityLayer_bianhua_Main:initUI()
	self.imgTitle = ccui.Helper:seekWidgetByName(self.rootLayer, "img_title")
	self.imgBg = ccui.Helper:seekWidgetByName(self.rootLayer, "img_bg")
	self.btnList = ccui.Helper:seekWidgetByName(self.rootLayer, "img_btn_list")

	local var_9_0 = ccui.Layout:create()

	var_9_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_9_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_9_0:setAnchorPoint(0, 0)
	var_9_0:setPosition(cc.p(0, 0))
	var_9_0:setBackGroundColor(cc.c3b(15, 15, 33))
	self.rootLayer:addChild(var_9_0, 0)
	self:initButton()
	playermodel:reloadSystemAlert(function()
		if self then
			self:updateReddot()
		end
	end)
end

function ActivityLayer_bianhua_Main:initButton()
	self:initActivityInfo()
	self:initRoleInfo()
	self:initBtnList()
	self:initBottomBtnList()
end

function ActivityLayer_bianhua_Main:initActivityInfo()
	self.activityInfoBtn = self.imgTitle:getChildByName("activity_info_btn")

	self.activityInfoBtn:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("显示活动信息")
		LayerManager:pushInLayer("PopActivityDetail", {
			key = string.format("activity_%d_%d", activity_bianhua_manager:getActivityId(), var_0_5)
		})
	end)
end

function ActivityLayer_bianhua_Main:initRoleInfo()
	self.roleInfo = {}
	self.btnAjiasha = self.imgBg:getChildByName("btn_ajiasha")
	self.btnBetty = self.imgBg:getChildByName("btn_betty")
	self.roleInfo[1] = self.btnAjiasha:getChildByName("btn_info1")
	self.roleInfo[2] = self.btnBetty:getChildByName("btn_info2")

	local var_14_0 = {
		id = 43,
		modelid = 25120,
		contentType = {
			contentType = "file_player"
		}
	}
	local var_14_1 = {
		id = 44,
		modelid = 25320,
		contentType = {
			contentType = "file_player"
		}
	}

	self.imgBg:setTouchEnabled(true)
	self.imgBg:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		require("controller.goto_system_manager")

		local var_15_0 = {
			jump_to_system = 1810
		}

		var_15_0.config = system_jump_config[SYSTEMID[1810]] and system_jump_config[SYSTEMID[1810]].config

		if var_15_0.config and var_15_0.config.exitCallbackType == "function" then
			var_15_0.config.exitCallback = createExitCallback({
				jump_to_system = 2091
			}, self.initconfig)
		end

		goto_complete_system(var_15_0)
	end)
	self.btnAjiasha:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("阿加莎")
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			cursoul = 25120,
			layertype = "ActivityLayer_bianhua_Main"
		})
	end)
	self.btnBetty:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("贝蒂")
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			cursoul = 25320,
			layertype = "ActivityLayer_bianhua_Main"
		})
	end)
	self.roleInfo[1]:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("阿加莎")
		LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_14_0)
	end)
	self.roleInfo[2]:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("贝蒂")
		LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_14_1)
	end)
end

function ActivityLayer_bianhua_Main:initBtnList()
	self.gotoChapter = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_chapter")

	self.gotoChapter:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("转入副本")
		LayerManager:switchShowLayer("ActivityLayer_bianhua_Chapter")
	end)

	self.gotoShop = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_shop")

	self.gotoShop:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("转入商店")
		LayerManager:switchShowLayer("MarketLayer", {
			returnLayer = "ActivityLayer_bianhua_Main",
			singleMarket = {
				"1-33",
				"1-20"
			}
		})
	end)

	self.gotoCollection = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_collection")

	self.gotoCollection:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("转入兑换")
		LayerManager:switchShowLayer("ActivityLayer_bianhua_Collection")
	end)

	self.btnSign = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sign")

	self.btnSign:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:pushInLayer((self:getAutoPopLayerConfig({
			activityID = self.id
		})))
	end)
end

function ActivityLayer_bianhua_Main:initBottomBtnList()
	self.bottomlist = BottomBtnList:create(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()

		if callback then
			callback()
		end
	end, {})

	self:addChild(self.bottomlist, 5)
end

function ActivityLayer_bianhua_Main:updateUI()
	self:updateReddot()
end

function ActivityLayer_bianhua_Main:updateReddot()
	if activity_manager:getAlertStatus(9, "proceed") and not self.gotoCollection:getChildByName("reddot") then
		local var_28_0 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_3)

		var_28_0:setPosition(cc.p(210, 140))
		var_28_0:setName("reddot")
		self.gotoCollection:addChild(var_28_0)
	end

	self.gotoAchievement = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_achievement")

	self.gotoAchievement:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("转入成就")
		LayerManager:switchShowLayer("ActivityLayer_bianhua_Achieve")
		activity_manager:updateActivityAlert("task", self.id, false)
	end)

	if activity_manager:getAlertStatus(9, "task") and not self.gotoAchievement:getChildByName("reddot") then
		local var_28_1 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_3)

		var_28_1:setPosition(cc.p(210, 140))
		var_28_1:setName("reddot")
		self.gotoAchievement:addChild(var_28_1)
	end
end

function ActivityLayer_bianhua_Main:getAutoPopLayerConfig(arg_30_1)
	local var_30_1 = activity_manager:getActivityListData()[self.id].list
	local var_30_2 = {}

	for iter_30_0 = 1, #var_30_1 do
		if var_30_1[iter_30_0].activity_type == var_0_8 then
			var_30_2 = var_30_1[iter_30_0]

			break
		end
	end

	var_30_2.activityID = arg_30_1.id
	var_30_2.isAutoPop = true

	return var_30_2
end

local function var_0_10(arg_31_0)
	if not arg_31_0 then
		return
	end

	return var_0_9[arg_31_0]
end

function ActivityLayer_bianhua_Main.getLayerIDTbl(arg_32_0)
	local function var_32_0(arg_33_0, arg_33_1)
		while activityConfData[arg_33_0][arg_33_1 .. 1] do
			if arg_33_1 == "sign_id" then
				var_0_7[activityConfData[arg_33_0][arg_33_1 .. 1]] = "ActivitySignLayer_9_1"
			end
		end
	end

	for iter_32_0, iter_32_1 in pairs(activityConfData) do
		if activityConfData[iter_32_0].proceed and activityConfData[iter_32_0].proceed ~= 0 then
			var_32_0(iter_32_0, "proceed_id")
		end

		if activityConfData[iter_32_0].task and activityConfData[iter_32_0].task ~= 0 then
			var_32_0(iter_32_0, "task_id")
		end

		if activityConfData[iter_32_0].sign and activityConfData[iter_32_0].sign ~= 0 then
			var_32_0(iter_32_0, "sign_id")
		end

		if activityConfData[iter_32_0].levelmode and activityConfData[iter_32_0].levelmode ~= 0 then
			var_32_0(iter_32_0, "levelmode_id")
		end

		if activityConfData[iter_32_0].shoptype and activityConfData[iter_32_0].shoptype ~= 0 then
			var_32_0(iter_32_0, "shoptype_id")
		end

		if activityConfData[iter_32_0].markettype and activityConfData[iter_32_0].markettype ~= 0 then
			var_32_0(iter_32_0, "markettype_id")
		end

		if activityConfData[iter_32_0].twisttype and activityConfData[iter_32_0].twisttype ~= 0 then
			var_32_0(iter_32_0, "twisttype_id")
		end
	end
end

function ActivityLayer_bianhua_Main:pushInLayer(arg_34_1)
	var_0_7["9-1"] = "ActivitySignLayer_9_1"
	arg_34_1.activityID = self.id

	if not arg_34_1.id then
		print("print id dont exist")

		return layer
	end

	if not var_0_7[arg_34_1.id] then
		print("print layerID dont exist")

		return layer
	end

	print("can create layer")

	self.layerinfo = var_0_10(var_0_7[arg_34_1.id])
	self.layer_type = self.layerinfo.type

	if self.layer_type == "PopLayer" then
		print("PopLayer")
		self.layerinfo.createLayer(arg_34_1)
	end
end

function ActivityLayer_bianhua_Main.registerActivityEventListener(arg_35_0)
	return
end

function ActivityLayer_bianhua_Main:fullScreen()
	self.rootLayer.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 0, TRANSFORM_UNIT.PX)

	self.rootLayer:setPositionY(self.rootLayer.full_posY)

	self.imgTitle.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 10 + self.imgTitle:getContentSize().height / 2 - GameDisplay.fix_y, TRANSFORM_UNIT.PX)

	self.imgTitle:setPositionY(self.imgTitle.full_posY)

	self.imgBg.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, GameDisplay.height * 0.6 + GameDisplay.fix_y, TRANSFORM_UNIT.PX)

	self.imgBg:setPositionY(self.imgBg.full_posY)

	self.btnList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, GameDisplay.height * 0.3376 + GameDisplay.fix_y, TRANSFORM_UNIT.PX)

	self.btnList:setPositionY(self.btnList.full_posY)

	self.bottomlist.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomlist:setPositionY(self.bottomlist.full_posY)
end
