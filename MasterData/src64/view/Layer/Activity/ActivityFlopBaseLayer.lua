ActivityFlopBaseLayer = class("ActivityFlopBaseLayer", function()
	return cc.Layer:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local discount_manager = require("controller.discount_manager")
local playermodel = require("model.playermodel")
local L2Actor = require("view.Sprite.L2Actor")
local var_0_7 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local activity_conf_data = require("data.activity_conf_data")

require("view.Layer.Activity.ActivityFlopDuanWuLayer")
require("view.Layer.Activity.ActivityFlopSummerLayer")
require("view.Layer.Activity.ActivitySummer.ActivityFlopLayer_128")
require("view.Layer.Activity.ActivityMoonFestival.ActivityFlopLayer_138")
require("view.Layer.Activity.ActivityUmaru.ActivityFlopLayer_137")

local var_0_12 = {}

function ActivityFlopBaseLayer.create(arg_2_0)
	return (ActivityFlopBaseLayer.new())
end

function ActivityFlopBaseLayer:initDynaticPara()
	self.id = 118
	self.bgPath = "mainScenebg/activity/branch" .. self.id .. "/BG.png"
	self.rolebg = "mainScenebg/activity/branch" .. self.id .. "/role_bg.png"
	self.texturePath = "ActivityFlopDuanwu/"
	self.cardPanelOffsetX = 45
	self.cardPanelOffsetY = 90
	self.cardPanelWidth = 550
	self.championDetailOffsetY = 10
end

function ActivityFlopBaseLayer:init(arg_4_1)
	self:initDynaticPara(arg_4_1)
	self:initUI()
	self:initData()
	self:fullScreen()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
			activity_manager:updateActivityAlert("flop", self.id, self:canFlop())

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
end

function ActivityFlopBaseLayer:initData()
	self.isCardAction = false

	activity_manager:getActivityFlopConf(self.id, function(arg_7_0)
		self.skinList = activity_manager:getSkinList(self.id)

		self:initCard(arg_7_0)
		self:updateChangeSkinBtn()
		self:updateResetBtn()
		self:updateChampionData()
		self:updateChampionItem()
		self:updateFlopTurns()
		self:updateSkin()
		self:drawCard((self:getStartPos()))
		self:updateOther()
	end)
end

function ActivityFlopBaseLayer:initUI()
	local var_8_0 = ccui.ImageView:create(self.bgPath)

	var_8_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_8_0:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y))
	self:addChild(var_8_0)

	self.imgBg = var_8_0

	local var_8_1 = ccui.Layout:create()

	var_8_1:setContentSize(GameDisplay.getScreenSize())
	var_8_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_8_1:setAnchorPoint(0, 0)
	var_8_1:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(var_8_1)

	self.rootLayer = var_8_1

	self:initTitle()
	self:initSurplusTime()
	self:initDrawBg()
	self:initAllBtn()
	self:initChangeSkinBtn()
	self:initOther()
	self:initTicket()
	self:initFlopTurns()
end

function ActivityFlopBaseLayer:initTitle()
	local var_9_0 = ccui.ImageView:create(self.texturePath .. "banner.png", var_0_7)

	var_9_0:setAnchorPoint(cc.p(0, 0.5))
	var_9_0:setPosition(cc.p(20, self.rootLayer:getContentSize().height * 0.89))
	self.rootLayer:addChild(var_9_0, 1)
	var_9_0:setTouchEnabled(true)
	var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "activity_flop_duanwu"
		})
	end)

	self.Title = var_9_0
end

function ActivityFlopBaseLayer:initSurplusTime()
	local var_11_0 = cc.Label:createWithTTF("", FONT_NAME, 22)

	var_11_0:setAnchorPoint(cc.p(0, 1))
	var_11_0:setName("time")
	var_11_0:setColor(cc.c3b(130, 249, 255))
	var_11_0:setPosition(cc.p(40, 30))
	self.Title:addChild(var_11_0)
	self:createSurplusTime(var_11_0, activity_conf_data[self.id].finishtime)
end

local function var_0_13(arg_12_0)
	local var_12_5 = math.floor(arg_12_0 / 24 / 3600)

	arg_12_0 = arg_12_0 - var_12_5 * 24 * 3600

	local var_12_6 = math.floor(arg_12_0 / 3600)

	arg_12_0 = arg_12_0 - var_12_6 * 3600

	local var_12_7 = math.floor(arg_12_0 / 60)

	return 0 ~= 0 and string.format(L_TIME_REST2 .. L_TIME_TEXT[1], var_12_5, var_12_6) or var_12_6 ~= 0 and string.format(L_TIME_REST2 .. L_TIME_TEXT[2], var_12_6, var_12_7) or string.format(L_TIME_REST2 .. L_TIME_TEXT[3], var_12_7)
end

function ActivityFlopBaseLayer.createSurplusTime(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = global_get_time_by_date(arg_13_2) - time_check_manager:getCurTime()

	if not var_13_0 then
		return
	end

	arg_13_0.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_13_0, function(arg_14_0)
		if arg_13_1 then
			arg_13_1:setString((var_0_13(arg_14_0)))

			if arg_14_0 <= 0 and arg_13_1 then
				time_check_manager:removeUpdatePool(arg_13_0.activityScheduler)
				arg_13_1:setVisible(false)
			end
		end
	end)))
end

function ActivityFlopBaseLayer:initDrawBg()
	local var_15_0 = ccui.ImageView:create(self.texturePath .. "champion_bg.png", var_0_7)

	var_15_0:setAnchorPoint(cc.p(0.5, 0))
	var_15_0:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, 740))
	self.rootLayer:addChild(var_15_0, 1)

	local var_15_1 = ccui.ImageView:create(self.texturePath .. "draw_bg.png", var_0_7)

	var_15_1:setAnchorPoint(cc.p(0.5, 1))
	var_15_1:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, var_15_0:getPositionY() + 28))
	self.rootLayer:addChild(var_15_1, 1)

	self.championBg = var_15_0
	self.drawBg = var_15_1
end

function ActivityFlopBaseLayer:initAllBtn()
	local var_16_0 = ccui.Button:create(self.texturePath .. "btn_return.png", nil, self.texturePath .. "btn_return.png", var_0_7)

	var_16_0:setAnchorPoint(cc.p(0, 0))
	var_16_0:setPosition(cc.p(8, 50))
	self.drawBg:addChild(var_16_0, 1)

	local var_16_1 = ccui.Button:create(self.texturePath .. "btn_award_list.png", nil, self.texturePath .. "btn_award_list.png", var_0_7)

	var_16_1:setAnchorPoint(cc.p(1, 0))
	var_16_1:setPosition(cc.p(620, self.rootLayer:getContentSize().height * 0.92))
	self.rootLayer:addChild(var_16_1, 1)

	local var_16_2 = ccui.Button:create(self.texturePath .. "btn_sign.png", nil, self.texturePath .. "btn_sign.png", var_0_7)

	var_16_2:setAnchorPoint(cc.p(1, 0))
	var_16_2:setPosition(cc.p(var_16_1:getPositionX(), var_16_1:getPositionY() - var_16_1:getContentSize().height - 20))
	self.rootLayer:addChild(var_16_2, 1)

	local var_16_3 = ccui.Button:create(self.texturePath .. "btn_get_more.png", nil, self.texturePath .. "btn_return.png", var_0_7)

	var_16_3:setAnchorPoint(cc.p(1, 0))
	self.drawBg:addChild(var_16_3, 1)

	self.shopbtn = var_16_3

	var_16_0:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	var_16_1:addTouchEventListener(function(arg_18_0, arg_18_1)
		local var_18_0

		if arg_18_1 ~= ccui.TouchEventType.ended then
			do return end

			var_18_0 = {
				callback = callback,
				category = {
					activityFlop = 1,
					type = 5
				}
			}
		end

		var_18_0.items_tbl = activity_manager:getDropConf(self.id)
		var_18_0.words_tbl = {
			type_tbl = {}
		}

		LayerManager:pushInLayer("DropDetailsLayer", var_18_0)
	end)
	var_16_2:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:jumptoSignLayer()
	end)
	self:autoPopSign()
	var_16_3:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = "1-18888",
			returnLayer = self.layerName
		})
	end)
end

function ActivityFlopBaseLayer:initChangeSkinBtn()
	local var_21_0 = ccui.Button:create(self.texturePath .. "btn_next_skin.png", nil, self.texturePath .. "btn_next_skin.png", var_0_7)

	var_21_0:setAnchorPoint(cc.p(1, 0.5))
	var_21_0:setPositionX(GameDisplay.width)
	self.rootLayer:addChild(var_21_0, 5)

	self.changeSkinBtn = var_21_0

	self.changeSkinBtn:setVisible(false)
end

function ActivityFlopBaseLayer:updateChangeSkinBtn()
	if #self.skinList > 1 then
		self.changeSkinBtn:setVisible(true)
		self:setSkinBtnEvent()
	else
		self.changeSkinBtn:setVisible(false)
	end
end

function ActivityFlopBaseLayer:setSkinBtnEvent()
	local var_23_0 = #self.skinList

	self.changeSkinBtn:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.skinShowId = self.skinShowId == var_23_0 and 1 or self.skinShowId + 1

		self.bigRole:loadTexture(self.rolebg .. "role_bg_" .. self.skinShowId .. ".png")

		self.skinItemid = self.skinList[self.skinShowId].itemid

		self.skinDetail:loadTexture(self.texturePath .. "champion_detail_" .. self.skinShowId .. ".png", var_0_7)
	end)
end

function ActivityFlopBaseLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, {
		{
			name = "reset",
			word = "",
			handler = function(self, arg_27_1)
				if arg_27_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:setBright(false)
				self:setVisible(false)
				self:resetFlop()
			end,
			texture = self.texturePath .. "btn_reset.png"
		}
	})

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 2)

	self.resetBtn = self.bottomList:getChildByName("reset")
end

function ActivityFlopBaseLayer:initTicket()
	local var_28_0, var_28_1, var_28_2 = activity_manager:getFlopTicket(self.id)
	local var_28_3 = 40
	local var_28_4 = cc.Label:createWithTTF(L_OWN_TICKET, FONT_NAME, 24)

	var_28_4:setAnchorPoint(cc.p(1, 0.5))
	var_28_4:setName("ticketTitle")
	var_28_4:setColor(cc.c3b(14, 55, 64))
	var_28_4:setPosition(cc.p(self.drawBg:getContentSize().width / 2 + var_28_3, self.drawBg:getContentSize().height - 18))
	self.drawBg:addChild(var_28_4)

	local var_28_5 = cc.Label:createWithTTF(string.format("%d/%d", var_28_1, var_28_0), FONT_NAME, 24)

	var_28_5:setAnchorPoint(cc.p(0, 0.5))
	var_28_5:setName("ticketNum")
	var_28_5:setColor(var_28_0 <= var_28_1 and cc.c3b(14, 55, 64) or cc.c3b(172, 39, 39))
	var_28_5:setPosition(cc.p(self.drawBg:getContentSize().width / 2 + var_28_3 + 40, var_28_4:getPositionY()))
	self.drawBg:addChild(var_28_5)

	local var_28_6 = ccui.ImageView:create("equipment/" .. item_data[var_28_2].image_id .. ".png")

	var_28_6:setAnchorPoint(cc.p(0.5, 0.5))
	var_28_6:setScale(0.25)
	var_28_6:setPosition(cc.p(self.drawBg:getContentSize().width / 2 + var_28_3 + 20, var_28_4:getPositionY()))
	self.drawBg:addChild(var_28_6)

	self.ticketNum = var_28_5
end

function ActivityFlopBaseLayer:initFlopTurns()
	local var_29_0 = cc.Label:createWithTTF(L_FLOP_TURNS_NOW, FONT_DES, 20)

	var_29_0:setAnchorPoint(cc.p(0.5, 1))
	var_29_0:setColor(cc.c3b(202, 155, 255))
	var_29_0:setName("flopBgWord")
	var_29_0:setPosition(cc.p(self.drawBg:getContentSize().width / 2, self.drawBg:getContentSize().height - 50))
	self.drawBg:addChild(var_29_0)

	local var_29_1 = ccui.Layout:create()

	var_29_1:setContentSize(cc.size(60, var_29_0:getContentSize().height))
	var_29_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_29_1:setAnchorPoint(0.5, 1)
	var_29_1:setPosition(cc.p(var_29_0:getPositionX() + 15, var_29_0:getPositionY()))
	var_29_1:setName("numLayer")
	self.drawBg:addChild(var_29_1)

	local var_29_2 = cc.Label:createWithTTF("/" .. activity_conf_data[self.id].flop_limit_turns, FONT_DES, 20)

	var_29_2:setAnchorPoint(cc.p(1, 0.5))
	var_29_2:setName("flopTotalTurns")
	var_29_2:setColor(cc.c3b(202, 155, 255))
	var_29_2:setPosition(cc.p(var_29_1:getContentSize().width / 2, var_29_1:getContentSize().height / 2))
	var_29_1:addChild(var_29_2)

	local var_29_3 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_29_3:setAnchorPoint(cc.p(0, 0.5))
	var_29_3:setName("flopTurns")
	var_29_3:setColor(cc.c3b(255, 223, 47))
	var_29_3:setPosition(cc.p(var_29_1:getContentSize().width / 2, var_29_1:getContentSize().height / 2))
	var_29_1:addChild(var_29_3)

	self.flopTurns = var_29_3

	var_29_1:setContentSize(cc.size(var_29_2:getContentSize().width + var_29_3:getContentSize().width, var_29_0:getContentSize().height))
	var_29_1:setPositionX(var_29_0:getPositionX() + 20)
	var_29_2:setPositionX(var_29_1:getContentSize().width)
	var_29_3:setPositionX(0)
end

function ActivityFlopBaseLayer:initOther()
	local var_30_0 = cc.Label:createWithTTF(L_FLOP_TIPS, FONT_DES, 20)

	var_30_0:setAnchorPoint(cc.p(1, 1))
	var_30_0:setName("flopTips")
	var_30_0:setColor(cc.c3b(128, 122, 255))
	var_30_0:setPosition(cc.p(self.drawBg:getContentSize().width / 2, self.drawBg:getContentSize().height - 250 - GameDisplay.fix_y))
	self.drawBg:addChild(var_30_0)

	local var_30_1 = ccui.ImageView:create(self.rolebg .. "role_bg_1.png")

	var_30_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_30_1:setPosition(cc.p(320, self.rootLayer:getContentSize().height * 0.6))
	self.rootLayer:addChild(var_30_1)

	self.bigRole = var_30_1
end

function ActivityFlopBaseLayer:initCard(arg_31_1)
	local var_31_0 = {}
	local var_31_1 = activity_manager:getFlopMatrixConf(self.id)
	local var_31_2 = activity_manager:getChampionCardPos(self.id)

	for iter_31_0 = 1, var_31_1 * var_31_1 do
		local var_31_3 = self:createCardObj()

		var_31_3:setBack()
		var_31_3:setOrder(iter_31_0)

		if arg_31_1["pos_" .. iter_31_0] then
			var_31_3:setItem(arg_31_1["pos_" .. iter_31_0].itemImg, arg_31_1["pos_" .. iter_31_0].itemNum, arg_31_1["pos_" .. iter_31_0].itemid)
			var_31_3:setFront()
			var_31_3:setRewarded(true)

			if iter_31_0 == var_31_2 then
				var_31_3:setChampionAni()
			end
		end

		table.insert(var_31_0, var_31_3)
	end

	self.cardTbl = var_31_0
end

function ActivityFlopBaseLayer:createCardObj()
	local var_32_0 = {}
	local var_32_1 = ccui.ImageView:create(self.texturePath .. "card_back.png", var_0_7)

	var_32_1:setAnchorPoint(cc.p(0.5, 0.5))

	local var_32_2 = ccui.ImageView:create(self.texturePath .. "card_front.png", var_0_7)

	var_32_2:setAnchorPoint(cc.p(0.5, 0.5))

	local var_32_3 = ccui.Layout:create()

	var_32_3:setContentSize(cc.size(var_32_1:getContentSize().width, var_32_1:getContentSize().height))
	var_32_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_32_3:setAnchorPoint(0.5, 0.5)
	var_32_3:setTouchEnabled(true)

	var_32_0.backImg = var_32_1
	var_32_0.frontImg = var_32_2
	var_32_0.touchLayer = var_32_3

	function var_32_0:setItem(arg_33_1, arg_33_2, arg_33_3)
		local var_33_0
		local var_33_1
		local var_33_2 = 1
		local var_33_3

		if arg_33_3 == "gold" then
			var_33_0 = "equipment/1000001.png"
			var_33_1 = 1
			var_33_2 = 1
		elseif arg_33_3 == "diamond" then
			var_33_0 = "equipment/1000000.png"
			var_33_1 = 1
			var_33_2 = 5
		elseif item_data[arg_33_3].bag_item_type == kITEM_COMPONENT then
			var_33_3 = componentManager:create_component_icon(arg_33_3)
			var_33_2 = item_data[arg_33_3].equip_quality
		elseif item_data[arg_33_3].image_id then
			var_33_0 = "equipment/" .. item_data[arg_33_3].image_id .. ".png"
			var_33_2 = item_data[arg_33_3].equip_quality
		end

		self.frontImg:loadTexture(self.texturePath .. var_33_2 .. ".png", var_0_7)

		var_33_3 = var_33_3 or ccui.ImageView:create(var_33_0)

		var_33_3:setName("itemSp")

		var_33_1 = var_33_1 or global_get_item_scale(var_33_3, item_data[arg_33_3].bag_item_type)

		var_33_3:setScale(var_33_1 * 0.65)
		var_33_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_33_3:setPositionX(self.frontImg:getContentSize().width / 2)
		var_33_3:setPositionY(self.frontImg:getContentSize().height / 2)
		self.frontImg:addChild(var_33_3)

		local var_33_4 = cc.Label:createWithTTF("x" .. arg_33_2, FONT_NAME, 26)

		var_33_4:setAnchorPoint(cc.p(1, 0))
		var_33_4:setPositionX(self.frontImg:getContentSize().width - 5)
		var_33_4:setPositionY(5)
		self.frontImg:addChild(var_33_4)
		self:setItemid(arg_33_3)
	end

	function var_32_0:setOrder(arg_34_1)
		self.order = arg_34_1
		self.touchLayer.order = arg_34_1
	end

	function var_32_0:getOrder()
		return self.order
	end

	function var_32_0:setBack()
		self.backImg:setVisible(true)
		self.frontImg:setVisible(false)
	end

	function var_32_0:setFront()
		self.backImg:setVisible(false)
		self.frontImg:setVisible(true)
	end

	function var_32_0:setTouchable()
		self.touchLayer:setTouchEnabled(true)
	end

	function var_32_0:forbidTouch()
		self.touchLayer:setTouchEnabled(false)
	end

	function var_32_0.setItemid(arg_40_0, arg_40_1)
		arg_40_0.itemid = arg_40_1
	end

	function var_32_0:getItemid()
		return self.itemid
	end

	function var_32_0.setRewarded(arg_42_0, arg_42_1)
		arg_42_0.rewarded = arg_42_1
	end

	function var_32_0:getRewarded()
		return self.rewarded
	end

	function var_32_0:setPos(arg_44_1)
		self.pos = {}
		self.pos.x = arg_44_1.x
		self.pos.y = arg_44_1.y
	end

	function var_32_0:getPos()
		return self.pos
	end

	function var_32_0:delete()
		self.backImg:removeFromParent()
		self.frontImg:removeFromParent()
		self.touchLayer:removeFromParent()
	end

	function var_32_0:setChampionAni()
		ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("flop.ExportJson")

		local var_47_0 = ccs.Armature:create("flop")

		var_47_0:setPosition(self.frontImg:getContentSize().width / 2, self.frontImg:getContentSize().height / 2)
		var_47_0:getAnimation():play("Animation1")
		self.frontImg:addChild(var_47_0)
	end

	function var_32_0:getCardAward()
		local var_48_0, var_48_1 = activity_manager:getFlopTicket(self.id)

		if var_48_1 < var_48_0 then
			activity_manager:getFlopLimitBag(self.id, function(arg_50_0)
				LayerManager:pushInLayer(self:getBuyLimitLayerName(), arg_50_0)
			end)

			return
		end

		self:forbidAllCard()
		activity_manager:setActivityFlopResult(self.id, self.order, function(arg_49_0)
			if arg_49_0 then
				self:setItem(arg_49_0.drawConf.itemImg, arg_49_0.drawConf.itemNum, arg_49_0.drawConf.itemid)
				self:setRewarded(true)

				self.isChampion = arg_49_0.isChampion

				if arg_49_0.isChampion then
					self.championCard = self

					print("抽到大奖啦！！！！！！！！！！！！！！！")
					self:turn(arg_49_0.itemGain, true)
				else
					global_get(arg_49_0.itemGain)
					self:turn(arg_49_0.itemGain)
					self:awardReturn()
				end
			else
				self:releaseAllCard()
			end
		end)
	end

	function var_32_0:turn(arg_51_1, arg_51_2)
		self.backImg:runAction(cc.Sequence:create(cc.OrbitCamera:create(0.1, 1, 0, 0, 90, 0, 0), cc.Hide:create(), cc.CallFunc:create(function()
			self.frontImg:runAction(cc.Sequence:create(cc.Show:create(), cc.OrbitCamera:create(0.1, 1, 0, 270, 90, 0, 0), cc.CallFunc:create(function()
				if arg_51_2 then
					global_gain(arg_51_1)
				end
			end)))
		end)))
	end

	function var_32_0:turnback()
		self.frontImg:runAction(cc.Sequence:create(cc.OrbitCamera:create(0.05, 1, 0, 0, 90, 0, 0), cc.Hide:create(), cc.CallFunc:create(function()
			self.backImg:runAction(cc.Sequence:create(cc.Show:create(), cc.OrbitCamera:create(0.05, 1, 0, 270, 90, 0, 0)))
		end)))
	end

	function var_32_0:showItemDetail()
		local var_56_0 = {
			itemid = self:getItemid()
		}

		var_56_0.hideGainButton = true

		if var_56_0.itemid and type(var_56_0.itemid) == "number" then
			LayerManager:pushInLayer("PopItemLayer", var_56_0)
		end
	end

	function var_32_0:clickEvent()
		if self:getCardAction() then
			return
		end

		if self:getRewarded() then
			self:showItemDetail()
		else
			self:getCardAward()
		end
	end

	var_32_0.touchLayer:addTouchEventListener(function(arg_58_0, arg_58_1)
		if arg_58_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.cardTbl[arg_58_0.order]:clickEvent()
	end)

	return var_32_0
end

function ActivityFlopBaseLayer.updateReset(arg_59_0)
	return
end

function ActivityFlopBaseLayer:updateFlopTurns()
	local var_60_0 = self.drawBg:getChildByName("flopBgWord")
	local var_60_1 = self.drawBg:getChildByName("numLayer")
	local var_60_2 = var_60_1:getChildByName("flopTotalTurns")
	local var_60_3 = var_60_1:getChildByName("flopTurns")

	self.flopTurns:setString((activity_manager:getFlopTurns(self.id)))
	var_60_1:setContentSize(cc.size(var_60_2:getContentSize().width + var_60_3:getContentSize().width, var_60_0:getContentSize().height))
	var_60_1:setPositionX(var_60_0:getPositionX() + 20)
	var_60_2:setPositionX(var_60_1:getContentSize().width)
	var_60_3:setPositionX(0)
end

function ActivityFlopBaseLayer:updateResetBtn()
	local var_61_0 = activity_manager:getResetEnable(self.id)

	self.resetBtn:setVisible(var_61_0)
	self.bottomList:getChildByName("reset"):setBright(var_61_0)
end

function ActivityFlopBaseLayer:updateChampionData()
	self.championItemOrder = activity_manager:getFlopChampionItem(self.id)
	self.championItem = activity_manager:getFlopItemByOrder(self.id, self.championItemOrder)
end

function ActivityFlopBaseLayer:updateTicket()
	local var_63_0, var_63_1 = activity_manager:getFlopTicket(self.id)

	self.ticketNum:setString(string.format("%d/%d", var_63_1, var_63_0))
	self.ticketNum:setColor(var_63_0 <= var_63_1 and cc.c3b(14, 55, 64) or cc.c3b(172, 39, 39))
end

function ActivityFlopBaseLayer:updateSkin(arg_64_1)
	self.skinShowId = arg_64_1 or activity_manager:getSkinid(self.id)

	local var_64_0 = self.skinShowId
	local var_64_1 = self.skinList[self.skinShowId].itemid

	if not self.skinDetail then
		local var_64_2 = ccui.ImageView:create(self.texturePath .. "champion_detail_" .. self.skinShowId .. ".png", var_0_7)

		var_64_2:setAnchorPoint(cc.p(1, 0))
		var_64_2:setPosition(cc.p(self.drawBg:getContentSize().width - 10, self.drawBg:getContentSize().height + (self.championDetailOffsetY or 10)))
		self.drawBg:addChild(var_64_2, 1)

		self.skinDetail = var_64_2

		self.bigRole:loadTexture(self.rolebg .. "role_bg_" .. self.skinShowId .. ".png")
	elseif self.skinItemid and self.skinItemid ~= var_64_1 then
		self.skinDetail:setScale(1)
		self.skinDetail:runAction(cc.Sequence:create(cc.ScaleTo:create(0.03, 1.5), cc.Spawn:create(cc.ScaleTo:create(0.03, 1), cc.EaseBackIn:create((cc.MoveBy:create(0.1, cc.p(self.skinDetail:getContentSize().width + 30, 0))))), cc.DelayTime:create(1.2), cc.CallFunc:create(function()
			self.skinDetail:loadTexture(self.texturePath .. "champion_detail_" .. var_64_0 .. ".png", var_0_7)
			self.bigRole:loadTexture(self.rolebg .. "role_bg_" .. var_64_0 .. ".png")
			self.bigRole:setTouchEnabled(true)
		end), cc.EaseBackOut:create((cc.MoveBy:create(0.1, cc.p(-self.skinDetail:getContentSize().width - 30, 0))))))
	else
		self.bigRole:setTouchEnabled(true)
	end

	self.skinItemid = var_64_1
end

function ActivityFlopBaseLayer:updateChampionItem(arg_66_1)
	local var_66_0
	local var_66_1 = 50

	if not self.itemShade then
		if item_data[self.championItem.itemid].bag_item_type == kITEM_SKIN then
			var_66_0 = ccui.ImageView:create("roleimage/role1/" .. model_data[item_data[self.championItem.itemid].model].cute_role .. ".png")

			var_66_0:setScale(0.4)
			var_66_0:setName("championItem")
			var_66_0:setAnchorPoint(cc.p(0.5, 0))
			var_66_0:setPosition(cc.p(self.championBg:getContentSize().width / 2, 44 + var_66_1))
			self.championBg:addChild(var_66_0)
		else
			var_66_0 = ccui.ImageView:create("equipment/" .. self.championItem.itemImg .. ".png")

			var_66_0:setName("championItem")
			var_66_0:setAnchorPoint(cc.p(0.5, 0))
			var_66_0:setPosition(cc.p(self.championBg:getContentSize().width / 2, 44 + var_66_1))
			self.championBg:addChild(var_66_0)
		end

		var_66_0:setTouchEnabled(true)
		var_66_0:addTouchEventListener(function(arg_67_0, arg_67_1)
			if arg_67_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_67_0 = {
				itemid = self.championItem.itemid
			}

			var_67_0.hideGainButton = true

			if var_67_0.itemid and type(var_67_0.itemid) == "number" then
				LayerManager:pushInLayer("PopItemLayer", var_67_0)
			end
		end)

		local var_66_2 = cc.Label:createWithTTF("x" .. self.championItem.itemNum, FONT_NAME, 21)

		var_66_2:setAnchorPoint(cc.p(0.5, 0))
		var_66_2:setName("championNumLabel")
		var_66_2:setPositionX(var_66_0:getPositionX())
		var_66_2:setPositionY(0)
		self.championBg:addChild(var_66_2, 99)

		local var_66_3 = ccui.ImageView:create(self.texturePath .. "champion_shade.png", var_0_7)

		var_66_3:setAnchorPoint(cc.p(0.5, 0))
		var_66_3:setPosition(cc.p(var_66_0:getPositionX(), var_66_0:getPositionY() - 25 - var_66_1))
		self.championBg:addChild(var_66_3)

		self.itemShade = var_66_3
	else
		if item_data[self.championItem.itemid].bag_item_type == kITEM_SKIN then
			self.championBg:getChildByName("championItem"):loadTexture("roleimage/role1/" .. model_data[item_data[self.championItem.itemid].model].cute_role .. ".png")
			self.championBg:getChildByName("championItem"):setScale(0.4)
		else
			self.championBg:getChildByName("championItem"):loadTexture("equipment/" .. self.championItem.itemImg .. ".png")
			self.championBg:getChildByName("championItem"):setScale(1)
		end

		self.championBg:getChildByName("championNumLabel"):setString("x" .. self.championItem.itemNum)
		self.championBg:getChildByName("championItem"):setTouchEnabled(true)
	end

	local var_66_4 = cc.MoveBy:create(0.6, cc.p(0, -var_66_1))

	self.championBg:getChildByName("championItem"):setOpacity(0)
	self.championBg:getChildByName("championItem"):runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.EaseIn:create(var_66_4, 0.2))))
	self.championBg:getChildByName("championNumLabel"):setOpacity(0)
	self.championBg:getChildByName("championNumLabel"):runAction(cc.Sequence:create(cc.FadeIn:create(0.6)))
end

function ActivityFlopBaseLayer:getStartPos()
	local var_68_0 = self.cardPanelOffsetX or 45
	local var_68_1 = self.cardPanelOffsetY
	local var_68_2

	if not self.cardPanelOffsetY then
		var_68_1 = 90
		var_68_2 = {
			x = var_68_0
		}
	end

	var_68_2.y = self.drawBg:getContentSize().height - var_68_1

	return var_68_2
end

function ActivityFlopBaseLayer:drawCard(arg_69_1)
	local var_69_0 = activity_manager:getFlopMatrixConf(self.id)
	local var_69_1 = math.floor(((self.cardPanelWidth or 550) - self.cardTbl[1].backImg:getContentSize().width * var_69_0) / (var_69_0 - 1))
	local var_69_2 = self.cardGapYPlus
	local var_69_3

	if not self.cardGapYPlus then
		var_69_2 = math.floor(GameDisplay.fix_y / (var_69_0 - 1))
		var_69_3 = self.cardTbl[1].backImg:getContentSize().width + var_69_1
	end

	local var_69_4 = self.cardTbl[1].backImg:getContentSize().height + (var_69_1 + var_69_2)
	local var_69_5 = arg_69_1.x + self.cardTbl[1].backImg:getContentSize().width / 2
	local var_69_6 = arg_69_1.y - self.cardTbl[1].backImg:getContentSize().height / 2

	for iter_69_0, iter_69_1 in ipairs(self.cardTbl) do
		iter_69_1:setPos({
			x = var_69_5 + (iter_69_0 - 1) % var_69_0 * var_69_3,
			y = var_69_6 - 0 * var_69_4
		})
		iter_69_1.backImg:setPosition(cc.p(var_69_5 + (iter_69_0 - 1) % var_69_0 * var_69_3, var_69_6 - 0 * var_69_4))
		iter_69_1.frontImg:setPosition(cc.p(var_69_5 + (iter_69_0 - 1) % var_69_0 * var_69_3, var_69_6 - 0 * var_69_4))
		iter_69_1.touchLayer:setPosition(cc.p(var_69_5 + (iter_69_0 - 1) % var_69_0 * var_69_3, var_69_6 - 0 * var_69_4))
		self.drawBg:addChild(iter_69_1.backImg, 1 + iter_69_0)
		self.drawBg:addChild(iter_69_1.frontImg, 1 + iter_69_0)
		self.drawBg:addChild(iter_69_1.touchLayer, 99)

		if iter_69_0 % var_69_0 == 0 then
			-- block empty
		end
	end
end

function ActivityFlopBaseLayer.updateOther(arg_70_0)
	return
end

function ActivityFlopBaseLayer.updateUI(arg_71_0)
	return
end

function ActivityFlopBaseLayer.forbidAllCard(arg_72_0)
	arg_72_0.isCardAction = true
end

function ActivityFlopBaseLayer.releaseAllCard(arg_73_0)
	arg_73_0.isCardAction = false
end

function ActivityFlopBaseLayer:getCardAction()
	return self.isCardAction
end

function ActivityFlopBaseLayer:fullScreen()
	self.championBg:setPositionY(self.championBg:getPositionY() + GameDisplay.fix_y * 0.6)
	self.drawBg:setPositionY(self.championBg:getPositionY() + 28)
	self.bigRole:setPositionY(self.Title:getPositionY() - self.bigRole:getContentSize().height / 2 + 180)

	local var_75_0 = self.drawBg:convertToNodeSpace((self:convertToWorldSpace(cc.p(self.imgBg:getPositionX(), self.imgBg:getPositionY() - self.imgBg:getContentSize().height / 2 + 62))))
	local var_75_1 = self.drawBg:convertToNodeSpace(cc.p(0, -GameDisplay.fix_y))

	self.shopbtn:setPosition(cc.p(640, (var_75_1.y > var_75_0.y or nil) and (var_75_1.y or var_75_0.y)))
end

function ActivityFlopBaseLayer:resetFlop()
	activity_manager:resetFlop(self.id, function(arg_77_0)
		self:showDeleteAni(arg_77_0)
	end)
end

function ActivityFlopBaseLayer:deleteCard()
	for iter_78_0, iter_78_1 in pairs(self.cardTbl) do
		iter_78_1:delete()
	end

	self.cardTbl = {}
end

function ActivityFlopBaseLayer:showDeleteAni(arg_79_1)
	self:forbidAllCard()
	self.bigRole:setTouchEnabled(false)

	local var_79_0 = activity_manager:getFlopMatrixConf(self.id)
	local var_79_1 = self:getStartPos()
	local var_79_2 = (self.cardTbl[1].backImg:getPositionX() + self.cardTbl[var_79_0].backImg:getPositionX()) / 2
	local var_79_3 = (self.cardTbl[1].backImg:getPositionY() + self.cardTbl[var_79_0 * (var_79_0 - 1) + 1].backImg:getPositionY()) / 2

	for iter_79_0, iter_79_1 in pairs(self.cardTbl) do
		if iter_79_1:getItemid() then
			iter_79_1:turnback()
		end
	end

	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		for iter_80_0, iter_80_1 in pairs(self.cardTbl) do
			local var_80_0 = iter_80_1:getPos()

			iter_80_1.backImg:runAction((cc.EaseBackIn:create((cc.MoveBy:create(0.4, cc.p(var_79_2 - var_80_0.x, var_79_3 - var_80_0.y))))))
		end
	end), cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		self:deleteCard()
		self:initCard(arg_79_1)
		self:updateReset()
		self:updateChampionItem()
		self:updateFlopTurns()
		self:updateChampionData()
		self:updateSkin()
		self:drawCard((self:getStartPos()))
		self:showChampionAni()
		self:showResetAni()
	end)))
end

function ActivityFlopBaseLayer:showChampionAni()
	local var_82_0 = self.championBg:getChildByName("championItem")
	local var_82_1 = self.championBg:getChildByName("championNumLabel")
	local var_82_2 = cc.MoveBy:create(0.6, cc.p(0, -50))
	local var_82_3 = true

	var_82_0:setTouchEnabled(false)
	var_82_0:stopAllActions()
	var_82_0:setOpacity(255)
	var_82_0:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.EaseBackIn:create((cc.MoveBy:create(0.6, cc.p(0, 50))))), cc.DelayTime:create(0.6), cc.CallFunc:create(function()
		self:updateChampionItem(var_82_3)
	end)))
	var_82_1:setOpacity(255)
	var_82_1:runAction(cc.Sequence:create(cc.FadeOut:create(0.6)))
end

function ActivityFlopBaseLayer:showResetAni()
	local var_84_0 = activity_manager:getFlopMatrixConf(self.id)
	local var_84_1 = self:getStartPos()
	local var_84_2 = (self.cardTbl[1].backImg:getPositionX() + self.cardTbl[var_84_0].backImg:getPositionX()) / 2
	local var_84_3 = (self.cardTbl[1].backImg:getPositionY() + self.cardTbl[var_84_0 * (var_84_0 - 1) + 1].backImg:getPositionY()) / 2

	for iter_84_0, iter_84_1 in pairs(self.cardTbl) do
		iter_84_1.backImg:setPosition(cc.p(var_84_2, var_84_3))
	end

	self.drawBg:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		for iter_85_0, iter_85_1 in pairs(self.cardTbl) do
			local var_85_0 = iter_85_1:getPos()

			iter_85_1.backImg:runAction(cc.Sequence:create(cc.DelayTime:create(0.02 * iter_85_0), cc.EaseBackOut:create((cc.MoveBy:create(0.4, cc.p(var_85_0.x - var_84_2, var_85_0.y - var_84_3))))))
		end
	end), cc.DelayTime:create(0.05 * var_84_0 * var_84_0 + 0.3), cc.CallFunc:create(function()
		self:releaseAllCard()
		self:updateResetBtn()
		print("endendendendend")
	end)))
end

function ActivityFlopBaseLayer:awardReturn()
	if self.isChampion then
		self.championCard:setChampionAni()
	end

	self:releaseAllCard()
	self:updateTicket()
	self:updateChampionData()
	self:updateResetBtn()
end

function ActivityFlopBaseLayer:canFlop()
	local var_88_0, var_88_1, var_88_2 = activity_manager:getFlopTicket(self.id)
	local var_88_3 = activity_manager:getFlopMatrixConf(self.id)

	if var_88_1 < var_88_0 then
		return false
	end

	if activity_manager:getFlopTurns(self.id) >= activity_conf_data[self.id].flop_limit_turns and activity_manager:getFlopCount(self.id) == activity_conf_data[self.id].matrix_line * activity_conf_data[self.id].matrix_line then
		return false
	end

	return true
end

function ActivityFlopBaseLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_90_0)
		if self.isChampion then
			self.championCard:setChampionAni()
		end

		self:releaseAllCard()
		self:updateTicket()
		self:updateChampionData()
		self:updateResetBtn()
	end)
end

function ActivityFlopBaseLayer.getFlopShop(arg_91_0)
	return {
		"1-18888"
	}
end

function ActivityFlopBaseLayer:popGetKeyItem()
	local var_92_0, var_92_1, var_92_2, var_92_3, var_92_4 = activity_manager:getFlopTicket(self.id)
	local var_92_5 = activity_manager:getFlopMatrixConf(self.id)
	local var_92_6 = cc.UserDefault:getInstance()

	setmetatable(var_92_6, {
		__index = function(arg_93_0, arg_93_1)
			return function()
				return arg_93_1
			end
		end
	})

	local var_92_8 = {
		have_bought = 0,
		itemtype = var_92_2,
		currency = ({
			diamond = SHOP_CURRENCY_DIAMOND,
			paid_diamond = SHOP_CURRENCY_DIAMOND
		})[var_92_4],
		paid = (var_92_4 == "paid_diamond" or nil) and true,
		price = var_92_3,
		buy_limit = var_92_5 * var_92_5 - activity_manager:getFlopCount(self.id) - item_manager:getItemNumber(var_92_2)
	}

	if var_92_6:getIntegerForKey("flopShop", 0) == 0 then
		var_92_8.to_shop = self:getFlopShop()
	end

	self:shopPop(var_92_8)
end

function ActivityFlopBaseLayer.getBuyLimitLayerName(arg_95_0)
	return
end

function ActivityFlopBaseLayer.showBuyPop(arg_96_0, arg_96_1, arg_96_2, arg_96_3)
	if not arg_96_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_96_1)
	elseif arg_96_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_96_1)
	elseif arg_96_3 == "giftitem" then
		LayerManager:pushInLayer("PopSkinPackage", arg_96_1)
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_96_1)
	end
end

function ActivityFlopBaseLayer.shopPop(arg_97_0, arg_97_1)
	local var_97_0 = 1
	local var_97_1 = 2
	local var_97_2 = 3
	local var_97_4 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			if arg_97_1.paid then
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

	setmetatable(var_97_4, {
		__index = function(arg_103_0, arg_103_1)
			return function()
				return item_manager:getItemNumber(arg_103_1)
			end
		end
	})

	local var_97_5 = {
		[1500001] = "public/currency/1500001_1.png",
		[var_97_0] = "public/currency/UI_battleEnd_gold.png",
		[0] = arg_97_1.paid and "public/currency/888888.png" or "public/currency/UI_battleEnd_diamond.png",
		[var_97_1] = "public/currency/arenascene_dot_1.png",
		[var_97_2] = "public/currency/explorecoin.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_97_5, {
		__index = function(arg_105_0, arg_105_1)
			return "public/currency/" .. item_data[arg_105_1].image_id .. ".png"
		end
	})

	local var_97_6 = {
		[var_97_0] = function()
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
		[var_97_1] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[var_97_2] = function()
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

	setmetatable(var_97_6, {
		__index = function(arg_111_0, arg_111_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_111_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_97_7 = {}

	local function var_97_8(arg_113_0)
		print(dump(arg_113_0))

		local var_113_0 = var_97_7

		if arg_113_0.result == 1 then
			activity_manager:buyTicketItem(arg_97_0.id, var_97_7.curbuyTime, function(arg_114_0)
				if arg_114_0.result == 1 then
					LayerManager:removePopLayer(_index)

					arg_97_1.have_bought = arg_97_1.have_bought + var_113_0.curbuyTime
					arg_97_1.sell_out = arg_97_1.buy_limit and arg_97_1.buy_limit <= arg_97_1.have_bought

					global_gain({
						items = {}
					})

					if var_113_0.callback then
						var_113_0.callback()
					end
				elseif arg_114_0.result == 2 then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_114_0.result == 3 then
					var_97_6[var_113_0.shopitem.currency]()
				end
			end)
		end
	end

	local function var_97_9(arg_115_0)
		if not arg_115_0.currency2 or discount_manager:getLastPriceByItem(arg_115_0.itemid, arg_115_0.currency2, arg_115_0.discount2) < arg_115_0.discount2 then
			return true
		end

		return false
	end

	;(function(arg_116_0)
		local var_116_0 = {
			itemid = arg_116_0.itemid,
			item_attr = arg_116_0.item_attr
		}

		var_116_0.limitNum = arg_116_0.buy_limit and (arg_116_0.buy_limit - arg_116_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_116_0.buy_limit - arg_116_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

		local var_116_1

		if var_97_9(arg_116_0) then
			var_116_1 = math.floor(var_97_4[arg_116_0.currency]() / arg_116_0.cost)
			var_116_0.currency = arg_116_0.currency
		else
			var_116_1 = math.floor(var_97_4[arg_116_0.currency2]() / arg_116_0.cost2)
			var_116_0.currency = arg_116_0.currency2
		end

		if var_116_1 > var_116_0.limitNum then
			var_116_0.limitNum = var_116_0.limitNum or var_116_1
		end

		var_116_0.slidecost = {}

		if var_97_9(arg_116_0) then
			var_116_0.slidecost.costtype = arg_116_0.costIcon
			var_116_0.slidecost.costnum = arg_116_0.discount or arg_116_0.cost
			var_116_0.slidecost.nowHave = var_97_4[arg_116_0.currency]()
			var_116_0.slidecost.cost_old = arg_116_0.cost_old or var_116_0.slidecost.costnum
		else
			var_116_0.slidecost.costtype = arg_116_0.costIcon2
			var_116_0.slidecost.costnum = arg_116_0.discount2 or arg_116_0.cost2
			var_116_0.slidecost.nowHave = var_97_4[arg_116_0.currency2]()
			var_116_0.slidecost.cost_old = arg_116_0.cost_old2 or var_116_0.slidecost.costnum
		end

		function var_116_0:ShopSliderCallback(arg_117_1, arg_117_2)
			if arg_117_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self:isBright() then
				return
			end

			local var_117_0 = self.nowNum or 1

			var_97_7 = {
				curbuyTime = var_117_0,
				shoptype = shoptype,
				itemid = var_116_0.itemid,
				callback = arg_117_2,
				shopitem = arg_116_0
			}

			if var_97_9(arg_116_0) and arg_116_0.cost > var_97_4[arg_116_0.currency]() then
				LayerManager:removePopLayer()
				var_97_6[arg_116_0.currency]()

				return
			end

			self:setTouchEnabled(false)
			var_97_8({
				result = 1
			})
		end

		var_116_0.hideGainButton = true

		if arg_116_0.have_bought and arg_116_0.buy_limit then
			var_116_0.limit_buy_num = arg_116_0.buy_limit - arg_116_0.have_bought
			var_116_0.have_bought_num = arg_116_0.have_bought
		end

		var_116_0.to_shop = arg_116_0.to_shop

		arg_97_0:showBuyPop(var_116_0)

		arg_116_0.isnewitem = false
	end)((function(arg_118_0)
		local var_118_0 = {
			name = item_data[arg_118_0.itemtype].name,
			itemid = arg_118_0.itemtype,
			costIcon = var_97_5[arg_118_0.currency],
			currency = arg_118_0.currency,
			cost = arg_118_0.price
		}

		var_118_0.quality = item_data[arg_118_0.itemtype].equip_quality or 1
		var_118_0.bag_item_type = item_data[arg_118_0.itemtype].bag_item_type
		var_118_0.buy_limit = arg_118_0.buy_limit or 1000000
		var_118_0.have_bought = arg_118_0.have_bought or 0
		var_118_0.sell_out = arg_118_0.buy_limit and arg_118_0.buy_limit <= arg_118_0.have_bought
		var_118_0.to_shop = arg_118_0.to_shop

		return var_118_0
	end)(arg_97_1))
end

function ActivityFlopBaseLayer:jumptoSignLayer()
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

function ActivityFlopBaseLayer:getLayerInfoByName(arg_121_1)
	if not arg_121_1 then
		return
	end

	return self.layerInfos[arg_121_1]
end

function ActivityFlopBaseLayer:pushInLayer(arg_122_1)
	local var_122_0 = self:getLayerInfoByName("ActivitySignLayer_118_1")

	arg_122_1.id = "118-1"
	self.layer_type = var_122_0.type

	if self.layer_type == "PopLayer" then
		var_122_0.createLayer(arg_122_1)
	end
end

function ActivityFlopBaseLayer.getLayerIDTbl(arg_123_0)
	local function var_123_0(arg_124_0, arg_124_1)
		while activity_conf_data[arg_124_0][arg_124_1 .. 1] do
			if arg_124_1 == "sign_id" then
				layerID[activity_conf_data[arg_124_0][arg_124_1 .. 1]] = "ActivitySignLayer_118_1"
			end
		end
	end

	for iter_123_0, iter_123_1 in pairs(activity_conf_data) do
		if activity_conf_data[iter_123_0].proceed and activity_conf_data[iter_123_0].proceed ~= 0 then
			var_123_0(iter_123_0, "proceed_id")
		end

		if activity_conf_data[iter_123_0].task and activity_conf_data[iter_123_0].task ~= 0 then
			var_123_0(iter_123_0, "task_id")
		end

		if activity_conf_data[iter_123_0].sign and activity_conf_data[iter_123_0].sign ~= 0 then
			var_123_0(iter_123_0, "sign_id")
		end

		if activity_conf_data[iter_123_0].levelmode and activity_conf_data[iter_123_0].levelmode ~= 0 then
			var_123_0(iter_123_0, "levelmode_id")
		end

		if activity_conf_data[iter_123_0].shoptype and activity_conf_data[iter_123_0].shoptype ~= 0 then
			var_123_0(iter_123_0, "shoptype_id")
		end

		if activity_conf_data[iter_123_0].markettype and activity_conf_data[iter_123_0].markettype ~= 0 then
			var_123_0(iter_123_0, "markettype_id")
		end

		if activity_conf_data[iter_123_0].twisttype and activity_conf_data[iter_123_0].twisttype ~= 0 then
			var_123_0(iter_123_0, "twisttype_id")
		end
	end
end

function ActivityFlopBaseLayer.getAutoPopLayerConfig(arg_125_0, arg_125_1)
	local var_125_0 = activity_manager:getActivityListData()[arg_125_1.activityID].list
	local var_125_1 = {}

	for iter_125_0 = 1, #var_125_0 do
		if var_125_0[iter_125_0].activity_type == autoPopLayerType then
			var_125_1 = var_125_0[iter_125_0]

			break
		end
	end

	var_125_1.activityID = arg_125_1.activityID
	var_125_1.isAutoPop = arg_125_1.isAuto

	return var_125_1
end

function ActivityFlopBaseLayer:autoPopSign()
	local var_126_0 = time_check_manager:getCurTime()

	if var_126_0 > RoleDefault:getInstance():getIntegerForKey("nextFlopSignPop", 0) then
		self:jumptoSignLayer()

		local var_126_1 = os.date("*t", var_126_0)

		RoleDefault:getInstance():setIntegerForKey("nextFlopSignPop", (os.time({
			hour = 23,
			min = 59,
			sec = 59,
			year = var_126_1.year,
			month = var_126_1.month,
			day = var_126_1.day
		})))
	end
end

function ActivityFlopBaseLayer:showSoulGirlPop(arg_127_1)
	print("?????????", dump(arg_127_1))

	local var_127_0 = item_data[arg_127_1.itemid].model

	if not model_data[item_data[arg_127_1.itemid].model].background then
		-- block empty
	end

	local var_127_1 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SoulGirlPop.json" or "SoulGirlPop.ExportJson")
	local var_127_2 = ccui.Helper:seekWidgetByName(var_127_1, "Panel_26")

	var_127_2:setLocalZOrder(1)
	self:addChild(var_127_1, 99)

	self.showSoulGirlScenePanel = ccui.Helper:seekWidgetByName(var_127_1, "Image_back")

	self.showSoulGirlScenePanel:setPosition(cc.p(320, 568))
	self.showSoulGirlScenePanel:setTouchEnabled(true)
	self.showSoulGirlScenePanel:setLocalZOrder(0)

	local var_127_3 = ccui.Helper:seekWidgetByName(var_127_1, "Button_return")

	if model_data[var_127_0].background and model_data[var_127_0].background == "dark" then
		var_127_3:loadTextures("MarketLayer/return_btn_dark.png", nil, "MarketLayer/return_btn_dark.png", var_0_7)
	else
		var_127_3:loadTextures("MarketLayer/return_btn_bright.png", nil, "MarketLayer/return_btn_bright.png", var_0_7)
	end

	var_127_3:setLocalZOrder(2)

	local function var_127_4(arg_128_0, arg_128_1)
		if arg_128_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showgirlLayer:resetCurTalkConfig()
		var_127_1:runAction(cc.RemoveSelf:create())

		var_127_1 = nil
	end

	var_127_3:setTouchEnabled(false)
	self.showSoulGirlScenePanel:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function(...)
		var_127_3:setTouchEnabled(true)
		var_127_3:addTouchEventListener(var_127_4)
	end)))

	local var_127_5 = ccui.Helper:seekWidgetByName(var_127_1, "Panel_cute_role")
	local var_127_6 = ccui.Helper:seekWidgetByName(var_127_1, "Image_cute_role")

	var_127_6:loadTexture("roleimage/role1/" .. model_data[var_127_0].cute_role .. ".png")
	var_127_6:setPosition(cc.p(var_127_5:getContentSize().width / 2, var_127_5:getContentSize().height / 2 + 30))
	var_127_6:setScale(0.4)
	var_127_6:setVisible(false)

	local var_127_7 = ccui.Helper:seekWidgetByName(var_127_1, "Panel_up"):setPositionY(568 + GameDisplay.fix_y)
	local var_127_8 = ccui.Helper:seekWidgetByName(var_127_1, "Panel_down"):setPositionY(568 - GameDisplay.fix_y)

	ccui.Helper:seekWidgetByName(var_127_1, "Panel_down"):setLocalZOrder(3)
	ccui.Helper:seekWidgetByName(var_127_1, "Panel_up"):setLocalZOrder(3)

	L2ActorSprite = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_127_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_127_0].spine_model .. ".atlas", (model_data[var_127_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_127_0].clothes_model .. ".atlas" or nil))

	local var_127_9 = model_data[var_127_0].actorScale or 0.4

	L2ActorSprite:setScale(var_127_9, var_127_9)
	L2ActorSprite:setContentSize(cc.size(100, 200))
	L2ActorSprite:setPosition(cc.p(var_127_5:getContentSize().width / 2, var_127_5:getContentSize().height / 2 - 60))
	var_127_5:addChild(L2ActorSprite, 99)
	L2ActorSprite:playAni(nil, "idle", true)
	var_127_5:addTouchEventListener(function(arg_130_0, arg_130_1)
		if arg_130_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_130_0 = math.random(2, 5)

		local function var_130_1()
			L2ActorSprite:playAni(nil, "idle", true)
		end

		if var_130_0 == 2 then
			L2ActorSprite:playAni(var_130_1, "run", false)
		elseif var_130_0 == 3 then
			L2ActorSprite:playAni(var_130_1, "yule", false)
		elseif var_130_0 == 4 then
			L2ActorSprite:playAni(var_130_1, "chihe", false)
		else
			L2ActorSprite:playAni(var_130_1, "fadai", false)
		end
	end)

	local var_127_10 = ccui.Helper:seekWidgetByName(var_127_1, "Label_name")
	local var_127_11 = ccui.Helper:seekWidgetByName(var_127_1, "Image_cv")

	var_127_11:loadTexture("public/panelbg/cv_bg.png", var_0_7)

	if favorfile_data[3][model_data[var_127_0].photofile_model] then
		var_127_11:setVisible(favorfile_data[3][model_data[var_127_0].photofile_model] ~= L_CV_UNSURE)

		local var_127_12 = cc.Label:createWithTTF("CV/" .. favorfile_data[3][model_data[var_127_0].photofile_model], FONT_DES, 28)

		var_127_12:setPosition(cc.p(var_127_11:getContentSize().width / 2, var_127_11:getContentSize().height / 2 - 3))
		var_127_11:addChild(var_127_12)
	else
		var_127_11:setVisible(false)
	end

	var_127_10:setFontSize(global_change_fontsize_by_length(model_data[var_127_0].name, 40, 4, 6))
	var_127_10:setString(model_data[var_127_0].name)
	var_127_10:setLocalZOrder(9999)

	if var_127_10:getContentSize().width > 190 then
		var_127_10:setScale(190 / var_127_10:getContentSize().width)
	else
		var_127_10:setScale(1)
	end

	local var_127_13 = ccui.Helper:seekWidgetByName(var_127_1, "Label_name_bottom")
	local var_127_14 = ccui.Helper:seekWidgetByName(var_127_1, "Label_name_top")

	var_127_13:setString(model_data[var_127_0].main_name)
	var_127_14:setString(model_data[var_127_0].main_name)

	if model_data[var_127_0].background and model_data[var_127_0].background == "bright" then
		var_127_13:setColor(cc.c3b(40, 125, 205))
		var_127_14:setColor(cc.c3b(0, 255, 246))
	end

	local var_127_15 = ccui.Helper:seekWidgetByName(var_127_1, "Image_type")
	local var_127_16

	if model_data[var_127_0].live2d then
		var_127_16 = "MarketLayer/skin_type_live2d.png"
	elseif model_data[var_127_0].rolespine then
		var_127_16 = "MarketLayer/skin_type_spine.png"
	else
		var_127_15:setVisible(false)
	end

	var_127_15:loadTextures(var_127_16, nil, var_127_16, var_0_7)

	local var_127_17 = ccui.Helper:seekWidgetByName(var_127_1, "Image_cost_bottom")

	var_127_17:loadTexture("MarketLayer/cost_bottom_bright.png", var_0_7)
	ccui.Helper:seekWidgetByName(var_127_1, "Image_name"):loadTexture("MarketLayer/skin_name_bottom_bright.png", var_0_7)
	ccui.Helper:seekWidgetByName(var_127_1, "Button_buy"):setVisible(false)
	var_127_17:setVisible(false)

	local var_127_18 = ccui.Layout:create()

	var_127_18:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_127_18:setAnchorPoint(cc.p(0.5, 0.5))
	var_127_18:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_127_18:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_127_18:setBackGroundColor(cc.c3b(0, 0, 0))
	var_127_18:setBackGroundColorOpacity(0)
	var_127_2:addChild(var_127_18, 2)

	local var_127_19 = cc.EventListenerTouchOneByOne:create()

	var_127_19:setSwallowTouches(false)
	var_127_19:registerScriptHandler(function(arg_132_0, arg_132_1)
		if var_0_12[playermodel.playerid][var_127_0] > PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT + 1 and arg_127_1.have_bought_num ~= 1 then
			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return true
		elseif var_0_12[playermodel.playerid][var_127_0] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT then
			var_0_12[playermodel.playerid][var_127_0] = var_0_12[playermodel.playerid][var_127_0] + 1

			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return false
		else
			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_127_19:registerScriptHandler(function(arg_133_0, arg_133_1)
		return false
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_127_18:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_127_19, var_127_18)

	function handler(arg_134_0, arg_134_1)
		if arg_134_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)
	end

	self.showSoulGirlScenePanel:setVisible(true)

	self.showgirlLayer = require("view.Layer.ShowGirlLayer"):create(var_127_0, 3)

	self.showgirlLayer:resetCurTalkConfig()

	if not var_0_12[playermodel.playerid] then
		var_0_12[playermodel.playerid] = {}
		var_0_12[playermodel.playerid][var_127_0] = var_0_12[playermodel.playerid][var_127_0] or 0
	else
		var_0_12[playermodel.playerid][var_127_0] = var_0_12[playermodel.playerid][var_127_0] or 0
	end

	self.showgirlLayer:setTalkEnabled(var_0_12[playermodel.playerid][var_127_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	self.showgirlLayer:setTouchTalkCallback(function()
		var_0_12[playermodel.playerid][var_127_0] = var_0_12[playermodel.playerid][var_127_0] + 1

		self.showgirlLayer:setTalkEnabled(var_0_12[playermodel.playerid][var_127_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	end)
	var_127_2:addChild(self.showgirlLayer, 1)

	if model_data[var_127_0].backgroundid then
		var_127_2:addChild(BackGroundLayer:create(model_data[var_127_0].backgroundid, (model_data[var_127_0].is_own_full_screen_background == 1 or nil) and 2), 0)
	end
end
