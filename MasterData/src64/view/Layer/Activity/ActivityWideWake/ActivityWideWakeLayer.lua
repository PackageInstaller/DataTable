ActivityWideWakeLayer = class("ActivityWideWakeLayer", function()
	return cc.Layer:create()
end)

function ActivityWideWakeLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityWideWakeLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_widewake_manager = require("controller.activity_widewake_manager")
local playermodel = require("model.playermodel")
local share_manager = require("controller.share_manager")
local shop_manager = require("controller.shop_manager")
local horcrux_manager = require("controller.horcrux_manager")
local audio_manager = require("controller.audio_manager")
local component_manager = require("controller.component_manager")
local twist_manager = require("controller.twist_manager")
local weapon_manager = require("controller.weapon_manager")
local level_manager = require("controller.level_manager")
local autopop_manager = require("controller.autopop_manager")
local aiattack_manager = require("controller.aiattack_manager")
local l2utils = require("controller.l2utils")
local drop_data = require("data.drop_data")
local shop_data = require("data.shop_data")
local item_data = require("data.item_data")
local horcrux_data = require("data.horcrux_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local twist_config_data = require("data.twist_config_data")
local var_0_25 = 109001001
local var_0_26 = 188
local var_0_27 = config._DEBUG and 0 or 1
local network = require("network.network")
local var_0_29 = 105
local var_0_30 = 106
local var_0_31 = 107
local var_0_32 = 1
local var_0_33 = 2
local var_0_34 = 1
local var_0_35 = 0
local var_0_36 = 1
local var_0_37 = 2

local function var_0_38(arg_3_0)
	if not arg_3_0 then
		return
	end

	if arg_3_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_3_0 / 86400), math.floor(arg_3_0 % 86400 / 3600))
	elseif arg_3_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_3_0 / 3600), math.floor(arg_3_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_3_0 / 60))
	end
end

function ActivityWideWakeLayer:init(arg_4_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityWideWakeLayer.json" or "ActivityWideWakeLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.curShowTwist = 105
	self.twist_type_to_index = {}
	self.curtwistDate = {}
	self.firstJoin = true

	self:initUI()
	self:fullScreen()
	self:registerActivityEventListener()
	activity_widewake_manager:getTwistStatus()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityWideWakeLayer")

			if self.getTimeScheduler then
				time_check_manager:removeUpdatePool(self.getTimeScheduler)

				self.getTimeScheduler = nil
			end
		end
	end)
end

function ActivityWideWakeLayer.registerActivityEventListener(arg_6_0)
	activity_manager:registerEventListener("ActivityWideWakeLayer", activity_manager.activityEventId.ACTIVITY_TWIST_STATUS_UPDATE, function(arg_7_0)
		for iter_7_0, iter_7_1 in pairs((activity_widewake_manager:getTwistConf())) do
			arg_6_0.curtwistDate[iter_7_0] = {
				pos = iter_7_0,
				upitems = iter_7_1.items,
				twistType = iter_7_1.twisttype,
				img = iter_7_1.img,
				time = iter_7_1.time,
				twistcount = iter_7_1.twistcount,
				upid = iter_7_1.upid,
				upcount = iter_7_1.upcount,
				updes = iter_7_1.updes,
				upcount2 = iter_7_1.upcount2,
				uppos2 = iter_7_1.uppos2,
				costtype = iter_7_1.costtype,
				costone = iter_7_1.costone,
				costten = iter_7_1.costten,
				dailyfreeforone = iter_7_1.dailyfreeforone,
				totalfreeforone = iter_7_1.totalfreeforone,
				dailyfreeforten = iter_7_1.dailyfreeforten,
				totalfreeforten = iter_7_1.totalfreeforten,
				naivemark = iter_7_1.naivemark,
				blackcard_type = iter_7_1.blackcard_type,
				twist_remain_count = iter_7_1.twist_remain_count
			}
			arg_6_0.twist_type_to_index[iter_7_1.twisttype] = iter_7_0

			if arg_6_0.initTwisType and arg_6_0.initTwisType == iter_7_1.twisttype then
				arg_6_0.curTwistIndex = iter_7_0
			end
		end

		arg_6_0.canTiwst = true

		if arg_6_0.firstJoin then
			arg_6_0.firstJoin = false

			arg_6_0:switchShowBtn()
		end

		arg_6_0:updateTwistBtn()
	end)
	activity_manager:registerEventListener("ActivityWideWakeLayer", activity_manager.activityEventId.ACTIVITY_TWIST_ITEM_UPDATE, function(arg_8_0)
		arg_6_0.showEffect = true

		arg_6_0:updateOrdTwistList()
		arg_6_0:updateSpTwistList()

		arg_6_0.showEffect = false
	end)
end

function ActivityWideWakeLayer:initUI()
	self:initTiwstLayer()
	self:initBottomList()
	self:initPanelUP()
	self:initTwistPanel()
end

function ActivityWideWakeLayer:initTiwstLayer()
	self.rootPanel = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TwistEgg.json" or "TwistEgg.ExportJson")

	self.rootPanel:setAnchorPoint(cc.p(0, 0))
	self.rootPanel:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootPanel, 5)
	self.rootPanel:setTouchEnabled(false)
	self.rootPanel:getChildByName("Button_one"):setVisible(false)
	self.rootPanel:getChildByName("Button_ten"):setVisible(false)

	self.clipPanel = self.rootPanel:getChildByName("Panel_clip")

	self.clipPanel:setVisible(false)

	self.mainImg = ccui.Helper:seekWidgetByName(self.rootPanel, "Image_main")

	self.mainImg:setTouchEnabled(true)

	self.timePanel = ccui.Helper:seekWidgetByName(self.rootPanel, "Panel_time")

	self.timePanel:setVisible(false)

	self.countPanel = ccui.Helper:seekWidgetByName(self.rootPanel, "Panel_count")

	self.countPanel:setVisible(false)
	self.countPanel:setPositionX(20)

	self.doubleCount1 = ccui.Helper:seekWidgetByName(self.rootPanel, "up_count1")

	self.doubleCount1:setVisible(false)

	self.doubleCount2 = ccui.Helper:seekWidgetByName(self.rootPanel, "up_count2")

	self.doubleCount2:setVisible(false)
	self.rootPanel:getChildByName("Bottom_bg"):setVisible(false)

	local var_10_0 = self.rootPanel:getChildByName("Bottom_bg"):getChildByName("Panel_num_bg")

	self.freeCostImg = var_10_0:getChildByName("Image_2")
	self.paidCostImg = var_10_0:getChildByName("Image_1")
	self.costLabel = var_10_0:getChildByName("Label_num")

	ccui.Helper:seekWidgetByName(self.rootPanel, "Button_goto_market"):setVisible(false)

	self.showPanel = self.rootPanel:getChildByName("Panel_show")
	self.skipBnt = self.rootPanel:getChildByName("Button_skip")

	self:initShowResultPanel()
end

function ActivityWideWakeLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("MainLayer")
	end, {
		{
			texture = "ActivityWideWakeLayer/btn_get_ticket.png",
			name = "show_twist_ticket_get",
			word = "",
			handler = function(arg_13_0, arg_13_1)
				if arg_13_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("PopGoGainLayer", {
					item = var_0_25
				})
			end
		}
	}, "ActivityWideWakeLayer/bottom_bg.png", {
		img = "ActivityWideWakeLayer/btn_return.png"
	})

	self.bottomList:setName("bottomlist")
	self.bottomList:setAnchorPoint(cc.p(0, 0))
	self.bottomList:setPositionY(-GameDisplay.fix_y + 52)
	self.rootLayer:addChild(self.bottomList, 2)

	local var_11_0 = self.bottomList:getChildByName("show_twist_ticket_get")

	self.ticketNumLbl = cc.Label:createWithTTF("", FONT_NAME, 24)

	self.ticketNumLbl:setPosition(cc.p(var_11_0:getContentSize().width / 2, var_11_0:getContentSize().height / 2))
	var_11_0:setPositionX(var_11_0:getPositionX() - 60)
	var_11_0:setPositionY(var_11_0:getPositionY() - 60)
	var_11_0:addChild(self.ticketNumLbl)
	self:updateTwistNumber()

	local var_11_1 = self.bottomList:getChildByName("returnBtn")

	var_11_1:setPositionY(var_11_1:getPositionY() - 86)

	self.btnOne = self.rootLayer:getChildByName("btn_one")

	self.btnOne:setPosition(cc.p(160, self.bottomList:getPositionY() + 50))
	self.btnOne:addTouchEventListener(function(arg_14_0, arg_14_1)
		if self.isCanChangeTwist == false then
			return
		end

		if not self.canTiwst then
			return
		end

		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.isCanChangeTwist = false

		self:twist_one_result(self.curShowTwist, function()
			self.isCanChangeTwist = true
		end)
	end)

	self.oneBnt = self.btnOne
	self.btnTen = self.rootLayer:getChildByName("btn_ten")
	self.lessNum = self.btnTen:getChildByName("num")
	self.BMFNum = cc.Label:createWithBMFont("fonts/Xmas_twist.fnt", 1)

	self.BMFNum:setPosition(cc.p(50, 61))
	self.btnTen:addChild(self.BMFNum)
	self.btnTen:setPosition(cc.p(480, self.bottomList:getPositionY() + 50))
	self.btnTen:addTouchEventListener(function(arg_16_0, arg_16_1)
		if self.tenBntOtherLock then
			return
		end

		if not self.canTiwst then
			return
		end

		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.tenBntOtherLock = true

		local function var_16_0()
			self.tenBntOtherLock = false
		end

		if playermodel.twistTenPop then
			LayerManager:pushInLayer("PopDoLayer", {
				labels = global_deepCopy(L_TWIST_TEN_POP[6800603]),
				surecallback = function()
					self:twist_ten_result(self.curShowTwist, var_16_0)
				end,
				cancelcallback = function()
					var_16_0()

					self.tenBntOtherLock = false
				end
			})
		else
			self:twist_ten_result(self.curShowTwist, var_16_0)
		end
	end)

	self.tenBnt = self.btnTen
	self.imgNull = self.rootLayer:getChildByName("btn_null")

	self.imgNull:setPosition(cc.p(320, self.bottomList:getPositionY() + 50))

	self.imgLock = self.rootLayer:getChildByName("btn_lock")

	self.imgLock:setPosition(cc.p(320, self.bottomList:getPositionY() + 50))
end

function ActivityWideWakeLayer:initPanelUP()
	self.panelUp = self.rootLayer:getChildByName("panel_up")

	self.panelUp:getChildByName("btn_goto"):addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if level_manager:isPlayerPassLevel({
			chapter = 10,
			mode = 10
		}) or config.limit_open_system == false then
			LayerManager:switchShowLayer("SubstitutionBossLayer", {
				returnbacklayer = "ActivityWideWakeLayer"
			})
		else
			global_ShowBlockWords("通关困难库库尔坎2-10解锁!")
		end
	end)

	self.btnDetail = self.panelUp:getChildByName("btn_detail")

	self.btnDetail:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "activity_wideawake"
		})
	end)

	local var_20_0 = self.panelUp:getChildByName("lbl_item")

	var_20_0:setAnchorPoint(cc.p(0, 0.5))
	var_20_0:setPositionX(10)

	local var_20_1 = activity_widewake_manager:getActivityEndTime()

	if not var_20_1 then
		return
	end

	self.getTimeScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_20_1, function(arg_23_0)
		var_20_0:setString(L_LEFT_TIME_SPACE .. var_0_38(arg_23_0))

		if arg_23_0 <= 0 and self.getTimeScheduler then
			time_check_manager:removeUpdatePool(self.getTimeScheduler)
		end
	end)))
end

function ActivityWideWakeLayer:initTwistPanel()
	self.twistPanel = self.rootLayer:getChildByName("panel_twist")

	self.twistPanel:setAnchorPoint(cc.p(0.5, 1))
	self.twistPanel:setScale9Enabled(true)
	self.twistPanel:setCapInsets(cc.rect(320, 111, 10, 10))
	self.twistPanel:setContentSize(cc.size(640, GameDisplay.height - 536))

	self.twistBtnA = self.twistPanel:getChildByName("twist_A")
	self.twistBtnB = self.twistPanel:getChildByName("twist_B")
	self.twistBtnC = self.twistPanel:getChildByName("twist_C")

	self.twistBtnA:setAnchorPoint(cc.p(0.5, 1))
	self.twistBtnA:setPositionY(self.twistPanel:getContentSize().height - 30)
	self.twistBtnA:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curShowTwist == var_0_29 then
			return
		end

		self.twistBtnA:loadTextures("ActivityWideWakeLayer/twist_α_on.png", nil, "ActivityWideWakeLayer/twist_α_on.png", var_0_27)
		self.twistBtnB:loadTextures("ActivityWideWakeLayer/twist_β.png", nil, "ActivityWideWakeLayer/twist_β.png", var_0_27)
		self.twistBtnC:loadTextures("ActivityWideWakeLayer/twist_∞.png", nil, "ActivityWideWakeLayer/twist_∞.png", var_0_27)

		self.curShowTwist = var_0_29

		activity_widewake_manager:getTwistStatus()
		activity_widewake_manager:getTwistRemainItems(self.curShowTwist)
	end)
	self.twistBtnB:setAnchorPoint(cc.p(0.5, 1))
	self.twistBtnB:setPositionY(self.twistPanel:getContentSize().height - 30)
	self.twistBtnB:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curShowTwist == var_0_30 then
			return
		end

		self.twistBtnA:loadTextures("ActivityWideWakeLayer/twist_α.png", nil, "ActivityWideWakeLayer/twist_α.png", var_0_27)
		self.twistBtnB:loadTextures("ActivityWideWakeLayer/twist_β_on.png", nil, "ActivityWideWakeLayer/twist_β_on.png", var_0_27)
		self.twistBtnC:loadTextures("ActivityWideWakeLayer/twist_∞.png", nil, "ActivityWideWakeLayer/twist_∞.png", var_0_27)

		self.curShowTwist = var_0_30

		activity_widewake_manager:getTwistStatus()
		activity_widewake_manager:getTwistRemainItems(self.curShowTwist)
	end)
	self.twistBtnC:setAnchorPoint(cc.p(0.5, 1))
	self.twistBtnC:setPositionY(self.twistPanel:getContentSize().height - 30)
	self.twistBtnC:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curShowTwist == var_0_31 then
			return
		end

		self.twistBtnA:loadTextures("ActivityWideWakeLayer/twist_α.png", nil, "ActivityWideWakeLayer/twist_α.png", var_0_27)
		self.twistBtnB:loadTextures("ActivityWideWakeLayer/twist_β.png", nil, "ActivityWideWakeLayer/twist_β.png", var_0_27)
		self.twistBtnC:loadTextures("ActivityWideWakeLayer/twist_∞_on.png", nil, "ActivityWideWakeLayer/twist_∞_on.png", var_0_27)

		self.curShowTwist = var_0_31

		activity_widewake_manager:getTwistStatus()
		activity_widewake_manager:getTwistRemainItems(self.curShowTwist)
	end)

	self.BMLblA = cc.Label:createWithBMFont("fonts/Xmas_blue.fnt", "")

	self.BMLblA:setScale(0.2)
	self.BMLblA:setPosition(cc.p(40, 70))
	self.twistBtnA:addChild(self.BMLblA)

	self.BMLblB = cc.Label:createWithBMFont("fonts/Xmas_blue.fnt", "")

	self.BMLblB:setScale(0.2)
	self.BMLblB:setPosition(cc.p(40, 65))
	self.twistBtnB:addChild(self.BMLblB)

	local var_24_0 = self.twistPanel:getChildByName("img_view")

	var_24_0:setAnchorPoint(cc.p(0.5, 1))
	var_24_0:setPosition(cc.p(320, self.twistPanel:getContentSize().height - self.twistBtnA:getContentSize().height - 30))
	var_24_0:setScale9Enabled(true)
	var_24_0:setCapInsets(cc.rect(320, 111, 10, 10))
	var_24_0:setContentSize(cc.size(600, self.twistPanel:getContentSize().height - 130))

	local var_24_1 = ccui.ImageView:create("ActivityWideWakeLayer/line.png", var_0_27)

	var_24_1:setPosition(cc.p(300, var_24_0:getContentSize().height - 50))
	var_24_0:addChild(var_24_1)

	self.LblSpNum = cc.Label:createWithTTF(L_ACTIVITY_WIDE_WAKE.SP, FONT_NAME, 24)

	self.LblSpNum:setColor(cc.c3b(175, 179, 212))
	self.LblSpNum:setPosition(cc.p(300, var_24_0:getContentSize().height - 50))
	var_24_0:addChild(self.LblSpNum)

	local var_24_2 = ccui.ImageView:create("ActivityWideWakeLayer/line.png", var_0_27)

	var_24_2:setPosition(cc.p(300, var_24_0:getContentSize().height - 270))
	var_24_0:addChild(var_24_2)

	self.LblOrdNum = cc.Label:createWithTTF(L_ACTIVITY_WIDE_WAKE.ORD, FONT_NAME, 24)

	self.LblOrdNum:setPosition(cc.p(300, var_24_0:getContentSize().height - 270))
	self.LblOrdNum:setColor(cc.c3b(175, 179, 212))
	var_24_0:addChild(self.LblOrdNum)

	self.btnPro = self.twistPanel:getChildByName("btn_gailv")

	self.btnPro:setPositionY(var_24_0:getContentSize().height - 13)
	self.btnPro:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showTwistEggDrops(self.curShowTwist, arg_28_0)
	end)
end

function ActivityWideWakeLayer:updateTwistNumber()
	self.ticketNumLbl:setString(string.format(L_ACTIVITY_WIDE_WAKE.TWIST_TICKET_NUM, (item_manager:getItemNumber(var_0_25))))
end

function ActivityWideWakeLayer:switchShowBtn()
	self.curShowTwist = activity_widewake_manager:getNeedShowTwist()

	activity_widewake_manager:getTwistRemainItems(self.curShowTwist)

	if self.curShowTwist == var_0_29 then
		self.twistBtnA:loadTextures("ActivityWideWakeLayer/twist_α_on.png", nil, "ActivityWideWakeLayer/twist_α_on.png", var_0_27)
		self.twistBtnB:loadTextures("ActivityWideWakeLayer/twist_β.png", nil, "ActivityWideWakeLayer/twist_β.png", var_0_27)
		self.twistBtnC:loadTextures("ActivityWideWakeLayer/twist_∞.png", nil, "ActivityWideWakeLayer/twist_∞.png", var_0_27)
	elseif self.curShowTwist == var_0_30 then
		self.twistBtnA:loadTextures("ActivityWideWakeLayer/twist_α.png", nil, "ActivityWideWakeLayer/twist_α.png", var_0_27)
		self.twistBtnB:loadTextures("ActivityWideWakeLayer/twist_β_on.png", nil, "ActivityWideWakeLayer/twist_β_on.png", var_0_27)
		self.twistBtnC:loadTextures("ActivityWideWakeLayer/twist_∞.png", nil, "ActivityWideWakeLayer/twist_∞.png", var_0_27)
	else
		self.twistBtnA:loadTextures("ActivityWideWakeLayer/twist_α.png", nil, "ActivityWideWakeLayer/twist_α.png", var_0_27)
		self.twistBtnB:loadTextures("ActivityWideWakeLayer/twist_β.png", nil, "ActivityWideWakeLayer/twist_β.png", var_0_27)
		self.twistBtnC:loadTextures("ActivityWideWakeLayer/twist_∞_on.png", nil, "ActivityWideWakeLayer/twist_∞_on.png", var_0_27)
	end
end

function ActivityWideWakeLayer:updateTwistBtn()
	if activity_widewake_manager:isTwsitLock(self.curShowTwist) then
		self.btnOne:setVisible(false)
		self.btnTen:setVisible(false)
		self.imgNull:setVisible(false)
		self.imgLock:setVisible(true)
	elseif activity_widewake_manager:isTwsitNUll(self.curShowTwist) then
		self.btnOne:setVisible(false)
		self.btnTen:setVisible(false)
		self.imgNull:setVisible(true)
		self.imgLock:setVisible(false)
	else
		self.btnOne:setVisible(true)
		self.btnTen:setVisible(true)
		self.imgNull:setVisible(false)
		self.imgLock:setVisible(false)

		local var_31_0 = activity_widewake_manager:getTwistTenDisplayNum(self.curShowTwist)

		self.lessNum:setString("×" .. var_31_0 * self.curtwistDate[self.twist_type_to_index[self.curShowTwist]].costone)
		self.btnOne:getChildByName("num"):setString("×" .. self.curtwistDate[self.twist_type_to_index[self.curShowTwist]].costone)

		if var_31_0 == 10 then
			var_31_0 = 0
		end

		self.BMFNum:setString(var_31_0)
	end

	if self.curShowTwist == var_0_31 then
		self.LblSpNum:setString(L_ACTIVITY_WIDE_WAKE.MATERIAL)
		self.LblOrdNum:setString(L_ACTIVITY_WIDE_WAKE.HUR)
	else
		self.LblSpNum:setString(L_ACTIVITY_WIDE_WAKE.SP)
		self.LblOrdNum:setString(L_ACTIVITY_WIDE_WAKE.ORD)
	end

	self.BMLblA:setString(activity_widewake_manager:getTwistRemainTime(105))
	self.BMLblB:setString(activity_widewake_manager:getTwistRemainTime(106))
	self.btnPro:setVisible(self.curShowTwist == var_0_31)
end

function ActivityWideWakeLayer:updateSpTwistList()
	self.spItemData = activity_widewake_manager:getSpItemData(self.curShowTwist)

	if not self.spItemData or not next(self.spItemData) then
		return
	end

	if self.spView then
		self.spView:reloadData()

		return
	end

	local var_32_0 = self.twistPanel:getChildByName("img_view")

	self.spView = cc.TableView:create(cc.size(580, 230))

	self.spView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	self.spView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.spView:setAnchorPoint(cc.p(0, 1))
	self.spView:setPosition(0, var_32_0:getContentSize().height - var_0_26 - 110)
	self.spView:setDelegate()
	var_32_0:addChild(self.spView)
	self.spView:registerScriptHandler(function(arg_34_0, arg_34_1)
		return 144, var_0_26
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.spView:registerScriptHandler(function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_0:dequeueCell()

		if not var_33_0 then
			var_33_0 = cc.TableViewCell:create()

			local var_33_2 = self:createItemSprite(self.spItemData[arg_33_1 + 1], true)

			var_33_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_33_2:setPosition(cc.p(80, var_0_26 / 2))
			var_33_0:addChild(var_33_2)

			if arg_33_1 < 4 then
				var_33_2:setOpacity(0)
				var_33_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_33_1), cc.FadeIn:create(0.1)))
			end
		else
			var_33_0:getChildByTag(100):removeFromParent()

			local var_33_3 = self:createItemSprite(self.spItemData[arg_33_1 + 1], true)

			var_33_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_33_3:setPosition(cc.p(80, var_0_26 / 2))
			var_33_0:addChild(var_33_3)

			if self.showEffect and arg_33_1 < 4 then
				var_33_3:setOpacity(0)
				var_33_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_33_1), cc.FadeIn:create(0.1)))
			elseif var_33_3:getOpacity() < 255 then
				var_33_3:setOpacity(255)
			end
		end

		return var_33_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.spView:registerScriptHandler(function(arg_35_0, arg_35_1)
		return #self.spItemData
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.spView:reloadData()
end

function ActivityWideWakeLayer:updateOrdTwistList()
	self.ordItemData = activity_widewake_manager:getOrdTwistList(self.curShowTwist)

	if not self.ordItemData or not next(self.ordItemData) then
		return
	end

	if self.ordView then
		self.ordView:reloadData()

		return
	end

	local var_36_0 = self.twistPanel:getChildByName("img_view")

	self.ordView = cc.TableView:create(cc.size(580, var_36_0:getContentSize().height - 280))

	self.ordView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.ordView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.ordView:setAnchorPoint(cc.p(0, 1))
	self.ordView:setPosition(0, -10)
	self.ordView:setDelegate()
	var_36_0:addChild(self.ordView)
	self.ordView:registerScriptHandler(function(arg_38_0, arg_38_1)
		return 148, var_0_26
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.ordView:registerScriptHandler(function(arg_37_0, arg_37_1)
		local var_37_0 = arg_37_0:dequeueCell()
		local var_37_1

		if not var_37_0 then
			var_37_0 = cc.TableViewCell:create()

			for iter_37_0 = 1, 4 do
				if self.ordItemData[arg_37_1 * 4 + iter_37_0] then
					var_37_1 = self:createItemSprite(self.ordItemData[arg_37_1 * 4 + iter_37_0])

					var_37_1:setName("sprite" .. iter_37_0)
					var_37_1:setAnchorPoint(cc.p(0.5, 0.5))
					var_37_1:setPosition(cc.p(80 + 140 * (iter_37_0 - 1), var_0_26 / 2))
					var_37_0:addChild(var_37_1)
				end

				if arg_37_1 < 2 then
					var_37_1:setOpacity(0)
					var_37_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_37_1), cc.FadeIn:create(0.1)))
				end
			end
		else
			for iter_37_1 = 1, 4 do
				var_37_1 = var_37_0:getChildByName("sprite" .. iter_37_1)

				if var_37_1 then
					var_37_1:removeFromParent()

					var_37_1 = nil
				end

				if self.ordItemData[arg_37_1 * 4 + iter_37_1] then
					if not var_37_1 then
						var_37_1 = self:createItemSprite(self.ordItemData[arg_37_1 * 4 + iter_37_1])

						var_37_1:setName("sprite" .. iter_37_1)
						var_37_1:setAnchorPoint(cc.p(0.5, 0.5))
						var_37_1:setPosition(cc.p(80 + 140 * (iter_37_1 - 1), var_0_26 / 2))
						var_37_0:addChild(var_37_1)
					else
						var_37_1:setVisible(true)
						var_37_1:setPosition(cc.p(80 + 140 * (iter_37_1 - 1), var_0_26 / 2))
						self:updateSprite(var_37_1, self.ordItemData[arg_37_1 * 4 + iter_37_1])
					end
				elseif var_37_1 then
					var_37_1:setVisible(false)
				end
			end

			if var_37_1 and self.showEffect and arg_37_1 < 4 then
				var_37_1:setOpacity(0)
				var_37_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_37_1), cc.FadeIn:create(0.1)))
			elseif var_37_1 and var_37_1:getOpacity() < 255 then
				var_37_1:setOpacity(255)
			end
		end

		return var_37_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.ordView:registerScriptHandler(function(arg_39_0, arg_39_1)
		return math.ceil(#self.ordItemData / 4)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.ordView:reloadData()
end

function ActivityWideWakeLayer:createItemSprite(arg_40_1, arg_40_2)
	local var_40_0 = ItemSprite:createSignNewWithItemId(arg_40_1.itemid)

	var_40_0:setTag(100)
	var_40_0:setScale(0.8)

	local var_40_1 = {
		cc.p(155, 80),
		cc.p(155, 105),
		cc.p(155, 130),
		cc.p(155, 155),
		cc.p(155, 180)
	}

	if self.curShowTwist ~= var_0_31 and arg_40_1.itemid ~= 3050011 and horcrux_data[arg_40_1.itemid] then
		for iter_40_0 = 1, (arg_40_2 or nil) and 5 do
			local var_40_3 = ccui.ImageView:create("public/currency/weapon_star.png", var_0_27)

			var_40_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_40_3:setPosition(var_40_1[iter_40_0])
			var_40_3:setName("star_" .. iter_40_0)
			var_40_0:addChild(var_40_3)
		end
	end

	local var_40_4 = ccui.ImageView:create("ActivityWideWakeLayer/had_get.png", var_0_27)

	var_40_4:setPosition(cc.p(120, 60))
	var_40_4:setVisible(false)
	var_40_0:addChild(var_40_4)

	if arg_40_1.remain and arg_40_1.remain > 0 then
		var_40_0:getChildByName("name"):setString(L_TIME_REST .. arg_40_1.remain)
	elseif arg_40_1.remain and arg_40_1.remain == 0 then
		var_40_4:setVisible(true)
		var_40_0:getChildByName("name"):setVisible(false)
	end

	local var_40_5 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_27)

	var_40_5:setContentSize(cc.size(var_40_0:getContentSize().width, var_40_0:getContentSize().height))
	var_40_5:setPosition(cc.p(var_40_0:getContentSize().width / 2, var_40_0:getContentSize().height / 2))
	var_40_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_40_5:setTouchEnabled(true)
	var_40_5:setSwallowTouches(false)
	var_40_0:addChild(var_40_5)
	var_40_5:addTouchEventListener(function(arg_41_0, arg_41_1)
		if math.abs(arg_41_0:getTouchBeganPosition().y - arg_41_0:getTouchEndPosition().y) > 10 then
			return
		end

		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		showItemDetails(arg_40_1.itemid)
	end)

	return var_40_0
end

function ActivityWideWakeLayer:fullScreen()
	self.panelUp:setAnchorPoint(cc.p(0.5, 1))
	self.panelUp:setPositionY(GameDisplay.height - GameDisplay.fix_y)
	self.twistPanel:setPositionY(self.panelUp:getPositionY() - self.panelUp:getContentSize().height)
end

local var_0_39 = "mainScenebg/bg.jpg"
local var_0_40 = "mainScenebg/resultbg.jpg"
local var_0_41 = "spine/ui/twist/twist"
local var_0_42 = "spine/ui/twist/fangkuai"
local var_0_44 = cc.size(514, 815)
local var_0_48 = {
	"public/rarity/r_long.png",
	"public/rarity/sr_long.png",
	"public/rarity/ur_long.png",
	"public/rarity/mr_long.png",
	"public/rarity/sp_long.png"
}
local var_0_49 = {
	"TwistEgg/star.png",
	"TwistEgg/star_dark.png"
}
local var_0_50 = {
	{
		"r1",
		"r2"
	},
	{
		"sr1",
		"sr2"
	},
	{
		"ur1",
		"ur2"
	},
	{
		"mr1",
		"mr2"
	},
	{
		"sp1",
		"sp2"
	}
}
local var_0_51 = {
	{
		"HQ-R",
		"HQ-R-R"
	},
	{
		"HQ-SR",
		"HQ-SR-R"
	},
	{
		"HQ-UR",
		"HQ-UR-R"
	},
	{
		"HQ-MR",
		"HQ-MR-R"
	},
	{
		"HQ-SP",
		"HQ-SP-R"
	}
}

local function var_0_52()
	local var_43_0 = ccui.ImageView:create(var_0_48[1], var_0_27)

	var_43_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_43_0:setVisible(false)

	return var_43_0
end

local function var_0_53()
	return (ccui.ImageView:create())
end

local function var_0_54()
	local var_45_0 = cc.Label:createWithTTF("", FONT_NAME, 40)

	var_45_0:setAnchorPoint(cc.p(0, 0.5))
	var_45_0:enableGlow(cc.c4b(30, 170, 255, 150), 2)
	var_45_0:setVisible(false)

	return var_45_0
end

local function var_0_55()
	local var_46_0 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_46_0:setAnchorPoint(cc.p(0, 0.5))
	var_46_0:setVisible(false)

	return var_46_0
end

local function var_0_56()
	local var_47_0 = ccui.ImageView:create()

	var_47_0:setScale(0.9)

	return var_47_0
end

local function var_0_57()
	local var_48_0 = cc.Label:createWithTTF("", FONT_NAME, 50)

	var_48_0:enableGlow(cc.c4b(0, 205, 255, 150), 2)

	return var_48_0
end

local function var_0_58()
	local var_49_0 = cc.Label:createWithTTF("", FONT_NAME, 50)

	var_49_0:enableGlow(cc.c4b(250, 187, 15, 150), 2)

	return var_49_0
end

local var_0_59 = {
	cc.p(118, 213 + GameDisplay.fix_y),
	cc.p(118, 103 + GameDisplay.fix_y)
}

local function var_0_60(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0.resultInfosPanel:getChildByName("skillicon" .. arg_50_1)

	if not var_50_0 then
		var_50_0 = ccui.ImageView:create()

		var_50_0:setName("skillicon" .. arg_50_1)
		var_50_0:setScale(0.85)
		var_50_0:setPosition(var_0_59[arg_50_1])
		arg_50_0.resultInfosPanel:addChild(var_50_0)
	end

	return var_50_0
end

local var_0_61 = {
	cc.p(168, 240 + GameDisplay.fix_y),
	cc.p(168, 130 + GameDisplay.fix_y)
}

local function var_0_62(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0.resultInfosPanel:getChildByName("skillname" .. arg_51_1)

	if not var_51_0 then
		var_51_0 = cc.Label:createWithTTF("", FONT_NAME, 35)

		var_51_0:setName("skillname" .. arg_51_1)
		var_51_0:setAnchorPoint(cc.p(0, 0.5))
		var_51_0:setPosition(var_0_61[arg_51_1])
		arg_51_0.resultInfosPanel:addChild(var_51_0)
	end

	return var_51_0
end

local var_0_63 = {
	cc.p(172, 220 + GameDisplay.fix_y),
	cc.p(172, 110 + GameDisplay.fix_y)
}

local function var_0_64(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0.resultInfosPanel:getChildByName("skilldes" .. arg_52_1)

	if not var_52_0 then
		var_52_0 = cc.Label:createWithTTF("", FONT_DES, 20)

		var_52_0:setName("skilldes" .. arg_52_1)
		var_52_0:setAnchorPoint(cc.p(0, 1))
		var_52_0:setDimensions(350, 0)
		var_52_0:setPosition(var_0_63[arg_52_1])
		arg_52_0.resultInfosPanel:addChild(var_52_0)
	end

	return var_52_0
end

local var_0_65 = {
	[kITEM_HERO] = function(arg_53_0, arg_53_1)
		local var_53_0 = servant_data[item_data[arg_53_1.dropid].servant].modelid
		local var_53_1 = arg_53_0.resultPanel:getChildByName("icon")

		if not var_53_1 then
			var_53_1 = cc.Sprite:create()

			var_53_1:setAnchorPoint(cc.p(0.5, 0))
			var_53_1:setVisible(false)
			var_53_1:setName("icon")
			arg_53_0.resultPanel:addChild(var_53_1)
		end

		local var_53_2 = model_data[servant_data[item_data[arg_53_1.dropid].servant].modelid].egg_offset_x or 0
		local var_53_3 = model_data[servant_data[item_data[arg_53_1.dropid].servant].modelid].egg_offset_y or 0

		var_53_1:setTexture("role/" .. model_data[servant_data[item_data[arg_53_1.dropid].servant].modelid].role_image .. ".png")
		var_53_1:setPosition(cc.p(315 + var_53_2, 190 + GameDisplay.fix_y + var_53_3))
		var_53_1:setScale(0.8)
		var_53_1:setVisible(false)
		var_53_1:setOpacity(0)

		local var_53_4 = arg_53_0.resultInfosPanel:getChildByName("rarity")

		if not var_53_4 then
			var_53_4 = var_0_52()

			var_53_4:setName("rarity")
			arg_53_0.resultInfosPanel:addChild(var_53_4)
		end

		local var_53_5 = servant_data[item_data[arg_53_1.dropid].servant].roll_rarity or 1

		var_53_4:loadTexture(var_0_48[var_53_5], var_0_27)
		var_53_4:setPosition(cc.p(130, 181 + GameDisplay.fix_y))
		var_53_4:setOpacity(0)
		var_53_4:setVisible(false)

		local var_53_6 = arg_53_0.resultInfosPanel:getChildByName("roleattricon")

		if not var_53_6 then
			var_53_6 = var_0_53()

			var_53_6:setName("roleattricon")
			var_53_6:setPosition(cc.p(525, 120 + GameDisplay.fix_y))
			arg_53_0.resultInfosPanel:addChild(var_53_6)
		end

		var_53_6:loadTexture(ATTRICONPATH[global_get_model_attr(servant_data[item_data[arg_53_1.dropid].servant].modelid)], var_0_27)
		var_53_6:setOpacity(0)
		var_53_6:setVisible(false)

		local var_53_7 = arg_53_0.resultInfosPanel:getChildByName("name")

		if not var_53_7 then
			var_53_7 = var_0_54()

			var_53_7:setName("name")
			arg_53_0.resultInfosPanel:addChild(var_53_7)
		end

		var_53_7:setPosition(cc.p(90, 124 + GameDisplay.fix_y))
		var_53_7:setString(major_factor_data[servant_data[item_data[arg_53_1.dropid].servant].major].easy_name)
		var_53_7:setOpacity(0)
		var_53_7:setVisible(false)

		local var_53_8 = arg_53_0.resultInfosPanel:getChildByName("roledes")

		if not var_53_8 then
			var_53_8 = var_0_55()

			var_53_8:setName("roledes")
			arg_53_0.resultInfosPanel:addChild(var_53_8)
		end

		var_53_8:setString(GlobalShowRoleSaying(servant_data[item_data[arg_53_1.dropid].servant].modelid, ROLE_SOUND_TYPE.home) or major_factor_data[servant_data[item_data[arg_53_1.dropid].servant].major].descrip)
		var_53_8:setMaxLineWidth(512)
		var_53_8:setPosition(cc.p(97, 64 + GameDisplay.fix_y))
		var_53_8:setOpacity(0)
		var_53_8:setVisible(false)
		arg_53_0.skipBnt:setVisible(false)
		arg_53_0.resultAni:setVisible(true)
		arg_53_0.resultAni:play(var_0_50[var_53_5][1], false)
		arg_53_0.resultAni:addAnimation(var_0_50[var_53_5][2])
		var_53_1:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_53_1:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
			l2utils:shakeNode(var_53_1, {
				scanlinethreshold = 0.025,
				scanlinedrift = 5,
				waitframe = 0,
				shakeframe = 24,
				driftpixel = 0,
				scanlinedriftfac = 5,
				restoreframe = 24,
				driftfac = 3
			})
		end)))
		var_53_1:runAction(cc.Sequence:create(cc.DelayTime:create(2.8), cc.CallFunc:create(function()
			l2utils:removeNodeShake(var_53_1)
			GlobalPlayRoleSound(var_53_0, ROLE_SOUND_TYPE.home)
		end)))
		var_53_4:runAction(cc.Sequence:create(cc.DelayTime:create(3.2666666666666666), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_53_6:runAction(cc.Sequence:create(cc.DelayTime:create(3.2666666666666666), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_53_7:runAction(cc.Sequence:create(cc.DelayTime:create(3.2666666666666666), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_53_8:runAction(cc.Sequence:create(cc.DelayTime:create(3.6666666666666665), cc.Show:create(), cc.FadeIn:create(0.5)))

		local var_53_9 = arg_53_0.resultPanel:getChildByName("blackcardinfo")

		if arg_53_0.lastTwistBlackCard == BLACK_CARD then
			var_53_9:loadTexture("TwistEgg/panel_blackcard_bg2.png", var_0_27)
			var_53_9:getChildByName("num"):setString(string.format(L_PLAYER_DATA_TYPE.Horcrux_Card .. "x%d", arg_53_1.dropnum - 1))
			var_53_9:getChildByName("num"):setScale(1)
		else
			var_53_9:loadTexture("TwistEgg/panel_blackcard_sp_bg2.png", var_0_27)
			var_53_9:getChildByName("num"):setString(string.format("SP" .. L_PLAYER_DATA_TYPE.Horcrux_Card .. "x%d", arg_53_1.dropnum - 1))
			var_53_9:getChildByName("num"):setScale(0.91)
		end

		var_53_9:setVisible(false)
		var_53_9:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create()))
		arg_53_0.skipBnt:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.CallFunc:create(function()
			arg_53_0.resultTouchEnabled = true
		end)))
		var_53_1:runAction(cc.Sequence:create(cc.DelayTime:create(7), cc.CallFunc:create(function()
			audio_manager:playeffectMusic(TWIST_CYCLE_EFFECT, true)
		end)))
	end,
	[kITEM_HORCRUX] = function(arg_58_0, arg_58_1)
		local var_58_0 = arg_58_1.entityid
		local var_58_1 = arg_58_0.resultPanel:getChildByName("icon")

		if not var_58_1 then
			var_58_1 = cc.Sprite:create()

			var_58_1:setAnchorPoint(cc.p(0.5, 0))
			var_58_1:setVisible(false)
			var_58_1:setName("icon")
			arg_58_0.resultPanel:addChild(var_58_1)
		end

		var_58_1:setTexture("role1/" .. model_data[horcrux_data[arg_58_1.dropid].model].cute_Q .. ".png")
		var_58_1:setPosition(cc.p(315, 525 + GameDisplay.fix_y))
		var_58_1:setScale(1)
		var_58_1:setOpacity(0)
		var_58_1:setVisible(false)

		local var_58_2 = arg_58_0.resultInfosPanel:getChildByName("rarity")

		if not var_58_2 then
			var_58_2 = var_0_52()

			var_58_2:setName("rarity")
			arg_58_0.resultInfosPanel:addChild(var_58_2)
		end

		local var_58_3 = horcrux_data[arg_58_1.dropid].rarity or 1

		var_58_2:loadTexture(var_0_48[var_58_3], var_0_27)
		var_58_2:setPosition(cc.p(210, 985 + GameDisplay.fix_y))
		var_58_2:setOpacity(0)
		var_58_2:setVisible(false)

		local var_58_4 = arg_58_0.resultInfosPanel:getChildByName("horcruxattricon")

		if not var_58_4 then
			var_58_4 = var_0_56()

			var_58_4:setName("horcruxattricon")
			var_58_4:setPosition(cc.p(42, 416 + GameDisplay.fix_y))
			arg_58_0.resultInfosPanel:addChild(var_58_4)
		end

		var_58_4:loadTexture(ATTRICONPATH[global_get_model_attr(horcrux_manager:getHorcruxModel(arg_58_1.entityid))], var_0_27)
		var_58_4:setOpacity(0)
		var_58_4:setVisible(false)

		local var_58_5 = arg_58_0.resultInfosPanel:getChildByName("name")

		if not var_58_5 then
			var_58_5 = var_0_54()

			var_58_5:setName("name")
			arg_58_0.resultInfosPanel:addChild(var_58_5)
		end

		var_58_5:setPosition(cc.p(75, 420 + GameDisplay.fix_y))
		var_58_5:setString(horcrux_manager:getHorcruxName(arg_58_1.entityid))
		var_58_5:setOpacity(0)
		var_58_5:setVisible(false)

		local var_58_6 = arg_58_0.resultInfosPanel:getChildByName("dfaclabel")

		if not var_58_6 then
			var_58_6 = var_0_57()

			var_58_6:setName("dfaclabel")
			arg_58_0.resultInfosPanel:addChild(var_58_6)
		end

		var_58_6:setPosition(cc.p(250, 310 + GameDisplay.fix_y))
		var_58_6:setString("")
		var_58_6:setVisible(false)

		local var_58_7 = arg_58_0.resultInfosPanel:getChildByName("hfaclabel")

		if not var_58_7 then
			var_58_7 = var_0_58()

			var_58_7:setName("hfaclabel")
			arg_58_0.resultInfosPanel:addChild(var_58_7)
		end

		var_58_7:setPosition(cc.p(540, 310 + GameDisplay.fix_y))
		var_58_7:setString("")
		var_58_7:setVisible(false)

		local var_58_8 = horcrux_manager:getHorcruxSkills(arg_58_1.entityid)
		local var_58_9 = {}
		local var_58_10 = {}
		local var_58_11 = {}

		for iter_58_0 = 1, 2 do
			var_58_9[iter_58_0] = var_0_60(arg_58_0, iter_58_0)
			var_58_10[iter_58_0] = var_0_62(arg_58_0, iter_58_0)
			var_58_11[iter_58_0] = var_0_64(arg_58_0, iter_58_0)

			if var_58_8[iter_58_0] then
				local var_58_12 = var_58_8[iter_58_0]

				var_58_9[iter_58_0]:loadTexture((total_skill_data[var_58_8[iter_58_0]].icon or nil) and ("skill_new/skill/" .. total_skill_data[var_58_12].icon .. ".png" or "public/rolebg/skill_frame_bg.png"), var_0_27)
				var_58_10[iter_58_0]:setString(total_skill_data[var_58_12].name)
				var_58_11[iter_58_0]:setString(total_skill_data[var_58_12].description)
			else
				var_58_9[iter_58_0]:loadTexture("public/rolebg/skill_frame_bg.png", var_0_27)
				var_58_10[iter_58_0]:setString("")
				var_58_11[iter_58_0]:setString("")
			end

			var_58_9[iter_58_0]:setOpacity(0)
			var_58_9[iter_58_0]:setVisible(false)
			var_58_10[iter_58_0]:setOpacity(0)
			var_58_10[iter_58_0]:setVisible(false)
			var_58_11[iter_58_0]:setOpacity(0)
			var_58_11[iter_58_0]:setVisible(false)
		end

		local var_58_13 = horcrux_manager:getHorcruxStarLevel(arg_58_1.entityid)

		arg_58_0.skipBnt:setVisible(false)
		arg_58_0.resultAni:setVisible(true)
		arg_58_0.resultAni:play(var_0_51[var_58_3][1] .. var_58_13, false)

		if var_58_13 == 1 then
			var_58_13 = ""
		end

		arg_58_0.resultAni:addAnimation(var_0_51[var_58_3][2] .. var_58_13)
		var_58_1:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_58_1:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.CallFunc:create(function()
			l2utils:shakeNode(var_58_1, {
				scanlinethreshold = 0.025,
				scanlinedrift = 5,
				waitframe = 0,
				shakeframe = 24,
				driftpixel = 0,
				scanlinedriftfac = 5,
				restoreframe = 24,
				driftfac = 3
			})
		end)))
		var_58_1:runAction(cc.Sequence:create(cc.DelayTime:create(2.466666666666667), cc.CallFunc:create(function()
			l2utils:removeNodeShake(var_58_1)
		end)))
		var_58_2:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_58_4:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.Show:create(), cc.FadeIn:create(0.2)))
		var_58_5:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.Show:create(), cc.FadeIn:create(0.2)))
		var_58_6:runAction(cc.Sequence:create(cc.DelayTime:create(2.2333333333333334), cc.Show:create(), cc.CallFunc:create(function()
			local var_61_0 = horcrux_manager:getHorcruxDamageFac(var_58_0) / 100

			l2utils:numberlabelRandomAction(var_58_6, var_61_0 >= 10 and string.format("%.1f", var_61_0) or string.format("%.1f", var_61_0), 1, "outQuad", 20)
		end)))
		var_58_7:runAction(cc.Sequence:create(cc.DelayTime:create(2.2333333333333334), cc.Show:create(), cc.CallFunc:create(function()
			l2utils:numberlabelRandomAction(var_58_7, tostring(horcrux_manager:getHorcruxHpFac(var_58_0) / 100), 1, "outQuad", 20)
		end)))

		for iter_58_1 = 1, 2 do
			var_58_9[iter_58_1]:runAction(cc.Sequence:create(cc.DelayTime:create(2.3333333333333335), cc.Show:create(), cc.FadeIn:create(0.1)))
			var_58_10[iter_58_1]:runAction(cc.Sequence:create(cc.DelayTime:create(2.533333333333333), cc.Show:create(), cc.FadeIn:create(0.5)))
			var_58_11[iter_58_1]:runAction(cc.Sequence:create(cc.DelayTime:create(2.533333333333333), cc.Show:create(), cc.FadeIn:create(0.5)))
		end

		arg_58_0.skipBnt:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.CallFunc:create(function()
			arg_58_0.resultTouchEnabled = true
		end)))
		var_58_1:runAction(cc.Sequence:create(cc.DelayTime:create(7), cc.CallFunc:create(function()
			audio_manager:playeffectMusic(TWIST_CYCLE_EFFECT, true)
		end)))
	end
}

local function var_0_66(arg_68_0)
	if arg_68_0.resultPanel:getChildByName("icon") then
		arg_68_0.resultPanel:getChildByName("icon"):stopAllActions()
		l2utils:removeNodeShake(arg_68_0.resultPanel:getChildByName("icon"))
		arg_68_0.resultPanel:getChildByName("icon"):setVisible(false)
	end

	arg_68_0.resultPanel:getChildByName("blackcardinfo"):setVisible(false)

	for iter_68_0, iter_68_1 in pairs(arg_68_0.resultInfosPanel:getChildren()) do
		iter_68_1:stopAllActions()
		iter_68_1:setVisible(false)
	end
end

setmetatable(var_0_65, {
	__index = function(arg_65_0, arg_65_1)
		return function(arg_66_0, arg_66_1)
			local var_66_0 = arg_66_0.resultPanel:getChildByName("icon")

			if not var_66_0 then
				var_66_0 = cc.Sprite:create()

				var_66_0:setAnchorPoint(cc.p(0.5, 0))
				var_66_0:setVisible(false)
				var_66_0:setName("icon")
				arg_66_0.resultPanel:addChild(var_66_0)
			end

			var_66_0:setTexture("equipment/" .. item_data[arg_66_1.dropid].image_id .. ".png")
			var_66_0:setPosition(cc.p(257, 400 - var_66_0:getContentSize().height / 2))
			arg_66_0.resultAni:setVisible(false)
			var_66_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.Show:create()))
			var_66_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
				arg_66_0.resultTouchEnabled = true
			end)))
		end
	end,
	__call = function(self, arg_69_1, ...)
		var_0_66(...)
		self[arg_69_1](...)
	end
})

local var_0_67 = setmetatable({
	false,
	nil,
	nil,
	false,
	[108] = false,
	[106] = false,
	[105] = false,
	[107] = false
}, {
	__index = function(arg_70_0, arg_70_1)
		return true
	end
})

function ActivityWideWakeLayer:show_twist_result(arg_71_1, arg_71_2, arg_71_3, arg_71_4)
	self.showPanel:setVisible(true)
	self.resultBg:setVisible(true)
	self:cleanShowResultPanelEvent()
	self.twistingRectPanel:getChildByName("blackcardinfo"):setVisible(false)

	if var_0_67[arg_71_1] then
		self:startTwistResultAni(arg_71_1, arg_71_2, arg_71_3, arg_71_4)
	else
		self:showTwistFinalResult(arg_71_1, arg_71_2, arg_71_3, arg_71_4)
	end
end

local function var_0_68()
	local var_72_0 = {}
	local var_72_1 = -1

	for iter_72_0 = 1, 10 do
		var_72_0[iter_72_0] = cc.p(320 + var_72_1 * 200, 950 - 0 * 250 + GameDisplay.fix_y)
		var_72_1 = var_72_1 + 1

		if var_72_1 > 1 then
			var_72_1 = -1
		end
	end

	return var_72_0
end

local function var_0_69(arg_73_0)
	if item_data[arg_73_0].bag_item_type == kITEM_HERO then
		return servant_data[item_data[arg_73_0].servant].roll_rarity > 3
	elseif item_data[arg_73_0].bag_item_type == kITEM_HORCRUX then
		return item_data[arg_73_0].rarity > 3
	else
		return false
	end
end

local function var_0_70(arg_74_0)
	if item_data[arg_74_0].bag_item_type == kITEM_HERO then
		return servant_data[item_data[arg_74_0].servant].roll_rarity >= 3
	elseif item_data[arg_74_0].bag_item_type == kITEM_HORCRUX then
		return item_data[arg_74_0].rarity > 2
	else
		return item_data[arg_74_0].equip_quality >= 5
	end
end

local function var_0_71(arg_75_0)
	if item_data[arg_75_0].bag_item_type == kITEM_HERO then
		if servant_data[item_data[arg_75_0].servant].roll_rarity >= 5 then
			return true
		end
	elseif item_data[arg_75_0].bag_item_type == kITEM_HORCRUX and item_data[arg_75_0].rarity >= 5 then
		return true
	end

	return false
end

function ActivityWideWakeLayer:startTwistResultAni(arg_76_1, arg_76_2, arg_76_3, arg_76_4)
	self:cleanTwistRectPanel()
	self.resultBg:setTexture(var_0_40)
	self.twistingRectPanel:setVisible(true)
	self.skipBnt:setVisible(false)

	local var_76_0 = #arg_76_2 == 1 and {
		cc.p(320, GameDisplay.height / 2)
	} or var_0_68()

	local function var_76_1(arg_77_0)
		local var_77_0 = self.twistingRectPanel:getChildByName("rect" .. arg_77_0)

		if not var_77_0 then
			var_77_0 = L2Skeleton:create(var_0_42 .. ".json", var_0_42 .. ".atlas", nil, true)

			var_77_0:refreshSkeleton()
			var_77_0:setName("rect" .. arg_77_0)
			self.twistingRectPanel:addChild(var_77_0)
		end

		return var_77_0
	end

	local function var_76_2(arg_78_0)
		return (item_data[arg_78_0].bag_item_type == kITEM_HERO and "role_" or "") .. (var_0_71(arg_78_0) and "red" or var_0_69(arg_78_0) and "orange" or var_0_70(arg_78_0) and "purple" or "blue")
	end

	local function var_76_3()
		return coroutine.create(function()
			for iter_80_0 = 1, #arg_76_2 do
				local var_80_0 = var_76_1(iter_80_0)

				var_80_0:setPosition(var_76_0[iter_80_0])
				var_80_0:setVisible(true)

				local var_80_2 = var_76_2(arg_76_2[iter_80_0].itemid ~= arg_76_2[iter_80_0].dropid and arg_76_2[iter_80_0].itemid == 1500001 and arg_76_2[iter_80_0].dropid or arg_76_2[iter_80_0].itemid)

				var_80_0:play(var_80_2, false)
				var_80_0:addAnimation(var_80_2 .. "2")
				audio_manager:playeffectMusic(TWIST_ADD_EFFECT)
				coroutine.yield(iter_80_0)
			end

			for iter_80_1 = 1, 3 do
				coroutine.yield("wait")
			end

			return "end"
		end)
	end

	if self.showAniScheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)
	end

	local var_76_4 = var_76_3()

	self.showAniScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_81_0)
		if not var_76_4 then
			var_76_4 = var_76_3()

			return
		end

		local var_81_0, var_81_1 = coroutine.resume(var_76_4)

		assert(var_81_0, var_81_1)

		if var_81_1 == "end" then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)

			self.showAniScheduler = nil
			var_76_4 = nil

			self.twistingRectPanel:setVisible(false)

			if var_0_67[arg_76_1] then
				self:showTwistItemsInfoAni(arg_76_1, arg_76_2, arg_76_3, arg_76_4)
			else
				self:showTwistFinalResult(arg_76_1, arg_76_2, arg_76_3, arg_76_4)
			end
		end
	end, 0.2, false)
end

function ActivityWideWakeLayer:showTwistItemsInfoAni(arg_82_1, arg_82_2, arg_82_3, arg_82_4)
	self.resultBg:setTexture(var_0_39)
	self.resultPanel:setVisible(true)
	self.resultInfosPanel:setVisible(true)
	self.skipBnt:setVisible(true)
	var_0_66(self)

	local var_82_0 = (function()
		return coroutine.create(function()
			for iter_84_0 = 1, #arg_82_2 do
				var_0_65(item_data[arg_82_2[iter_84_0].dropid].bag_item_type, self, arg_82_2[iter_84_0])
				audio_manager:stopAllEffects()
				audio_manager:playeffectMusic(TWIST_CHANGE_EFFECT)
				coroutine.yield(iter_84_0)
			end

			audio_manager:stopAllEffects()

			return "end"
		end)
	end)()
	local var_82_1, var_82_2 = coroutine.resume(var_82_0)

	assert(var_82_1, var_82_2)
	self.showPanel:addTouchEventListener(function(arg_85_0, arg_85_1)
		if arg_85_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.resultTouchEnabled then
			return
		end

		if not var_82_0 then
			return
		end

		self.resultTouchEnabled = false

		local var_85_0, var_85_1 = coroutine.resume(var_82_0)

		assert(var_85_0, var_85_1)

		if var_85_1 == "end" then
			var_82_0 = nil

			self.resultAni:setVisible(false)
			self.resultPanel:setVisible(false)
			self.resultInfosPanel:setVisible(false)
			var_0_66(self)
			self:showTwistFinalResult(arg_82_1, arg_82_2, arg_82_3, arg_82_4)
		end
	end)
	self.skipBnt:addTouchEventListener(function(arg_86_0, arg_86_1)
		if arg_86_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.resultTouchEnabled then
			return
		end

		self.resultTouchEnabled = false
		var_82_0 = nil

		self.resultAni:setVisible(false)
		self.resultPanel:setVisible(false)
		self.resultInfosPanel:setVisible(false)
		var_0_66(self)
		audio_manager:stopAllEffects()
		self:showTwistFinalResult(arg_82_1, arg_82_2, arg_82_3, arg_82_4)
	end)
end

local var_0_72 = {
	"public/box/new_item_bg1.png",
	"public/box/new_item_bg2.png",
	"public/box/new_item_bg3.png",
	"public/box/new_item_bg4.png",
	"public/box/new_item_bg5.png",
	"public/box/new_item_bg6.png"
}
local var_0_73 = {
	wind = "TwistEgg/bg_wind.png",
	water = "TwistEgg/bg_water.png",
	fire = "TwistEgg/bg_fire.png",
	null = "TwistEgg/bg_wind.png",
	light = "TwistEgg/bg_light.png",
	dark = "TwistEgg/bg_dark.png",
	imaginary = "TwistEgg/bg_wind.png"
}
local var_0_74 = "TwistEgg/shine_frame.png"
local var_0_75 = "TwistEgg/purple_frame.png"
local var_0_76 = "TwistEgg/red_frame.png"
local var_0_77 = {
	"TwistEgg/btn_sure.png",
	"TwistEgg/btn_sure_on.png"
}
local var_0_78 = {
	[kITEM_HERO] = function(arg_87_0, arg_87_1)
		local var_87_1 = global_get_model_attr(servant_data[item_data[arg_87_0.dropid].servant].modelid)
		local var_87_2 = ccui.ImageView:create(var_0_73[var_87_1], var_0_27)
		local var_87_3 = ccui.Layout:create()

		var_87_3:setClippingEnabled(true)
		var_87_3:setContentSize(var_87_2:getContentSize().width - 8, var_87_2:getContentSize().height - 8)
		var_87_3:setPosition(cc.p(4, 4))
		var_87_3:setCascadeOpacityEnabled(true)
		var_87_3:setName("clip")
		var_87_2:addChild(var_87_3)

		local var_87_4 = cc.Sprite:create("role/shop_image/" .. model_data[servant_data[item_data[arg_87_0.dropid].servant].modelid].role_image .. ".png")

		var_87_4:setAnchorPoint(cc.p(0.5, 0))
		var_87_4:setScale(0.9)
		var_87_4:setPosition(cc.p(var_87_3:getContentSize().width / 2, -100))
		var_87_4:setName("icon")
		var_87_3:addChild(var_87_4)

		local var_87_5 = servant_data[item_data[arg_87_0.dropid].servant].roll_rarity or 1
		local var_87_6 = ccui.ImageView:create(var_0_48[var_87_5], var_0_27)

		var_87_6:setScale(0.5)
		var_87_6:setAnchorPoint(cc.p(0, 1))
		var_87_6:setPosition(cc.p(0, var_87_2:getContentSize().height))
		var_87_2:addChild(var_87_6, 1)

		local var_87_7 = ccui.ImageView:create(ATTRICONPATH[var_87_1], var_0_27)

		var_87_7:setScale(0.7)
		var_87_7:setAnchorPoint(cc.p(0, 0))
		var_87_7:setPosition(cc.p(0, 0))
		var_87_2:addChild(var_87_7, 1)

		if arg_87_0.dropnum > 2 then
			local var_87_8 = ccui.Layout:create()

			var_87_8:setClippingEnabled(true)
			var_87_8:setContentSize(var_87_2:getContentSize().width, var_87_2:getContentSize().height)
			var_87_8:setPosition(cc.p(0, 0))
			var_87_8:setCascadeOpacityEnabled(true)
			var_87_2:addChild(var_87_8)

			local var_87_10 = arg_87_1 == BLACK_CARD and "TwistEgg/black_img.png" or "TwistEgg/black_sp_img.png"
			local var_87_11 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_87_10) or cc.Sprite:createWithSpriteFrameName(var_87_10)))

			var_87_11:setType(cc.PROGRESS_TIMER_TYPE_BAR)
			var_87_11:setBarChangeRate(cc.p(0, 1))
			var_87_11:setMidpoint(cc.p(0, 1))
			var_87_11:setAnchorPoint(cc.p(0, 1))
			var_87_11:setPosition(0, var_87_8:getContentSize().height)
			var_87_11:runAction(cc.Sequence:create(cc.DelayTime:create(1.0666666666666667), cc.ProgressTo:create(0.8, 100), cc.CallFunc:create(function()
				var_87_11:stopAllActions()
				var_87_11:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1.2, 0), cc.DelayTime:create(0.3), cc.FadeTo:create(1.2, 255))))
			end)))
			var_87_8:addChild(var_87_11, 9)

			local var_87_12 = ccui.ImageView:create("TwistEgg/light_img.png", var_0_27)

			var_87_12:setAnchorPoint(cc.p(0, 1))
			var_87_12:setPosition(-10, var_87_8:getContentSize().height + 10)
			var_87_8:addChild(var_87_12, 10)
			var_87_12:setVisible(false)
			var_87_12:runAction(cc.Sequence:create(cc.DelayTime:create(1.0666666666666667), cc.Show:create(), cc.MoveTo:create(0.8, cc.p(-10, 10))))
		end

		local var_87_13

		if var_87_5 >= 5 then
			var_87_13 = var_0_76
		elseif var_87_5 >= 4 then
			var_87_13 = var_0_74
		elseif var_87_5 >= 3 then
			var_87_13 = var_0_75
		end

		if var_87_13 then
			for iter_87_0 = 1, 2 do
				local var_87_14 = ccui.ImageView:create(var_87_13, var_0_27)

				var_87_14:setPosition(cc.p(var_87_2:getContentSize().width / 2, var_87_2:getContentSize().height / 2))

				if iter_87_0 == 1 then
					var_87_14:setScale(1.1)
					var_87_14:setOpacity(0)
					var_87_14:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
				else
					var_87_14:setScale(1)
					var_87_14:setOpacity(255)
					var_87_14:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
				end

				var_87_2:addChild(var_87_14, 2)
			end
		end

		return var_87_2
	end,
	[kITEM_HORCRUX] = function(arg_89_0)
		local var_89_1 = item_data[arg_89_0.dropid].image_offset_y or 0
		local var_89_2 = (item_data[arg_89_0.dropid].image_offse_x or 0) * 0.65
		local var_89_3 = global_get_model_attr(horcrux_data[arg_89_0.dropid].model)
		local var_89_4 = ccui.ImageView:create(var_0_73[var_89_3], var_0_27)
		local var_89_5 = ccui.Layout:create()

		var_89_5:setClippingEnabled(true)
		var_89_5:setContentSize(var_89_4:getContentSize().width - 8, var_89_4:getContentSize().height - 8)
		var_89_5:setPosition(cc.p(4, 4))
		var_89_5:setCascadeOpacityEnabled(true)
		var_89_5:setName("clip")
		var_89_4:addChild(var_89_5)

		local var_89_6 = cc.Sprite:create("role1/" .. horcrux_manager:getHorcruxRoleImage(arg_89_0.dropid) .. ".png")

		var_89_6:setScale(0.65)
		var_89_6:setAnchorPoint(cc.p(0.5, 0))
		var_89_6:setPosition(cc.p(var_89_5:getContentSize().width / 2 + var_89_2, -40 + var_89_1 * 0.65))
		var_89_6:setName("icon")
		var_89_5:addChild(var_89_6)

		local var_89_7 = horcrux_data[arg_89_0.dropid].rarity or 1
		local var_89_8 = ccui.ImageView:create(var_0_48[var_89_7], var_0_27)

		var_89_8:setScale(0.5)
		var_89_8:setAnchorPoint(cc.p(0, 1))
		var_89_8:setPosition(cc.p(0, var_89_4:getContentSize().height))
		var_89_4:addChild(var_89_8, 1)

		local var_89_9 = ccui.ImageView:create(ATTRICONPATH[var_89_3], var_0_27)

		var_89_9:setScale(0.7)
		var_89_9:setAnchorPoint(cc.p(0, 0))
		var_89_9:setPosition(cc.p(0, 0))
		var_89_4:addChild(var_89_9, 1)

		for iter_89_0 = 1, horcrux_manager:getHorcruxStarLevel(arg_89_0.entityid) do
			local var_89_10 = ccui.ImageView:create(var_0_49[1], var_0_27)

			var_89_10:setScale(0.5)
			var_89_10:setPosition(cc.p(var_89_4:getContentSize().width - 20, 20 + 30 * (iter_89_0 - 1)))
			var_89_4:addChild(var_89_10, 1)
		end

		if var_89_7 > 2 then
			for iter_89_1 = 1, 2 do
				local var_89_11

				if var_89_7 > 3 then
					var_89_11 = ccui.ImageView:create(var_0_74, var_0_27) or ccui.ImageView:create(var_0_75, var_0_27)
				end

				var_89_11:setPosition(cc.p(var_89_4:getContentSize().width / 2, var_89_4:getContentSize().height / 2))

				if iter_89_1 == 1 then
					var_89_11:setScale(1.1)
					var_89_11:setOpacity(0)
					var_89_11:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
				else
					var_89_11:setScale(1)
					var_89_11:setOpacity(255)
					var_89_11:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
				end

				var_89_4:addChild(var_89_11, 2)
			end
		end

		return var_89_4
	end,
	[kITEM_DRAWING] = function(arg_90_0)
		local var_90_0 = ccui.ImageView:create(var_0_72[item_data[arg_90_0.dropid].equip_quality], var_0_27)
		local var_90_1 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

		var_90_1:setString(item_data[arg_90_0.dropid].name)
		var_90_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_90_1:setPosition(cc.p(var_90_0:getContentSize().width / 2, var_90_0:getContentSize().height / 2 - 90))
		var_90_0:addChild(var_90_1, 1)

		local var_90_2 = ccui.Layout:create()

		var_90_2:setClippingEnabled(true)
		var_90_2:setContentSize(cc.size(170, 170))
		var_90_2:setPosition(cc.p(var_90_0:getContentSize().width / 2 - 85, var_90_0:getContentSize().height / 2 - 56))
		var_90_2:setCascadeOpacityEnabled(true)
		var_90_2:setName("clip")
		var_90_0:addChild(var_90_2)

		local var_90_3 = cc.Sprite:create("equipment/draw.png")

		var_90_3:setPosition(cc.p(84, 84))
		var_90_3:setName("icon")
		var_90_3:setCascadeOpacityEnabled(true)
		var_90_2:addChild(var_90_3)

		local var_90_4 = cc.Sprite:create("equipment/" .. item_data[arg_90_0.dropid].image_id .. ".png")

		var_90_4:setScale(0.46875)
		var_90_4:setPosition(cc.p(var_90_3:getContentSize().width / 2, var_90_3:getContentSize().height / 2))
		var_90_3:addChild(var_90_4)

		if item_data[arg_90_0.dropid].equip_quality >= 5 then
			local var_90_5 = cc.Sprite:createWithSpriteFrameName("eggegg_1.png")

			var_90_5:setScale(1.25)
			var_90_5:setName("eggEffect")
			var_90_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_90_5:setPosition(var_90_0:getContentSize().width / 2, var_90_0:getContentSize().height / 2)

			local var_90_6 = cc.Animation:create()

			for iter_90_0 = 1, 8 do
				var_90_6:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("eggegg_" .. iter_90_0 .. ".png")))
			end

			var_90_6:setDelayPerUnit(0.1)
			var_90_6:setRestoreOriginalFrame(true)
			var_90_5:runAction(cc.RepeatForever:create(cc.Animate:create(var_90_6)))
			var_90_0:addChild(var_90_5)
		end

		return var_90_0
	end,
	[kITEM_HORCRUX_DRAWING] = function(arg_91_0)
		local var_91_0 = ccui.ImageView:create(var_0_72[item_data[arg_91_0.dropid].equip_quality], var_0_27)
		local var_91_1 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

		var_91_1:setString(item_data[arg_91_0.dropid].name)
		var_91_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_91_1:setPosition(cc.p(var_91_0:getContentSize().width / 2, var_91_0:getContentSize().height / 2 - 90))
		var_91_0:addChild(var_91_1, 1)

		local var_91_2 = ccui.Layout:create()

		var_91_2:setClippingEnabled(true)
		var_91_2:setContentSize(cc.size(170, 170))
		var_91_2:setPosition(cc.p(var_91_0:getContentSize().width / 2 - 85, var_91_0:getContentSize().height / 2 - 56))
		var_91_2:setCascadeOpacityEnabled(true)
		var_91_2:setName("clip")
		var_91_0:addChild(var_91_2)

		local var_91_3 = cc.Sprite:create("equipment/draw.png")

		var_91_3:setPosition(cc.p(84, 84))
		var_91_3:setName("icon")
		var_91_3:setCascadeOpacityEnabled(true)
		var_91_2:addChild(var_91_3)

		local var_91_4 = cc.Sprite:create("equipment/" .. item_data[arg_91_0.dropid].image_id .. ".png")

		var_91_4:setScale(0.46875)
		var_91_4:setPosition(cc.p(var_91_3:getContentSize().width / 2, var_91_3:getContentSize().height / 2))
		var_91_3:addChild(var_91_4)

		if item_data[arg_91_0.dropid].equip_quality >= 5 then
			local var_91_5 = cc.Sprite:createWithSpriteFrameName("eggegg_1.png")

			var_91_5:setScale(1.25)
			var_91_5:setName("eggEffect")
			var_91_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_91_5:setPosition(var_91_0:getContentSize().width / 2, var_91_0:getContentSize().height / 2)

			local var_91_6 = cc.Animation:create()

			for iter_91_0 = 1, 8 do
				var_91_6:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("eggegg_" .. iter_91_0 .. ".png")))
			end

			var_91_6:setDelayPerUnit(0.1)
			var_91_6:setRestoreOriginalFrame(true)
			var_91_5:runAction(cc.RepeatForever:create(cc.Animate:create(var_91_6)))
			var_91_0:addChild(var_91_5)
		end

		return var_91_0
	end
}

setmetatable(var_0_78, {
	__index = function(arg_92_0, arg_92_1)
		return function(arg_93_0)
			local var_93_0 = item_data[arg_93_0.dropid].equip_quality
			local var_93_1 = ccui.ImageView:create(var_0_72[item_data[arg_93_0.dropid].equip_quality], var_0_27)
			local var_93_2 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

			if arg_93_0.dropnum > 1 then
				var_93_2:setString(item_data[arg_93_0.dropid].name .. " X" .. arg_93_0.dropnum)
			else
				var_93_2:setString(item_data[arg_93_0.dropid].name)
			end

			var_93_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_93_2:setPosition(cc.p(var_93_1:getContentSize().width / 2, var_93_1:getContentSize().height / 2 - 90))
			var_93_1:addChild(var_93_2, 1)

			local var_93_3 = ccui.Layout:create()

			var_93_3:setClippingEnabled(true)
			var_93_3:setContentSize(cc.size(170, 170))
			var_93_3:setPosition(cc.p(var_93_1:getContentSize().width / 2 - 85, var_93_1:getContentSize().height / 2 - 56))
			var_93_3:setCascadeOpacityEnabled(true)
			var_93_3:setName("clip")
			var_93_1:addChild(var_93_3)

			local var_93_4 = cc.Sprite:create("equipment/" .. item_data[arg_93_0.dropid].image_id .. ".png")

			var_93_4:setPosition(cc.p(84, 84))
			var_93_4:setName("icon")
			var_93_3:addChild(var_93_4)

			if var_93_0 >= 5 then
				local var_93_5 = cc.Sprite:createWithSpriteFrameName("eggegg_1.png")

				var_93_5:setScale(1.25)
				var_93_5:setName("eggEffect")
				var_93_5:setAnchorPoint(cc.p(0.5, 0.5))
				var_93_5:setPosition(var_93_1:getContentSize().width / 2, var_93_1:getContentSize().height / 2)

				local var_93_6 = cc.Animation:create()

				for iter_93_0 = 1, 8 do
					var_93_6:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("eggegg_" .. iter_93_0 .. ".png")))
				end

				var_93_6:setDelayPerUnit(0.1)
				var_93_6:setRestoreOriginalFrame(true)
				var_93_5:runAction(cc.RepeatForever:create(cc.Animate:create(var_93_6)))
				var_93_1:addChild(var_93_5)
			end

			if item_data[arg_93_0.dropid].bag_item_type == kITEM_WEAPON then
				var_93_4:setScale(0.65)
			end

			return var_93_1
		end
	end,
	__call = function(self, arg_94_1, ...)
		return self[arg_94_1](...)
	end
})

function ActivityWideWakeLayer:showTwistFinalResult(arg_95_1, arg_95_2, arg_95_3, arg_95_4)
	self.skipBnt:setVisible(false)
	self.twistSureBtn:setVisible(false)
	self.twistingRectPanel:setVisible(true)
	self.resultBg:setTexture(var_0_40)
	self.twistingRectPanel:getChildByName("blackcardinfo"):setVisible(false)
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/twist_animation/eggegg.plist")

	self.resultTouchEnabled = false

	local var_95_0 = #arg_95_2 == 1 and {
		cc.p(320, GameDisplay.height / 2)
	} or var_0_68()

	local function var_95_1(arg_96_0)
		local var_96_0 = self.twistingRectPanel:getChildByName("rect" .. arg_96_0)

		if not var_96_0 then
			var_96_0 = L2Skeleton:create(var_0_42 .. ".json", var_0_42 .. ".atlas", nil, true)

			var_96_0:refreshSkeleton()
			var_96_0:setName("rect" .. arg_96_0)
			self.twistingRectPanel:addChild(var_96_0)
		end

		return var_96_0
	end

	local function var_95_2()
		return coroutine.create(function()
			for iter_98_0 = 1, #arg_95_2 do
				local var_98_0 = var_95_1(iter_98_0)

				var_98_0:setPosition(var_95_0[iter_98_0])
				var_98_0:setVisible(true)
				var_98_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_99_0)
					if arg_99_0.animation == "blue-out" or arg_99_0.animation == "orange-out" or arg_99_0.animation == "red-out" or arg_99_0.animation == "purple-out" then
						var_98_0:setVisible(false)
					end
				end)

				local var_98_1 = arg_95_2[iter_98_0].dropid
				local var_98_2 = arg_95_2[iter_98_0].entityid
				local var_98_3, var_98_4 = var_98_0:getPosition()
				local var_98_5 = item_data[arg_95_2[iter_98_0].dropid].bag_item_type
				local var_98_6 = var_0_78(item_data[arg_95_2[iter_98_0].dropid].bag_item_type, arg_95_2[iter_98_0], self.twistBlackCard)

				var_98_6:setName("item" .. iter_98_0)
				var_98_6:setPosition(cc.p(var_98_3, var_98_4))
				var_98_6:setOpacity(0)

				local var_98_7 = var_98_6:getChildByName("clip"):getChildByName("icon")

				var_98_7:setOpacity(0)
				self.twistingRectPanel:addChild(var_98_6)
				var_98_6:setTouchEnabled(true)
				var_98_6:addTouchEventListener(function(arg_100_0, arg_100_1)
					if arg_100_1 ~= ccui.TouchEventType.ended then
						return
					end

					if not self.resultTouchEnabled then
						return
					end

					if var_98_5 == kITEM_HORCRUX then
						LayerManager:pushInLayer("HorcruxInfoLayer", var_98_2, "twist_preview")

						return
					end

					if var_98_5 == kITEM_HERO then
						if arg_95_2[iter_98_0].itemid == 1500001 then
							if not global_basic_scene:getChildByName("OTHER_LAYER") then
								local var_100_0 = PopLayer:Item({
									hideGainButton = true,
									itemid = arg_95_2[iter_98_0].itemid
								})
							end
						else
							LayerManager:pushInLayer("SoulsLayer", {
								showtype = SHOW_TYPE_TWISTEGG_PREVIEW,
								cursoul = item_data[var_98_1].servant
							})
						end

						return
					end

					if not global_basic_scene:getChildByName("OTHER_LAYER") then
						local var_100_1 = PopLayer:Item({
							hideGainButton = true,
							itemid = var_98_1
						})
					end
				end)

				local var_98_8 = arg_95_2[iter_98_0].itemid ~= arg_95_2[iter_98_0].dropid and arg_95_2[iter_98_0].itemid == 1500001 and arg_95_2[iter_98_0].dropid or arg_95_2[iter_98_0].itemid

				if var_0_71(var_98_8) then
					var_98_0:play("red-out", false)
				elseif var_0_69(var_98_8) then
					var_98_0:play("orange-out", false)
				elseif var_0_70(var_98_8) then
					var_98_0:play("purple-out", false)
				else
					var_98_0:play("blue-out", false)
				end

				var_98_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.FadeIn:create(0.2)))
				var_98_7:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.FadeIn:create(0.2)))
				var_98_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.CallFunc:create(function()
					audio_manager:playeffectMusic(TWIST_ADD_EFFECT_AFTER)
				end)))

				if not var_0_67[arg_95_1] then
					audio_manager:playeffectMusic(TWIST_ADD_EFFECT)
				end

				coroutine.yield(iter_98_0)
			end

			if arg_95_4 and arg_95_4 > 0 then
				self.twistingRectPanel:getChildByName("blackcardinfo"):setVisible(true)

				if self.lastTwistBlackCard == BLACK_CARD then
					self.twistingRectPanel:getChildByName("blackcardinfo"):loadTexture("TwistEgg/panel_blackcard_bg1.png", var_0_27)
					self.twistingRectPanel:getChildByName("blackcardinfo"):getChildByName("num"):setString(string.format(L_PLAYER_DATA_TYPE.Horcrux_Card .. "x%d", arg_95_4))
				else
					self.twistingRectPanel:getChildByName("blackcardinfo"):loadTexture("TwistEgg/panel_blackcard_sp_bg1.png", var_0_27)
					self.twistingRectPanel:getChildByName("blackcardinfo"):getChildByName("num"):setString(string.format("SP" .. L_PLAYER_DATA_TYPE.Horcrux_Card .. "x%d", arg_95_4))
				end
			end

			self.twistSureBtn:setOpacity(0)
			self.twistSureBtn:setVisible(true)
			self.twistSureBtn:runAction(cc.FadeIn:create(0.2))

			return "end"
		end)
	end

	if self.showAniScheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)
	end

	local var_95_3 = var_95_2()
	local var_95_4, var_95_5 = coroutine.resume(var_95_3)

	assert(var_95_4, var_95_5)

	self.showAniScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_102_0)
		if not var_95_3 then
			var_95_3 = var_95_2()

			return
		end

		local var_102_0, var_102_1 = coroutine.resume(var_95_3)

		assert(var_102_0, var_102_1)

		if var_102_1 == "end" then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)

			self.showAniScheduler = nil
			var_95_3 = nil
			self.resultTouchEnabled = true
		end
	end, 0.2, false)

	self.twistSureBtn:addTouchEventListener(function(arg_103_0, arg_103_1)
		if arg_103_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.resultTouchEnabled then
			return
		end

		self.resultTouchEnabled = false
		self.isAlowOtherTouch = true
		self.tenBntOtherLock = false

		self.twistingRectPanel:setVisible(false)
		self:cleanTwistRectPanel()
		self.showPanel:setVisible(false)
		self.resultPanel:setVisible(false)
		self.resultInfosPanel:setVisible(false)
		self:cleanShowResultPanelEvent()

		if arg_95_3 then
			audio_manager:playeffectMusic(GAIN_HEAD_PORTRAIT_EFFECT)
			self:onGetNewHead(arg_95_3.itemid, function()
				GuideListener.swallowEvent(false)
				GuideListener.lockGuideTrigger(false)
				GuideListener.updateGuides(self)
			end)
		else
			GuideListener.swallowEvent(false)
			GuideListener.lockGuideTrigger(false)
			GuideListener.updateGuides(self)
		end

		autopop_manager:resumeAchievementPop()
	end)
end

function ActivityWideWakeLayer:initShowResultPanel()
	self.skipBnt:setPositionY(self.skipBnt:getPositionY() - GameDisplay.fix_y)

	self.resultTouchEnabled = false
	self.resultBg = cc.Sprite:create(var_0_39)

	self.resultBg:setPosition(cc.p(320, GameDisplay.height / 2))
	self.resultBg:setVisible(false)
	self.showPanel:addChild(self.resultBg, 1)

	self.resultAni = L2Skeleton:create(var_0_41 .. ".json", var_0_41 .. ".atlas", nil, true)

	self.resultAni:refreshSkeleton()
	self.resultAni:setPosition(cc.p(-45, 638 + GameDisplay.fix_y))
	self.resultAni:setVisible(false)
	self.showPanel:addChild(self.resultAni, 3)

	self.resultPanel = ccui.Layout:create()

	self.resultPanel:setContentSize(cc.size(640, GameDisplay.height))
	self.resultPanel:setVisible(false)
	self.showPanel:addChild(self.resultPanel, 5)

	self.resultInfosPanel = ccui.Layout:create()

	self.resultInfosPanel:setContentSize(cc.size(640, GameDisplay.height))
	self.resultInfosPanel:setVisible(false)
	self.showPanel:addChild(self.resultInfosPanel, 4)

	local var_105_0 = ccui.ImageView:create("TwistEgg/panel_blackcard_bg2.png", var_0_27)

	var_105_0:setAnchorPoint(cc.p(1, 0.5))
	var_105_0:setPosition(cc.p(640, 221 + GameDisplay.fix_y))
	var_105_0:setName("blackcardinfo")
	self.resultPanel:addChild(var_105_0, 5)

	local var_105_1 = cc.Label:createWithTTF(L_PLAYER_DATA_TYPE.Horcrux_Card .. "x1", "fonts/number.ttf", 18)

	var_105_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_105_1:setPosition(cc.p(var_105_0:getContentSize().width / 2 + 32, var_105_0:getContentSize().height / 2 - 18))
	var_105_1:setName("num")
	var_105_0:addChild(var_105_1)

	self.twistingRectPanel = ccui.Layout:create()

	self.twistingRectPanel:setContentSize(cc.size(640, GameDisplay.height))
	self.twistingRectPanel:setTouchEnabled(true)
	self.twistingRectPanel:setVisible(false)
	self.showPanel:addChild(self.twistingRectPanel, 2)

	local var_105_2 = ccui.ImageView:create("TwistEgg/panel_blackcard_bg1.png", var_0_27)

	var_105_2:setAnchorPoint(cc.p(1, 0.5))
	var_105_2:setPosition(cc.p(640, 226 + GameDisplay.fix_y))
	var_105_2:setName("blackcardinfo")
	var_105_2:setVisible(false)
	self.twistingRectPanel:addChild(var_105_2, 5)

	local var_105_3 = cc.Label:createWithTTF(L_PLAYER_DATA_TYPE.Horcrux_Card .. "x20", "fonts/number.ttf", 28)

	var_105_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_105_3:setPosition(cc.p(var_105_2:getContentSize().width / 2 + 50, var_105_2:getContentSize().height / 2 - 36))
	var_105_3:setName("num")
	var_105_2:addChild(var_105_3)

	self.twistSureBtn = ccui.Button:create(var_0_77[1], var_0_77[2], var_0_77[1], var_0_27)

	self.twistSureBtn:setPressedActionEnabled(true)
	self.twistSureBtn:setPosition(cc.p(450, 100 + GameDisplay.fix_y))
	self.twistSureBtn:setVisible(false)
	self.twistingRectPanel:addChild(self.twistSureBtn)
end

function ActivityWideWakeLayer:cleanTwistRectPanel()
	self.resultTouchEnabled = false

	for iter_106_0 = 1, 10 do
		local var_106_0 = self.twistingRectPanel:getChildByName("rect" .. iter_106_0)

		if var_106_0 then
			var_106_0:setVisible(false)
		else
			break
		end
	end

	for iter_106_1 = 1, 10 do
		if self.twistingRectPanel:getChildByName("item" .. iter_106_1) then
			self.twistingRectPanel:removeChildByName("item" .. iter_106_1)
		else
			break
		end
	end

	self.twistSureBtn:setVisible(false)
end

function ActivityWideWakeLayer:cleanShowResultPanelEvent()
	self.resultTouchEnabled = false

	self.showPanel:addTouchEventListener(function(arg_108_0, arg_108_1)
		return
	end)
	self.skipBnt:addTouchEventListener(function(arg_109_0, arg_109_1)
		return
	end)
end

function ActivityWideWakeLayer.twist_one_result(arg_110_0, arg_110_1, arg_110_2)
	autopop_manager:pauseAchievementPop()

	arg_110_0.isAlowOtherTouch = false

	network:rpc("add_twistegg_items", {
		twisttype = arg_110_1
	}, function(arg_111_0)
		if arg_111_0.result == 1 then
			arg_110_0.rootPanel:setVisible(true)

			arg_110_0.lastTwistBlackCard = arg_110_0.twistBlackCard

			arg_110_0:twistcost(var_0_32, arg_110_1, arg_111_0.twist_remain_count)

			if arg_111_0.item.itemtype == kITEM_HERO then
				if not playermodel.haveServant[item_data[arg_111_0.item.itemid].servant] then
					local var_111_0 = {
						servantid = item_data[arg_111_0.item.itemid].servant
					}

					var_111_0.rarity = servant_data[item_data[arg_111_0.item.itemid].servant].roll_rarity or 1

					AnalyticManager.gain_new_servant_by_twist(var_111_0)
				end
			end

			local var_111_1 = item_manager:setItemByServerItem(arg_111_0.item)

			arg_110_0:show_twist_result(arg_110_1, {
				{
					dropid = arg_111_0.dropitem.dropid,
					dropnum = arg_111_0.dropitem.dropNum,
					itemid = arg_111_0.item.itemid,
					entityid = arg_111_0.item.entityid
				}
			}, nil, (arg_111_0.blackcard or nil) and item_manager:setItemByServerItem(arg_111_0.blackcard))
			arg_110_0:updateByBlackCard(twisttype)
			arg_110_0:updateTwistNumber()

			if twist_config_data[arg_110_1].stat == 3 then
				arg_110_0:updateNaiveTwist(arg_110_1, "one")
			end

			activity_widewake_manager:getTwistRemainItems(arg_110_0.curShowTwist)
			activity_widewake_manager:getTwistStatus()
		elseif arg_111_0.result == 2 then
			arg_110_0:lackofcost(var_0_32, arg_110_1)
		elseif arg_111_0.result == 3 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[3])
		elseif arg_111_0.result == 4 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[4])
		elseif arg_111_0.result == 5 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[5])
		end

		if arg_110_2 then
			arg_110_2()
		end

		arg_110_0.isAlowOtherTouch = true
	end)
end

function ActivityWideWakeLayer.updateByBlackCard(arg_112_0)
	return
end

function ActivityWideWakeLayer.twist_ten_result(arg_113_0, arg_113_1, arg_113_2)
	autopop_manager:pauseAchievementPop()

	arg_113_0.isAlowOtherTouch = false

	network:rpc("add_twistegg_items_for_ten", {
		twisttype = arg_113_1
	}, function(arg_114_0)
		if arg_114_0.result == 1 then
			arg_113_0.rootPanel:setVisible(true)

			arg_113_0.lastTwistBlackCard = arg_113_0.twistBlackCard

			arg_113_0:twistcost(var_0_33, arg_113_1, arg_114_0.twist_remain_count)

			for iter_114_0, iter_114_1 in pairs(arg_114_0.items) do
				if iter_114_1.itemtype == kITEM_HERO then
					if not playermodel.haveServant[item_data[iter_114_1.itemid].servant] then
						local var_114_0 = {
							servantid = item_data[iter_114_1.itemid].servant
						}

						var_114_0.rarity = servant_data[item_data[iter_114_1.itemid].servant].roll_rarity or 1

						AnalyticManager.gain_new_servant_by_twist(var_114_0)
					end
				end

				item_manager:setItemByServerItem(iter_114_1)
			end

			if arg_114_0.icon then
				item_manager:setItemByServerItem(arg_114_0.icon)
			end

			local var_114_1 = 0

			if arg_114_0.blackcard then
				var_114_1 = item_manager:setItemByServerItem(arg_114_0.blackcard)
			end

			local var_114_2 = {}

			for iter_114_2, iter_114_3 in ipairs(arg_114_0.dropitems) do
				table.insert(var_114_2, {
					dropid = iter_114_3.dropid,
					dropnum = iter_114_3.dropNum,
					itemid = arg_114_0.items[iter_114_2].itemid,
					entityid = arg_114_0.items[iter_114_2].entityid
				})
			end

			arg_113_0:show_twist_result(arg_113_1, var_114_2, arg_114_0.icon, var_114_1)
			arg_113_0:updateByBlackCard(arg_113_1)
			arg_113_0:updateTwistNumber()

			if twist_config_data[arg_113_1].stat == 3 then
				arg_113_0:updateNaiveTwist(arg_113_1, "ten")
			end

			activity_widewake_manager:getTwistRemainItems(arg_113_0.curShowTwist)
			activity_widewake_manager:getTwistStatus()
			AnalyticManager.twistSuccess(arg_113_1, "ten")
		elseif arg_114_0.result == 2 then
			arg_113_0:lackofcost(var_0_33, arg_113_1)
		elseif arg_114_0.result == 3 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[3])
		elseif arg_114_0.result == 4 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[4])
		elseif arg_114_0.result == 5 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[5])
		end

		if arg_113_2 then
			arg_113_2()
		end

		arg_113_0.isAlowOtherTouch = true

		if arg_114_0.result ~= 1 then
			arg_113_0.tenBntOtherLock = false
		end
	end)
end

function ActivityWideWakeLayer:updateTwistCount(arg_115_1, arg_115_2)
	if self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount2 then
		self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount2 = self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount2 - arg_115_2

		if self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount then
			self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount = self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount - arg_115_2
		end

		if self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount2 <= 0 then
			self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount2 = nil
		end

		if self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount and self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount <= 0 then
			self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount = nil
		end

		local var_115_0
		local var_115_1

		if self.curtwistDate[self.twist_type_to_index[arg_115_1]].uppos2 == 1 then
			var_115_1 = self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount
			var_115_0 = self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount2
		else
			var_115_1 = self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount2
			var_115_0 = self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount
		end

		if var_115_0 then
			self.doubleCount1:getChildByName("num"):setString(var_115_0)
		else
			self.doubleCount1:setVisible(false)
		end

		if var_115_1 then
			self.doubleCount2:getChildByName("num"):setString(var_115_1)
		else
			self.doubleCount2:setVisible(false)
		end
	elseif self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount then
		self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount = self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount - arg_115_2

		if self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount <= 0 then
			self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount = nil

			self.countPanel:setVisible(false)
		else
			self.countPanel:getChildByName("num"):setString(self.curtwistDate[self.twist_type_to_index[arg_115_1]].upcount)
		end
	end
end

function ActivityWideWakeLayer:twistcost(arg_116_1, arg_116_2, arg_116_3)
	local var_116_0 = self.twist_type_to_index[arg_116_2]
	local var_116_1 = self.curtwistDate[self.twist_type_to_index[arg_116_2]].costtype

	if arg_116_1 == var_0_32 then
		self:updateTwistCount(arg_116_2, 1)

		if arg_116_2 == var_0_34 then
			self.freetime = self.freetime - 1
		elseif self.curtwistDate[self.twist_type_to_index[arg_116_2]].dailyfreeforone and self.curtwistDate[self.twist_type_to_index[arg_116_2]].dailyfreeforone > 0 then
			self.curtwistDate[self.twist_type_to_index[arg_116_2]].dailyfreeforone = self.curtwistDate[self.twist_type_to_index[arg_116_2]].dailyfreeforone - 1
			var_116_1 = var_0_35
		elseif self.curtwistDate[self.twist_type_to_index[arg_116_2]].totalfreeforone and self.curtwistDate[self.twist_type_to_index[arg_116_2]].totalfreeforone > 0 then
			self.curtwistDate[self.twist_type_to_index[arg_116_2]].totalfreeforone = self.curtwistDate[self.twist_type_to_index[arg_116_2]].totalfreeforone - 1
			var_116_1 = var_0_35
		elseif self.curtwistDate[self.twist_type_to_index[arg_116_2]].costtype > 2 then
			item_manager:deleteItem(self.curtwistDate[self.twist_type_to_index[arg_116_2]].costtype, self.curtwistDate[self.twist_type_to_index[arg_116_2]].costone)

			self.curtwistDate[self.twist_type_to_index[arg_116_2]].twist_remain_count = arg_116_3
		elseif self.curtwistDate[self.twist_type_to_index[arg_116_2]].costtype == var_0_36 then
			playermodel.gold = playermodel.gold - self.curtwistDate[var_116_0].costone

			global_update_gold_stone_diamond(playermodel.gold)
			AnalyticManager.twistCostSuccess(self.curtwistDate[var_116_0].costone)
		elseif self.curtwistDate[self.twist_type_to_index[arg_116_2]].costtype == var_0_37 then
			playermodel.diamond = playermodel.diamond - self.curtwistDate[var_116_0].costone

			global_update_gold_stone_diamond(nil, nil, 1)
			AnalyticManager.twistCostSuccess(nil, self.curtwistDate[var_116_0].costone, 1)
		end

		AnalyticManager.twist_one_success({
			twisttype = arg_116_2,
			cost_type = var_116_1,
			cost_num = var_116_1 == var_0_35 and 1 or self.curtwistDate[var_116_0].costone
		})

		if arg_116_2 == 4 then
			AnalyticManager.favor_twist_one({
				cost_type = var_116_1,
				cost_num = var_116_1 == var_0_35 and 1 or self.curtwistDate[var_116_0].costone
			})
		end
	elseif arg_116_1 == var_0_33 then
		self:updateTwistCount(arg_116_2, 10)

		if arg_116_2 == var_0_34 then
			self.freetime = self.freetime - 10
		elseif self.curtwistDate[self.twist_type_to_index[arg_116_2]].dailyfreeforten and self.curtwistDate[self.twist_type_to_index[arg_116_2]].dailyfreeforten > 0 then
			self.curtwistDate[self.twist_type_to_index[arg_116_2]].dailyfreeforten = self.curtwistDate[self.twist_type_to_index[arg_116_2]].dailyfreeforten - 1
			var_116_1 = var_0_35
		elseif self.curtwistDate[self.twist_type_to_index[arg_116_2]].totalfreeforten and self.curtwistDate[self.twist_type_to_index[arg_116_2]].totalfreeforten > 0 then
			self.curtwistDate[self.twist_type_to_index[arg_116_2]].totalfreeforten = self.curtwistDate[self.twist_type_to_index[arg_116_2]].totalfreeforten - 1
			var_116_1 = var_0_35
		elseif self.curtwistDate[self.twist_type_to_index[arg_116_2]].costtype > 2 then
			item_manager:deleteItem(self.curtwistDate[self.twist_type_to_index[arg_116_2]].costtype, (self.curtwistDate[self.twist_type_to_index[arg_116_2]].twist_remain_count or nil) and self.curtwistDate[self.twist_type_to_index[arg_116_2]].costone * math.min(10, self.curtwistDate[self.twist_type_to_index[arg_116_2]].twist_remain_count))

			self.curtwistDate[self.twist_type_to_index[arg_116_2]].twist_remain_count = arg_116_3
		elseif self.curtwistDate[self.twist_type_to_index[arg_116_2]].costtype == var_0_36 then
			playermodel.gold = playermodel.gold - self.curtwistDate[var_116_0].costten

			global_update_gold_stone_diamond(playermodel.gold)
			AnalyticManager.twistCostSuccess(self.curtwistDate[var_116_0].costten)
		elseif self.curtwistDate[self.twist_type_to_index[arg_116_2]].costtype == var_0_37 then
			playermodel.diamond = playermodel.diamond - self.curtwistDate[var_116_0].costten

			global_update_gold_stone_diamond(nil, nil, 1)
			AnalyticManager.twistCostSuccess(nil, self.curtwistDate[var_116_0].costten, 10)
		end

		AnalyticManager.twist_ten_success({
			twisttype = arg_116_2,
			cost_type = var_116_1,
			cost_num = var_116_1 == var_0_35 and 1 or self.curtwistDate[var_116_0].costten
		})

		if arg_116_2 == 4 then
			AnalyticManager.favor_twist_one({
				cost_type = var_116_1,
				cost_num = var_116_1 == var_0_35 and 1 or self.curtwistDate[var_116_0].costten
			})
		end
	end

	print("Twist Remain Count: ", arg_116_3)

	if arg_116_3 then
		-- block empty
	end

	if not self:checkIsHaveFreeTimes() then
		require("controller.alert_manager"):unregister_alert(ALERT_TWISTEGG)
	end
end

function ActivityWideWakeLayer:lackofcost(arg_117_1, arg_117_2)
	local var_117_0 = self.curtwistDate[self.twist_type_to_index[arg_117_2]].costtype

	if arg_117_2 == var_0_34 then
		global_ShowBlockWords(failWord[arg_117_2])
	elseif var_117_0 > 4 then
		local var_117_1

		if arg_117_1 == var_0_32 then
			var_117_1 = self.curtwistDate[self.twist_type_to_index[arg_117_2]].costone - item_manager:getItemNumber(var_117_0)
		elseif arg_117_1 == var_0_33 then
			var_117_1 = self.curtwistDate[self.twist_type_to_index[arg_117_2]].twist_remain_count and self.curtwistDate[self.twist_type_to_index[arg_117_2]].costone * math.min(self.curtwistDate[self.twist_type_to_index[arg_117_2]].twist_remain_count, 10) - item_manager:getItemNumber(var_117_0) or self.curtwistDate[self.twist_type_to_index[arg_117_2]].costten - item_manager:getItemNumber(var_117_0)
		end

		if not twist_config_data[arg_117_2].supply_cost then
			if twist_config_data[arg_117_2].gold_cost then
				local var_117_2 = {
					is_need_pop_layer = 1
				}

				function var_117_2.surecallback()
					network:rpc("supply_twist_cost", {
						twisttype = arg_117_2,
						num = var_117_1
					}, function(arg_119_0)
						if arg_119_0.result == 1 then
							if twist_config_data[arg_117_2].supply_cost then
								playermodel.diamond = playermodel.diamond - var_117_1 * twist_config_data[arg_117_2].supply_cost
							else
								playermodel.gold = playermodel.gold - var_117_1 * twist_config_data[arg_117_2].gold_cost
							end

							global_update_gold_stone_diamond(playermodel.gold, nil, playermodel.diamond)
							item_manager:setItemByServerItem(arg_119_0.item)
							self:updateTwistNumber()
							self.oneBnt:setBright(false)
							self.tenBnt:setBright(false)

							local function var_119_0()
								self.oneBnt:setBright(true)
								self.tenBnt:setBright(true)
							end

							if arg_117_1 == var_0_32 then
								self:twist_one_result(arg_117_2, var_119_0)
							else
								self:twist_ten_result(arg_117_2, var_119_0)
							end

							global_ShowBlockWords(L_TWISTEGG_LACK_OF_COST.Buy_Success, RISE_WORDS_SUCCESS)

							if twist_config_data[arg_117_2].supply_cost then
								AnalyticManager.buyTwistTicketSuccess(var_117_1 * twist_config_data[arg_117_2].supply_cost, var_117_1)
							end
						elseif arg_119_0.result == 2 then
							LayerManager:pushInLayer("PopGoBuyDiamond", {
								is_need_pop_layer = 0
							})
						elseif arg_119_0.result == 3 then
							LayerManager:pushInLayer("PopGoGainLayer", {
								goto_back_system_id = 180,
								item = var_117_0
							})
						else
							l2Log("buy_twist_ticket fail")
						end
					end)
				end

				if twist_config_data[arg_117_2].supply_cost then
					var_117_2.costtype = "diamond"
					var_117_2.own = playermodel.diamond
					var_117_2.cost = twist_config_data[arg_117_2].supply_cost * var_117_1
					var_117_2.des = string.format(L_BUY_SCRIP, twist_config_data[arg_117_2].supply_cost * var_117_1, var_117_1, item_data[var_117_0].name)
				else
					var_117_2.costtype = "gold"
					var_117_2.own = playermodel.gold
					var_117_2.cost = twist_config_data[arg_117_2].gold_cost * var_117_1
					var_117_2.des = string.format(L_TWISTEGG_LACK_OF_COST.Cost_Gold, twist_config_data[arg_117_2].gold_cost * var_117_1, var_117_1, item_data[var_117_0].name)
				end

				var_117_2.labels = global_deepCopy(L_COMPONENT_TWIST)
				var_117_2.labels.des = var_117_2.des or L_TWISTEGG_LACK_OF_COST.Cost_Diamond_Des

				LayerManager:pushInLayer("PopDoLayer", var_117_2)
			elseif var_117_0 == 6800601 then
				LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
					targetlayer = "PopSupermarketLayer"
				})
			end
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			goto_back_system_id = 180,
			item = var_117_0
		})
	elseif var_117_0 == var_0_36 then
		LayerManager:pushInLayer("PopGoLayer", {
			targetlayer = "HandOfMidasLayer",
			labels = L_GO_BUY_GOLD
		})
	end
end

local function var_0_79(arg_121_0, arg_121_1, arg_121_2)
	local var_121_0 = {
		type_tbl = {}
	}

	for iter_121_0, iter_121_1 in pairs(arg_121_0) do
		local var_121_1, var_121_2 = string.match(iter_121_0, arg_121_1)
		local var_121_3 = tonumber(var_121_1)
		local var_121_4 = tonumber(var_121_2)
		local var_121_5

		if var_121_3 and var_121_4 then
			if true == true then
				var_121_0[var_121_3] = {}
				var_121_0[var_121_3].attribute = var_121_3
				var_121_0[var_121_3].content = {}
				var_121_0[var_121_3].content[var_121_4] = {
					itemid = iter_121_1
				}
				var_121_5 = false
			else
				local var_121_7 = false

				for iter_121_2, iter_121_3 in pairs(var_121_0) do
					if iter_121_3.attribute and iter_121_3.attribute == var_121_3 then
						if iter_121_3.content[var_121_4] then
							iter_121_3.content[var_121_4].itemid = iter_121_1
						else
							iter_121_3.content[var_121_4] = {
								itemid = iter_121_1
							}
						end

						var_121_7 = true

						break
					end
				end

				if var_121_7 == false then
					var_121_0[var_121_3] = {}
					var_121_0[var_121_3].attribute = var_121_3
					var_121_0[var_121_3].content = {}
					var_121_0[var_121_3].content[var_121_4] = {
						itemid = iter_121_1
					}
				end
			end
		else
			local var_121_8 = string.match(iter_121_0, arg_121_2)

			if var_121_8 then
				var_121_0.type_tbl[tonumber(var_121_8)] = iter_121_1
			end
		end
	end

	return var_121_0
end

local function var_0_81(arg_123_0)
	local var_123_0 = {
		type_tbl = {}
	}

	for iter_123_0, iter_123_1 in pairs(arg_123_0) do
		if 1 and iter_123_0 then
			local var_123_2

			if true == true then
				var_123_0[1] = {}
				var_123_0[1].attribute = 1
				var_123_0[1].content = {}
				var_123_0[1].content[iter_123_0] = {
					itemid = iter_123_1
				}
				var_123_2 = false
			else
				local var_123_4 = false

				for iter_123_2, iter_123_3 in pairs(var_123_0) do
					if iter_123_3.attribute and iter_123_3.attribute == 1 then
						if iter_123_3.content[iter_123_0] then
							iter_123_3.content[iter_123_0].itemid = iter_123_1
						else
							iter_123_3.content[iter_123_0] = {
								itemid = iter_123_1
							}
						end

						var_123_4 = true

						break
					end
				end

				if var_123_4 == false then
					var_123_0[1] = {}
					var_123_0[1].attribute = 1
					var_123_0[1].content = {}
					var_123_0[1].content[iter_123_0] = {
						itemid = iter_123_1
					}
				end
			end
		end
	end

	local var_123_5 = {
		[65] = 2,
		[17] = 3,
		[67] = 1
	}

	setmetatable(var_123_5, {
		__index = function(arg_124_0, arg_124_1)
			return 4
		end
	})

	var_123_0.type_tbl = {}

	table.insert(var_123_0.type_tbl, L_GIFT)
	table.insert(var_123_0.type_tbl, L_FURNITURE)
	table.insert(var_123_0.type_tbl, L_TECH_MATERIAL)
	table.insert(var_123_0.type_tbl, L_OTHER_ITEM)

	local var_123_6 = {}

	table.insert(var_123_6, {
		attribute = 1,
		content = {}
	})
	table.insert(var_123_6, {
		attribute = 2,
		content = {}
	})
	table.insert(var_123_6, {
		attribute = 3,
		content = {}
	})
	table.insert(var_123_6, {
		attribute = 4,
		content = {}
	})

	for iter_123_4, iter_123_5 in pairs((global_deepCopy(var_123_0[1].content))) do
		table.insert(var_123_6[var_123_5[item_data[iter_123_5.itemid].bag_item_type]].content, {
			itemid = iter_123_5.itemid
		})
	end

	var_123_0[1] = var_123_6[1]
	var_123_0[2] = var_123_6[2]
	var_123_0[3] = var_123_6[3]
	var_123_0[4] = var_123_6[4]

	return var_123_0
end

local drop_words_data = require("data.drop_words_data")

function ActivityWideWakeLayer.showTwistEggDrops(arg_125_0, arg_125_1, arg_125_2)
	activity_widewake_manager:set_twist_status(function(arg_126_0)
		local var_126_0 = {}
		local var_126_1 = {}
		local var_126_2 = {}

		while drop_data[twist_config_data[arg_125_1].dropid]["rd_dropmodel_id" .. 1] do
			if drop_data[twist_config_data[arg_125_1].dropid]["rd_dropmodel_rate" .. 1] ~= 0 then
				var_126_2[#var_126_2 + 1] = drop_data[twist_config_data[arg_125_1].dropid]["rd_dropmodel_id" .. 1]
			end
		end

		local var_126_4 = {}

		for iter_126_0 = 1, #var_126_2 do
			local var_126_5 = 1

			while drop_data[var_126_2[iter_126_0]]["rd_drop_id" .. var_126_5] do
				if drop_data[var_126_2[iter_126_0]]["rd_drop_weight" .. var_126_5] ~= 0 then
					var_126_4[#var_126_4 + 1] = drop_data[var_126_2[iter_126_0]]["rd_drop_id" .. var_126_5]
				end

				var_126_5 = var_126_5 + 1
			end
		end

		table.sort(var_126_4)

		local twist_probability_data = require("data.twist_probability_data")

		for iter_126_1, iter_126_2 in pairs(arg_126_0) do
			if iter_126_2.twisttype == arg_125_1 then
				print("check egg pool: ", arg_125_1)

				var_126_0 = var_0_81(var_126_4)
				var_126_1 = var_0_79(drop_words_data[iter_126_2.twisttype], "type(%d+)_words(%d+)", "words_type(%d+)")
			end
		end

		local var_126_7, var_126_8, var_126_9 = (function(arg_128_0, arg_128_1)
			local var_128_0 = {}
			local var_128_1 = {}
			local var_128_2 = {
				startTime,
				finishTime
			}

			for iter_128_0 = 1, #arg_128_1 do
				if arg_128_1[iter_128_0].twisttype == arg_128_0 then
					var_128_0 = arg_128_1[iter_128_0].items
					var_128_1 = arg_128_1[iter_128_0].weights
					var_128_2.startTime = arg_128_1[iter_128_0].upstarttime
					var_128_2.finishTime = arg_128_1[iter_128_0].upfinishtime
				end
			end

			return var_128_0, var_128_1, var_128_2
		end)(arg_125_1, arg_126_0)

		if var_126_7 and next(var_126_7) ~= nil then
			local var_126_10 = {
				attribute = 999,
				content = {}
			}

			for iter_126_3 = 1, #var_126_7 do
				table.insert(var_126_10.content, {
					itemid = var_126_7[iter_126_3]
				})
			end

			table.insert(var_126_0, var_126_10)

			if var_126_0.type_tbl then
				var_126_0.type_tbl[999] = L_TWISTEGG_PROBILITY_UP
			end

			local var_126_11 = #var_126_0

			for iter_126_4 = #var_126_0, 1, -1 do
				var_126_0[iter_126_4 + 1] = var_126_0[iter_126_4]
			end

			var_126_0[1] = var_126_0[var_126_11 + 1]

			table.remove(var_126_0)
		end

		if next(var_126_0) == nil then
			if next(var_126_1) ~= nil then
				local var_126_12 = {
					callback = function()
						if not twistLayerInstance then
							return
						end

						arg_125_2:setTouchEnabled(true)
					end
				}

				var_126_12.category = {
					type = 2,
					egg_pool_type = arg_125_1,
					Items_Up = var_126_7,
					Items_Weights = var_126_8,
					Items_Uptime = var_126_9
				}
				var_126_12.items_tbl = var_126_0
				var_126_12.words_tbl = var_126_1

				LayerManager:pushInLayer("DropDetailsLayer", var_126_12)
			end
		end
	end)
end

function ActivityWideWakeLayer:updateGoldPanel()
	if self.curtwistDate[self.curTwistIndex] and self.curtwistDate[self.curTwistIndex].costtype == 1 then
		-- block empty
	end
end

function ActivityWideWakeLayer:checkIsHaveFreeTimes(arg_130_1, arg_130_2)
	if not arg_130_1 then
		for iter_130_0, iter_130_1 in pairs(self.twist_type_to_index) do
			local var_130_0 = iter_130_1

			if (self.curtwistDate[iter_130_1].dailyfreeforone or 0) <= 0 then
				local var_130_2

				if (self.curtwistDate[var_130_0].totalfreeforone or 0) <= 0 then
					var_130_2 = false

					goto label_130_0
				end
			end

			var_130_2 = true

			do
				local var_130_4
			end

			::label_130_0::

			if (self.curtwistDate[var_130_0].dailyfreeforten or 0) <= 0 then
				if (self.curtwistDate[var_130_0].totalfreeforten or 0) <= 0 then
					var_130_4 = false

					goto label_130_1
				end
			end

			::label_130_1::

			if var_130_2 or true then
				return true
			end
		end

		return false
	else
		local var_130_5 = self.twist_type_to_index[arg_130_1]

		if (self.curtwistDate[self.twist_type_to_index[arg_130_1]].dailyfreeforone or 0) <= 0 then
			local var_130_7

			if (self.curtwistDate[var_130_5].totalfreeforone or 0) <= 0 then
				var_130_7 = false

				goto label_130_2
			end
		end

		var_130_7 = true

		::label_130_2::

		if (self.curtwistDate[var_130_5].dailyfreeforten or 0) <= 0 then
			local var_130_9

			if (self.curtwistDate[var_130_5].totalfreeforten or 0) <= 0 then
				var_130_9 = false

				goto label_130_3
			end
		end

		var_130_9 = true

		::label_130_3::

		if arg_130_2 == "one" then
			return var_130_7
		elseif arg_130_2 == "ten" then
			return var_130_9
		elseif not arg_130_2 then
			return var_130_9 or var_130_7
		end
	end
end

function ActivityWideWakeLayer:checkBntsAlert(arg_131_1)
	local var_131_0 = self.curtwistDate[self.curTwistIndex].twistType

	local function var_131_1()
		local var_132_0 = self.imgScrollView:getChildByName("class_image" .. self.curTwistIndex)

		if self:checkIsHaveFreeTimes(var_131_0) then
			AlertManager:add_alert_by_config(var_132_0, true, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(10, var_132_0:getContentSize().height - 20)
			})
		else
			AlertManager:add_alert_by_config(var_132_0, false, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(10, var_132_0:getContentSize().height - 20)
			})
		end
	end

	local function var_131_2()
		if self:checkIsHaveFreeTimes(var_131_0, "one") then
			AlertManager:add_alert_by_config(self.oneBnt, true, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.oneBnt:getContentSize().width - 20, self.oneBnt:getContentSize().height - 20)
			})
		else
			AlertManager:add_alert_by_config(self.oneBnt, false, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.oneBnt:getContentSize().width - 20, self.oneBnt:getContentSize().height - 20)
			})
		end
	end

	local function var_131_3()
		if self:checkIsHaveFreeTimes(var_131_0, "ten") then
			AlertManager:add_alert_by_config(self.tenBnt, true, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.tenBnt:getContentSize().width - 20, self.oneBnt:getContentSize().height - 20)
			})
		else
			AlertManager:add_alert_by_config(self.tenBnt, false, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.tenBnt:getContentSize().width - 20, self.oneBnt:getContentSize().height - 20)
			})
		end
	end

	if arg_131_1 == "img" then
		var_131_1()
	elseif arg_131_1 == "oneBnt" then
		var_131_2()
	elseif arg_131_1 == "tenBnt" then
		var_131_3()
	else
		var_131_1()
		var_131_2()
		var_131_3()
	end
end

function ActivityWideWakeLayer:initGotoMarketBtn()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_goto_market"):addTouchEventListener(function(arg_136_0, arg_136_1)
		if arg_136_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("MarketLayer", {
			returnLayer = "ActivityWideWakeLayer",
			singleMarket = arg_136_0.shoptype,
			showType = arg_136_0.shoptype[1]
		})
	end)
end

function ActivityWideWakeLayer.onGetNewHead(arg_137_0, arg_137_1, arg_137_2)
	local var_137_0 = ccui.Layout:create()

	var_137_0:setContentSize(cc.size(640, GameDisplay.height))
	var_137_0:setTouchEnabled(true)
	var_137_0:setBackGroundImage("mainScenebg/head_get_bg.jpg")
	global_basic_scene:addChild(var_137_0, 999)
	var_137_0:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.RemoveSelf:create()))

	local var_137_1

	if config._DEBUG then
		var_137_1 = cc.Sprite:create("TwistEgg/xiao.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/xiao.png")
	end

	var_137_1:setPosition(cc.p(320, GameDisplay.height / 2))
	var_137_1:setScale(0.1)
	var_137_0:addChild(var_137_1)

	local var_137_2

	if config._DEBUG then
		var_137_2 = cc.Sprite:create("TwistEgg/zhong.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/zhong.png")
	end

	var_137_2:setPosition(cc.p(320, GameDisplay.height / 2))
	var_137_2:setScale(0.1)
	var_137_0:addChild(var_137_2, 5)

	local var_137_3

	if config._DEBUG then
		var_137_3 = cc.Sprite:create("TwistEgg/da.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/da.png")
	end

	var_137_3:setPosition(cc.p(320, GameDisplay.height / 2))
	var_137_3:setScale(0.1)
	var_137_0:addChild(var_137_3, 5)
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/compose.plist")

	local var_137_4 = cc.Sprite:createWithSpriteFrameName("compose_1.png")

	var_137_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_137_4:setPosition(cc.p(320, GameDisplay.height / 2))
	var_137_4:setVisible(false)
	var_137_0:addChild(var_137_4, 4)

	local var_137_5

	if config._DEBUG then
		var_137_5 = cc.Sprite:create("TwistEgg/kuang.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/kuang.png")
	end

	var_137_5:setPosition(cc.p(320, GameDisplay.height / 2))
	var_137_5:setVisible(false)
	var_137_0:addChild(var_137_5, 2)

	local var_137_6

	if config._DEBUG then
		var_137_6 = cc.Sprite:create("public/rolebg/icon_bg.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/icon_bg.png")
	end

	local var_137_7 = cc.Sprite:create("role/wuji/" .. item_data[arg_137_1].image_id .. ".png")

	var_137_7:setPosition(cc.p(var_137_6:getContentSize().width / 2, var_137_6:getContentSize().height / 2))
	var_137_6:addChild(var_137_7)
	var_137_6:setPosition(cc.p(320, GameDisplay.height / 2))
	var_137_6:setVisible(false)
	var_137_0:addChild(var_137_6, 300)
	var_137_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_137_2:runAction(cc.ScaleTo:create(0.2, 1))
	var_137_3:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1), cc.CallFunc:create(function()
		var_137_3:runAction(cc.RepeatForever:create(cc.RotateBy:create(3, 360)))
		var_137_2:runAction(cc.RepeatForever:create(cc.RotateBy:create(3, -360)))
		var_137_1:runAction(cc.RepeatForever:create(cc.RotateBy:create(3, 360)))

		local var_138_0 = cc.Animation:create()

		for iter_138_0 = 1, 12 do
			var_138_0:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("compose_" .. iter_138_0 .. ".png")))
		end

		var_138_0:setDelayPerUnit(0.1)
		var_137_4:setVisible(true)
		var_137_4:runAction(cc.Sequence:create(cc.Animate:create(var_138_0), cc.Hide:create(), cc.CallFunc:create(function()
			local var_139_0 = cc.Label:createWithTTF(item_data[arg_137_1].name, FONT_NAME, 40)

			var_139_0:setAnchorPoint(cc.p(0, 0.5))
			var_139_0:setPosition(cc.p(320 - var_139_0:getContentSize().width / 2, 450 + GameDisplay.fix_y))
			var_137_0:addChild(var_139_0)
			var_137_0:addTouchEventListener(function(arg_140_0, arg_140_1)
				if arg_140_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_137_2 then
					arg_137_2()
				end

				var_137_0:runAction(cc.RemoveSelf:create())
			end)
		end)))

		local var_138_1 = cc.OrbitCamera:create(0.8, 180, 0, -180, 180, 0, 0)

		var_137_5:setVisible(true)
		var_137_5:runAction(cc.Spawn:create(var_138_1:clone(), cc.Sequence:create(cc.DelayTime:create(0.4), cc.Hide:create())))
		var_137_6:runAction(cc.Spawn:create(var_138_1:clone(), cc.Sequence:create(cc.DelayTime:create(0.4), cc.Show:create())))
	end)))
end

function ActivityWideWakeLayer.get_naive_stat(arg_141_0, arg_141_1, arg_141_2)
	local bit = require("bit")
	local var_141_1 = bit.band(arg_141_1, 1) > 0 and true
	local var_141_2 = bit.band(arg_141_1, 2) > 0 and true

	if arg_141_2 == "one" then
		return var_141_1
	elseif arg_141_2 == "ten" then
		return var_141_2
	else
		return var_141_2
	end
end

function ActivityWideWakeLayer:updateNaiveTwist(arg_142_1, arg_142_2)
	local bit = require("bit")
	local var_142_1 = self.twist_type_to_index[arg_142_1]
	local var_142_2 = self.curtwistDate[self.twist_type_to_index[arg_142_1]]

	if arg_142_2 == "one" then
		var_142_2.naivemark = bit.bor(self.curtwistDate[self.twist_type_to_index[arg_142_1]].naivemark, 1)
	elseif arg_142_2 == "ten" then
		var_142_2.naivemark = bit.bor(self.curtwistDate[self.twist_type_to_index[arg_142_1]].naivemark, 2)
	end

	if self:get_naive_stat(var_142_2.naivemark) then
		table.remove(self.curtwistDate, var_142_1)

		for iter_142_0, iter_142_1 in pairs(self.curtwistDate) do
			self.twist_type_to_index[iter_142_1.twistType] = iter_142_0
		end

		for iter_142_2, iter_142_3 in pairs(self.imgScrollView:getChildren()) do
			if iter_142_3.twistIndex then
				if var_142_1 < iter_142_3.twistIndex then
					iter_142_3.twistIndex = iter_142_3.twistIndex - 1

					iter_142_3:setName("class_image" .. iter_142_3.twistIndex)
					iter_142_3:setPositionX(10 + (iter_142_3.twistIndex - 1) * (iter_142_3:getContentSize().width + 20))
				elseif iter_142_3.twistIndex == var_142_1 then
					iter_142_3:removeFromParent()
				end
			end
		end

		self.curTwistIndex = 1

		self.pointsPanel:removeAllChildren()
		self:initSlidePoints()
		self.imgScrollView:switchImg()
		self.oneBnt:setOpacity(255)
		self.tenBnt:setOpacity(255)
	elseif self:get_naive_stat(var_142_2.naivemark, "one") then
		self.oneBnt:setOpacity(100)
	elseif self:get_naive_stat(var_142_2.naivemark, "ten") then
		self.tenBnt:setOpacity(100)
	end
end
