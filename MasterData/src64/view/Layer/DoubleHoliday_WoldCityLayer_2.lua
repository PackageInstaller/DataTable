DoubleHoliday_WoldCityLayer_2 = class("DoubleHoliday_WoldCityLayer_2", function()
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
local var_0_6 = require("controller.time_check_manager")
local aiattack_manager = require("controller.aiattack_manager")
local level_manager = require("controller.level_manager")
local var_0_9
local levelmode_data = require("data.levelmode_data")
local activity_plague_message_data = require("data.activity_plague_message_data")
local activity_plague_city_data = require("data.activity_plague_city_data")
local activity_plague_data = require("data.activity_plague_data")
local var_0_14 = require("data.levelmode_data")
local item_manager = require("controller.item_manager")
local item_doubleholiday_data = require("data.item_doubleholiday_data")
local item_data = require("data.item_data")
local activity_plague_other_data = require("data.activity_plague_other_data")
local ItemSprite = require("view.Sprite.ItemSprite")
local var_0_20 = {
	201912003,
	201912002,
	201912001
}
local var_0_21 = {
	"Activity_doubleholiday/chengjiu.png",
	"Activity_doubleholiday/ai.png",
	"Activity_doubleholiday/sd_bdkg.png"
}
local var_0_22 = config._DEBUG and 0 or 1

function DoubleHoliday_WoldCityLayer_2.create(arg_2_0, arg_2_1)
	local var_2_0 = DoubleHoliday_WoldCityLayer_2.new()

	var_2_0:init(arg_2_1)
	activity_manager:fireEvent(activity_manager.activityEventId.POP_LAYER_OPEMED)

	return var_2_0
end

function DoubleHoliday_WoldCityLayer_2.getInstance()
	return var_0_9
end

function DoubleHoliday_WoldCityLayer_2:init(arg_4_1)
	var_0_9 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "DoubleHoliday_WorldCityLayer.json" or "DoubleHoliday_WorldCityLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "image_title")
	self.title_name = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_activityname")
	self.btn_info = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_info")
	self.panel_ml = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_mindle_l")
	self.panel_mr = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_mindle_r")
	self.panel_city = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_city")
	self.panel_explore = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_tanxian")
	self.btn_broadcast = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_30")
	self.btn_explore = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_tanxian")
	self.btn_addnum = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_add")
	self.label_guaji = ccui.Helper:seekWidgetByName(self.panel_ml, "Label_28")
	self.shop_btn = ccui.Helper:seekWidgetByName(self.panel_explore, "Button_100")
	self.title_yinzi = ccui.Helper:seekWidgetByName(self.title, "Image_23")
	self.vir_add = ccui.Helper:seekWidgetByName(self.title, "Button_62")
	self.ai_create_btn = ccui.Helper:seekWidgetByName(self.panel_explore, "Button_112")
	self.add_kuozhan = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_114")

	self.title:setLocalZOrder(5)
	self.panel_ml:setLocalZOrder(5)
	self.btn_addnum:getChildByName("Label_241"):setPositionY(15)
	self:createTimeLable()
	GuideListener.lockGuideTrigger(false)
	self.btn_info:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_15)
	end)
	self.btn_broadcast:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_15)
	end)
	self.btn_explore:loadTextures("Activity_doubleholiday/tansuoben_big.png", nil, "Activity_doubleholiday/tansuoben_big.png", var_0_22)
	self.btn_explore:setPosition(cc.p(self.btn_explore:getPositionX() + 30, self.btn_explore:getPositionY() + 20))
	self.btn_addnum:setPosition(cc.p(self.btn_addnum:getPositionX() + 48, self.btn_addnum:getPositionY() + 38))
	self.add_kuozhan:setPosition(cc.p(self.add_kuozhan:getPositionX() + 15, self.add_kuozhan:getPositionY() + 38))
	self.btn_explore:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_7_0 = aiattack_manager:get_levelmode_id()

		if not item_manager:isHaveItemByType(KITEM_AI_MONSTER) then
			global_ShowBlockWords(L_DoubleHoliday_WoldCityLayer_2.SIMULATED_INTRUSION)
			arg_7_0:setBright(true)

			return
		end

		LayerManager:pushInLayer("AdventureNewDetailLayer", {
			data = var_0_14[var_7_0],
			times = self.ai_attack_times
		})
	end)
	self.btn_addnum:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)

		local var_8_0 = var_0_14[aiattack_manager:get_levelmode_id()].modetype

		local function var_8_1()
			arg_8_0:setBright(true)
		end

		local function var_8_2()
			level_manager:buyAdventureDailyTime(var_8_0, function(arg_11_0, arg_11_1, arg_11_2)
				if arg_11_0 == 1 then
					global_ShowBlockWords(L_BUY_TIMES_SUCCESS)

					self.ai_attack_times = arg_11_2

					self:updateAIAttackTimes(arg_11_2)
				elseif arg_11_0 == 2 then
					global_ShowBlockWords(L_DIAMOND_LACK)
				elseif arg_11_0 == 3 then
					global_ShowBlockWords(L_BUY_TIMES_LIMITED)
				end

				if var_8_1 then
					var_8_1()
				end
			end)
		end

		level_manager:getBuyAdventureDailyTimeInfo(var_8_0, function(arg_12_0, arg_12_1, arg_12_2)
			if arg_12_0 == 1 then
				LayerManager:pushInLayer("PopDoLayer", {
					costtype = "diamond",
					surecallback = var_8_2,
					cancelcallback = function()
						if var_8_1 then
							var_8_1()
						end
					end,
					cost = arg_12_1,
					own = playermodel.diamond,
					labels = {
						titleImage = "title_more_adventure_times.png",
						button = L_BUY_TIMES_MSG.button,
						des = string.format(L_BUY_TIMES_MSG.des, arg_12_1),
						more = string.format(L_BUY_TIMES_MSG.more, arg_12_1)
					}
				})
			else
				global_ShowBlockWords(L_BUY_TIMES_LIMITED)

				if var_8_1 then
					var_8_1()
				end
			end
		end)
	end)
	self.add_kuozhan:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_14_0:isBright() then
			return
		end

		arg_14_0:setBright(false)

		local var_14_0 = var_0_14[aiattack_manager:get_levelmode_id()].modetype

		local function var_14_1()
			arg_14_0:setBright(true)
		end

		local function var_14_2()
			level_manager:buyAdventureDailyTime(var_14_0, function(arg_17_0, arg_17_1, arg_17_2)
				if arg_17_0 == 1 then
					global_ShowBlockWords(L_BUY_TIMES_SUCCESS)

					self.ai_attack_times = arg_17_2

					self:updateAIAttackTimes(arg_17_2)
				elseif arg_17_0 == 2 then
					global_ShowBlockWords(L_DIAMOND_LACK)
				elseif arg_17_0 == 3 then
					global_ShowBlockWords(L_BUY_TIMES_LIMITED)
				end

				if var_14_1 then
					var_14_1()
				end
			end)
		end

		level_manager:getBuyAdventureDailyTimeInfo(var_14_0, function(arg_18_0, arg_18_1, arg_18_2)
			if arg_18_0 == 1 then
				LayerManager:pushInLayer("PopDoLayer", {
					costtype = "diamond",
					surecallback = var_14_2,
					cancelcallback = function()
						if var_14_1 then
							var_14_1()
						end
					end,
					cost = arg_18_1,
					own = playermodel.diamond,
					labels = {
						titleImage = "title_more_adventure_times.png",
						button = L_BUY_TIMES_MSG.button,
						des = string.format(L_BUY_TIMES_MSG.des, arg_18_1),
						more = string.format(L_BUY_TIMES_MSG.more, arg_18_1)
					}
				})
			else
				global_ShowBlockWords(L_BUY_TIMES_LIMITED)

				if var_14_1 then
					var_14_1()
				end
			end
		end)
	end)
	self.ai_create_btn:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AITwistLayer", {
			returnLayer = "DoubleHoliday_WoldCityLayer_2"
		})
	end)
	self.shop_btn:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_21_0 = cc.EventCustom:new("switchShowLayer")

		var_21_0.layerName = "MarketLayer"
		var_21_0.initparam = {
			showType = "1-26",
			returnLayer = "DoubleHoliday_WoldCityLayer_2",
			singleMarket = {
				"1-26",
				"1-25",
				"1-24",
				"1-27"
			}
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_21_0)
	end)
	self.vir_add:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_15)
	end)
	self.title_yinzi:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_15)
	end)
	self:initBottomBtnList()
	self:initUI()
	self:fullScreen()
	self:initAIAttackTimes()
	self:registerScriptHandler(function(arg_24_0)
		if arg_24_0 == "exit" then
			var_0_9 = nil

			if self.callback then
				self.callback()
			end

			activity_manager:releaseEventListenerByName("DoubleHoliday_WoldCityLayer_2")
		end
	end)
end

function DoubleHoliday_WoldCityLayer_2:updateTecNumber()
	ccui.Helper:seekWidgetByName(self.title, "Label_25"):setString(global_trans_number(item_manager:getItemNumber(var_0_20[2])))
end

function DoubleHoliday_WoldCityLayer_2:initAIAttackTimes()
	self.btn_explore:setVisible(false)
	self.btn_explore:setOpacity(0)
	level_manager:getAdventureDailytimeByModeType(var_0_14[aiattack_manager:get_levelmode_id()].modetype, function(arg_27_0, arg_27_1)
		if arg_27_0 == 1 then
			self.ai_attack_times = arg_27_1

			self:updateAIAttackTimes()
			self.btn_explore:runAction(cc.Sequence:create(cc.Show:create(), cc.FadeIn:create(0.5)))
		end
	end)
end

function DoubleHoliday_WoldCityLayer_2:updateAIAttackTimes()
	self.btn_addnum:getChildByName("Label_241"):setString(self.ai_attack_times .. "/" .. var_0_14[aiattack_manager:get_levelmode_id()].dailytime)
end

function DoubleHoliday_WoldCityLayer_2:initUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_24"):setString(global_trans_number(item_manager:getItemNumber(var_0_20[1])))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_25"):setString(global_trans_number(item_manager:getItemNumber(var_0_20[2])))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_26"):setString(global_trans_number(item_manager:getItemNumber(var_0_20[3])))
	self.label_guaji:setString("")
	ccui.Helper:seekWidgetByName(self.panel_mr, "Label_31"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_15)
	self.panel_explore:setLocalZOrder(11)

	local var_29_0 = ccui.Layout:create()

	var_29_0:setContentSize(cc.size(640, GameDisplay.getScreenSize().height))
	var_29_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_29_0:setAnchorPoint(0, 0)
	var_29_0:setBackGroundColor(cc.c3b(12, 11, 31))
	var_29_0:setOpacity(170)
	var_29_0:setTouchEnabled(true)
	var_29_0:setVisible(true)
	var_29_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_29_0:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)
	self.rootLayer:addChild(var_29_0, 10)

	for iter_29_0 = 2, 8 do
		local var_29_1 = ccui.Helper:seekWidgetByName(self.panel_city, "city_" .. iter_29_0 - 1)
		local var_29_2 = cc.Label:createWithTTF(glabal_trans_text_horizontal_to_vertical(activity_plague_city_data[iter_29_0].name), "fonts/name.ttf", 20)

		var_29_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_29_2:setPosition(cc.p(var_29_1:getContentSize().width / 2 - 70, var_29_1:getContentSize().height / 2))
		var_29_2:setName("name_node")
		var_29_1:addChild(var_29_2, 100)
		var_29_1:loadTextures("Activity_doubleholiday/yiguanbi.png", nil, "Activity_doubleholiday/yiguanbi.png", var_0_22)
		var_29_1:addTouchEventListener(function(arg_31_0, arg_31_1)
			global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_15)
		end)
	end
end

function DoubleHoliday_WoldCityLayer_2:initBottomBtnList()
	self.bottomlist = BottomBtnList:create(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()

		if callback then
			callback()
		end
	end, {})

	self:addChild(self.bottomlist, 5)
	self:initBottomAddPanel()
end

function DoubleHoliday_WoldCityLayer_2:initBottomAddPanel()
	local var_34_0 = ccui.Layout:create()

	var_34_0:setPosition(cc.p(320, 30))
	var_34_0:setName("bottomAddPanel")
	self.bottomlist:addChild(var_34_0)

	local var_34_1 = ccui.Button:create(var_0_21[1], nil, var_0_21[1], var_0_22)

	var_34_1:setPosition(cc.p(-60, 0))
	var_34_0:addChild(var_34_1)

	self.btn_finalrank = var_34_1

	local var_34_2 = ccui.Button:create(var_0_21[2], nil, var_0_21[2], var_0_22)

	var_34_2:setPosition(cc.p(self.btn_finalrank:getPositionX() + self.btn_finalrank:getContentSize().width + 20, 0))
	var_34_0:addChild(var_34_2)

	self.btn_aicard = var_34_2

	local var_34_3 = ccui.Button:create(var_0_21[3], nil, var_0_21[3], var_0_22)

	var_34_3:setPosition(cc.p(self.btn_aicard:getPositionX() + self.btn_aicard:getContentSize().width + 20, 0))
	var_34_0:addChild(var_34_3)

	self.btn_virsicene = var_34_3

	self.btn_aicard:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("BagLayer", {
			bagType = 19,
			returnLayer = "DoubleHoliday_WoldCityLayer_2",
			createType = 1
		})
	end)
	self.btn_virsicene:addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_15)
	end)
	self.btn_virsicene:getVirtualRenderer():setOpacity(70)
	self.btn_finalrank:getVirtualRenderer():setOpacity(70)
	self.btn_finalrank:addTouchEventListener(function(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_15)
	end)
end

function DoubleHoliday_WoldCityLayer_2:fullScreen()
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
	self.panel_ml:setPositionY(self.panel_ml:getPositionY() + GameDisplay.fix_y)
	self.panel_mr:setPositionY(self.panel_mr:getPositionY() + GameDisplay.fix_y)
	self.panel_explore:setPositionY(self.panel_explore:getPositionY() - GameDisplay.fix_y)

	self.bottomlist.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomlist:setPositionY(self.bottomlist.full_posY)
end

function DoubleHoliday_WoldCityLayer_2:createTimeLable()
	local var_39_0 = ccui.ImageView:create("Activity_doubleholiday/time_end.png", var_0_22)

	var_39_0:setPosition(cc.p(self.btn_broadcast:getPositionX(), self.btn_broadcast:getPositionY() - self.btn_broadcast:getContentSize().height / 2 - 30))
	self.panel_mr:addChild(var_39_0, 10)

	local var_39_1 = cc.Label:createWithTTF(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_15, "fonts/name.ttf", 18)

	var_39_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_39_1:setPosition(cc.p(var_39_0:getContentSize().width / 2, var_39_0:getContentSize().height / 2))
	var_39_0:addChild(var_39_1)

	self.surplusTime = var_39_1
end
