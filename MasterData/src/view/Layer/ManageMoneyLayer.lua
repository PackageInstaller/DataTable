ManageMoneyLayer = class("ManageMoneyLayer", function()
	return PopBaseLayer:create()
end)

local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_5 = config._DEBUG and 0 or 1

function ManageMoneyLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ManageMoneyLayer.new()

	if arg_2_1 and arg_2_1.ispop then
		var_2_0:initBg(arg_2_1)
	else
		var_2_0:init(arg_2_1)
	end

	return var_2_0
end

function ManageMoneyLayer:init(arg_3_1)
	local var_3_0 = config._DEBUG and "ManageMoneyLayer.json" or "ManageMoneyLayer.ExportJson"

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer)

	self.ispop = arg_3_1 and arg_3_1.ispop
	self.rootpanel = ccs.GUIReader:getInstance():widgetFromJsonFile(var_3_0)

	self.rootLayer:addChild(self.rootpanel, 10)
	self.showActions.moveFadeIn(self)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_newbee_investment_info(MANAGE_MONEY_ACTIVITYID)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			for iter_4_0, iter_4_1 in pairs(self.schedulerList) do
				time_check_manager:removeUpdatePool(iter_4_1)
			end

			self.schedulerList = nil

			if arg_3_1 and arg_3_1.exitcallback then
				arg_3_1.exitcallback()
			end

			activity_manager:releaseEventListenerByName("ManageMoneyLayer")
		end
	end)
end

function ManageMoneyLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("ManageMoneyLayer", activity_manager.activityEventId.ACTIVITY_MANAGE_MONEY_DATA_UPDATE, function(arg_6_0)
		arg_5_0.moneyList = arg_6_0.issue_list

		arg_5_0:updateTimeLabel()
		arg_5_0:updateMoneyView()

		if arg_5_0.confirmPanel and arg_5_0.confirmPanel:isVisible() then
			arg_5_0.confirmPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
				arg_5_0.confirmPanel:setVisible(false)
			end)))
		end
	end)
end

function ManageMoneyLayer:initUI()
	self.bg = ccui.Helper:seekWidgetByName(self.rootpanel, "bg")
	self.confirmPanel = ccui.Helper:seekWidgetByName(self.rootpanel, "confirm")

	local var_8_0 = ccui.Helper:seekWidgetByName(self.rootpanel, "title")

	var_8_0:setTouchEnabled(true)
	var_8_0:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ManageMoneyLayer_" .. MANAGE_MONEY_ACTIVITYID
		})
	end)

	if self.ispop then
		self.rootpanel:setTouchEnabled(true)
		self.rootpanel:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end
end

function ManageMoneyLayer:updateTimeLabel()
	self.timeLabel = self.bg:getChildByName("time_label")

	self.timeLabel:setVisible(true)

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(activity_manager:getManageMoneyEndTime(MANAGE_MONEY_ACTIVITYID), function(arg_12_0)
		if arg_12_0 <= 0 and self.activityScheduler then
			if self.timeLabel then
				self.timeLabel:setString(L_ACTIVITY_END)
			end

			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end

		self.timeLabel:setString(L_LEFT_TIME_SPACE .. Global_format_time_str(arg_12_0))
	end)))
end

function ManageMoneyLayer:updateMoneyView()
	if self.moneyView then
		self:updateShowingCells(self.moneyView, #self.moneyList)

		return
	end

	self.schedulerList = {}

	local var_13_0 = self.bg:getChildByName("tableview")
	local var_13_1 = self.bg:getChildByName("cell")

	self.moneyView = cc.TableView:create(var_13_0:getContentSize())

	self.moneyView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.moneyView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.moneyView:setAnchorPoint(var_13_0:getAnchorPoint())
	self.moneyView:setPosition(var_13_0:getPosition())
	self.moneyView:setDelegate()
	var_13_0:getParent():addChild(self.moneyView)

	self.moneyView.cellsize = cc.size(var_13_1:getContentSize().width, var_13_1:getContentSize().height + 20)

	self.moneyView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return var_13_1:getContentSize().width, var_13_1:getContentSize().height + 8
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.moneyView:registerScriptHandler(function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0:dequeueCell()

		if not var_14_0 then
			var_14_0 = cc.TableViewCell:create()

			local var_14_2 = self:updateMoneySprite(nil, var_13_1, arg_14_1 + 1)

			var_14_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_14_2:setPosition(cc.p(var_13_0:getContentSize().width / 2, var_13_1:getContentSize().height / 2 + 4))
			var_14_0:addChild(var_14_2)
		else
			self:updateMoneySprite(var_14_0:getChildByName("sprite"), nil, arg_14_1 + 1)
		end

		return var_14_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.moneyView:registerScriptHandler(function(arg_16_0, arg_16_1)
		return #self.moneyList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.moneyView:reloadData()
end

local var_0_6 = {
	[0] = {
		currency_bg_off = "ManageMoneyLayer/diamond_bg_off.png",
		currency_bg_on = "ManageMoneyLayer/diamond_bg_on.png",
		currency = "public/currency/888888.png"
	},
	{
		currency_bg_off = "ManageMoneyLayer/gift_card_bg_off.png",
		currency_bg_on = "ManageMoneyLayer/gift_card_bg_on.png",
		currency = "public/currency/6800601.png"
	}
}

local function var_0_7(arg_17_0)
	if arg_17_0.reward then
		return false
	end

	return time_check_manager:getCurTime() >= arg_17_0.end_time and arg_17_0.invest
end

local function var_0_8(arg_18_0)
	return time_check_manager:getCurTime() >= arg_18_0.end_time and not arg_18_0.invest
end

function ManageMoneyLayer:updateMoneySprite(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = self.moneyList[arg_19_3]

	if not arg_19_1 then
		arg_19_1 = arg_19_2:clone()

		arg_19_1:setVisible(true)
		arg_19_1:setName("sprite")
	end

	local var_19_1 = var_0_8(var_19_0)
	local var_19_2 = var_0_7(var_19_0)
	local var_19_3 = time_check_manager:getCurTime()
	local var_19_4 = activity_manager:getManageMoneyRewardType(MANAGE_MONEY_ACTIVITYID, var_19_0.issue)

	arg_19_1:getChildByName("day"):loadTexture("ManageMoneyLayer/" .. var_19_0.issue .. ".png", var_0_5)
	arg_19_1:getChildByName("currency_bg"):loadTexture((var_19_2 or nil) and var_0_6[var_19_4].currency_bg_on, var_0_5)
	arg_19_1:getChildByName("currency"):loadTexture(var_0_6[var_19_4].currency, var_0_5)
	arg_19_1:getChildByName("currency"):setVisible(not var_19_1 and not var_19_0.reward and not (var_19_3 < var_19_0.begin_time))
	arg_19_1:getChildByName("num"):setString("X" .. activity_manager:getManageMoneyRewardNum(MANAGE_MONEY_ACTIVITYID, var_19_0.issue))
	arg_19_1:getChildByName("num"):setVisible(not var_19_1 and not var_19_0.reward and not (var_19_3 < var_19_0.begin_time))
	arg_19_1:getChildByName("got"):setVisible(var_19_0.reward)
	arg_19_1:getChildByName("unlock"):setVisible(var_19_3 < var_19_0.begin_time)

	local var_19_6 = "ManageMoneyLayer/btn_get.png"

	if not var_19_0.invest then
		var_19_6 = "ManageMoneyLayer/btn_buy.png"
	end

	arg_19_1:getChildByName("btn_get"):loadTextures(var_19_6, nil, var_19_6, var_0_5)
	arg_19_1:getChildByName("btn_get"):setVisible(not var_19_1 and not var_19_0.reward and not (var_19_3 < var_19_0.begin_time))

	local var_19_7 = cc.c3b(255, 255, 255)

	arg_19_1:getChildByName("btn_get"):setColor((var_19_0.invest and not var_19_2 or nil) and cc.c3b(117, 117, 117))
	arg_19_1:getChildByName("time_out"):setVisible(var_19_1)
	arg_19_1:getChildByName("clip"):setVisible(var_19_0.reward or var_19_3 < var_19_0.begin_time or var_19_1)
	arg_19_1:getChildByName("time"):setVisible(var_19_3 < var_19_0.begin_time)
	arg_19_1:getChildByName("time_lbl"):setVisible(var_19_3 < var_19_0.begin_time)

	if var_19_3 < var_19_0.begin_time and not self.schedulerList[arg_19_3] then
		self.schedulerList[arg_19_3] = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_19_0.begin_time - var_19_3, function(arg_20_0)
			arg_19_1:getChildByName("time_lbl"):setString(Global_format_time_str(arg_20_0) .. L_MANAGE_MONEY_LOCK)

			if arg_20_0 <= 0 and self.schedulerList[arg_19_3] then
				arg_19_1:getChildByName("time_lbl"):setVisible(false)
				time_check_manager:removeUpdatePool(self.schedulerList[arg_19_3])

				self.schedulerList[arg_19_3] = nil

				activity_manager:get_activity_newbee_investment_info(MANAGE_MONEY_ACTIVITYID)
			end
		end)))
	end

	local var_19_8 = arg_19_1:getChildByName("title_1")
	local var_19_9 = arg_19_1:getChildByName("title_2")
	local var_19_10 = arg_19_1:getChildByName("title_3")
	local var_19_11 = arg_19_1:getChildByName("des_1")
	local var_19_12 = arg_19_1:getChildByName("des_2")
	local var_19_13 = arg_19_1:getChildByName("des_3")
	local var_19_14, var_19_15 = activity_manager:getManageMoneyInvestNum(MANAGE_MONEY_ACTIVITYID, var_19_0.issue)

	var_19_8:setString(var_19_15)
	var_19_9:setString(var_19_14)
	var_19_8:setPositionX(var_19_9:getPositionX() + var_19_9:getContentSize().width + 3)

	local var_19_16, var_19_17 = activity_manager:getManageMoneyGetNum(MANAGE_MONEY_ACTIVITYID, var_19_0.issue)

	var_19_12:setString(var_19_16)
	var_19_13:setString(var_19_17)
	var_19_13:setPositionX(var_19_12:getPositionX() + var_19_12:getContentSize().width + 3)
	arg_19_1:getChildByName("btn_get"):addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_19_2 then
			activity_manager:activity_newbee_investment_reward(MANAGE_MONEY_ACTIVITYID, var_19_0.issue)

			return
		end

		if not var_19_0.invest and var_19_3 > var_19_0.end_time then
			global_ShowBlockWords(L_MANAGE_MONEY_INVEST[3])

			return
		end

		if var_19_0.invest and var_19_3 < var_19_0.end_time then
			global_ShowBlockWords(L_MANAGE_MONEY_GET_REWARD[5])

			return
		end

		self:showConfirmPop(var_19_0.issue)
	end)
	arg_19_1:registerScriptHandler(function(arg_22_0)
		if arg_22_0 == "exit" and self.schedulerList[arg_19_3] then
			time_check_manager:removeUpdatePool(self.schedulerList[arg_19_3])

			self.schedulerList[arg_19_3] = nil
		end
	end)

	return arg_19_1
end

function ManageMoneyLayer:showConfirmPop(arg_23_1)
	self.confirmPanel:setOpacity(0)
	self.confirmPanel:setVisible(true)
	self.confirmPanel:runAction(cc.FadeIn:create(0.2))

	local var_23_0 = self.confirmPanel:getChildByName("do_bg")
	local var_23_1 = var_23_0:getChildByName("des_1")
	local var_23_2 = var_23_0:getChildByName("des_2")
	local var_23_3 = var_23_0:getChildByName("des_3")
	local var_23_4, var_23_5 = activity_manager:getManageMoneyInvestNum(MANAGE_MONEY_ACTIVITYID, arg_23_1)

	var_23_1:setString(var_23_5)
	var_23_2:setString(var_23_4)
	var_23_1:setPositionX(var_23_2:getPositionX() + var_23_2:getContentSize().width + 3)
	var_23_0:getChildByName("btn_sure"):addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:activity_newbee_investment_invest(MANAGE_MONEY_ACTIVITYID, arg_23_1)
	end)
	var_23_0:getChildByName("btn_cancel"):addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.confirmPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			self.confirmPanel:setVisible(false)
		end)))
	end)
	self.confirmPanel:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.confirmPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			self.confirmPanel:setVisible(false)
		end)))
	end)
end

function ManageMoneyLayer.updateShowingCells(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0, var_29_1 = GetTableViewShowCellIdx(arg_29_1, {
		maxcount = math.ceil(arg_29_2),
		cellsize = arg_29_1.cellsize
	})

	for iter_29_0 = var_29_0, var_29_1 do
		arg_29_1:updateCellAtIndex(iter_29_0)
	end
end

function ManageMoneyLayer:initBg(arg_30_1)
	local var_30_0 = ccui.Layout:create()

	var_30_0:setTouchEnabled(true)
	var_30_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_30_0:setAnchorPoint(cc.p(0, 0))
	var_30_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_30_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_30_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_30_0:setOpacity(0)
	self:addChild(var_30_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_31_0)
		self:addChild(arg_31_0, -2)
		arg_31_0:setPositionY(arg_31_0:getPositionY() - GameDisplay.fix_y)

		local var_31_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_31_0:setAnchorPoint(cc.p(0, 0))
		var_31_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_31_0, -1)
		self:init(arg_30_1)
		var_30_0:setOpacity(102)
		var_30_0:setTouchEnabled(false)
	end)
end
