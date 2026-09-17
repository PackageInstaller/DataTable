AdventurerVisualLayerSummer = class("AdventurerVisualLayerSummer", function()
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
local var_0_12 = 128
local var_0_13 = "awardmodetype_1281_"
local lua = require("data.adventure_score_awards.adventure_score_awards_1281.lua")
local var_0_15 = 20
local var_0_16 = (function()
	if not lua or not next(lua) then
		return 0
	end

	local var_2_0 = 1

	while lua[var_0_13 .. var_2_0] do
		var_2_0 = var_2_0 + 1
	end

	return var_2_0
end)()
local var_0_17 = "adventure_score_summer/items_bg.png"
local var_0_18 = {
	[1] = "adventure_score_summer/row_no.png",
	[2] = "adventure_score_summer/row_get.png"
}
local var_0_19

local function var_0_20(arg_3_0)
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

function AdventurerVisualLayerSummer.create(arg_4_0, arg_4_1)
	local var_4_0 = AdventurerVisualLayerSummer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function AdventurerVisualLayerSummer:init(arg_5_1)
	var_0_19 = self

	if arg_5_1 then
		self.returnbacklayer = arg_5_1.returnbacklayer or "ActivitySummerMainLayer"
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventurerVisualLayerSummer.json" or "AdventurerVisualLayerSummer.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setBackGroundColorOpacity(0)

	self.title_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "img_title")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.items1 = ccui.Helper:seekWidgetByName(self.rootLayer, "items2")
	self.Listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_59")
	self.awardpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "img_award")
	self.info1 = ccui.Helper:seekWidgetByName(self.title_panel, "Button_24")
	self.info2 = ccui.Helper:seekWidgetByName(self.title_panel, "Button_25")
	self.score_label = ccui.Helper:seekWidgetByName(self.awardpanel, "Label_67")
	self.Listview1 = ccui.Helper:seekWidgetByName(self.awardpanel, "ListView_30")

	ccui.Helper:seekWidgetByName(self.title_panel, "Label_27"):setString("")
	self.score_label:setString("")

	self.modetype = 1281
	self.totalscore = 0
	self.gethaveaward = {}

	self.Listview:setBackGroundColor(cc.c4b(255, 205, 66, 255))
	self:initBottomList()
	self:initTileLayer()
	self:getListData()
	self:registerTimeCheckEvent()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_19 = nil

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
end

function AdventurerVisualLayerSummer:initTileLayer()
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

		var_8_0.key = "activity_summer_adverture"

		if not require("data.detail_data")[var_8_0.key] then
			print("error:----------------> detail_data.lua is no data for this layer  找策划填写规则表：键值为：" .. var_8_0.key)
		else
			LayerManager:pushInLayer("PopActivityDetail", var_8_0)
		end
	end

	self.info1:addTouchEventListener(var_7_0)
	self.info2:addTouchEventListener(var_7_0)
	self:updateTimeLable()
end

function AdventurerVisualLayerSummer:updateBtnStatus()
	if not self.awards or not next(self.awards) then
		return
	end

	if not self.selectindex then
		for iter_9_0, iter_9_1 in ipairs(self.awards) do
			ccui.Helper:seekWidgetByName(iter_9_1, "Image_34"):setVisible(false)
		end
	else
		for iter_9_2, iter_9_3 in ipairs(self.awards) do
			if iter_9_2 == self.selectindex then
				ccui.Helper:seekWidgetByName(iter_9_3, "Image_34"):setVisible(true)
			else
				ccui.Helper:seekWidgetByName(iter_9_3, "Image_34"):setVisible(false)
			end
		end
	end
end

function AdventurerVisualLayerSummer.checkIsTime(arg_10_0, arg_10_1)
	local var_10_0 = true

	if not arg_10_1 then
		return var_10_0
	end

	if global_get_time_by_date(arg_10_1) > time_check_manager:getCurTime() then
		var_10_0 = false
	end

	return var_10_0
end

function AdventurerVisualLayerSummer:updateTotalScore()
	self.score_label:setString((self.totalscore or nil) and L_AVAON_VISUAL.chapter_score .. global_trans_number(self.totalscore))
end

function AdventurerVisualLayerSummer:updateTimeLable()
	local var_12_0 = ccui.Helper:seekWidgetByName(self.title_panel, "Label_27")

	if not activity_conf_data[var_0_12] then
		var_12_0:setString(L_LAMIYA_CHAPTER.activity_no_open)

		return
	end

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date(activity_conf_data[var_0_12].finishtime) - time_check_manager:getCurTime(), function(arg_13_0)
		var_12_0:setString(L_AVAON_VISUAL.jishi .. var_0_20(arg_13_0))

		if arg_13_0 <= 0 and self.activityScheduler then
			var_12_0:setString(L_LAMIYA_CHAPTER.activity_end)
		end
	end)))
end

function AdventurerVisualLayerSummer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer(self.returnbacklayer)
	end, nil, "adventure_score_summer/battom.png", {
		img = "adventure_score_summer/return_btn.png"
	})

	self:addChild(self.bottomList, 10)
end

function AdventurerVisualLayerSummer:initUILayer()
	self:initListView()
	self:updateTotalScore()
	self:initAwardPanel()
end

function AdventurerVisualLayerSummer:initListView()
	self.Listview:removeAllChildren()
	self.Listview:setItemsMargin(var_0_15)

	if not self.data then
		print("error:----------------------------> no data can use！！！！！")
	end

	for iter_17_0, iter_17_1 in ipairs(self.data) do
		local var_17_0 = self.items:clone()

		self:updateNode(var_17_0, iter_17_0, iter_17_1)

		var_17_0.step = iter_17_0

		self.Listview:pushBackCustomItem(var_17_0)
	end
end

function AdventurerVisualLayerSummer:updateNode(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = ccui.Helper:seekWidgetByName(arg_18_1, "bossface")
	local var_18_1 = ccui.Helper:seekWidgetByName(arg_18_1, "ceshu")
	local var_18_2 = ccui.Helper:seekWidgetByName(arg_18_1, "bossname")
	local var_18_3 = ccui.Helper:seekWidgetByName(arg_18_1, "change_btn")
	local var_18_4 = ccui.Helper:seekWidgetByName(arg_18_1, "info")
	local var_18_5 = ccui.Helper:seekWidgetByName(arg_18_1, "Image_32")
	local var_18_6 = ccui.Helper:seekWidgetByName(var_18_5, "Label_34")

	var_18_1:setPositionY(144)
	var_18_0:setPositionY(103)
	var_18_4:getVirtualRenderer():setMaxLineWidth(260)
	arg_18_1:setBackGroundImage(var_0_17, var_0_1)
	ccui.Helper:seekWidgetByName(arg_18_1, "Label_58"):setString(arg_18_3.name)

	if arg_18_3.score then
		var_18_1:setString(arg_18_3.score)
	else
		var_18_1:setString("")
	end

	if arg_18_3.bossinfo then
		var_18_4:setString(arg_18_3.bossinfo)
	else
		var_18_4:setString("")
	end

	var_18_3:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", self.modetype)
		LayerManager:pushInLayer("AdventureNewDetailLayer", {
			isvisual = 1,
			issummeradverture = 1,
			data = levelmode_data[arg_18_3.mode],
			score = arg_18_3.score
		})
	end)

	if arg_18_3.show_boss then
		var_18_0:loadTextures(CUTE_ROLE_IMAGE_PATH .. model_data[arg_18_3.show_boss].cute_role .. ".png", nil, CUTE_ROLE_IMAGE_PATH .. model_data[arg_18_3.show_boss].cute_role .. ".png")
		var_18_0:setVisible(true)
		var_18_0:setScale(0.3)
		var_18_2:setString(model_data[arg_18_3.show_boss].name)
	else
		var_18_0:setVisible(false)
		var_18_2:setString("")
	end

	if self:checkIsTime(arg_18_3.starttime) then
		var_18_5:setVisible(false)
	else
		var_18_5:setVisible(true)
		var_18_5:setTouchEnabled(true)

		local var_18_7 = self:dealString(arg_18_3.starttime)

		var_18_6:setString(var_18_7)
		var_18_5:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(var_18_7)
		end)
	end
end

function AdventurerVisualLayerSummer.dealString(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return ""
	end

	local var_21_0 = os.date("*t", math.floor((global_get_time_by_date(arg_21_1))))

	return (string.format(L_AVAON_VISUAL.tips_3, var_21_0.year, var_21_0.month, var_21_0.day))
end

function AdventurerVisualLayerSummer:initAwardPanel()
	self.Listview1:setClippingEnabled(true)
	self.Listview1:removeAllChildren()
	self.Listview1:setItemsMargin(0)

	self.awards = {}

	if not lua or not next(lua) then
		return
	end

	local var_22_0 = 1

	while lua[var_0_13 .. var_22_0] do
		local var_22_1 = self.items1:clone()

		self:updateAwardNode(var_22_1, var_22_0, lua[var_0_13 .. var_22_0])
		self.Listview1:pushBackCustomItem(var_22_1)
		table.insert(self.awards, var_22_1)

		var_22_1.step = var_22_0
		var_22_0 = var_22_0 + 1
	end

	self:updateBtnStatus()

	local var_22_2 = self:getCurScoreIndex()

	if var_22_2 <= 3 then
		-- block empty
	else
		local var_22_3 = (var_22_2 - 1) * (100 / (var_0_16 - self.Listview1:getContentSize().width / 107))

		if var_22_3 < 0 then
			var_22_3 = 0
		elseif var_22_3 > 100 then
			var_22_3 = 100
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			self.Listview1:scrollToPercentHorizontal(var_22_3, 0.5, false)
		end)))
	end
end

function AdventurerVisualLayerSummer:updateAwardNode(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = ccui.Helper:seekWidgetByName(arg_24_1, "ProgressBar_61")
	local var_24_1 = ccui.Helper:seekWidgetByName(arg_24_1, "img_row")
	local var_24_2 = ccui.Helper:seekWidgetByName(arg_24_1, "need_img_di")
	local var_24_3 = ccui.Helper:seekWidgetByName(var_24_2, "Label_64")
	local var_24_4 = ccui.Helper:seekWidgetByName(arg_24_1, "img_canget")
	local var_24_5 = ccui.Helper:seekWidgetByName(arg_24_1, "Image_65")
	local var_24_6 = ccui.Helper:seekWidgetByName(arg_24_1, "Image_68")
	local var_24_7 = ccui.Helper:seekWidgetByName(var_24_6, "Label_69")

	var_24_6:setVisible(false)
	var_24_1:setVisible(false)

	local var_24_8 = 0
	local var_24_9 = self:getCurScoreIndex()

	if arg_24_2 < var_24_9 then
		var_24_8 = 100
	elseif arg_24_2 == var_24_9 then
		var_24_8 = 100 * (self.totalscore / arg_24_3.score)
	elseif var_24_9 < arg_24_2 then
		var_24_8 = 0
	end

	var_24_0:setPercent(var_24_8)

	if var_24_8 == 100 then
		var_24_1:loadTexture(var_0_18[2], var_0_1)
		var_24_2:setVisible(false)
		var_24_3:setString("")
		var_24_4:setVisible(true)

		if self:isAwardHaveGet(arg_24_2) then
			var_24_3:setString(L_AVAON_VISUAL.have_get)
			var_24_4:setVisible(false)
			var_24_2:setVisible(true)
			var_24_5:setVisible(true)
		else
			var_24_5:setVisible(false)
		end
	else
		var_24_1:loadTexture(var_0_18[1], var_0_1)
		var_24_2:setVisible(true)
		var_24_4:setVisible(false)
		var_24_3:setString(string.format(L_AVAON_VISUAL.fen_lock, arg_24_3.score))
		var_24_5:setVisible(false)
	end

	local var_24_10 = self:getDropData(arg_24_3.dropid)
	local var_24_11
	local var_24_12 = 0

	if var_24_10.items and next(var_24_10.items) then
		var_24_11 = var_24_10.items[1].itemid
		var_24_12 = var_24_10.items[1].num
	elseif var_24_10.diamond and var_24_10.diamond > 0 then
		var_24_11 = "diamond"
		var_24_12 = var_24_10.diamond
	elseif var_24_10.gold then
		var_24_11 = "gold"
		var_24_12 = var_24_10.gold
	end

	local var_24_14

	if var_24_11 and var_24_12 then
		var_24_14 = type(var_24_11) == "string" and ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_1) or ccui.Button:create("public/box/" .. item_data[var_24_11].equip_quality .. ".png", "public/box/" .. item_data[var_24_11].equip_quality .. ".png", nil, var_0_1)

		var_24_14:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_14:setPosition(cc.p(0, 0))
		var_24_14:setTouchEnabled(true)
		var_24_14:setSwallowTouches(false)
		var_24_14:setPosition(cc.p(arg_24_1:getContentSize().width / 2, arg_24_1:getContentSize().height / 2 + 8))
		var_24_14:setName("awarditem")
		arg_24_1:addChild(var_24_14, 2)
		var_24_6:setLocalZOrder(3)
		var_24_14:setScale9Enabled(true)
		var_24_14:setContentSize(cc.size(94, 124))

		local var_24_15
		local var_24_16

		if var_24_11 == "gold" then
			var_24_15 = "equipment/1000001.png"
		elseif var_24_11 == "diamond" then
			var_24_15 = "equipment/1000000.png"
		elseif item_data[var_24_11].bag_item_type == kITEM_MEDAL then
			var_24_16 = ItemSprite:create_medal_icon(var_24_11)
		elseif item_data[var_24_11].bag_item_type == kITEM_COMPONENT then
			var_24_16 = componentManager:create_component_icon(var_24_11, nil, nil)
		elseif item_data[var_24_11].image_id then
			var_24_15 = "equipment/" .. item_data[var_24_11].image_id .. ".png"
		end

		var_24_16 = var_24_16 or ccui.ImageView:create(var_24_15)

		var_24_16:setPosition(cc.p(var_24_14:getContentSize().width / 2, var_24_14:getContentSize().height / 2 + 3))
		var_24_16:setName("ItemSprite")
		var_24_16:setScale(90 / math.min(var_24_16:getContentSize().width, var_24_16:getContentSize().height))
		var_24_14:addChild(var_24_16)

		var_24_14.step = arg_24_2
		var_24_14.itemid = var_24_11

		var_24_7:setString("x" .. var_24_12)
		var_24_6:setVisible(true)
		var_24_14:addTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectindex = arg_25_0.step

			self:updateBtnStatus()

			if self.totalscore and self.totalscore >= arg_24_3.score and not self:isAwardHaveGet(arg_25_0.step) then
				self:dealGetAward(arg_25_0.step)
			else
				self:showItemDeatil(arg_25_0)
			end
		end)
	end
end

function AdventurerVisualLayerSummer:showItemDeatil(arg_26_1)
	if type(arg_26_1.itemid) == "string" then
		return
	end

	local var_26_0 = item_data[arg_26_1.itemid].bag_item_type

	if item_data[arg_26_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_26_1 = -1
		local var_26_2 = require("data.item_data")[arg_26_1.itemid].horcruxtype

		for iter_26_0, iter_26_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_26_1.itemid == iter_26_1.item_id then
				var_26_1 = iter_26_0

				break
			end
		end

		if var_26_1 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_26_1,
			itemid = arg_26_1.itemid
		})
	elseif var_26_0 == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_26_1.itemid].servant
		})
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_26_3 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_26_1.itemid
		})
	end
end

function AdventurerVisualLayerSummer:isAwardHaveGet(arg_27_1)
	if not arg_27_1 or not self.gethaveaward or not next(self.gethaveaward) then
		return false
	end

	local var_27_0 = false

	for iter_27_0, iter_27_1 in pairs(self.gethaveaward) do
		if iter_27_1.rank == arg_27_1 and iter_27_1.havereceived then
			var_27_0 = true

			break
		end
	end

	return var_27_0
end

function AdventurerVisualLayerSummer:getCurScoreIndex()
	if not lua or not next(lua) then
		return 1
	end

	local var_28_0 = var_0_16

	while lua[var_0_13 .. 1] do
		if self.totalscore <= lua[var_0_13 .. 1].score then
			var_28_0 = 1

			break
		end
	end

	return var_28_0
end

function AdventurerVisualLayerSummer:updateAwardData(arg_29_1)
	if not arg_29_1 or not self.gethaveaward then
		return
	end

	if not self:isAwardHaveGet(arg_29_1) then
		table.insert(self.gethaveaward, {
			havereceived = true,
			rank = arg_29_1
		})
	else
		for iter_29_0, iter_29_1 in pairs(self.gethaveaward) do
			if iter_29_1.rank == arg_29_1 then
				iter_29_1.havereceived = true
			end
		end
	end
end

function AdventurerVisualLayerSummer:dealGetAward(arg_30_1)
	level_manager:get_adventure_score_awards(nil, self.modetype, arg_30_1, function(arg_31_0)
		if arg_31_0.result == 1 then
			self:updateAwardData(arg_30_1)
			self:updateAwardNode(self.awards[arg_30_1], arg_30_1, lua[var_0_13 .. arg_30_1])
		else
			global_ShowBlockWords(L_AVAON_VISUAL.no_award)
		end
	end)
end

function AdventurerVisualLayerSummer:getListData()
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(levelmode_data) do
		if iter_32_1.modetype == self.modetype then
			table.insert(var_32_0, iter_32_1)
		end
	end

	if next(var_32_0) then
		table.sort(var_32_0, function(arg_33_0, arg_33_1)
			return arg_33_0.order < arg_33_1.order
		end)
	end

	self:updateListData(var_32_0)
	level_manager:is_have_adventure_awards(nil, self.modetype, function(arg_34_0)
		if arg_34_0.result == 1 then
			self.gethaveaward = arg_34_0.awardlist

			self:addRedot()
		else
			self.gethaveaward = arg_34_0.awardlist

			self:addRedot()
		end

		self:initAwardPanel()
	end)
end

function AdventurerVisualLayerSummer:updateListData(arg_35_1)
	level_manager:get_adventure_score(nil, self.modetype, function(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
		if arg_36_0 == 1 then
			self.totalscore = arg_36_1

			for iter_36_0, iter_36_1 in pairs(arg_36_2) do
				for iter_36_2, iter_36_3 in pairs(arg_35_1) do
					if iter_36_3.mode == iter_36_1.mode then
						iter_36_3.score = iter_36_1.score

						break
					end
				end
			end

			self.data = arg_35_1

			self:initUILayer()
		end
	end)
end

function AdventurerVisualLayerSummer.addRedot(arg_37_0, arg_37_1)
	return
end

function AdventurerVisualLayerSummer.getDropData(arg_38_0, arg_38_1)
	local var_38_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_38_1 = drop_data[arg_38_1] or {}

	if var_38_1.gold then
		var_38_0.gold = var_38_0.gold + var_38_1.gold
	end

	if var_38_1.diamond then
		var_38_0.diamond = var_38_0.diamond + var_38_1.diamond
	end

	local var_38_2 = 1

	if var_38_1["drop_id" .. 1] then
		local var_38_3 = 1

		while var_38_1["drop_id" .. var_38_3] do
			var_38_0.items[var_38_2] = {
				itemid = var_38_1["drop_id" .. var_38_3],
				num = var_38_1["drop_num" .. var_38_3],
				rate = var_38_1["drop_rate" .. var_38_3]
			}
			var_38_3 = var_38_3 + 1
			var_38_2 = var_38_2 + 1
		end
	end

	if var_38_1["dropmodel_id" .. 1] then
		local var_38_4 = 1

		while var_38_1["dropmodel_id" .. var_38_4] do
			if drop_data[var_38_1["dropmodel_id" .. var_38_4]].gold then
				var_38_0.gold = var_38_0.gold + drop_data[var_38_1["dropmodel_id" .. var_38_4]].gold
			end

			if drop_data[var_38_1["dropmodel_id" .. var_38_4]].diamond then
				var_38_0.diamond = var_38_0.diamond + drop_data[var_38_1["dropmodel_id" .. var_38_4]].diamond
			end

			if drop_data[var_38_1["dropmodel_id" .. var_38_4]]["drop_id" .. 1] then
				local var_38_5 = 1

				while drop_data[var_38_1["dropmodel_id" .. var_38_4]]["drop_id" .. var_38_5] do
					var_38_0.items[var_38_2] = {
						itemid = drop_data[var_38_1["dropmodel_id" .. var_38_4]]["drop_id" .. var_38_5],
						num = drop_data[var_38_1["dropmodel_id" .. var_38_4]]["drop_num" .. var_38_5]
					}
					var_38_5 = var_38_5 + 1
					var_38_2 = var_38_2 + 1
				end
			end

			if drop_data[var_38_1["dropmodel_id" .. var_38_4]]["rd_drop_id" .. 1] then
				local var_38_6 = 1

				while drop_data[var_38_1["dropmodel_id" .. var_38_4]]["rd_drop_id" .. var_38_6] do
					var_38_0.items[var_38_2] = {
						itemid = drop_data[var_38_1["dropmodel_id" .. var_38_4]]["rd_drop_id" .. var_38_6],
						num = drop_data[var_38_1["dropmodel_id" .. var_38_4]]["rd_drop_num" .. var_38_6]
					}
					var_38_6 = var_38_6 + 1
					var_38_2 = var_38_2 + 1
				end
			end

			var_38_4 = var_38_4 + 1
		end
	end

	if var_38_1["rd_drop_id" .. 1] then
		local var_38_7 = 1

		while var_38_1["rd_drop_id" .. var_38_7] do
			var_38_0.items[var_38_2] = {
				itemid = var_38_1["rd_drop_id" .. var_38_7],
				num = var_38_1["rd_drop_num" .. var_38_7]
			}
			var_38_7 = var_38_7 + 1
			var_38_2 = var_38_2 + 1
		end
	end

	if var_38_1["rd_dropmodel_id" .. 1] then
		local var_38_8 = 1

		while var_38_1["rd_dropmodel_id" .. var_38_8] do
			if drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]].gold then
				var_38_0.gold = var_38_0.gold + drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]].gold
			end

			if drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]].diamond then
				var_38_0.diamond = var_38_0.diamond + drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]].diamond
			end

			if drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]]["drop_id" .. 1] then
				local var_38_9 = 1

				while drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]]["drop_id" .. var_38_9] do
					var_38_0.items[var_38_2] = {
						itemid = drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]]["drop_id" .. var_38_9],
						num = drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]]["drop_num" .. var_38_9]
					}
					var_38_9 = var_38_9 + 1
					var_38_2 = var_38_2 + 1
				end
			end

			if drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]]["rd_drop_id" .. 1] then
				local var_38_10 = 1

				while drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]]["rd_drop_id" .. var_38_10] do
					var_38_0.items[var_38_2] = {
						itemid = drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]]["rd_drop_id" .. var_38_10],
						num = drop_data[var_38_1["rd_dropmodel_id" .. var_38_8]]["rd_drop_num" .. var_38_10]
					}
					var_38_10 = var_38_10 + 1
					var_38_2 = var_38_2 + 1
				end
			end

			var_38_8 = var_38_8 + 1
		end
	end

	return var_38_0
end

function AdventurerVisualLayerSummer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_40_0)
		if arg_40_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				self:initListView()
			end)
		end
	end), self)
end

function AdventurerVisualLayerSummer:fullScreen(arg_42_1)
	arg_42_1:setContentSize((GameDisplay.getScreenSize()))
	arg_42_1:setPositionY(arg_42_1:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.title_panel:setPositionY(self.title_panel:getPositionY() + 2 * GameDisplay.fix_y)
	self.Listview:setContentSize(cc.size(640, 490 + 2 * GameDisplay.fix_y))
end
