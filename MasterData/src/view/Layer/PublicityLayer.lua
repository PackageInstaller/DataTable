PublicityLayer = class("PublicityLayer", function()
	return cc.Layer:create()
end)

local item_data = require("data.item_data")
local drop_data = require("data.drop_data")
local horcrux_data = require("data.horcrux_data")
local servant_data = require("data.servant_data")
local major_factor_data = require("data.major_factor_data")
local var_0_5 = config._DEBUG and 0 or 1

local function var_0_6(arg_2_0)
	return CAREER_ICON[item_data[arg_2_0].career .. "_" .. global_get_model_attr(horcrux_data[arg_2_0].model)]
end

function PublicityLayer.create(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = PublicityLayer.new()

	var_3_0:init(arg_3_1, arg_3_2, arg_3_3)

	return var_3_0
end

function PublicityLayer.fullScreen(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:setContentSize(GameDisplay.getScreenSize())
	arg_4_1:setPositionY(arg_4_1:getPositionY() - GameDisplay.fix_y)
	arg_4_2:setPositionY(arg_4_2:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
end

function PublicityLayer:init(arg_5_1, arg_5_2, arg_5_3)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Probability_Publicity.json" or "Probability_Publicity.ExportJson")

	self:addChild(self.rootLayer)

	self.panel_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bg")
	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")
	self.deadline = ccui.Helper:seekWidgetByName(self.rootLayer, "deadline")
	self.listview = ccui.Helper:seekWidgetByName(self.rootLayer, "listview")
	self.entry_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "entry_bg")
	self.panel_black = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_black")
	self.panel_white = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_white")
	self.no_publicity = ccui.Helper:seekWidgetByName(self.rootLayer, "label_no_publicity")

	self.bg:setTouchEnabled(true)
	self.no_publicity:setVisible(false)

	self.specialvalue = arg_5_1.specialvalue or {}
	self.servant = arg_5_1.all.girls
	self.horcrux = arg_5_1.all.horcrux
	self.skin = arg_5_1.all.skins
	self.others = arg_5_1.all.others
	self.egg_pool_type = arg_5_3
	self.topitemsmanual = {}

	if arg_5_1.topitems then
		for iter_5_0, iter_5_1 in pairs(arg_5_1.topitems) do
			self.topitemsmanual[iter_5_1] = true
		end
	end

	self:setRarityProbability()

	local var_5_0 = os.clock()

	print("local s = os.clock()local s = os.clock()local s = os.clock()", var_5_0)

	if arg_5_1.deadline and arg_5_1.starttime then
		self:setDeadline(arg_5_1.deadline, arg_5_1.starttime)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "label_time"):removeFromParent()
	end

	local var_5_1 = self.entry_bg:clone()

	var_5_1:getChildByName("label_rate"):setString(L_PUBLICITY_PROBABILITY.Total)
	self.listview:pushBackCustomItem(var_5_1:clone())

	self.table = {}
	self.sptable = {}

	for iter_5_2 = 1, #arg_5_1.items do
		if string.find(arg_5_1.items[iter_5_2].name, "SP") or string.find(arg_5_1.items[iter_5_2].name, "独特") then
			table.insert(self.sptable, {
				probability = arg_5_1.items[iter_5_2].probability,
				name = arg_5_1.items[iter_5_2].name
			})
		else
			self.table[#self.table + 1] = arg_5_1.items[iter_5_2]
		end
	end

	local function var_5_2(arg_6_0)
		if string.find(arg_6_0, "MR") then
			return cc.c3b(255, 198, 24)
		end

		if string.find(arg_6_0, "超凡") then
			return cc.c3b(255, 198, 24)
		end

		if string.find(arg_6_0, "UR") then
			return cc.c3b(245, 88, 255)
		end

		if string.find(arg_6_0, "精英") then
			return cc.c3b(245, 88, 255)
		end

		if string.find(arg_6_0, "SR") then
			return cc.c3b(98, 153, 255)
		end

		if string.find(arg_6_0, "普通") then
			return cc.c3b(98, 153, 255)
		end

		if string.find(arg_6_0, "SP") then
			return cc.c3b(247, 100, 103)
		end

		if string.find(arg_6_0, "独特") then
			return cc.c3b(247, 100, 103)
		end

		if string.find(arg_6_0, "R") then
			return cc.c3b(255, 255, 255)
		end

		return cc.c3b(255, 255, 255)
	end

	local function var_5_3(arg_7_0)
		if string.find(arg_7_0, "MR") then
			return {
				"MR",
				split(arg_7_0, "MR")[1]
			}
		end

		if string.find(arg_7_0, "超凡") then
			return {
				"超凡",
				split(arg_7_0, "超凡")[1]
			}
		end

		if string.find(arg_7_0, "UR") then
			return {
				"UR",
				split(arg_7_0, "UR")[1]
			}
		end

		if string.find(arg_7_0, "精英") then
			return {
				"精英",
				split(arg_7_0, "精英")[1]
			}
		end

		if string.find(arg_7_0, "SR") then
			return {
				"SR",
				split(arg_7_0, "SR")[1]
			}
		end

		if string.find(arg_7_0, "普通") then
			return {
				"普通",
				split(arg_7_0, "普通")[1]
			}
		end

		if string.find(arg_7_0, "SP") then
			return {
				"SP",
				split(arg_7_0, "SP")[1]
			}
		end

		if string.find(arg_7_0, "独特") then
			return {
				"独特",
				split(arg_7_0, "独特")[1]
			}
		end

		if string.find(arg_7_0, "R") then
			return {
				"R",
				split(arg_7_0, "R")[1]
			}
		end

		return {}
	end

	for iter_5_3 = 1, #self.table do
		local var_5_4 = string.format("%.3f", tostring(tonumber(self.table[iter_5_3].probability) * 100))
		local var_5_5 = self:createPanel()
		local var_5_6 = var_5_3(self.table[iter_5_3].name)[1] or self.table[iter_5_3].name
		local var_5_7 = var_5_3(self.table[iter_5_3].name)[2] or self.table[iter_5_3].name

		if var_5_6 == var_5_7 then
			var_5_7 = ""
		end

		local var_5_8 = cc.Label:createWithTTF(var_5_6, FONT_DES, 25)

		var_5_8:setColor(var_5_2(self.table[iter_5_3].name))
		var_5_8:setPosition(cc.p(21, 20))
		var_5_8:setAnchorPoint(cc.p(0, 0.5))
		var_5_5:addChild(var_5_8, 999)

		local var_5_9 = cc.Label:createWithTTF(var_5_7, FONT_DES, 25)

		var_5_9:setColor(cc.c3b(255, 255, 255))
		var_5_9:setPosition(var_5_8:getPositionX() + var_5_8:getContentSize().width, var_5_8:getPositionY())
		var_5_9:setAnchorPoint(cc.p(0, 0.5))
		var_5_5:addChild(var_5_9, 999)
		var_5_5:getChildByName("item_name"):setVisible(false)
		var_5_5:getChildByName("item_star"):setVisible(false)
		var_5_5:getChildByName("item_probability"):setString(var_5_4 .. "%")
		self.listview:pushBackCustomItem(var_5_5)
	end

	if self.sptable and #self.sptable > 0 then
		(function(...)
			local var_8_0 = self:createPanel()
			local var_8_1 = cc.Label:createWithTTF("——————————————————", FONT_DES, 25)

			var_8_1:setColor(cc.c3b(255, 255, 255))
			var_8_1:setPosition(cc.p(21, 20))
			var_8_1:setAnchorPoint(cc.p(0, 0.5))
			var_8_0:addChild(var_8_1, 999)
			var_8_0:getChildByName("item_name"):setVisible(false)
			var_8_0:getChildByName("item_star"):setVisible(false)
			var_8_0:getChildByName("item_probability"):setVisible(false)
			self.listview:pushBackCustomItem(var_8_0)
		end)()
	end

	local var_5_10 = false

	for iter_5_4, iter_5_5 in pairs(self.sptable) do
		var_5_10 = (string.find(iter_5_5.name, "SP学员") or string.find(iter_5_5.name, "独特学员")) and true
	end

	for iter_5_6 = 1, #self.sptable do
		local var_5_11 = string.format("%.3f", tostring(tonumber(self.sptable[iter_5_6].probability) * 100))
		local var_5_12 = self:createPanel()
		local var_5_13 = 21

		if string.find(self.sptable[iter_5_6].name, "星") then
			start = split(self.sptable[iter_5_6].name, "星")[1]
			start = start .. "星"

			local var_5_14 = cc.Label:createWithTTF(start, FONT_DES, 25)

			var_5_14:setPosition(cc.p(var_5_13, 20))
			var_5_14:setAnchorPoint(cc.p(0, 0.5))
			var_5_12:addChild(var_5_14, 999)

			var_5_13 = var_5_13 + var_5_14:getContentSize().width
		end

		local var_5_15 = cc.Label:createWithTTF(self.sptable[iter_5_6].name, FONT_DES, 25)

		var_5_15:setColor(cc.c3b(247, 100, 103))
		var_5_15:setPosition(cc.p(var_5_13, 20))
		var_5_15:setAnchorPoint(cc.p(0, 0.5))
		var_5_12:addChild(var_5_15, 999)

		local var_5_16 = cc.Label:createWithTTF("", FONT_DES, 25)

		var_5_16:setColor(cc.c3b(255, 255, 255))
		var_5_16:setPosition(var_5_15:getPositionX() + var_5_15:getContentSize().width, var_5_15:getPositionY())
		var_5_16:setAnchorPoint(cc.p(0, 0.5))
		var_5_12:addChild(var_5_16, 999)
		var_5_12:getChildByName("item_name"):setVisible(false)
		var_5_12:getChildByName("item_star"):setVisible(false)
		var_5_12:getChildByName("item_probability"):setString(var_5_11 .. "%")
		self.listview:pushBackCustomItem(var_5_12)
	end

	if #self.servant ~= 0 or #self.horcrux ~= 0 or #self.others then
		local var_5_17 = self.entry_bg:clone()

		var_5_17:getChildByName("label_rate"):setString(L_PUBLICITY_PROBABILITY.Detail)
		self.listview:pushBackCustomItem(var_5_17:clone())
	end

	local var_5_18 = self:getToppingItem()

	for iter_5_7 = 1, #var_5_18 do
		local var_5_19 = string.format("%.3f", tostring(tonumber(var_5_18[iter_5_7].probability) * 100))
		local var_5_20 = self:createPanel()
		local var_5_21 = item_data[var_5_18[iter_5_7].itemid].name

		if item_data[var_5_18[iter_5_7].itemid].bag_item_type == kITEM_HERO then
			if global_get_model_attr(servant_data[item_data[var_5_18[iter_5_7].itemid].servant].modelid) == "umaru" then
				var_5_21 = "【" .. major_factor_data[servant_data[item_data[var_5_18[iter_5_7].itemid].servant].major].easy_name .. "】"
			end
		elseif item_data[var_5_18[iter_5_7].itemid].bag_item_type ~= kITEM_SKIN then
			var_5_21 = "【" .. var_5_21 .. "】"
		end

		var_5_20:getChildByName("item_name"):setString(var_5_21)
		var_5_20:getChildByName("item_name"):setColor(cc.c3b(250, 150, 0))
		var_5_20:getChildByName("item_star"):setColor(cc.c3b(250, 150, 0))
		var_5_20:getChildByName("item_probability"):setColor(cc.c3b(250, 150, 0))

		if var_5_18[iter_5_7].start then
			var_5_20:getChildByName("item_star"):setVisible(true)
			var_5_20:getChildByName("item_star"):setString(var_5_18[iter_5_7].start)
		else
			var_5_20:getChildByName("item_star"):setVisible(false)
		end

		var_5_20:getChildByName("item_probability"):setString(var_5_19 .. "%")
		self.listview:pushBackCustomItem(var_5_20)
	end

	local function var_5_23(arg_9_0, arg_9_1)
		if arg_9_0.probability ~= arg_9_1.probability then
			return arg_9_0.probability < arg_9_1.probability
		else
			return arg_9_0.itemid < arg_9_1.itemid
		end
	end

	table.sort(self.servant, var_5_23)
	table.sort(self.skin, var_5_23)
	table.sort(self.others, function(arg_10_0, arg_10_1)
		if item_data[arg_10_0.itemid].bag_item_type ~= item_data[arg_10_1.itemid].bag_item_type then
			return item_data[arg_10_0.itemid].bag_item_type == kITEM_SKIN and item_data[arg_10_1.itemid].bag_item_type ~= kITEM_SKIN
		else
			return arg_10_0.probability < arg_10_1.probability
		end
	end)

	if var_5_10 then
		local var_5_24

		for iter_5_8, iter_5_9 in pairs(self.servant) do
			if iter_5_9.probability == 0.01 and servant_data[item_data[iter_5_9.itemid].servant].rarity == 4 then
				var_5_24 = iter_5_8

				break
			end
		end

		if var_5_24 then
			self.servant[var_5_24], self.servant[1] = self.servant[1], self.servant[var_5_24]
		end
	end

	for iter_5_10, iter_5_11 in ipairs(self.servant) do
		if not self.servant[iter_5_10].isUp then
			local var_5_25 = string.format("%.3f", tostring(tonumber(self.servant[iter_5_10].probability) * 100))
			local var_5_26 = self:createPanel()

			var_5_26:getChildByName("item_name"):setString((global_get_model_attr(servant_data[item_data[self.servant[iter_5_10].itemid].servant].modelid) == "umaru" or nil) and "【" .. major_factor_data[servant_data[item_data[self.servant[iter_5_10].itemid].servant].major].easy_name .. "】")
			var_5_26:getChildByName("item_star"):setVisible(false)
			var_5_26:getChildByName("item_probability"):setString(var_5_25 .. "%")
			self.listview:pushBackCustomItem(var_5_26)
		end
	end

	for iter_5_12, iter_5_13 in ipairs(self.skin) do
		if not iter_5_13.isUp then
			local var_5_28 = string.format("%.3f", tostring(tonumber(iter_5_13.probability) * 100))
			local var_5_29 = self:createPanel()

			var_5_29:getChildByName("item_name"):setString(item_data[iter_5_13.itemid].name)
			var_5_29:getChildByName("item_star"):setVisible(false)
			var_5_29:getChildByName("item_probability"):setString(var_5_28 .. "%")
			self.listview:pushBackCustomItem(var_5_29)
		end
	end

	for iter_5_14, iter_5_15 in ipairs(self.others) do
		local var_5_30 = string.format("%.3f", tostring(tonumber(self.others[iter_5_14].probability) * 100))
		local var_5_31 = self:createPanel()

		var_5_31:getChildByName("item_name"):setString(item_data[self.others[iter_5_14].itemid].name)
		var_5_31:getChildByName("item_star"):setVisible(false)
		var_5_31:getChildByName("item_probability"):setString(var_5_30 .. "%")
		self.listview:pushBackCustomItem(var_5_31)
	end

	table.sort(self.horcrux, function(arg_11_0, arg_11_1)
		if arg_11_0.probability ~= arg_11_1.probability then
			return arg_11_0.probability < arg_11_1.probability
		else
			return arg_11_0.itemid < arg_11_1.itemid
		end
	end)

	for iter_5_16, iter_5_17 in pairs(self.horcrux) do
		if not self.horcrux[iter_5_16].isUp then
			local var_5_33 = string.format("%.3f", tostring(tonumber(self.horcrux[iter_5_16].probability) * 100))
			local var_5_34 = self:createPanel()

			var_5_34:getChildByName("item_name"):setString(item_data[self.horcrux[iter_5_16].itemid].name)
			var_5_34:getChildByName("item_star"):setString(self.horcrux[iter_5_16].start)
			var_5_34:getChildByName("item_probability"):setString(var_5_33 .. "%")

			local var_5_35 = ccui.ImageView:create(var_0_6(self.horcrux[iter_5_16].itemid), var_0_5)
			local var_5_36 = var_5_34:getChildByName("item_name")

			var_5_35:setAnchorPoint(0, 0.5)
			var_5_35:setPositionX(var_5_36:getPositionX() + var_5_36:getContentSize().width + 15)
			var_5_35:setPositionY(var_5_36:getPositionY())
			var_5_35:setScale(0.4)
			var_5_34:addChild(var_5_35)
			self.listview:pushBackCustomItem(var_5_34)

			self.horcrux[iter_5_16] = nil
		end
	end

	local var_5_37 = 1

	self.listview:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		if not self.horcrux[var_5_37] then
			self.listview:stopAllActions()
		end

		if self.horcrux[var_5_37] and not self.horcrux[var_5_37].isUp then
			local var_12_0 = self:createPanel()

			var_12_0:getChildByName("item_name"):setString(item_data[self.horcrux[var_5_37].itemid].name)
			var_12_0:getChildByName("item_star"):setString(self.horcrux[var_5_37].start)
			var_12_0:getChildByName("item_probability"):setString(string.format("%.3f", tostring(tonumber(self.horcrux[var_5_37].probability) * 100)) .. "%")
			self.listview:pushBackCustomItem(var_12_0)
		end

		var_5_37 = var_5_37 + 1
	end))))
	print("local s = os.clock()local s = os.clock()local s = os.clock()", os.clock() - var_5_0)
	self.entry_bg:removeFromParent()
	self.panel_black:removeFromParent()
	self.panel_white:removeFromParent()
	global_window_open_action(self.bg, timetbl)
	self.panel_bg:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.bg, function()
			LayerManager:removePopLayer()
		end)
	end)
	self:fullScreen(self.panel_bg, self.bg)
end

function PublicityLayer.createPanel(arg_15_0)
	local var_15_0 = ccui.Layout:create()

	var_15_0:setContentSize(cc.size(503, 40))
	var_15_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)

	local var_15_1 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

	var_15_1:setName("item_probability")
	var_15_1:setAnchorPoint(1, 0.5)
	var_15_1:setPosition(cc.p(480, var_15_0:getContentSize().height / 2))
	var_15_0:addChild(var_15_1, 2)

	local var_15_2 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

	var_15_2:setName("item_name")
	var_15_2:setAnchorPoint(0, 0.5)
	var_15_2:setPosition(cc.p(21, var_15_0:getContentSize().height / 2))
	var_15_0:addChild(var_15_2, 2)

	local var_15_3 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

	var_15_3:setName("item_star")
	var_15_3:setAnchorPoint(0.5, 0.5)
	var_15_3:setPosition(cc.p(250, var_15_0:getContentSize().height / 2))
	var_15_0:addChild(var_15_3, 2)

	return var_15_0
end

function PublicityLayer:setRarityProbability()
	self.rate = {
		servant = {},
		horcrux = {}
	}

	local function var_16_0(arg_17_0)
		return servant_data[item_data[arg_17_0].servant].roll_rarity
	end

	local function var_16_1(arg_18_0)
		return item_data[arg_18_0].rarity
	end

	for iter_16_0, iter_16_1 in pairs(self.servant) do
		local var_16_2 = var_16_0(iter_16_1.itemid)

		self.rate.servant[var_16_2] = self.rate.servant[var_16_2] or {
			count = 1,
			value = iter_16_1.probability
		}

		if self.rate.servant[var_16_2].value > iter_16_1.probability then
			self.rate.servant[var_16_2].value = math.min(self.rate.servant[var_16_2].value, iter_16_1.probability)
		end
	end

	for iter_16_2, iter_16_3 in pairs(self.horcrux) do
		local var_16_3 = var_16_1(iter_16_3.itemid)

		self.rate.horcrux[var_16_3] = self.rate.horcrux[var_16_3] or {
			count = 1,
			value = iter_16_3.probability
		}

		if self.rate.horcrux[var_16_3].value > iter_16_3.probability then
			self.rate.horcrux[var_16_3].value = math.min(self.rate.horcrux[var_16_3].value, iter_16_3.probability)
		end
	end
end

function PublicityLayer:getToppingItem()
	local var_20_0 = {}
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in pairs(self.specialvalue) do
		var_20_1[iter_20_1] = true
	end

	local function var_20_2(arg_21_0)
		return servant_data[item_data[arg_21_0].servant].roll_rarity
	end

	local function var_20_3(arg_22_0)
		return item_data[arg_22_0].rarity
	end

	for iter_20_2, iter_20_3 in pairs(self.servant) do
		local var_20_4 = var_20_2(iter_20_3.itemid)

		if var_20_1[iter_20_3.itemid] then
			iter_20_3.isUp = true
			iter_20_3.from_upitem = true

			table.insert(var_20_0, iter_20_3)
		elseif self.topitemsmanual[iter_20_3.itemid] then
			iter_20_3.isUp = true
			iter_20_3.from_upitem = false

			table.insert(var_20_0, iter_20_3)
		elseif self.egg_pool_type == 222 and (iter_20_3.itemid == 1301020 or iter_20_3.itemid == 1300520) then
			iter_20_3.isUp = true
			iter_20_3.from_upitem = false

			table.insert(var_20_0, iter_20_3)
		elseif iter_20_3.probability > self.rate.servant[var_20_4].value then
			iter_20_3.isUp = true
			iter_20_3.from_upitem = false

			table.insert(var_20_0, iter_20_3)
		end
	end

	for iter_20_4, iter_20_5 in pairs(self.skin) do
		if var_20_1[iter_20_5.itemid] then
			iter_20_5.isUp = true
			iter_20_5.from_upitem = true

			table.insert(var_20_0, iter_20_5)
		elseif self.topitemsmanual[iter_20_5.itemid] then
			iter_20_5.isUp = true
			iter_20_5.from_upitem = true

			table.insert(var_20_0, iter_20_5)
		end
	end

	for iter_20_6, iter_20_7 in pairs(self.horcrux) do
		-- block empty
	end

	local var_20_5 = {
		[30520812] = true,
		[30520312] = true,
		[30520612] = true,
		[30520912] = true,
		[30520412] = true,
		[30520712] = true,
		[30520512] = true,
		[3050061] = true
	}

	for iter_20_8, iter_20_9 in pairs(self.horcrux) do
		local var_20_6 = var_20_3(iter_20_9.itemid)

		if var_20_1[iter_20_9.itemid] then
			iter_20_9.isUp = true
			iter_20_9.from_upitem = true

			table.insert(var_20_0, iter_20_9)
		elseif self.topitemsmanual[iter_20_9.itemid] then
			iter_20_9.isUp = true
			iter_20_9.from_upitem = false

			table.insert(var_20_0, iter_20_9)
		elseif iter_20_9.itemid == 3050011 then
			-- block empty
		elseif var_20_5[iter_20_9.itemid] then
			iter_20_9.isUp = true
			iter_20_9.from_upitem = false

			table.insert(var_20_0, iter_20_9)
		elseif iter_20_9.probability > self.rate.horcrux[var_20_6].value then
			iter_20_9.isUp = true
			iter_20_9.from_upitem = false

			table.insert(var_20_0, iter_20_9)
		end
	end

	local var_20_7 = {
		[1306520] = true,
		[30514111] = true,
		[30513911] = true,
		[30514211] = true,
		[30514011] = true
	}

	for iter_20_10, iter_20_11 in pairs(self.horcrux) do
		if var_20_7[iter_20_11.itemid] then
			iter_20_11.isUp = true
			iter_20_11.from_upitem = false

			table.insert(var_20_0, iter_20_11)
		end
	end

	local var_20_8 = {
		{
			weight = 1,
			func = function(self, arg_27_1)
				if item_data[self.itemid].bag_item_type == kITEM_HORCRUX and item_data[arg_27_1.itemid].bag_item_type == kITEM_HORCRUX then
					return item_data[self.itemid].horcruxtype < item_data[arg_27_1.itemid].horcruxtype
				else
					return false
				end
			end
		},
		{
			weight = 2,
			func = function(self, arg_26_1)
				if self.probability == arg_26_1.probability then
					return "=="
				else
					return self.probability < arg_26_1.probability
				end
			end
		},
		{
			weight = 3,
			func = function(self, arg_25_1)
				local var_25_0 = 0
				local var_25_1 = 0

				if item_data[self.itemid].bag_item_type == kITEM_HERO then
					var_25_0 = var_20_2(self.itemid)
				end

				if item_data[self.itemid].bag_item_type == kITEM_HORCRUX then
					var_25_0 = var_20_3(self.itemid)
				end

				if item_data[arg_25_1.itemid].bag_item_type == kITEM_HERO then
					var_25_1 = var_20_2(arg_25_1.itemid)
				end

				if item_data[arg_25_1.itemid].bag_item_type == kITEM_HORCRUX then
					var_25_1 = var_20_3(arg_25_1.itemid)
				end

				if var_25_0 == var_25_1 then
					return "=="
				else
					return var_25_1 < var_25_0
				end
			end
		},
		{
			weight = 4,
			func = function(self, arg_24_1)
				local var_24_0 = item_data[self.itemid].bag_item_type == kITEM_HERO and 1 or 0
				local var_24_1 = item_data[arg_24_1.itemid].bag_item_type == kITEM_HERO and 1 or 0

				if (item_data[self.itemid].bag_item_type == kITEM_HERO and 1 or 0) == (item_data[arg_24_1.itemid].bag_item_type == kITEM_HERO and 1 or 0) then
					return "=="
				else
					return var_24_1 < var_24_0
				end
			end
		},
		{
			weight = 5,
			func = function(self, arg_23_1)
				local var_23_0 = self.from_upitem and 1 or 0
				local var_23_1 = arg_23_1.from_upitem and 1 or 0

				if (self.from_upitem and 1 or 0) == (arg_23_1.from_upitem and 1 or 0) then
					return "=="
				else
					return var_23_1 < var_23_0
				end
			end
		}
	}

	table.sort(var_20_8, function(arg_28_0, arg_28_1)
		return arg_28_0.weight > arg_28_1.weight
	end)
	table.sort(var_20_0, function(arg_29_0, arg_29_1)
		for iter_29_0 = 1, #var_20_8 do
			if var_20_8[iter_29_0].func(arg_29_0, arg_29_1) ~= "==" then
				return var_20_8[iter_29_0].func(arg_29_0, arg_29_1)
			end
		end
	end)

	return var_20_0
end

function PublicityLayer.handleContentTbl(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	return arg_30_3 and next(arg_30_3) ~= nil and stickSpecialItems(arg_30_2, arg_30_3) or arg_30_2
end

function PublicityLayer:setDeadline(arg_31_1, arg_31_2)
	self.deadline:setString(arg_31_2 .. "~" .. arg_31_1)
end
