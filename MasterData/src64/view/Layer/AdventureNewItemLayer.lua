AdventureNewItemLayer = class("AdventureNewItemLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local var_0_3 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local Utility = require("common.Utility")

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Layer.BattleArrayLayerNew")

local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local alert_manager = require("controller.alert_manager")
local levelmode_data = require("data.levelmode_data")
local var_0_12 = require("data.item_data")
local var_0_15
local var_0_16 = 630
local var_0_17 = 175
local var_0_18 = L_WEEK_TEXT_SIMPLE

function AdventureNewItemLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = AdventureNewItemLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AdventureNewItemLayer:init(arg_3_1)
	var_0_15 = self
	arg_3_1 = arg_3_1 or {
		trialtype = 1,
		layer = 2
	}

	if type(arg_3_1) ~= "table" then
		self.modetype = arg_3_1
	else
		self.modetype = arg_3_1.layer
		self.scessflag = arg_3_1.scessflag
		self.returnbacklayer = arg_3_1.returnbacklayer
	end

	self.trialtype = arg_3_1.trialtype

	RoleDefault:getInstance():setBoolForKey("AdventureEnterAde" .. self.trialtype, true)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventureNewItemLayer.json" or "AdventureNewItemLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:updateData()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_15 = nil
		end
	end)
end

function AdventureNewItemLayer:initUI(...)
	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.bg:loadTexture("mainScenebg/roledatabg.jpg")
	self.bg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2))

	self.backdi = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bottom")

	self.backdi:setPosition(cc.p(320, 31))
	self.backdi:setZOrder(10000)
	self.backdi:getChildByName("Image_17"):getChildByName("Label_18"):setString("load..")
	self.backdi:getChildByName("Image_17"):setTouchEnabled(true)
	self.backdi:getChildByName("Image_17"):addTouchEventListener(self:getBuyTimeHandler())

	self.back = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_23")
	self.gantan = ccui.Helper:seekWidgetByName(self.rootLayer, "detail_btn")

	self.gantan:setVisible(false)
	self.back:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.buybtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_40")

	self.buybtn:addTouchEventListener(self:getBuyTimeHandler())
	self:fullScreen(self.rootLayer)
	self:initTabBtn()
	self:updateTblBtn()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_trialtype_2"):setVisible(false)
end

function AdventureNewItemLayer.getBuyTimeHandler(arg_7_0)
	return function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)
		arg_7_0:requestBuyAdventureDailyTimeInfo(arg_8_0)
	end
end

function AdventureNewItemLayer:requestBuyAdventureDailyTimeInfo(arg_9_1)
	local function var_9_0()
		level_manager:buyAdventureDailyTime(self.modetype, function(arg_11_0, arg_11_1, arg_11_2)
			if arg_11_0 == 1 then
				if not var_0_15 then
					return
				end

				global_ShowBlockWords(L_BUY_TIMES_SUCCESS)
				self:updateTimeLabel(arg_11_2)

				self.modetimes = arg_11_2

				self:updateTimeLabel()
			elseif arg_11_0 == 2 then
				global_ShowBlockWords(L_DIAMOND_LACK)
			elseif arg_11_0 == 3 then
				global_ShowBlockWords(L_BUY_TIMES_LIMITED)
			elseif arg_11_0 == 4 then
				global_ShowBlockWords(L_BUY_TIMES_OVERSIZE)
			end

			if arg_9_1 then
				arg_9_1:setBright(true)
			end
		end, self.trialtype)
	end

	level_manager:getBuyAdventureDailyTimeInfo(self.modetype, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == 1 then
			LayerManager:pushInLayer("PopDoLayer", {
				costtype = "diamond",
				surecallback = var_9_0,
				cancelcallback = function()
					if arg_9_1 then
						arg_9_1:setBright(true)
					end
				end,
				cost = arg_12_1,
				own = playermodel.diamond,
				labels = {
					titleImage = "title_more_adventure_times.png",
					button = L_BUY_TIMES_MSG_MODETYPE_2.button,
					des = string.format(L_BUY_TIMES_MSG_MODETYPE_2.des, arg_12_1),
					more = string.format(L_BUY_TIMES_MSG_MODETYPE_2.more, arg_12_1)
				}
			})
		elseif arg_12_0 == 4 then
			global_ShowBlockWords(L_BUY_TIMES_OVERSIZE)
		else
			global_ShowBlockWords(L_BUY_TIMES_LIMITED)

			if arg_9_1 then
				arg_9_1:setBright(true)
			end
		end
	end, self.trialtype)
end

function AdventureNewItemLayer:updateTimeLabel()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_16"):setString(L_ADVENTURER_RANDOMLAYER[8] .. ":")
	self.backdi:getChildByName("Image_17"):getChildByName("Label_18"):setString("" .. self.modetimes)
end

function AdventureNewItemLayer:createNode()
	local var_15_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

	var_15_0:setSwallowTouches(false)

	return var_15_0
end

function AdventureNewItemLayer:updateNode(arg_16_1, arg_16_2)
	local var_16_0 = ccui.Helper:seekWidgetByName(arg_16_1, "level_lock")
	local var_16_1 = arg_16_1:getChildByName("nostatrt_img")
	local var_16_2 = arg_16_1:getChildByName("change_btn")
	local var_16_3 = arg_16_1:getChildByName("ImageUpDrop")
	local var_16_4 = arg_16_1:getChildByName("LabelUpDrop")

	self:updataImage(arg_16_1, arg_16_2)
	ccui.Helper:seekWidgetByName(arg_16_1, "fuben_name"):setString(arg_16_2.name)
	ccui.Helper:seekWidgetByName(arg_16_1, "time"):setString(self:createTimeString(arg_16_2))
	ccui.Helper:seekWidgetByName(arg_16_1, "lefttime1_1"):setString(tostring(self.modetimes))

	if self:checkIsVaild(arg_16_2) then
		if self.modetimes > 0 then
			var_16_2:setVisible(true)
			var_16_2:setBright(true)
			var_16_1:setVisible(false)
		else
			var_16_2:setVisible(true)
			var_16_2:setBright(false)
			var_16_1:setVisible(false)
		end
	else
		var_16_2:setVisible(false)
		var_16_1:setVisible(true)
	end

	if arg_16_2.open_week_days then
		if arg_16_2.buy_mod or Utility:checkWeekday(arg_16_2.open_week_days) then
			var_16_2:setVisible(true)
			var_16_0:setVisible(false)
		else
			var_16_0:setVisible(true)
			var_16_2:setVisible(false)
			var_16_0:getChildByName("Label_30"):setString(string.format(L_WEEK_OPEN, Utility:numbterStrToChinese(arg_16_2.open_week_days)))
		end
	else
		var_16_2:setVisible(true)
		var_16_0:setVisible(false)
	end

	if arg_16_2.awardup_week_days and Utility:checkWeekday(arg_16_2.awardup_week_days) then
		var_16_4:setString(string.format(L_ADVANTURE_UP_DROP, tostring(1 + arg_16_2.awardup_rate)))
		var_16_3:setVisible(true)
		var_16_4:setVisible(true)
	else
		var_16_3:setVisible(false)
		var_16_4:setVisible(false)
	end

	arg_16_1:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_17_0:getTouchBeganPosition().y - arg_17_0:getTouchEndPosition().y) > 50 then
			return
		end

		if not arg_16_2.buy_mod and arg_16_2.open_week_days and not Utility:checkWeekday(arg_16_2.open_week_days) then
			self:showBuyOpenWeekDays(arg_16_2.mode)
		elseif self.modetimes <= 0 then
			self:requestBuyAdventureDailyTimeInfo()
		else
			local var_17_0 = {
				data = arg_16_2,
				times = self.modetimes
			}

			function var_17_0.buySuccessFun(arg_18_0)
				if var_0_15 then
					self:updateTimeLabel(arg_18_0)

					self.modetimes = arg_18_0

					self:updateTimeLabel()
				end
			end

			LayerManager:pushInLayer("AdventureNewDetailLayer", var_17_0)
			RoleDefault:getInstance():setIntegerForKey("AdventureEnterTrialtype", self.trialtype)
			RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", 2)
		end
	end)
end

function AdventureNewItemLayer.updataImage(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = {}

	for iter_19_0 = 1, 4 do
		if arg_19_2["show_item" .. iter_19_0] then
			table.insert(var_19_0, arg_19_2["show_item" .. iter_19_0])
		end
	end

	for iter_19_1 = 1, 4 do
		if var_19_0[iter_19_1] then
			arg_19_1:getChildByName("img_" .. iter_19_1):loadTexture("equipment/" .. (var_0_12[var_19_0[iter_19_1]].image_id or "100") .. ".png")
			arg_19_1:getChildByName("img_" .. iter_19_1):setVisible(true)

			local var_19_2 = math.min(arg_19_1:getChildByName("img_" .. iter_19_1):getContentSize().width, arg_19_1:getChildByName("img_" .. iter_19_1):getContentSize().height)

			if iter_19_1 == 1 then
				arg_19_1:getChildByName("img_" .. iter_19_1):setScale(128 / var_19_2)
			else
				arg_19_1:getChildByName("img_" .. iter_19_1):setScale(89.6 / var_19_2)
			end

			arg_19_1:getChildByName("img_" .. iter_19_1).afterLoadSuccess = function(self, ...)
				local var_20_0 = math.min(self:getContentSize().width, self:getContentSize().height)

				if iter_19_1 == 1 then
					self:setScale(128 / var_20_0)
				else
					self:setScale(89.6 / var_20_0)
				end
			end
		else
			arg_19_1:getChildByName("img_" .. iter_19_1):setVisible(false)
		end
	end
end

function AdventureNewItemLayer:initTableView()
	self.tableView = cc.TableView:create(cc.size(640, 1050 + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT)))

	self.tableView:setPosition(cc.p(0, 90))
	self.tableView:setDelegate()
	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.tableView)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:registerScriptHandler(function(arg_23_0, arg_23_1)
		return var_0_16, var_0_17
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0:dequeueCell()

		if not var_22_0 then
			var_22_0 = cc.TableViewCell:create()

			local var_22_1 = self:createNode()

			var_22_0:setName("cell_" .. arg_22_1)
			var_22_1:setName("node")
			var_22_1:setPosition(cc.p(5, 0))
			self:updateNode(var_22_1, self.data[arg_22_1 + 1])

			if arg_22_1 <= math.floor(self.tableView:getContentSize().height / var_0_17) then
				var_22_1:setOpacity(0)
				var_22_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_22_1), cc.FadeIn:create(0.1)))
			else
				var_22_1:setOpacity(255)
			end

			var_22_0:addChild(var_22_1)
		else
			local var_22_2 = var_22_0:getChildByName("node")

			var_22_2:setOpacity(255)
			self:updateNode(var_22_2, self.data[arg_22_1 + 1])
		end

		return var_22_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_24_0, arg_24_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function AdventureNewItemLayer:updateData()
	level_manager:getAdventureDailytimeByModeType(self.modetype, function(arg_26_0, arg_26_1, arg_26_2)
		if not var_0_15 then
			return
		end

		self.modetimes = arg_26_1

		if arg_26_2 then
			self.buy_modes = {}

			for iter_26_0, iter_26_1 in pairs(arg_26_2) do
				self.buy_modes[iter_26_1] = true
			end
		end

		self:reloadData()
	end, self.trialtype)
end

function AdventureNewItemLayer:reloadData()
	local var_27_0 = {}
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in pairs(levelmode_data) do
		if iter_27_1.trialtype == self.trialtype and self:checkTimeIsOverVaild(iter_27_1) then
			local var_27_3 = global_deepCopy(iter_27_1)

			var_27_3.buy_mod = self.buy_modes and self.buy_modes[iter_27_1.mode]

			if not var_27_3.openday then
				if self:checkIsVaild(var_27_3) then
					table.insert(var_27_0, var_27_3)
				else
					table.insert(var_27_1, var_27_3)
				end
			elseif self:checkIsVaild(var_27_3) then
				table.insert(var_27_0, var_27_3)
			else
				table.insert(var_27_1, var_27_3)
			end
		end
	end

	self:sortByOrder(var_27_0)
	self:sortByOrder(var_27_1)

	for iter_27_2, iter_27_3 in ipairs(var_27_1) do
		table.insert(var_27_0, iter_27_3)
	end

	self.data = var_27_0

	self:updateTimeLabel()

	if not self.tableView then
		self:initTableView()
	else
		self.tableView:reloadData()
	end
end

function AdventureNewItemLayer.sortByOrder(arg_28_0, arg_28_1)
	if arg_28_1 and #arg_28_1 > 1 then
		table.sort(arg_28_1, function(arg_29_0, arg_29_1)
			return arg_29_0.order < arg_29_1.order
		end)
	end
end

function AdventureNewItemLayer:createTimeString(arg_30_1)
	if arg_30_1.openday then
		local var_30_0 = {}

		for iter_30_0 in string.gmatch(arg_30_1.openday, "%d+") do
			table.insert(var_30_0, iter_30_0)
		end

		local var_30_1 = ""

		for iter_30_1, iter_30_2 in pairs(var_30_0) do
			var_30_1 = var_30_1 == "" and var_30_1 .. var_0_18[iter_30_2] or var_30_1 .. "、" .. var_0_18[iter_30_2]
		end

		return string.format(L_ACTIVITY_TIME_STR.Week_Open, var_30_1)
	elseif arg_30_1.starttime then
		if self:checkIsVaild(arg_30_1) then
			return string.format(L_ACTIVITY_TIME_STR.End, self:dealString(arg_30_1.endtime))
		else
			return string.format(L_ACTIVITY_TIME_STR.Open, self:dealString(arg_30_1.starttime))
		end
	else
		return ""
	end
end

function AdventureNewItemLayer.checkIsVaild(arg_31_0, arg_31_1)
	if arg_31_1.openday then
		local var_31_0 = {}

		for iter_31_0 in string.gmatch(arg_31_1.openday, "%d+") do
			table.insert(var_31_0, iter_31_0)
		end

		local var_31_1 = false
		local var_31_2 = os.date("%w")

		for iter_31_1, iter_31_2 in ipairs(var_31_0) do
			if iter_31_2 == var_31_2 then
				var_31_1 = true
			end
		end

		return var_31_1
	else
		local var_31_3 = false

		if arg_31_1.starttime then
			local var_31_4 = os.time()

			if global_get_time_by_date(arg_31_1.starttime) <= var_31_4 and var_31_4 <= global_get_time_by_date(arg_31_1.endtime) then
				var_31_3 = true
			end
		else
			var_31_3 = true
		end

		return var_31_3
	end
end

function AdventureNewItemLayer.checkTimeIsOverVaild(arg_32_0, arg_32_1)
	return arg_32_1.openday and true or arg_32_1.starttime and os.time() <= global_get_time_by_date(arg_32_1.endtime) or true
end

function AdventureNewItemLayer.dealString(arg_33_0, arg_33_1)
	local var_33_0 = os.date("*t", math.floor((global_get_time_by_date(arg_33_1))))

	if var_33_0.min < 10 then
		var_33_0.min = "0" .. var_33_0.min
	end

	return "" .. var_33_0.month .. "/" .. var_33_0.day .. "  " .. var_33_0.hour .. ":" .. var_33_0.min
end

function AdventureNewItemLayer.fullScreen(arg_34_0, arg_34_1)
	arg_34_1:setContentSize((GameDisplay.getScreenSize()))
	arg_34_1:setPositionY(arg_34_1:getPositionY() - GameDisplay.fix_y)
end

function AdventureNewItemLayer:initTabBtn(...)
	local var_35_0 = {
		1,
		4,
		2,
		3
	}

	while ccui.Helper:seekWidgetByName(self.rootLayer, "Button_trialtype_" .. 1) do
		if 1 == 2 then
			break
		end

		local var_35_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_trialtype_" .. 1)

		var_35_1.trialtype = var_35_0[1]

		var_35_1:addTouchEventListener(function(arg_36_0, arg_36_1)
			if arg_36_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:setTrialType(arg_36_0.trialtype)
			alert_manager:add_new_mark(arg_36_0, false, cc.p(arg_36_0:getContentSize().width - 10, arg_36_0:getContentSize().height - 15))
		end)

		if not RoleDefault:getInstance():getBoolForKey("AdventureEnterAde" .. var_35_1.trialtype, false) then
			if var_35_1.trialtype == 2 or var_35_1.trialtype == 3 then
				if level_manager:isPlayerPassLevel(UNLOCK_ADVENTURENEWITEMLAYER_2) then
					alert_manager:add_new_mark(var_35_1, true, cc.p(var_35_1:getContentSize().width - 10, var_35_1:getContentSize().height - 15))
				end
			else
				alert_manager:add_new_mark(var_35_1, true, cc.p(var_35_1:getContentSize().width - 10, var_35_1:getContentSize().height - 15))
			end
		end
	end

	self.autoFight = RoleDefault:getInstance():getBoolForKey("AdventureItemAutoFight", false)

	local var_35_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_26")
	local var_35_4 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_28")

	var_35_4:setVisible(self.autoFight)
	var_35_3:setTouchEnabled(true)
	var_35_3:addTouchEventListener(function(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.autoFight = not self.autoFight

		var_35_4:setVisible(self.autoFight)
		RoleDefault:getInstance():setBoolForKey("AdventureItemAutoFight", self.autoFight)
	end)
end

function AdventureNewItemLayer:updateMaskPanel(...)
	if not self.maskPanel then
		self.maskPanel = ccui.Layout:create()

		self.maskPanel:setTouchEnabled(true)
		self.maskPanel:setContentSize(cc.Director:getInstance():getVisibleSize())
		self.maskPanel:setAnchorPoint(cc.p(0.5, 0.5))
		self.maskPanel:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
		self.maskPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self.maskPanel:setBackGroundColor(cc.c3b(0, 0, 0))
		self.maskPanel:setBackGroundColorOpacity(120)
		self.rootLayer:addChild(self.maskPanel, 2)
		self.maskPanel:addTouchEventListener(function(arg_39_0, arg_39_1)
			if arg_39_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords((string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_ADVENTURENEWITEMLAYER_2))))
		end)

		local var_38_0 = cc.Label:createWithTTF(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_ADVENTURENEWITEMLAYER_2)), FONT_NAME, 35)

		var_38_0:setPositionX(self.maskPanel:getContentSize().width / 2)
		var_38_0:setPositionY(self.maskPanel:getContentSize().height / 2)
		self.maskPanel:addChild(var_38_0)
	end

	if not level_manager:isPlayerPassLevel(UNLOCK_ADVENTURENEWITEMLAYER_2) and (self.trialtype == 2 or self.trialtype == 3) then
		self.maskPanel:setVisible(true)
	else
		self.maskPanel:setVisible(false)
	end
end

function AdventureNewItemLayer:setTrialType(arg_40_1)
	if self.trialtype == arg_40_1 then
		return
	end

	self.trialtype = arg_40_1

	RoleDefault:getInstance():setBoolForKey("AdventureEnterAde" .. self.trialtype, true)
	self:updateMaskPanel()
	self:updateData()
	self:updateTblBtn()
end

function AdventureNewItemLayer:updateTblBtn(...)
	while ccui.Helper:seekWidgetByName(self.rootLayer, "Button_trialtype_" .. 1) do
		if 1 == 2 then
			break
		end

		local var_41_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_trialtype_" .. 1)

		if var_41_0.trialtype == self.trialtype then
			var_41_0:loadTextures("adventurenewlayer/" .. var_41_0.trialtype .. "_on.png", "adventurenewlayer/" .. var_41_0.trialtype .. "_on.png", "adventurenewlayer/" .. var_41_0.trialtype .. "_on.png", var_0_3)
		else
			var_41_0:loadTextures("adventurenewlayer/" .. var_41_0.trialtype .. "_off.png", "adventurenewlayer/" .. var_41_0.trialtype .. "_off.png", "adventurenewlayer/" .. var_41_0.trialtype .. "_off.png", var_0_3)
		end
	end
end

function AdventureNewItemLayer.showBuyOpenWeekDays(arg_42_0, arg_42_1)
	local var_42_0 = {
		costtype = "diamond",
		surecallback = function()
			if arg_42_0.waitnet then
				return
			end

			arg_42_0.waitnet = true

			level_manager:buy_mode_temporarily(arg_42_1, function(arg_44_0)
				arg_42_0.waitnet = nil

				if arg_44_0 == 1 then
					arg_42_0.buy_modes = arg_42_0.buy_modes or {}
					arg_42_0.buy_modes[arg_42_1] = true

					arg_42_0:reloadData()
				end
			end)
		end,
		cancelcallback = function()
			return
		end
	}

	var_42_0.cost = 100
	var_42_0.own = playermodel.diamond
	var_42_0.labels = {
		titleImage = "title_warorder.png",
		button = L_BUY_TIMES_MSG_MODETYPE_2.button,
		des = string.format(L_BUY_TIMES_MSG_MODETYPE_2.buy_open_week_days, 100),
		more = string.format(L_BUY_TIMES_MSG_MODETYPE_2.buy_open_week_days_more, 100)
	}

	LayerManager:pushInLayer("PopDoLayer", var_42_0)
end
