local WeeklyTowerEntranceLayer = class("WeeklyTowerEntranceLayer", function()
	return cc.Layer:create()
end)
local playermodel = require("model.playermodel")
local time_check_manager = require("controller.time_check_manager")
local levelmode_data = require("data.levelmode_data")
local level_manager = require("controller.level_manager")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local var_0_7 = require("controller.weekly_tower_manager").getInstance()
local var_0_8 = config._DEBUG and 0 or 1
local var_0_9 = 640
local var_0_11 = 640
local var_0_12 = 180
local var_0_13 = {
	LIGHT_ENERGY = 1,
	ANTI_MATTER = 6,
	OTHER = 7,
	QUANTUM = 3,
	ZEROSUPPERESSION = 9,
	FIRE_MIMICRY = 13,
	LIGHT_POSITIVE = 14,
	POSITIVE = 10,
	IMAGINARY = 11,
	MIMICRY = 8,
	WATER_ZEROSUPPERESSION = 15,
	DRAK_MATTER = 5,
	DARK_DEVIL = 12,
	WIND_IMAGINARY = 16,
	THERMAL_ENERGY = 2,
	ELECTROMAGNETISM = 4
}
local var_0_14 = "weeklytower/"
local var_0_15 = {
	[var_0_13.LIGHT_ENERGY] = {
		off = "img_light_off.png",
		on = "img_light_on.png"
	},
	[var_0_13.THERMAL_ENERGY] = {
		off = "img_thermal_off.png",
		on = "img_thermal_on.png"
	},
	[var_0_13.QUANTUM] = {
		off = "img_quantum_off.png",
		on = "img_quantum_on.png"
	},
	[var_0_13.ELECTROMAGNETISM] = {
		off = "img_electric_off.png",
		on = "img_electric_on.png"
	},
	[var_0_13.DRAK_MATTER] = {
		off = "img_darkmatter_off.png",
		on = "img_darkmatter_on.png"
	},
	[var_0_13.ANTI_MATTER] = {
		off = "img_antimatter_off.png",
		on = "img_antimatter_on.png"
	},
	[var_0_13.OTHER] = {
		off = "img_other_off.png",
		on = "img_other_on.png"
	},
	[var_0_13.MIMICRY] = {
		off = "img_mimicry_off.png",
		on = "img_mimicry_on.png"
	},
	[var_0_13.ZEROSUPPERESSION] = {
		off = "img_zerosupperession_off.png",
		on = "img_zerosupperession_on.png"
	},
	[var_0_13.POSITIVE] = {
		off = "img_positive_off.png",
		on = "img_positive_on.png"
	},
	[var_0_13.IMAGINARY] = {
		off = "img_imaginary_off.png",
		on = "img_imaginary_on.png"
	},
	[var_0_13.DARK_DEVIL] = {
		off = "img_dark_devil_off.png",
		on = "img_dark_devil_on.png"
	},
	[var_0_13.FIRE_MIMICRY] = {
		off = "img_fire_mimicry_off.png",
		on = "img_fire_mimicry_on.png"
	},
	[var_0_13.LIGHT_POSITIVE] = {
		off = "img_light_positive_off.png",
		on = "img_light_positive_on.png"
	},
	[var_0_13.WATER_ZEROSUPPERESSION] = {
		off = "img_water_zerosupperession_off.png",
		on = "img_water_zerosupperession_on.png"
	},
	[var_0_13.WIND_IMAGINARY] = {
		off = "img_wind_imaginary_off.png",
		on = "img_wind_imaginary_on.png"
	}
}
local var_0_16 = {
	wind = var_0_13.ELECTROMAGNETISM,
	fire = var_0_13.THERMAL_ENERGY,
	water = var_0_13.QUANTUM,
	light = var_0_13.LIGHT_ENERGY,
	dark = var_0_13.DRAK_MATTER,
	devil = var_0_13.ANTI_MATTER,
	other = var_0_13.OTHER,
	mimicry = var_0_13.MIMICRY,
	zerosupperession = var_0_13.ZEROSUPPERESSION,
	positive = var_0_13.POSITIVE,
	imaginary = var_0_13.IMAGINARY,
	["dark,devil"] = var_0_13.DARK_DEVIL,
	["fire,mimicry"] = var_0_13.FIRE_MIMICRY,
	["light,positive"] = var_0_13.LIGHT_POSITIVE,
	["water,zerosupperession"] = var_0_13.WATER_ZEROSUPPERESSION,
	["wind,imaginary"] = var_0_13.WIND_IMAGINARY
}

function WeeklyTowerEntranceLayer:create(...)
	local var_2_0 = WeeklyTowerEntranceLayer.new(...)

	var_2_0:init(...)

	return var_2_0
end

function WeeklyTowerEntranceLayer:init(...)
	self:initData(...)
	self:initUI()
	self:registerEvents()
end

function WeeklyTowerEntranceLayer:initData(arg_4_1)
	self.datas = {}
end

function WeeklyTowerEntranceLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "WeeklyTowerEntranceLayer.json" or "WeeklyTowerEntranceLayer.ExportJson")

	self:addChild(self.rootNode)

	self.rootPanel = self.rootNode:getChildByName("panelRoot")
	self.panelMain = self.rootPanel:getChildByName("panelMain")
	self.listView = self.panelMain:getChildByName("listView")
	self.imgTitle = self.panelMain:getChildByName("imgTitle")
	self.btnTip = self.imgTitle:getChildByName("btnTip")
	self.panelRewards = self.panelMain:getChildByName("panelRewards")

	self.panelRewards:setVisible(false)

	self.listViewRewards = self.panelRewards:getChildByName("listViewRewards")

	Utility:alignPanelByParent(self.panelRewards, self.panelMain)
	self:initOriginPanelItem()
	self:initBottomBtn()
	self:fullScreen()
end

function WeeklyTowerEntranceLayer:initOriginPanelItem()
	self.panelItem = self.panelMain:getChildByName("panelItem")

	self.panelItem:retain()
	self.panelItem:removeFromParent()
	self.panelItem:setContentSize(cc.size(640, 168))

	local var_6_0 = self.panelItem:getChildByName("imgBorder")
	local var_6_1 = self.panelItem:getChildByName("labelLevel")
	local var_6_2 = self.panelItem:getChildByName("btnPreview")
	local var_6_3 = self.panelItem:getChildByName("imgLimit")
end

function WeeklyTowerEntranceLayer:initBottomBtn()
	require("view.Sprite.BottomBtnList")

	self.bottomBtnList = BottomBtnList:create(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.bottomBtnList:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 0, TRANSFORM_UNIT.PX))
	self:addChild(self.bottomBtnList, 10)
end

function WeeklyTowerEntranceLayer:fullScreen()
	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self.imgTitle:setPositionType(0)
	self.imgTitle:setPositionY(self.imgTitle:getPositionY() - GameDisplay.statusbar_height)
end

function WeeklyTowerEntranceLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.btnTip, handler(self, self.onBtnTip))
	Utility:registerTouchEventListener(self.panelRewards, cc.Handler.EVENT_TOUCH_BEGAN, handler(self, self.onTouchBegan))
	Utility:registerTouchEventListener(self.panelRewards, cc.Handler.EVENT_TOUCH_ENDED, handler(self, self.onTouchEnded))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_WEEKLY_TOWER_INFO, handler(self, self.handleGetWeeklyTowerInfo))
end

function WeeklyTowerEntranceLayer:onTouchBegan(arg_11_1, arg_11_2)
	return self.panelRewards:isVisible()
end

function WeeklyTowerEntranceLayer:onTouchEnded(arg_12_1, arg_12_2)
	if not cc.rectContainsPoint(self.panelRewards:getBoundingBox(), (self.panelMain:convertToNodeSpace(arg_12_1:getLocation()))) then
		self.panelRewards:setVisible(false)
	end
end

function WeeklyTowerEntranceLayer:updateLabelTime()
	return
end

function WeeklyTowerEntranceLayer:initTableView()
	self.tableView = cc.TableView:create(cc.size(var_0_9, self.listView:getContentSize().height + GameDisplay.height - GameDisplay.origin_design_y - 30))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setDelegate()
	self.tableView:setPositionY(self.listView:getPositionY() + 30)
	self.panelMain:addChild(self.tableView)
	self.tableView:registerScriptHandler(handler(self, self.numberOfCells), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:registerScriptHandler(handler(self, self.cellSizeForIndex), cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(handler(self, self.updateCellAtIndex), cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:setLocalZOrder(0)
end

function WeeklyTowerEntranceLayer:updateTableView()
	if not self.tableView then
		self:initTableView()
	end

	self.tableView:reloadData()
end

function WeeklyTowerEntranceLayer:numberOfCells(arg_16_1)
	return #self.datas
end

function WeeklyTowerEntranceLayer:cellSizeForIndex(arg_17_1, arg_17_2)
	return var_0_11, var_0_12
end

function WeeklyTowerEntranceLayer:updateCellAtIndex(arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1:dequeueCell()
	local var_18_1 = true

	if not var_18_0 then
		var_18_0 = cc.TableViewCell:create()
		var_18_1 = false
	end

	if var_18_1 then
		self:updateOneItem(var_18_0, arg_18_2)
	else
		self:createOneItem(var_18_0, arg_18_2)
	end

	return var_18_0
end

function WeeklyTowerEntranceLayer:createOneItem(arg_19_1, arg_19_2)
	local var_19_0 = self.panelItem:clone()

	var_19_0:setName("panelItem")
	var_19_0:setPositionY(12)
	var_19_0:setSwallowsTouches(false)

	local var_19_1 = ccui.ImageView:create("public/career_icon/restrain_tip_1.png", var_0_8)

	var_19_1:setName("restrainTip")
	var_19_1:setPosition(cc.p(0, 50))
	var_19_1:setAnchorPoint(cc.p(0, 0))
	var_19_0:addChild(var_19_1)
	arg_19_1:addChild(var_19_0)
	self:updateOneItem(arg_19_1, arg_19_2)

	if arg_19_2 < math.floor(self.tableView:getContentSize().height / var_0_12) then
		var_19_0:setOpacity(0)
		var_19_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_19_2 * 0.05), cc.FadeIn:create(0.1)))
	end
end

function WeeklyTowerEntranceLayer:updateOneItem(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1:getChildByName("panelItem")
	local var_20_1 = var_20_0:getChildByName("imgBorder")
	local var_20_2 = var_20_0:getChildByName("labelLevel")
	local var_20_3 = var_20_0:getChildByName("btnPreview")
	local var_20_4 = var_20_0:getChildByName("imgLimit")
	local var_20_5 = var_20_4:getChildByName("labelLimitTime")
	local var_20_6 = var_20_0:getChildByName("ImageAttr1")
	local var_20_7 = var_20_0:getChildByName("ImageAttr2")
	local var_20_8 = var_20_0:getChildByName("LabelUseAttrLimit")
	local var_20_9 = self.datas[arg_20_2 + 1]

	if not self.datas[arg_20_2 + 1] then
		print("error data", arg_20_2)

		return
	end

	if Utility:isTimeRangeValid(var_20_9.startTime, var_20_9.endTime) and (not var_20_9.open_week_days or Utility:checkWeekday(var_20_9.open_week_days)) then
		var_20_1:loadTexture(var_0_14 .. var_0_15[var_0_16[var_20_9.show_type]].on, var_0_8)
		var_20_4:setVisible(false)

		var_20_0.isValid = true
	else
		if var_20_9.open_week_days then
			var_20_5:setString((string.format(L_WEEK_OPEN, Utility:numbterStrToChinese(var_20_9.open_week_days))))
		else
			var_20_5:setString(var_20_9.startTime)
		end

		var_20_1:loadTexture(var_0_14 .. var_0_15[var_0_16[var_20_9.show_type]].off, var_0_8)
		var_20_4:setVisible(true)

		var_20_0.isValid = false
	end

	if string.find(var_20_9.show_type, ",") then
		var_20_6:loadTexture("public/career_icon/" .. string.split(var_20_9.show_type, ",")[1] .. ".png", var_0_8)
		var_20_7:loadTexture("public/career_icon/" .. string.split(var_20_9.show_type, ",")[2] .. ".png", var_0_8)
		var_20_8:setString("限用：")
		var_20_6:setVisible(false)
		var_20_7:setVisible(false)
		var_20_8:setVisible(false)
	else
		var_20_6:setVisible(false)
		var_20_7:setVisible(false)
		var_20_8:setVisible(false)
	end

	var_20_2:setString(Utility:clamp(var_20_9.curLevel, 1, var_20_9.totalLevel) .. " / " .. var_20_9.totalLevel)
	var_20_3:setVisible(var_20_0.isValid == true)
	Utility:addClickEventListener(var_20_3, handler(self, self.onBtnPreview), arg_20_2)
	Utility:addClickEventListener(var_20_0, handler(self, self.onPanelItem), arg_20_2)

	local var_20_10 = var_20_0:getChildByName("restrainTip")

	if var_20_9.res_element then
		var_20_10:setVisible(true)
		var_20_10:loadTexture("public/career_icon/restrain_tip_" .. ATTR_INDEX[var_20_9.res_element] .. ".png", var_0_8)
	else
		var_20_10:setVisible(false)
	end
end

function WeeklyTowerEntranceLayer:onPanelItem(arg_21_1, arg_21_2)
	if not arg_21_1.isValid then
		return
	end

	local var_21_0 = self.datas[arg_21_2 + 1]

	;(function(arg_22_0)
		LayerManager:switchShowLayer("WeeklyTowerLayer", {
			returnLayer = "WeeklyTowerEntranceLayer",
			originMode = var_21_0.mode,
			modeType = var_21_0.modeType,
			index = arg_22_0 or 1
		})
	end)()
end

function WeeklyTowerEntranceLayer:openGuidePanel(arg_23_1)
	local var_23_0 = self.panelMain:getChildByName("guidePanel")

	if var_23_0 == nil then
		var_23_0 = ccui.Layout:create()

		var_23_0:setContentSize(cc.size(640, 174))
		var_23_0:setName("guidePanel")
		var_23_0:setLocalZOrder(98)
		self.panelMain:addChild(var_23_0)
		var_23_0:setVisible(true)

		local var_23_1 = ccui.ImageView:create("weeklytower/guide_bg.png", var_0_8)

		var_23_1:setAnchorPoint(cc.p(0, 0))
		var_23_0:addChild(var_23_1)

		for iter_23_0, iter_23_1 in pairs({
			"easy",
			"normal",
			"hard"
		}) do
			local var_23_2 = ccui.ImageView:create("weeklytower/btn_" .. iter_23_1 .. "_index.png", var_0_8)

			var_23_2:setPosition(cc.p(40 + 200 * (iter_23_0 - 1), 50))
			var_23_2:setAnchorPoint(cc.p(0, 0))
			var_23_2:setTouchEnabled(true)

			var_23_2.index = iter_23_0

			var_23_2:addTouchEventListener(function(arg_24_0, arg_24_1)
				if arg_24_1 ~= ccui.TouchEventType.ended then
					return
				end

				var_23_0:setVisible(false)

				if type(arg_23_1.successCallback) == "function" then
					arg_23_1.successCallback(arg_24_0.index)
				end
			end)
			var_23_0:addChild(var_23_2)
		end
	else
		var_23_0:setVisible(true)
	end

	local var_23_3 = self.panelMain:convertToNodeSpace(arg_23_1.pos)

	var_23_0:setPosition(cc.p(var_23_3.x, var_23_3.y - 168))
end

function WeeklyTowerEntranceLayer:onBtnPreview(arg_25_1, arg_25_2)
	if self.datas[arg_25_2 + 1] then
		local var_25_0, var_25_1 = var_0_7:getDropDatasByMode(self.datas[arg_25_2 + 1].mode)
		local var_25_2 = {}

		for iter_25_0 = 1, #var_25_0 do
			var_25_2[#var_25_2 + 1] = {
				id = var_25_0[iter_25_0],
				count = var_25_1[iter_25_0]
			}
		end

		LayerManager:pushInLayer("RewardPreviewLayer", var_25_2, (level_manager:getDropUpServants(self.datas[arg_25_2 + 1].mode)))
	end
end

function WeeklyTowerEntranceLayer:updateRewards(arg_26_1)
	if not arg_26_1 then
		return
	end

	local var_26_0 = self.panelRewards:getChildByName("listViewRewards")

	var_26_0:removeAllChildren()
	var_26_0:setItemsMargin(40)

	local var_26_1 = var_0_7:getDropDatasByMode(arg_26_1.mode)

	for iter_26_0 = 1, math.ceil(#var_26_1 / 3) do
		local var_26_2 = ccui.Layout:create()

		var_26_2:setContentSize(cc.size(460, 140))

		for iter_26_1 = 1, 3 do
			if var_26_1[iter_26_1 + 3 * (iter_26_0 - 1)] then
				local var_26_3 = ItemSprite:createNewWithItemId(var_26_1[iter_26_1 + 3 * (iter_26_0 - 1)])

				var_26_3:addSpriteTouchEventListener(function(arg_27_0, arg_27_1)
					if not self.panelRewards:isVisible() then
						return
					end

					if arg_27_1 == ccui.TouchEventType.ended then
						LayerManager:pushInLayer("PopItemLayer", {
							itemid = var_26_1[iter_26_1 + 3 * (iter_26_0 - 1)]
						})
					end
				end)
				var_26_3:setPosition(80 + (iter_26_1 - 1) * 140, 60)
				var_26_3:setScale(0.7)
				var_26_2:addChild(var_26_3)
			end
		end

		var_26_0:pushBackCustomItem(var_26_2)
	end
end

function WeeklyTowerEntranceLayer:onBtnTip(arg_28_1)
	LayerManager:pushInLayer("PopActivityDetail", {
		key = "WeeklyTower"
	})
end

function WeeklyTowerEntranceLayer:onEnter()
	EventManager:requestGetWeeklyTowerInfo()
end

function WeeklyTowerEntranceLayer:onExit()
	self.panelItem:release()
	EventManager:unsubscribe(self)
end

function WeeklyTowerEntranceLayer:handleGetWeeklyTowerInfo(arg_31_1)
	if not arg_31_1 then
		return
	end

	if arg_31_1 and arg_31_1.result == 1 then
		self.datas = self:filterDatas(var_0_7.modeDatas)

		self:updateTableView()
	end
end

function WeeklyTowerEntranceLayer:filterDatas(arg_32_1)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		if Utility:isTimeRangeValid(iter_32_1.startTime, iter_32_1.endTime) or levelmode_data[iter_32_1.mode] and (not levelmode_data[iter_32_1.mode].pt_hide or levelmode_data[iter_32_1.mode].pt_hide ~= 1) then
			var_32_0[#var_32_0 + 1] = iter_32_1
		end
	end

	table.sort(var_32_0, function(arg_33_0, arg_33_1)
		return arg_33_0.order > arg_33_1.order
	end)

	return var_32_0
end

return WeeklyTowerEntranceLayer
