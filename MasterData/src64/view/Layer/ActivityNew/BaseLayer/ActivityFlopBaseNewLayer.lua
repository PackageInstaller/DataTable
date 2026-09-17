ActivityFlopBaseNewLayer = class("ActivityFlopBaseNewLayer", function()
	return cc.Layer:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")

require("view.Sprite.ItemSpriteFlop")

local var_0_5 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local activity_flop_condition_conf = require("data.activity_modules.activity_flop_condition_conf")
local activity_flop_ui_conf_data = require("data.activity_flop.uiconfig.activity_flop_ui_conf_data")

require("view.Layer.ActivityNew.activity142.ActivityFlopLayer_142")
require("view.Layer.ActivityNew.activity148.ActivityFlopLayer_148")
require("view.Layer.ActivityNew.activity154.ActivityFlopLayer_154")
require("view.Layer.ActivityNew.activity186.ActivityFlopLayer_186")
require("view.Layer.ActivityNew.activity185.ActivityFlopLayer_185")
require("view.Layer.ActivityNew.activity197.ActivityFlopLayer_197")
require("view.Layer.ActivityNew.activity196.ActivityFlopLayer_196")
require("view.Layer.ActivityNew.activity208.ActivityFlopLayer_208")
require("view.Layer.ActivityNew.activity210.ActivityFlopLayer_210")
require("view.Layer.ActivityNew.activity217.ActivityFlopLayer_217")
require("view.Layer.ActivityNew.activity227.ActivityFlopLayer_227")
require("view.Layer.ActivityNew.activity230.ActivityFlopLayer_230")
require("view.Layer.ActivityNew.activity248.ActivityFlopLayer_248")
require("view.Layer.ActivityNew.activity264.ActivityFlopLayer_264")
require("view.Layer.ActivityNew.activity291.ActivityFlopLayer_291")
require("view.Layer.ActivityNew.activity304.ActivityFlopLayer_304")
require("view.Layer.ActivityNew.activity312.ActivityFlopLayer_312")
require("view.Layer.ActivityNew.activity314.ActivityFlopLayer_314")
require("view.Layer.ActivityNew.activity330.ActivityFlopLayer_330")
require("view.Layer.ActivityNew.activity333.ActivityFlopLayer_333")
require("view.Layer.ActivityNew.activity334.ActivityFlopLayer_334")
require("view.Layer.ActivityNew.activity405.ActivityFlopLayer_405")
require("view.Layer.ActivityNew.activity418.ActivityFlopLayer_418")
require("view.Layer.ActivityNew.activity433.ActivityFlopLayer_433")
require("view.Layer.ActivityNew.activity430.ActivityFlopLayer_430")
require("view.Layer.ActivityNew.activity436.ActivityFlopLayer_436")
require("view.Layer.ActivityNew.activity450.ActivityFlopLayer_450")
require("view.Layer.ActivityNew.BaseLayer.ActivityFlopDefaultLayer")

function ActivityFlopBaseNewLayer.create(arg_2_0)
	return (ActivityFlopBaseNewLayer.new())
end

function ActivityFlopBaseNewLayer:initDynaticPara()
	self.id = 10000
	self.bgPath = "activitiesRes/activity" .. self.id .. "/flop/flop_bg.png"
	self.rolebg = "activitiesRes/activity" .. self.id .. "/flop/"
	self.texturePath = "ActivityFlopDuanwu/"

	self:getParamFromUIConf()
end

function ActivityFlopBaseNewLayer:getUIConf()
	return activity_flop_ui_conf_data[self.id] or activity_flop_ui_conf_data[430]
end

function ActivityFlopBaseNewLayer:getParamFromUIConf()
	local var_5_0 = self:getUIConf()

	self.cardPanelOffsetX = var_5_0.card_panel_offset_x
	self.cardPanelOffsetY = var_5_0.card_panel_offset_y
	self.cardPanelWidth = var_5_0.card_panel_width
	self.cardGapYPlus = var_5_0.card_gap_y_plus
	self.championDetailOffsetY = var_5_0.champion_detail_offset
	self.championScale = var_5_0.champion_scale
	self.titleTimeLabelSize = var_5_0.title_time_label_size
	self.titleTimeLabelColor = cc.c3b(var_5_0.title_time_lable_color[1], var_5_0.title_time_lable_color[2], var_5_0.title_time_lable_color[3])
	self.turnsLabelSize = var_5_0.turns_label_size
	self.turnsLabelColor = cc.c3b(var_5_0.turns_label_color[1], var_5_0.turns_label_color[2], var_5_0.turns_label_color[3])
	self.turnsLabelColorOn = cc.c3b(var_5_0.turns_label_color_on[1], var_5_0.turns_label_color_on[2], var_5_0.turns_label_color_on[3])
	self.ticketNumSize = var_5_0.ticket_num_size
	self.ticketNumColorOn = cc.c3b(var_5_0.ticket_num_color_on[1], var_5_0.ticket_num_color_on[2], var_5_0.ticket_num_color_on[3])
	self.ticketNumColorOff = cc.c3b(var_5_0.ticket_num_color_off[1], var_5_0.ticket_num_color_off[2], var_5_0.ticket_num_color_off[3])
	self.tipsSize = var_5_0.tips_size
	self.tipsColor = var_5_0.tips_color
	self.UniqueItemBg = var_5_0.need_unique_item_bg
end

function ActivityFlopBaseNewLayer:init(arg_6_1)
	self:initDynaticPara(arg_6_1)
	self:initUI()
	self:initData()
	self:fullScreen()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			activity_manager:updateActivityAlert("flop", self.id, self:canFlop())

			if arg_6_1 and arg_6_1.callback then
				arg_6_1.callback()
			end
		end
	end)
end

function ActivityFlopBaseNewLayer:initData()
	self.isCardAction = false

	activity_manager:getActivityFlopConf(self.id, function(arg_9_0)
		self.skinList = activity_manager:getSkinList(self.id)

		self:initCard(arg_9_0)
		self:updateChangeSkinBtn()
		self:updateResetBtn()
		self:updateChampionData()
		self:updateChampionItem()
		self:updateFlopTurns()
		self:setSkinBtnEvent()
		self:updateSkin()
		self:drawCard((self:getStartPos()))
		self:updateOther()
		self:updateNewObjects()
	end)
end

function ActivityFlopBaseNewLayer:initUI()
	local var_10_0 = ccui.ImageView:create(self.bgPath)

	var_10_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_10_0:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y))
	self:addChild(var_10_0)

	self.imgBg = var_10_0

	local var_10_1 = ccui.Layout:create()

	var_10_1:setContentSize(GameDisplay.getScreenSize())
	var_10_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_10_1:setAnchorPoint(0, 0)
	var_10_1:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(var_10_1)

	self.rootLayer = var_10_1

	self:initTitle()
	self:initSurplusTime()
	self:initDrawBg()
	self:initAllBtn()
	self:initChangeSkinBtn()
	self:initOther()
	self:initTicket()
	self:initFlopTurns()
	self:initNewObjects()
end

function ActivityFlopBaseNewLayer:initTitle()
	local var_11_0 = ccui.ImageView:create(self.texturePath .. "banner.png", var_0_5)

	var_11_0:setAnchorPoint(cc.p(0, 0.5))
	var_11_0:setPosition(cc.p(20, self.rootLayer:getContentSize().height * 0.89))
	self.rootLayer:addChild(var_11_0, 1)
	var_11_0:setTouchEnabled(true)
	var_11_0:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "activity_flop_" .. self.id
		})
	end)

	self.Title = var_11_0
end

function ActivityFlopBaseNewLayer:initSurplusTime()
	local var_13_0 = self:getUIConf()
	local var_13_1 = var_13_0.title_time_label_offset_x or self.defaultconf.title_time_label_offset_x
	local var_13_2 = var_13_0.title_time_label_offset_y or self.defaultconf.title_time_label_offset_y
	local var_13_3 = cc.Label:createWithTTF("", FONT_DES, self.titleTimeLabelSize)

	var_13_3:setAnchorPoint(cc.p(0, 1))
	var_13_3:setName("time")
	var_13_3:setColor(self.titleTimeLabelColor)
	var_13_3:setPosition(cc.p(var_13_1, var_13_2))
	self.Title:addChild(var_13_3)
	self:createSurplusTime(var_13_3, activity_flop_condition_conf[self.id].finishtime)
end

local function var_0_12(arg_14_0)
	local var_14_5 = math.floor(arg_14_0 / 24 / 3600)

	arg_14_0 = arg_14_0 - var_14_5 * 24 * 3600

	local var_14_6 = math.floor(arg_14_0 / 3600)

	arg_14_0 = arg_14_0 - var_14_6 * 3600

	local var_14_7 = math.floor(arg_14_0 / 60)

	return 0 ~= 0 and string.format(L_TIME_REST2 .. L_TIME_TEXT[1], var_14_5, var_14_6) or var_14_6 ~= 0 and string.format(L_TIME_REST2 .. L_TIME_TEXT[2], var_14_6, var_14_7) or string.format(L_TIME_REST2 .. L_TIME_TEXT[3], var_14_7)
end

function ActivityFlopBaseNewLayer.createSurplusTime(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = global_get_time_by_date(arg_15_2) - time_check_manager:getCurTime()

	if not var_15_0 then
		return
	end

	arg_15_0.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_15_0, function(arg_16_0)
		if arg_15_1 then
			arg_15_1:setString((var_0_12(arg_16_0)))

			if arg_16_0 <= 0 and arg_15_1 then
				time_check_manager:removeUpdatePool(arg_15_0.activityScheduler)
				arg_15_1:setVisible(false)
			end
		end
	end)))
end

function ActivityFlopBaseNewLayer:initDrawBg()
	local var_17_0 = ccui.ImageView:create(self.texturePath .. "champion_bg.png", var_0_5)

	var_17_0:setAnchorPoint(cc.p(0.5, 0))
	var_17_0:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, 740))
	self.rootLayer:addChild(var_17_0, 1)

	local var_17_1 = ccui.ImageView:create(self.texturePath .. "draw_bg.png", var_0_5)

	var_17_1:setAnchorPoint(cc.p(0.5, 1))
	var_17_1:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, var_17_0:getPositionY() - 28))
	self.rootLayer:addChild(var_17_1, 1)

	self.championBg = var_17_0

	local var_17_2 = self:getUIConf()

	self.championBg:setPosition(cc.p(self.championBg:getPositionX() + (var_17_2.champion_bg_offset_x or 0), self.championBg:getPositionY() + GameDisplay.fix_y * 0.6 + (var_17_2.champion_bg_offset_y or 0)))

	self.drawBg = var_17_1
end

function ActivityFlopBaseNewLayer:initAllBtn()
	local var_18_0 = ccui.Button:create(self.texturePath .. "btn_award_list.png", nil, self.texturePath .. "btn_award_list.png", var_0_5)

	var_18_0:setAnchorPoint(cc.p(1, 0))
	var_18_0:setName("awardListbtn")
	var_18_0:setPosition(cc.p(630, self.rootLayer:getContentSize().height * 0.9))
	self.rootLayer:addChild(var_18_0, 5)

	local var_18_1 = ccui.Button:create(self.texturePath .. "btn_get_more.png", nil, self.texturePath .. "btn_get_more.png", var_0_5)

	var_18_1:setAnchorPoint(cc.p(1, 0))
	var_18_1:setPosition(cc.p(var_18_0:getPositionX(), var_18_0:getPositionY() - var_18_1:getContentSize().height - 10))
	self.rootLayer:addChild(var_18_1, 5)

	self.shopbtn = var_18_1

	var_18_0:addTouchEventListener(function(arg_19_0, arg_19_1)
		local var_19_0

		if arg_19_1 ~= ccui.TouchEventType.ended then
			do return end

			var_19_0 = {
				callback = callback,
				category = {
					activityFlop = 1,
					type = 5,
					activityFlopLevel = activity_manager:getCurFlopLevel(self.id)
				}
			}
		end

		var_19_0.items_tbl = activity_manager:getDropConf(self.id)
		var_19_0.words_tbl = {
			type_tbl = {}
		}

		LayerManager:pushInLayer("DropDetailsLayer", var_19_0)
	end)
	var_18_1:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:getCardAction() then
			return
		end

		activity_manager:getFlopLimitBag(self.id, 1, function(arg_21_0)
			self:goBuyLimitLayer(arg_21_0)
		end)
	end)
	self:initBottomList()
end

function ActivityFlopBaseNewLayer:initChangeSkinBtn()
	local var_22_0 = ccui.Button:create(self.texturePath .. "btn_next_skin.png", nil, self.texturePath .. "btn_next_skin.png", var_0_5)

	var_22_0:setAnchorPoint(cc.p(1, 0.5))
	var_22_0:setPositionX(GameDisplay.width)
	self.rootLayer:addChild(var_22_0, 5)

	self.changeSkinBtn = var_22_0
end

function ActivityFlopBaseNewLayer:updateChangeSkinBtn()
	if #self.skinList > 1 then
		self.changeSkinBtn:setVisible(true)
		self:setSkinBtnEvent()
	else
		self.changeSkinBtn:setVisible(false)
	end
end

function ActivityFlopBaseNewLayer:setSkinBtnEvent()
	local var_24_0 = #self.skinList

	self.changeSkinBtn:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.skinShowId = self.skinShowId == var_24_0 and 1 or self.skinShowId + 1

		self.bigRole:loadTexture(self.rolebg .. "role_bg_" .. self.skinShowId .. ".png")

		self.skinItemid = self.skinList[self.skinShowId].itemid

		self.skinDetail:loadTexture(self.texturePath .. "champion_detail_" .. self.skinShowId .. ".png", var_0_5)
	end)
end

function ActivityFlopBaseNewLayer:initBottomList()
	local var_26_0 = self:getUIConf()

	self.bottomList = BottomBtnList:create(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, {
		{
			name = "nextTurn",
			word = "",
			handler = function(arg_28_0, arg_28_1)
				if arg_28_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:goNextTurn()
			end,
			texture = self.texturePath .. "btn_reset.png"
		},
		{
			name = "previousTurn",
			word = "",
			handler = function(arg_29_0, arg_29_1)
				if arg_29_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:goPreviousTurn()
			end,
			texture = self.texturePath .. "btn_previous.png"
		}
	}, self.texturePath .. var_26_0.return_bottom_texture)

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 2)

	local var_26_1 = self.bottomList:getChildByName("nextTurn")

	var_26_1:setVisible(false)

	local var_26_2 = self.bottomList:getChildByName("previousTurn")

	var_26_2:setVisible(false)

	local var_26_3, var_26_4 = var_26_2:getPosition()

	var_26_2:setPosition(cc.p(var_26_3 - (var_26_0.btn_previous_turn_offset_x or 0), var_26_4 - (var_26_0.btn_previous_turn_offset_y or 0)))

	local var_26_5, var_26_6 = var_26_1:getPosition()

	var_26_1:setPosition(cc.p(var_26_5 - (var_26_0.btn_next_turn_offset_x or 0), var_26_6 - (var_26_0.btn_next_turn_offset_y or 0)))

	if var_26_0.return_btn_texture then
		local var_26_7 = self.bottomList:getChildByName("returnBtn")

		var_26_7:loadTextures(self.texturePath .. var_26_0.return_btn_texture, self.texturePath .. var_26_0.return_btn_texture, self.texturePath .. var_26_0.return_btn_texture, var_0_5)
		var_26_7:setPositionX(var_26_7:getPositionX() + var_26_0.return_btn_offsetX or 0)
	end
end

function ActivityFlopBaseNewLayer:initTicket()
	local var_30_0, var_30_1, var_30_2 = activity_manager:getFlopTicket(self.id)
	local var_30_3 = self:getUIConf()
	local var_30_4 = var_30_3.ticket_offset_x or self.defaultconf.ticket_offset_x
	local var_30_5 = var_30_3.ticket_offset_y or self.defaultconf.ticket_offset_y
	local var_30_6 = cc.Label:createWithTTF(L_OWN_TICKET, FONT_DES, self.ticketNumSize)

	var_30_6:setAnchorPoint(cc.p(1, 0.5))
	var_30_6:setName("ticketTitle")
	var_30_6:setColor(self.ticketNumColorOn)
	var_30_6:setPosition(cc.p(self.drawBg:getContentSize().width / 2 - 35 + var_30_4, self.drawBg:getContentSize().height + var_30_5))
	self.drawBg:addChild(var_30_6)

	local var_30_7 = cc.Label:createWithTTF(string.format("%d/%d", var_30_1, var_30_0), FONT_DES, self.ticketNumSize)

	var_30_7:setAnchorPoint(cc.p(0, 0.5))
	var_30_7:setName("ticketNum")
	var_30_7:setColor((var_30_0 <= var_30_1 or nil) and (self.ticketNumColorOn or self.ticketNumColorOff))
	var_30_7:setPosition(cc.p(self.drawBg:getContentSize().width / 2 + 35 + var_30_4, var_30_6:getPositionY()))
	self.drawBg:addChild(var_30_7)

	local var_30_8 = ccui.ImageView:create("equipment/" .. item_data[var_30_2].image_id .. ".png")

	var_30_8:setAnchorPoint(cc.p(0.5, 0.5))
	var_30_8:setScale(0.25)
	var_30_8:setPosition(cc.p(self.drawBg:getContentSize().width / 2 + var_30_4, var_30_6:getPositionY()))
	self.drawBg:addChild(var_30_8)

	local var_30_9 = ccui.Layout:create()

	var_30_9:setContentSize(cc.size(220, 40))
	var_30_9:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_30_9:setAnchorPoint(0.5, 0.5)
	var_30_9:setTouchEnabled(true)
	var_30_9:setPosition(cc.p(self.drawBg:getContentSize().width / 2, self.drawBg:getContentSize().height - 23))
	self.drawBg:addChild(var_30_9, 5)
	var_30_8:setTouchEnabled(true)
	var_30_8:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:getCardAction() then
			return
		end

		activity_manager:getFlopLimitBag(self.id, 1, function(arg_32_0)
			self:goBuyLimitLayer(arg_32_0)
		end)
	end)
	var_30_9:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:getCardAction() then
			return
		end

		activity_manager:getFlopLimitBag(self.id, 1, function(arg_34_0)
			self:goBuyLimitLayer(arg_34_0)
		end)
	end)

	self.ticketNum = var_30_7
end

function ActivityFlopBaseNewLayer:initFlopTurns()
	local var_35_0 = cc.Label:createWithTTF(L_FLOP_TURNS_NOW, FONT_DES, self.turnsLabelSize)

	var_35_0:setAnchorPoint(cc.p(0.5, 1))
	var_35_0:setColor(self.turnsLabelColor)
	var_35_0:setName("flopBgWord")
	var_35_0:setPosition(cc.p(self.drawBg:getContentSize().width / 2, self.drawBg:getContentSize().height + (self:getUIConf().turns_label_offsetY or -50)))
	self.drawBg:addChild(var_35_0)

	local var_35_1 = ccui.Layout:create()

	var_35_1:setContentSize(cc.size(60, var_35_0:getContentSize().height))
	var_35_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_35_1:setAnchorPoint(0.5, 1)
	var_35_1:setPosition(cc.p(var_35_0:getPositionX() + 15, var_35_0:getPositionY()))
	var_35_1:setName("numLayer")
	self.drawBg:addChild(var_35_1)

	local var_35_2 = cc.Label:createWithTTF("/" .. activity_flop_condition_conf[self.id].flop_limit_turns, FONT_DES, self.turnsLabelSize)

	var_35_2:setAnchorPoint(cc.p(1, 0.5))
	var_35_2:setName("flopTotalTurns")
	var_35_2:setColor(self.turnsLabelColor)
	var_35_2:setPosition(cc.p(var_35_1:getContentSize().width / 2, var_35_1:getContentSize().height / 2))
	var_35_1:addChild(var_35_2)

	local var_35_3 = cc.Label:createWithTTF("", FONT_DES, self.turnsLabelSize)

	var_35_3:setAnchorPoint(cc.p(0, 0.5))
	var_35_3:setName("flopTurns")
	var_35_3:setColor(self.turnsLabelColorOn)
	var_35_3:setPosition(cc.p(var_35_1:getContentSize().width / 2, var_35_1:getContentSize().height / 2))
	var_35_1:addChild(var_35_3)

	self.flopTurns = var_35_3

	var_35_1:setContentSize(cc.size(var_35_2:getContentSize().width + var_35_3:getContentSize().width, var_35_0:getContentSize().height))
	var_35_1:setPositionX(var_35_0:getPositionX() + 30)
	var_35_2:setPositionX(var_35_1:getContentSize().width)
	var_35_3:setPositionX(0)
end

function ActivityFlopLayer_142:initOther()
	local var_36_0 = ccui.ImageView:create(self.rolebg .. "role_bg_0.png")

	var_36_0:setAnchorPoint(cc.p(0.5, 1))
	var_36_0:setPosition(cc.p(320, self.rootLayer:getContentSize().height * 0.6))
	self.rootLayer:addChild(var_36_0)

	self.bigRole = var_36_0

	self.bigRole:setTouchEnabled(true)
	self.bigRole:addTouchEventListener(function(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.skinItemid then
			return
		end

		self:showSoulGirlPop({
			itemid = self.skinItemid
		})
	end)
end

function ActivityFlopBaseNewLayer:initCard(arg_38_1)
	local var_38_0 = {}
	local var_38_1 = activity_manager:getFlopMatrixConf(self.id)
	local var_38_2 = activity_manager:getChampionCardPos(self.id)

	for iter_38_0 = 1, var_38_1 * var_38_1 do
		local var_38_3 = self:createCardObj()

		var_38_3:setBack()
		var_38_3:setOrder(iter_38_0)

		if arg_38_1["pos_" .. iter_38_0] then
			var_38_3:setItem(arg_38_1["pos_" .. iter_38_0].itemImg, arg_38_1["pos_" .. iter_38_0].itemNum, arg_38_1["pos_" .. iter_38_0].itemid)
			var_38_3:setFront()
			var_38_3:setRewarded(true)

			if iter_38_0 == var_38_2 then
				var_38_3:setChampionAni()
			end
		end

		table.insert(var_38_0, var_38_3)
	end

	self.cardTbl = var_38_0
	self.isChampion = false
end

function ActivityFlopBaseNewLayer:updateCard(arg_39_1)
	local var_39_1 = activity_manager:getFlopMatrixConf(self.id)
	local var_39_2 = activity_manager:getChampionCardPos(self.id)

	for iter_39_0, iter_39_1 in pairs(self.cardTbl) do
		iter_39_1.backImg:runAction(cc.Sequence:create(cc.OrbitCamera:create(0, 1, 0, 270, 90, 0, 0)))
		iter_39_1:setBack()
		iter_39_1:setOrder(iter_39_0)
		iter_39_1:setRewarded(false)
		iter_39_1:deleteChampionAni()

		if arg_39_1["pos_" .. iter_39_0] then
			iter_39_1:setItem(arg_39_1["pos_" .. iter_39_0].itemImg, arg_39_1["pos_" .. iter_39_0].itemNum, arg_39_1["pos_" .. iter_39_0].itemid)
			iter_39_1:setFront()
			iter_39_1:setRewarded(true)

			if iter_39_0 == var_39_2 then
				iter_39_1:setChampionAni()
			end
		end
	end
end

function ActivityFlopBaseNewLayer:createCardObj()
	local var_40_0 = {}
	local var_40_1 = ccui.ImageView:create(self.texturePath .. "card_back.png", var_0_5)

	var_40_1:setAnchorPoint(cc.p(0.5, 0.5))

	local var_40_2 = ItemSpriteFlop:createPurchaseItemByItemid()

	var_40_2:setAnchorPoint(cc.p(0.5, 0.5))

	local var_40_3 = ccui.Layout:create()

	var_40_3:setContentSize(cc.size(var_40_1:getContentSize().width, var_40_1:getContentSize().height))
	var_40_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_40_3:setAnchorPoint(0.5, 0.5)
	var_40_3:setTouchEnabled(true)

	var_40_0.backImg = var_40_1
	var_40_0.frontImg = var_40_2
	var_40_0.touchLayer = var_40_3

	function var_40_0:setItem(arg_41_1, arg_41_2, arg_41_3)
		self.frontImg:updateFlopItemByItemid(arg_41_3, arg_41_2)

		if self.UniqueItemBg then
			self.frontImg:loadTexture(self.UniqueItemBg .. self.quality .. ".png", var_0_5)
		end

		self:setItemid(arg_41_3)
	end

	function var_40_0:setOrder(arg_42_1)
		self.order = arg_42_1
		self.touchLayer.order = arg_42_1
	end

	function var_40_0:getOrder()
		return self.order
	end

	function var_40_0:setBack()
		self.backImg:setVisible(true)
		self.frontImg:setVisible(false)
	end

	function var_40_0:setFront()
		self.backImg:setVisible(false)
		self.frontImg:setVisible(true)
	end

	function var_40_0:setTouchable()
		self.touchLayer:setTouchEnabled(true)
	end

	function var_40_0:forbidTouch()
		self.touchLayer:setTouchEnabled(false)
	end

	function var_40_0.setItemid(arg_48_0, arg_48_1)
		arg_48_0.itemid = arg_48_1
	end

	function var_40_0:getItemid()
		return self.itemid
	end

	function var_40_0.setRewarded(arg_50_0, arg_50_1)
		arg_50_0.rewarded = arg_50_1
	end

	function var_40_0:getRewarded()
		return self.rewarded
	end

	function var_40_0:setPos(arg_52_1)
		self.pos = {}
		self.pos.x = arg_52_1.x
		self.pos.y = arg_52_1.y
	end

	function var_40_0:getPos()
		return self.pos
	end

	function var_40_0:delete()
		self.backImg:removeFromParent()
		self.frontImg:removeFromParent()
		self.touchLayer:removeFromParent()
	end

	function var_40_0:setChampionAni()
		ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("flop.ExportJson")

		local var_55_0 = ccs.Armature:create("flop")

		var_55_0:setPosition(self.frontImg:getContentSize().width / 2, self.frontImg:getContentSize().height / 2)
		var_55_0:getAnimation():play("Animation1")
		var_55_0:setName("flopAni")
		self.frontImg:addChild(var_55_0)
	end

	function var_40_0:deleteChampionAni()
		if self.frontImg:getChildByName("flopAni") then
			self.frontImg:removeChildByName("flopAni", true)
		end
	end

	function var_40_0:getCardAward()
		local var_57_0, var_57_1 = activity_manager:getFlopTicket(self.id)

		if var_57_1 < var_57_0 then
			activity_manager:getFlopLimitBag(self.id, 1, function(arg_59_0)
				self:goBuyLimitLayer(arg_59_0)
			end)

			return
		end

		self:forbidAllCard()
		activity_manager:setActivityFlopResult(self.id, self.order, function(arg_58_0)
			if arg_58_0 then
				self:setItem(arg_58_0.drawConf.itemImg, arg_58_0.drawConf.itemNum, arg_58_0.drawConf.itemid)
				self:setRewarded(true)

				self.isChampion = arg_58_0.isChampion

				if arg_58_0.isChampion then
					self.championCard = self

					print("抽到大奖啦！！！！！！！！！！！！！！！")
					self:turn(arg_58_0.itemGain, true)
				else
					global_get(arg_58_0.itemGain)
					self:turn(arg_58_0.itemGain)
					self:awardReturn()
				end
			else
				self:releaseAllCard()
			end
		end)
	end

	function var_40_0:turn(arg_60_1, arg_60_2)
		self.backImg:runAction(cc.Sequence:create(cc.OrbitCamera:create(0.1, 1, 0, 0, 90, 0, 0), cc.Hide:create(), cc.CallFunc:create(function()
			self.frontImg:runAction(cc.Sequence:create(cc.Show:create(), cc.OrbitCamera:create(0.1, 1, 0, 270, 90, 0, 0), cc.CallFunc:create(function()
				if arg_60_2 then
					global_gain(arg_60_1)
				end
			end)))
		end)))
	end

	function var_40_0:turnback()
		self.frontImg:runAction(cc.Sequence:create(cc.OrbitCamera:create(0.05, 1, 0, 0, 90, 0, 0), cc.Hide:create(), cc.CallFunc:create(function()
			self.backImg:runAction(cc.Sequence:create(cc.Show:create(), cc.OrbitCamera:create(0.05, 1, 0, 270, 90, 0, 0)))
		end)))
	end

	function var_40_0:showItemDetail()
		local var_65_0 = {
			itemid = self:getItemid()
		}

		var_65_0.hideGainButton = true

		if var_65_0.itemid and type(var_65_0.itemid) == "number" then
			LayerManager:pushInLayer("PopItemLayer", var_65_0)
		end
	end

	function var_40_0:clickEvent()
		if self:getCardAction() then
			return
		end

		if self:getRewarded() then
			self:showItemDetail()
		else
			self:getCardAward()
		end
	end

	var_40_0.touchLayer:addTouchEventListener(function(arg_67_0, arg_67_1)
		if arg_67_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.cardTbl[arg_67_0.order]:clickEvent()
	end)

	return var_40_0
end

function ActivityFlopBaseNewLayer.updateReset(arg_68_0)
	return
end

function ActivityFlopBaseNewLayer:updateFlopTurns()
	local var_69_0 = activity_manager:getFlopTurns(self.id)
	local var_69_1 = self.drawBg:getChildByName("flopBgWord")
	local var_69_2 = self.drawBg:getChildByName("numLayer")
	local var_69_3 = var_69_2:getChildByName("flopTotalTurns")
	local var_69_4 = var_69_2:getChildByName("flopTurns")

	self.flopTurns:setString(var_69_0)
	var_69_1:setString(string.format(L_FLOP_TURNS_NOW, var_69_0, (activity_manager:getFlopLimitTurns(self.id))))
	var_69_2:setContentSize(cc.size(var_69_3:getContentSize().width + var_69_4:getContentSize().width, var_69_1:getContentSize().height))
	var_69_2:setPositionX(var_69_1:getPositionX() + 20)
	var_69_3:setPositionX(var_69_2:getContentSize().width)
	var_69_4:setPositionX(0)
end

function ActivityFlopBaseNewLayer:updateResetBtn()
	local var_70_0 = activity_manager:getResetEnable(self.id)

	self.bottomList:getChildByName("nextTurn"):setVisible(var_70_0)
	self.bottomList:getChildByName("nextTurn"):setBright(var_70_0)
	self.bottomList:getChildByName("previousTurn"):setBright(true)

	if activity_manager:getFlopTurns(self.id) == 1 then
		self.bottomList:getChildByName("previousTurn"):setVisible(false)
	else
		self.bottomList:getChildByName("previousTurn"):setVisible(true)
	end
end

function ActivityFlopBaseNewLayer:updateChampionData()
	self.championItemOrder = activity_manager:getFlopChampionItem(self.id)
	self.championItem = activity_manager:getFlopItemByOrder(self.id, self.championItemOrder)
end

function ActivityFlopBaseNewLayer:updateTicket()
	local var_72_0, var_72_1 = activity_manager:getFlopTicket(self.id)

	self.ticketNum:setString(string.format("%d/%d", var_72_1, var_72_0))
	self.ticketNum:setColor((var_72_0 <= var_72_1 or nil) and (self.ticketNumColorOn or self.ticketNumColorOff))
end

function ActivityFlopBaseNewLayer:updateSkin(arg_73_1, arg_73_2)
	self.skinShowId = arg_73_1 or activity_manager:getSkinid(self.id)

	local var_73_0 = self.skinShowId
	local var_73_1 = self.skinList[self.skinShowId].itemid

	if not self.skinDetail then
		local var_73_2 = ccui.ImageView:create(self.texturePath .. "champion_detail_" .. self.skinShowId .. ".png", var_0_5)

		var_73_2:setAnchorPoint(cc.p(1, 0))
		var_73_2:setPosition(cc.p(self.drawBg:getContentSize().width - 10, self.drawBg:getContentSize().height + (self.championDetailOffsetY or 10)))
		self.drawBg:addChild(var_73_2, 1)

		self.skinDetail = var_73_2

		self.bigRole:loadTexture(self.rolebg .. "role_bg_" .. self.skinShowId .. ".png")
	elseif self.skinItemid and self.skinItemid ~= var_73_1 then
		if not arg_73_2 then
			self.skinDetail:setScale(1)
			self.skinDetail:runAction(cc.Sequence:create(cc.ScaleTo:create(0.03, 1.5), cc.Spawn:create(cc.ScaleTo:create(0.03, 1), cc.EaseBackIn:create((cc.MoveBy:create(0.1, cc.p(self.skinDetail:getContentSize().width + 30, 0))))), cc.DelayTime:create(1.2), cc.CallFunc:create(function()
				self.skinDetail:loadTexture(self.texturePath .. "champion_detail_" .. var_73_0 .. ".png", var_0_5)
				self.bigRole:loadTexture(self.rolebg .. "role_bg_" .. var_73_0 .. ".png")
				self.bigRole:setTouchEnabled(true)
			end), cc.EaseBackOut:create((cc.MoveBy:create(0.1, cc.p(-self.skinDetail:getContentSize().width - 30, 0))))))
		else
			self.skinDetail:loadTexture(self.texturePath .. "champion_detail_" .. self.skinShowId .. ".png", var_0_5)
			self.bigRole:loadTexture(self.rolebg .. "role_bg_" .. self.skinShowId .. ".png")
			self.bigRole:setTouchEnabled(true)
		end
	else
		self.bigRole:setTouchEnabled(true)
	end

	self.skinItemid = var_73_1
end

local function var_0_13(arg_75_0)
	local var_75_0 = -1
	local var_75_1 = require("data.horcrux_data")[arg_75_0].horcruxt

	for iter_75_0, iter_75_1 in pairs((require("data.photofile_HelpGirl_data"))) do
		if arg_75_0 == iter_75_1.item_id then
			var_75_0 = iter_75_0

			break
		end
	end

	if var_75_0 == -1 then
		print("did not find id")

		return
	end

	LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
		id = var_75_0,
		itemid = arg_75_0
	})
end

function ActivityFlopBaseNewLayer:updateChampionItem(arg_76_1)
	local var_76_1 = self:getUIConf()
	local var_76_2 = var_76_1.champion_offset_y or 50
	local var_76_3 = var_76_1.champion_offset_x or 0

	if not var_76_1.champion_size then
		-- block empty
	end

	local var_76_5 = "public/box/UI_touming.png"

	if not self.itemShade then
		local var_76_6 = ItemSpriteFlop:createPurchaseItemByItemid()

		var_76_6:setName("championItem")
		var_76_6:setScale(var_76_6:getScale() * 1.2)
		var_76_6:setAnchorPoint(cc.p(0.5, 0))
		var_76_6:setPosition(cc.p(self.championBg:getContentSize().width / 2 - 80 + var_76_3, var_76_2))
		self.championBg:addChild(var_76_6)
		var_76_6:updateFlopItemByItemid(self.championItem.itemid, nil, nil, var_76_5, self.championItem.item_attr)

		if item_data[self.championItem.itemid].bag_item_type == kITEM_SKIN then
			var_76_6:getChildByName("bg"):getChildByName("icon"):loadTexture("roleimage/role1/" .. model_data[item_data[self.championItem.itemid].model].cute_role .. ".png")
			var_76_6:getChildByName("bg"):getChildByName("icon"):setScale(0.3)
		end

		var_76_6:setTouchEnabled(true)
		var_76_6:addTouchEventListener(function(arg_77_0, arg_77_1)
			if arg_77_1 ~= ccui.TouchEventType.ended then
				return
			end

			if item_data[self.championItem.itemid].bag_item_type == kITEM_HORCRUX then
				var_0_13(self.championItem.itemid)

				return
			end

			local var_77_0 = {
				itemid = self.championItem.itemid
			}

			var_77_0.hideGainButton = true

			if var_77_0.itemid and type(var_77_0.itemid) == "number" then
				LayerManager:pushInLayer("PopItemLayer", var_77_0)
			end
		end)
		self.championBg:setTouchEnabled(true)
		self.championBg:addTouchEventListener(function(arg_78_0, arg_78_1)
			if arg_78_1 ~= ccui.TouchEventType.ended then
				return
			end

			if item_data[self.championItem.itemid].bag_item_type == kITEM_HORCRUX then
				var_0_13(self.championItem.itemid)

				return
			end

			local var_78_0 = {
				itemid = self.championItem.itemid
			}

			var_78_0.hideGainButton = true

			if var_78_0.itemid and type(var_78_0.itemid) == "number" then
				LayerManager:pushInLayer("PopItemLayer", var_78_0)
			end
		end)

		local var_76_7 = cc.Label:createWithTTF("x" .. self.championItem.itemNum, FONT_NAME, var_76_1.champion_num_size)

		var_76_7:setAnchorPoint(cc.p(0.5, 0))
		var_76_7:setName("championNumLabel")
		var_76_7:setPositionX(var_76_6:getPositionX() + 65)
		var_76_7:setPositionY(var_76_1.champion_num_offset_y)
		var_76_7:setColor(cc.c3b(255, 255, 255))
		self.championBg:addChild(var_76_7, 99)

		local var_76_8 = ccui.ImageView:create(self.texturePath .. "champion_shade.png", var_0_5)

		var_76_8:setAnchorPoint(cc.p(0.5, 0))
		var_76_8:setPosition(cc.p(self.championBg:getContentSize().width / 2 + var_76_3, var_76_6:getPositionY() - 45 - var_76_2))
		self.championBg:addChild(var_76_8)

		self.itemShade = var_76_8
	else
		local var_76_9 = self.championBg:getChildByName("championItem")

		var_76_9:updateFlopItemByItemid(self.championItem.itemid, nil, nil, var_76_5, self.championItem.item_attr)

		if item_data[self.championItem.itemid].bag_item_type == kITEM_SKIN then
			var_76_9:getChildByName("bg"):getChildByName("icon"):loadTexture("roleimage/role1/" .. model_data[item_data[self.championItem.itemid].model].cute_role .. ".png")
			var_76_9:getChildByName("bg"):getChildByName("icon"):setScale(0.4)
		elseif item_data[self.championItem.itemid].bag_item_type == kITEM_COMPONENT then
			var_76_9:getChildByName("bg"):getChildByName("icon"):setPosition(cc.p(50, 60))
		end

		self.championBg:getChildByName("championNumLabel"):setString("x" .. self.championItem.itemNum)
		self.championBg:getChildByName("championItem"):setTouchEnabled(true)
	end

	if not arg_76_1 then
		self.championBg:getChildByName("championItem"):setOpacity(0)
		self.championBg:getChildByName("championItem"):runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.4), cc.EaseIn:create(cc.MoveTo:create(0.4, cc.p(self.championBg:getContentSize().width / 2 - 80 + var_76_3, var_76_2)), 0.2))))
		self.championBg:getChildByName("championNumLabel"):setOpacity(0)
		self.championBg:getChildByName("championNumLabel"):runAction(cc.Sequence:create(cc.FadeIn:create(0.4)))
	end
end

function ActivityFlopBaseNewLayer:getStartPos()
	return {
		x = self.cardPanelOffsetX,
		y = self.drawBg:getContentSize().height - self.cardPanelOffsetY
	}
end

function ActivityFlopBaseNewLayer:drawCard(arg_80_1)
	local var_80_0 = activity_manager:getFlopMatrixConf(self.id)
	local var_80_1 = math.floor((self.cardPanelWidth - self.cardTbl[1].backImg:getContentSize().width * var_80_0) / (var_80_0 - 1))
	local var_80_2 = self.cardGapYPlus
	local var_80_3

	if not self.cardGapYPlus then
		var_80_2 = math.floor(GameDisplay.fix_y / (var_80_0 - 1))
		var_80_3 = self.cardTbl[1].backImg:getContentSize().width + var_80_1
	end

	local var_80_4 = self.cardTbl[1].backImg:getContentSize().height + (var_80_1 + var_80_2)
	local var_80_5 = arg_80_1.x + self.cardTbl[1].backImg:getContentSize().width / 2
	local var_80_6 = arg_80_1.y - self.cardTbl[1].backImg:getContentSize().height / 2

	for iter_80_0, iter_80_1 in ipairs(self.cardTbl) do
		iter_80_1:setPos({
			x = var_80_5 + (iter_80_0 - 1) % var_80_0 * var_80_3,
			y = var_80_6 - 0 * var_80_4
		})
		iter_80_1.backImg:setPosition(cc.p(var_80_5 + (iter_80_0 - 1) % var_80_0 * var_80_3, var_80_6 - 0 * var_80_4))
		iter_80_1.frontImg:setPosition(cc.p(var_80_5 + (iter_80_0 - 1) % var_80_0 * var_80_3, var_80_6 - 0 * var_80_4))
		iter_80_1.touchLayer:setPosition(cc.p(var_80_5 + (iter_80_0 - 1) % var_80_0 * var_80_3, var_80_6 - 0 * var_80_4))
		self.drawBg:addChild(iter_80_1.backImg, 1 + iter_80_0)
		self.drawBg:addChild(iter_80_1.frontImg, 1 + iter_80_0)
		self.drawBg:addChild(iter_80_1.touchLayer, 99)

		if iter_80_0 % var_80_0 == 0 then
			-- block empty
		end
	end
end

function ActivityFlopBaseNewLayer.updateOther(arg_81_0)
	return
end

function ActivityFlopBaseNewLayer:updateUI(arg_82_1)
	self:forbidAllCard()
	self:updateCard(arg_82_1)
	self:updateReset()
	self:updateResetBtn()
	self:updateChampionData()
	self:updateChampionItem(true)
	self:updateFlopTurns()
	self:updateSkin(nil, true)
	self:updateNewObjects()
	self:releaseAllCard()
end

function ActivityFlopBaseNewLayer.forbidAllCard(arg_83_0)
	arg_83_0.isCardAction = true
end

function ActivityFlopBaseNewLayer.releaseAllCard(arg_84_0)
	arg_84_0.isCardAction = false
end

function ActivityFlopBaseNewLayer:getCardAction()
	return self.isCardAction
end

function ActivityFlopBaseNewLayer:fullScreen()
	self.drawBg:setPositionY(self.championBg:getPositionY() - 280)
	self.bigRole:setPositionY(self.Title:getPositionY() - self.bigRole:getContentSize().height / 2 + 180)

	local var_86_0 = self.drawBg:convertToNodeSpace((self:convertToWorldSpace(cc.p(self.imgBg:getPositionX(), self.imgBg:getPositionY() - self.imgBg:getContentSize().height / 2 + 62))))
	local var_86_1 = self.drawBg:convertToNodeSpace(cc.p(0, -GameDisplay.fix_y))

	self.shopbtn:setPosition(cc.p(640, (var_86_1.y > var_86_0.y or nil) and (var_86_1.y or var_86_0.y)))
end

function ActivityFlopBaseNewLayer:goPreviousTurn()
	activity_manager:goPreviousTurn(self.id, function(arg_88_0)
		self:updateUI(arg_88_0)
	end)
end

function ActivityFlopBaseNewLayer:goNextTurn()
	activity_manager:goNextTurn(self.id, function(arg_90_0, arg_90_1)
		if arg_90_1 then
			self:resetFlop(arg_90_0)
		else
			self:updateUI(arg_90_0)
		end
	end)
end

function ActivityFlopBaseNewLayer:resetFlop(arg_91_1)
	self.bottomList:getChildByName("previousTurn"):setVisible(false)
	self.bottomList:getChildByName("nextTurn"):setVisible(false)
	self:showDeleteAni(arg_91_1)
end

function ActivityFlopBaseNewLayer:deleteCard()
	for iter_92_0, iter_92_1 in pairs(self.cardTbl) do
		iter_92_1:delete()
	end

	self.cardTbl = {}
end

function ActivityFlopBaseNewLayer:showDeleteAni(arg_93_1)
	self:forbidAllCard()
	self.bigRole:setTouchEnabled(false)

	local var_93_0 = activity_manager:getFlopMatrixConf(self.id)
	local var_93_1 = self:getStartPos()
	local var_93_2 = (self.cardTbl[1].backImg:getPositionX() + self.cardTbl[var_93_0].backImg:getPositionX()) / 2
	local var_93_3 = (self.cardTbl[1].backImg:getPositionY() + self.cardTbl[var_93_0 * (var_93_0 - 1) + 1].backImg:getPositionY()) / 2

	local function var_93_4()
		for iter_94_0, iter_94_1 in pairs(self.cardTbl) do
			if iter_94_1:getItemid() then
				iter_94_1:turnback()
			end
		end
	end

	self.rootLayer:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		var_93_4()
	end), cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		for iter_97_0, iter_97_1 in pairs(self.cardTbl) do
			local var_97_0 = iter_97_1:getPos()

			iter_97_1.backImg:runAction((cc.EaseBackIn:create((cc.MoveBy:create(0.2, cc.p(var_93_2 - var_97_0.x, var_93_3 - var_97_0.y))))))
		end
	end), cc.DelayTime:create(0.25), cc.CallFunc:create(function()
		self:deleteCard()
		self:initCard(arg_93_1)
		self:updateReset()
		self:updateFlopTurns()
		self:updateChampionData()
		self:updateSkin()
		self:updateNewObjects()
		self:drawCard((self:getStartPos()))
		self:showChampionAni()
		self:showResetAni()
	end)))
end

function ActivityFlopBaseNewLayer:showChampionAni()
	local var_99_0 = self.championBg:getChildByName("championItem")
	local var_99_1 = self.championBg:getChildByName("championNumLabel")
	local var_99_2 = cc.MoveBy:create(0.4, cc.p(0, -50))

	var_99_0:setTouchEnabled(false)
	var_99_0:stopAllActions()
	var_99_0:setOpacity(255)
	var_99_0:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.4), cc.EaseBackIn:create((cc.MoveBy:create(0.4, cc.p(0, 50))))), cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self:updateChampionItem()
	end)))
	var_99_1:setOpacity(255)
	var_99_1:runAction(cc.Sequence:create(cc.FadeOut:create(0.4)))
end

function ActivityFlopBaseNewLayer:showResetAni()
	local var_101_0 = activity_manager:getFlopMatrixConf(self.id)
	local var_101_1 = self:getStartPos()
	local var_101_2 = (self.cardTbl[1].backImg:getPositionX() + self.cardTbl[var_101_0].backImg:getPositionX()) / 2
	local var_101_3 = (self.cardTbl[1].backImg:getPositionY() + self.cardTbl[var_101_0 * (var_101_0 - 1) + 1].backImg:getPositionY()) / 2

	for iter_101_0, iter_101_1 in pairs(self.cardTbl) do
		iter_101_1.backImg:setPosition(cc.p(var_101_2, var_101_3))
	end

	self.drawBg:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		for iter_102_0, iter_102_1 in pairs(self.cardTbl) do
			local var_102_0 = iter_102_1:getPos()

			iter_102_1.backImg:runAction(cc.Sequence:create(cc.DelayTime:create(0.02 * iter_102_0), cc.EaseBackOut:create((cc.MoveBy:create(0.4, cc.p(var_102_0.x - var_101_2, var_102_0.y - var_101_3))))))
		end
	end), cc.DelayTime:create(0.05 * var_101_0 * var_101_0 + 0.3), cc.CallFunc:create(function()
		self:releaseAllCard()
		self:updateResetBtn()
		print("endendendendend")
	end)))
end

function ActivityFlopBaseNewLayer:awardReturn()
	if self.isChampion then
		self.championCard:setChampionAni()
	end

	self:releaseAllCard()
	self:updateTicket()
	self:updateChampionData()
	self:updateResetBtn()
end

function ActivityFlopBaseNewLayer:canFlop()
	local var_105_0, var_105_1, var_105_2 = activity_manager:getFlopTicket(self.id)
	local var_105_3 = activity_manager:getFlopMatrixConf(self.id)

	if var_105_1 < var_105_0 then
		return false
	end

	if activity_manager:getFlopTurns(self.id) >= activity_flop_condition_conf[self.id].flop_limit_turns and activity_manager:getFlopCount(self.id) == activity_flop_condition_conf[self.id].matrix_line * activity_flop_condition_conf[self.id].matrix_line then
		return false
	end

	return true
end

function ActivityFlopBaseNewLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_107_0)
		if self.isChampion then
			self.championCard:setChampionAni()
		end

		self:releaseAllCard()
		self:updateTicket()
		self:updateChampionData()
		self:updateResetBtn()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_108_0)
		if self.isChampion then
			self.championCard:setChampionAni()
		end

		self:releaseAllCard()
		self:updateTicket()
		self:updateChampionData()
		self:updateResetBtn()
	end), self)
end

function ActivityFlopBaseNewLayer.getFlopShop(arg_109_0)
	return {
		"1-18888"
	}
end

function ActivityFlopBaseNewLayer:popGetKeyItem()
	local var_110_0, var_110_1, var_110_2, var_110_3, var_110_4 = activity_manager:getFlopTicket(self.id)
	local var_110_5 = activity_manager:getFlopMatrixConf(self.id)
	local var_110_6 = cc.UserDefault:getInstance()

	setmetatable(var_110_6, {
		__index = function(arg_111_0, arg_111_1)
			return function()
				return arg_111_1
			end
		end
	})

	local var_110_8 = {
		have_bought = 0,
		itemtype = var_110_2,
		currency = ({
			diamond = SHOP_CURRENCY_DIAMOND,
			paid_diamond = SHOP_CURRENCY_DIAMOND
		})[var_110_4],
		paid = (var_110_4 == "paid_diamond" or nil) and true,
		price = var_110_3,
		buy_limit = var_110_5 * var_110_5 - activity_manager:getFlopCount(self.id) - item_manager:getItemNumber(var_110_2)
	}

	if var_110_6:getIntegerForKey("flopShop", 0) == 0 then
		var_110_8.to_shop = self:getFlopShop()
	end

	self:shopPop(var_110_8)
end

function ActivityFlopBaseNewLayer.goBuyLimitLayer(arg_113_0, arg_113_1)
	arg_113_1.uiconf = {
		id = 1
	}

	LayerManager:pushInLayer("PopBuyPackageDirectLayer", arg_113_1)
end

function ActivityFlopBaseNewLayer.showBuyPop(arg_114_0, arg_114_1, arg_114_2, arg_114_3)
	if not arg_114_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_114_1)
	elseif arg_114_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_114_1)
	elseif arg_114_3 == "giftitem" then
		LayerManager:pushInLayer("PopSkinPackage", arg_114_1)
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_114_1)
	end
end

function ActivityFlopBaseNewLayer.shopPop(arg_115_0, arg_115_1)
	local var_115_0 = 1
	local var_115_1 = 2
	local var_115_2 = 3
	local var_115_4 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			if arg_115_1.paid then
				return item_manager:getItemNumber(CURRENCY_DIAMOND_PAID)
			else
				return item_manager:getItemNumber(CURRENCY_DIAMOND)
			end
		end,
		function()
			return playermodel.honor
		end,
		function()
			return playermodel.explorecoin
		end,
		[100] = function()
			return 0
		end
	}

	setmetatable(var_115_4, {
		__index = function(arg_121_0, arg_121_1)
			return function()
				return item_manager:getItemNumber(arg_121_1)
			end
		end
	})

	local var_115_5 = {
		[1500001] = "public/currency/1500001_1.png",
		[var_115_0] = "public/currency/UI_battleEnd_gold.png",
		[0] = arg_115_1.paid and "public/currency/888888.png" or "public/currency/UI_battleEnd_diamond.png",
		[var_115_1] = "public/currency/arenascene_dot_1.png",
		[var_115_2] = "public/currency/explorecoin.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_115_5, {
		__index = function(arg_123_0, arg_123_1)
			return "public/currency/" .. item_data[arg_123_1].image_id .. ".png"
		end
	})

	local var_115_6 = {
		[var_115_0] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[0] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		[var_115_1] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[var_115_2] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end,
		[6800601] = function()
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer"
			})
		end
	}

	setmetatable(var_115_6, {
		__index = function(arg_129_0, arg_129_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_129_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_115_7 = {}

	local function var_115_8(arg_131_0)
		local var_131_0 = var_115_7

		if arg_131_0.result == 1 then
			activity_manager:buyTicketItem(arg_115_0.id, var_115_7.curbuyTime, function(arg_132_0)
				if arg_132_0.result == 1 then
					LayerManager:removePopLayer(_index)

					arg_115_1.have_bought = arg_115_1.have_bought + var_131_0.curbuyTime
					arg_115_1.sell_out = arg_115_1.buy_limit and arg_115_1.buy_limit <= arg_115_1.have_bought

					global_gain({
						items = {}
					})

					if var_131_0.callback then
						var_131_0.callback()
					end
				elseif arg_132_0.result == 2 then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_132_0.result == 3 then
					var_115_6[var_131_0.shopitem.currency]()
				end
			end)
		end
	end

	local function var_115_9(arg_133_0)
		if not arg_133_0.currency2 or ActivityBachelorManager:getLastPriceByItem(arg_133_0.itemid, arg_133_0.currency2) < arg_133_0.discount2 then
			return true
		end

		return false
	end

	;(function(arg_134_0)
		local var_134_0 = {
			itemid = arg_134_0.itemid,
			item_attr = arg_134_0.item_attr
		}

		var_134_0.limitNum = arg_134_0.buy_limit and (arg_134_0.buy_limit - arg_134_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_134_0.buy_limit - arg_134_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

		local var_134_1

		if var_115_9(arg_134_0) then
			var_134_1 = math.floor(var_115_4[arg_134_0.currency]() / arg_134_0.cost)
			var_134_0.currency = arg_134_0.currency
		else
			var_134_1 = math.floor(var_115_4[arg_134_0.currency2]() / arg_134_0.cost2)
			var_134_0.currency = arg_134_0.currency2
		end

		if var_134_1 > var_134_0.limitNum then
			var_134_0.limitNum = var_134_0.limitNum or var_134_1
		end

		var_134_0.slidecost = {}

		if var_115_9(arg_134_0) then
			var_134_0.slidecost.costtype = arg_134_0.costIcon
			var_134_0.slidecost.costnum = arg_134_0.discount or arg_134_0.cost
			var_134_0.slidecost.nowHave = var_115_4[arg_134_0.currency]()
			var_134_0.slidecost.cost_old = arg_134_0.cost_old or var_134_0.slidecost.costnum
		else
			var_134_0.slidecost.costtype = arg_134_0.costIcon2
			var_134_0.slidecost.costnum = arg_134_0.discount2 or arg_134_0.cost2
			var_134_0.slidecost.nowHave = var_115_4[arg_134_0.currency2]()
			var_134_0.slidecost.cost_old = arg_134_0.cost_old2 or var_134_0.slidecost.costnum
		end

		function var_134_0:ShopSliderCallback(arg_135_1, arg_135_2)
			if arg_135_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self:isBright() then
				return
			end

			local var_135_0 = self.nowNum or 1

			var_115_7 = {
				curbuyTime = var_135_0,
				shoptype = shoptype,
				itemid = var_134_0.itemid,
				callback = arg_135_2,
				shopitem = arg_134_0
			}

			if var_115_9(arg_134_0) and arg_134_0.cost > var_115_4[arg_134_0.currency]() then
				LayerManager:removePopLayer()
				var_115_6[arg_134_0.currency]()

				return
			end

			self:setTouchEnabled(false)
			var_115_8({
				result = 1
			})
		end

		var_134_0.hideGainButton = true

		if arg_134_0.have_bought and arg_134_0.buy_limit then
			var_134_0.limit_buy_num = arg_134_0.buy_limit - arg_134_0.have_bought
			var_134_0.have_bought_num = arg_134_0.have_bought
		end

		var_134_0.to_shop = arg_134_0.to_shop

		arg_115_0:showBuyPop(var_134_0)

		arg_134_0.isnewitem = false
	end)((function(arg_136_0)
		local var_136_0 = {
			name = item_data[arg_136_0.itemtype].name,
			itemid = arg_136_0.itemtype,
			costIcon = var_115_5[arg_136_0.currency],
			currency = arg_136_0.currency,
			cost = arg_136_0.price
		}

		var_136_0.quality = item_data[arg_136_0.itemtype].equip_quality or 1
		var_136_0.bag_item_type = item_data[arg_136_0.itemtype].bag_item_type
		var_136_0.buy_limit = arg_136_0.buy_limit or 1000000
		var_136_0.have_bought = arg_136_0.have_bought or 0
		var_136_0.sell_out = arg_136_0.buy_limit and arg_136_0.buy_limit <= arg_136_0.have_bought
		var_136_0.to_shop = arg_136_0.to_shop

		return var_136_0
	end)(arg_115_1))
end

function ActivityFlopBaseNewLayer:jumptoSignLayer()
	self.layerInfos = {
		ActivitySignLayer_118_1 = {
			Name = "ActivitySignLayer_118_1",
			type = "PopLayer",
			createLayer = function(...)
				require("controller.sign_manager"):createActivitySignLayer(...)
			end
		}
	}

	self:pushInLayer((self:getAutoPopLayerConfig({
		activityID = 118
	})))
end

function ActivityFlopBaseNewLayer:getLayerInfoByName(arg_139_1)
	if not arg_139_1 then
		return
	end

	return self.layerInfos[arg_139_1]
end

function ActivityFlopBaseNewLayer:pushInLayer(arg_140_1)
	local var_140_0 = self:getLayerInfoByName("ActivitySignLayer_118_1")

	arg_140_1.id = "118-1"
	self.layer_type = var_140_0.type

	if self.layer_type == "PopLayer" then
		var_140_0.createLayer(arg_140_1)
	end
end

function ActivityFlopBaseNewLayer.getLayerIDTbl(arg_141_0)
	local function var_141_0(arg_142_0, arg_142_1)
		while activity_flop_condition_conf[arg_142_0][arg_142_1 .. 1] do
			if arg_142_1 == "sign_id" then
				layerID[activity_flop_condition_conf[arg_142_0][arg_142_1 .. 1]] = "ActivitySignLayer_118_1"
			end
		end
	end

	for iter_141_0, iter_141_1 in pairs(activity_flop_condition_conf) do
		if activity_flop_condition_conf[iter_141_0].proceed and activity_flop_condition_conf[iter_141_0].proceed ~= 0 then
			var_141_0(iter_141_0, "proceed_id")
		end

		if activity_flop_condition_conf[iter_141_0].task and activity_flop_condition_conf[iter_141_0].task ~= 0 then
			var_141_0(iter_141_0, "task_id")
		end

		if activity_flop_condition_conf[iter_141_0].sign and activity_flop_condition_conf[iter_141_0].sign ~= 0 then
			var_141_0(iter_141_0, "sign_id")
		end

		if activity_flop_condition_conf[iter_141_0].levelmode and activity_flop_condition_conf[iter_141_0].levelmode ~= 0 then
			var_141_0(iter_141_0, "levelmode_id")
		end

		if activity_flop_condition_conf[iter_141_0].shoptype and activity_flop_condition_conf[iter_141_0].shoptype ~= 0 then
			var_141_0(iter_141_0, "shoptype_id")
		end

		if activity_flop_condition_conf[iter_141_0].markettype and activity_flop_condition_conf[iter_141_0].markettype ~= 0 then
			var_141_0(iter_141_0, "markettype_id")
		end

		if activity_flop_condition_conf[iter_141_0].twisttype and activity_flop_condition_conf[iter_141_0].twisttype ~= 0 then
			var_141_0(iter_141_0, "twisttype_id")
		end
	end
end

function ActivityFlopBaseNewLayer.getAutoPopLayerConfig(arg_143_0, arg_143_1)
	local var_143_0 = activity_manager:getActivityListData()[arg_143_1.activityID].list
	local var_143_1 = {}

	for iter_143_0 = 1, #var_143_0 do
		if var_143_0[iter_143_0].activity_type == autoPopLayerType then
			var_143_1 = var_143_0[iter_143_0]

			break
		end
	end

	var_143_1.activityID = arg_143_1.activityID
	var_143_1.isAutoPop = arg_143_1.isAuto

	return var_143_1
end

function ActivityFlopBaseNewLayer:autoPopSign()
	local var_144_0 = time_check_manager:getCurTime()

	if var_144_0 > RoleDefault:getInstance():getIntegerForKey("nextFlopSignPop", 0) then
		self:jumptoSignLayer()

		local var_144_1 = os.date("*t", var_144_0)

		RoleDefault:getInstance():setIntegerForKey("nextFlopSignPop", (os.time({
			hour = 23,
			min = 59,
			sec = 59,
			year = var_144_1.year,
			month = var_144_1.month,
			day = var_144_1.day
		})))
	end
end

function ActivityFlopBaseNewLayer.showSoulGirlPop(arg_145_0, arg_145_1)
	LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
		modelid = item_data[arg_145_1.itemid].model
	})
end

function ActivityFlopBaseNewLayer.initNewObjects(arg_146_0)
	return
end

function ActivityFlopBaseNewLayer:updateNewObjects()
	self:updateChampionTipLabel()
	self:updateFurniture()
end

function ActivityFlopBaseNewLayer.updateChampionTipLabel(arg_148_0)
	return
end

function ActivityFlopBaseNewLayer.updateFurniture(arg_149_0)
	return
end
