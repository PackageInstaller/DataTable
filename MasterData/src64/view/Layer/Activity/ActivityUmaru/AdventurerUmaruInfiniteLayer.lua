AdventurerUmaruInfiniteLayer = class("AdventurerUmaruInfiniteLayer", function()
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
local var_0_12 = 137
local var_0_13 = "awardmodetype_1371_"
local lua = require("data.adventure_score_awards_data.lua")
local var_0_15 = 20
local var_0_16 = 1371
local var_0_17 = (function()
	if not lua or not next(lua) then
		return 0
	end

	local var_2_0 = 1

	while lua[var_0_13 .. var_2_0] do
		var_2_0 = var_2_0 + 1
	end

	return var_2_0
end)()
local var_0_18 = "adventure_infinite_umaru/inif_diban.png"
local var_0_19 = {
	[1] = "adventure_infinite_umaru/row_no.png",
	[2] = "adventure_infinite_umaru/row_get.png"
}
local var_0_20 = "adventure_infinite_umaru/inif_rank.png"
local var_0_21

local function var_0_22(arg_3_0)
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

function AdventurerUmaruInfiniteLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = AdventurerUmaruInfiniteLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function AdventurerUmaruInfiniteLayer:init(arg_5_1)
	var_0_21 = self

	if arg_5_1 then
		self.returnbacklayer = arg_5_1.returnbacklayer or "ActivityAnniversaryMainLayer"
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventurerUmaruInfiniteLayer.json" or "AdventurerUmaruInfiniteLayer.ExportJson")

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
	self.score_label:setString("")

	self.modetype = var_0_16
	self.totalscore = 0
	self.gethaveaward = {}

	self.Listview:setBackGroundColor(cc.c4b(255, 205, 66, 255))
	self:initBottomList()
	self:initTileLayer()
	self:getListData()
	self:registerTimeCheckEvent()
	self.btnup:setVisible(false)
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
			var_0_21 = nil

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
end

function AdventurerUmaruInfiniteLayer.getTheModeByModetype(arg_9_0, arg_9_1)
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

function AdventurerUmaruInfiniteLayer:initTileLayer()
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

		var_11_0.key = "activity_umaru_infinite_adverture"

		if not require("data.detail_data")[var_11_0.key] then
			print("error:----------------> detail_data.lua is no data for this layer  找策划填写规则表：键值为：" .. var_11_0.key)
		else
			LayerManager:pushInLayer("PopActivityDetail", var_11_0)
		end
	end)
	self:updateTimeLable()
end

function AdventurerUmaruInfiniteLayer:updateBtnStatus()
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

function AdventurerUmaruInfiniteLayer.checkIsTime(arg_13_0, arg_13_1)
	local var_13_0 = true

	if not arg_13_1 then
		return var_13_0
	end

	if global_get_time_by_date(arg_13_1) > time_check_manager:getCurTime() then
		var_13_0 = false
	end

	return var_13_0
end

function AdventurerUmaruInfiniteLayer:updateTotalScore()
	self.score_label:setString((self.totalscore or nil) and "" .. global_trans_number(self.totalscore))
end

function AdventurerUmaruInfiniteLayer:updateTimeLable()
	local var_15_0 = ccui.Helper:seekWidgetByName(self.title_panel, "Label_27")

	if not activity_conf_data[var_0_12] then
		var_15_0:setString(L_LAMIYA_CHAPTER.activity_no_open)

		return
	end

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date(activity_conf_data[var_0_12].finishtime) - time_check_manager:getCurTime(), function(arg_16_0)
		var_15_0:setString(L_AVAON_VISUAL.jishi .. var_0_22(arg_16_0))

		if arg_16_0 <= 0 and self.activityScheduler then
			var_15_0:setString(L_ACTIVITY_END)
		end
	end)))
end

function AdventurerUmaruInfiniteLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, nil, "adventure_infinite_umaru/inf_dibian.png", {
		img = "adventure_infinite_umaru/inif_back.png"
	})

	self:addChild(self.bottomList, 1000)

	self.rankbtn = ccui.Button:create(var_0_20, nil, var_0_20, var_0_1)

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

function AdventurerUmaruInfiniteLayer:initUILayer()
	self:initListView()
	self:updateTotalScore()
	self:initAwardPanel()
end

function AdventurerUmaruInfiniteLayer:initListView()
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

function AdventurerUmaruInfiniteLayer:updateNode(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = ccui.Helper:seekWidgetByName(arg_22_1, "bossface")
	local var_22_1 = ccui.Helper:seekWidgetByName(arg_22_1, "ceshu")
	local var_22_2 = ccui.Helper:seekWidgetByName(arg_22_1, "bossname")
	local var_22_3 = ccui.Helper:seekWidgetByName(arg_22_1, "change_btn")
	local var_22_4 = ccui.Helper:seekWidgetByName(arg_22_1, "info")
	local var_22_5 = ccui.Helper:seekWidgetByName(arg_22_1, "Image_32")
	local var_22_6 = ccui.Helper:seekWidgetByName(var_22_5, "Label_34")

	var_22_0:setTouchEnabled(false)
	ccui.Helper:seekWidgetByName(arg_22_1, "detail_btn"):setTouchEnabled(false)
	var_22_0:setPositionY(129)
	var_22_4:setFontSize(23)
	var_22_4:getVirtualRenderer():setMaxLineWidth(260)
	arg_22_1:setBackGroundImage(var_0_18, var_0_1)
	ccui.Helper:seekWidgetByName(arg_22_1, "Label_58"):setString(arg_22_3.name)

	if arg_22_3.score then
		var_22_1:setString(arg_22_3.score)
	else
		var_22_1:setString("")
	end

	if arg_22_3.bossinfo then
		var_22_4:setString(arg_22_3.bossinfo)
	else
		var_22_4:setString("")
	end

	var_22_3:addTouchEventListener(function(arg_23_0, arg_23_1)
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
		var_22_0:setScale(0.4)
		var_22_2:setString(model_data[arg_22_3.show_boss].name)
	else
		var_22_0:setVisible(false)
		var_22_2:setString("")
	end

	if self:checkIsTime(arg_22_3.starttime) then
		var_22_5:setVisible(false)
	else
		var_22_5:setVisible(true)
		var_22_5:setTouchEnabled(true)

		local var_22_7 = self:dealString(arg_22_3.starttime)

		var_22_6:setString(var_22_7)
		var_22_5:addTouchEventListener(function(arg_24_0, arg_24_1)
			if arg_24_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(var_22_7)
		end)
	end
end

function AdventurerUmaruInfiniteLayer.dealString(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return ""
	end

	local var_25_0 = os.date("*t", math.floor((global_get_time_by_date(arg_25_1))))

	return (string.format(L_AVAON_VISUAL.tips_3, var_25_0.year, var_25_0.month, var_25_0.day))
end

function AdventurerUmaruInfiniteLayer:initAwardPanel()
	self.Listview1:setClippingEnabled(true)
	self.Listview1:removeAllChildren()
	self.Listview1:setItemsMargin(0)

	self.awards = {}

	if not lua or not next(lua) then
		return
	end

	local var_26_0 = 1

	while lua[var_0_13 .. var_26_0] do
		local var_26_1 = self.items1:clone()

		self:updateAwardNode(var_26_1, var_26_0, lua[var_0_13 .. var_26_0])
		self.Listview1:pushBackCustomItem(var_26_1)
		table.insert(self.awards, var_26_1)

		var_26_1.step = var_26_0
		var_26_0 = var_26_0 + 1
	end

	self:updateBtnStatus()

	local var_26_2 = self:getCurScoreIndex()

	if var_26_2 <= 3 then
		-- block empty
	else
		local var_26_3 = (var_26_2 - 1) * (100 / (var_0_17 - self.Listview1:getContentSize().width / 107))

		if var_26_3 < 0 then
			var_26_3 = 0
		elseif var_26_3 > 100 then
			var_26_3 = 100
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			self.Listview1:scrollToPercentHorizontal(var_26_3, 0.5, false)
		end)))
	end
end

function AdventurerUmaruInfiniteLayer:updateAwardNode(arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = ccui.Helper:seekWidgetByName(arg_28_1, "ProgressBar_61")
	local var_28_1 = ccui.Helper:seekWidgetByName(arg_28_1, "img_row")
	local var_28_2 = ccui.Helper:seekWidgetByName(arg_28_1, "need_img_di")
	local var_28_3 = ccui.Helper:seekWidgetByName(var_28_2, "Label_64")
	local var_28_4 = ccui.Helper:seekWidgetByName(arg_28_1, "img_canget")
	local var_28_5 = ccui.Helper:seekWidgetByName(arg_28_1, "Image_65")
	local var_28_6 = ccui.Helper:seekWidgetByName(arg_28_1, "Image_68")
	local var_28_7 = ccui.Helper:seekWidgetByName(var_28_6, "Label_69")

	var_28_6:setVisible(false)
	var_28_1:setVisible(false)

	local var_28_8 = 0
	local var_28_9 = self:getCurScoreIndex()

	if arg_28_2 < var_28_9 then
		var_28_8 = 100
	elseif arg_28_2 == var_28_9 then
		var_28_8 = 100 * (self.totalscore / arg_28_3.score)
	elseif var_28_9 < arg_28_2 then
		var_28_8 = 0
	end

	var_28_0:setPercent(var_28_8)

	if var_28_8 == 100 then
		var_28_1:loadTexture(var_0_19[2], var_0_1)
		var_28_2:setVisible(false)
		var_28_3:setString("")
		var_28_4:setVisible(true)

		if self:isAwardHaveGet(arg_28_2) then
			var_28_3:setString(L_AVAON_VISUAL.have_get)
			var_28_4:setVisible(false)
			var_28_2:setVisible(true)
			var_28_5:setVisible(true)
		else
			var_28_5:setVisible(false)
		end
	else
		var_28_1:loadTexture(var_0_19[1], var_0_1)
		var_28_2:setVisible(true)
		var_28_4:setVisible(false)
		var_28_3:setString(string.format(L_AVAON_VISUAL.fen_lock, arg_28_3.score))
		var_28_5:setVisible(false)
	end

	local var_28_10 = self:getDropData(arg_28_3.dropid)
	local var_28_11
	local var_28_12 = 0

	if var_28_10.items and next(var_28_10.items) then
		var_28_11 = var_28_10.items[1].itemid
		var_28_12 = var_28_10.items[1].num
	elseif var_28_10.diamond and var_28_10.diamond > 0 then
		var_28_11 = "diamond"
		var_28_12 = var_28_10.diamond
	elseif var_28_10.gold then
		var_28_11 = "gold"
		var_28_12 = var_28_10.gold
	end

	local var_28_14

	if var_28_11 and var_28_12 then
		if arg_28_1:getChildByName("awarditem") then
			arg_28_1:getChildByName("awarditem"):removeFromParent()
		end

		var_28_14 = type(var_28_11) == "string" and ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_1) or ccui.Button:create("public/box/" .. item_data[var_28_11].equip_quality .. ".png", "public/box/" .. item_data[var_28_11].equip_quality .. ".png", nil, var_0_1)

		var_28_14:setAnchorPoint(cc.p(0.5, 0.5))
		var_28_14:setPosition(cc.p(0, 0))
		var_28_14:setTouchEnabled(true)
		var_28_14:setSwallowTouches(false)
		var_28_14:setPosition(cc.p(arg_28_1:getContentSize().width / 2, arg_28_1:getContentSize().height / 2 + 8))
		var_28_14:setName("awarditem")
		arg_28_1:addChild(var_28_14, 2)
		var_28_6:setLocalZOrder(3)
		var_28_14:setScale9Enabled(true)
		var_28_14:setContentSize(cc.size(94, 124))

		local var_28_15
		local var_28_16

		if var_28_11 == "gold" then
			var_28_15 = "equipment/1000001.png"
		elseif var_28_11 == "diamond" then
			var_28_15 = "equipment/1000000.png"
		elseif item_data[var_28_11].bag_item_type == kITEM_MEDAL then
			var_28_16 = ItemSprite:create_medal_icon(var_28_11)
		elseif item_data[var_28_11].bag_item_type == kITEM_COMPONENT then
			var_28_16 = componentManager:create_component_icon(var_28_11, nil, nil)
		elseif item_data[var_28_11].image_id then
			var_28_15 = "equipment/" .. item_data[var_28_11].image_id .. ".png"
		end

		var_28_16 = var_28_16 or ccui.ImageView:create(var_28_15)

		var_28_16:setPosition(cc.p(var_28_14:getContentSize().width / 2, var_28_14:getContentSize().height / 2 + 3))
		var_28_16:setName("ItemSprite")

		local var_28_17 = var_28_16:getContentSize().width
		local var_28_18 = 90 / math.min(var_28_17, var_28_16:getContentSize().height)

		var_28_16:setScale((item_data[var_28_11] or nil) and global_get_item_scale_by_size(var_28_17, item_data[var_28_11] and item_data[var_28_11].bag_item_type) * 0.52)
		var_28_14:addChild(var_28_16)

		var_28_14.step = arg_28_2
		var_28_14.itemid = var_28_11

		var_28_7:setString("x" .. var_28_12)
		var_28_6:setVisible(true)
		var_28_14:addTouchEventListener(function(arg_29_0, arg_29_1)
			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectindex = arg_29_0.step

			self:updateBtnStatus()

			if self.totalscore and self.totalscore >= arg_28_3.score and not self:isAwardHaveGet(arg_29_0.step) then
				self:dealGetAward(arg_29_0.step)
			else
				print("TTTTTTTTTTTTTTTTTTTTTT")
				self:showItemDeatil(arg_29_0)
			end
		end)
	end
end

function AdventurerUmaruInfiniteLayer:showItemDeatil(arg_30_1)
	if type(arg_30_1.itemid) == "string" then
		return
	end

	local var_30_0 = item_data[arg_30_1.itemid].bag_item_type

	if item_data[arg_30_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_30_1 = -1
		local var_30_2 = require("data.item_data")[arg_30_1.itemid].horcruxtype

		for iter_30_0, iter_30_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_30_1.itemid == iter_30_1.item_id then
				var_30_1 = iter_30_0

				break
			end
		end

		if var_30_1 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_30_1,
			itemid = arg_30_1.itemid
		})
	elseif var_30_0 == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_30_1.itemid].servant
		})
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_30_3 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_30_1.itemid
		})
	end
end

function AdventurerUmaruInfiniteLayer:isAwardHaveGet(arg_31_1)
	if not arg_31_1 or not self.gethaveaward or not next(self.gethaveaward) then
		return false
	end

	local var_31_0 = false

	for iter_31_0, iter_31_1 in pairs(self.gethaveaward) do
		if iter_31_1.rank == arg_31_1 and iter_31_1.havereceived then
			var_31_0 = true

			break
		end
	end

	return var_31_0
end

function AdventurerUmaruInfiniteLayer:getCurScoreIndex()
	if not lua or not next(lua) then
		return 1
	end

	local var_32_0 = var_0_17

	while lua[var_0_13 .. 1] do
		if self.totalscore <= lua[var_0_13 .. 1].score then
			var_32_0 = 1

			break
		end
	end

	return var_32_0
end

function AdventurerUmaruInfiniteLayer:updateAwardData(arg_33_1)
	if not arg_33_1 or not self.gethaveaward then
		return
	end

	if not self:isAwardHaveGet(arg_33_1) then
		table.insert(self.gethaveaward, {
			havereceived = true,
			rank = arg_33_1
		})
	else
		for iter_33_0, iter_33_1 in pairs(self.gethaveaward) do
			if iter_33_1.rank == arg_33_1 then
				iter_33_1.havereceived = true
			end
		end
	end
end

function AdventurerUmaruInfiniteLayer:dealGetAward(arg_34_1)
	level_manager:get_adventure_score_awards(nil, self.modetype, arg_34_1, function(arg_35_0)
		if arg_35_0.result == 1 then
			self:updateAwardData(arg_34_1)
			self:updateAwardNode(self.awards[arg_34_1], arg_34_1, lua[var_0_13 .. arg_34_1])
		else
			global_ShowBlockWords(L_AVAON_VISUAL.no_award)
		end
	end)
end

function AdventurerUmaruInfiniteLayer:getListData()
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in pairs(levelmode_data) do
		if iter_36_1.modetype == self.modetype then
			table.insert(var_36_0, iter_36_1)
		end
	end

	if next(var_36_0) then
		table.sort(var_36_0, function(arg_37_0, arg_37_1)
			return arg_37_0.order < arg_37_1.order
		end)
	end

	self:updateListData(var_36_0)
	level_manager:is_have_adventure_awards(nil, self.modetype, function(arg_38_0)
		if arg_38_0.result == 1 then
			self.gethaveaward = arg_38_0.awardlist

			self:addRedot()
		else
			self.gethaveaward = arg_38_0.awardlist

			self:addRedot()
		end

		self:initAwardPanel()
	end)
end

function AdventurerUmaruInfiniteLayer:updateListData(arg_39_1)
	level_manager:get_adventure_score(nil, self.modetype, function(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
		if arg_40_0 == 1 then
			self.totalscore = arg_40_1
			self.rank = arg_40_3

			for iter_40_0, iter_40_1 in pairs(arg_40_2) do
				for iter_40_2, iter_40_3 in pairs(arg_39_1) do
					if iter_40_3.mode == iter_40_1.mode then
						iter_40_3.score = iter_40_1.score

						break
					end
				end
			end

			self.data = arg_39_1

			level_manager:setinfiniteScoreInfo(arg_40_2)
			self:initUILayer()
		end
	end)
end

function AdventurerUmaruInfiniteLayer.addRedot(arg_41_0, arg_41_1)
	return
end

function AdventurerUmaruInfiniteLayer.getDropData(arg_42_0, arg_42_1)
	local var_42_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_42_1 = drop_data[arg_42_1] or {}

	if var_42_1.gold then
		var_42_0.gold = var_42_0.gold + var_42_1.gold
	end

	if var_42_1.diamond then
		var_42_0.diamond = var_42_0.diamond + var_42_1.diamond
	end

	local var_42_2 = 1

	if var_42_1["drop_id" .. 1] then
		local var_42_3 = 1

		while var_42_1["drop_id" .. var_42_3] do
			var_42_0.items[var_42_2] = {
				itemid = var_42_1["drop_id" .. var_42_3],
				num = var_42_1["drop_num" .. var_42_3],
				rate = var_42_1["drop_rate" .. var_42_3]
			}
			var_42_3 = var_42_3 + 1
			var_42_2 = var_42_2 + 1
		end
	end

	if var_42_1["dropmodel_id" .. 1] then
		local var_42_4 = 1

		while var_42_1["dropmodel_id" .. var_42_4] do
			if drop_data[var_42_1["dropmodel_id" .. var_42_4]].gold then
				var_42_0.gold = var_42_0.gold + drop_data[var_42_1["dropmodel_id" .. var_42_4]].gold
			end

			if drop_data[var_42_1["dropmodel_id" .. var_42_4]].diamond then
				var_42_0.diamond = var_42_0.diamond + drop_data[var_42_1["dropmodel_id" .. var_42_4]].diamond
			end

			if drop_data[var_42_1["dropmodel_id" .. var_42_4]]["drop_id" .. 1] then
				local var_42_5 = 1

				while drop_data[var_42_1["dropmodel_id" .. var_42_4]]["drop_id" .. var_42_5] do
					var_42_0.items[var_42_2] = {
						itemid = drop_data[var_42_1["dropmodel_id" .. var_42_4]]["drop_id" .. var_42_5],
						num = drop_data[var_42_1["dropmodel_id" .. var_42_4]]["drop_num" .. var_42_5]
					}
					var_42_5 = var_42_5 + 1
					var_42_2 = var_42_2 + 1
				end
			end

			if drop_data[var_42_1["dropmodel_id" .. var_42_4]]["rd_drop_id" .. 1] then
				local var_42_6 = 1

				while drop_data[var_42_1["dropmodel_id" .. var_42_4]]["rd_drop_id" .. var_42_6] do
					var_42_0.items[var_42_2] = {
						itemid = drop_data[var_42_1["dropmodel_id" .. var_42_4]]["rd_drop_id" .. var_42_6],
						num = drop_data[var_42_1["dropmodel_id" .. var_42_4]]["rd_drop_num" .. var_42_6]
					}
					var_42_6 = var_42_6 + 1
					var_42_2 = var_42_2 + 1
				end
			end

			var_42_4 = var_42_4 + 1
		end
	end

	if var_42_1["rd_drop_id" .. 1] then
		local var_42_7 = 1

		while var_42_1["rd_drop_id" .. var_42_7] do
			var_42_0.items[var_42_2] = {
				itemid = var_42_1["rd_drop_id" .. var_42_7],
				num = var_42_1["rd_drop_num" .. var_42_7]
			}
			var_42_7 = var_42_7 + 1
			var_42_2 = var_42_2 + 1
		end
	end

	if var_42_1["rd_dropmodel_id" .. 1] then
		local var_42_8 = 1

		while var_42_1["rd_dropmodel_id" .. var_42_8] do
			if drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]].gold then
				var_42_0.gold = var_42_0.gold + drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]].gold
			end

			if drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]].diamond then
				var_42_0.diamond = var_42_0.diamond + drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]].diamond
			end

			if drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]]["drop_id" .. 1] then
				local var_42_9 = 1

				while drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]]["drop_id" .. var_42_9] do
					var_42_0.items[var_42_2] = {
						itemid = drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]]["drop_id" .. var_42_9],
						num = drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]]["drop_num" .. var_42_9]
					}
					var_42_9 = var_42_9 + 1
					var_42_2 = var_42_2 + 1
				end
			end

			if drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]]["rd_drop_id" .. 1] then
				local var_42_10 = 1

				while drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]]["rd_drop_id" .. var_42_10] do
					var_42_0.items[var_42_2] = {
						itemid = drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]]["rd_drop_id" .. var_42_10],
						num = drop_data[var_42_1["rd_dropmodel_id" .. var_42_8]]["rd_drop_num" .. var_42_10]
					}
					var_42_10 = var_42_10 + 1
					var_42_2 = var_42_2 + 1
				end
			end

			var_42_8 = var_42_8 + 1
		end
	end

	return var_42_0
end

function AdventurerUmaruInfiniteLayer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_44_0)
		if arg_44_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				self:initListView()
			end)
		end
	end), self)
end

function AdventurerUmaruInfiniteLayer:fullScreen(arg_46_1)
	arg_46_1:setContentSize((GameDisplay.getScreenSize()))
	arg_46_1:setPositionY(arg_46_1:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.title_panel:setPositionY(self.title_panel:getPositionY() + 2 * GameDisplay.fix_y)
	self.Listview:setContentSize(cc.size(640, 466 + 2 * GameDisplay.fix_y))
end
