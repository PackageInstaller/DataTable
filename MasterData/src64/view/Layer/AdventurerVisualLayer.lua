AdventurerVisualLayer = class("AdventurerVisualLayer", function()
	return cc.Layer:create()
end)

local var_0_1 = config._DEBUG and 0 or 1

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")

local monster_manager = require("controller.monster_manager")
local time_check_manager = require("controller.time_check_manager")
local levelmode_data = require("data.levelmode_data")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local activity_conf_data = require("data.activity_conf_data")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local var_0_11 = 115
local var_0_12 = 20
local var_0_13 = "2020-08-01 00:00:00"
local var_0_14 = {
	"adventure_score/item_1.png",
	"adventure_score/item_2.png",
	"adventure_score/item_3.png"
}
local var_0_15 = {
	off = "adventure_score/btn_award.png",
	on = "adventure_score/btn_award.png"
}
local var_0_16

local function var_0_17(arg_2_0)
	if arg_2_0 >= 86400 then
		return string.format("%02d天%02d小时", math.floor(arg_2_0 / 86400), math.floor(arg_2_0 % 86400 / 3600))
	elseif arg_2_0 >= 3600 then
		return string.format("%02d小时%02d分钟", math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60))
	else
		return string.format("%02d分钟%02d秒", math.floor(arg_2_0 / 60), math.floor(arg_2_0 % 60))
	end
end

function AdventurerVisualLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = AdventurerVisualLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function AdventurerVisualLayer:init(arg_4_1)
	var_0_16 = self

	if arg_4_1 then
		self.returnbacklayer = arg_4_1.returnbacklayer or "ActivityLayer_AvalonEnterLayer"
	end

	self.isStory = arg_4_1 and arg_4_1.isStory
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventurerVisualLayer.json" or "AdventurerVisualLayer.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setBackGroundColorOpacity(0)

	self.title_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "img_title")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.Listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_59")
	self.info1 = ccui.Helper:seekWidgetByName(self.title_panel, "Button_18")
	self.info2 = ccui.Helper:seekWidgetByName(self.title_panel, "Button_19")
	self.scorepanel = ccui.Helper:seekWidgetByName(self.title_panel, "Image_14")
	self.btn_rank = ccui.Helper:seekWidgetByName(self.scorepanel, "btn_rank")
	self.score_label = ccui.Helper:seekWidgetByName(self.scorepanel, "Label_15")

	ccui.Helper:seekWidgetByName(self.title_panel, "Label_20"):setString("")
	ccui.Helper:seekWidgetByName(self.title_panel, "Label_20"):setPositionX(91)

	self.modetype = 1151

	self.Listview:setBackGroundColor(cc.c4b(255, 205, 66, 255))
	self:initBottomList()
	self:initTileLayer()
	self:getListData()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_16 = nil

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
end

function AdventurerVisualLayer.checkIsTime(arg_6_0)
	if not activity_conf_data[var_0_11] then
		return false
	end

	local var_6_1 = time_check_manager:getCurTime()
	local var_6_2 = true

	if var_6_1 >= global_get_time_by_date(var_0_13) and var_6_1 <= global_get_time_by_date(activity_conf_data[var_0_11].finishtime) then
		var_6_2 = true
	elseif var_6_1 < global_get_time_by_date(var_0_13) then
		global_ShowBlockWords("虚拟试炼将于2020-8-1开启")

		var_6_2 = false
	elseif var_6_1 > global_get_time_by_date(activity_conf_data[var_0_11].finishtime) then
		var_6_2 = true
	end

	return var_6_2
end

function AdventurerVisualLayer:initTileLayer()
	local function var_7_0(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_8_0:getTouchBeganPosition().y - arg_8_0:getTouchEndPosition().y) > 50 then
			return
		end

		local var_8_0 = {
			callback = callback
		}

		var_8_0.key = "activity_awl_adverture"

		if not require("data.detail_data")[var_8_0.key] then
			print("error:----------------> detail_data.lua is no data for this layer  找策划填写规则表")
		else
			LayerManager:pushInLayer("PopActivityDetail", var_8_0)
		end
	end

	self.info1:addTouchEventListener(var_7_0)
	self.info2:addTouchEventListener(var_7_0)
	self.btn_rank:setPosition(cc.p(345, 20))
	self.btn_rank:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AdventureRankingPanel", {
			modetype = self.modetype
		})
	end)
	self:updateTimeLable()
end

function AdventurerVisualLayer:updateTotalScore()
	self.score_label:setString((self.totalscore or nil) and "" .. global_trans_number(self.totalscore))
end

function AdventurerVisualLayer:updateTimeLable()
	if self.isStory then
		ccui.Helper:seekWidgetByName(self.title_panel, "Label_20"):setString("")

		return
	end

	local var_11_0 = ccui.Helper:seekWidgetByName(self.title_panel, "Label_20")

	if not activity_conf_data[var_0_11] then
		var_11_0:setString("活动未开始")

		return
	end

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date(activity_conf_data[var_0_11].finishtime) - time_check_manager:getCurTime(), function(arg_12_0)
		var_11_0:setString("活动倒计时:" .. var_0_17(arg_12_0))

		if arg_12_0 <= 0 and self.activityScheduler then
			var_11_0:setString("活动已结束")
		end
	end)))
end

function AdventurerVisualLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self:addChild(self.bottomList, 10)

	self.award = ccui.Button:create(var_0_15.on, nil, var_0_15.on, var_0_1)

	self.award:setVisible(not self.isStory and true or false)
	self.bottomList:addChild(self.award, 100)
	self.award:setPosition(self.bottomList:getContentSize().width - self.award:getContentSize().width / 2, self.bottomList:getContentSize().height / 2)

	local function var_13_0()
		local var_15_0 = cc.UserDefault:getInstance():getIntegerForKey("AdventurerVisualtime", 0)
		local var_15_1 = time_check_manager:getCurTime()

		if var_15_0 and var_15_1 < var_15_0 then
			return
		end

		local var_15_2 = os.date("*t", var_15_1)

		cc.UserDefault:getInstance():setIntegerForKey("AdventurerVisualtime", (os.time({
			hour = 23,
			min = 59,
			sec = 59,
			year = var_15_2.year,
			month = var_15_2.month,
			day = var_15_2.day
		})))
	end

	self.award:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if cc.UserDefault:getInstance():getBoolForKey("AdventurerVisualred", false) then
			var_13_0()
			cc.UserDefault:getInstance():setBoolForKey("AdventurerVisualred", false)
		end

		self:addRedot()
		LayerManager:pushInLayer("PopVisualAdventureChapter", {
			modetype = self.modetype,
			callback = function(arg_17_0)
				if var_0_16 then
					-- block empty
				end
			end
		})
	end)
end

function AdventurerVisualLayer:initUILayer()
	self:initListView()
	self:updateTotalScore()
end

function AdventurerVisualLayer:initListView()
	self.Listview:removeAllChildren()
	self.Listview:setItemsMargin(var_0_12)

	if not self.data then
		print("error:----------------------------> no data can use！！！！！")
	end

	for iter_19_0, iter_19_1 in ipairs(self.data) do
		local var_19_0 = self.items:clone()

		self:updateNode(var_19_0, iter_19_0, iter_19_1)
		self.Listview:pushBackCustomItem(var_19_0)
	end
end

function AdventurerVisualLayer.updateNode(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = ccui.Helper:seekWidgetByName(arg_20_1, "bossface")
	local var_20_1 = ccui.Helper:seekWidgetByName(arg_20_1, "ceshu")
	local var_20_2 = ccui.Helper:seekWidgetByName(arg_20_1, "bossname")
	local var_20_3 = ccui.Helper:seekWidgetByName(arg_20_1, "change_btn")

	arg_20_1:setBackGroundImage(var_0_14[arg_20_2], var_0_1)
	ccui.Helper:seekWidgetByName(arg_20_1, "Label_58"):setString(arg_20_3.name)

	if arg_20_3.score then
		var_20_1:setString(arg_20_3.score)
	else
		var_20_1:setString("")
	end

	var_20_3:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_20_0:checkIsTime() then
			RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", arg_20_0.modetype)
			LayerManager:pushInLayer("AdventureNewDetailLayer", {
				isvisual = 1,
				data = levelmode_data[arg_20_3.mode],
				score = arg_20_3.score
			})
		end
	end)

	for iter_20_0 = 1, 3 do
		local var_20_4 = arg_20_1:getChildByName("img_" .. iter_20_0)

		var_20_4:setCascadeOpacityEnabled(false)

		if var_20_4:getChildByName("awarditem") then
			var_20_4:getChildByName("awarditem"):removeFromParent()
		end
	end

	local var_20_5 = 1

	while arg_20_3["show_item" .. var_20_5] do
		local var_20_6 = arg_20_1:getChildByName("img_" .. var_20_5)
		local var_20_7 = arg_20_3["show_item" .. var_20_5]
		local var_20_9 = type(arg_20_3["show_item" .. var_20_5]) == "string" and ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_1) or ccui.Button:create("public/box/" .. item_data[var_20_7].equip_quality .. ".png", "public/box/" .. item_data[var_20_7].equip_quality .. ".png", nil, var_0_1)

		var_20_9:setAnchorPoint(cc.p(0.5, 0.5))
		var_20_9:setPosition(cc.p(0, 0))
		var_20_9:setTouchEnabled(false)
		var_20_9:setSwallowTouches(false)
		var_20_9:setPosition(cc.p(var_20_6:getContentSize().width / 2, var_20_6:getContentSize().height / 2 + 4))
		var_20_9:setName("awarditem")
		var_20_6:addChild(var_20_9, 1)

		local var_20_10
		local var_20_11

		if item_data[var_20_7].image_id then
			var_20_10 = "equipment/" .. item_data[var_20_7].image_id .. ".png"
		else
			var_20_11 = item_data[var_20_7].bag_item_type == kITEM_MEDAL and ItemSprite:create_medal_icon(var_20_7) or componentManager:create_component_icon(var_20_7, nil, nil)
		end

		var_20_11 = var_20_11 or ccui.ImageView:create(var_20_10)

		var_20_11:setPosition(cc.p(var_20_9:getContentSize().width / 2, var_20_9:getContentSize().height / 2))
		var_20_11:setName("ItemSprite")
		var_20_11:setScale(80 / math.min(var_20_11:getContentSize().width, var_20_11:getContentSize().height))

		function var_20_11:afterLoadSuccess(...)
			self:setScale(80 / math.min(self:getContentSize().width, self:getContentSize().height))
		end

		var_20_9:addChild(var_20_11)

		var_20_5 = var_20_5 + 1
	end

	if arg_20_3.show_boss then
		var_20_0:loadTextures(CUTE_ROLE_IMAGE_PATH .. model_data[arg_20_3.show_boss].cute_role .. ".png", nil, CUTE_ROLE_IMAGE_PATH .. model_data[arg_20_3.show_boss].cute_role .. ".png")
		var_20_0:setVisible(true)
		var_20_0:setScale(0.36)
		var_20_2:setString(model_data[arg_20_3.show_boss].name)
	else
		var_20_0:setVisible(false)
		var_20_2:setString("")
	end
end

function AdventurerVisualLayer:getListData()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(levelmode_data) do
		if iter_23_1.modetype == self.modetype then
			table.insert(var_23_0, iter_23_1)
		end
	end

	self:updateListData(var_23_0)
	level_manager:is_have_adventure_awards(nil, self.modetype, function(arg_24_0)
		self.haveaward = arg_24_0.result == 1 and not not (arg_24_0.canexchangescore and arg_24_0.canexchangescore > 0 and arg_24_0.items and next(arg_24_0.items)) or false

		if self.haveaward then
			local var_24_0 = cc.UserDefault:getInstance():getIntegerForKey("AdventurerVisualtime", 0)

			if var_24_0 and time_check_manager:getCurTime() < var_24_0 then
				-- block empty
			else
				cc.UserDefault:getInstance():setBoolForKey("AdventurerVisualred", true)
			end
		end

		self:addRedot()
	end)
end

function AdventurerVisualLayer.updateAwardBtnStatus(arg_25_0)
	return
end

function AdventurerVisualLayer.updateAwardStatus(arg_26_0, arg_26_1)
	if arg_26_1 then
		arg_26_0.haveaward = false
	end
end

function AdventurerVisualLayer:updateListData(arg_27_1)
	level_manager:get_adventure_score(nil, self.modetype, function(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
		if arg_28_0 == 1 then
			self.totalscore = arg_28_1

			for iter_28_0, iter_28_1 in pairs(arg_28_2) do
				for iter_28_2, iter_28_3 in pairs(arg_27_1) do
					if iter_28_3.mode == iter_28_1.mode then
						iter_28_3.score = iter_28_1.score

						break
					end
				end
			end

			self.data = arg_27_1

			self:initUILayer()
		end
	end)
end

function AdventurerVisualLayer:addRedot(arg_29_1)
	if cc.UserDefault:getInstance():getBoolForKey("AdventurerVisualred", false) then
		global_add_alert_tag(self.award, {
			x = 170,
			y = 70
		})
	else
		global_remove_alert_tag(self.award)
	end
end

function AdventurerVisualLayer:fullScreen(arg_30_1)
	arg_30_1:setContentSize((GameDisplay.getScreenSize()))
	arg_30_1:setPositionY(arg_30_1:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.title_panel:setPositionY(self.title_panel:getPositionY() + 2 * GameDisplay.fix_y)
	self.Listview:setContentSize(cc.size(640, 640 + 2 * GameDisplay.fix_y))
end
