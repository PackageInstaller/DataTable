ActivityWordCollectionBaseLayer = class("ActivityWordCollectionBaseLayer", function()
	return cc.Layer:create()
end)

local item_data = require("data.item_data")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = 5
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = {}

var_0_7[1] = "/get_award_btn.png"
var_0_7[2] = "/get_award_btn.png"
var_0_7[3] = "/not_collect.png"
var_0_7[4] = "/un_get_award.png"

local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local activity_collect_data = require("data.activity_collect_data")
local item_word_collect_data = require("data.item_word_collect_data")
local var_0_13 = {
	[806] = 0
}

function ActivityWordCollectionBaseLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityWordCollectionBaseLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityWordCollectionBaseLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId
	self.layerName = activity_manager:getCollectLayerName(self.activityId)

	print("loadLayerTextures:" .. self.layerName)
	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:getWordCollectStatus(self.activityId)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)
end

function ActivityWordCollectionBaseLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_COLLECT_INFO_UPDATE, function(arg_6_0)
		self:updatePanelBoxUI()

		local var_6_0 = activity_manager:getUniversalItemId(self.activityId)

		if var_6_0 and self.lblUniversalNum then
			self.lblUniversalNum:setString(L_UNICERSAL_WORD .. item_manager:getItemNumber(var_6_0))
		end

		self.randomList = activity_manager:getAllWordCollectItem(self.activityId)

		self:updatePanelRandomUI()
	end)
end

function ActivityWordCollectionBaseLayer:initUI()
	self:initBg()
	self:initBottomList()
	self:initPanelUp()
	self:initPanelRandom()
end

function ActivityWordCollectionBaseLayer:initBg()
	self.bg = ccui.ImageView:create(string.format("mainScenebg/activity/branch%d/%s.jpg", self.activityId, self.layerName))

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)
end

function ActivityWordCollectionBaseLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, {
		{
			name = "onekey",
			texture = self.layerName .. "/btn_onekey.png",
			handler = function(arg_11_0, arg_11_1)
				if arg_11_1 ~= ccui.TouchEventType.ended then
					return
				end

				activity_manager:collectItemsOneKey(self.activityId)
			end
		}
	}, self.layerName .. "/return_bg.png", {
		img = self.layerName .. "/btn_return.png",
		pos = cc.p(100, 50)
	})

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 10)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end

function ActivityWordCollectionBaseLayer:initPanelUp()
	self.panelUp = self.rootLayer:getChildByName("img_bottom")
	self.panelBox = self.rootLayer:getChildByName("Panel_box")
	self.panelRandom = self.rootLayer:getChildByName("Panel_random")

	self.panelUp:setPositionY(GameDisplay.height - self.panelUp:getContentSize().height / 2 - GameDisplay.fix_y)
	self.panelUp:getChildByName("btn_detial"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = self.layerName
		})
	end)

	self.timeLbl = self.panelUp:getChildByName("lbl_time")
	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date((activity_manager:get_module_finishtime(self.activityId, "collect"))) - time_check_manager:getCurTime(), function(arg_14_0)
		self.timeLbl:setString(L_ONE_LEFT_TIME_SPACE .. Global_format_time_str(arg_14_0))

		if arg_14_0 <= 0 and self.activityScheduler then
			LayerManager:switchShowLayer("MainLayer")
			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end
	end)))

	self.panelBox:setVisible(true)

	self.btnBox = self.panelUp:getChildByName("btn_box")

	self.bottomList:getChildByName("onekey"):setVisible(false)
	self.btnBox:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.panelBox:isVisible() then
			return
		end

		self.panelBox:setVisible(true)
		self.panelRandom:setVisible(false)
		self.bottomList:getChildByName("onekey"):setVisible(false)
		self.btnBox:loadTextures(self.layerName .. "/box_btn.png", self.layerName .. "/box_btn.png", self.layerName .. "/box_btn.png", var_0_3)
		self.btnRandom:loadTextures(self.layerName .. "/random_un_btn.png", self.layerName .. "/random_un_btn.png", self.layerName .. "/random_un_btn.png", var_0_3)
	end)

	self.btnRandom = self.panelUp:getChildByName("btn_random")

	self.btnRandom:loadTextures(self.layerName .. "/random_un_btn.png", self.layerName .. "/random_un_btn.png", self.layerName .. "/random_un_btn.png", var_0_3)
	self.btnRandom:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.panelRandom:isVisible() then
			return
		end

		local var_16_0, var_16_1 = activity_manager:getCollectRandomStartTime(self.activityId)

		if not var_16_0 then
			global_ShowBlockWords(var_16_1)

			return
		end

		self.panelBox:setVisible(false)
		self.panelRandom:setVisible(true)
		self.bottomList:getChildByName("onekey"):setVisible(true)
		self.btnBox:loadTextures(self.layerName .. "/box_un_btn.png", self.layerName .. "/box_un_btn.png", self.layerName .. "/box_un_btn.png", var_0_3)
		self.btnRandom:loadTextures(self.layerName .. "/random_btn.png", self.layerName .. "/random_btn.png", self.layerName .. "/random_btn.png", var_0_3)
	end)
	self.panelBox:getChildByName("listview_box"):removeFromParent()

	local var_12_0 = activity_manager:getUniversalItemId(self.activityId)
	local var_12_1 = self.panelUp:getChildByName("img_all")

	if not var_12_0 and var_12_1 then
		var_12_1:setVisible(false)

		return
	end

	if var_12_1 then
		self.lblUniversalNum = var_12_1:getChildByName("lbl_num")

		self.lblUniversalNum:setString(L_UNICERSAL_WORD .. item_manager:getItemNumber(var_12_0))
		var_12_1:getChildByName("btn_get"):addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopGoGainLayer", {
				item = var_12_0
			})
		end)
	end
end

function ActivityWordCollectionBaseLayer:initPanelRandom()
	local var_18_0 = self.panelRandom:getChildByName("Image_random_bottom")
	local var_18_1 = var_18_0:getChildByName("Image_random_gift")
	local var_18_2 = var_18_0:getChildByName("panel_touch")

	var_18_1:loadTexture(self.layerName .. "/question.png", var_0_3)
	var_18_1:setScale(var_18_2:getContentSize().height / var_18_1:getContentSize().height * 0.94)
	ccui.Helper:seekWidgetByName(self.panelRandom, "tips_bg"):getChildByName("lbl_tips"):setString(L_WORD_COLLECT_TIPS)

	local var_18_3 = var_18_0:getChildByName("Image_word_bottom")

	var_18_0:setPositionY(GameDisplay.height - self.panelUp:getContentSize().height - GameDisplay.fix_y - 155)
	var_18_3:setContentSize(cc.size(GameDisplay.width - 20, GameDisplay.height - 645))

	self.randomView = var_18_3:getChildByName("listview_random")

	self.randomView:setContentSize(cc.size(GameDisplay.width - 55, self.randomView:getContentSize().height + GameDisplay.fix_y * 2))
	self.randomView:setItemsMargin(0)

	self.randomSelect = {}

	local var_18_4 = activity_manager:getRandomCollectNeedCount(self.activityId) or 0

	for iter_18_0 = 1, var_18_4 do
		local var_18_5 = self:createWrodSprite()

		var_18_5:setPosition(cc.p(120 + (iter_18_0 - 1) * 120, 90))
		var_18_0:addChild(var_18_5)
		var_18_5:setName("select_" .. iter_18_0)
		var_18_5:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.randomSelect[iter_18_0] or not self.randomSelect[iter_18_0].id then
				return
			end

			self:addToRandomList((table.remove(self.randomSelect, iter_18_0)))
			self:updateRandomBottom()
		end)
	end

	local function var_18_6(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if #self.randomSelect < var_18_4 then
			return
		end

		local var_20_0 = {}

		for iter_20_0, iter_20_1 in pairs(self.randomSelect) do
			table.insert(var_20_0, {
				costnum = 1,
				entityid = iter_20_1.id,
				itemid = iter_20_1.id
			})
		end

		self.randomSelect = {}

		self:updateRandomBottom()
		activity_manager:collectRanDomActivityItems(self.activityId, var_20_0)
	end

	var_18_0:getChildByName("btn_get"):addTouchEventListener(var_18_6)
	var_18_2:addTouchEventListener(var_18_6)
end

function ActivityWordCollectionBaseLayer:addToRandomList(arg_21_1)
	for iter_21_0, iter_21_1 in pairs(self.randomList) do
		if arg_21_1.id == iter_21_1.id then
			self.randomList[iter_21_0].hasNum = self.randomList[iter_21_0].hasNum + 1

			break
		end
	end

	self:updatePanelRandomUI()
end

function ActivityWordCollectionBaseLayer:updatePanelBoxUI()
	self.boxDataList = activity_manager:getCollectBoxDataList(self.activityId)

	if self.boxView then
		self:updateShowingCells(self.levelView, self.levelListLen)

		return
	end

	local var_22_0 = self.bottomList:getPositionY() + (var_0_13[self.activityId] or 52)

	self.boxView = cc.TableView:create(cc.size(GameDisplay.width, GameDisplay.height - 450))
	self.cellClone = self.panelBox:getChildByName("box_clone")

	self.boxView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.boxView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.boxView:setAnchorPoint(cc.p(0, 0))
	self.boxView:setPosition(0, var_22_0)
	self.boxView:setDelegate()
	self.panelBox:addChild(self.boxView, 2)
	self.boxView:registerScriptHandler(function(arg_24_0, arg_24_1)
		return GameDisplay.width, self.cellClone:getContentSize().height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.boxView:registerScriptHandler(function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0:dequeueCell()

		if not var_23_0 then
			var_23_0 = cc.TableViewCell:create()

			local var_23_2 = self:createBoxSprite(self.boxDataList[arg_23_1 + 1])

			var_23_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_23_2:setPosition(cc.p(320, self.cellClone:getContentSize().height / 2))
			var_23_2:setScale(1)
			var_23_0:addChild(var_23_2)

			if arg_23_1 < 6 then
				var_23_2:setOpacity(0)
				var_23_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_23_1), cc.FadeIn:create(0.1)))
			end
		else
			self:updateBoxSprite(var_23_0:getChildByTag(100), self.boxDataList[arg_23_1 + 1])
		end

		return var_23_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.boxView:registerScriptHandler(function(arg_25_0, arg_25_1)
		return #self.boxDataList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.boxView:reloadData()
end

function ActivityWordCollectionBaseLayer:createBoxSprite(arg_26_1)
	local var_26_0 = self.cellClone:clone()

	var_26_0:setTouchEnabled(false)
	var_26_0:setName("sprite")
	var_26_0:setTag(100)

	local var_26_1 = var_26_0:getChildByName("img_bottom")
	local var_26_2 = var_26_1:getChildByName("btn_get_reward")
	local var_26_3 = var_26_1:getChildByName("panel_touch")
	local var_26_4 = var_26_1:getChildByName("item_num_bg")

	var_26_2:loadTextures(self.layerName .. var_0_7[arg_26_1.stat], nil, self.layerName .. var_0_7[arg_26_1.stat], var_0_3)
	var_26_2:setGlobalZOrder(10)
	var_26_3:setGlobalZOrder(10)

	local var_26_5 = ccui.Helper:seekWidgetByName(var_26_0, "lbl_limit")

	var_26_5:setString(L_LIMIT .. ":" .. arg_26_1.lessNum .. "/" .. arg_26_1.totalNum)
	var_26_5:setVisible(arg_26_1.totalNum > 0)

	local var_26_6 = ccui.Helper:seekWidgetByName(var_26_0, "lbl_item_num")

	if arg_26_1.drops[1].dropNum <= 1 then
		var_26_6:setString("")
		var_26_4:setVisible(false)
	else
		var_26_6:setString("X" .. arg_26_1.drops[1].dropNum)
		var_26_4:setVisible(true)
	end

	local var_26_8 = 1
	local var_26_9 = (self.activityId == 813 or self.activityId == 888) and 110 or 75
	local var_26_10 = activity_manager:getWordCollectDataByIndex(self.activityId, arg_26_1.index)

	if var_26_10[1].id and var_26_10[1].id > 0 and item_data[var_26_10[1].id].bag_item_type == kITEM_HORCRUX then
		var_26_9 = 180
		var_26_8 = 0.35
	end

	local var_26_11 = ccui.Helper:seekWidgetByName(var_26_0, "img_gift")

	var_26_11:setVisible(true)
	var_26_11:loadTexture("equipment/" .. item_data[arg_26_1.drops[1].dropid].image_id .. ".png")
	var_26_11:setPositionY(var_26_9)
	var_26_11:setScale(var_26_3:getContentSize().height / var_26_11:getContentSize().height * 0.8)

	function var_26_11:afterLoadSuccess(...)
		self:setScale(var_26_3:getContentSize().height / self:getContentSize().height * 0.8)
	end

	local var_26_12 = ccui.Layout:create()

	var_26_12:setName("word_panel")
	var_26_12:setTouchEnabled(false)
	var_26_12:setPosition(var_26_1:convertToNodeSpace((var_26_0:convertToWorldSpace(cc.p(0, 0)))))
	var_26_1:addChild(var_26_12)

	local var_26_13 = #var_26_10

	for iter_26_0 = 1, #var_26_10 do
		local var_26_14 = self:createWrodSprite(var_26_10[iter_26_0])

		var_26_14:setPosition(cc.p(510 / (var_26_13 + 1) * iter_26_0 + 10, (self.activityId == 813 or self.activityId == 855) and 60 or 80))
		var_26_14:setScale(var_26_8 * 0.65)
		var_26_14:getChildByName("numBg"):setVisible(false)

		local var_26_15, var_26_16 = self:getWordBGPath(var_26_10[iter_26_0])
		local var_26_17 = ccui.ImageView:create(var_26_16, var_0_3)

		var_26_14:setColor(var_26_15)
		var_26_17:setScale(1 / var_26_8)
		var_26_17:setName("img_bg")
		var_26_17:setPosition(var_26_14:getContentSize().width / 2, var_26_14:getContentSize().height / 2 - 3)

		function var_26_14:afterLoadSuccess(...)
			if not self:getChildByName("img_bg") then
				return
			end

			self:getChildByName("img_bg"):setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - 3)
		end

		var_26_14:addChild(var_26_17, -1)
		var_26_12:addChild(var_26_14)
		var_26_14:addTouchEventListener(function(arg_29_0, arg_29_1)
			if math.abs(arg_29_0:getTouchBeganPosition().y - arg_29_0:getTouchEndPosition().y) > 20 then
				return
			end

			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_26_10[iter_26_0].id
			})
		end)
	end

	local function var_26_18(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_30_0 = {}

		if arg_26_1.stat == var_0_5 then
			for iter_30_0 = 1, var_26_13 do
				table.insert(var_30_0, {
					itemid = var_26_10[iter_30_0].id,
					costnum = var_26_10[iter_30_0].needNum
				})
			end

			activity_manager:collectActivityItems(self.activityId, arg_26_1.index, var_30_0)
		elseif arg_26_1.stat == var_0_6 then
			local var_30_1 = 0

			for iter_30_1 = 1, var_26_13 do
				local var_30_2 = item_manager:getItemNumber(var_26_10[iter_30_1].id)

				var_30_1 = var_30_1 + math.max(var_26_10[iter_30_1].needNum - var_30_2, 0)

				table.insert(var_30_0, {
					itemid = var_26_10[iter_30_1].id,
					costnum = var_30_2
				})
			end

			table.insert(var_30_0, {
				itemid = activity_manager:getUniversalItemId(self.activityId),
				costnum = var_30_1
			})
			LayerManager:pushInLayer("PopDoLayer", {
				labels = {
					title = L_WORD_COLLECT_TITLE,
					des = string.format(L_WORD_COLLECT_DES, var_30_1),
					button = L_BATTLEPASS_BUY.button
				},
				surecallback = function()
					activity_manager:collectActivityItems(self.activityId, arg_26_1.index, var_30_0)
				end
			})
		else
			showItemDetails(arg_26_1.drops[1].dropid)

			return
		end
	end

	var_26_3:addTouchEventListener(var_26_18)
	var_26_2:addTouchEventListener(var_26_18)

	return var_26_0
end

function ActivityWordCollectionBaseLayer:getWordBGPath(arg_32_1)
	if arg_32_1 and arg_32_1.hasNum and arg_32_1.needNum then
		if arg_32_1.hasNum >= arg_32_1.needNum then
			return cc.c3b(255, 255, 255), self.layerName .. "/item_bg_2.png"
		end

		return cc.c3b(111, 111, 111), self.layerName .. "/item_bg_1.png"
	end

	return ""
end

function ActivityWordCollectionBaseLayer:updateBoxSprite(arg_33_1, arg_33_2)
	arg_33_1:setTag(100)

	local var_33_0 = arg_33_1:getChildByName("img_bottom")
	local var_33_1 = var_33_0:getChildByName("btn_get_reward")
	local var_33_2 = var_33_0:getChildByName("panel_touch")
	local var_33_3 = var_33_0:getChildByName("item_num_bg")

	var_33_1:setGlobalZOrder(10)
	var_33_2:setGlobalZOrder(10)
	var_33_1:loadTextures(self.layerName .. var_0_7[arg_33_2.stat], nil, self.layerName .. var_0_7[arg_33_2.stat], var_0_3)

	local var_33_4 = ccui.Helper:seekWidgetByName(arg_33_1, "lbl_limit")

	var_33_4:setString(L_LIMIT .. ":" .. arg_33_2.lessNum .. "/" .. arg_33_2.totalNum)
	var_33_4:setVisible(arg_33_2.totalNum > 0)

	local var_33_5 = ccui.Helper:seekWidgetByName(arg_33_1, "lbl_item_num")

	if arg_33_2.drops[1].dropNum <= 1 then
		var_33_5:setString("")
		var_33_3:setVisible(false)
	else
		var_33_5:setString("X" .. arg_33_2.drops[1].dropNum)
		var_33_3:setVisible(true)
	end

	local var_33_7 = 1
	local var_33_8 = activity_manager:getWordCollectDataByIndex(self.activityId, arg_33_2.index)[1].id

	if var_33_8 and var_33_8 > 0 and item_data[var_33_8].bag_item_type == kITEM_HORCRUX then
		var_33_7 = 0.35
	end

	local var_33_10 = ccui.Helper:seekWidgetByName(arg_33_1, "img_gift")

	var_33_10:loadTexture("equipment/" .. item_data[arg_33_2.drops[1].dropid].image_id .. ".png")
	var_33_10:setScale(var_33_2:getContentSize().height / var_33_10:getContentSize().height * 0.8)

	local var_33_11 = var_33_0:getChildByName("word_panel")

	var_33_11:setTouchEnabled(false)
	var_33_11:removeAllChildren()

	local var_33_12 = activity_manager:getWordCollectDataByIndex(self.activityId, arg_33_2.index)
	local var_33_13 = #var_33_12

	for iter_33_0 = 1, #var_33_12 do
		local var_33_14 = self:createWrodSprite(var_33_12[iter_33_0])

		var_33_14:setPosition(cc.p(510 / (#var_33_12 + 1) * iter_33_0 + 10, 80))
		var_33_14:setScale(var_33_7 * 0.9)
		var_33_14:getChildByName("numBg"):setVisible(false)

		local var_33_15, var_33_16 = self:getWordBGPath(var_33_12[iter_33_0])
		local var_33_17 = ccui.ImageView:create(var_33_16, var_0_3)

		var_33_14:setColor(var_33_15)
		var_33_17:setScale(1 / (var_33_7 * 0.9))
		var_33_17:setName("img_bg")
		var_33_17:setPosition(var_33_14:getContentSize().width / 2, var_33_14:getContentSize().height / 2 - 3)
		var_33_14:addChild(var_33_17, -1)
		var_33_11:addChild(var_33_14)
		var_33_14:addTouchEventListener(function(arg_34_0, arg_34_1)
			if math.abs(arg_34_0:getTouchBeganPosition().y - arg_34_0:getTouchEndPosition().y) > 20 then
				return
			end

			if arg_34_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_33_12[iter_33_0].id
			})
		end)
	end

	local function var_33_18(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_35_0 = {}

		if arg_33_2.stat == var_0_5 then
			for iter_35_0 = 1, var_33_13 do
				table.insert(var_35_0, {
					itemid = var_33_12[iter_35_0].id,
					costnum = var_33_12[iter_35_0].needNum
				})
			end

			activity_manager:collectActivityItems(self.activityId, arg_33_2.index, var_35_0)
		elseif arg_33_2.stat == var_0_6 then
			local var_35_1 = 0

			for iter_35_1 = 1, var_33_13 do
				local var_35_2 = item_manager:getItemNumber(var_33_12[iter_35_1].id)

				var_35_1 = var_35_1 + math.max(var_33_12[iter_35_1].needNum - var_35_2, 0)

				table.insert(var_35_0, {
					itemid = var_33_12[iter_35_1].id,
					costnum = var_35_2
				})
			end

			table.insert(var_35_0, {
				itemid = activity_manager:getUniversalItemId(self.activityId),
				costnum = var_35_1
			})
			LayerManager:pushInLayer("PopDoLayer", {
				labels = {
					title = L_WORD_COLLECT_TITLE,
					des = string.format(L_WORD_COLLECT_DES, var_35_1),
					button = L_BATTLEPASS_BUY.button
				},
				surecallback = function()
					activity_manager:collectActivityItems(self.activityId, arg_33_2.index, var_35_0)
				end
			})
		else
			showItemDetails(arg_33_2.drops[1].dropid)

			return
		end
	end

	var_33_2:addTouchEventListener(var_33_18)
	var_33_1:addTouchEventListener(var_33_18)
end

function ActivityWordCollectionBaseLayer:updateShowingCells()
	local var_37_0, var_37_1 = GetTableViewShowCellIdx(self.boxView, {
		maxcount = math.ceil(#self.boxDataList),
		cellsize = cc.size(GameDisplay.width, self.cellClone:getContentSize().height)
	})

	for iter_37_0 = var_37_0, var_37_1 do
		self.boxView:updateCellAtIndex(iter_37_0)
	end
end

function ActivityWordCollectionBaseLayer:updatePanelRandomUI()
	self.randomView:removeAllChildren()

	for iter_38_0 = 1, #self.randomList / var_0_4 do
		self.randomView:pushBackCustomItem((self:createRandomPanel(iter_38_0)))
	end
end

function ActivityWordCollectionBaseLayer:createRandomPanel(arg_39_1)
	local var_39_0 = ccui.Layout:create()

	var_39_0:setContentSize(cc.size(640, 115))

	for iter_39_0 = 1, var_0_4 do
		local var_39_1 = self:createWrodSprite(self.randomList[(arg_39_1 - 1) * var_0_4 + iter_39_0])

		var_39_1:setPosition(cc.p(60 + 120 * (iter_39_0 - 1), 50))
		var_39_1:setScale(0.65)
		var_39_0:addChild(var_39_1)
	end

	return var_39_0
end

function ActivityWordCollectionBaseLayer:createWrodSprite(arg_40_1)
	local var_40_1

	if arg_40_1 then
		if arg_40_1.id < 0 then
			var_40_1 = ccui.Button:create(self.layerName .. "/select_bottom.png", self.layerName .. "/select_bottom.png", self.layerName .. "/select_bottom.png", var_0_3)

			goto label_40_0
		end
	end

	var_40_1 = ccui.Button:create("equipment/" .. item_data[arg_40_1.id].image_id .. ".png", "equipment/" .. item_data[arg_40_1.id].image_id .. ".png", "equipment/" .. item_data[arg_40_1.id].image_id .. ".png")

	::label_40_0::

	var_40_1:setSwallowTouches(false)
	var_40_1:addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_40_1 or arg_40_1.id < 0 then
			return
		end

		if arg_40_1.hasNum <= 0 then
			global_ShowBlockWords(L_COLLECT_RANDOM_UN_ENOUGH .. item_data[arg_40_1.id].name)

			return
		end

		if activity_manager:getRandomCollectNeedCount(self.activityId) <= #self.randomSelect then
			return
		end

		arg_40_1.hasNum = arg_40_1.hasNum - 1

		table.insert(self.randomSelect, {
			id = arg_40_1.id,
			hasNum = arg_40_1.hasNum
		})
		self:updateWordSprite(var_40_1, arg_40_1)
		self:updateRandomBottom()
	end)

	local var_40_2 = ccui.ImageView:create(self.layerName .. "/num_bottom.png", var_0_3)

	var_40_2:setPosition(cc.p(65, -10))
	var_40_2:setName("numBg")
	var_40_2:setScale(1.56)
	var_40_1:addChild(var_40_2)

	local var_40_3 = ""

	if arg_40_1 and arg_40_1.hasNum and arg_40_1.needNum then
		var_40_3 = arg_40_1.hasNum .. "/" .. arg_40_1.needNum
	elseif arg_40_1 and arg_40_1.hasNum and not arg_40_1.needNum then
		var_40_3 = "X" .. arg_40_1.hasNum
	end

	local var_40_4 = cc.Label:createWithTTF(var_40_3, FONT_TITLE, 16)

	var_40_4:setName("lbl_Num")
	var_40_4:setPosition(var_40_2:getContentSize().width / 2 + 1, var_40_2:getContentSize().height / 2 - 3)

	if arg_40_1 and arg_40_1.hasNum and arg_40_1.needNum and arg_40_1.hasNum >= arg_40_1.needNum then
		var_40_4:setColor(cc.c3b(102, 192, 96))
	elseif arg_40_1 and arg_40_1.hasNum and not arg_40_1.needNum then
		var_40_4:setColor(cc.c3b(0, 0, 0))
	else
		var_40_4:setColor(cc.c3b(255, 50, 50))
	end

	var_40_2:addChild(var_40_4)
	var_40_2:setVisible(arg_40_1 ~= nil and arg_40_1.id > 0)

	return var_40_1
end

function ActivityWordCollectionBaseLayer:updateWordSprite(arg_42_1, arg_42_2)
	if arg_42_2 then
		if arg_42_2.id < 0 then
			arg_42_1:loadTextures(self.layerName .. "/select_bottom.png", self.layerName .. "/select_bottom.png", self.layerName .. "/select_bottom.png", var_0_3)

			goto label_42_0
		end
	end

	arg_42_1:loadTextures("equipment/" .. item_data[arg_42_2.id].image_id .. ".png", "equipment/" .. item_data[arg_42_2.id].image_id .. ".png", "equipment/" .. item_data[arg_42_2.id].image_id .. ".png")

	::label_42_0::

	local var_42_1 = arg_42_1:getChildByName("numBg")
	local var_42_2 = var_42_1:getChildByName("lbl_Num")
	local var_42_3 = ""

	if arg_42_2 and arg_42_2.hasNum and arg_42_2.needNum then
		var_42_3 = arg_42_2.hasNum .. "/" .. arg_42_2.needNum
	elseif arg_42_2 and arg_42_2.hasNum and not arg_42_2.needNum then
		var_42_3 = "X" .. arg_42_2.hasNum
	end

	if arg_42_2 and arg_42_2.hasNum and arg_42_2.needNum and arg_42_2.hasNum >= arg_42_2.needNum then
		var_42_2:setColor(cc.c3b(102, 192, 96))
	elseif arg_42_2 and arg_42_2.hasNum and not arg_42_2.needNum then
		var_42_2:setColor(cc.c3b(0, 0, 0))
	else
		var_42_2:setColor(cc.c3b(255, 50, 50))
	end

	var_42_2:setString(var_42_3)
	var_42_1:setVisible(arg_42_2 ~= nil and arg_42_2.id > 0)

	if arg_42_2 and arg_42_2.id > 0 and item_data[arg_42_2.id].bag_item_type == kITEM_HORCRUX then
		arg_42_1:setScale(0.35)
	else
		arg_42_1:setScale(1)
	end
end

function ActivityWordCollectionBaseLayer:updateRandomBottom()
	local var_43_0 = activity_manager:getRandomCollectNeedCount(self.activityId)
	local var_43_1 = self.panelRandom:getChildByName("Image_random_bottom")
	local var_43_2 = var_43_1:getChildByName("btn_get")

	for iter_43_0 = 1, var_43_0 do
		local var_43_3 = var_43_1:getChildByName("select_" .. iter_43_0)

		self:updateWordSprite(var_43_3, self.randomSelect[iter_43_0])
		var_43_3:getChildByName("numBg"):setVisible(false)
	end

	if var_43_0 <= #self.randomSelect then
		var_43_2:loadTextures(self.layerName .. "/get_award_btn.png", nil, self.layerName .. "/get_award_btn.png", var_0_3)
	else
		var_43_2:loadTextures(self.layerName .. "/not_collect.png", nil, self.layerName .. "/not_collect.png", var_0_3)
	end
end
