LabLayer = class("LabLayer", function()
	return cc.Layer:create()
end)

require("view.Layer.SmeltLayer")
require("view.Layer.CompoundLabLayer")
require("view.Layer.HorcruxCommandLayer")
require("view.Layer.EnergyLabLayer")

local lab_manager = require("controller.lab_manager")
local alert_manager = require("controller.alert_manager")
local lab_gold_data = require("data.lab_gold_data")
local var_0_3
local var_0_4
local var_0_5

function LabLayer.create(arg_2_0)
	local var_2_0 = LabLayer.new()

	var_2_0:init()

	return var_2_0
end

function LabLayer.getInstance()
	return var_0_3
end

LAB_TYPE_CENTER = 1
LAB_TYPE_ENERGY = 2

local var_0_6 = 0
local var_0_8 = {
	[LAB_TYPE_CENTER] = L_LAB_UNLOCK_MSG.LAB_TYPE_CENTER,
	[LAB_TYPE_ENERGY] = L_LAB_UNLOCK_MSG.LAB_TYPE_ENERGY
}
local var_0_10 = {
	[LAB_TYPE_CENTER] = cc.p(50, 200),
	[LAB_TYPE_ENERGY] = cc.p(50, 200)
}

function LabLayer:init()
	var_0_3 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Produce.json" or "Produce.ExportJson")

	self:addChild(self.rootLayer)

	self.rooms = {}
	self.rooms[LAB_TYPE_CENTER] = ccui.Helper:seekWidgetByName(self.rootLayer, "button_room1")

	self.rooms[LAB_TYPE_CENTER]:setVisible(false)

	self.rooms[LAB_TYPE_ENERGY] = ccui.Helper:seekWidgetByName(self.rootLayer, "button_room2")

	self.rooms[LAB_TYPE_ENERGY]:setVisible(false)

	self.updateSchedule = nil

	lab_manager:getLabInfo(function(arg_5_0)
		if not var_0_3 then
			return
		end

		self:initLabInfos(arg_5_0)
	end)
	TopcostLayer.getInstance():registeReturnEvent(LabLayer)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.updateSchedule then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.updateSchedule)

				self.updateSchedule = nil
			end

			var_0_3 = nil
			var_0_5 = nil
			var_0_4 = nil
		end
	end)
end

function LabLayer.topupdate()
	return {
		"Topcost/lab.png",
		"Topcost/lab.png"
	}
end

function LabLayer:initLabInfos(arg_8_1)
	local var_8_0 = {
		status = arg_8_1.status,
		levelup_lab = arg_8_1.levelup_lab,
		remain_time = arg_8_1.remain_time
	}

	self:updateCenterLabInfo(arg_8_1.rooms[LAB_TYPE_CENTER], var_8_0)
	self:updateEnergyLabInfo(arg_8_1.rooms[LAB_TYPE_ENERGY], var_8_0)
	self:updateAlert()

	local function var_8_1(arg_9_0, arg_9_1)
		if arg_9_0 ~= 0 then
			self:updateLabInfos(arg_9_1)
		end
	end

	self.updateSchedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		lab_manager:updateLabLevelup(var_8_1)
	end, 1, false)
end

function LabLayer:reloadLayer()
	if self:getChildByName("CenterLab") then
		self:removeChildByName("CenterLab")
	end

	if self:getChildByName("EnergyLabLayer") then
		self:removeChildByName("EnergyLabLayer")
	end

	lab_manager:getLabInfo(function(arg_12_0)
		self:updateLabInfos(arg_12_0)
	end)
end

function LabLayer:updateLabInfos(arg_13_1)
	local var_13_0 = {
		status = arg_13_1.status,
		levelup_lab = arg_13_1.levelup_lab,
		remain_time = arg_13_1.remain_time
	}

	self:updateCenterLabInfo(arg_13_1.rooms[LAB_TYPE_CENTER], var_13_0)
	self:updateEnergyLabInfo(arg_13_1.rooms[LAB_TYPE_ENERGY], var_13_0)
	self:updateAlert()
end

function LabLayer:updateCenterLabInfo(arg_14_1, arg_14_2)
	self.rooms[LAB_TYPE_CENTER]:setVisible(true)

	if arg_14_1.status == var_0_6 then
		self.rooms[LAB_TYPE_CENTER]:getChildByName("adven_unlock_0"):setVisible(true)
		self.rooms[LAB_TYPE_CENTER]:getChildByName("adven_unlock_0"):getChildByName("Label_84"):setString(var_0_8[LAB_TYPE_CENTER])
		self.rooms[LAB_TYPE_CENTER]:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(var_0_8[LAB_TYPE_CENTER])
		end)

		if var_0_4 and var_0_4 == "CommandLayer" then
			global_ShowBlockWords(var_0_8[LAB_TYPE_CENTER])
		end
	else
		self.rooms[LAB_TYPE_CENTER]:getChildByName("adven_unlock_0"):setVisible(false)
		self.rooms[LAB_TYPE_CENTER]:getChildByName("lv"):getChildByName("num"):setString(arg_14_1.level)
		self.rooms[LAB_TYPE_CENTER]:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if HorcruxCommandLayer and HorcruxCommandLayer.getInstance() then
				return
			end

			local var_16_0 = HorcruxCommandLayer:create(arg_14_2.status == LAB_STATUS_LEVELUP and arg_14_2.levelup_lab == LAB_TYPE_CENTER, LAB_TYPE_CENTER, function()
				self.rootLayer:setVisible(true)
			end)

			var_16_0:setName("CenterLab")
			self:addChild(var_16_0, 10)
			self.rootLayer:setVisible(false)

			var_0_5 = "CommandLayer"
		end)

		if var_0_4 and var_0_4 == "CommandLayer" then
			if HorcruxCommandLayer and HorcruxCommandLayer.getInstance() then
				return
			end

			local var_14_0 = HorcruxCommandLayer:create(arg_14_2.status == LAB_STATUS_LEVELUP and arg_14_2.levelup_lab == LAB_TYPE_CENTER, LAB_TYPE_CENTER)

			var_14_0:setName("CenterLab")
			self:addChild(var_14_0, 10)

			var_0_5 = "CommandLayer"
		end
	end
end

function LabLayer:updateEnergyLabInfo(arg_18_1, arg_18_2)
	self.rooms[LAB_TYPE_ENERGY]:setVisible(true)

	if arg_18_1.status == var_0_6 then
		self.rooms[LAB_TYPE_ENERGY]:getChildByName("adven_unlock_0"):setVisible(true)
		self.rooms[LAB_TYPE_ENERGY]:getChildByName("adven_unlock_0"):getChildByName("Label_84"):setString(var_0_8[LAB_TYPE_ENERGY])
		self.rooms[LAB_TYPE_ENERGY]:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(var_0_8[LAB_TYPE_ENERGY])
		end)
	else
		self.rooms[LAB_TYPE_ENERGY]:getChildByName("adven_unlock_0"):setVisible(false)
		self.rooms[LAB_TYPE_ENERGY]:getChildByName("lv"):getChildByName("num"):setString(arg_18_1.level)
		self.rooms[LAB_TYPE_ENERGY]:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_20_0 = EnergyLabLayer:create(arg_18_2.status == LAB_STATUS_LEVELUP and arg_18_2.levelup_lab == LAB_TYPE_ENERGY)

			var_20_0:setName("EnergyLabLayer")
			self:addChild(var_20_0, 10)

			var_0_5 = "EnergyLabLayer"
		end)
	end
end

function LabLayer.setSwitchLabType(arg_21_0, arg_21_1)
	var_0_4 = arg_21_1

	if var_0_3 then
		if var_0_5 == arg_21_1 then
			return
		else
			LabLayer.getInstance():reloadLayer()
		end
	end
end

function LabLayer:updateAlert()
	alert_manager:add_alert(ALERT_GOLDLAB, self.rooms[LAB_TYPE_ENERGY], alert_manager:isSystemNewAlert(ALERT_GOLDLAB), var_0_10[LAB_TYPE_ENERGY])
	alert_manager:add_alert(ALERT_HORCRUXWORK, self.rooms[LAB_TYPE_CENTER], alert_manager:isSystemNewAlert(ALERT_HORCRUXWORK), var_0_10[LAB_TYPE_CENTER])
end
