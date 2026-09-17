DropDetailsLayer = class("DropDetailsLayer", function()
	return cc.Layer:create()
end)

require("view.Layer.PublicityLayer")
require("view.Sprite.ItemSprite")
require("view.Layer.EquipLayer")
require("view.Layer.DetailsofHelpGirlLayer")
require("view.Layer.WeaponLayer")

local RichTextPro = require("view.Sprite.RichTextPro")
local item_data = require("data.item_data")
local horcrux_data = require("data.horcrux_data")
local photofile_HelpGirl_data = require("data.photofile_HelpGirl_data")
local var_0_4 = require("data.item_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local playermodel = require("model.playermodel")
local var_0_9 = config._DEBUG and 0 or 1
local var_0_10 = 3
local var_0_11 = 194
local var_0_12 = 248
local var_0_14 = 20
local var_0_15 = 601
local var_0_16 = 40
local var_0_17 = 65
local var_0_18 = {
	"DropItemDisplay/title_dropdetails.png",
	"TwistEgg/twisteggdetail.png",
	"TwistEgg/twisteggdetail.png",
	"TwistEgg/twisteggdetail.png",
	"DropItemDisplay/title_dropdetails.png"
}
local var_0_19 = {
	"DropItemDisplay/title1_dropdetails.png",
	"DropItemDisplay/title2_dropdetails.png",
	"DropItemDisplay/title3_dropdetails.png",
	"DropItemDisplay/title4_dropdetails.png"
}
local var_0_20 = {
	"DropItemDisplay/title_flopdrop_champion.png",
	"DropItemDisplay/title_flopdrop_now.png",
	"DropItemDisplay/title_flopdrop_all.png"
}

function DropDetailsLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = DropDetailsLayer.new()

	var_2_0:init(arg_2_1.callback, arg_2_1.category, arg_2_1.items_tbl, arg_2_1.words_tbl, arg_2_1.chapter_info)

	return var_2_0
end

function DropDetailsLayer:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "DropItemDisplay.json" or "DropItemDisplay.ExportJson")

	self:addChild(self.rootLayer)

	self.panel_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bg")

	self.panel_bg:setBackGroundImage("mainScenebg/hocruxbg.jpg")

	self.img_title = ccui.Helper:seekWidgetByName(self.rootLayer, "image_title")
	self.listview = ccui.Helper:seekWidgetByName(self.rootLayer, "listview")
	self.panel_bg_items = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bg_items")
	self.panel_bg_words = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bg_words")
	self.items_bg = self.panel_bg_items:getChildByName("items_bg")

	self.items_bg:setAnchorPoint(cc.p(0.5, 0))
	self.items_bg:setPosition(cc.p(320, 20))

	self.panel_items = self.items_bg:getChildByName("panel_items")
	self.words_bg = self.panel_bg_words:getChildByName("words_bg")

	self.words_bg:setAnchorPoint(cc.p(0.5, 0))
	self.words_bg:setPosition(cc.p(320, 20))

	self.panel_words = self.words_bg:getChildByName("panel_words")

	self.listview:setVisible(false)
	self.listview:setPositionX(1500)

	self.egg_pool_type = arg_3_2.egg_pool_type

	self:loadImgTitle(var_0_18[arg_3_2.type])

	if arg_3_5 and next(arg_3_5) ~= nil then
		self:createChapterInfoDisplay(arg_3_5)
	end

	if arg_3_4 and next(arg_3_4) ~= nil then
		for iter_3_0 = 1, #arg_3_4 do
			self:createWordsDisplay(arg_3_4[iter_3_0].content, arg_3_4.type_tbl[arg_3_4[iter_3_0].attribute])
		end
	else
		self.words_bg:removeFromParent()
	end

	if arg_3_3 and next(arg_3_3) ~= nil then
		self:createItemsDisplay(arg_3_3, arg_3_2)
	else
		self.items_bg:removeFromParent()
	end

	self:cleanUI()
	self.listview:setVisible(true)
	self:initBottomList(arg_3_2)
	self:fullScreen()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and arg_3_1 then
			arg_3_1()
		end
	end)
	self:playEnterOrOutAni(true)
end

function DropDetailsLayer:fullScreen()
	local var_5_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "top_bg")

	var_5_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 0, TRANSFORM_UNIT.PX)

	var_5_0:setPositionY(var_5_0.full_posY)

	local var_5_1 = self:getChildByName("bottombg")

	var_5_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 0, TRANSFORM_UNIT.PX)

	var_5_1:setPositionY(var_5_1.full_posY)

	self.listview.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.listview:getPositionY(), TRANSFORM_UNIT.PX)

	self.listview:setPositionY(self.listview.full_posY)
	self.listview:setContentSize(cc.size(self.listview:getContentSize().width, self.listview:getContentSize().height + GameDisplay.height - GameDisplay.notch_height - config._DESIGN_HEIGHT))
end

function DropDetailsLayer:loadImgTitle(arg_6_1)
	self.img_title:loadTexture(arg_6_1, var_0_9)
end

function DropDetailsLayer.sortSoulsRarity(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		local var_7_2 = 1

		var_7_2 = item_data[iter_7_1.itemid].servant and servant_data[item_data[iter_7_1.itemid].servant].roll_rarity + 100 or item_data[iter_7_1.itemid].rarity or item_data[iter_7_1.itemid].equip_quality
		var_7_0[var_7_2] = var_7_0[var_7_2] or {
			rarity = var_7_2
		}

		table.insert(var_7_0[var_7_2], {
			itemid = iter_7_1.itemid
		})
	end

	local var_7_4 = {}

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		table.insert(var_7_4, iter_7_3)
	end

	table.sort(var_7_4, function(arg_8_0, arg_8_1)
		return arg_8_0.rarity > arg_8_1.rarity
	end)

	return var_7_4
end

function DropDetailsLayer.sortSkinRarity(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		if item_data[iter_9_1.itemid].bag_item_type == kITEM_SKIN then
			if item_data[iter_9_1.itemid].skintype == 1 then
				var_9_0.spring = var_9_0.spring or {}

				table.insert(var_9_0.spring, {
					itemid = iter_9_1.itemid
				})
			else
				var_9_0.common = var_9_0.common or {}

				table.insert(var_9_0.common, {
					itemid = iter_9_1.itemid
				})
			end
		else
			var_9_1[item_data[iter_9_1.itemid].bag_item_type] = var_9_1[item_data[iter_9_1.itemid].bag_item_type] or {}

			table.insert(var_9_1[item_data[iter_9_1.itemid].bag_item_type], {
				itemid = iter_9_1.itemid
			})
		end
	end

	local var_9_2 = {}

	if var_9_0.spring then
		table.insert(var_9_2, {
			title = "春节",
			itemtype = kITEM_SKIN,
			items = var_9_0.spring
		})
	end

	if var_9_0.common then
		table.insert(var_9_2, {
			title = "服装",
			itemtype = kITEM_SKIN,
			items = var_9_0.common
		})
	end

	for iter_9_2, iter_9_3 in pairs(var_9_1) do
		table.insert(var_9_2, {
			itemtype = iter_9_2,
			items = iter_9_3
		})
	end

	return var_9_2
end

function DropDetailsLayer:createItemsDisplay(arg_10_1, arg_10_2)
	local var_10_0 = false

	for iter_10_0 = 1, #arg_10_1 do
		for iter_10_1, iter_10_2 in pairs(arg_10_1[iter_10_0].content) do
			if item_data[iter_10_2.itemid].bag_item_type == kITEM_SKIN then
				var_10_0 = true

				break
			end
		end

		if var_10_0 then
			break
		end
	end

	if arg_10_2.egg_pool_type == 4 or not arg_10_2.egg_pool_type and arg_10_2.type == 1 then
		self.listview:setItemsMargin(-40)

		self.nodes = {}

		for iter_10_3 = 1, #arg_10_1 do
			self.listview:pushBackCustomItem((self:createItemsDisplayByType(arg_10_1[iter_10_3].content, arg_10_1.type_tbl[arg_10_1[iter_10_3].attribute], arg_10_2)))
		end
	elseif arg_10_2.activityFlop == 1 then
		self.listview:setItemsMargin(-40)

		self.nodes = {}

		for iter_10_4 = 1, #arg_10_1 do
			self.listview:pushBackCustomItem((self:createItemsDisplayByTypeFlop(arg_10_1[iter_10_4].content, arg_10_1[iter_10_4].attribute, arg_10_2)))
		end
	elseif var_10_0 then
		for iter_10_5 = 1, #arg_10_1 do
			if arg_10_1[iter_10_5].attribute == 999 then
				self.listview:pushBackCustomItem((self:createSkinTwistPanel({
					rarity = 999,
					content = arg_10_1[iter_10_5].content
				})))
			else
				for iter_10_6, iter_10_7 in ipairs((self:sortSkinRarity(arg_10_1[iter_10_5].content))) do
					self.listview:pushBackCustomItem(iter_10_7.itemtype == kITEM_SKIN and self:createSkinTwistPanel({
						content = iter_10_7.items,
						name = iter_10_7.title
					}) or self:createItemsDisplayByType(iter_10_7.items, arg_10_1.type_tbl and arg_10_1.type_tbl[arg_10_1[iter_10_5].attribute], arg_10_2))
				end
			end
		end
	else
		for iter_10_8 = 1, #arg_10_1 do
			if arg_10_1[iter_10_8].attribute == 1 then
				for iter_10_9, iter_10_10 in pairs((self:sortSoulsRarity(arg_10_1[iter_10_8].content, arg_10_2.egg_pool_type))) do
					self.listview:pushBackCustomItem((self:createItemsDisplayByTypeOld(iter_10_10, arg_10_1.type_tbl[arg_10_1[iter_10_8].attribute], arg_10_2, iter_10_10.rarity, arg_10_2.egg_pool_type)))
				end
			elseif arg_10_1[iter_10_8].attribute == 999 then
				self.listview:pushBackCustomItem((self:createItemsDisplayByTypeOld(arg_10_1[iter_10_8].content, arg_10_1.type_tbl[arg_10_1[iter_10_8].attribute], arg_10_2, arg_10_1[iter_10_8].attribute)))
			else
				self.listview:pushBackCustomItem((self:createItemsDisplayByTypeOld(arg_10_1[iter_10_8].content, arg_10_1.type_tbl[arg_10_1[iter_10_8].attribute], arg_10_2, 5)))
			end
		end
	end
end

local function var_0_21(arg_11_0)
	local var_11_0 = {}

	for iter_11_0 = 1, #arg_11_0 do
		local var_11_1 = false

		for iter_11_1 = 1, #var_11_0 do
			if item_data[arg_11_0[iter_11_0].itemid].equip_quality == item_data[var_11_0[iter_11_1].itemid].equip_quality then
				if item_data[arg_11_0[iter_11_0].itemid].bag_item_type ~= kITEM_HERO then
					if arg_11_0[iter_11_0].itemid < var_11_0[iter_11_1].itemid then
						table.insert(var_11_0, iter_11_1, {
							itemid = arg_11_0[iter_11_0].itemid
						})

						var_11_1 = true

						break
					end
				elseif arg_11_0[iter_11_0].itemid > var_11_0[iter_11_1].itemid then
					table.insert(var_11_0, iter_11_1, {
						itemid = arg_11_0[iter_11_0].itemid
					})

					var_11_1 = true

					break
				end
			elseif item_data[arg_11_0[iter_11_0].itemid].equip_quality < item_data[var_11_0[iter_11_1].itemid].equip_quality then
				-- block empty
			elseif item_data[arg_11_0[iter_11_0].itemid].equip_quality > item_data[var_11_0[iter_11_1].itemid].equip_quality then
				table.insert(var_11_0, iter_11_1, {
					itemid = arg_11_0[iter_11_0].itemid
				})

				var_11_1 = true

				break
			end
		end

		if var_11_1 == false then
			table.insert(var_11_0, {
				itemid = arg_11_0[iter_11_0].itemid
			})
		end
	end

	return var_11_0
end

local function var_0_22(arg_12_0)
	return ATTR_INDEX[arg_12_0.attr]
end

function DropDetailsLayer:createItemsDisplayByTypeOld(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	local var_13_1 = var_0_21(arg_13_1)

	if arg_13_5 == 232 then
		local var_13_2 = {}

		for iter_13_0 = 1, #var_13_1 do
			table.insert(var_13_2, var_13_1[iter_13_0])
		end

		local var_13_3 = {}

		for iter_13_1, iter_13_2 in pairs((require("data.twist_config.twist_hq_pos_fool"))) do
			var_13_3[iter_13_2.id] = iter_13_2.pos_hq
		end

		table.sort(var_13_2, function(arg_14_0, arg_14_1)
			return ((var_13_3[arg_14_0.itemid] or nil) and var_13_3[arg_14_0.itemid]) < ((var_13_3[arg_14_1.itemid] or nil) and var_13_3[arg_14_1.itemid])
		end)

		var_13_1 = var_13_2
	end

	if item_data[var_13_1[1].itemid].bag_item_type == kITEM_HERO then
		for iter_13_3, iter_13_4 in pairs(var_13_1) do
			iter_13_4.attr = global_get_model_attr(servant_data[item_data[iter_13_4.itemid].servant].modelid)
		end

		global_sort_by_weight(var_13_1, {
			{
				weight = 2,
				func = var_0_22
			}
		})
	end

	local var_13_4 = self.panel_bg_items:clone()
	local var_13_5 = var_13_4:getChildByName("items_bg")

	var_13_5:loadTexture("public/panelbg/drop_info_bg.png", var_0_9)

	local var_13_6 = var_13_5:getChildByName("label_type")

	var_13_6:setVisible(false)

	local var_13_7 = var_13_5:getChildByName("panel_items")

	local function var_13_8(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_2 % var_0_10 == 0 then
			arg_15_0 = arg_15_0 - 2 * var_0_11
			arg_15_1 = arg_15_1 - var_0_12
		else
			arg_15_0 = arg_15_0 + var_0_11
		end

		return arg_15_0, arg_15_1
	end

	local var_13_9 = var_0_12 * math.ceil(#var_13_1 / 3) - 10
	local var_13_10 = 107
	local var_13_11 = var_13_9

	for iter_13_5 = 1, #var_13_1 do
		local var_13_12 = ItemSprite:createNewWithItemId(var_13_1[iter_13_5].itemid, nil, nil, nil, var_13_1[iter_13_5].item_attr, 1, nil, true)

		var_13_12:setAnchorPoint(cc.p(0.5, 1))
		var_13_12:setPosition(cc.p(var_13_10, var_13_9))

		local var_13_13 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "", var_0_9)

		var_13_13:setContentSize(cc.size(174, 228))
		var_13_13:setSwallowTouches(false)
		var_13_13:setOpacity(0)
		var_13_13:setAnchorPoint(cc.p(0, 0))
		var_13_13:setColor(cc.c3b(255, 255, 255))
		var_13_13:setTouchEnabled(true)
		var_13_13:setPosition(cc.p(0, 0))
		var_13_12:addChild(var_13_13)
		var_13_13:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_16_0:getTouchBeganPosition().y - arg_16_0:getTouchEndPosition().y) > 30 then
				return
			end

			var_13_12:setTouchEnabled(false)

			arg_16_0.itemid = var_13_1[iter_13_5].itemid

			self:showItemDeatil(arg_16_0)
		end)

		var_13_10, var_13_11 = var_13_8(var_13_10, var_13_9, 1)

		var_13_7:addChild(var_13_12)

		if item_data[var_13_1[iter_13_5].itemid].bag_item_type == kITEM_HERO and playermodel.haveServant[item_data[var_13_1[iter_13_5].itemid].servant] then
			local var_13_15 = ccui.ImageView:create("DropItemDisplay/have_icon.png", var_0_9)

			var_13_15:setAnchorPoint(0, 1)
			var_13_12:addChild(var_13_15)
			var_13_15:setPosition(0, var_13_12:getContentSize().height)
		end
	end

	var_13_7:setContentSize(cc.size(var_0_15, var_13_9 + var_0_14))

	local var_13_16 = var_13_5:getContentSize()

	var_13_5:setCapInsets(cc.rect(0, 100, var_13_16.width, 5))
	var_13_5:setContentSize(cc.size(var_13_16.width, var_13_9 + var_0_14 + var_0_17))
	var_13_4:setContentSize(cc.size(640, var_13_9 + var_0_14 + var_0_17 + var_0_16))

	if arg_13_4 then
		local var_13_17 = ccui.ImageView:create(RARITY_RECRUIT[arg_13_4], var_0_9)

		var_13_17:setAnchorPoint(cc.p(0, 0.5))
		var_13_17:setPosition(cc.p(var_13_6:getPositionX() + 12, var_13_5:getContentSize().height - var_13_17:getContentSize().height / 2 + 8))
		var_13_5:addChild(var_13_17, 99)
	else
		local var_13_18 = cc.Label:createWithTTF("1", FONT_DES, 30)

		var_13_18:setAnchorPoint(cc.p(0, 0.5))
		var_13_18:setColor(cc.c3b(255, 255, 255))
		var_13_18:setPosition(var_13_6:getPosition())
		var_13_18:setString(arg_13_2)
		var_13_5:addChild(var_13_18, 100)
		var_13_18:setPosition(cc.p(var_13_6:getPositionX() + 30, var_13_9 + var_0_14 + var_0_17 - 30))
	end

	return var_13_4
end

function DropDetailsLayer:createItemsDisplayByTypeFlop(arg_17_1, arg_17_2, arg_17_3)
	local var_17_1 = self.panel_bg_items:clone()
	local var_17_2 = var_17_1:getChildByName("items_bg")
	local var_17_3 = var_17_2:getChildByName("label_type")

	var_17_3:loadTexture(var_0_20[arg_17_2], var_0_9)

	local var_17_4 = var_17_2:getChildByName("panel_items")

	local function var_17_5(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = 5
		local var_18_1 = 124.03999999999999
		local var_18_2 = 163.68

		if type and type == L_FIGHT_RESULT_LEVLE_DROP_DATA.raredata then
			var_18_0 = 4
			var_18_1 = 147.9
			var_18_2 = 140.25
		end

		if arg_18_2 % var_18_0 == 0 then
			arg_18_0 = arg_18_0 - (var_18_0 - 1) * var_18_1
			arg_18_1 = arg_18_1 - var_18_2
		else
			arg_18_0 = arg_18_0 + var_18_1
		end

		return arg_18_0, arg_18_1
	end

	local var_17_6 = 163.68 * math.ceil(#arg_17_1 / 5)
	local var_17_7 = 52
	local var_17_8 = var_17_6
	local var_17_9 = 1

	if type == L_FIGHT_RESULT_LEVLE_DROP_DATA.raredata then
		var_17_6 = 140.25 * math.ceil(#arg_17_1 / 4)
		var_17_9 = 1
		var_17_8 = var_17_6
		var_17_7 = 65
	end

	for iter_17_0 = 1, #arg_17_1 do
		local var_17_10

		if type == L_FIGHT_RESULT_LEVLE_DROP_DATA.raredata then
			var_17_10 = ItemPurchaseSprite:createPurchaseItem(arg_17_1[iter_17_0].itemid, nil, true)

			var_17_10:setScale(0.85)
			var_17_10:setPosition(cc.p(var_17_7, var_17_8 + 30))
			var_17_10:setAnchorPoint(cc.p(0.5, 1))
		else
			if arg_17_1[iter_17_0].details then
				var_17_10 = ItemSprite:createNewWithItemId(arg_17_1[iter_17_0].itemid, nil, nil, arg_17_1[iter_17_0].details, arg_17_1[iter_17_0].item_attr)

				var_17_10:getChildByName("itemName"):setScale(1.2)

				local var_17_11 = cc.Label:createWithTTF("x" .. arg_17_1[iter_17_0].itemNum, FONT_NAME, 30)

				var_17_11:setAnchorPoint(cc.p(1, 0))
				var_17_11:setPositionX(var_17_10:getContentSize().width - 5)
				var_17_11:setPositionY(60)
				var_17_10:addChild(var_17_11, 99)
			else
				var_17_10 = ItemSprite:createNewWithItemId(arg_17_1[iter_17_0].itemid, arg_17_1[iter_17_0].itemNum, nil, arg_17_1[iter_17_0].details, arg_17_1[iter_17_0].item_attr)
			end

			var_17_10:setAnchorPoint(cc.p(0.5, 1))
			var_17_10:setPosition(cc.p(var_17_7, var_17_8 + 30))
			var_17_10:setScale(0.66)
		end

		function var_17_10:setChampionAni()
			ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("flop.ExportJson")

			local var_19_0 = ccs.Armature:create("flop")

			var_19_0:setPosition(self._spriteIcon:getContentSize().width / 2, self._spriteIcon:getContentSize().height / 2)
			var_19_0:getAnimation():play("Animation1")
			var_19_0:setName("flopAni")
			var_19_0:setScale(1.4)
			self._spriteIcon:addChild(var_19_0)
		end

		if arg_17_2 == 3 and arg_17_3.activityFlopLevel == iter_17_0 then
			var_17_10:setChampionAni()
			var_17_10:setColor(cc.c3b(255, 255, 255))
		elseif arg_17_2 == 3 and iter_17_0 < arg_17_3.activityFlopLevel then
			var_17_10:setColor(cc.c3b(133, 133, 133))
		else
			var_17_10:setColor(cc.c3b(255, 255, 255))
		end

		local var_17_12 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "", var_0_9)

		if nametype == 1 then
			var_17_12:setContentSize(cc.size(174, 165))
		else
			var_17_12:setContentSize(cc.size(174, 228))
		end

		var_17_12:setSwallowTouches(false)
		var_17_12:setOpacity(0)
		var_17_12:setAnchorPoint(cc.p(0, 0))
		var_17_12:setColor(cc.c3b(255, 255, 255))
		var_17_12:setTouchEnabled(true)
		var_17_12:setPosition(cc.p(0, 0))
		var_17_10:addChild(var_17_12)
		var_17_12:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_20_0:getTouchBeganPosition().y - arg_20_0:getTouchEndPosition().y) > 30 then
				return
			end

			var_17_10:setTouchEnabled(false)

			arg_20_0.itemid = arg_17_1[iter_17_0].itemid

			self:showItemDeatil(arg_20_0)
		end)

		var_17_7, var_17_8 = var_17_5(var_17_7, var_17_8, var_17_9)

		var_17_4:addChild(var_17_10)

		var_17_9 = var_17_9 + 1
	end

	var_17_4:setContentSize(cc.size(var_0_15, var_17_6 + var_0_14))

	local var_17_13 = var_17_2:getContentSize()

	var_17_2:setCapInsets(cc.rect(0, 100, var_17_13.width, 5))
	var_17_2:setContentSize(cc.size(var_17_13.width, var_17_6 + var_0_14 + var_0_17))
	var_17_1:setContentSize(cc.size(640, var_17_6 + var_0_14 + var_0_17 + var_0_16))
	var_17_3:setPosition(cc.p(var_17_3:getPositionX(), var_17_6 + var_0_14 + var_0_17 - 10))

	return var_17_1
end

function DropDetailsLayer:createItemsDisplayByType(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = var_0_21(arg_21_1)

	if arg_21_2 == L_COMPONENT_TEXT.Component then
		var_21_0 = arg_21_1
	end

	local var_21_1 = 2

	if arg_21_2 == L_FIGHT_RESULT_LEVLE_DROP_DATA.raredata then
		var_21_1 = 1
	elseif arg_21_2 == L_FIGHT_RESULT_LEVLE_DROP_DATA.commondata then
		var_21_1 = 2
	elseif arg_21_2 == L_FIGHT_RESULT_LEVLE_DROP_DATA.sciencedata then
		var_21_1 = 3
	elseif arg_21_2 == L_FIGHT_RESULT_LEVLE_DROP_DATA.componentdata then
		var_21_1 = 4
	end

	local var_21_2 = self.panel_bg_items:clone()
	local var_21_3 = var_21_2:getChildByName("items_bg")
	local var_21_4 = var_21_3:getChildByName("label_type")

	var_21_4:loadTexture(var_0_19[var_21_1], var_0_9)

	local var_21_5 = var_21_3:getChildByName("panel_items")

	local function var_21_6(arg_22_0, arg_22_1, arg_22_2)
		local var_22_0 = 5
		local var_22_1 = 124.03999999999999
		local var_22_2 = 163.68

		if arg_21_2 and arg_21_2 == L_FIGHT_RESULT_LEVLE_DROP_DATA.raredata then
			var_22_0 = 4
			var_22_1 = 147.9
			var_22_2 = 140.25
		end

		if arg_22_2 % var_22_0 == 0 then
			arg_22_0 = arg_22_0 - (var_22_0 - 1) * var_22_1
			arg_22_1 = arg_22_1 - var_22_2
		else
			arg_22_0 = arg_22_0 + var_22_1
		end

		return arg_22_0, arg_22_1
	end

	local var_21_7 = 163.68 * math.ceil(#var_21_0 / 5)
	local var_21_8 = 52
	local var_21_9 = var_21_7
	local var_21_10 = 1

	if arg_21_2 == L_FIGHT_RESULT_LEVLE_DROP_DATA.raredata then
		var_21_7 = 140.25 * math.ceil(#var_21_0 / 4)
		var_21_10 = 1
		var_21_9 = var_21_7
		var_21_8 = 65
	end

	for iter_21_0 = 1, #var_21_0 do
		local var_21_11

		if arg_21_2 == L_FIGHT_RESULT_LEVLE_DROP_DATA.raredata then
			var_21_11 = ItemPurchaseSprite:createPurchaseItem(var_21_0[iter_21_0].itemid, nil, true)

			var_21_11:setScale(0.85)
			var_21_11:setPosition(cc.p(var_21_8, var_21_9 + 30))
			var_21_11:setAnchorPoint(cc.p(0.5, 1))
		else
			var_21_11 = ItemSprite:createNewWithItemId(var_21_0[iter_21_0].itemid, nil, nil, nil, var_21_0[iter_21_0].item_attr)

			var_21_11:setAnchorPoint(cc.p(0.5, 1))
			var_21_11:setPosition(cc.p(var_21_8, var_21_9 + 30))
			var_21_11:setScale(0.66)
		end

		local var_21_12 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "", var_0_9)

		if var_21_1 == 1 then
			var_21_12:setContentSize(cc.size(174, 165))
		else
			var_21_12:setContentSize(cc.size(174, 228))
		end

		var_21_12:setSwallowTouches(false)
		var_21_12:setOpacity(0)
		var_21_12:setAnchorPoint(cc.p(0, 0))
		var_21_12:setColor(cc.c3b(255, 255, 255))
		var_21_12:setTouchEnabled(true)
		var_21_12:setPosition(cc.p(0, 0))
		var_21_11:addChild(var_21_12)
		var_21_12:addTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_23_0:getTouchBeganPosition().y - arg_23_0:getTouchEndPosition().y) > 30 then
				return
			end

			var_21_11:setTouchEnabled(false)

			arg_23_0.itemid = var_21_0[iter_21_0].itemid

			self:showItemDeatil(arg_23_0)
		end)

		var_21_8, var_21_9 = var_21_6(var_21_8, var_21_9, var_21_10)

		var_21_5:addChild(var_21_11)

		var_21_10 = var_21_10 + 1
	end

	var_21_5:setContentSize(cc.size(var_0_15, var_21_7 + var_0_14))

	local var_21_13 = var_21_3:getContentSize()

	var_21_3:setCapInsets(cc.rect(0, 100, var_21_13.width, 5))
	var_21_3:setContentSize(cc.size(var_21_13.width, var_21_7 + var_0_14 + var_0_17))
	var_21_2:setContentSize(cc.size(640, var_21_7 + var_0_14 + var_0_17 + var_0_16))
	var_21_4:setPosition(cc.p(var_21_4:getPositionX(), var_21_7 + var_0_14 + var_0_17 - 10))

	return var_21_2
end

function DropDetailsLayer:createSkinTwistPanel(arg_24_1)
	local var_24_0 = math.ceil(#arg_24_1.content / 3) * 359 + var_0_14
	local var_24_1 = self.panel_bg_items:clone()
	local var_24_2 = var_24_1:getChildByName("items_bg")
	local var_24_3 = var_24_2:getChildByName("label_type")
	local var_24_4 = var_24_2:getChildByName("panel_items")

	var_24_4:setContentSize(cc.size(var_0_15, var_24_0))
	var_24_2:loadTexture("public/panelbg/drop_info_bg.png", var_0_9)
	var_24_2:setCapInsets(cc.rect(0, 100, var_24_2:getContentSize().width, 5))
	var_24_2:setContentSize(cc.size(var_24_2:getContentSize().width, var_24_0 + var_0_17))
	var_24_1:setContentSize(cc.size(640, var_24_0 + var_0_17 + var_0_16))
	var_24_3:setVisible(false)

	local var_24_5 = ccui.ImageView:create("DropItemDisplay/no_word_top.png", var_0_9)

	var_24_5:setAnchorPoint(cc.p(0, 0.5))
	var_24_5:setPosition(cc.p(var_24_3:getPositionX() + 12, var_24_2:getContentSize().height - var_24_5:getContentSize().height / 2 + 8))
	var_24_2:addChild(var_24_5, 99)

	if arg_24_1.rarity then
		var_24_5:loadTexture(RARITY_RECRUIT[arg_24_1.rarity], var_0_9)
	else
		local var_24_6 = cc.Label:createWithTTF(arg_24_1.name, FONT_NAME, 36)

		var_24_6:setAnchorPoint(cc.p(0, 0.5))
		var_24_6:setPosition(48, var_24_5:getContentSize().height / 2)
		var_24_5:addChild(var_24_6)
	end

	local function var_24_7(arg_25_0)
		local var_25_0 = {
			["60"] = "summer_bg.png",
			["90"] = "spring_bg.png",
			["20"] = "sleep_bg.png"
		}
		local var_25_1 = tostring(arg_25_0):sub(-2, -1)

		if var_25_0[var_25_1] then
			return var_25_0[var_25_1]
		else
			return "normal_bg.png"
		end
	end

	local function var_24_8(arg_26_0)
		local var_26_0 = math.ceil(arg_26_0 / 3)

		return cc.p(({
			107,
			301,
			495
		})[arg_26_0 - (var_26_0 - 1) * 3], var_24_4:getContentSize().height - var_26_0 * 359)
	end

	local function var_24_9(arg_27_0)
		return "roleimage/role/shop_image/" .. model_data[item_data[arg_27_0].model].role_image .. ".png"
	end

	local function var_24_10(arg_28_0)
		if model_data[item_data[arg_28_0].model].live2d then
			return true, "DropItemDisplay/live2d_tips.png"
		elseif model_data[item_data[arg_28_0].model].rolespine then
			return true, "DropItemDisplay/spind_tips.png"
		else
			return false
		end
	end

	for iter_24_0, iter_24_1 in ipairs(arg_24_1.content) do
		local var_24_11 = iter_24_1.itemid
		local var_24_12 = "DropItemDisplay/" .. var_24_7(iter_24_1.itemid)
		local var_24_13 = ccui.Button:create(var_24_12, var_24_12, var_24_12, var_0_9)

		var_24_13:setAnchorPoint(cc.p(0.5, 0))
		var_24_13:setPosition(var_24_8(iter_24_0))
		var_24_4:addChild(var_24_13)

		local var_24_14 = ccui.Layout:create()

		var_24_14:setTouchEnabled(false)
		var_24_14:setContentSize(cc.size(var_24_13:getContentSize().width - 6, var_24_13:getContentSize().height - 6))
		var_24_14:setPosition(3, 3)
		var_24_14:setClippingEnabled(true)
		var_24_13:addChild(var_24_14)

		local var_24_15 = ccui.ImageView:create((var_24_9(iter_24_1.itemid)))

		var_24_15:setTouchEnabled(false)
		var_24_15:setScale(0.9)
		var_24_15:setPosition(var_24_14:getContentSize().width / 2, var_24_14:getContentSize().height / 2)
		var_24_14:addChild(var_24_15)

		local var_24_16 = ccui.ImageView:create("DropItemDisplay/skin_word_bg.png", var_0_9)

		var_24_16:setTouchEnabled(false)
		var_24_16:setPosition(var_24_13:getContentSize().width / 2, var_24_13:getContentSize().height / 2)
		var_24_13:addChild(var_24_16)

		local var_24_17 = cc.Label:createWithTTF(string.gsub(string.gsub(item_data[iter_24_1.itemid].name, "【", ""), "】", ""), FONT_NAME, 24)

		var_24_17:setAnchorPoint(cc.p(1, 0))
		var_24_17:setPosition(174, 30)
		var_24_16:addChild(var_24_17)

		local var_24_18 = cc.Label:createWithTTF(major_factor_data[item_data[iter_24_1.itemid].major].easy_name, FONT_NAME, 18)

		var_24_18:setAnchorPoint(cc.p(1, 0))
		var_24_18:setPosition(174, 3)
		var_24_16:addChild(var_24_18)

		local var_24_19, var_24_20 = var_24_10(iter_24_1.itemid)

		if var_24_19 then
			local var_24_21 = ccui.ImageView:create(var_24_20, var_0_9)

			var_24_21:setPosition(cc.p(var_24_21:getContentSize().width / 2, var_24_21:getContentSize().height / 2))
			var_24_16:addChild(var_24_21)
		end

		var_24_13:addTouchEventListener(function(arg_29_0, arg_29_1)
			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopShowSkinLayer", {
				itemid = var_24_11
			})
		end)
	end

	return var_24_1
end

function DropDetailsLayer:createWordsDisplay(arg_30_1, arg_30_2)
	local var_30_0 = {}

	for iter_30_0 = 1, #arg_30_1 do
		var_30_0[iter_30_0] = arg_30_1[iter_30_0].itemid
	end

	local var_30_1 = self.panel_bg_words:clone()
	local var_30_2 = var_30_1:getChildByName("words_bg")
	local var_30_3 = var_30_2:getChildByName("label_name")

	var_30_2:loadTexture("public/panelbg/drop_info_bg.png", var_0_9)

	local var_30_4 = var_30_3:getPositionY()

	var_30_3:setVisible(false)

	local var_30_5 = var_30_2:getChildByName("panel_words")
	local var_30_6

	for iter_30_1 = 1, #var_30_0 do
		local var_30_7 = RichTextPro:create()

		var_30_7:setMaxWidth(580)
		var_30_7:setText(var_30_0[iter_30_1])

		var_30_6 = var_30_7:getContentHeight()

		var_30_7:setPosition(cc.p(15, var_30_6 + 20))
		var_30_5:addChild(var_30_7)
	end

	var_30_5:setContentSize(cc.size(601, var_30_6))

	local var_30_8 = var_30_2:getContentSize()

	var_30_2:setCapInsets(cc.rect(0, 100, var_30_8.width, 5))
	var_30_2:setContentSize(cc.size(var_30_8.width, var_30_6 + var_0_17 + 40))

	local var_30_9 = ccui.ImageView:create("DropItemDisplay/recruit_info.png", var_0_9)

	var_30_9:setAnchorPoint(cc.p(0, 0.5))
	var_30_9:setPosition(cc.p(var_30_3:getPositionX() + 20 - 10, var_30_6 + var_0_17 + 40 - 25))
	var_30_2:addChild(var_30_9, 99)
	var_30_1:setContentSize(cc.size(640, var_30_6 + var_0_17 + 40 + var_0_16))
	self.listview:pushBackCustomItem(var_30_1)
end

function DropDetailsLayer:createChapterInfoDisplay(arg_31_1)
	local var_31_0 = arg_31_1.gold
	local var_31_1 = arg_31_1.exp
	local var_31_2 = 200
	local var_31_3 = 250
	local var_31_4 = 0
	local var_31_5 = 30
	local var_31_6 = 0
	local var_31_7 = 24

	if arg_31_1.gold and var_31_0 ~= 0 then
		var_31_6 = var_31_6 + 1
	end

	if var_31_1 and var_31_1 ~= 0 then
		var_31_6 = var_31_6 + 1
	end

	if arg_31_1.strengthpoint and arg_31_1.strengthpoint ~= 0 then
		var_31_6 = var_31_6 + 1
	end

	if var_31_6 == 3 then
		var_31_4 = var_31_2 / 2 + var_31_5 * 1.5 - 10
	elseif var_31_6 == 2 then
		var_31_4 = var_31_2 / 2 + var_31_5 - 10
	elseif var_31_6 == 1 then
		var_31_4 = var_31_2 / 2 + var_31_5 / 2 - 10
	elseif var_31_6 == 0 then
		return
	end

	local var_31_8 = ccui.Layout:create()

	var_31_8:setContentSize(cc.size(640, var_31_2))

	local var_31_9 = cc.Label:createWithTTF(L_DROP_DETAIL.Label.title, FONT_NAME, var_31_7 + 2)

	var_31_9:setAnchorPoint(cc.p(0, 1))
	var_31_9:setPosition(cc.p(80, var_31_2 - 20))
	var_31_8:addChild(var_31_9)

	local var_31_10 = cc.Label:createWithTTF(L_DROP_DETAIL.Label.des, FONT_NAME, var_31_7)

	var_31_10:setAnchorPoint(cc.p(0.5, 0.5))
	var_31_10:setPosition(cc.p(320, var_31_4))
	var_31_8:addChild(var_31_10)

	if arg_31_1.strengthpoint and arg_31_1.strengthpoint ~= 0 then
		local var_31_11 = ccui.ImageView:create(IMAGE_STRENGTHPOINT, var_0_9)

		var_31_11:setAnchorPoint(cc.p(0, 0.5))
		var_31_11:setPosition(cc.p(var_31_3, var_31_4 - var_31_5))
		var_31_8:addChild(var_31_11)

		local var_31_12 = cc.Label:createWithTTF("+" .. arg_31_1.strengthpoint * 6 .. "/M", FONT_DES, var_31_7)

		var_31_12:setColor(cc.c3b(226, 146, 0))
		var_31_12:setAnchorPoint(cc.p(0, 0.5))
		var_31_12:setPosition(cc.p(var_31_11:getContentSize().width + 5, var_31_11:getContentSize().height / 2))
		var_31_12:setName("strengthPointLabel")
		var_31_11:addChild(var_31_12)
	end

	if var_31_0 and var_31_0 ~= 0 then
		local var_31_13 = ccui.ImageView:create(IMAGE_GOLD, var_0_9)

		var_31_13:setAnchorPoint(cc.p(0, 0.5))

		if not strengthPointImg then
			var_31_13:setPosition(cc.p(var_31_3, var_31_4 - var_31_5))
		else
			var_31_13:setPosition(cc.p(var_31_3, var_31_4 - var_31_5 * 2))
		end

		var_31_8:addChild(var_31_13)

		local var_31_14 = cc.Label:createWithTTF("+" .. var_31_0 * 6 .. "/M", FONT_DES, var_31_7)

		var_31_14:setColor(cc.c3b(226, 146, 0))
		var_31_14:setAnchorPoint(cc.p(0, 0.5))
		var_31_14:setPosition(cc.p(var_31_13:getContentSize().width + 5, var_31_13:getContentSize().height / 2))
		var_31_14:setName("goldLabel")
		var_31_13:addChild(var_31_14)
	end

	if var_31_1 and var_31_1 ~= 0 then
		local var_31_15 = cc.Label:createWithTTF("EXP +" .. var_31_1 * 6 .. "/M", FONT_DES, var_31_7)

		var_31_15:setColor(cc.c3b(226, 146, 0))
		var_31_15:setAnchorPoint(cc.p(0, 0.5))

		if var_31_6 == 1 then
			var_31_15:setPosition(cc.p(var_31_3, var_31_4 - var_31_5))
		elseif var_31_6 == 2 then
			var_31_15:setPosition(cc.p(var_31_3, var_31_4 - var_31_5 * 2))
		elseif var_31_6 == e then
			var_31_15:setPosition(cc.p(var_31_3, var_31_4 - 2 * var_31_5 * 3))
		end

		var_31_15:setName("expLabel")
		var_31_8:addChild(var_31_15)
	end

	self.listview:pushBackCustomItem(var_31_8)
end

function DropDetailsLayer:cleanUI()
	if self.panel_bg_items then
		self.panel_bg_items:removeFromParent()
	end

	if self.panel_bg_words then
		self.panel_bg_words:removeFromParent()
	end
end

function DropDetailsLayer:showItemDeatil(arg_33_1)
	if item_data[arg_33_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_33_0 = -1
		local var_33_1 = require("data.horcrux_data")[arg_33_1.itemid].horcruxtype

		for iter_33_0, iter_33_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_33_1.itemid == iter_33_1.item_id then
				var_33_0 = iter_33_0

				break
			end
		end

		if var_33_0 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_33_0,
			itemid = arg_33_1.itemid
		})
	elseif item_data[arg_33_1.itemid].bag_item_type == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_33_1.itemid].servant
		})
	elseif item_data[arg_33_1.itemid].bag_item_type == kITEM_SKIN then
		-- block empty
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_33_2 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_33_1.itemid
		})
	end
end

function DropDetailsLayer:exitCallback()
	if self then
		self:playEnterOrOutAni(false, function()
			LayerManager:removePopLayer()
		end)
	end
end

local twist_config_data = require("data.twist_config_data")
local drop_data = require("data.drop_data")
local var_0_25 = require("data.horcrux_data")
local drop_level_data = require("data.drop_level_data")

function DropDetailsLayer:initBottomList(arg_36_1)
	local function var_36_0(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playEnterOrOutAni(false, function()
			if self.exitCallback then
				self:exitCallback()
			else
				layerManager:switchReturnLayer("FightLayer")
			end
		end)
	end

	local var_36_1 = arg_36_1.data

	if arg_36_1.type == 1 then
		local var_36_2 = BottomBtnList:create(var_36_0)

		var_36_2:setName("bottombg")
		self:addChild(var_36_2)
	elseif arg_36_1.type == 2 then
		local var_36_3 = BottomBtnList:create(var_36_0, ({
			[2] = {
				{
					name = "details",
					word = L_DROP_DETAIL.Show_Probability,
					handler = function(arg_39_0, arg_39_1)
						if arg_39_1 ~= ccui.TouchEventType.ended then
							return
						end

						local var_39_0 = {}

						if arg_36_1.Items_Uptime.startTime and arg_36_1.Items_Uptime.finishTime then
							local var_39_1, var_39_2, var_39_3 = string.match(arg_36_1.Items_Uptime.startTime, "(%d+)-(%d+)-(%d+)")

							var_39_0.starttime = var_39_2 .. "-" .. var_39_3

							local var_39_4, var_39_5, var_39_6 = string.match(arg_36_1.Items_Uptime.finishTime, "(%d+)-(%d+)-(%d+)")

							var_39_0.deadline = var_39_5 .. "-" .. var_39_6
						end

						local twist_manager = require("controller.twist_manager")

						var_39_0.items, var_39_0.all, var_39_0.specialvalue = twist_manager:generate_twist_drop_probs(var_36_1)
						var_39_0.topitems = nil

						if twist_manager:is_selectup_twist(arg_36_1.egg_pool_type) then
							var_39_0.topitems = twist_manager:get_twist_upitems(arg_36_1.egg_pool_type)
						end

						LayerManager:pushInLayer("PublicityLayer", var_39_0, nil, arg_36_1.egg_pool_type)
					end
				}
			}
		})[2])

		var_36_3:setName("bottombg")
		self:addChild(var_36_3)
	else
		local var_36_4 = BottomBtnList:create(var_36_0)

		var_36_4:setName("bottombg")
		self:addChild(var_36_4)
	end
end

function DropDetailsLayer:playEnterOrOutAni(arg_40_1, arg_40_2)
	if arg_40_1 then
		self.listview:runAction(cc.MoveTo:create(0.4, cc.p(0, self.listview:getPositionY())))
	else
		self.listview:runAction(cc.Sequence:create(cc.MoveTo:create(0.3, cc.p(-1500, self.listview:getPositionY())), cc.CallFunc:create(function()
			if arg_40_2 then
				arg_40_2()
			end
		end)))
	end
end

function DropDetailsLayer:exit()
	self:playEnterOrOutAni(false, function()
		if self.exitCallback then
			self:exitCallback()
		else
			layerManager:switchReturnLayer("FightLayer")
		end
	end)
end
