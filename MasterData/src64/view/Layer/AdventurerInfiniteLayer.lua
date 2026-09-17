AdventurerInfiniteLayer = class("AdventurerInfiniteLayer", function()
	return cc.Layer:create()
end)

local var_0_1 = config._DEBUG and 0 or 1

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Sprite.ItemSprite")

local monster_manager = require("controller.monster_manager")
local time_check_manager = require("controller.time_check_manager")
local levelmode_data = require("data.levelmode_data")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local activity_conf_data = require("data.activity_conf_data")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local drop_data = require("data.drop_data")
local var_0_12 = 599
local var_0_13 = "awardmodetype_5993_"
local lua = require("data.adventure_score_awards.adventure_score_awards_5993.lua")
local var_0_15 = 20
local var_0_16 = 5993
local var_0_17 = {
	photofile_nightmare_xmasfile_data = "file_nightmare_xmasfile",
	photofile_ai3_data = "file_enemy4",
	photofile_ai1_data = "file_enemy2",
	photofile_data = "file_player",
	photofile_foundationai_data = "file_enemy9",
	photofile_foundation_data = "file_enemy8",
	photofile_ai2_data = "file_enemy3",
	photofile_activity_data = "file_enemy12",
	photofile_military_data = "file_enemy6",
	photofile_talk_level_data = "photofile_talk_level_data",
	photofile_militaryai_data = "file_enemy7",
	photofile_killer_data = "file_enemy10",
	photofile_ai4_data = "file_enemy5",
	photofile_ai5_data = "file_enemy_ai5",
	photofile_xmasfile_data = "file_enemy1",
	photofile_activityai_data = "file_enemy11"
}
local var_0_18 = (function()
	if not lua or not next(lua) then
		return 0
	end

	local var_2_0 = 1

	while lua[var_0_13 .. var_2_0] do
		var_2_0 = var_2_0 + 1
	end

	return var_2_0 - 1
end)()
local var_0_19 = "adventure_infinite/inif_diban.png"
local var_0_20 = {
	"adventure_infinite/row_no.png",
	"adventure_infinite/row_get.png",
	"adventure_infinite/progress_di.png",
	"adventure_infinite/progress.png"
}
local var_0_21 = "adventure_infinite/inif_rank.png"
local var_0_22

local function var_0_23(arg_3_0)
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

function AdventurerInfiniteLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = AdventurerInfiniteLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function AdventurerInfiniteLayer:init(arg_5_1)
	var_0_22 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventurerInfiniteLayer.json" or "AdventurerInfiniteLayer.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setBackGroundColorOpacity(0)

	self.title_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "img_title")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.items1 = ccui.Helper:seekWidgetByName(self.rootLayer, "items2")
	self.Listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_59")
	self.awardpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "img_award")
	self.info1 = ccui.Helper:seekWidgetByName(self.title_panel, "Button_24")
	self.score_label = ccui.Helper:seekWidgetByName(self.awardpanel, "Label_67")
	self.Listview1 = ccui.Helper:seekWidgetByName(self.awardpanel, "ListView_30")
	self.btnup = ccui.Helper:seekWidgetByName(self.awardpanel, "upbtn")

	ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setString("")
	ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setVisible(false)
	self.score_label:setString("")
	self.score_label:setFontSize(22)
	self.score_label:setPosition(45, 120)
	self.score_label:setColor(cc.c3b(0, 0, 0))
	self.btnup:setPositionX(150)
	self.btnup:setVisible(false)
	self.info1:setPositionY(80)

	self.modetype = var_0_16
	self.totalscore = 0
	self.gethaveaward = {}

	self.Listview:setBackGroundColor(cc.c4b(255, 205, 66, 255))
	self:initBottomList()
	self:initTileLayer()
	self:getListData()
	self:registerTimeCheckEvent()
	self.btnup:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_6_0(arg_7_0, arg_7_1)
			if arg_7_0 == 1 then
				LayerManager:pushInLayer("PopAdventureInfiniteUpLayer", {
					uplist = arg_7_1
				})
			end
		end

		local var_6_1 = self:getTheModeByModetype(var_0_16)

		if var_6_1 then
			level_manager:get_infinite_score_up_list(var_6_1, var_6_0)
		else
			print("error..error....error..error:-------> no data  找策划填表！！！！！！！！！！！")
		end
	end)
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			var_0_22 = nil

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
end

function AdventurerInfiniteLayer.getTheModeByModetype(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return false
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(levelmode_data) do
		if iter_9_1.modetype == arg_9_1 then
			table.insert(var_9_0, iter_9_1)
		end
	end

	if next(var_9_0) and var_9_0[1].mode then
		return var_9_0[1].mode
	else
		return false
	end
end

function AdventurerInfiniteLayer:initTileLayer()
	self.info1:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_11_0:getTouchBeganPosition().y - arg_11_0:getTouchEndPosition().y) > 50 then
			return
		end

		local var_11_0 = {
			callback = callback
		}

		var_11_0.key = "activity_infinite_adverture"

		if not require("data.detail_data")[var_11_0.key] then
			print("error:----------------> detail_data.lua is no data for this layer  找策划填写规则表：键值为：" .. var_11_0.key)
		else
			LayerManager:pushInLayer("PopActivityDetail", var_11_0)
		end
	end)
	self:updateTimeLable()
end

function AdventurerInfiniteLayer:updateBtnStatus()
	if not self.awards or not next(self.awards) then
		return
	end

	if not self.selectindex then
		for iter_12_0, iter_12_1 in ipairs(self.awards) do
			ccui.Helper:seekWidgetByName(iter_12_1, "Image_34"):setVisible(false)
		end
	else
		for iter_12_2, iter_12_3 in ipairs(self.awards) do
			if iter_12_2 == self.selectindex then
				ccui.Helper:seekWidgetByName(iter_12_3, "Image_34"):setVisible(true)
			else
				ccui.Helper:seekWidgetByName(iter_12_3, "Image_34"):setVisible(false)
			end
		end
	end
end

function AdventurerInfiniteLayer.checkIsTime(arg_13_0, arg_13_1)
	local var_13_0 = true

	if not arg_13_1 then
		return var_13_0
	end

	if global_get_time_by_date(arg_13_1) > time_check_manager:getCurTime() then
		var_13_0 = false
	end

	return var_13_0
end

function AdventurerInfiniteLayer:updateTotalScore()
	self.score_label:setString((self.totalscore or nil) and "" .. global_trans_number(self.totalscore))
end

function AdventurerInfiniteLayer:updateTimeLable()
	local var_15_0 = ccui.Helper:seekWidgetByName(self.title_panel, "Label_27")

	if not activity_conf_data[var_0_12] then
		var_15_0:setString(L_LAMIYA_CHAPTER.activity_no_open)

		return
	end

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date(activity_conf_data[var_0_12].finishtime) - time_check_manager:getCurTime(), function(arg_16_0)
		var_15_0:setString(L_AVAON_VISUAL.jishi .. var_0_23(arg_16_0))

		if arg_16_0 <= 0 and self.activityScheduler then
			var_15_0:setString(L_ACTIVITY_END)
		end
	end)))
end

function AdventurerInfiniteLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, nil, "adventure_infinite/inf_dibian.png", {
		img = "adventure_infinite/inif_back.png",
		pos = cc.p(45, 30)
	})

	self:addChild(self.bottomList, 1000)

	self.rankbtn = ccui.Button:create(var_0_21, nil, var_0_21, var_0_1)

	self.rankbtn:setPosition(cc.p(self.bottomList:getContentSize().width - self.rankbtn:getContentSize().width / 2, self.bottomList:getContentSize().height / 2))
	self.bottomList:addChild(self.rankbtn)
	self.rankbtn:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AdventureInfiniteRankLayer", {
			modetype = var_0_16,
			score = self.totalscore,
			rank = self.rank
		})
	end)
end

function AdventurerInfiniteLayer:initUILayer()
	self:initListView()
	self:updateTotalScore()
	self:initAwardPanel()
end

function AdventurerInfiniteLayer:initListView()
	self.Listview:removeAllChildren()
	self.Listview:setItemsMargin(var_0_15)

	if not self.data then
		print("error:----------------------------> no data can use！！！！！")
	end

	for iter_21_0, iter_21_1 in ipairs(self.data) do
		local var_21_0 = self.items:clone()

		self:updateNode(var_21_0, iter_21_0, iter_21_1)

		var_21_0.step = iter_21_0

		self.Listview:pushBackCustomItem(var_21_0)
	end
end

function AdventurerInfiniteLayer:updateNode(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = ccui.Helper:seekWidgetByName(arg_22_1, "bossface")
	local var_22_1 = ccui.Helper:seekWidgetByName(arg_22_1, "ceshu")
	local var_22_2 = ccui.Helper:seekWidgetByName(arg_22_1, "bossname")
	local var_22_3 = ccui.Helper:seekWidgetByName(arg_22_1, "Label_58")
	local var_22_4 = ccui.Helper:seekWidgetByName(arg_22_1, "change_btn")
	local var_22_5 = ccui.Helper:seekWidgetByName(arg_22_1, "info")
	local var_22_6 = ccui.Helper:seekWidgetByName(arg_22_1, "Image_32")
	local var_22_7 = ccui.Helper:seekWidgetByName(var_22_6, "Label_34")

	var_22_0:setTouchEnabled(true)
	ccui.Helper:seekWidgetByName(arg_22_1, "detail_btn"):setTouchEnabled(false)
	ccui.Helper:seekWidgetByName(arg_22_1, "Image_26"):setVisible(false)
	var_22_0:setPosition(111, 105)
	var_22_1:setPosition(421, 155)
	var_22_1:setColor(cc.c3b(0, 0, 0))
	var_22_5:setFontSize(18)
	var_22_5:getVirtualRenderer():setMaxLineWidth(260)
	var_22_5:setPositionX(190)
	arg_22_1:setBackGroundImage(var_0_19, var_0_1)
	var_22_3:setString(arg_22_3.name)
	var_22_3:setColor(cc.c3b(225, 137, 99))
	var_22_3:setPosition(220, 140)

	if arg_22_3.score then
		var_22_1:setString("最高得分：" .. arg_22_3.score)
	else
		var_22_1:setString("最高得分：")
	end

	var_22_1:setColor(cc.c3b(255, 255, 255))

	if arg_22_3.bossinfo then
		var_22_5:setString(arg_22_3.bossinfo)
	else
		var_22_5:setString("")
	end

	var_22_4:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", self.modetype)
		LayerManager:pushInLayer("AdventureNewDetailLayer", {
			isinfinite = 1,
			data = levelmode_data[arg_22_3.mode],
			score = arg_22_3.score
		})
	end)

	if arg_22_3.show_boss then
		var_22_0:loadTextures(CUTE_ROLE_IMAGE_PATH .. model_data[arg_22_3.show_boss].cute_role .. ".png", nil, CUTE_ROLE_IMAGE_PATH .. model_data[arg_22_3.show_boss].cute_role .. ".png")
		var_22_0:setVisible(true)
		var_22_0:setScaleX(200 / var_22_0:getContentSize().width)
		var_22_0:setScaleY(200 / var_22_0:getContentSize().height)

		function var_22_0:afterLoadSuccess(...)
			self:setScaleX(200 / self:getContentSize().width)
			self:setScaleY(200 / self:getContentSize().height)
		end

		var_22_2:setString(model_data[arg_22_3.show_boss].name)
	else
		var_22_0:setVisible(false)
		var_22_2:setString("")
	end

	var_22_0:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_25_2 = {
			id = model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_model,
			modelid = levelmode_data[arg_22_3.mode].show_boss,
			contentType = {
				contentType = var_0_17[model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_type]
			},
			modelid = levelmode_data[arg_22_3.mode].show_boss
		}

		var_25_2.contentType = {
			contentType = var_0_17[model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_type]
		}
		var_25_2.id = model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_model

		if var_0_17[model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_type] == "file_player" or var_0_17[model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_type] == "file_enemy1" or var_0_17[model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_type] == "file_enemy6" or var_0_17[model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_type] == "file_enemy8" or var_0_17[model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_type] == "file_enemy10" or var_0_17[model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_type] == "file_enemy12" or var_0_17[model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_type] == "file_teacher" or var_0_17[model_data[levelmode_data[arg_22_3.mode].show_boss].photofile_type] == "file_nightmare_xmasfile" then
			LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_25_2)
		else
			LayerManager:pushInLayer("PhotoFileHelpGirlLayer", var_25_2)
		end
	end)

	if self:checkIsTime(arg_22_3.starttime) then
		var_22_6:setVisible(false)
	else
		var_22_6:setVisible(true)
		var_22_6:setTouchEnabled(true)

		local var_22_8 = self:dealString(arg_22_3.starttime)

		var_22_7:setString(var_22_8)
		var_22_6:addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(var_22_8)
		end)
	end
end

function AdventurerInfiniteLayer.dealString(arg_27_0, arg_27_1)
	if not arg_27_1 then
		return ""
	end

	local var_27_0 = os.date("*t", math.floor((global_get_time_by_date(arg_27_1))))

	return (string.format(L_AVAON_VISUAL.tips_3, var_27_0.year, var_27_0.month, var_27_0.day))
end

function AdventurerInfiniteLayer:initAwardPanel()
	self.Listview1:setClippingEnabled(true)
	self.Listview1:removeAllChildren()
	self.Listview1:setItemsMargin(0)

	self.awards = {}

	if not lua or not next(lua) then
		return
	end

	local var_28_0 = 1

	while lua[var_0_13 .. var_28_0] do
		local var_28_1 = self.items1:clone()

		self:updateAwardNode(var_28_1, var_28_0, lua[var_0_13 .. var_28_0])
		self.Listview1:pushBackCustomItem(var_28_1)
		table.insert(self.awards, var_28_1)

		var_28_1.step = var_28_0
		var_28_0 = var_28_0 + 1
	end

	self:updateBtnStatus()

	local var_28_2 = self:getCurScoreIndex()

	if var_28_2 <= 3 then
		-- block empty
	else
		local var_28_3 = (var_28_2 - 1) * (100 / (var_0_18 - self.Listview1:getContentSize().width / 107))

		if var_28_3 < 0 then
			var_28_3 = 0
		elseif var_28_3 > 100 then
			var_28_3 = 100
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			self.Listview1:scrollToPercentHorizontal(var_28_3, 0.5, false)
		end)))
	end

	self.awardpanel:setPositionY(150)
end

function AdventurerInfiniteLayer:updateAwardNode(arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = ccui.Helper:seekWidgetByName(arg_30_1, "ProgressBar_61")
	local var_30_1 = ccui.Helper:seekWidgetByName(arg_30_1, "img_row")
	local var_30_2 = ccui.Helper:seekWidgetByName(arg_30_1, "need_img_di")
	local var_30_3 = ccui.Helper:seekWidgetByName(var_30_2, "Label_64")
	local var_30_4 = ccui.Helper:seekWidgetByName(arg_30_1, "img_canget")
	local var_30_5 = ccui.Helper:seekWidgetByName(arg_30_1, "Image_65")
	local var_30_6 = ccui.Helper:seekWidgetByName(arg_30_1, "Image_68")
	local var_30_7 = ccui.Helper:seekWidgetByName(var_30_6, "Label_69")

	var_30_6:setVisible(false)
	ccui.Helper:seekWidgetByName(arg_30_1, "progress_di"):loadTexture(var_0_20[3], var_0_1)
	var_30_0:loadTexture(var_0_20[4], var_0_1)

	local var_30_8 = 0
	local var_30_9 = self:getCurScoreIndex()

	if arg_30_2 < var_30_9 then
		var_30_8 = 100
	elseif arg_30_2 == var_30_9 then
		var_30_8 = 100 * (self.totalscore / arg_30_3.score)
	elseif var_30_9 < arg_30_2 then
		var_30_8 = 0
	end

	var_30_0:setPercent(var_30_8)

	if var_30_8 == 100 then
		var_30_1:loadTexture(var_0_20[2], var_0_1)
		var_30_2:setVisible(false)
		var_30_3:setString("")
		var_30_4:setVisible(true)

		if self:isAwardHaveGet(arg_30_2) then
			var_30_3:setString(L_AVAON_VISUAL.have_get)
			var_30_4:setVisible(false)
			var_30_2:setVisible(true)
			var_30_5:setVisible(true)
		else
			var_30_5:setVisible(false)
		end
	else
		var_30_1:loadTexture(var_0_20[1], var_0_1)
		var_30_2:setVisible(true)
		var_30_4:setVisible(false)
		var_30_3:setString(string.format(L_AVAON_VISUAL.fen_lock, arg_30_3.score))
		var_30_5:setVisible(false)
	end

	local var_30_10 = self:getDropData(arg_30_3.dropid)
	local var_30_11
	local var_30_12 = 0

	if var_30_10.items and next(var_30_10.items) then
		var_30_11 = var_30_10.items[1].itemid
		var_30_12 = var_30_10.items[1].num
	elseif var_30_10.diamond and var_30_10.diamond > 0 then
		var_30_11 = "diamond"
		var_30_12 = var_30_10.diamond
	elseif var_30_10.gold then
		var_30_11 = "gold"
		var_30_12 = var_30_10.gold
	end

	local var_30_14

	if var_30_11 and var_30_12 then
		var_30_14 = type(var_30_11) == "string" and ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_1) or ccui.Button:create("public/box/" .. item_data[var_30_11].equip_quality .. ".png", "public/box/" .. item_data[var_30_11].equip_quality .. ".png", nil, var_0_1)

		var_30_14:setAnchorPoint(cc.p(0.5, 0.5))
		var_30_14:setPosition(cc.p(0, 0))
		var_30_14:setTouchEnabled(true)
		var_30_14:setSwallowTouches(false)
		var_30_14:setPosition(cc.p(arg_30_1:getContentSize().width / 2, arg_30_1:getContentSize().height / 2 + 8))
		var_30_14:setName("awarditem")
		arg_30_1:addChild(var_30_14, 2)
		var_30_6:setLocalZOrder(3)
		var_30_14:setScale9Enabled(true)
		var_30_14:setContentSize(cc.size(94, 124))

		local var_30_15
		local var_30_16

		if var_30_11 == "gold" then
			var_30_15 = "equipment/1000001.png"
		elseif var_30_11 == "diamond" then
			var_30_15 = "equipment/1000000.png"
		elseif item_data[var_30_11].bag_item_type == kITEM_MEDAL then
			var_30_16 = ItemSprite:create_medal_icon(var_30_11)
		elseif item_data[var_30_11].bag_item_type == kITEM_COMPONENT then
			var_30_16 = componentManager:create_component_icon(var_30_11, nil, nil)
		elseif item_data[var_30_11].image_id then
			var_30_15 = "equipment/" .. item_data[var_30_11].image_id .. ".png"
		end

		var_30_16 = var_30_16 or ccui.ImageView:create(var_30_15)

		var_30_16:setPosition(cc.p(var_30_14:getContentSize().width / 2, var_30_14:getContentSize().height / 2 + 3))
		var_30_16:setName("ItemSprite")
		var_30_16:setScale(90 / math.min(var_30_16:getContentSize().width, var_30_16:getContentSize().height))

		function var_30_16:afterLoadSuccess(...)
			self:setScale(90 / math.min(self:getContentSize().width, self:getContentSize().height))
		end

		var_30_14:addChild(var_30_16)

		var_30_14.step = arg_30_2
		var_30_14.itemid = var_30_11

		var_30_7:setString("x" .. var_30_12)
		var_30_6:setVisible(true)
		var_30_14:addTouchEventListener(function(arg_32_0, arg_32_1)
			if arg_32_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectindex = arg_32_0.step

			self:updateBtnStatus()

			if self.totalscore and self.totalscore >= arg_30_3.score and not self:isAwardHaveGet(arg_32_0.step) then
				self:dealGetAward(arg_32_0.step)
			else
				self:showItemDeatil(arg_32_0)
			end
		end)
	end
end

function AdventurerInfiniteLayer:showItemDeatil(arg_33_1)
	if type(arg_33_1.itemid) == "string" then
		return
	end

	local var_33_0 = item_data[arg_33_1.itemid].bag_item_type

	if item_data[arg_33_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_33_1 = -1
		local var_33_2 = require("data.item_data")[arg_33_1.itemid].horcruxtype

		for iter_33_0, iter_33_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_33_1.itemid == iter_33_1.item_id then
				var_33_1 = iter_33_0

				break
			end
		end

		if var_33_1 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_33_1,
			itemid = arg_33_1.itemid
		})
	elseif var_33_0 == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_33_1.itemid].servant
		})
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_33_3 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_33_1.itemid
		})
	end
end

function AdventurerInfiniteLayer:isAwardHaveGet(arg_34_1)
	if not arg_34_1 or not self.gethaveaward or not next(self.gethaveaward) then
		return false
	end

	local var_34_0 = false

	for iter_34_0, iter_34_1 in pairs(self.gethaveaward) do
		if iter_34_1.rank == arg_34_1 and iter_34_1.havereceived then
			var_34_0 = true

			break
		end
	end

	return var_34_0
end

function AdventurerInfiniteLayer:getCurScoreIndex()
	if not lua or not next(lua) then
		return 1
	end

	local var_35_0 = var_0_18

	while lua[var_0_13 .. 1] do
		if self.totalscore <= lua[var_0_13 .. 1].score then
			var_35_0 = 1

			break
		end
	end

	return var_35_0
end

function AdventurerInfiniteLayer:updateAwardData(arg_36_1)
	if not arg_36_1 or not self.gethaveaward then
		return
	end

	if not self:isAwardHaveGet(arg_36_1) then
		table.insert(self.gethaveaward, {
			havereceived = true,
			rank = arg_36_1
		})
	else
		for iter_36_0, iter_36_1 in pairs(self.gethaveaward) do
			if iter_36_1.rank == arg_36_1 then
				iter_36_1.havereceived = true
			end
		end
	end
end

function AdventurerInfiniteLayer:dealGetAward(arg_37_1)
	level_manager:get_adventure_score_awards(nil, self.modetype, arg_37_1, function(arg_38_0)
		if arg_38_0.result == 1 then
			self:updateAwardData(arg_37_1)
			self:updateAwardNode(self.awards[arg_37_1], arg_37_1, lua[var_0_13 .. arg_37_1])
		else
			global_ShowBlockWords(L_AVAON_VISUAL.no_award)
		end
	end)
end

function AdventurerInfiniteLayer:getListData()
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(levelmode_data) do
		if iter_39_1.modetype == self.modetype then
			table.insert(var_39_0, iter_39_1)
		end
	end

	if next(var_39_0) then
		table.sort(var_39_0, function(arg_40_0, arg_40_1)
			return arg_40_0.order < arg_40_1.order
		end)
	end

	self:updateListData(var_39_0)
	level_manager:is_have_adventure_awards(nil, self.modetype, function(arg_41_0)
		if arg_41_0.result == 1 then
			self.gethaveaward = arg_41_0.awardlist

			self:addRedot()
		else
			self.gethaveaward = arg_41_0.awardlist

			self:addRedot()
		end

		self:initAwardPanel()
	end)
end

function AdventurerInfiniteLayer:updateListData(arg_42_1)
	level_manager:get_adventure_score(nil, self.modetype, function(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
		if arg_43_0 == 1 then
			self.totalscore = arg_43_1
			self.rank = arg_43_3

			for iter_43_0, iter_43_1 in pairs(arg_43_2) do
				for iter_43_2, iter_43_3 in pairs(arg_42_1) do
					if iter_43_3.mode == iter_43_1.mode then
						iter_43_3.score = iter_43_1.score

						break
					end
				end
			end

			self.data = arg_42_1

			level_manager:setinfiniteScoreInfo(arg_43_2)
			self:initUILayer()
		end
	end)
end

function AdventurerInfiniteLayer.addRedot(arg_44_0, arg_44_1)
	return
end

function AdventurerInfiniteLayer.getDropData(arg_45_0, arg_45_1)
	local var_45_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_45_1 = drop_data[arg_45_1] or {}

	if var_45_1.gold then
		var_45_0.gold = var_45_0.gold + var_45_1.gold
	end

	if var_45_1.diamond then
		var_45_0.diamond = var_45_0.diamond + var_45_1.diamond
	end

	local var_45_2 = 1

	if var_45_1["drop_id" .. 1] then
		local var_45_3 = 1

		while var_45_1["drop_id" .. var_45_3] do
			var_45_0.items[var_45_2] = {
				itemid = var_45_1["drop_id" .. var_45_3],
				num = var_45_1["drop_num" .. var_45_3],
				rate = var_45_1["drop_rate" .. var_45_3]
			}
			var_45_3 = var_45_3 + 1
			var_45_2 = var_45_2 + 1
		end
	end

	if var_45_1["dropmodel_id" .. 1] then
		local var_45_4 = 1

		while var_45_1["dropmodel_id" .. var_45_4] do
			if drop_data[var_45_1["dropmodel_id" .. var_45_4]].gold then
				var_45_0.gold = var_45_0.gold + drop_data[var_45_1["dropmodel_id" .. var_45_4]].gold
			end

			if drop_data[var_45_1["dropmodel_id" .. var_45_4]].diamond then
				var_45_0.diamond = var_45_0.diamond + drop_data[var_45_1["dropmodel_id" .. var_45_4]].diamond
			end

			if drop_data[var_45_1["dropmodel_id" .. var_45_4]]["drop_id" .. 1] then
				local var_45_5 = 1

				while drop_data[var_45_1["dropmodel_id" .. var_45_4]]["drop_id" .. var_45_5] do
					var_45_0.items[var_45_2] = {
						itemid = drop_data[var_45_1["dropmodel_id" .. var_45_4]]["drop_id" .. var_45_5],
						num = drop_data[var_45_1["dropmodel_id" .. var_45_4]]["drop_num" .. var_45_5]
					}
					var_45_5 = var_45_5 + 1
					var_45_2 = var_45_2 + 1
				end
			end

			if drop_data[var_45_1["dropmodel_id" .. var_45_4]]["rd_drop_id" .. 1] then
				local var_45_6 = 1

				while drop_data[var_45_1["dropmodel_id" .. var_45_4]]["rd_drop_id" .. var_45_6] do
					var_45_0.items[var_45_2] = {
						itemid = drop_data[var_45_1["dropmodel_id" .. var_45_4]]["rd_drop_id" .. var_45_6],
						num = drop_data[var_45_1["dropmodel_id" .. var_45_4]]["rd_drop_num" .. var_45_6]
					}
					var_45_6 = var_45_6 + 1
					var_45_2 = var_45_2 + 1
				end
			end

			var_45_4 = var_45_4 + 1
		end
	end

	if var_45_1["rd_drop_id" .. 1] then
		local var_45_7 = 1

		while var_45_1["rd_drop_id" .. var_45_7] do
			var_45_0.items[var_45_2] = {
				itemid = var_45_1["rd_drop_id" .. var_45_7],
				num = var_45_1["rd_drop_num" .. var_45_7]
			}
			var_45_7 = var_45_7 + 1
			var_45_2 = var_45_2 + 1
		end
	end

	if var_45_1["rd_dropmodel_id" .. 1] then
		local var_45_8 = 1

		while var_45_1["rd_dropmodel_id" .. var_45_8] do
			if drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]].gold then
				var_45_0.gold = var_45_0.gold + drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]].gold
			end

			if drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]].diamond then
				var_45_0.diamond = var_45_0.diamond + drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]].diamond
			end

			if drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["drop_id" .. 1] then
				local var_45_9 = 1

				while drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["drop_id" .. var_45_9] do
					var_45_0.items[var_45_2] = {
						itemid = drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["drop_id" .. var_45_9],
						num = drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["drop_num" .. var_45_9]
					}
					var_45_9 = var_45_9 + 1
					var_45_2 = var_45_2 + 1
				end
			end

			if drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["rd_drop_id" .. 1] then
				local var_45_10 = 1

				while drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["rd_drop_id" .. var_45_10] do
					var_45_0.items[var_45_2] = {
						itemid = drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["rd_drop_id" .. var_45_10],
						num = drop_data[var_45_1["rd_dropmodel_id" .. var_45_8]]["rd_drop_num" .. var_45_10]
					}
					var_45_10 = var_45_10 + 1
					var_45_2 = var_45_2 + 1
				end
			end

			var_45_8 = var_45_8 + 1
		end
	end

	return var_45_0
end

function AdventurerInfiniteLayer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_47_0)
		if arg_47_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				self:initListView()
			end)
		end
	end), self)
end

function AdventurerInfiniteLayer:fullScreen(arg_49_1)
	arg_49_1:setContentSize((GameDisplay.getScreenSize()))
	arg_49_1:setPositionY(arg_49_1:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.title_panel:setPositionY(self.title_panel:getPositionY() + 2 * GameDisplay.fix_y)
	self.title_panel:setAnchorPoint(0.5, 1)
	self.title_panel:setPositionY(GameDisplay.height)
	print(self.title_panel:getPositionY(), GameDisplay.fix_y, "yyyyy", GameDisplay.height)
	self.Listview:setContentSize(cc.size(640, 466 + 2 * GameDisplay.fix_y))
end
