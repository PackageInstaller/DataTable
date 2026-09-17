DoubleHoliday_CityNodeLayer = class("DoubleHoliday_CityNodeLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.BottomBtnList")
require("controller.goto_system_manager")

local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")
local activity_conf_data = require("data.activity_conf_data")
local time_check_manager = require("controller.time_check_manager")
local explore_manager = require("controller.explore_manager")
local activity_doubleholiday_manager = require("controller.activity_doubleholiday_manager")
local var_0_6 = require("model.playermodel")
local activity_plague_achievement_data = require("data.activity_plague_achievement_data")
local activity_plague_city_data = require("data.activity_plague_city_data")
local activity_plague_data = require("data.activity_plague_data")
local activity_plague_virus_data = require("data.activity_plague_virus_data")
local activity_plague_skill_data = require("data.activity_plague_skill_data")
local activity_plague_technology_data = require("data.activity_plague_technology_data")
local activity_plague_message_data = require("data.activity_plague_message_data")
local activity_plague_other_data = require("data.activity_plague_other_data")
local item_manager = require("controller.item_manager")
local LinkNode = require("view.Sprite.LinkNode")
local var_0_17 = "mainScenebg/activity/branch12/sd_bg.jpg"
local var_0_18 = "doubleholiday_city/weizhi.png"
local var_0_19 = "PopTechnologyTree/"
local var_0_20
local levelmode_data = require("data.levelmode_data")
local var_0_22 = {
	"doubleholiday_city/cxmn.png",
	"Activity_doubleholiday/ai.png",
	"Activity_doubleholiday/sd_bdkg.png"
}
local var_0_23 = {
	"ChristmasMap_ADY",
	"ChristmasMap_ADY",
	"ChristmasMap_KKEK",
	"ChristmasMap_PS",
	"ChristmasMap_BHMT",
	"ChristmasMap_YMJD",
	"ChristmasMap_NDHG",
	"ChristmasMap_LJE"
}
local var_0_24 = {
	"doubleholiday_city/nodecity_1.png",
	"doubleholiday_city/nodecity_4.png",
	"doubleholiday_city/nodecity_5.png",
	"doubleholiday_city/nodecity_3.png",
	"doubleholiday_city/nodecity_7.png",
	"doubleholiday_city/nodecity_2.png",
	"doubleholiday_city/nodecity_6.png",
	"doubleholiday_city/nodecity_1.png"
}
local var_0_25 = {
	[1] = 0.69,
	[2] = 1
}
local var_0_26 = {
	"doubleholiday_city/node4.png",
	"doubleholiday_city/node3.png",
	"doubleholiday_city/node2.png",
	"doubleholiday_city/node1.png"
}
local var_0_27 = {
	201912003,
	201912002,
	201912001
}
local var_0_30 = {
	"doubleholiday_city/1TB_2.png",
	"doubleholiday_city/1TB_1.png",
	"doubleholiday_city/10TB_2.png",
	"doubleholiday_city/10TB_1.png"
}
local var_0_31 = 40
local var_0_32 = config._DEBUG and 0 or 1

function DoubleHoliday_CityNodeLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = DoubleHoliday_CityNodeLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function DoubleHoliday_CityNodeLayer.getInstance()
	return var_0_20
end

function DoubleHoliday_CityNodeLayer:init(arg_4_1)
	var_0_20 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "DoubleHoliday_CityNodeLayer.json" or "DoubleHoliday_CityNodeLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "image_title")
	self.cityname = ccui.Helper:seekWidgetByName(self.rootLayer, "cityname")
	self.panel_ml = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_mindle_l")
	self.panel_mr = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_mindle_r")
	self.btn_broadcast = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_30")
	self.scollpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_29")
	self.skillpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "jinnengbg")
	self.pass_city_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_87")
	self.tips_skill = ccui.Helper:seekWidgetByName(self.rootLayer, "skill_label")
	self.nodeinfo_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_nodeinfo")
	self.sinceinfo_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_sinceinfo")
	self.guaji_info = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_88")
	self.guaji_btn = ccui.Helper:seekWidgetByName(self.panel_ml, "Image_27")

	self.nodeinfo_panel:getChildByName("Image_90"):getChildByName("Label_92"):getVirtualRenderer():setMaxLineWidth(228)
	self.sinceinfo_panel:getChildByName("Image_90"):getChildByName("Label_92"):getVirtualRenderer():setMaxLineWidth(540)

	self.returnBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return")

	self.pass_city_panel:setVisible(false)

	local function var_4_0(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopItemLayer", {
			itemid = arg_5_0.itemid
		})
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_21"):setTouchEnabled(true)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_22"):setTouchEnabled(true)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_23"):setTouchEnabled(true)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_21"):addTouchEventListener(var_4_0)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_21").itemid = var_0_27[1]

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_22"):addTouchEventListener(var_4_0)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_22").itemid = var_0_27[2]

	local function var_4_1(arg_6_0, arg_6_1)
		local var_6_0

		if arg_6_1 ~= ccui.TouchEventType.ended then
			do return end

			var_6_0 = {
				itemid = 201912006
			}
		end

		function var_6_0.callback()
			if var_0_20 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_26"):setString(global_trans_number(item_manager:getItemNumber(var_0_27[3])))
			end
		end

		LayerManager:pushInLayer("PopNodeOperationLayer", var_6_0)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_23"):addTouchEventListener(var_4_1)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_23").itemid = 201912006
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_23"):getChildByName("Button_87").itemid = 201912006

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_23"):getChildByName("Button_87"):addTouchEventListener(var_4_1)
	self.skillpanel:setAnchorPoint(1, 0)
	self.skillpanel:setVisible(true)
	self.skillpanel:setPositionX(643)

	if arg_4_1 then
		self.callback = arg_4_1.callback
		self.city = arg_4_1.city or 2
	end

	self.virnum = 1

	self:updateNumBtn(self.virnum)
	self.cityname:loadTexture(var_0_24[self.city], var_0_32)

	local var_4_2 = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (var_0_23[self.city] .. ".json" or var_0_23[self.city] .. ".ExportJson"))

	self.nodeLayer = var_4_2

	ccui.Helper:seekWidgetByName(var_4_2, "Image_2"):loadTexture(var_0_17)

	local var_4_3 = ccui.Helper:seekWidgetByName(var_4_2, "Image_2"):getContentSize()

	self.research_btn = ccui.Helper:seekWidgetByName(self.nodeLayer, "btn_research")

	ccui.Helper:seekWidgetByName(var_4_2, "Image_2"):setVisible(true)
	self.research_btn:getVirtualRenderer():setOpacity(0)
	self:createNodeImg(self.city)
	self:createNodeLine(self.city)

	local var_4_4 = ccui.Layout:create()

	var_4_4:setContentSize(cc.size(906, 2014))
	var_4_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_4_4:setAnchorPoint(0.5, 0.5)
	var_4_4:setBackGroundColor(cc.c3b(0, 0, 0))
	var_4_4:setOpacity(160)
	var_4_4:setTouchEnabled(true)
	var_4_4:setPosition(ccui.Helper:seekWidgetByName(var_4_2, "Image_2"):getPosition())
	var_4_4:setVisible(false)
	var_4_4:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:updateUIOrder(false)
		self:updateChoeseFrame()
	end)
	self.nodeLayer:addChild(var_4_4, 1)

	self.skill_select_panel = var_4_4

	local var_4_5 = ccui.Layout:create()

	var_4_5:setContentSize(cc.size(906, 2014))
	var_4_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_4_5:setAnchorPoint(0.5, 0.5)
	var_4_5:setBackGroundColor(cc.c3b(0, 0, 0))
	var_4_5:setOpacity(0)
	var_4_5:setTouchEnabled(true)
	var_4_5:setPosition(ccui.Helper:seekWidgetByName(var_4_2, "Image_2"):getPosition())
	self.nodeLayer:addChild(var_4_5, 2)
	var_4_5:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.nodeinfo_panel:setVisible(false)
		self.sinceinfo_panel:setVisible(false)
		self:updateChoeseFrame()
		arg_9_0:setVisible(false)
	end)
	self.returnBtn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.nodeinfo_panel:setVisible(false)
		self.sinceinfo_panel:setVisible(false)
		self:updateChoeseFrame()
	end)

	self.operate_node_layer = var_4_5

	self.operate_node_layer:setVisible(false)
	self.scollpanel:removeAllChildren()
	self.scollpanel:addChild(var_4_2, 5)
	self.scollpanel:setInnerContainerSize(var_4_3)
	self.scollpanel:setContentSize(GameDisplay.getScreenSize())
	var_4_2:setPositionX((var_4_3.width - 640) / 2)
	var_4_2:setPositionY((var_4_3.height - 1136) / 2)
	self.scollpanel:scrollToPercentBothDirection(cc.p(40, 40), 0.2, false)
	self.btn_broadcast:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_11_0:setBright(false)
		LayerManager:pushInLayer("PopDroadcastLayer", {
			callback = function()
				if var_0_20 then
					arg_11_0:setBright(true)
				end
			end
		})
	end)
	self:getDataFromServer()
	self:initBottomBtnList()
	self:registerActivityEventListener()
	self:fullScreen()

	self.next_round_time = -1
	self.actScheduler = self.actScheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		self:getNextRoundTimeFromServer()
	end, 2, false)

	self:registerScriptHandler(function(arg_14_0)
		if arg_14_0 == "exit" then
			if self.actScheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.actScheduler)

				self.actScheduler = nil
			end

			activity_manager:releaseEventListenerByName("DoubleHoliday_CityNodeLayer")

			var_0_20 = nil

			if self.buffScheduler then
				time_check_manager:removeUpdatePool(self.buffScheduler)
			end

			if self.callback then
				self.callback()
			end
		end
	end)
end

function DoubleHoliday_CityNodeLayer.registerActivityEventListener(arg_15_0)
	activity_manager:registerEventListener("DoubleHoliday_CityNodeLayer", activity_manager.activityEventId.TECHNOLOGY_TREE_DATA_UPDATE, function(arg_16_0)
		arg_15_0:updateTecNumber()
	end)
	activity_manager:registerEventListener("DoubleHoliday_CityNodeLayer", activity_manager.activityEventId.TECHNOLOGY_LEVEL_UP_SECCESS, function(arg_17_0)
		arg_15_0:updateTecNumber()
	end)
end

function DoubleHoliday_CityNodeLayer:updateTecNumber()
	ccui.Helper:seekWidgetByName(self.title, "Label_25"):setString(global_trans_number(item_manager:getItemNumber(var_0_27[2])))
end

function DoubleHoliday_CityNodeLayer.createSkillPanel(arg_19_0)
	return
end

function DoubleHoliday_CityNodeLayer:skill_judgement()
	local var_20_0 = activity_plague_skill_data[self.skill_id].desc
	local var_20_1 = activity_plague_skill_data[self.skill_id].num
	local var_20_2 = activity_plague_skill_data[self.skill_id].itemid
	local var_20_3 = activity_plague_skill_data[self.skill_id].target
	local var_20_4 = item_manager:getItemNumber(activity_plague_skill_data[self.skill_id].itemid)
	local var_20_5

	if var_20_4 and var_20_1 and var_20_4 < var_20_1 then
		var_20_0 = L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_1 .. activity_plague_skill_data[self.skill_id].diamond .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_2
		var_20_2 = "diamond"
		var_20_4 = var_0_6.diamond
		var_20_1 = activity_plague_skill_data[self.skill_id].diamond
		var_20_5 = {}
	end

	function var_20_5.surecallback()
		if var_20_3 ~= 1 then
			self:updateUIOrder(true)
		end
	end

	function var_20_5.cancelcallback()
		if callback then
			callback()
		end
	end

	var_20_5.cost = var_20_1
	var_20_5.own = var_20_4
	var_20_5.costtype = var_20_2
	var_20_5.labels = {
		button = L_GO_BUY_SCOREARENA_TIMES.button,
		title = activity_plague_skill_data[self.skill_id].name,
		des = var_20_0
	}

	if var_20_2 then
		if var_20_4 and var_20_1 and var_20_4 < var_20_1 and activity_plague_skill_data[self.skill_id].diamond then
			LayerManager:pushInLayer("PopDoLayer", var_20_5)
		else
			self:updateUIOrder(true)
		end
	elseif activity_plague_skill_data[self.skill_id].target == 2 then
		self:updateUIOrder(true)
	else
		local function var_20_7()
			self:pushSkillToNode(nil, nil)
		end

		local var_20_8 = {
			button = L_GO_BUY_SCOREARENA_TIMES.button,
			title = activity_plague_skill_data[self.skill_id].name,
			des = var_20_0
		}

		LayerManager:pushInLayer("PopDoLayer", var_20_2 and var_20_4 and var_20_1 and {
			surecallback = var_20_7,
			cancelcallback = function()
				if callback then
					callback()
				end
			end,
			cost = var_20_1,
			own = var_20_4,
			costtype = var_20_2,
			labels = var_20_8
		} or {
			surecallback = var_20_7,
			cancelcallback = function()
				if callback then
					callback()
				end
			end,
			labels = var_20_8
		})
	end
end

function DoubleHoliday_CityNodeLayer:updateUIOrder(arg_26_1)
	if arg_26_1 then
		self.scollpanel:setLocalZOrder(6)
	else
		self.scollpanel:setLocalZOrder(0)
	end

	self.skill_select_panel:setVisible(arg_26_1)
	self.tips_skill:setVisible(arg_26_1)
end

function DoubleHoliday_CityNodeLayer:createNodeImg(arg_27_1)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(activity_plague_data) do
		if iter_27_1.cityid == arg_27_1 then
			table.insert(var_27_0, iter_27_1)
		end
	end

	while ccui.Helper:seekWidgetByName(self.nodeLayer, "Node" .. 1) do
		local var_27_1 = ccui.Helper:seekWidgetByName(self.nodeLayer, "Node" .. 1)

		var_27_1:setLocalZOrder(3)

		local var_27_2
		local var_27_4 = 10
		local var_27_5 = -8
		local var_27_6 = -28
		local var_27_7 = 10
		local var_27_8 = cc.Label:createWithTTF(var_27_0[1].nodename, "fonts/name.ttf", 19)

		var_27_8:setAnchorPoint(cc.p(0, 0.5))

		if var_27_0[1].nodetype == 0 then
			var_27_2 = ccui.Button:create(var_0_26[1], nil, var_0_26[1], var_0_32)
			var_27_5 = 0
			var_27_4 = 10
		elseif var_27_0[1].nodetype == 1 then
			var_27_2 = ccui.Button:create(var_0_26[2], nil, var_0_26[2], var_0_32)

			if var_27_0[1].subtype and var_27_0[1].subtype == 0 then
				-- block empty
			end
		elseif var_27_0[1].nodetype == 2 then
			var_27_2 = ccui.Button:create(var_0_26[3], nil, var_0_26[3], var_0_32)

			if var_27_0[1].subtype and var_27_0[1].subtype == 0 then
				-- block empty
			end
		elseif var_27_0[1].nodetype == 3 then
			var_27_2 = ccui.Button:create(var_0_26[4], nil, var_0_26[4], var_0_32)

			if var_27_0[1].subtype and var_27_0[1].subtype == 0 then
				-- block empty
			end
		end

		var_27_2:setName("btn_node" .. 1)
		var_27_2:setPosition(cc.p(0 + var_27_4, var_27_2:getContentSize().height / 2 + var_27_5))
		var_27_2:addChild(var_27_8, 1)
		var_27_8:setPosition(cc.p(var_27_2:getContentSize().width / 2 + var_27_6, var_27_2:getContentSize().height / 2 + var_27_7))
		var_27_1:addChild(var_27_2, 3)
	end

	local var_27_10 = ccui.ImageView:create("doubleholiday_city/next_round.png", var_0_32)

	var_27_10:setPosition(cc.p(self.guaji_btn:getPositionX(), self.guaji_btn:getPositionY() - self.guaji_btn:getContentSize().height / 2 - 38))
	var_27_10:setName("next_round_time")
	self.panel_ml:addChild(var_27_10, 5)

	local var_27_11 = cc.Label:createWithTTF(L_DOUBLEHOLIDAY_WOLDCITYLAYER.NOSTART, "fonts/name.ttf", 22)

	var_27_11:setAnchorPoint(cc.p(0, 0.5))
	var_27_11:setName("next_lable")
	var_27_11:setPosition(cc.p(100, var_27_10:getContentSize().height / 2))
	var_27_10:addChild(var_27_11)
end

function DoubleHoliday_CityNodeLayer:createNodeLine(arg_28_1)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(activity_plague_data) do
		if iter_28_1.cityid == arg_28_1 then
			table.insert(var_28_0, iter_28_1)
		end
	end

	table.sort(var_28_0, function(arg_29_0, arg_29_1)
		return arg_29_0.nodeid < arg_29_1.nodeid
	end)

	local var_28_1 = {}
	local var_28_2 = {}

	for iter_28_2 = 1, #var_28_0 do
		local var_28_3 = {}

		for iter_28_3 in var_28_0[iter_28_2].neighbor:gmatch("%d+") do
			table.insert(var_28_3, iter_28_3)
		end

		for iter_28_4, iter_28_5 in pairs(var_28_3) do
			if not var_28_2[iter_28_2 .. iter_28_5] and not var_28_2[iter_28_5 .. iter_28_2] then
				local var_28_4 = ccui.Helper:seekWidgetByName(self.nodeLayer, "Node" .. iter_28_2)
				local var_28_5 = ccui.Helper:seekWidgetByName(self.nodeLayer, "Node" .. activity_plague_data[tonumber(iter_28_5)].nodeid)

				var_28_2[iter_28_2 .. iter_28_5] = {
					self.nodeLayer:convertToWorldSpace(cc.p(var_28_4:getPosition())),
					(self.nodeLayer:convertToWorldSpace(cc.p(var_28_5:getPosition())))
				}
			end
		end
	end

	for iter_28_6, iter_28_7 in pairs(var_28_2) do
		table.insert(var_28_1, iter_28_7)
	end

	local var_28_6 = LinkNode:create("mainScenebg/lineblue.png", var_28_1)

	self.nodeLayer:addChild(var_28_6, -1)
	var_28_6:setPosition(0, 0)
end

local function var_0_33(arg_30_0)
	if not arg_30_0 then
		return
	end

	if arg_30_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_30_0 / 86400), math.floor(arg_30_0 % 86400 / 3600))
	elseif arg_30_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_30_0 / 3600), math.floor(arg_30_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_30_0 / 60))
	end
end

function DoubleHoliday_CityNodeLayer:updateBroadCastPanel(arg_31_1)
	local var_31_0 = ccui.Helper:seekWidgetByName(self.panel_mr, "Label_31")

	var_31_0:getVirtualRenderer():setMaxLineWidth(216)

	local var_31_1 = L_DOUBLEHOLIDAY_WOLDCITYLAYER.NONEWS
	local var_31_2 = {
		cityname = function(arg_32_0)
			return activity_plague_city_data[arg_32_0].name
		end,
		nodename = function(arg_33_0)
			local var_33_0 = ""

			if type(arg_33_0) == "number" then
				var_33_0 = activity_plague_data[arg_33_0].nodename
			elseif type(arg_33_0) == "table" then
				for iter_33_0, iter_33_1 in ipairs(arg_33_0) do
					var_33_0 = var_33_0 .. activity_plague_data[iter_33_1].nodename .. ((iter_33_0 == #arg_33_0 or nil) and "")
				end
			end

			return var_33_0
		end,
		date = function(arg_34_0)
			return (var_0_33(arg_34_0))
		end,
		value = function(arg_35_0)
			return global_trans_number(arg_35_0)
		end
	}

	if arg_31_1 and next(arg_31_1) then
		var_31_1 = string.gsub(activity_plague_message_data[arg_31_1.id].msg, "(%w+)|(%w+)", function(arg_36_0, arg_36_1)
			return var_31_2[arg_36_0] and arg_31_1[arg_36_1] and var_31_2[arg_36_0](arg_31_1[arg_36_1]) or arg_31_1[arg_36_1]
		end)

		if arg_31_1.new then
			var_31_1 = "【NEW】" .. var_31_1
		end
	end

	var_31_0:setString(var_31_1)
end

function DoubleHoliday_CityNodeLayer:updateNextRoundTime()
	local var_37_0 = self.next_round_time

	ccui.Helper:seekWidgetByName(self.panel_ml, "next_round_time"):getChildByName("next_lable"):scheduleUpdateWithPriorityLua(function(arg_38_0)
		local var_38_0 = var_37_0 - time_check_manager:getCurTime()

		if var_38_0 < 0 then
			ccui.Helper:seekWidgetByName(self.panel_ml, "next_round_time"):getChildByName("next_lable"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.NOSTART)
		else
			ccui.Helper:seekWidgetByName(self.panel_ml, "next_round_time"):getChildByName("next_lable"):setString((function(arg_39_0)
				if arg_39_0 >= 3600 then
					return string.format("%dh%dm", math.floor(arg_39_0 / 3600), math.floor(arg_39_0 % 3600 / 60))
				elseif arg_39_0 >= 60 and arg_39_0 < 3600 then
					return string.format("%dm%ds", math.floor(arg_39_0 / 60), arg_39_0 % 60)
				else
					return string.format("%ds", arg_39_0)
				end
			end)(var_38_0))
		end
	end, 0)
end

function DoubleHoliday_CityNodeLayer:initUI(arg_40_1)
	if arg_40_1 and arg_40_1.damage == 100 and not arg_40_1.story then
		local function var_40_0(arg_41_0)
			activity_doubleholiday_manager:finish_citystory(12, self.city, function(arg_42_0)
				if arg_42_0.result ~= 0 then
					self:pushResultPanel()
					self:updateNodeStatus(arg_40_1)
					self:updateSkillPanel(arg_40_1)
					self:updateBroadCastPanel(arg_40_1.news)
				end
			end)
		end

		if activity_plague_city_data[self.city].classification then
			global_basic_scene:addChild(TalkLayer:create(activity_plague_city_data[self.city].classification, nil, TALK_TYPE_TRAVEL, "", var_40_0), ZORDER_TALKLAYER)
		elseif var_40_0 then
			var_40_0()
		end
	else
		self:pushResultPanel()
		self:updateNodeStatus(arg_40_1)
		self:updateBroadCastPanel(arg_40_1.news)
		self:updateCityBuffsUI(arg_40_1.buffs)
	end
end

function DoubleHoliday_CityNodeLayer:updateCityBuffsUI(arg_43_1)
	local var_43_0 = self.panel_ml:getChildByName("buffs_panel")

	if var_43_0 then
		var_43_0:removeFromParent()
	end

	if self.buffScheduler then
		time_check_manager:removeUpdatePool(self.buffScheduler)
	end

	if not arg_43_1 or not next(arg_43_1) then
		return
	end

	local var_43_1 = ccui.Layout:create()

	var_43_1:setPosition(cc.p(290, 14))
	var_43_1:setName("buffs_panel")
	self.panel_ml:addChild(var_43_1, 999)

	for iter_43_0, iter_43_1 in pairs(arg_43_1) do
		if iter_43_1.round and iter_43_1.round > 0 then
			local var_43_2 = ccui.Layout:create()
			local var_43_3 = ccui.ImageView:create("Activity_doubleholiday/buff_" .. iter_43_1.buffid .. ".png", var_0_32)

			var_43_3:setPositionX(-60)
			var_43_3:setTouchEnabled(true)
			var_43_3:addTouchEventListener(function(arg_44_0, arg_44_1)
				if arg_44_1 ~= ccui.TouchEventType.ended then
					return
				end

				global_show_data_bubble(arg_44_0, self, nil, activity_plague_skill_data[iter_43_1.buffid].desc, nil, nil, (iter_43_0 == 1 or nil) and 120)
			end)

			local var_43_4 = cc.Label:createWithTTF("", "fonts/name.ttf", 19)

			var_43_4:setString(iter_43_1.round .. L_ACTIVITY_DOULE_HOLIDAY.ROUND)
			var_43_2:addChild(var_43_3)
			var_43_2:addChild(var_43_4)
			var_43_2:setPositionY((1 - iter_43_0) * 45)
			var_43_1:addChild(var_43_2, 100 - iter_43_0)
		elseif iter_43_1.time then
			local var_43_5 = iter_43_1.time - time_check_manager:getCurTime()

			if var_43_5 > 0 then
				local var_43_6 = ccui.Layout:create()
				local var_43_7 = ccui.ImageView:create("Activity_doubleholiday/buff_" .. iter_43_1.buffid .. ".png", var_0_32)

				var_43_7:setPositionX(-60)
				var_43_7:setTouchEnabled(true)
				var_43_7:addTouchEventListener(function(arg_45_0, arg_45_1)
					if arg_45_1 ~= ccui.TouchEventType.ended then
						return
					end

					global_show_data_bubble(arg_45_0, self, nil, activity_plague_skill_data[iter_43_1.buffid].desc, nil, nil, (iter_43_0 == 1 or nil) and 120)
				end)

				local var_43_8 = cc.Label:createWithTTF("", "fonts/name.ttf", 19)

				var_43_6:addChild(var_43_7)
				var_43_6:addChild(var_43_8)

				self.buffScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_43_5, function(arg_46_0)
					var_43_8:setString(arg_46_0 .. "s")

					if arg_46_0 <= 0 and self.buffScheduler then
						time_check_manager:removeUpdatePool(self.buffScheduler)

						self.buffScheduler = nil

						var_43_6:removeFromParent()
					end
				end)))

				var_43_6:setPositionY((1 - iter_43_0) * 45)
				var_43_1:addChild(var_43_6, 100 - iter_43_0)
			end
		end
	end
end

function DoubleHoliday_CityNodeLayer:pushResultPanel()
	if self.damage == 100 then
		self.pass_city_panel:setVisible(true)
		self.pass_city_panel:getChildByName("Image_151"):getChildByName("Label_88"):setString("城市已攻略")
		self.pass_city_panel:getChildByName("Image_151"):getChildByName("Label_88"):setColor(cc.c3b(0, 0, 0))
		self.pass_city_panel:getChildByName("Image_151"):getChildByName("Label_113"):setVisible(true)

		self.result = 1

		self:playResultAin(self.pass_city_panel, self.result)
		self.pass_city_panel:getChildByName("Image_151"):loadTexture("doubleholiday_city/re_yes.png", var_0_32)
		RoleDefault:getInstance():setBoolForKey("First_result_moment1_" .. self.city, true)
		self.operate_node_layer:setVisible(false)
		self.nodeinfo_panel:setVisible(false)
		self.sinceinfo_panel:setVisible(false)
	else
		self.pass_city_panel:setVisible(false)

		if self.decode == 100 then
			self.pass_city_panel:setVisible(true)
			self.pass_city_panel:getChildByName("Image_151"):getChildByName("Label_88"):setString("模拟失败")
			self.pass_city_panel:getChildByName("Image_151"):getChildByName("Label_88"):setColor(cc.c3b(0, 0, 0))
			self.pass_city_panel:getChildByName("Image_151"):loadTexture("doubleholiday_city/re_no.png", var_0_32)
			self.pass_city_panel:getChildByName("Image_151"):getChildByName("Label_113"):setVisible(false)

			self.result = 2

			self:playResultAin(self.pass_city_panel, self.result)
			RoleDefault:getInstance():setBoolForKey("First_result_moment1_" .. self.city, true)
			self.operate_node_layer:setVisible(false)
			self.nodeinfo_panel:setVisible(false)
			self.sinceinfo_panel:setVisible(false)
		else
			self.pass_city_panel:setVisible(false)
		end
	end
end

function DoubleHoliday_CityNodeLayer:getDataFromServer()
	activity_doubleholiday_manager:get_worldnode_info(12, self.city, function(arg_49_0)
		if arg_49_0.result ~= 0 then
			self.data = arg_49_0
			self.data = arg_49_0
			self.damage = arg_49_0.damage
			self.decode = arg_49_0.decode
			self.result = nil

			self:initUI(self.data)

			self.next_round_time = arg_49_0.next_round_time

			self:updateNextRoundTime()
		else
			LayerManager:switchShowLayer("DoubleHoliday_WoldCityLayer_2")
		end
	end)
	activity_doubleholiday_manager:get_skill_info(12, function(arg_50_0)
		if arg_50_0.result ~= 0 then
			self.skilldata = arg_50_0.list

			self:updateSkillPanel(self.skilldata)
		end
	end)
end

function DoubleHoliday_CityNodeLayer:playResultAin(arg_51_1, arg_51_2)
	local var_51_0 = cc.Sequence:create(cc.ScaleTo:create(0.5, 1.5), cc.ScaleTo:create(1, 1))

	if arg_51_2 == 1 then
		if not RoleDefault:getInstance():getBoolForKey("First_result_moment1_" .. self.city) then
			arg_51_1:getChildByName("Image_151"):runAction(var_51_0)

			goto label_51_0
		end
	end

	if arg_51_2 == 2 then
		if not RoleDefault:getInstance():getBoolForKey("First_result_moment2_" .. self.city) then
			arg_51_1:getChildByName("Image_151"):runAction(var_51_0)
			RoleDefault:getInstance():setBoolForKey("First_result_moment2_" .. self.city, true)
		end
	end

	::label_51_0::
end

function DoubleHoliday_CityNodeLayer:getNextRoundTimeFromServer()
	local var_52_0 = time_check_manager:getCurTime()

	if self.next_round_time == -1 then
		-- block empty
	elseif self.next_round_time and var_52_0 >= self.next_round_time then
		self:getDataFromServer()
	end

	if var_52_0 >= activity_doubleholiday_manager:get_recover_time() then
		activity_doubleholiday_manager:recover_virus(12, function(arg_53_0)
			if arg_53_0 ~= 0 then
				global_get(arg_53_0.virus)
				global_get({
					items = {
						arg_53_0.virus
					}
				})
			end
		end)
	end
end

function DoubleHoliday_CityNodeLayer:updateNodeStatus(arg_54_1)
	if not arg_54_1.nodes then
		return
	end

	for iter_54_0 = 1, #arg_54_1.nodes do
		local var_54_0 = ccui.Helper:seekWidgetByName(self.nodeLayer, "Node" .. iter_54_0):getChildByName("btn_node" .. iter_54_0)
		local var_54_1
		local var_54_3
		local var_54_4

		for iter_54_1, iter_54_2 in pairs(arg_54_1.nodes) do
			if iter_54_0 == activity_plague_data[iter_54_2.nodeid].nodeid then
				var_54_1 = iter_54_2
				var_54_3 = activity_plague_data[iter_54_2.nodeid].nodetype
				var_54_4 = iter_54_2.nodeid

				break
			end
		end

		var_54_0._id = var_54_4

		if not var_54_0:getChildByName("Nodebar") then
			local var_54_5 = cc.Node:create()

			var_54_5:setPosition(cc.p(var_54_0:getContentSize().width / 2, var_54_0:getContentSize().height + 3))
			var_54_5:setName("Nodebar")

			local var_54_6 = ccui.Slider:create()

			var_54_6:loadBarTexture("Activity_doubleholiday/pohuai1.png", var_0_32)
			var_54_6:loadProgressBarTexture("Activity_doubleholiday/pohuai2.png", var_0_32)

			if var_54_3 == 0 then
				var_54_6:setScaleX(var_0_25[1])
			else
				var_54_6:setScaleX(var_0_25[2])
			end

			var_54_6:setPercent(20)
			var_54_6:setName("bar")
			var_54_5:addChild(var_54_6, 2)

			local var_54_7 = cc.Label:createWithTTF("0%", "fonts/name.ttf", 20)

			var_54_7:setAnchorPoint(cc.p(0, 0.5))
			var_54_7:setName("numlable")
			var_54_7:setPosition(cc.p(var_54_6:getContentSize().width * var_54_6:getScaleX() / 2 - 30, 17))
			var_54_5:addChild(var_54_7, 3)
			var_54_0:addChild(var_54_5, 999)
		end

		if var_54_1.damage and var_54_1.damage >= 0 then
			var_54_0:getChildByName("Nodebar"):getChildByName("bar"):setPercent(var_54_1.damage)
			var_54_0:getChildByName("Nodebar"):getChildByName("numlable"):setString("" .. var_54_1.damage .. "%")
			var_54_0:getChildByName("Nodebar"):setVisible(true)
		else
			var_54_0:getChildByName("Nodebar"):setVisible(false)
		end

		ccui.Helper:seekWidgetByName(self.panel_ml, "Label_28"):setString("" .. arg_54_1.damage .. "%")
		var_54_0:addTouchEventListener(function(arg_55_0, arg_55_1)
			if arg_55_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_55_0.type = var_54_3
			self.select_node = var_54_4

			self:updateChoeseFrame(self.select_node)

			if not self.skill_select_panel:isVisible() then
				self:nodeOperationLayer({
					city = self.city,
					nodetype = arg_55_0.type,
					baseinfo = var_54_1,
					callback = callback
				})
			else
				self:pushSkillToNode(var_54_0._id, callback)
			end
		end)
	end

	ccui.Helper:seekWidgetByName(self.title, "Label_24"):setString(global_trans_number(item_manager:getItemNumber(var_0_27[1])))
	ccui.Helper:seekWidgetByName(self.title, "Label_25"):setString(global_trans_number(item_manager:getItemNumber(var_0_27[2])))
	ccui.Helper:seekWidgetByName(self.title, "Label_26"):setString(global_trans_number(item_manager:getItemNumber(var_0_27[3])))

	if arg_54_1.decode == -1 then
		self.research_btn:getVirtualRenderer():setOpacity(0)
		self.research_btn:setEnabled(false)

		if self.research_btn:getChildByName("Nodebar") then
			self.research_btn:getChildByName("Nodebar"):removeFromParent()
			self.research_btn:getChildByName("numlable"):removeFromParent()
		end
	else
		self.research_btn:getVirtualRenderer():setOpacity(255)
		self.research_btn:setEnabled(true)

		if not self.research_btn:getChildByName("Nodebar") then
			local var_54_8 = ccui.Slider:create()

			var_54_8:loadBarTexture("Activity_doubleholiday/poyi1.png", var_0_32)
			var_54_8:loadProgressBarTexture("Activity_doubleholiday/poyi2.png", var_0_32)
			var_54_8:setPercent(0)
			var_54_8:setPosition(cc.p(self.research_btn:getContentSize().width / 2, self.research_btn:getContentSize().height + 10))
			var_54_8:setName("Nodebar")
			self.research_btn:addChild(var_54_8, 9)

			local var_54_9 = cc.Label:createWithTTF("0%", "fonts/name.ttf", 20)

			var_54_9:setAnchorPoint(cc.p(0, 0.5))
			var_54_9:setName("numlable")
			var_54_9:setPosition(cc.p(self.research_btn:getContentSize().width / 2 + 20, self.research_btn:getContentSize().height + 26))
			self.research_btn:addChild(var_54_9, 999)
		end

		self.research_btn:getChildByName("Nodebar"):setPercent(arg_54_1.decode)
		self.research_btn:getChildByName("numlable"):setString("" .. arg_54_1.decode .. "%")
		self.research_btn:addTouchEventListener(function(arg_56_0, arg_56_1)
			if arg_56_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_56_0.type = 4

			self:nodeOperationLayer({
				city = self.city,
				nodetype = arg_56_0.type,
				callback = callback
			})
		end)
	end

	if self.select_node then
		local var_54_10
		local var_54_11

		for iter_54_3, iter_54_4 in pairs(arg_54_1.nodes) do
			if self.select_node == iter_54_4.nodeid then
				var_54_11 = iter_54_4
				var_54_10 = activity_plague_data[self.select_node].nodetype

				break
			end
		end

		self:updateNode(var_54_10, var_54_11)
	end

	self:updateNode(4, nil)
end

function DoubleHoliday_CityNodeLayer:nodeOperationLayer(arg_57_1)
	self:updateNode(arg_57_1.nodetype, arg_57_1.baseinfo)
	self.operate_node_layer:setVisible(true)

	if arg_57_1.nodetype ~= 4 then
		self.nodeinfo_panel:setPosition(cc.p(320, self.bottomlist:getPositionY() + self.nodeinfo_panel:getContentSize().height / 2))
		self.nodeinfo_panel:setLocalZOrder(self.bottomlist:getLocalZOrder() + 1)
		self.sinceinfo_panel:setPositionX(-1500)
		self.nodeinfo_panel:setVisible(true)

		for iter_57_0 = 1, 2 do
			ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "num_btn_" .. iter_57_0):addTouchEventListener(function(arg_58_0, arg_58_1)
				if arg_58_1 ~= ccui.TouchEventType.ended then
					return
				end

				arg_58_0.num = iter_57_0 == 1 and 1 or 10
				self.virnum = arg_58_0.num

				self:updateNumBtn(self.virnum)
			end)
		end

		for iter_57_1 = 1, 3 do
			local var_57_0 = ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "btn_" .. iter_57_1)

			var_57_0:addTouchEventListener(function(arg_59_0, arg_59_1)
				if arg_59_1 ~= ccui.TouchEventType.ended then
					return
				end

				print("|||||||||||||||node||||||||||||||||", var_57_0:isBright())

				if not arg_59_0:isBright() then
					return
				end

				arg_59_0:setBright(false)

				local function var_59_0()
					if var_0_20 then
						print("?????????PopNodeOperationLayer????callback????????")
						arg_59_0:setBright(true)
					end
				end

				arg_59_0.tag = iter_57_1 + 1

				print(">>>>>>>>>>>>>>>>>>>>push_virus>>>>>>>>>>>>>>>>>>>", arg_57_1.city, arg_57_1.baseinfo.nodeid, arg_59_0.tag, self.virnum)
				activity_doubleholiday_manager:push_virus(12, arg_57_1.city, arg_57_1.baseinfo.nodeid, arg_59_0.tag, self.virnum, function(arg_61_0)
					if arg_61_0.result == 0 then
						global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.PUSHVIRUS[1])
					elseif arg_61_0.result == 1 then
						global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.PUSHVIRUS[2])
						self:subCost(arg_61_0.stock_cost)

						self.nodedata = arg_61_0.node

						self:updateNode(activity_plague_data[self.nodedata.nodeid].nodetype, self.nodedata)
						self:updateRoundTime(arg_61_0.next_round_time)
						self:getDataFromServer()
					elseif arg_61_0.result == 2 then
						global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.PUSHVIRUS[3])
					elseif arg_61_0.result == 3 then
						global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.PUSHVIRUS[4])
					elseif arg_61_0.result == 4 then
						global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.PUSHVIRUS[5])
					elseif arg_61_0.result == 5 then
						global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.PUSHVIRUS[6])
					end

					if var_59_0 then
						var_59_0()
					end
				end)
			end)
		end
	else
		self.sinceinfo_panel:setPosition(cc.p(320, self.bottomlist:getPositionY() + self.sinceinfo_panel:getContentSize().height / 2))
		self.sinceinfo_panel:setLocalZOrder(self.bottomlist:getLocalZOrder() + 1)
		self.nodeinfo_panel:setPositionX(-1500)
		self.sinceinfo_panel:setVisible(true)
	end
end

function DoubleHoliday_CityNodeLayer:updateNumBtn(arg_62_1)
	if arg_62_1 == 1 then
		ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "num_btn_1"):loadTextures(var_0_30[2], nil, var_0_30[2], var_0_32)
		ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "num_btn_2"):loadTextures(var_0_30[3], nil, var_0_30[3], var_0_32)
	else
		ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "num_btn_1"):loadTextures(var_0_30[1], nil, var_0_30[1], var_0_32)
		ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "num_btn_2"):loadTextures(var_0_30[4], nil, var_0_30[4], var_0_32)
	end
end

function DoubleHoliday_CityNodeLayer:updateNode(arg_63_1, arg_63_2)
	if arg_63_1 ~= 4 then
		ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "Label_94"):setString("" .. arg_63_2.damage .. "%")

		if arg_63_2.damage_remain <= 0 then
			if arg_63_2.damage_remain == -1 then
				ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "Label_96"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.NODAMAGE)
			else
				ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "Label_96"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.HAVEDAMAGE)
			end
		else
			ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "Label_96"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_3 .. string.format("%02d:%02d", math.floor(arg_63_2.damage_remain / 60), arg_63_2.damage_remain % 60) .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_4)
		end

		local var_63_1

		if arg_63_2.capacity then
			var_63_1 = arg_63_2.capacity or var_0_31
		end

		local var_63_2 = 0

		for iter_63_0 = 1, 3 do
			local var_63_3 = false
			local var_63_4

			for iter_63_1, iter_63_2 in ipairs(arg_63_2.viruses) do
				if iter_63_0 == iter_63_2.virusid - 1 then
					var_63_3 = true
					var_63_4 = iter_63_2
					var_63_2 = var_63_2 + iter_63_2.num
				end
			end

			if var_63_3 then
				ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "label_node_" .. iter_63_0):getChildByName("Label_101"):setString(var_63_4.num .. "TB")
				ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "label_node_" .. iter_63_0):getChildByName("Image_100"):setScaleX((var_63_4.num / var_63_1 > 1 or nil) and 0.8)
			else
				ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "label_node_" .. iter_63_0):getChildByName("Label_101"):setString("0" .. "TB")
				ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "label_node_" .. iter_63_0):getChildByName("Image_100"):setScaleX(0)
			end
		end

		ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "Label_98"):setString(var_63_2 .. "/" .. var_63_1 .. "TB")
		ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "label_node_4"):getChildByName("Label_101"):setString(arg_63_2.breed .. "TB/H")
		ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "Label_92"):setString(activity_plague_data[arg_63_2.nodeid].desc)
		ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "Label_89"):setString(glabal_trans_text_horizontal_to_vertical(activity_plague_data[arg_63_2.nodeid].nodename))
		ccui.Helper:seekWidgetByName(self.nodeinfo_panel, "Label_91"):setString(L_ACTIVITY_DOULE_HOLIDAY.NODE_CUR_DEFENSE .. arg_63_2.defense)
		self:updateCityNodeBuffsUI(arg_63_2.buffs)
	else
		ccui.Helper:seekWidgetByName(self.sinceinfo_panel, "Label_94"):setString(self.data.decode .. "%")
		ccui.Helper:seekWidgetByName(self.sinceinfo_panel, "Label_89"):setString(glabal_trans_text_horizontal_to_vertical(L_DOUBLEHOLIDAY_WOLDCITYLAYER.SCIENE))
		ccui.Helper:seekWidgetByName(self.sinceinfo_panel, "Image_90"):getChildByName("Label_92"):setString(activity_plague_other_data.sciencecenter_desc.rule)

		if self.data.decode_reamin <= 0 then
			if self.data.decode_reamin == -1 then
				ccui.Helper:seekWidgetByName(self.sinceinfo_panel, "Label_96"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.NODECODE)
			else
				ccui.Helper:seekWidgetByName(self.sinceinfo_panel, "Label_96"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.HAVEFECODE)
			end
		else
			ccui.Helper:seekWidgetByName(self.sinceinfo_panel, "Label_96"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_3 .. string.format("%02d:%02d", math.floor(self.data.decode_reamin / 60), self.data.decode_reamin % 60) .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_5)
		end
	end
end

function DoubleHoliday_CityNodeLayer:updateCityNodeBuffsUI(arg_64_1)
	local var_64_0 = self.nodeinfo_panel:getChildByName("buffs_panel")

	if var_64_0 then
		var_64_0:removeFromParent()
	end

	if not arg_64_1 or not next(arg_64_1) then
		return
	end

	local var_64_1 = ccui.Layout:create()

	var_64_1:setPosition(cc.p(600, 282))
	var_64_1:setName("buffs_panel")
	self.nodeinfo_panel:addChild(var_64_1)

	for iter_64_0, iter_64_1 in pairs(arg_64_1) do
		if iter_64_1.round and iter_64_1.round > 0 then
			local var_64_2 = ccui.Layout:create()
			local var_64_3 = ccui.ImageView:create("Activity_doubleholiday/buff_" .. iter_64_1.buffid .. ".png", var_0_32)

			var_64_3:setPositionX(-60)
			var_64_3:setTouchEnabled(true)
			var_64_3:addTouchEventListener(function(arg_65_0, arg_65_1)
				if arg_65_1 ~= ccui.TouchEventType.ended then
					return
				end

				global_show_data_bubble(arg_65_0, self, nil, activity_plague_skill_data[iter_64_1.buffid].desc, nil, nil, (iter_64_0 == 1 or nil) and 120)
			end)

			local var_64_4 = cc.Label:createWithTTF("", "fonts/name.ttf", 19)

			var_64_4:setString(iter_64_1.round .. L_ACTIVITY_DOULE_HOLIDAY.ROUND)
			var_64_2:addChild(var_64_3)
			var_64_2:addChild(var_64_4)
			var_64_2:setPositionX((1 - iter_64_0) * 120)
			var_64_1:addChild(var_64_2)
		end
	end
end

function DoubleHoliday_CityNodeLayer.updateTimeInfo(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	return
end

function DoubleHoliday_CityNodeLayer:subCost(arg_67_1)
	if not arg_67_1 then
		return
	end

	for iter_67_0, iter_67_1 in pairs(arg_67_1) do
		if iter_67_1.entityid == 0 then
			playermodel.gold = playermodel.gold - iter_67_1.num
		elseif iter_67_1.entityid == 1 then
			playermodel.diamond = playermodel.diamond - iter_67_1.num
		else
			item_manager:deleteItem(iter_67_1.entityid, iter_67_1.num)
		end
	end

	self:updateCoinShow()
end

function DoubleHoliday_CityNodeLayer:pushSkillToNode(arg_68_1, arg_68_2)
	print("?????????????????pushSkillToNode?????????????????", arg_68_1)
	activity_doubleholiday_manager:use_skill(12, self.city, arg_68_1, self.skill_id, function(arg_69_0)
		if arg_69_0.result == 0 then
			global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.USE_SKILL[1])
		elseif arg_69_0.result == 1 then
			global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.USE_SKILL[2])

			if arg_69_0.cd and arg_69_0.cd > 0 then
				self:updateShowSkillCd(self.skillnodes[arg_69_0.skillid], arg_69_0.cd)
			end

			self:getDataFromServer()
			self:subCost(arg_69_0.cost_items)
			self:updateUIOrder(false)

			if arg_69_0.diamond and arg_69_0.diamond then
				var_0_6.diamond = var_0_6.diamond - arg_69_0.diamond

				global_update_gold_stone_diamond(nil, nil, arg_69_0.diamond)
			end
		elseif arg_69_0.result == 2 then
			global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.USE_SKILL[3])
		elseif arg_69_0.result == 3 then
			global_ShowBlockWords(L_MARKET_MSG.Item_Lack)
		elseif arg_69_0.result == 4 then
			global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.USE_SKILL[4])
		elseif arg_69_0.result == 5 then
			global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.USE_SKILL[5])
		elseif arg_69_0.result == 6 then
			global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.DIM_NOT_ENOUGH)
		elseif arg_69_0.result == 7 then
			global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.USE_SKILL[6])
		elseif arg_69_0.result == 8 then
			global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.USE_SKILL[7])
		else
			global_ShowBlockWords(L_ACTIVITY_NINIFA.OTHER_ERROR)
		end

		if arg_68_2 then
			arg_68_2()
		end
	end)
end

function DoubleHoliday_CityNodeLayer:clearSkillCd(arg_70_1)
	activity_doubleholiday_manager:clear_skill_cd(12, self.skill_id, function(arg_71_0)
		if arg_71_0.result == 0 then
			global_ShowBlockWords(L_ACTIVITY_NINIFA.OTHER_ERROR)
		elseif arg_71_0.result == 1 then
			global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.CLEAR_SKILL_CD)
			self:updateShowSkillCd(self.skillnodes[self.skill_id], 0)

			if arg_71_0.diamond then
				var_0_6.diamond = var_0_6.diamond - arg_71_0.diamond

				global_update_gold_stone_diamond(nil, nil, arg_71_0.diamond)
			end
		elseif arg_71_0.result == 2 then
			global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.DIM_NOT_ENOUGH)
		else
			global_ShowBlockWords(L_ACTIVITY_NINIFA.OTHER_ERROR)
		end

		if arg_70_1 then
			arg_70_1()
		end
	end)
end

function DoubleHoliday_CityNodeLayer:updateSkillPanel(arg_72_1)
	self.skillnodes = {}

	self:updateTimeSkillNum()

	local var_72_0 = ccui.Helper:seekWidgetByName(self.skillpanel, "items_time")

	self.skillnodes[1] = var_72_0

	var_72_0:getChildByName("Button_ji"):addTouchEventListener(function(arg_73_0, arg_73_1)
		if arg_73_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.skill_id = 1

		self:pushTimeSkillPanel(activity_plague_skill_data[1].type)
	end)

	if not arg_72_1 or not next(arg_72_1) then
		for iter_72_0 = 1, 4 do
			local var_72_1 = ccui.Helper:seekWidgetByName(self.skillpanel, "items_jinen_" .. iter_72_0)
			local var_72_2 = var_72_1:getChildByName("btn_jindu")
			local var_72_3 = var_72_2:getChildByName("Label_34")
			local var_72_4 = var_72_1:getChildByName("mask_img")

			var_72_2:loadTextures(var_0_18, nil, var_0_18, var_0_32)
			var_72_3:setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.NO_SKILL)
			var_72_2:setEnabled(false)
		end
	else
		for iter_72_1 = 1, 4 do
			local var_72_5 = ccui.Helper:seekWidgetByName(self.skillpanel, "items_jinen_" .. iter_72_1)
			local var_72_6 = var_72_5:getChildByName("btn_jindu")
			local var_72_7 = var_72_6:getChildByName("Label_34")
			local var_72_8 = var_72_5:getChildByName("mask_img")

			var_72_6.tag = nil
			var_72_6.cd = nil

			if arg_72_1[iter_72_1] then
				var_72_6.tag = arg_72_1[iter_72_1].skillid
				var_72_6.cd = arg_72_1[iter_72_1].cd

				var_72_7:setString(activity_plague_technology_data[var_72_6.tag].name)

				if var_72_6.cd > 0 then
					self:updateShowSkillCd(var_72_5, var_72_6.cd)
					var_72_8:setVisible(true)
				else
					var_72_8:setVisible(false)
				end

				var_72_6:loadTextures(var_0_19 .. tostring(var_72_6.tag) .. ".png", nil, var_0_19 .. tostring(var_72_6.tag) .. ".png", var_0_32)
				var_72_6:setEnabled(true)

				self.skillnodes[var_72_6.tag] = var_72_5

				var_72_6:addTouchEventListener(function(arg_74_0, arg_74_1)
					if arg_74_1 ~= ccui.TouchEventType.ended then
						return
					end

					self.skill_id = arg_74_0.tag

					if arg_74_0.lock_cd then
						self:pushTimeSkillPanel(activity_plague_skill_data[arg_74_0.tag].type, arg_74_0.cd)
					else
						self:skill_judgement()
					end
				end)
			else
				var_72_6:loadTextures(var_0_18, nil, var_0_18, var_0_32)
				var_72_8:setVisible(false)
				var_72_6:setEnabled(false)
				var_72_7:setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.NO_SKILL)
			end
		end
	end
end

function DoubleHoliday_CityNodeLayer:updateTimeSkillNum()
	local var_75_0 = item_manager:getItemNumber(activity_plague_skill_data[1].itemid) / activity_plague_skill_data[1].num

	tostring(var_75_0)
	ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(self.skillpanel, "items_time"), "BitmapLabel_36"):setString(tostring(var_75_0))
end

function DoubleHoliday_CityNodeLayer.pushTimeSkillPanel(arg_76_0, arg_76_1, arg_76_2)
	local var_76_0 = L_DOUBLEHOLIDAY_WOLDCITYLAYER.SKILL_TIPS[1]
	local var_76_1 = L_DOUBLEHOLIDAY_WOLDCITYLAYER.SKILL_TIPS[2]
	local var_76_2 = activity_plague_skill_data[1].num
	local var_76_3 = activity_plague_skill_data[1].itemid
	local var_76_4 = item_manager:getItemNumber(activity_plague_skill_data[1].itemid)

	if var_76_4 < activity_plague_skill_data[1].num then
		var_76_1 = L_DOUBLEHOLIDAY_WOLDCITYLAYER.SKILL_TIPS[3]
		var_76_3 = "diamond"
		var_76_4 = var_0_6.diamond
		var_76_2 = activity_plague_skill_data[1].diamond
	end

	local function var_76_5()
		arg_76_0:pushSkillToNode(nil, nil)
		arg_76_0:updateTimeSkillNum()
	end

	local var_76_7

	if arg_76_1 == 2 then
		local var_76_6 = math.ceil((arg_76_2 - time_check_manager:getCurTime()) / 360)

		var_76_0 = L_DOUBLEHOLIDAY_WOLDCITYLAYER.SKILL_TIPS[4]
		var_76_1 = L_DOUBLEHOLIDAY_WOLDCITYLAYER.SKILL_TIPS[5] .. var_76_6 .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.SKILL_TIPS[6]
		var_76_2 = var_76_6
		var_76_3 = "diamond"
		var_76_4 = var_0_6.diamond

		function var_76_5()
			arg_76_0:clearSkillCd()
		end

		var_76_7 = {
			surecallback = var_76_5,
			cancelcallback = function()
				if callback then
					callback()
				end
			end,
			cost = var_76_2,
			own = var_76_4,
			costtype = var_76_3
		}
	end

	var_76_7.labels = {
		button = L_GO_BUY_SCOREARENA_TIMES.button,
		title = var_76_0,
		des = var_76_1
	}

	LayerManager:pushInLayer("PopDoLayer", var_76_7)
end

function DoubleHoliday_CityNodeLayer.updateShowSkillCd(arg_80_0, arg_80_1, arg_80_2)
	arg_80_1:scheduleUpdateWithPriorityLua(function(arg_81_0)
		local var_81_0 = arg_80_2 - time_check_manager:getCurTime()

		if var_81_0 <= 0 then
			ccui.Helper:seekWidgetByName(arg_80_1, "btn_jindu").lock_cd = false

			ccui.Helper:seekWidgetByName(arg_80_1, "Label_40"):setString("0")
			ccui.Helper:seekWidgetByName(arg_80_1, "mask_img"):setVisible(false)
		else
			ccui.Helper:seekWidgetByName(arg_80_1, "btn_jindu").lock_cd = true

			ccui.Helper:seekWidgetByName(arg_80_1, "Label_40"):setString((function(arg_82_0)
				if arg_82_0 >= 3600 then
					return string.format("%dh%dm", math.floor(arg_82_0 / 3600), math.floor(arg_82_0 % 3600 / 60))
				else
					return string.format("%dm%ds", math.floor(arg_82_0 / 60), arg_82_0 % 60)
				end
			end)(var_81_0))
			ccui.Helper:seekWidgetByName(arg_80_1, "mask_img"):setVisible(true)
		end
	end, 0)
end

function DoubleHoliday_CityNodeLayer.updateResearchCenter(arg_83_0, arg_83_1)
	return
end

function DoubleHoliday_CityNodeLayer.updateRoundTime(arg_84_0, arg_84_1)
	arg_84_0.next_round_time = arg_84_1
end

function DoubleHoliday_CityNodeLayer:initBottomBtnList()
	self.bottomlist = BottomBtnList:create(function(arg_86_0, arg_86_1)
		if arg_86_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()

		if callback then
			callback()
		end
	end, {})

	self.rootLayer:addChild(self.bottomlist, 7)
	self:initBottomAddPanel()
end

function DoubleHoliday_CityNodeLayer:updatePassPanel(arg_87_1)
	self.pass_city_panel:setVisible(arg_87_1)
end

function DoubleHoliday_CityNodeLayer:initBottomAddPanel()
	local var_88_0 = ccui.Layout:create()

	var_88_0:setPosition(cc.p(320, 30))
	var_88_0:setName("bottomAddPanel")
	self.bottomlist:addChild(var_88_0)

	local var_88_1 = ccui.Button:create(var_0_22[1], nil, var_0_22[1], var_0_32)

	var_88_1:setPosition(cc.p(-60, 0))
	var_88_0:addChild(var_88_1)

	self.btn_simulation = var_88_1

	local var_88_2 = ccui.Button:create(var_0_22[2], nil, var_0_22[2], var_0_32)

	var_88_2:setPosition(cc.p(self.btn_simulation:getPositionX() + self.btn_simulation:getContentSize().width + 20, 0))
	var_88_0:addChild(var_88_2)

	self.btn_aicard = var_88_2

	local var_88_3 = ccui.Button:create(var_0_22[3], nil, var_0_22[3], var_0_32)

	var_88_3:setPosition(cc.p(self.btn_aicard:getPositionX() + self.btn_aicard:getContentSize().width + 20, 0))
	var_88_0:addChild(var_88_3)

	self.btn_virsicene = var_88_3

	self.btn_simulation:addTouchEventListener(function(arg_89_0, arg_89_1)
		if arg_89_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_89_0:isBright() then
			return
		end

		arg_89_0:setBright(false)

		local function var_89_0()
			if var_0_20 then
				arg_89_0:setBright(true)
			end
		end

		local function var_89_1()
			activity_doubleholiday_manager:reset_city(12, self.city, function(arg_92_0)
				if arg_92_0.result ~= 0 then
					global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.RESET_CITY)

					if arg_92_0.get and next(arg_92_0.get) then
						global_gain({
							gold = arg_92_0.gold,
							diamond = arg_92_0.diamond,
							honor = arg_92_0.honor,
							items = {
								arg_92_0.get
							}
						})
					end

					self:updatePassPanel(false)
					self:getDataFromServer()

					if self.result == 1 then
						RoleDefault:getInstance():setBoolForKey("First_result_moment1_" .. self.city, false)
					elseif self.result == 2 then
						RoleDefault:getInstance():setBoolForKey("First_result_moment2_" .. self.city, false)
					end
				end

				if var_89_0 then
					var_89_0()
				end
			end)
		end

		local var_89_2 = 0
		local var_89_3

		if activity_plague_other_data.moni_endtime.rule >= time_check_manager:getCurTime() then
			var_89_2 = math.floor(self.damage * activity_plague_city_data[self.city].coef * 50 / 100)
			var_89_3 = {
				button = L_GO_BUY_SCOREARENA_TIMES.button,
				title = L_DOUBLEHOLIDAY_WOLDCITYLAYER.AGAIN_PLAY
			}
		end

		var_89_3.des = L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_6 .. var_89_2 .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_7

		LayerManager:pushInLayer("PopDoLayer", {
			surecallback = function()
				var_89_1()
			end,
			cancelcallback = function()
				if var_89_0 then
					var_89_0()
				end
			end,
			labels = var_89_3
		})
	end)
	self.btn_aicard:addTouchEventListener(function(arg_95_0, arg_95_1)
		if arg_95_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("BagLayer", {
			bagType = 19,
			returnLayer = "DoubleHoliday_WoldCityLayer",
			createType = 1
		})
	end)
	self.btn_virsicene:addTouchEventListener(function(arg_96_0, arg_96_1)
		local var_96_0

		if arg_96_1 ~= ccui.TouchEventType.ended then
			do return end

			var_96_0 = {}
		end

		function var_96_0.callback()
			activity_doubleholiday_manager:get_skill_info(12, function(arg_98_0)
				if arg_98_0.result ~= 0 and var_0_20 then
					self.skilldata = arg_98_0.list

					self:updateSkillPanel(self.skilldata)
				end
			end)
		end

		LayerManager:pushInLayer("PopTechnologyTree", var_96_0)
	end)
end

function DoubleHoliday_CityNodeLayer:updateChoeseFrame(arg_99_1)
	arg_99_1 = arg_99_1 and activity_plague_data[arg_99_1].nodeid

	local var_99_0 = activity_plague_city_data[self.city].total
	local var_99_1 = {}

	for iter_99_0, iter_99_1 in ipairs(activity_plague_data) do
		if iter_99_1.cityid == self.city then
			table.insert(var_99_1, iter_99_1)
		end
	end

	table.sort(var_99_1, function(arg_100_0, arg_100_1)
		return arg_100_0.nodeid < arg_100_1.nodeid
	end)

	for iter_99_2 = 1, var_99_0 do
		local var_99_2 = ccui.Helper:seekWidgetByName(self.nodeLayer, "Node" .. iter_99_2)

		if var_99_2:getChildByName("selectFrame") then
			var_99_2:getChildByName("selectFrame"):removeFromParent()
		end

		if arg_99_1 == iter_99_2 then
			local var_99_3 = "doubleholiday_city/city_select_small.png"
			local var_99_4 = 36

			if var_99_1[iter_99_2].nodetype ~= 0 then
				var_99_3 = "doubleholiday_city/city_select_big.png"
				var_99_4 = 64
			end

			local var_99_5 = ccui.ImageView:create(var_99_3, var_0_32)

			var_99_5:setPosition(cc.p(var_99_2:getContentSize().width / 2, var_99_2:getContentSize().height / 2 + var_99_4))
			var_99_5:setName("selectFrame")
			var_99_2:addChild(var_99_5, 3)
		end
	end
end

function DoubleHoliday_CityNodeLayer:updateCoinShow()
	ccui.Helper:seekWidgetByName(self.title, "Label_24"):setString(global_trans_number(item_manager:getItemNumber(var_0_27[1])))
	ccui.Helper:seekWidgetByName(self.title, "Label_25"):setString(global_trans_number(item_manager:getItemNumber(var_0_27[2])))
	ccui.Helper:seekWidgetByName(self.title, "Label_26"):setString(global_trans_number(item_manager:getItemNumber(var_0_27[3])))
end

function DoubleHoliday_CityNodeLayer:fullScreen()
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.pass_city_panel:setContentSize(GameDisplay.getScreenSize())
	self.pass_city_panel:setPositionY(self.pass_city_panel:getPositionY() - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.pass_city_panel, "Image_151"):setPositionY(ccui.Helper:seekWidgetByName(self.pass_city_panel, "Image_151"):getPositionY() + GameDisplay.fix_y)
	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
	self.panel_ml:setPositionY(self.panel_ml:getPositionY() + GameDisplay.fix_y)
	self.panel_mr:setPositionY(self.panel_mr:getPositionY() + GameDisplay.fix_y)
	self.skillpanel:setPositionY(self.skillpanel:getPositionY() - GameDisplay.fix_y)

	self.bottomlist.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomlist:setPositionY(self.bottomlist.full_posY)
	self.scollpanel:setPositionY(self.bottomlist:getPositionY() + self.bottomlist:getContentSize().height)
end
