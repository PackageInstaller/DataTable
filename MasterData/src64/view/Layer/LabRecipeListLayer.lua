LabRecipeListLayer = class("LabRecipeListLayer", function()
	return cc.Layer:create()
end)

local item_data = require("data.item_data")
local lab_recipe_data = require("data.lab_recipe_data")
local lab_research_data = require("data.lab_research_data")
local city_data = require("data.city_data")
local sign_manager = require("controller.sign_manager")
local playermodel = require("model.playermodel")
local alert_manager = require("controller.alert_manager")
local audio_manager = require("controller.audio_manager")
local weapon_manager = require("controller.weapon_manager")
local lab_manager = require("controller.lab_manager")
local item_manager = require("controller.item_manager")
local filter_config_manager = require("controller.filter_config_manager")
local drop_manager = require("controller.drop_manager")
local level_manager = require("controller.level_manager")
local lab_recipe_conf_data = require("data.lab_recipe_conf_data")
local time_check_manager = require("controller.time_check_manager")

require("view.Sprite.FilterListSprite")
require("view.Sprite.BottomBtnList")
require("view.Sprite.ItemSprite")

local var_0_16 = config._DEBUG and 0 or 1
local var_0_17

function LabRecipeListLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = LabRecipeListLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LabRecipeListLayer:init(arg_3_1)
	var_0_17 = true

	local var_3_0 = ccui.ImageView:create("mainScenebg/task_bg.jpg")

	var_3_0:setPosition(cc.p(320, 568))
	self:addChild(var_3_0)

	self.selectCallback = arg_3_1.selectCallback
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.rootLayer:setAnchorPoint(cc.p(0, 0))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer)

	self.selectTblAni = true
	self.listType = arg_3_1.listType
	self.goto_back_system_id = arg_3_1.goto_back_system_id
	self.tab = arg_3_1.tab

	self:initBottomList()
	self:createTitle()
	self:initData(function()
		if self.selectType == 1 then
			self:createFilterList()
		end

		self:initTableView()
		self:startEffect()
		self:registerGuidesEvent()
		self:initDisplayValue(self.rootLayer)

		self.selectTblAni = false
	end)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_17 = nil
		end
	end)
end

function LabRecipeListLayer:updateGoldNum()
	if not self.imageGold then
		self.imageGold = ccui.ImageView:create("lab_recipe_list/money.png", var_0_16)

		self.imageGold:setTouchEnabled(true)
		self.imageGold:setPosition(cc.p(self.title:getContentSize().width / 2 + 230, self.title:getContentSize().height / 2))
		self.title:addChild(self.imageGold, 999)

		self.labelGold = cc.Label:createWithTTF(global_trans_number(playermodel.gold), FONT_DES, 20)

		self.labelGold:setPosition(cc.p(self.imageGold:getContentSize().width / 2, self.imageGold:getContentSize().height / 2))
		self.labelGold:setAnchorPoint(cc.p(0.3, 0.5))
		self.imageGold:addChild(self.labelGold, 999)
		self.imageGold:addTouchEventListener(function(arg_7_0, arg_7_1)
			if arg_7_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.touchLock then
				return
			end

			sign_manager:createMidasLayer(function()
				self.labelGold:setString(global_trans_number(playermodel.gold))
			end)
		end)
	else
		self.labelGold:setString(global_trans_number(playermodel.gold))
	end
end

function LabRecipeListLayer:updateElectricNum()
	if not self.imageEle then
		self.imageEle = ccui.ImageView:create("lab_recipe_list/electric.png", var_0_16)

		self.imageEle:setTouchEnabled(true)
		self.imageEle:setPosition(cc.p(self.title:getContentSize().width / 2 + 250, self.title:getContentSize().height / 2))
		self.title:addChild(self.imageEle, 999)

		self.labelEle = cc.Label:createWithTTF(global_trans_number(item_manager:getItemNumber(ELECTRIC)), FONT_DES, 20)

		self.labelEle:setPosition(cc.p(self.imageEle:getContentSize().width / 2, self.imageEle:getContentSize().height / 2))
		self.imageEle:addChild(self.labelEle, 999)
		self.imageEle:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_10_0

			if self.touchLock then
				do return end

				var_10_0 = {}
			end

			function var_10_0.callback()
				if self.labelEle then
					self.labelEle:setString(global_trans_number(item_manager:getItemNumber(ELECTRIC)))
				end
			end

			msg = var_10_0

			LayerManager:pushInLayer("PopElectricSupplyLayer", msg)
		end)
	else
		self.labelEle:setString(global_trans_number(item_manager:getItemNumber(ELECTRIC)))
	end
end

function LabRecipeListLayer:createTitle()
	if self.listType == 2 then
		self.title = TitleSprite:create("lab_recipe_list/title_processlist.png", 2)

		self:updateGoldNum()
	else
		self.title = TitleSprite:create("lab_recipe_list/title_recipelist.png", 2)

		self:updateElectricNum()
	end

	self.title:setPosition(cc.p(0, 1080 + GameDisplay.fix_y))
	self.rootLayer:addChild(self.title, 10)
end

function LabRecipeListLayer:initBottomList()
	local var_13_0 = BottomBtnList:create(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:layerOutAni(function()
			LayerManager:removePopLayer()
		end)
	end)

	var_13_0:setPositionY(-GameDisplay.fix_y)
	self.rootLayer:addChild(var_13_0, 10)
end

function LabRecipeListLayer:createFilterList()
	local var_16_0 = {
		style = "style_lab_recipe",
		hideAll = true,
		defaultSelected = self.selectType,
		bagLayerType = filter_config_manager.LAB_RECIPE,
		filterCallback = function(self)
			self.selectTblAni = true

			for iter_17_0, iter_17_1 in pairs(self.btnState) do
				if iter_17_1 == 1 then
					self.selectType = iter_17_0
				end
			end

			self:changeAttrTypeAfterUpdate()

			self.selectTblAni = false
		end,
		tab = self.tab
	}

	var_16_0.style = self.listType == 2 and "style_lab_research" or "style_lab_recipe"
	self.filterList = FilterListSprite:create(var_16_0)

	self.filterList:setAnchorPoint(cc.p(0, 1))
	self.filterList:setPositionX(0)
	self.filterList:setPositionY(1080 + GameDisplay.fix_y)
	self.rootLayer:addChild(self.filterList, 8)
end

function LabRecipeListLayer:changeAttrTypeAfterUpdate()
	self.tableView:reloadData()
end

function LabRecipeListLayer:initData(arg_19_1)
	self.listData = {}

	if self.listType == 2 then
		for iter_19_0 = 1, 5 do
			self.listData[iter_19_0] = {}
		end

		for iter_19_1, iter_19_2 in pairs(lab_research_data) do
			if self.listData[iter_19_2.tab] and not iter_19_2.hide then
				table.insert(self.listData[iter_19_2.tab], {
					recipe = iter_19_2.id,
					pos = iter_19_2.pos,
					lock = level_manager:isPlayerPassLevel(iter_19_2.recipe_open_limit) and 1 or 2
				})
			end
		end
	else
		for iter_19_3 = 1, 5 do
			self.listData[iter_19_3] = {}
		end

		for iter_19_4, iter_19_5 in pairs(lab_recipe_data) do
			if not iter_19_5.hide then
				table.insert(self.listData[iter_19_5.tab], {
					recipe = iter_19_5.id,
					pos = iter_19_5.pos,
					lock = level_manager:isPlayerPassLevel(iter_19_5.recipe_open_limit) and 1 or 2
				})
			end
		end
	end

	local function var_19_0(...)
		local var_20_0 = {
			[3] = {
				weight = 3,
				func = function(self, arg_23_1)
					local var_23_0 = self:isUnlockRecipe(self.recipe) and 1 or 2
					local var_23_1 = self:isUnlockRecipe(arg_23_1.recipe) and 1 or 2

					if var_23_0 == var_23_1 then
						return "=="
					end

					return var_23_0 < var_23_1
				end
			},
			[2] = {
				weight = 2,
				func = function(self, arg_21_1)
					if self.lock == arg_21_1.lock then
						return "=="
					end

					return self.lock < arg_21_1.lock
				end
			},
			{
				weight = 1,
				func = function(self, arg_22_1)
					if self.pos == arg_22_1.pos then
						return "=="
					end

					return self.pos < arg_22_1.pos
				end
			}
		}

		table.sort(var_20_0, function(arg_24_0, arg_24_1)
			return arg_24_0.weight > arg_24_1.weight
		end)

		local function var_20_1(arg_25_0, arg_25_1)
			for iter_25_0 = 1, #var_20_0 do
				if var_20_0[iter_25_0].func(arg_25_0, arg_25_1) ~= "==" then
					return var_20_0[iter_25_0].func(arg_25_0, arg_25_1)
				end
			end
		end

		for iter_20_0, iter_20_1 in pairs(self.listData) do
			if next(self.listData[iter_20_0]) then
				table.sort(self.listData[iter_20_0], var_20_1)
			end
		end
	end

	self.selectType = self.listType == 2 and lab_recipe_conf_data.research[self.tab][1].id or 1

	if self.listType == 2 then
		lab_manager:get_research_status_list(function(arg_26_0)
			self.researchUnlockList = arg_26_0.research_status_list

			var_19_0()

			if arg_19_1 then
				arg_19_1()
			end
		end)
	else
		var_19_0()

		if arg_19_1 then
			arg_19_1()
		end
	end
end

function LabRecipeListLayer.getOpenLimit(arg_27_0, arg_27_1)
	return (not config.limit_open_system or nil) and 10000
end

function LabRecipeListLayer:isUnlockRecipe(arg_28_1)
	return (({
		function()
			return true
		end,
		function()
			return lab_manager:is_lock_research(self.researchUnlockList, arg_28_1)
		end
	})[self.listType]())
end

function LabRecipeListLayer:getItemid(arg_31_1)
	return self.listType == 2 and lab_research_data[arg_31_1].target or lab_recipe_data[arg_31_1].target
end

function LabRecipeListLayer:getTargetName(arg_32_1)
	local var_32_1 = self:getData()

	return item_data[var_32_1[arg_32_1].target].name .. ((var_32_1[arg_32_1].num or nil) and "X" .. self:getData()[arg_32_1].num)
end

function LabRecipeListLayer:getData()
	if self.listType == 2 then
		return lab_research_data
	else
		return lab_recipe_data
	end
end

function LabRecipeListLayer.updateTableView(arg_34_0)
	return
end

function LabRecipeListLayer:selectRecipe(arg_35_1)
	if self.listType == 2 then
		LayerManager:pushInLayer("PopResearchMake", {
			goto_back_system_id = self.goto_back_system_id,
			research = arg_35_1,
			exitcallback = function()
				self:updateShowingCells()
				self:updateGoldNum()
			end
		})
	else
		self:layerOutAni(function()
			if self.selectCallback then
				self.selectCallback(arg_35_1)
			end

			LayerManager:removePopLayer()
		end)
	end
end

local var_0_18 = {
	"public/box/weapon_bg_white.png",
	"public/box/weapon_bg_green.png",
	"public/box/weapon_bg_blue.png",
	"public/box/weapon_bg_purple.png",
	"public/box/weapon_bg_orange.png",
	"public/box/weapon_bg_red.png"
}
local var_0_19 = 600
local var_0_20 = 200
local var_0_21 = 1000 + 2 * GameDisplay.fix_y
local var_0_22 = {
	70,
	182,
	294,
	406,
	518,
	630
}

function LabRecipeListLayer.createCellSp(arg_38_0)
	local var_38_0 = ccui.Button:create("lab_recipe_list/bg_recipelist.png", nil, nil, var_0_16)

	var_38_0:setTouchEnabled(true)
	var_38_0:setSwallowTouches(false)
	var_38_0:setAnchorPoint(cc.p(0, 0))
	var_38_0:setPosition(cc.p(0, 0))

	local var_38_1 = ccui.ListView:create()

	var_38_1:setDirection(ccui.ScrollViewDir.horizontal)
	var_38_1:setContentSize(380, 120)
	var_38_1:setPosition(cc.p(0, 5))
	var_38_0:addChild(var_38_1)
	var_38_1:setBounceEnabled(true)
	var_38_1:setName("materialsListView")

	local var_38_2 = ccui.Layout:create()

	var_38_2:setContentSize(cc.size(680, 155))
	var_38_1:pushBackCustomItem(var_38_2)

	var_38_0.materialsListLayout = var_38_2

	for iter_38_0 = 1, 6 do
		local var_38_3 = ccui.ImageView:create("lab_recipe_list/frame_material.png", var_0_16)

		var_38_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_38_3:setPositionX(var_0_22[iter_38_0])
		var_38_3:setPositionY(var_38_0:getContentSize().height / 2)
		var_38_3:setName("frame_" .. iter_38_0)
		var_38_2:addChild(var_38_3)

		local var_38_4 = ccui.Button:create(var_0_18[1], var_0_18[1], var_0_18[1], var_0_16)

		var_38_4:setScale(0.66)
		var_38_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_38_4:setName("material_" .. iter_38_0)
		var_38_4:setPositionX(var_38_3:getPositionX())
		var_38_4:setPositionY(var_38_3:getPositionY())
		var_38_4:setTouchEnabled(true)
		var_38_4:setSwallowTouches(false)
		var_38_2:addChild(var_38_4)

		local var_38_5 = ccui.ImageView:create("GUI/image.png", var_0_16)

		var_38_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_38_5:setPositionX(var_38_3:getContentSize().width / 2)
		var_38_5:setPositionY(var_38_3:getContentSize().height / 2)
		var_38_5:setName("icon")
		var_38_4:addChild(var_38_5, 1)

		local var_38_6 = ccui.ImageView:create("public/box/word_black_bg.png", var_0_16)

		var_38_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_38_6:setPositionX(var_38_3:getContentSize().width / 2)
		var_38_6:setPositionY(var_38_3:getContentSize().height / 2 - 30)
		var_38_6:setName("wordBg")
		var_38_4:addChild(var_38_6, 2)

		local var_38_7 = ccui.Text:create("1/1", FONT_DES, 24)

		var_38_7:setPositionX(var_38_6:getPositionX())
		var_38_7:setPositionY(var_38_6:getPositionY())
		var_38_7:setName("numLabel")
		var_38_4:addChild(var_38_7, 3)
		var_38_4:setVisible(false)
		var_38_4:addTouchEventListener(function(arg_39_0, arg_39_1)
			if arg_39_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_39_0:getTouchBeganPosition().y - arg_39_0:getTouchEndPosition().y) > 50 then
				return
			end

			if not arg_38_0:isUnlockRecipe(var_38_0.recipe) then
				return
			end

			if not level_manager:isPlayerPassLevel((arg_38_0:getOpenLimit(var_38_0.recipe))) then
				global_ShowBlockWords(L_COMMON_WARNING.Locking)

				return
			end

			arg_38_0.touchMask = true

			if arg_39_0.ownNum < arg_39_0.needNum then
				local var_39_0 = PopLayer.new()

				LayerManager:pushInLayer("PopGoGainLayer", {
					item = arg_39_0.itemid,
					goto_back_system_id = arg_38_0.goto_back_system_id
				})
			else
				local var_39_1 = {
					itemid = arg_39_0.itemid,
					goto_back_system_id = arg_38_0.goto_back_system_id
				}

				var_39_1.layer = cc.Layer:create()

				PopLayer:Item(var_39_1)
			end
		end)
	end

	local var_38_8 = ccui.ImageView:create("lab_recipe_list/img_clock.png", var_0_16)

	var_38_8:setPosition(cc.p(30, 146))
	var_38_8:setName("timeIcon")
	var_38_0:addChild(var_38_8)

	local var_38_9 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_38_9:setColor(cc.c3b(250, 243, 246))
	var_38_9:setAnchorPoint(cc.p(0, 0.5))
	var_38_9:setPositionX(var_38_8:getPositionX() + var_38_8:getContentSize().width / 2 + 15)
	var_38_9:setPositionY(var_38_8:getPositionY())
	var_38_9:setName("timeLabel")
	var_38_0:addChild(var_38_9)

	local var_38_10 = ccui.ImageView:create("public/currency/electric.png", var_0_16)

	var_38_10:setScale(0.8)
	var_38_10:setPosition(cc.p(170, 142))
	var_38_10:setName("electricImage")
	var_38_10:setVisible(false)
	var_38_0:addChild(var_38_10)

	local var_38_11 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_38_11:setColor(cc.c3b(250, 243, 246))
	var_38_11:setAnchorPoint(cc.p(0, 0.5))
	var_38_11:setPositionX(var_38_10:getPositionX() + var_38_10:getContentSize().width / 2 + 15)
	var_38_11:setPositionY(var_38_10:getPositionY())
	var_38_11:setName("electircLabel")
	var_38_11:setVisible(false)
	var_38_0:addChild(var_38_11)

	local var_38_12 = ccui.ImageView:create("lab_recipe_list/arrow_workshop.png", var_0_16)

	var_38_12:setPositionX(410)
	var_38_12:setPositionY(var_38_0:getContentSize().height / 2)
	var_38_0:addChild(var_38_12)

	local var_38_13 = ccui.ImageView:create("lab_recipe_list/bg_lock_workshop.png", var_0_16)

	var_38_13:setAnchorPoint(cc.p(0.5, 0.5))
	var_38_13:setPositionX(var_38_13:getContentSize().width / 2)
	var_38_13:setPositionY(var_38_0:getContentSize().height / 2)
	var_38_13:setName("backPanel")
	var_38_0:addChild(var_38_13, 10)

	local var_38_14 = cc.Label:createWithTTF("", FONT_DES, 28)

	var_38_14:setColor(cc.c3b(221, 236, 242))
	var_38_14:setPositionX(var_38_13:getPositionX())
	var_38_14:setPositionY(var_38_13:getPositionY() + 15)
	var_38_14:setName("unlockLabel")
	var_38_0:addChild(var_38_14, 11)

	local var_38_15 = cc.Label:createWithTTF(L_UNLOCK, FONT_DES, 32)

	var_38_15:setColor(cc.c3b(221, 236, 242))
	var_38_15:setPositionX(var_38_14:getPositionX())
	var_38_15:setPositionY(var_38_14:getPositionY() - 35)
	var_38_15:setName("unlockTag")
	var_38_0:addChild(var_38_15, 11)

	local var_38_16 = ccui.Button:create("GUI/image.png", "GUI/image.png", "GUI/image.png", var_0_16)

	var_38_16:setSwallowTouches(false)
	var_38_16:setScale9Enabled(true)
	var_38_16:setCapInsets(cc.rect(20, 20, 20, 20))
	var_38_16:setContentSize(cc.size(150, var_38_0:getContentSize().height))
	var_38_16:setAnchorPoint(cc.p(0.5, 0.5))
	var_38_16:setPosition(cc.p(500, var_38_0:getContentSize().height / 2))
	var_38_16:setOpacity(0)
	var_38_0:addChild(var_38_16)

	local var_38_17
	local var_38_18
	local var_38_19 = 0
	local var_38_20

	var_38_16:addTouchEventListener(function(arg_40_0, arg_40_1)
		var_38_20 = arg_40_0:getTouchMovePosition()
		var_38_17 = arg_40_0:getTouchBeganPosition()
		var_38_18 = arg_40_0:getTouchEndPosition()

		if arg_40_1 == ccui.TouchEventType.began then
			arg_40_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				if var_38_20.y ~= 0 and math.abs(var_38_17.y - var_38_20.y) > 50 then
					return
				end

				var_38_19 = 0.2
				arg_38_0.touchMask = true

				PopLayer:Item({
					goto_back_system_id = arg_38_0.goto_back_system_id,
					layer = cc.Layer:create(),
					itemid = arg_38_0:getItemid(var_38_0.recipe)
				})
			end)))
		elseif arg_40_1 == ccui.TouchEventType.canceled then
			arg_40_0:stopAllActions()

			var_38_19 = 0
		elseif arg_40_1 == ccui.TouchEventType.ended then
			arg_40_0:stopAllActions()

			if var_38_19 == 0 then
				if not level_manager:isPlayerPassLevel((arg_38_0:getOpenLimit(var_38_0.recipe))) then
					global_ShowBlockWords(L_COMMON_WARNING.Locking)

					return
				elseif not arg_38_0:isUnlockRecipe(var_38_0.recipe) then
					arg_38_0.touchMask = true

					arg_38_0:showUnlockPop(var_38_0.recipe)
				elseif arg_38_0:isEnough(var_38_0.recipe) then
					arg_38_0.touchMask = true

					arg_38_0:selectRecipe(var_38_0.recipe)
				else
					global_ShowBlockWords(L_LAB_MATERIAL_LACK)
				end
			end

			var_38_19 = 0
		end
	end)
	var_38_0:addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_42_0:getTouchBeganPosition().y - arg_42_0:getTouchEndPosition().y) > 50 then
			return
		end

		local var_42_0 = arg_38_0:getOpenLimit(var_38_0.recipe)

		if arg_38_0.touchMask then
			arg_38_0.touchMask = false

			return
		end

		if not level_manager:isPlayerPassLevel(var_42_0) then
			global_ShowBlockWords(L_COMMON_WARNING.Locking)

			return
		end

		if not arg_38_0:isUnlockRecipe(var_38_0.recipe) then
			arg_38_0:showUnlockPop(var_38_0.recipe)
		elseif arg_38_0:isEnough(var_38_0.recipe) then
			arg_38_0:selectRecipe(var_38_0.recipe)
		else
			global_ShowBlockWords(L_LAB_MATERIAL_LACK)
		end
	end)

	function var_38_0:hideUnlockRecipe()
		local var_43_0 = self:getChildByName("unlockMaterialPanel")

		if var_43_0 then
			var_43_0:setVisible(false)
		end
	end

	function var_38_0:updateUnlockMaterial(arg_44_1)
		if not arg_38_0:isUnlockRecipe(arg_44_1) then
			local var_44_0 = self:getChildByName("unlockMaterialPanel")

			if not var_44_0 then
				var_44_0 = ccui.Layout:create()

				var_44_0:setContentSize(cc.size(436, 160))
				var_44_0:setAnchorPoint(cc.p(0, 0))
				var_44_0:setPosition(cc.p(0, 0))
				var_44_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_44_0:setBackGroundColor(cc.c3b(26, 21, 58))
				var_44_0:setBackGroundColorOpacity(255)
				var_44_0:setName("unlockMaterialPanel")
				self:addChild(var_44_0, 1000)

				local var_44_1 = cc.Label:createWithTTF(L_UNLOCK_NEEDING, FONT_DES, 28)

				var_44_1:setColor(cc.c3b(221, 236, 242))
				var_44_1:setAnchorPoint(cc.p(0, 0))
				var_44_1:setPosition(cc.p(10, var_44_0:getContentSize().height - var_44_1:getContentSize().height - 5))
				var_44_0:addChild(var_44_1)

				local var_44_2 = ccui.Layout:create()

				var_44_2:setContentSize(cc.size(126, 160))
				var_44_2:setAnchorPoint(cc.p(0, 0))
				var_44_2:setPosition(cc.p(var_44_0:getContentSize().width, 0))
				var_44_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_44_2:setBackGroundColor(cc.c3b(0, 0, 0))
				var_44_2:setBackGroundColorOpacity(150)
				var_44_0:addChild(var_44_2, 1000)

				local var_44_3 = ccui.ImageView:create("public/currency/lock.png", var_0_16)

				var_44_3:setPosition(cc.p(var_44_2:getContentSize().width - 10, var_44_2:getContentSize().height - 10))
				var_44_3:setScale(0.8)
				var_44_2:addChild(var_44_3)
			end

			var_44_0:setVisible(true)

			local var_44_4 = 1

			while var_44_0:getChildByName("material_sp_" .. var_44_4) do
				var_44_0:getChildByName("material_sp_" .. var_44_4):setVisible(false)

				var_44_4 = var_44_4 + 1
			end

			local var_44_5 = arg_38_0:getUnlockMaterial(arg_44_1)
			local var_44_6 = 1

			while var_44_5[var_44_6] do
				if var_44_5[var_44_6].costNum == 0 then
					table.remove(var_44_5, var_44_6)
				else
					var_44_6 = var_44_6 + 1
				end
			end

			local var_44_7 = #var_44_5

			for iter_44_0, iter_44_1 in pairs(var_44_5) do
				local var_44_8 = var_44_0:getChildByName("material_sp_" .. iter_44_0)

				if not var_44_8 then
					var_44_8 = ItemSmallSprite:createSmallItem()

					var_44_8:setScale(0.66)
					var_44_8:setSwallowTouches(false)
					var_44_8:setName("material_sp_" .. iter_44_0)
					var_44_8:setInfoTouchEvent(true)
					var_44_8:registerTouchCallback(function()
						arg_38_0.touchMask = true
					end)
					var_44_0:addChild(var_44_8)
				end

				var_44_8:setVisible(true)
				var_44_8:setPositionX((var_44_0:getContentSize().width - 40) / 2 - (iter_44_0 - (var_44_7 + 1) / 2) * (var_44_8:getContentSize().width * 0.7 + 20))
				var_44_8:setPositionY(var_44_0:getContentSize().height / 2 - 18)
				var_44_8:updateSmallItemByItemid(iter_44_1.itemid, iter_44_1.ownNum, iter_44_1.costNum, arg_38_0.goto_back_system_id)
			end
		else
			local var_44_9 = self:getChildByName("unlockMaterialPanel")

			if var_44_9 then
				var_44_9:setVisible(false)
			end
		end
	end

	function var_38_0:update(arg_46_1)
		self.recipe = arg_46_1.recipe

		if self.recipe then
			self:setVisible(true)
		else
			self:setVisible(false)

			return
		end

		if arg_38_0.listType == 2 then
			self:getChildByName("timeLabel"):setString(lab_research_data[self.recipe].recipe_gold)
			self:getChildByName("timeIcon"):loadTexture("public/currency/UI_battleEnd_gold.png", var_0_16)
		else
			self:getChildByName("timeLabel"):setString(string.format("%02d", math.floor(lab_recipe_data[self.recipe].recipe_time / 60)) .. ":" .. string.format("%02d", math.floor(lab_recipe_data[self.recipe].recipe_time % 60)))
			self:getChildByName("timeIcon"):loadTexture("lab_recipe_list/img_clock.png", var_0_16)

			if lab_recipe_data[self.recipe].cost_power then
				self:getChildByName("electricImage"):setVisible(true)
				self:getChildByName("electircLabel"):setVisible(true)
				self:getChildByName("electircLabel"):setString(lab_recipe_data[self.recipe].cost_power)
			else
				self:getChildByName("electricImage"):setVisible(false)
				self:getChildByName("electircLabel"):setVisible(false)
			end
		end

		self:hideUnlockRecipe()

		local var_46_0 = arg_38_0:getOpenLimit(self.recipe)

		if not level_manager:isPlayerPassLevel(var_46_0) then
			self:getChildByName("unlockLabel"):setVisible(true)
			self:getChildByName("backPanel"):setVisible(true)
			self:getChildByName("unlockLabel"):setString(L_CLEAR_CHAPTER .. arg_38_0:getModeDifficulty(var_46_0) .. level_manager:formatModeChapterLevelByPlayerLevel(var_46_0))
			self:getChildByName("unlockTag"):setVisible(true)
		elseif not arg_38_0:isUnlockRecipe(self.recipe) then
			self:updateUnlockMaterial(self.recipe)
			self:getChildByName("unlockLabel"):setVisible(false)
			self:getChildByName("backPanel"):setVisible(true)
			self:getChildByName("unlockTag"):setVisible(true)
		else
			self:getChildByName("unlockLabel"):setVisible(false)
			self:getChildByName("backPanel"):setVisible(false)
			self:getChildByName("unlockTag"):setVisible(false)
		end

		local var_46_1 = arg_38_0:getItemid(self.recipe)

		self:removeChild(self:getChildByName("targetItem"))

		local var_46_2 = ItemSprite:createNewWithItemId(var_46_1, nil, nil, arg_38_0:getTargetName(self.recipe))

		var_46_2:setScale(0.7)
		var_46_2:setPositionY(self:getContentSize().height / 2)
		var_46_2:setPositionX(500)
		var_46_2:setName("targetItem")
		self:addChild(var_46_2)

		for iter_46_0 = 1, 6 do
			local var_46_3 = self.materialsListLayout:getChildByName("material_" .. iter_46_0)

			if arg_38_0:getData()[self.recipe]["material" .. iter_46_0] then
				self.materialsListLayout:getChildByName("frame_" .. iter_46_0):setVisible(false)
				var_46_3:setVisible(true)

				local var_46_4 = arg_38_0:getData()[self.recipe]["material" .. iter_46_0]

				var_46_3.needNum = arg_38_0:getData()[self.recipe]["material" .. iter_46_0 .. "_num"]
				var_46_3.ownNum = item_manager:getItemNumber(var_46_4)
				var_46_3.itemid = var_46_4

				var_46_3:loadTextures(var_0_18[item_data[var_46_3.itemid].equip_quality], var_0_18[item_data[var_46_3.itemid].equip_quality], var_0_18[item_data[var_46_3.itemid].equip_quality], var_0_16)
				var_46_3:getChildByName("icon"):loadTexture("equipment/" .. item_data[var_46_3.itemid].image_id .. ".png")
				var_46_3:getChildByName("icon"):setPosition(cc.p(var_46_3:getContentSize().width / 2, var_46_3:getContentSize().height / 2))
				var_46_3:getChildByName("numLabel"):setString(var_46_3.ownNum .. "/" .. var_46_3.needNum)
				var_46_3:getChildByName("wordBg"):setPositionX(var_46_3:getContentSize().width / 2)
				var_46_3:getChildByName("numLabel"):setPositionX(var_46_3:getContentSize().width / 2)

				if var_46_3.needNum > var_46_3.ownNum then
					flag = true

					var_46_3:getChildByName("numLabel"):setColor(cc.c3b(255, 55, 55))
				else
					var_46_3:getChildByName("numLabel"):setColor(cc.c3b(61, 255, 107))
				end
			else
				self.materialsListLayout:getChildByName("frame_" .. iter_46_0):setVisible(true)
				var_46_3:setVisible(false)
			end
		end
	end

	return var_38_0
end

function LabRecipeListLayer:initTableView()
	local var_47_2 = self.selectType == 1 and 54 or 30
	local var_47_3 = 65

	self.tableView = cc.TableView:create(cc.size(var_0_19, var_0_21))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setPosition(cc.p(var_47_2, var_47_3 - GameDisplay.fix_y))
	self.tableView:setDelegate()
	self.rootLayer:addChild(self.tableView, 1)
	self.tableView:registerScriptHandler(function(arg_48_0, arg_48_1)
		local var_48_0 = arg_48_0:dequeueCell()

		if not var_48_0 then
			var_48_0 = cc.TableViewCell:create()

			var_48_0:setName("cell_" .. arg_48_1)

			local var_48_1 = self:createCellSp()

			var_48_1:setPosition(cc.p(0, 10))
			var_48_1:update(self.listData[self.selectType][arg_48_1 + 1])
			var_48_1:setName("sp")
			var_48_0:addChild(var_48_1)

			local var_48_2 = math.ceil(var_0_21 / var_0_20)

			if arg_48_1 < var_48_2 then
				var_48_1:setPositionX(600)
				var_48_1:runAction(cc.Sequence:create(cc.DelayTime:create((arg_48_1 + 1) * (LAYER_INTO_TIME / var_48_2)), cc.MoveTo:create(LAYER_INTO_TIME / var_48_2, cc.p(0, 10))))
			end
		else
			local var_48_3 = var_48_0:getChildByName("sp")

			var_48_3:stopAllActions()
			var_48_3:setPosition(cc.p(0, 10))
			var_48_3:update(self.listData[self.selectType][arg_48_1 + 1])
		end

		local var_48_4 = math.ceil(var_0_21 / var_0_20)

		if self.startRunOutAni then
			self.startIndex = self.startIndex or arg_48_1

			var_48_0:getChildByName("sp"):runAction(cc.Sequence:create(cc.DelayTime:create((arg_48_1 - self.startIndex) * (LAYER_OUT_TIME / var_48_4)), cc.FadeOut:create(LAYER_OUT_TIME / var_48_4)))
		end

		if self.selectTblAni then
			local var_48_5 = var_48_0:getChildByName("sp")

			var_48_5:setOpacity(0)
			var_48_5:runAction(cc.Sequence:create(cc.DelayTime:create(arg_48_1 * (LAYER_OUT_TIME / var_48_4 * 1.5)), cc.FadeIn:create(LAYER_OUT_TIME / var_48_4 * 1.5)))
		else
			var_48_0:getChildByName("sp"):setOpacity(255)
		end

		return var_48_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_49_0, arg_49_1)
		return self:getCurDataLen()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:registerScriptHandler(function(arg_50_0, arg_50_1)
		return var_0_19, var_0_20
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:reloadData()
end

function LabRecipeListLayer:getCurDataLen()
	return #self.listData[self.selectType]
end

function LabRecipeListLayer:updateShowingCells()
	local var_52_0, var_52_1 = GetTableViewShowCellIdx(self.tableView, {
		cellsize = cc.size(var_0_19, var_0_20),
		maxcount = self:getCurDataLen()
	})

	for iter_52_0 = var_52_0, var_52_1 do
		self.tableView:updateCellAtIndex(iter_52_0)
	end
end

function LabRecipeListLayer:startEffect()
	local var_53_0 = ccui.Layout:create()

	var_53_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_53_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_53_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_53_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_53_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_53_0:setBackGroundColorOpacity(255)
	var_53_0:runAction(cc.FadeOut:create(0.13333333333333333))
	self:addChild(var_53_0, 1000)
end

function LabRecipeListLayer:isEnough(arg_54_1)
	local var_54_0 = 1

	if self.listType == 2 then
		while lab_research_data[arg_54_1]["material" .. var_54_0] do
			if lab_research_data[arg_54_1]["material" .. var_54_0 .. "_num"] * 1 > item_manager:getItemNumber(lab_research_data[arg_54_1]["material" .. var_54_0]) then
				return false
			end

			var_54_0 = var_54_0 + 1
		end
	else
		while lab_recipe_data[arg_54_1]["material" .. var_54_0] do
			if lab_recipe_data[arg_54_1]["material" .. var_54_0 .. "_num"] * 1 > item_manager:getItemNumber(lab_recipe_data[arg_54_1]["material" .. var_54_0]) then
				return false
			end

			var_54_0 = var_54_0 + 1
		end
	end

	if 1 == 0 then
		return false
	end

	return true
end

function LabRecipeListLayer.getModeDifficulty(arg_55_0, arg_55_1)
	local var_55_0 = 1

	::label_55_0::

	local var_55_1

	if city_data[var_55_0] then
		repeat
			var_55_0 = var_55_0 + 1

			goto label_55_0
		until true

		var_55_1 = {
			0,
			city_data[var_55_0 - 1].difficulty1,
			city_data[var_55_0 - 1].difficulty2
		}
	end

	var_55_1[4] = city_data[var_55_0 - 1].difficulty3

	local var_55_2 = 1
	local var_55_3 = math.floor(arg_55_1 / 1000)

	for iter_55_0, iter_55_1 in pairs(var_55_1) do
		if iter_55_1 < var_55_3 then
			var_55_2 = iter_55_0
		end
	end

	return L_LABRECIPE_DIFF_MODE[var_55_2]
end

function LabRecipeListLayer:registerGuidesEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("select_lab_type", function(arg_57_0)
		self:layerOutAni(function()
			LayerManager:removePopLayer()
			LayerManager:removePopLayer()
		end)
	end), self)
end

function LabRecipeListLayer:layerOutAni(arg_59_1)
	self.startRunOutAni = true

	if var_0_17 then
		self:updateShowingCells()
	end

	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME), cc.CallFunc:create(arg_59_1)))
end

function LabRecipeListLayer:initDisplayValue(arg_60_1)
	self.displayPos = global_get_node_display_posy(arg_60_1, {
		Panel_leftup = {
			posY = 686,
			focusName = "Panel_leftup",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		},
		Panel_rightup = {
			posY = 613,
			focusName = "Panel_rightup",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		},
		Panel_unlock = {
			posY = 0,
			focusName = "Panel_unlock",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		},
		Panel_weaponview = {
			posY = 231,
			focusName = "Panel_weaponview",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		},
		Panel_bottom = {
			posY = 0,
			focusName = "Panel_bottom",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		}
	})

	for iter_60_0, iter_60_1 in pairs(self.displayPos) do
		local var_60_0 = ccui.Helper:seekWidgetByName(arg_60_1, iter_60_0)

		if var_60_0 then
			var_60_0:setPositionY(iter_60_1)
		end
	end
end

function LabRecipeListLayer.getUnlockMaterial(arg_61_0, arg_61_1)
	local var_61_0 = {}
	local var_61_1 = 1

	while lab_research_data[arg_61_1]["recipe_unlock_material" .. var_61_1] do
		var_61_1 = var_61_1 + 1

		table.insert(var_61_0, {
			itemid = lab_research_data[arg_61_1]["recipe_unlock_material" .. var_61_1],
			costNum = lab_research_data[arg_61_1]["recipe_unlock_material" .. var_61_1 .. "_num"],
			ownNum = item_manager:getItemNumber(lab_research_data[arg_61_1]["recipe_unlock_material" .. var_61_1])
		})
	end

	if lab_research_data[arg_61_1].recipe_gold_limit then
		local var_61_2 = lab_research_data[arg_61_1].recipe_gold_limit or 0

		table.insert(var_61_0, {
			itemid = "gold",
			costNum = var_61_2,
			ownNum = playermodel.gold
		})
	end

	return var_61_0
end

function LabRecipeListLayer.showUnlockPop(arg_62_0, arg_62_1)
	local var_62_0 = {
		surecallback = function()
			lab_manager:unlock_research(arg_62_1, function(arg_64_0)
				if arg_64_0.result == 1 then
					arg_62_0.researchUnlockList = arg_64_0.research_status_list

					arg_62_0:updateShowingCells()
					arg_62_0:updateGoldNum()
				end
			end)
		end,
		labels = L_UNLOCK_RESEARCH
	}

	var_62_0.labels.titleNewImage = "public/title/title_unlock_items.png"

	LayerManager:pushInLayer("PopDoLayer", var_62_0)
end

function LabRecipeListLayer:exit()
	self:layerOutAni(function()
		LayerManager:removePopLayer()
	end)
end
