local TempWidget = require("view/Sprite/TempWidget")
local var_0_1
local var_0_2

MarketLayer = class("MarketLayer", function()
	return cc.Layer:create()
end)

function MarketLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = MarketLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

local var_0_3

function MarketLayer.getInstance()
	return var_0_3
end

require("view.Sprite.ConfirmDialogSprite")

local L2Actor = require("view.Sprite.L2Actor")
local texture_manager = require("controller.texture_manager")
local shop_manager = require("controller.shop_manager")
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local weapon_manager = require("controller.weapon_manager")
local alert_manager = require("controller.alert_manager")
local network = require("network.network")
local component_manager = require("controller.component_manager")
local audio_manager = require("controller.audio_manager")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local level_manager = require("controller.level_manager")
local armature_manager = require("controller.armature_manager")
local diamond_update_data = require("data.diamond_update_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local component_effect_data = require("data.component_effect_data")
local discount_manager = require("controller.discount_manager")
local var_0_24 = config._DEBUG and 0 or 1
local shop_data = require("data.shop_data")
local activity_manager = require("controller.activity_manager")
local community_system_manager = require("controller.community_system_manager")
local major_factor_data = require("data.major_factor_data")
local furnituresuit_data = require("data.furnituresuit_data")
local servant_data = require("data.servant_data")
local hexie_manager = require("controller.hexie_manager")
local var_0_32 = require("data.major_factor_data")
local test_fight_manager = require("controller.test_fight_manager")
local skin_data = require("data.skin_data")
local filter_config_manager = require("controller.filter_config_manager")
local var_0_36 = {}
local ShopSprite = require("view.Sprite.ShopSprite")
local Utility = require("common.Utility")

local function var_0_39(arg_4_0)
	return split(arg_4_0, "-")[1] .. "_" .. split(arg_4_0, "-")[2]
end

local var_0_40 = {
	["1-10702"] = 3,
	["1-9"] = 1,
	["1-7"] = 1,
	["1-8"] = 1,
	["1-10404"] = 1,
	["1-1801"] = 2,
	["1-16"] = 1,
	["1-509"] = 2,
	["1-27"] = 1,
	["1-15405"] = 1,
	["1-15701"] = 5,
	["1-20"] = 1,
	["1-137"] = 1,
	["1-40511"] = 1,
	["1-37"] = 1,
	["1-22701"] = 1,
	["1-22"] = 1,
	["2-4"] = 1,
	["1-41811"] = 1,
	["1-26"] = 1,
	["1-4"] = 2,
	["1-5104"] = 2,
	["1-5201"] = 6,
	["1-13802"] = 3,
	["1-520"] = 1,
	["1-24"] = 3,
	["1-14805"] = 4,
	["1-35"] = 1,
	["1-17101"] = 1,
	["1-17301"] = 1,
	["1-18001"] = 1,
	["1-21020"] = 1,
	["1-15301"] = 1,
	["1-1"] = 1,
	["2-1"] = 1,
	["1-19501"] = 1,
	["1-19901"] = 1,
	["1-1371"] = 1,
	["1-27001"] = 3,
	["1-1999"] = 1,
	["1-13804"] = 1,
	["1-21203"] = 3,
	["1-21011"] = 3,
	["1-18201"] = 1,
	["1-21701"] = 1,
	["1-22201"] = 3,
	["1-22501"] = 1,
	["1-22301"] = 3,
	["1-6"] = 2,
	["2-6"] = 1,
	["1-22801"] = 1,
	["1-23021"] = 1,
	["1-30411"] = 1,
	["1-54"] = 1,
	["1-23201"] = 1,
	["1-10801"] = 1,
	["1-52"] = 1,
	["1-13"] = 1,
	["1-32"] = 1,
	["1-20701"] = 1,
	["1-51"] = 1,
	["1-53"] = 1,
	["1-31"] = 1,
	["1-23041"] = 1,
	["1-27002"] = 1,
	["1-3"] = 1,
	["1-23801"] = 1,
	["1-30"] = 1,
	["1-12"] = 3,
	["1-10"] = 3,
	["1-25201"] = 1,
	["1-50"] = 1,
	["1-11"] = 1,
	["1-29"] = 1,
	["1-10407"] = 1,
	["1-20502"] = 1,
	["1-36"] = 1,
	["1-21"] = 3,
	["1-40"] = 1,
	["1-38"] = 1,
	["1-501"] = 2,
	["1-18"] = 1,
	["1-22702"] = 1,
	["1-27010"] = 3,
	["1-19"] = 1,
	["1-34"] = 1,
	["1-56"] = 1,
	["1-28501"] = 1,
	["1-15601"] = 1,
	["1-17"] = 3,
	["1-55"] = 1,
	["1-23301"] = 3,
	["1-11003"] = 3,
	["1-39"] = 1,
	["2-3"] = 1,
	["1-10402"] = 1,
	["1-16601"] = 1,
	["1-5"] = 1,
	["1-42101"] = 3,
	["1-10001"] = 3,
	["1-23011"] = 3,
	["1-10403"] = 1,
	["1-18801"] = 1,
	["1-18607"] = 1,
	["1-10201"] = 1,
	["1-21010"] = 1,
	["1-2"] = 4,
	["2-2"] = 1,
	["1-5103"] = 3,
	["1-10301"] = 1,
	["1-10002"] = 1,
	["1-123000"] = 1,
	["1-10401"] = 1,
	["1-17303"] = 1
}

setmetatable(var_0_40, {
	__index = function(arg_5_0, arg_5_1)
		return 3
	end
})

local var_0_41 = {
	["1-9"] = 0,
	["1-1"] = 0,
	["2-1"] = 0,
	["1-3"] = 0,
	["1-12"] = 0,
	["1-10"] = 0,
	["1-7"] = 0,
	["1-13"] = 0,
	["1-11"] = 0,
	["1-5"] = 0,
	["1-6"] = 0,
	["1-2"] = 0,
	["2-2"] = 0,
	["2-4"] = 0,
	["1-4"] = 0,
	["1-8"] = 0,
	["2-3"] = UNLOCK_COLLECTION_SHOP
}

setmetatable(var_0_41, {
	__index = function(arg_6_0, arg_6_1)
		return 0
	end
})

local var_0_42 = {
	["1-27002"] = 1,
	["1-22201"] = 1,
	["1-21009"] = 1,
	["1-15406"] = 3,
	["1-10"] = 1,
	["1-22"] = 2,
	["1-502"] = 3,
	["1-50"] = 1,
	["1-11"] = 2,
	["1-5"] = 1,
	["1-39"] = 1,
	["1-21203"] = 1,
	["1-36"] = 2,
	["1-21"] = 1,
	["1-40"] = 1,
	["1-38"] = 1,
	["1-35"] = 2,
	["2-4"] = 2,
	["1-18"] = 2,
	["1-501"] = 3,
	["1-4"] = 1,
	["1-15407"] = 3,
	["1-503"] = 3,
	["1-505"] = 3,
	["1-520"] = 2,
	["1-504"] = 3,
	["1-509"] = 3,
	["1-5103"] = 3,
	["1-11003"] = 1,
	["1-15403"] = 3,
	["2-3"] = 2,
	["1-21020"] = 1,
	["1-15301"] = 1,
	["1-1"] = 1,
	["2-1"] = 2,
	["1-5201"] = 3,
	["1-5101"] = 3,
	["1-506"] = 3,
	["1-14801"] = 3,
	["1-18801"] = 1,
	["1-15404"] = 3,
	["1-5104"] = 3,
	["1-18501"] = 1,
	["1-6"] = 1,
	["1-21011"] = 3,
	["1-27010"] = 3,
	["1-21010"] = 1,
	["1-2"] = 1,
	["2-2"] = 2,
	["2-6"] = 1,
	["1-28811"] = 3,
	["1-23001"] = 1,
	["1-22301"] = 1,
	["1-23301"] = 1,
	["1-507"] = 3,
	["1-15408"] = 3
}

setmetatable(var_0_42, {
	__index = function(arg_7_0, arg_7_1)
		return 4
	end
})

local var_0_43 = {
	["1-28"] = true
}
local var_0_44 = {
	["1-10001"] = {
		detailsid = "activity_shop_10001",
		x = 200,
		y = 30
	}
}
local var_0_45 = {
	NEVER = 0,
	EVERY_MONTH = 3,
	MANUAL = 4,
	EVERY_WEEK = 2,
	EVERY_DAY = 1
}
local var_0_46 = {}
local var_0_47 = {
	{
		offsetx = 15,
		height = 275,
		width = 630,
		offsety = 10
	},
	{
		offsetx = 200,
		height = 320,
		width = 630,
		offsety = 20
	},
	{
		offsetx = 200,
		height = 660,
		width = 630,
		offsety = 0
	},
	{
		offsetx = 200,
		height = 280,
		width = 630,
		offsety = 20
	},
	{
		offsetx = 200,
		height = 280,
		width = 630,
		offsety = 20
	},
	{
		offsetx = 10,
		height = 330,
		width = 630,
		offsety = -12
	}
}

setmetatable(var_0_46, {
	__index = function(arg_8_0, arg_8_1)
		if var_0_47[var_0_40[arg_8_1]] then
			return var_0_47[var_0_40[arg_8_1]]
		else
			return {
				offsetx = 15,
				height = 275,
				width = 630,
				offsety = 10
			}
		end
	end
})

local var_0_48 = {
	offsetx = 22,
	height = 380,
	width = 630,
	offsety = -10
}
local var_0_49 = {
	[6800202] = "public/currency/6800202.png",
	[SHOP_CURRENCY_GOLD] = IMAGE_GOLD,
	[SHOP_CURRENCY_DIAMOND] = IMAGE_DIAMOND,
	[SHOP_CURRENCY_HORNOR] = "public/currency/arenascene_dot_1.png",
	[SHOP_CURRENCY_EXPLORECOIN] = "public/currency/explorecoin.png",
	[BLACK_CARD] = "public/currency/1500001_1.png",
	[BLACK_SP_CARD] = "public/currency/1500002_1.png",
	[SHOP_CURRENCY_RMB] = "public/currency/rmb_white.png",
	[85000006] = "equipment/" .. item_data[85000006].image_id .. ".png"
}

setmetatable(var_0_49, {
	__index = function(arg_9_0, arg_9_1)
		return "public/currency/" .. item_data[arg_9_1].image_id .. ".png"
	end
})

local var_0_50 = {
	nil,
	"mainScenebg/market/",
	"mainScenebg/market/",
	"mainScenebg/market/"
}

setmetatable(var_0_50, {
	__index = function(arg_10_0, arg_10_1)
		return "equipment/"
	end
})

local var_0_51 = {
	".png",
	".jpg",
	nil,
	".jpg"
}

setmetatable(var_0_51, {
	__index = function(arg_11_0, arg_11_1)
		return ".png"
	end
})

local var_0_52 = {
	"college_btn",
	"cat_btn",
	"activity_btn"
}
local var_0_54 = 0
local var_0_55 = 1
local var_0_56 = 1
local var_0_57 = 2
local var_0_58 = 3
local var_0_59 = {}

var_0_59.have = 1
var_0_59.attrs = {}

local var_0_60 = 0

local function var_0_61(arg_12_0, arg_12_1)
	if arg_12_0 == nil then
		return false
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0) do
		if iter_12_1 == arg_12_1 then
			return true
		end
	end

	return false
end

local function var_0_62(arg_13_0, arg_13_1)
	local var_13_0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0) do
		if iter_13_1 == arg_13_1 then
			var_13_0 = iter_13_0

			break
		end
	end

	if var_13_0 then
		table.remove(arg_13_0, var_13_0)
	end
end

function MarketLayer:createBottomBtn()
	self.btnTables = {}

	for iter_14_0 = 1, #var_0_52 do
		local var_14_3 = ccui.Button:create()

		var_14_3:setName(var_0_52[iter_14_0])
		var_14_3:setTouchEnabled(false)
		var_14_3:loadTextures("MarketLayer/" .. var_0_52[iter_14_0] .. ".png", "MarketLayer/" .. var_0_52[iter_14_0] .. "_bottom.png", "MarketLayer/" .. var_0_52[iter_14_0] .. "_bottom.png", var_0_24)

		local var_14_4 = ccui.ImageView:create("MarketLayer/shop_new_icon.png", var_0_24)

		var_14_4:setPosition(cc.p(var_14_3:getContentSize().width / 2 + 10, var_14_3:getContentSize().height / 2 + 20))
		var_14_4:setName("redDot")
		var_14_4:setVisible(false)
		var_14_3:addChild(var_14_4)

		self.btnTables[#self.btnTables + 1] = var_14_3

		var_14_3:setPosition(cc.p(640 - ((not hexie_manager:canShowSkinMarket() or nil) and {
			280,
			100,
			100
		})[iter_14_0], 36))

		var_14_3.id = iter_14_0

		self.panelBottom:addChild(var_14_3, 999)
		var_14_3:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.indexId == arg_15_0.id then
				return
			end

			if not self.rpcCallbackFalg then
				return
			end

			self:switchBtn(arg_15_0.id)
			self:updateRightButtonList()
			self:updateButtonList()
			self:refreshTableData()
			self:refreshTime()
			self:updateCurActiveTime()
		end)
	end

	if not hexie_manager:canShowSkinMarket() then
		self.btnTables[3]:setVisible(false)
	end
end

function MarketLayer:initSwitchEvent(arg_16_1)
	local var_16_0 = self:getEventDispatcher()

	var_16_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("switchLeftBtn", function(arg_17_0)
		if not arg_17_0 or not arg_17_0.name then
			return
		end

		if arg_17_0.name == self.selectedType then
			return
		end

		self.selectedType = arg_17_0.name

		if self.openSingleMarket then
			if type(self.openSingleMarket) == "string" then
				self.openSingleMarket = {
					self.openSingleMarket
				}
			end

			local var_17_0 = false

			for iter_17_0, iter_17_1 in pairs(self.openSingleMarket) do
				if iter_17_1 == self.selectedType then
					var_17_0 = true
				end
			end

			if not var_17_0 then
				table.insert(self.openSingleMarket, self.selectedType)
			end

			self.indexId = var_0_42[arg_17_0.name]

			self:updateDataByGain()
			self:updateBtnByGain()
			self:updateButtonList()
			self:refreshTime()
			self:refreshTableData()
			self:updateCurActiveTime()
		else
			self.indexId = var_0_42[arg_17_0.name]

			self:switchBtn(self.indexId, arg_17_0.name)
			self:updateRightButtonList()
			self:updateButtonList()
			self:refreshTableData()
			self:refreshTime()
			self:updateCurActiveTime()
		end
	end), self.panel_tab_three)
	var_16_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_18_0)
		self:updateTopInfo()
	end), self)
end

function MarketLayer:switchBtn(arg_19_1, arg_19_2, arg_19_3)
	print(arg_19_1, arg_19_2)

	self.indexId = arg_19_1

	for iter_19_0, iter_19_1 in pairs(self.btnTables) do
		if iter_19_0 == self.indexId then
			iter_19_1:setBright(false)

			local var_19_0 = {}

			if iter_19_1:getName() == "college_btn" then
				self.selectedType = arg_19_2 or self.collegeShopName[1]:getName()

				if arg_19_3 then
					var_19_0 = self.collegeShopName
				end
			elseif iter_19_1:getName() == "cat_btn" then
				self.selectedType = arg_19_2 or self.catShopName[1]:getName()

				if arg_19_3 then
					var_19_0 = self.catShopName
				end
			else
				self.selectedType = arg_19_2 or self.activityShopName[1]:getName()

				if arg_19_3 then
					var_19_0 = self.activityShopName
				end
			end

			if not self.showinfo or not next(self.showinfo) then
				for iter_19_2, iter_19_3 in pairs(var_19_0) do
					if iter_19_3:getName() == var_0_1 then
						self.selectedType = var_0_1

						break
					end
				end
			end
		else
			iter_19_1:setBright(true)
		end
	end

	self:replaceUI()
	self:updateBlackCardDes()
	self:updatebtnCoupons()
end

function MarketLayer:updateRightButtonList()
	if var_0_52[self.indexId] == "college_btn" then
		self.panel_tab:setVisible(true)
		self.panel_tab_two:setVisible(false)
		self.panel_tab_three:setVisible(false)
	elseif var_0_52[self.indexId] == "cat_btn" then
		self.panel_tab:setVisible(false)
		self.panel_tab_two:setVisible(true)
		self.panel_tab_three:setVisible(false)
	else
		self.panel_tab:setVisible(false)
		self.panel_tab_two:setVisible(false)
		self.panel_tab_three:setVisible(true)
	end

	self.panel_tab_two:setPositionY(self.displayPos.panel_tab)
	self.panel_tab_three:setPositionY(self.displayPos.panel_tab)
end

function MarketLayer:createButton(arg_21_1)
	local var_21_0 = ccui.Button:create()

	var_21_0:setSwallowTouches(false)
	var_21_0:setName(arg_21_1)
	var_21_0:loadTextures("mainScenebg/market_type/1_1_normal.png", "mainScenebg/market_type/1_1_normal.png")
	var_21_0:setAnchorPoint(cc.p(0.5, 0.5))

	if arg_21_1 ~= "1-10" then
		if arg_21_1 == "1-21" then
			L2ActorSprite = L2Actor:create("effect/market_sweep_light/skeleton.json", "effect/market_sweep_light/skeleton.atlas")

			L2ActorSprite:setPosition(cc.p(var_21_0:getContentSize().width / 2, var_21_0:getContentSize().height / 2))
			var_21_0:addChild(L2ActorSprite, 99)
			L2ActorSprite:playAni(nil, "animation", true)
		end
	end

	local var_21_1 = ccui.ImageView:create("MarketLayer/shop_new_icon.png", var_0_24)

	var_21_1:setPosition(cc.p(var_21_0:getContentSize().width - 12, var_21_0:getContentSize().height - 15))
	var_21_1:setName("redDot")
	var_21_1:setVisible(false)
	var_21_0:addChild(var_21_1)

	for iter_21_0, iter_21_1 in pairs(self.buttonName) do
		if iter_21_1 == arg_21_1 then
			var_21_0:setTag(#self.buttonName - iter_21_0 + 10)
		end
	end

	if arg_21_1 == "2-1" then
		local var_21_2 = ccui.ImageView:create("MarketLayer/shop_new_icon.png", var_0_24)

		var_21_2:setPositionX(var_21_0:getContentSize().width - 12)
		var_21_2:setPositionY(var_21_0:getContentSize().height - 15)
		var_21_2:setName("reddot")
		var_21_0:addChild(var_21_2)

		if alert_manager.alertsys[ALERT_MARKET] == true then
			var_21_2:setVisible(alert_manager.alertsys[ALERT_MARKET] == true)
		else
			var_21_2:setVisible(false)
		end
	end

	var_21_0:addTouchEventListener(function(arg_22_0, arg_22_1)
		if self.rpcCallbackFalg == false then
			return
		end

		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_22_0:getName() == "2-1" then
			alert_manager:unregister_alert(ALERT_MARKET)

			if arg_22_0:getChildByName("reddot") then
				arg_22_0:getChildByName("reddot"):setVisible(false)
				alert_manager:unregister_alert(ALERT_MARKET)
			end
		end

		if self.selectedType == arg_22_0:getName() then
			return
		end

		if math.abs(arg_22_0:getTouchBeganPosition().y - arg_22_0:getTouchEndPosition().y) > 50 then
			return
		end

		self.rpcCallbackFalg = false
		self.selectedType = arg_22_0:getName()

		self:updateButtonList()
		self:refreshTime()
		self:refreshTableData()
		self:updateCurActiveTime()
		self:checkpushBrowseTime()
		self:updateBlackCardDes()
		self:replaceUI()
		self:updatebtnCoupons()
	end)

	return var_21_0
end

function MarketLayer:checkpushBrowseTime()
	if self.lastSelectType ~= self.selectedType then
		if self.lastSelectType then
			self:pushBrowseTime(self.lastSelectType)
		else
			self:pushBrowseTime(self.selectedType)
		end

		self.lastSelectType = self.selectedType
		self.lastBrowseTime = os.time()
	end
end

function MarketLayer:pushBrowseTime(arg_24_1)
	if not self.lastBrowseTime then
		return
	end

	AnalyticManager.browseShop(arg_24_1, os.time() - self.lastBrowseTime)
end

local var_0_63 = 3000
local var_0_64 = 13000

function MarketLayer:initTimeRefreshHandle()
	local var_25_0 = {
		[6] = var_0_64
	}
	local var_25_1 = {
		[6] = MAX_REFRESH_TIME_COMPONENT
	}

	local function var_25_2(arg_26_0)
		arg_26_0:setTouchEnabled(false)

		local function var_26_0(arg_27_0)
			local var_27_0 = var_25_0[self.shopList[self.marketType[self.selectedType]].id] or var_0_63

			if not diamond_update_data[var_27_0 + arg_27_0 + 1] then
				global_ShowBlockWords(L_MARKET_REFRESH.Out_Of_Times)

				return
			end

			local var_27_1 = diamond_update_data[var_27_0 + arg_27_0 + 1].costdiamond
			local var_27_2 = global_deepCopy(L_REFRESH_MARKET[self.shopList[self.marketType[self.selectedType]].id])
			local var_27_3 = (var_25_1[self.shopList[self.marketType[self.selectedType]].id] or MAX_REFRESH_TIME) - arg_27_0
			local var_27_4 = var_25_1[self.shopList[self.marketType[self.selectedType]].id] or MAX_REFRESH_TIME

			var_27_2.more = var_27_2.more .. var_27_3 .. "/" .. var_27_4
			var_27_2.titleImage = "title_refresh_shop.png"

			LayerManager:pushInLayer("PopDoLayer", {
				costtype = "diamond",
				markettype = self.shopList[self.marketType[self.selectedType]].id,
				remaintimes = var_27_3,
				totaltimes = var_27_4,
				surecallback = function()
					shop_manager:refresh_market(self.shopList[self.marketType[self.selectedType]].id, function(arg_29_0)
						if arg_29_0 == 1 then
							global_ShowBlockWords(L_MARKET_REFRESH.Success, RISE_WORDS_SUCCESS)
							self:refreshTableData()
						end
					end)
				end,
				own = playermodel.diamond,
				cost = var_27_1,
				labels = var_27_2
			})
		end

		shop_manager:get_market_refresh_time(self.shopList[self.marketType[self.selectedType]].id, function(arg_30_0, arg_30_1, arg_30_2)
			if arg_30_2 then
				global_ShowBlockWords(L_MARKET_REFRESH.Out_Of_Times)
				audio_manager:playeffectMusicTest("sound/invalid")
			else
				var_26_0(arg_30_0)
			end

			arg_26_0:setTouchEnabled(true)
		end)
	end

	self.refreshBtn:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.refreshmanual[self.selectedType] > 0 then
			var_25_2(arg_31_0)
		else
			global_ShowBlockWords(L_MARKET_REFRESH.Auto_Refresh)
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

function MarketLayer:updateCurActiveTime()
	if self.autoRefreshType[self.selectedType] == var_0_45.MANUAL then
		self.panelBottom:getChildByName("Image_surplusTimeBottom"):setVisible(false)

		return
	end

	local var_32_0 = (function(arg_33_0)
		for iter_33_0, iter_33_1 in pairs(self.marketData) do
			if arg_33_0 == iter_33_1.id then
				return iter_33_0
			end
		end
	end)((tonumber(split(self.selectedType, "-")[2])))

	if self.marketData[var_32_0].stat == 2 then
		local var_32_1 = self.marketData[var_32_0].finishtime
		local var_32_2 = -1

		playermodel:getServerTime(function()
			var_32_2 = self:getResidueTime(var_32_1)

			self.panelBottom:getChildByName("Image_surplusTimeBottom"):getChildByName("Label_time"):setString(var_32_2)
			self.panelBottom:getChildByName("Image_surplusTimeBottom"):setVisible(true)

			if tonumber(var_32_2) == -1 then
				self.panelBottom:getChildByName("Image_surplusTimeBottom"):setVisible(false)
			end
		end)
	else
		self.panelBottom:getChildByName("Image_surplusTimeBottom"):setVisible(false)
	end
end

function MarketLayer.getResidueTime(arg_35_0, arg_35_1)
	if not arg_35_1 then
		return "-1"
	end

	local var_35_5 = global_get_time_by_date(arg_35_1) - playermodel.onlineTime
	local var_35_6 = math.floor(var_35_5 / 24 / 3600)
	local var_35_7 = math.floor((var_35_5 - var_35_6 * 24 * 3600) / 3600)
	local var_35_8 = math.floor((var_35_5 - var_35_6 * 24 * 3600 - var_35_7 * 3600) / 60)

	return var_35_6 ~= 0 and string.format(L_TIME_TEXT[1], var_35_6, var_35_7) or var_35_7 ~= 0 and string.format(L_TIME_TEXT[2], var_35_7, var_35_8) or string.format(L_TIME_TEXT[3], var_35_8)
end

function MarketLayer.isOpenShop(arg_36_0, arg_36_1)
	if var_0_43[arg_36_1] then
		return false
	end

	if config.limit_open_system and var_0_41[arg_36_1] then
		return level_manager:isPlayerPassLevel(var_0_41[arg_36_1])
	end

	return true
end

function MarketLayer:updateDataByGain()
	self.shopList = {}

	for iter_37_0, iter_37_1 in pairs(self.marketData) do
		if iter_37_1.stat == 1 or iter_37_1.stat == 2 then
			if iter_37_1.type == "2-2" then
				local var_37_0, var_37_1 = LayerManager:getLayerUnlockStat("AdventureLayer")

				if var_37_0 then
					self.shopList[#self.shopList + 1] = {
						order = iter_37_1.order,
						id = iter_37_1.id,
						type = iter_37_1.type,
						refreshtime = iter_37_1.refreshtime,
						refreshtype = iter_37_1.refreshtype,
						refreshtime = iter_37_1.refreshtime,
						refreshmanual = iter_37_1.refreshmanual,
						havenewitem = iter_37_1.havenewitem
					}
				end
			else
				self.shopList[#self.shopList + 1] = {
					order = iter_37_1.order,
					id = iter_37_1.id,
					type = iter_37_1.type,
					refreshtime = iter_37_1.refreshtime,
					refreshtype = iter_37_1.refreshtype,
					refreshtime = iter_37_1.refreshtime,
					refreshmanual = iter_37_1.refreshmanual,
					havenewitem = iter_37_1.havenewitem
				}
			end
		end
	end

	table.sort(self.shopList, function(arg_38_0, arg_38_1)
		return arg_38_0.order < arg_38_1.order
	end)

	self.activityShopName = {}
	self.collegeShopName = {}
	self.catShopName = {}
	self.autoRefreshType = {}
	self.refreshmanual = {}
	self.marketType = {}
	self.nextRefreshTime = {}
	self.buttonName = {}

	for iter_37_2, iter_37_3 in pairs(self.shopList) do
		if self:isOpenShop(iter_37_3.type) and self:isOpenShopByParam(iter_37_3.type) then
			self.marketType[iter_37_3.type] = iter_37_2
			self.buttonName[#self.buttonName + 1] = iter_37_3.type
			self.autoRefreshType[iter_37_3.type] = iter_37_3.refreshtype
			self.nextRefreshTime[iter_37_3.type] = iter_37_3.refreshtime
			self.refreshmanual[iter_37_3.type] = iter_37_3.refreshmanual
		end
	end

	print("self.marketType====", dump(self.marketType))

	self.lastBrowseTime = os.time()
end

function MarketLayer:initData()
	self.shopList = {}

	for iter_39_0, iter_39_1 in pairs(self.marketData) do
		if iter_39_1.stat == 1 or iter_39_1.stat == 2 then
			if iter_39_1.type == "2-2" then
				local var_39_0, var_39_1 = LayerManager:getLayerUnlockStat("AdventureLayer")

				if var_39_0 then
					self.shopList[#self.shopList + 1] = {
						order = iter_39_1.order,
						id = iter_39_1.id,
						type = iter_39_1.type,
						refreshtime = iter_39_1.refreshtime,
						refreshtype = iter_39_1.refreshtype,
						refreshtime = iter_39_1.refreshtime,
						refreshmanual = iter_39_1.refreshmanual,
						havenewitem = iter_39_1.havenewitem
					}
				end
			else
				self.shopList[#self.shopList + 1] = {
					order = iter_39_1.order,
					id = iter_39_1.id,
					type = iter_39_1.type,
					refreshtime = iter_39_1.refreshtime,
					refreshtype = iter_39_1.refreshtype,
					refreshtime = iter_39_1.refreshtime,
					refreshmanual = iter_39_1.refreshmanual,
					havenewitem = iter_39_1.havenewitem
				}
			end
		end
	end

	table.sort(self.shopList, function(arg_40_0, arg_40_1)
		return arg_40_0.order < arg_40_1.order
	end)

	self.activityShopName = {}
	self.collegeShopName = {}
	self.catShopName = {}
	self.autoRefreshType = {}
	self.refreshmanual = {}
	self.marketType = {}
	self.nextRefreshTime = {}
	self.buttonName = {}
	self.tableViewList = {}

	if self.openSingleMarket then
		local var_39_2 = true
		local var_39_3 = type(self.openSingleMarket) == "string" and {
			self.openSingleMarket
		} or self.openSingleMarket

		for iter_39_2, iter_39_3 in pairs(self.shopList) do
			if self:isOpenShop(iter_39_3.type) then
				for iter_39_4, iter_39_5 in pairs(var_39_3) do
					if iter_39_3.type == iter_39_5 then
						iter_39_5 = nil
						var_39_2 = false
					end
				end
			end
		end

		if var_39_2 then
			self.openSingleMarket = {
				"1-1"
			}
		end
	end

	for iter_39_6, iter_39_7 in pairs(self.shopList) do
		if self:isOpenShop(iter_39_7.type) and self:isOpenShopByParam(iter_39_7.type) then
			if not self.openSingleMarket and var_0_42[iter_39_7.type] ~= 4 then
				self.marketType[iter_39_7.type] = iter_39_6
				self.buttonName[#self.buttonName + 1] = iter_39_7.type
				self.autoRefreshType[iter_39_7.type] = iter_39_7.refreshtype
				self.nextRefreshTime[iter_39_7.type] = iter_39_7.refreshtime
				self.refreshmanual[iter_39_7.type] = iter_39_7.refreshmanual
			elseif self.openSingleMarket then
				self.marketType[iter_39_7.type] = iter_39_6
				self.buttonName[#self.buttonName + 1] = iter_39_7.type
				self.autoRefreshType[iter_39_7.type] = iter_39_7.refreshtype
				self.nextRefreshTime[iter_39_7.type] = iter_39_7.refreshtime
				self.refreshmanual[iter_39_7.type] = iter_39_7.refreshmanual
			end
		end
	end

	self.lastBrowseTime = os.time()
end

function MarketLayer:isOpenShopByParam(arg_41_1)
	if self.openSingleMarket and type(self.openSingleMarket) == "table" then
		for iter_41_0, iter_41_1 in pairs(self.openSingleMarket) do
			if iter_41_1 == arg_41_1 then
				return true
			end
		end

		return false
	elseif self.openSingleMarket then
		return self.openSingleMarket == arg_41_1
	end

	return true
end

function MarketLayer:initBtn()
	for iter_42_0 = 1, #self.btnTables do
		self.btnTables[iter_42_0]:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			self.btnTables[iter_42_0]:setTouchEnabled(true)
		end)))
	end
end

function MarketLayer:init(arg_44_1)
	self.showinfo = arg_44_1 or {}
	var_0_3 = self
	self.tilepath = arg_44_1 and arg_44_1.topImgPath
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "MarketLayer.json" or "MarketLayer.ExportJson")

	self:addChild(self.rootlayer)

	self.returnLayer = self.showinfo.returnLayer or nil
	self.exitCallback = self.showinfo.exitCallback or nil
	self.itemid = self.showinfo.itemid or nil
	self.openSingleMarket = self.showinfo.singleMarket
	self.buttonList = {}
	self.listData = {}
	self.costTypeTable = {}
	self.rpcCallbackFalg = false
	self.refresh_bg = ccui.Helper:seekWidgetByName(self.rootlayer, "refresh_bg")
	self.refreshBtn = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_refreshBtn")
	self.coin = ccui.Helper:seekWidgetByName(self.rootlayer, "coin_bg")
	self.costList = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_costList")
	self.panel_tab = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_tab")
	self.panel_tab_two = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_tab_two")
	self.panel_tab_three = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_tab_three")
	self.panelTable = {
		self.panel_tab,
		self.panel_tab_two,
		self.panel_tab_three
	}
	self.panelBottom = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom")
	self.purchaseid_to_index = {}

	if self.openSingleMarket then
		self:getMarketDataFromServer(function()
			self:initData()
			self:setDefaultSelectType()
			self:initButtonList()
			self:updateButtonList()
			self:refreshTableData()
			self:refreshTime()
			self:updateCurActiveTime()
			self:registerTimeCheckEvent()
			self:updateBlackCardDes()
		end)
	else
		self:getMarketDataFromServer(function()
			self:initData()
			self:setDefaultSelectType()
			self:initButtonList()
			self:createBottomBtn()
			self:initBottomButton()
			self:initBtn()

			if hexie_manager:canShowSkinMarket() then
				self:switchBtn(#self.btnTables, nil, true)
			else
				self:switchBtn(1, nil, true)
			end

			self:updateRightButtonList()
			self:updateButtonList()
			self:refreshTableData()
			self:refreshTime()
			self:updateCurActiveTime()
			self:registerTimeCheckEvent()
			self:updateBlackCardDes()
		end)
		self:registerGuidesEvent()
	end

	self:createTitleSprite()
	self:registerReturnEvent()
	self:initTimeRefreshHandle()
	self:initSwitchEvent(getSingleDataFromPopCallback)
	self:initEventListenter()
	self:initCouponsBtn()
	self:fullScreen(self.rootlayer)
	self:registerScriptHandler(function(arg_47_0)
		if arg_47_0 == "exit" then
			var_0_1 = self.selectedType
			var_0_2 = self.tableViewList[var_0_40[self.selectedType]]:getContentOffset()
			var_0_3 = nil

			self:updateNewAlert()
			self:pushBrowseTime(self.selectedType)
			TextureManager:removeSpineTexturesWithOutCollect()
			shop_manager:clear_shop_buy_stack()

			if self.skeletonData then
				self.skeletonData:release()
			end

			self.skeletonData = nil

			activity_manager:releaseEventListenerByName("MarketLayer")
		end
	end)
	self:registerCommityEventListener()
end

function MarketLayer:fullScreen(arg_48_1)
	local var_48_0 = GameDisplay.getUiScreenSize()

	self.panel_tab.full_size = cc.size(self.panel_tab:getContentSize().width, 1013 + var_48_0.height - config._DESIGN_HEIGHT - GameDisplay.notch_height)

	self.panel_tab:setContentSize(self.panel_tab.full_size)

	self.panel_tab_two.full_size = cc.size(self.panel_tab:getContentSize().width, 1013 + var_48_0.height - config._DESIGN_HEIGHT - GameDisplay.notch_height)

	self.panel_tab_two:setContentSize(self.panel_tab_two.full_size)

	self.panel_tab_three.full_size = cc.size(self.panel_tab:getContentSize().width, 1013 + var_48_0.height - config._DESIGN_HEIGHT - GameDisplay.notch_height)

	self.panel_tab_three:setContentSize(self.panel_tab_three.full_size)

	self.displayPos = global_get_node_display_posy(arg_48_1, {
		panel_tab = {
			focusName = "panel_tab",
			reference = TRANSFORM_REFERENCE.UP,
			posY = 1083 + GameDisplay.fix_y * 2 - GameDisplay.notch_height,
			unit = TRANSFORM_UNIT.PX
		},
		panel_tab_two = {
			posY = 1083,
			focusName = "panel_tab_two",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		},
		panel_tab_three = {
			posY = 1083,
			focusName = "panel_tab_three",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		},
		Panel_costList = {
			posY = 52,
			focusName = "Panel_costList",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		},
		title = {
			posY = 60,
			focusName = "title",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		}
	})

	for iter_48_0, iter_48_1 in pairs(self.displayPos) do
		local var_48_1 = ccui.Helper:seekWidgetByName(arg_48_1, iter_48_0)

		if var_48_1 then
			var_48_1:setPositionY(iter_48_1)
		end
	end

	ccui.Helper:seekWidgetByName(arg_48_1, "panel_tab"):setPosition(0, GameDisplay.height)
	ccui.Helper:seekWidgetByName(arg_48_1, "panel_tab"):runAction(cc.MoveTo:create(0.5, cc.p(0, self.displayPos.panel_tab)))
end

function MarketLayer:exitAni()
	self.panel_tab:runAction(cc.MoveTo:create(0.5, cc.p(0, GameDisplay.height)))
	self.panel_tab_two:runAction(cc.MoveTo:create(0.5, cc.p(0, GameDisplay.height)))
	self.panel_tab_three:runAction(cc.MoveTo:create(0.5, cc.p(0, GameDisplay.height)))
end

function MarketLayer.getMarketDataFromServer(arg_50_0, arg_50_1)
	shop_manager:get_config_data(function(arg_51_0, arg_51_1)
		if arg_51_0 == 1 then
			for iter_51_0, iter_51_1 in pairs(arg_51_1) do
				if var_0_43[arg_51_1[iter_51_0]] then
					arg_51_1[iter_51_0] = nil
				end
			end

			arg_50_0.marketData = arg_51_1

			for iter_51_2, iter_51_3 in ipairs(arg_51_1) do
				if iter_51_3.type then
					var_0_40[iter_51_3.type] = iter_51_3.ui_type
					var_0_42[iter_51_3.type] = iter_51_3.shoptable_type
				end
			end

			time_check_manager:insertShopTimeTrigger(arg_51_1)

			if arg_50_1 then
				arg_50_1()
			end
		end
	end)
end

function MarketLayer:registerReturnEvent()
	ccui.Helper:seekWidgetByName(self.rootlayer, "button_back"):addTouchEventListener(function(arg_53_0, arg_53_1)
		if arg_53_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:layerOutAni(function()
			self:exitAni()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)
end

function MarketLayer:setDefaultSelectType()
	for iter_55_0, iter_55_1 in pairs(self.buttonName) do
		if iter_55_1 == self.showinfo.showType then
			self.selectedType = self.showinfo.showType

			break
		end

		if iter_55_0 == #self.buttonName then
			self.selectedType = self.buttonName[1]

			if not self.showinfo or not next(self.showinfo) then
				for iter_55_2, iter_55_3 in pairs(self.buttonName) do
					if var_0_1 == iter_55_3 then
						self.selectedType = iter_55_3

						break
					end
				end
			end
		end
	end

	self:replaceUI()
end

function MarketLayer:createTitleSprite()
	require("view.Sprite.TitleSprite")

	self.titleSprite = TitleSprite:create("", 2, "MarketLayer/maker_top.png")

	self.titleSprite:setName("title")
	self.titleSprite:setPosition(0, 1076)
	self.rootlayer:addChild(self.titleSprite)
end

function MarketLayer:initBottomButton()
	for iter_57_0, iter_57_1 in ipairs(self.buttonName) do
		if self.btnTables[var_0_42[iter_57_1]]:getChildByName("redDot"):isVisible() == true then
			-- block empty
		else
			self.btnTables[var_0_42[iter_57_1]]:getChildByName("redDot"):setVisible(self.shopList[self.marketType[iter_57_1]].havenewitem)
		end
	end

	if self.btnTables and alert_manager.alertsys[ALERT_MARKET] == true then
		self.btnTables[2]:getChildByName("redDot"):setVisible(true)
	end
end

function MarketLayer:judgeRedDot(arg_58_1)
	local var_58_0 = self.panelTable[arg_58_1]:getChildren()

	for iter_58_0 = 1, #var_58_0 do
		local var_58_1 = var_58_0[iter_58_0]:getChildByName("redDot")
		local var_58_2 = var_58_0[iter_58_0]:getChildByName("reddot")

		if var_58_2 and var_58_2:isVisible() == true then
			return true
		end

		if var_58_1:isVisible() == true then
			return true
		end
	end

	return false
end

function MarketLayer:updateBtnByGain()
	self.panel_tab:removeAllChildren()

	self.buttonList = {}

	for iter_59_0, iter_59_1 in ipairs(self.buttonName) do
		index = #self.buttonList + 1
		self.buttonList[index] = {}
		self.buttonList[index].button = self:createButton(iter_59_1)

		self.buttonList[index].button:getChildByName("redDot"):setVisible(self.shopList[self.marketType[iter_59_1]].havenewitem)

		self.buttonList[index].selected = self.selectedType == iter_59_1
		self.collegeShopName[#self.collegeShopName + 1] = self.buttonList[index].button

		self.panel_tab:pushBackCustomItem(self.buttonList[index].button)
	end
end

function MarketLayer:initButtonList()
	self.panel_tab:setContentSize(self.panel_tab.full_size)
	self.panel_tab:setItemsMargin(0)
	self.panel_tab_two:setContentSize(self.panel_tab_two.full_size)
	self.panel_tab_two:setItemsMargin(0)
	self.panel_tab_three:setContentSize(self.panel_tab_three.full_size)
	self.panel_tab_two:setItemsMargin(0)

	local var_60_0 = {}
	local var_60_1 = 0

	for iter_60_0, iter_60_1 in ipairs(self.buttonName) do
		var_60_1 = #self.buttonList + 1
		self.buttonList[#self.buttonList + 1] = {}
		self.buttonList[var_60_1].button = self:createButton(iter_60_1)

		self.buttonList[var_60_1].button:getChildByName("redDot"):setVisible(self.shopList[self.marketType[iter_60_1]].havenewitem)

		self.buttonList[var_60_1].selected = self.selectedType == iter_60_1

		if not self.openSingleMarket then
			if var_0_42[iter_60_1] == 1 then
				self.collegeShopName[#self.collegeShopName + 1] = self.buttonList[var_60_1].button

				self.panel_tab:pushBackCustomItem(self.buttonList[var_60_1].button)
			elseif var_0_42[iter_60_1] == 2 then
				self.panel_tab_two:pushBackCustomItem(self.buttonList[var_60_1].button)

				self.catShopName[#self.catShopName + 1] = self.buttonList[var_60_1].button
			elseif var_0_42[iter_60_1] == 3 then
				self.activityShopName[#self.activityShopName + 1] = self.buttonList[var_60_1].button

				self.panel_tab_three:pushBackCustomItem(self.buttonList[var_60_1].button)
			end
		else
			self.collegeShopName[#self.collegeShopName + 1] = self.buttonList[var_60_1].button

			self.panel_tab:pushBackCustomItem(self.buttonList[var_60_1].button)
		end
	end

	while #var_60_0 ~= 0 do
		self.panel_tab_two:pushBackCustomItem(var_60_0[#var_60_0])
	end

	self.buttonList[var_60_1 + 1] = {}

	local var_60_3 = self:createButton("2-2")

	var_60_3:setVisible(false)

	self.buttonList[var_60_1 + 1].button = var_60_3
	self.buttonList[var_60_1 + 1].selected = self.selectedType == "2-2"

	if not self.openSingleMarket then
		self.panel_tab:pushBackCustomItem(self.buttonList[var_60_1 + 1].button)
		self.panel_tab_two:pushBackCustomItem(self.buttonList[var_60_1 + 1].button:clone())
		self.panel_tab_three:pushBackCustomItem(self.buttonList[var_60_1 + 1].button:clone())
	else
		self.panel_tab:pushBackCustomItem(self.buttonList[var_60_1 + 1].button)
	end

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		local var_61_0 = self:getInitScrollPercent()

		if var_61_0 then
			self.panel_tab:jumpToPercentVertical(var_61_0)
			self.panel_tab_two:jumpToPercentVertical(var_61_0)
			self.panel_tab_three:jumpToPercentVertical(var_61_0)
		end
	end)))
end

function MarketLayer:getInitScrollPercent()
	local function var_62_0(arg_63_0)
		local var_63_0 = arg_63_0:getChildren()
		local var_63_1 = Utility:indexOf(var_63_0, function(arg_64_0)
			return arg_64_0:getName() == self.selectedType
		end)

		if var_63_1 > 0 then
			return (var_63_1 - 1) / #var_63_0 * 100
		else
			return -1
		end
	end

	if var_62_0(self.panel_tab) ~= -1 then
		return var_62_0(self.panel_tab)
	end

	if var_62_0(self.panel_tab_two) ~= -1 then
		return var_62_0(self.panel_tab_two)
	end

	if var_62_0(self.panel_tab_three) ~= -1 then
		return var_62_0(self.panel_tab_three)
	end

	return 0
end

function MarketLayer.sortMarketlist(arg_65_0, arg_65_1)
	local function var_65_0(arg_66_0)
		if item_data[arg_66_0].bag_item_type == kITEM_SKIN_GIFT then
			for iter_66_0, iter_66_1 in pairs(drop_manager:getDropMsg(item_data[arg_66_0].mode_id).equips) do
				if item_data[iter_66_1.dropid].bag_item_type == kITEM_SKIN then
					return playermodel.haveSuit[item_data[iter_66_1.dropid].major]
				end
			end
		end

		return false
	end

	local function var_65_1(arg_67_0)
		if furnituresuit_data[item_data[arg_67_0].suit_id].servantid and major_factor_data[furnituresuit_data[item_data[arg_67_0].suit_id].servantid] and major_factor_data[furnituresuit_data[item_data[arg_67_0].suit_id].servantid].servant then
			return playermodel.haveServant[major_factor_data[furnituresuit_data[item_data[arg_67_0].suit_id].servantid].servant]
		else
			return false
		end
	end

	local function var_65_2(arg_68_0, arg_68_1, arg_68_2)
		if arg_68_2 and arg_68_2.uncolor_clothes then
			if shop_manager:fixUnColorMsg(arg_68_2).limit_buy_num <= 0 then
				return 0
			else
				return 1
			end
		end

		if arg_68_0 == arg_68_1 then
			return 0
		else
			return 1
		end
	end

	local var_65_3 = {
		[6] = {
			weight = 5,
			func = function(self, arg_74_1)
				local var_74_0 = global_get_time_by_date(self.discountfinish) > time_check_manager:getCurTime() and 1 or 0
				local var_74_1 = global_get_time_by_date(arg_74_1.discountfinish) > time_check_manager:getCurTime() and 1 or 0

				if shop_manager:is_skin_shop(arg_65_0.selectedType) then
					return "=="
				end

				if var_74_0 == var_74_1 then
					return "=="
				else
					return var_74_1 < var_74_0
				end
			end
		},
		[5] = {
			weight = 10,
			func = function(self, arg_72_1)
				local var_72_2 = 0
				local var_72_3 = 0
				local var_72_4 = {
					[1502001] = true,
					[1502005] = true,
					[1502002] = true,
					[107103000] = true,
					[1502003] = true,
					[1502004] = true
				}

				if var_72_4[self.itemtype] then
					var_72_2 = 100
				end

				if var_72_4[arg_72_1.itemtype] then
					var_72_3 = 100
				end

				if var_72_2 == var_72_3 then
					return "=="
				else
					return var_72_3 < var_72_2
				end
			end
		},
		[4] = {
			weight = 3,
			func = function(self, arg_71_1)
				local var_71_0 = 0
				local var_71_1 = 0

				if item_data[self.itemtype].servant and item_data[self.itemtype].bag_item_type == kITEM_WEAPON and item_data[arg_71_1.itemtype].servant and item_data[arg_71_1.itemtype].bag_item_type == kITEM_WEAPON then
					var_71_0 = playermodel.haveServant[item_data[self.itemtype].servant] and 1 or 0
					var_71_1 = playermodel.haveServant[item_data[arg_71_1.itemtype].servant] and 1 or 0
				end

				if var_71_0 == var_71_1 then
					return "=="
				else
					return var_71_1 < var_71_0
				end
			end
		},
		[3] = {
			weight = 1,
			func = function(self, arg_73_1)
				return self.pos < arg_73_1.pos
			end
		},
		[2] = {
			weight = 2,
			func = function(self, arg_70_1)
				local var_70_0 = 0
				local var_70_1 = 0

				if item_data[self.itemtype].major and item_data[self.itemtype].bag_item_type == kITEM_SKIN then
					var_70_0 = playermodel.haveSuit[item_data[self.itemtype].major] and 1 or 0
				end

				if item_data[arg_70_1.itemtype].major and item_data[arg_70_1.itemtype].bag_item_type == kITEM_SKIN then
					var_70_1 = playermodel.haveSuit[item_data[arg_70_1.itemtype].major] and 1 or 0
				end

				if item_data[self.itemtype].exclusive and item_data[self.itemtype].bag_item_type == kITEM_GIFT_FOR_FRIEND then
					var_70_0 = playermodel.haveSuit[item_data[self.itemtype].exclusive] and 1 or 0
				end

				if item_data[arg_70_1.itemtype].exclusive and item_data[arg_70_1.itemtype].bag_item_type == kITEM_GIFT_FOR_FRIEND then
					var_70_1 = playermodel.haveSuit[item_data[arg_70_1.itemtype].exclusive] and 1 or 0
				end

				if item_data[self.itemtype].bag_item_type == kITEM_FURNITURE_GIFT then
					var_70_0 = var_65_1(self.itemtype) and 2 or not furnituresuit_data[item_data[self.itemtype].suit_id].servantid and 1 or 0
				end

				if item_data[arg_70_1.itemtype].bag_item_type == kITEM_FURNITURE_GIFT then
					var_70_1 = var_65_1(arg_70_1.itemtype) and 2 or not furnituresuit_data[item_data[arg_70_1.itemtype].suit_id].servantid and 1 or 0
				end

				if item_data[self.itemtype].bag_item_type == kITEM_SKIN_GIFT then
					var_70_0 = var_65_0(self.itemtype) and 1 or 0
				end

				if item_data[arg_70_1.itemtype].bag_item_type == kITEM_SKIN_GIFT then
					var_70_1 = var_65_0(arg_70_1.itemtype) and 1 or 0
				end

				if var_70_0 == var_70_1 then
					return "=="
				else
					return var_70_1 < var_70_0
				end
			end
		},
		{
			weight = 6,
			func = function(self, arg_69_1)
				if var_65_2(self.buy_limit, self.have_bought, self) == var_65_2(arg_69_1.buy_limit, arg_69_1.have_bought, arg_69_1) then
					return "=="
				else
					return var_65_2(self.buy_limit, self.have_bought, self) > var_65_2(arg_69_1.buy_limit, arg_69_1.have_bought, arg_69_1)
				end
			end
		}
	}

	table.sort(var_65_3, function(arg_75_0, arg_75_1)
		return arg_75_0.weight > arg_75_1.weight
	end)
	table.sort(arg_65_1, function(arg_76_0, arg_76_1)
		for iter_76_0 = 1, #var_65_3 do
			if var_65_3[iter_76_0].func(arg_76_0, arg_76_1) ~= "==" then
				return var_65_3[iter_76_0].func(arg_76_0, arg_76_1)
			end
		end
	end)
end

function MarketLayer:initEventListenter()
	self:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("BUY_ONEKEY_SUCCESS", function(arg_78_0)
		if self.selectedType ~= arg_78_0.markettype then
			return
		end

		if arg_78_0.result ~= 1 then
			return
		end

		if not arg_78_0.marketitems then
			return
		end

		local var_78_0 = {}

		for iter_78_0, iter_78_1 in pairs(arg_78_0.marketitems) do
			var_78_0[iter_78_1.pos] = iter_78_1
		end

		for iter_78_2, iter_78_3 in pairs(self.listData) do
			if var_78_0[iter_78_3.pos] then
				iter_78_3.have_bought = var_78_0[iter_78_3.pos].buycount
				iter_78_3.sell_out = iter_78_3.buy_limit and iter_78_3.buy_limit <= iter_78_3.have_bought
			end
		end

		self:updateTopInfo()
		self:updateShowingCells()
	end), self)
end

function MarketLayer:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_80_0)
		if not arg_80_0 or not arg_80_0.id then
			return
		end

		local var_80_0 = self.purchaseid_to_index[arg_80_0.id]

		if not self.purchaseid_to_index[arg_80_0.id] then
			return
		end

		self:updateTopInfo()

		self.listData[var_80_0].have_bought = self.listData[var_80_0].have_bought + 1
		self.listData[var_80_0].sell_out = self.listData[var_80_0].buy_limit and self.listData[var_80_0].buy_limit <= self.listData[var_80_0].have_bought

		self:updateShowingCells()
	end), self)
end

function MarketLayer:getListDataIndex()
	if not self.itemid then
		return
	end

	for iter_81_0 = 1, #self.listData do
		if self.itemid == self.listData[iter_81_0].itemid then
			return iter_81_0
		end
	end
end

function MarketLayer:refreshTableData()
	if self.selectedType == "2-1" then
		alert_manager:unregister_alert(ALERT_MARKET)
	end

	local var_82_0 = {}

	local function var_82_1(arg_83_0, arg_83_1)
		local var_83_0 = {
			itemid = self.listData[arg_83_1].itemid,
			item_attr = self.listData[arg_83_1].item_attr,
			costIcon = self.listData[arg_83_1].costIcon,
			cost_old = self.listData[arg_83_1].cost_old,
			sell_time = self.listData[arg_83_1].sell_time,
			uncolor_clothes = self.listData[arg_83_1].uncolor_clothes,
			_data = self.listData[arg_83_1],
			_shopList = self.shopList,
			_marketType = self.marketType,
			_selectedType = self.selectedType,
			index = arg_83_1
		}

		var_83_0.limitNum = self.listData[arg_83_1].buy_limit and self.listData[arg_83_1].buy_limit - self.listData[arg_83_1].have_bought or 100

		local var_83_1 = math.floor(shop_manager:getCurrencyNum(self.listData[arg_83_1].currency) / self.listData[arg_83_1].cost)

		if var_83_1 > var_83_0.limitNum then
			var_83_0.limitNum = var_83_0.limitNum or var_83_1
		end

		if shop_manager:is_collection(self.selectedType) then
			var_83_0.marketType = "market_collection"
			var_83_0.hideGainButton = false
			var_83_0.limitNum = self.listData[arg_83_1].buy_limit - self.listData[arg_83_1].have_bought
		else
			var_83_0.hideGainButton = true
		end

		local var_83_2 = self:getResidueTime(self.listData[arg_83_1].finish_time)

		if var_83_2 ~= "-1" then
			var_83_0.limit_time = L_MARKET_REFRESH.Rest_Time .. var_83_2
		end

		var_83_0.slidecost = {
			costtype = self.listData[arg_83_1].costIcon,
			costnum = math.floor(self.listData[arg_83_1].cost),
			shop_manager:getCurrencyNum(self.listData[arg_83_1].currency)
		}

		function var_83_0:ShopSliderCallback(arg_84_1)
			if arg_84_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.listData[arg_83_1].sell_time and time_check_manager:getCurTime() < global_get_time_by_date(self.listData[arg_83_1].sell_time) then
				global_ShowBlockWords(self.listData[arg_83_1].sell_time .. L_START_BUY)

				return
			end

			if var_83_0.marketType ~= "market_collection" and self.listData[arg_83_1].cost > shop_manager:getCurrencyNum(self.listData[arg_83_1].currency) then
				LayerManager:removePopLayer()
				shop_manager:popGoGain(arg_83_0.currency, function()
					self:updateTopInfo()
				end)
				self:setTouchEnabled(true)

				return
			end

			if shop_manager:isWeaponMax(self.selectedType, self.listData[arg_83_1].itemid, curbuyTime) then
				global_ShowBlockWords(L_WEAPON_SELECT_MAX_STAR)
				self:setTouchEnabled(true)

				return
			end

			local var_84_0 = self.nowNum or 1

			shop_manager:market_buy(self.shopList[self.marketType[self.selectedType]].id, self.listData[arg_83_1].pos, function(arg_86_0)
				if arg_86_0 == 1 then
					self:updateTopInfo()

					self.listData[arg_83_1].have_bought = self.listData[arg_83_1].have_bought + var_84_0
					self.listData[arg_83_1].sell_out = self.listData[arg_83_1].buy_limit and self.listData[arg_83_1].buy_limit <= self.listData[arg_83_1].have_bought

					self:updateShowingCells()

					if item_data[var_83_0.itemid].bag_item_type == kITEM_HERO then
						require("view.Layer.GetRoleAnimationLayer")
						cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_83_0.itemid), 1000)
					end
				elseif arg_86_0 == 2 then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_86_0 == 3 then
					shop_manager:popGoGain(self.listData[arg_83_1].currency, function()
						self:updateTopInfo()
					end)
				end
			end, var_84_0, function()
				LayerManager:removePopLayer()
			end)
		end

		if self.listData[arg_83_1].have_bought and self.listData[arg_83_1].buy_limit and not shop_manager:is_collection(self.selectedType) then
			var_83_0.limit_buy_num = self.listData[arg_83_1].buy_limit - self.listData[arg_83_1].have_bought
			var_83_0.have_bought_num = self.listData[arg_83_1].have_bought
		end

		self:showBuyPop(var_83_0)

		self.listData[arg_83_1].isnewitem = false

		self:updateButtonRed()
		self:updateShowingCells()
		AnalyticManager.clickMarketItem({
			shoptype = self.selectedType
		})
	end

	local function var_82_2(arg_89_0)
		local var_89_0 = var_82_0

		if arg_89_0.result == 1 then
			local function var_89_1(arg_90_0)
				if arg_90_0 == 1 then
					self:updateTopInfo()

					self.listData[var_89_0.index].have_bought = self.listData[var_89_0.index].have_bought + var_89_0.curbuyTime
					self.listData[var_89_0.index].sell_out = self.listData[var_89_0.index].buy_limit and self.listData[var_89_0.index].buy_limit <= self.listData[var_89_0.index].have_bought

					self:updateShowingCells()

					if self.selectedType == "1-9" then
						AnalyticManager.score_store_change({
							score_itemsid = self.listData[var_89_0.index].itemid
						})
					end

					if item_data[var_89_0.itemid].bag_item_type == kITEM_HERO then
						require("view.Layer.GetRoleAnimationLayer")
						cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_89_0.itemid), 1000)
					end
				elseif arg_90_0 == 2 then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_90_0 == 3 then
					shop_manager:popGoGain(self.listData[var_89_0.index].currency, function()
						self:updateTopInfo()
					end)
				end
			end

			if shop_manager:is_special_shopid(self.listData[var_82_0.index].shopid) then
				for iter_89_0 = 1, var_82_0.curbuyTime do
					shop_manager:push_back_shop_buy_stack(function(...)
						shop_manager:shop_buy(self.shopList[self.marketType[self.selectedType]].id, self.listData[var_89_0.index].shopid, var_89_1, 1, function()
							if shop_manager:is_shop_buy_stack_empty() then
								LayerManager:removePopLayer()
							end
						end)
					end)
				end

				if var_82_0.callback then
					var_82_0.callback()
				end

				self:playPumpkinSpine(function(...)
					shop_manager:pop_shop_buy_stack()()
				end)
			elseif arg_89_0.selectCoupon then
				shop_manager:shop_buy_with_ticket(self.shopList[self.marketType[self.selectedType]].id, self.listData[var_82_0.index].shopid, var_89_1, var_82_0.curbuyTime, function()
					if arg_89_0.closePop ~= false then
						LayerManager:removePopLayer()
					end

					if var_89_0.callback then
						var_89_0.callback()
					end
				end, arg_89_0.selectCoupon, 1)
			else
				shop_manager:shop_buy(self.shopList[self.marketType[self.selectedType]].id, self.listData[var_82_0.index].shopid, var_89_1, var_82_0.curbuyTime, function()
					if arg_89_0.closePop ~= false then
						LayerManager:removePopLayer()
					end

					if var_89_0.callback then
						var_89_0.callback()
					end
				end, nil, arg_89_0.selectCurrency)
			end
		end
	end

	local function var_82_3(arg_97_0, arg_97_1)
		local var_97_0 = {
			itemid = self.listData[arg_97_1].itemid,
			item_attr = self.listData[arg_97_1].item_attr,
			index = arg_97_1,
			_data = self.listData[arg_97_1],
			_shopList = self.shopList,
			_marketType = self.marketType,
			_selectedType = self.selectedType,
			shopid = self.listData[arg_97_1].shopid
		}

		if shop_manager:judgeNumber(self.listData[arg_97_1]) then
			var_97_0.costIcon = self.listData[arg_97_1].costIcon
			var_97_0.cost_old = self.listData[arg_97_1].cost_old
			var_97_0.currency = self.listData[arg_97_1].currency
		else
			var_97_0.costIcon = self.listData[arg_97_1].costIcon2
			var_97_0.cost_old = self.listData[arg_97_1].cost_old2
			var_97_0.currency = self.listData[arg_97_1].currency2
		end

		var_97_0.limitNum = shop_manager:getBuyLimit(self.listData[arg_97_1])

		local var_97_1 = self:getResidueTime(self.listData[arg_97_1].finish_time)

		if var_97_1 ~= "-1" then
			var_97_0.limit_time = L_MARKET_REFRESH.Rest_Time .. var_97_1
		end

		var_97_0.slidecost = {}
		var_97_0.uncolor_clothes = self.listData[arg_97_1].uncolor_clothes

		if shop_manager:judgeNumber(self.listData[arg_97_1]) then
			var_97_0.slidecost.costtype = self.listData[arg_97_1].costIcon
			var_97_0.slidecost.costnum = self.listData[arg_97_1].discount or self.listData[arg_97_1].cost
			var_97_0.slidecost.nowHave = shop_manager:getCurrencyNum(self.listData[arg_97_1].currency)
		else
			var_97_0.slidecost.costtype = self.listData[arg_97_1].costIcon2
			var_97_0.slidecost.costnum = self.listData[arg_97_1].discount2 or self.listData[arg_97_1].cost2
			var_97_0.slidecost.nowHave = shop_manager:getCurrencyNum(self.listData[arg_97_1].currency2)
		end

		function var_97_0:ShopSliderCallback(arg_98_1, arg_98_2, arg_98_3, arg_98_4)
			if arg_98_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.listData[arg_97_1].activity_level then
				global_ShowBlockWords(L_MARKET_MSG.LEVEL_BUZU)
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end

			if self.listData[arg_97_1].have_bought >= self.listData[arg_97_1].buy_limit then
				global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end

			if self.listData[arg_97_1].sell_time and time_check_manager:getCurTime() < global_get_time_by_date(self.listData[arg_97_1].sell_time) then
				global_ShowBlockWords(self.listData[arg_97_1].sell_time .. L_START_BUY)

				return
			end

			local var_98_0 = self.nowNum or 1

			var_82_0 = {
				curbuyTime = var_98_0,
				index = arg_97_1,
				itemid = var_97_0.itemid,
				callback = arg_98_2
			}

			if shop_manager:judgeNumber(self.listData[arg_97_1]) then
				if arg_98_3 then
					if self.listData[arg_97_1].cost > shop_manager:getCurrencyNum(self.listData[arg_97_1].currency) + discount_manager:getCouponsDiscount(arg_98_3) then
						LayerManager:removePopLayer()
						shop_manager:popGoGain(arg_97_0.currency, function()
							self:updateTopInfo()
						end)

						return
					end
				elseif self.listData[arg_97_1].cost * var_98_0 > shop_manager:getCurrencyNum(self.listData[arg_97_1].currency) then
					LayerManager:removePopLayer()
					shop_manager:popGoGain(arg_97_0.currency, function()
						self:updateTopInfo()
					end)

					return
				end
			end

			if shop_manager:isWeaponMax(self.selectedType, var_82_0.itemid, var_82_0.curbuyTime) then
				global_ShowBlockWords(L_WEAPON_SELECT_MAX_STAR)
				self:setTouchEnabled(true)

				return
			end

			var_82_2({
				result = 1,
				selectCoupon = arg_98_3,
				closePop = self.closePop,
				selectCurrency = arg_98_4
			})
		end

		var_97_0.hideGainButton = true

		if self.listData[arg_97_1].have_bought and self.listData[arg_97_1].buy_limit and not shop_manager:is_collection(self.selectedType) then
			var_97_0.limit_buy_num = self.listData[arg_97_1].buy_limit - self.listData[arg_97_1].have_bought
			var_97_0.have_bought_num = self.listData[arg_97_1].have_bought
		end

		self:showBuyPop(var_97_0)

		self.listData[arg_97_1].isnewitem = false

		self:updateButtonRed()
		self:updateShowingCells()
		AnalyticManager.clickShopItem({
			shoptype = self.selectedType
		})
	end

	local function var_82_4(arg_101_0, arg_101_1)
		if self.listData[arg_101_1].currency == SHOP_CURRENCY_RMB then
			-- block empty
		else
			var_82_3(arg_101_0, arg_101_1)
		end
	end

	local var_82_5 = {}

	for iter_82_0, iter_82_1 in pairs(self.shopList) do
		if tonumber(split(iter_82_1.type, "-")[1]) == 1 then
			var_82_5[iter_82_1.type] = var_82_4
		elseif tonumber(split(iter_82_1.type, "-")[1]) == 2 then
			var_82_5[iter_82_1.type] = var_82_1
		end
	end

	local function var_82_6(...)
		local var_102_0 = self:getListDataIndex()

		if var_102_0 then
			if tonumber(split(self.selectedType, "-")[1]) == 1 then
				var_82_4(self.listData[var_102_0], var_102_0)
			else
				var_82_1(self.listData[var_102_0], var_102_0)
			end

			self.itemid = nil
		end
	end

	local function var_82_7(arg_103_0)
		self:sortMarketlist(arg_103_0)

		self.listData = {}
		self.costTypeTable = {}
		self.purchaseid_to_index = {}

		local var_103_0 = {}
		local var_103_1 = false

		for iter_103_0, iter_103_1 in pairs(arg_103_0) do
			iter_103_1.price = iter_103_1.price or -1

			local var_103_2 = #self.listData + 1

			self.listData[#self.listData + 1] = {}
			iter_103_1.currency = iter_103_1.currency or 0
			iter_103_1.discount = iter_103_1.discount or 10

			if not var_103_0[iter_103_1.currency] then
				table.insert(self.costTypeTable, iter_103_1.currency)

				var_103_0[iter_103_1.currency] = iter_103_1.currency
			end

			if iter_103_1.currency2 and not var_103_0[iter_103_1.currency2] then
				table.insert(self.costTypeTable, iter_103_1.currency2)

				var_103_0[iter_103_1.currency2] = iter_103_1.currency2
			end

			if iter_103_1.item_number ~= 1 then
				if item_data[iter_103_1.itemtype].item_market_name then
					self.listData[var_103_2].name = item_data[iter_103_1.itemtype].item_market_name .. " X" .. iter_103_1.item_number or item_data[iter_103_1.itemtype].name .. " X" .. iter_103_1.item_number
				end
			elseif not item_data[iter_103_1.itemtype].item_market_name then
				self.listData[var_103_2].name = item_data[iter_103_1.itemtype].name
			end

			self.listData[var_103_2].itemid = iter_103_1.itemtype
			self.listData[var_103_2].shopid = iter_103_1.shopid
			self.listData[var_103_2].costIcon = shop_manager:getCurrencyIcon(iter_103_1.currency)
			self.listData[var_103_2].currency = iter_103_1.currency

			if iter_103_1.currency2 then
				self.listData[var_103_2].costIcon2 = shop_manager:getCurrencyIcon(iter_103_1.currency2)
				self.listData[var_103_2].currency2 = iter_103_1.currency2
				self.listData[var_103_2].discount2 = iter_103_1.discount2
				self.listData[var_103_2].cost_old2 = iter_103_1.price2
			end

			self.listData[var_103_2].isnewitem = iter_103_1.isnewitem
			self.listData[var_103_2].discountfinish = iter_103_1.discountfinish
			self.listData[var_103_2].canUse = self:isCanUseItem(iter_103_1.itemtype)
			self.listData[var_103_2].canShowHaveServant = self:isShowHaveServant(iter_103_1.itemtype)

			if tonumber(split(self.selectedType, "-")[1]) == 1 then
				self.listData[var_103_2].cost = iter_103_1.discount or iter_103_1.price

				if iter_103_1.currency2 then
					self.listData[var_103_2].cost2 = iter_103_1.discount2 or iter_103_1.price2
				end
			else
				self.listData[var_103_2].cost = iter_103_1.price * 0.1 * iter_103_1.discount * iter_103_1.item_number

				if iter_103_1.currency2 then
					self.listData[var_103_2].cost2 = iter_103_1.price2 * 0.1 * iter_103_1.discount2 * iter_103_1.item_number
				end
			end

			self.listData[var_103_2].uncolor_clothes = iter_103_1.uncolor_clothes
			self.listData[var_103_2].is_lock_activitycity = iter_103_1.is_lock_activitycity
			self.listData[var_103_2].lock_activitycity = iter_103_1.lock_activitycity
			self.listData[var_103_2].quality = item_data[iter_103_1.itemtype].equip_quality or 1
			self.listData[var_103_2].cost_old = iter_103_1.price
			self.listData[var_103_2].bag_item_type = item_data[iter_103_1.itemtype].bag_item_type
			self.listData[var_103_2].item_attr = iter_103_1.item_attr
			self.listData[var_103_2].finish_time = iter_103_1.finish_time
			self.listData[var_103_2].sell_time = iter_103_1.sell_time
			self.listData[var_103_2].activity_level = iter_103_1.activity_level
			self.listData[var_103_2].family_shop_limit = iter_103_1.family_shop_limit

			if iter_103_1.item_attr and (item_data[iter_103_1.itemtype].bag_item_type == kITEM_WEAPON or item_data[iter_103_1.itemtype].bag_item_type == kITEM_COMPONENT) then
				-- block empty
			else
				self.listData[var_103_2].icon = item_data[iter_103_1.itemtype].bag_item_type == kITEM_SCULTURE and "roleimage/role/wuji/" .. item_data[iter_103_1.itemtype].image_id .. ".png" or item_data[iter_103_1.itemtype].bag_item_type == kITEM_COMPONENT and string.format("equipment/component/%d-%d-%d.png", component_effect_data[item_data[iter_103_1.itemtype].effect1].image_id, item_data[iter_103_1.itemtype].pos, item_data[iter_103_1.itemtype].main_attr) or item_data[iter_103_1.itemtype].bag_item_type == kITEM_SKIN and var_0_50[var_0_40[self.selectedType]] .. item_data[iter_103_1.itemtype].model .. var_0_51[var_0_40[self.selectedType]] or var_0_50[var_0_40[self.selectedType]] .. item_data[iter_103_1.itemtype].image_id .. var_0_51[var_0_40[self.selectedType]]
			end

			self.listData[var_103_2].discount = iter_103_1.discount
			self.listData[var_103_2].buy_limit = iter_103_1.buy_limit or 1000000
			self.listData[var_103_2].have_bought = iter_103_1.have_bought or 0
			self.listData[var_103_2].sell_out = iter_103_1.buy_limit and iter_103_1.buy_limit <= iter_103_1.have_bought
			self.listData[var_103_2].tag = iter_103_1.tag or 0
			self.listData[var_103_2].pos = iter_103_1.pos
			self.listData[var_103_2].currency = iter_103_1.currency
			self.listData[var_103_2].touchCallBack = function(arg_104_0, arg_104_1)
				arg_104_0.own = shop_manager:getCurrencyNum(iter_103_1.currency)
				arg_104_0.currency = iter_103_1.currency

				var_82_5[self.selectedType](arg_104_0, var_103_2)
			end
			self.listData[var_103_2].purchaseid = iter_103_1.productid

			if shop_data[iter_103_1.shopid] and shop_data[iter_103_1.shopid].item_extra_param then
				local var_103_5, var_103_6 = string.match(shop_data[iter_103_1.shopid].item_extra_param, "(%w+)=(%d+)")

				self.listData[var_103_2].extraType = tostring(var_103_5)
				self.listData[var_103_2].extraValue = tonumber(var_103_6)
			end

			if iter_103_1.productid then
				self.purchaseid_to_index[iter_103_1.productid] = var_103_2
			end

			if shop_data[iter_103_1.shopid] then
				local var_103_7 = shop_data[iter_103_1.shopid].unique_item or nil

				if var_103_7 then
					local var_103_8 = skin_data[var_103_7] or item_data[var_103_7]

					if var_103_8 and var_103_8.major and major_factor_data[var_103_8.major] and major_factor_data[var_103_8.major].fight_model1 then
						self.listData[var_103_2].haveSuit = playermodel.haveSuit[var_103_8.major]

						if var_103_8.model then
							self.listData[var_103_2].small_skin_img = "roleimage/role/shop_image/" .. var_103_8.model .. ".png"
						end

						var_103_1 = true

						local var_103_9 = {}

						for iter_103_2, iter_103_3 in ipairs(SHOP_SKIN_ATTR_ID) do
							if model_data[major_factor_data[var_103_8.major].fight_model1][iter_103_3] then
								table.insert(var_103_9, iter_103_3)
							end
						end

						if #var_103_9 == 0 then
							table.insert(var_103_9, "other")
						end

						self.listData[var_103_2].fliterAttrs = var_103_9
					end
				end
			end
		end

		self.can_filter = var_103_1

		table.sort(self.costTypeTable, function(arg_105_0, arg_105_1)
			if arg_105_0 and arg_105_1 then
				return arg_105_1 < arg_105_0
			else
				return true
			end
		end)
		self:updateTopInfo()
		self:updateTableView()
		self:updateButtonRed()

		self.rpcCallbackFalg = true

		self:updateFilterIcon()
	end

	local function var_82_8()
		shop_manager:get_market_data(self.shopList[self.marketType[self.selectedType]].id, function(arg_107_0)
			var_82_7(arg_107_0)
			var_82_6()
		end)
	end

	local function var_82_9()
		shop_manager:get_shop_data(self.shopList[self.marketType[self.selectedType]].id, function(arg_109_0)
			var_82_7(arg_109_0)
			var_82_6()
		end)
	end

	local var_82_10 = {}

	for iter_82_2, iter_82_3 in pairs(self.shopList) do
		if tonumber(split(iter_82_3.type, "-")[1]) == 1 then
			var_82_10[iter_82_3.type] = var_82_9
		elseif tonumber(split(iter_82_3.type, "-")[1]) == 2 then
			var_82_10[iter_82_3.type] = var_82_8
		end
	end

	print(self.selectedType)

	if var_82_10[self.selectedType] then
		var_82_10[self.selectedType]()
	end
end

function MarketLayer.isCanUseItem(arg_110_0, arg_110_1)
	if item_data[arg_110_1].bag_item_type == kITEM_WEAPON then
		return playermodel.haveServant[item_data[arg_110_1].servant]
	end

	return true
end

function MarketLayer.isShowHaveServant(arg_111_0, arg_111_1)
	local var_111_0 = false
	local var_111_1 = {}

	if item_data[arg_111_1] and item_data[arg_111_1].bag_item_type == kITEM_WEAPON then
		table.insert(var_111_1, item_data[arg_111_1].servant)
	elseif item_data[arg_111_1] and item_data[arg_111_1].bag_item_type == kITEM_GIFT_FOR_FRIEND then
		for iter_111_0, iter_111_1 in pairs(servant_data) do
			if iter_111_1.major == item_data[arg_111_1].exclusive then
				table.insert(var_111_1, iter_111_1.id)
			end
		end
	elseif item_data[arg_111_1] and item_data[arg_111_1].bag_item_type == kITEM_FURNITURE_GIFT and furnituresuit_data[item_data[arg_111_1].suit_id] then
		for iter_111_2, iter_111_3 in pairs(servant_data) do
			if iter_111_3.major == furnituresuit_data[item_data[arg_111_1].suit_id].servantid then
				table.insert(var_111_1, iter_111_3.id)
			end
		end
	end

	for iter_111_4, iter_111_5 in pairs(var_111_1) do
		if playermodel.haveServant[iter_111_5] then
			var_111_0 = true

			break
		end
	end

	return var_111_0
end

function MarketLayer:showBuyPop(arg_112_1)
	local var_112_1 = discount_manager:getCanUseCoupin(arg_112_1.itemid, arg_112_1.currency, arg_112_1.costnum or arg_112_1.slidecost.costnum, self.selectedType)

	if var_112_1 and next(var_112_1) then
		self:showBachelorBuyPop(arg_112_1, var_112_1)

		return
	end

	local var_112_2 = {
		[kITEM_FURNITURE_GIFT] = function()
			self:showFurniturePopNew(arg_112_1)
		end,
		[kITEM_SKIN_GIFT] = function()
			self:showSoulGirlPop(arg_112_1, kITEM_SKIN_GIFT)
		end,
		[kITEM_SKIN] = function()
			self:showSoulGirlPop(arg_112_1, kITEM_SKIN)
		end,
		[KITEM_MARK_GIFT] = function()
			self:buyGift(arg_112_1)
		end,
		[KITEM_MARK_GIFT_SLIDER] = function()
			LayerManager:pushInLayer("PopOpenBagInfoLayer", arg_112_1)
		end,
		[KITEM_EMOTION_CHAT_GIFT] = function()
			LayerManager:pushInLayer("PopBuyChatEmotationGiftLayer", arg_112_1)
		end
	}

	if var_112_2[item_data[arg_112_1.itemid].bag_item_type] then
		var_112_2[item_data[arg_112_1.itemid].bag_item_type]()
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_112_1)
	end
end

function MarketLayer.showBachelorBuyPop(arg_119_0, arg_119_1, arg_119_2)
	local var_119_0 = {
		[kITEM_FURNITURE_GIFT] = function()
			arg_119_1.couponList = arg_119_2

			arg_119_0:showBachelorFurniturePop(arg_119_1)
		end,
		[KITEM_MARK_GIFT] = function()
			arg_119_1.couponList = arg_119_2

			arg_119_0:buyBachelorGift(arg_119_1)
		end,
		[kITEM_SKIN_GIFT] = function()
			arg_119_1.couponList = arg_119_2

			arg_119_0:showSoulGirlPop(arg_119_1, kITEM_SKIN_GIFT)
		end,
		[kITEM_SKIN] = function()
			arg_119_1.couponList = arg_119_2

			arg_119_0:showSoulGirlPop(arg_119_1, kITEM_SKIN)
		end
	}

	if var_119_0[item_data[arg_119_1.itemid].bag_item_type] then
		var_119_0[item_data[arg_119_1.itemid].bag_item_type]()
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_119_1)
	end
end

function MarketLayer:updateTopInfo()
	self.costList:removeAllChildren()

	self.costList.nodeCount = 0

	function self.costList:pushBack(arg_125_1)
		arg_125_1:setAnchorPoint(cc.p(0.5, 0.5))
		arg_125_1:setPositionX(self:getContentSize().width - (self.nodeCount + 0.5) * arg_125_1:getContentSize().width - 10 * (self.nodeCount + 1))
		arg_125_1:setPositionY(self:getContentSize().height / 2)
		self:addChild(arg_125_1)

		self.nodeCount = self.nodeCount + 1
	end

	for iter_124_0, iter_124_1 in pairs(self.costTypeTable) do
		if iter_124_1 ~= SHOP_CURRENCY_RMB then
			local var_124_0 = self.coin:clone()

			local function var_124_1()
				var_124_0:getChildByName("coin_label"):setString(global_trans_number(shop_manager:getCurrencyNum(iter_124_1)))
			end

			if var_0_49[iter_124_1]:find("equipment") then
				var_124_0:getChildByName("coin"):loadTexture(var_0_49[iter_124_1])

				if iter_124_1 == SHOP_CURRENCY_GOLD then
					var_124_0:getChildByName("coin"):setScale(0.8)
				elseif iter_124_1 == SHOP_CURRENCY_HORNOR then
					var_124_0:getChildByName("coin"):setScale(0.7)
				elseif iter_124_1 == SHOP_CURRENCY_DIAMOND then
					-- block empty
				elseif iter_124_1 == SHOP_CURRENCY_EXPLORECOIN then
					-- block empty
				elseif iter_124_1 == GIFT_TICKET then
					-- block empty
				elseif iter_124_1 == 85000006 then
					var_124_0:getChildByName("coin"):setScale(0.4)
				else
					var_124_0:getChildByName("coin"):setScale(1)
				end
			else
				var_124_0:getChildByName("coin"):loadTexture(var_0_49[iter_124_1], var_0_24)

				if iter_124_1 == SHOP_CURRENCY_GOLD then
					var_124_0:getChildByName("coin"):setScale(0.8)
				elseif iter_124_1 == SHOP_CURRENCY_HORNOR then
					var_124_0:getChildByName("coin"):setScale(0.7)
				elseif iter_124_1 == SHOP_CURRENCY_DIAMOND then
					-- block empty
				elseif iter_124_1 == SHOP_CURRENCY_EXPLORECOIN then
					-- block empty
				elseif iter_124_1 == GIFT_TICKET then
					-- block empty
				elseif iter_124_1 == 85000006 then
					var_124_0:getChildByName("coin"):setScale(0.4)
				else
					var_124_0:getChildByName("coin"):setScale(1)
				end
			end

			if iter_124_1 == SHOP_CURRENCY_GOLD then
				-- block empty
			elseif iter_124_1 == SHOP_CURRENCY_HORNOR then
				-- block empty
			elseif iter_124_1 == SHOP_CURRENCY_DIAMOND then
				if self.selectedType == "1-10404" then
					var_124_0:setVisible(false)
				else
					var_124_0:setVisible(true)
				end

				var_124_0:setTouchEnabled(true)
				var_124_0:addTouchEventListener(function(arg_127_0, arg_127_1)
					if arg_127_1 ~= ccui.TouchEventType.ended then
						return
					end

					LayerManager:pushInLayer("PopSupermarketLayer", {
						tab = 1,
						callback = var_124_1
					})
				end)
			elseif iter_124_1 == SHOP_CURRENCY_EXPLORECOIN then
				-- block empty
			elseif iter_124_1 == GIFT_TICKET then
				var_124_0:setTouchEnabled(true)
				var_124_0:addTouchEventListener(function(arg_128_0, arg_128_1)
					if arg_128_1 ~= ccui.TouchEventType.ended then
						return
					end

					LayerManager:pushInLayer("PopSupermarketLayer", {
						tab = 2,
						callback = var_124_1
					})
				end)
			else
				var_124_0:setTouchEnabled(true)
				var_124_0:addTouchEventListener(function(arg_129_0, arg_129_1)
					if arg_129_1 ~= ccui.TouchEventType.ended then
						return
					end

					LayerManager:pushInLayer("PopItemLayer", {
						itemid = iter_124_1
					})
				end)
			end

			var_124_0:getChildByName("coin_label"):setString(global_trans_number(shop_manager:getCurrencyNum(iter_124_1)))
			self.costList:pushBack(var_124_0)
		end
	end

	if not self.title_mark then
		self.title_mark = ccui.ImageView:create("MarketLayer/exclamation_mark.png", var_0_24)

		self.title_mark:setTouchEnabled(true)
		self.titleSprite:addChild(self.title_mark)
		self.title_mark:addTouchEventListener(function(arg_130_0, arg_130_1)
			if arg_130_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopActivityDetail", {
				key = var_0_44[self.selectedType].detailsid
			})
		end)
	end

	if var_0_44[self.selectedType] then
		self.title_mark:setVisible(true)
		self.title_mark:setPositionX(var_0_44[self.selectedType].x or 0)
		self.title_mark:setPositionY(var_0_44[self.selectedType].y or 0)
	else
		self.title_mark:setVisible(false)
	end
end

local var_0_65 = 0

function MarketLayer:updateTableView()
	self.node_number = var_0_40[self.selectedType] == 6 and 4 or var_0_40[self.selectedType] == 1 and 3 or 1

	self:updateCurTableView()

	self.tableViewList[var_0_40[self.selectedType]].type = self.selectedType
	self.tableViewList[var_0_40[self.selectedType]].isRunAnim = true
	var_0_65 = 0
	self.tableViewList[var_0_40[self.selectedType]].node_number = self.node_number
	self.tableViewList[var_0_40[self.selectedType]].listData = self:filter_skin(self.listData, var_0_59)

	self.tableViewList[var_0_40[self.selectedType]]:reloadData()

	if (not self.showinfo or not next(self.showinfo)) and var_0_2 then
		self.tableViewList[var_0_40[self.selectedType]]:setContentOffset(var_0_2)

		var_0_2 = nil
	end

	local var_131_0 = var_0_40[self.selectedType]

	for iter_131_0, iter_131_1 in pairs(self.tableViewList) do
		iter_131_1:setVisible(iter_131_0 == var_131_0)
	end
end

function MarketLayer:updateCurTableView()
	if self.can_filter then
		if self.tableViewList[var_0_40[self.selectedType]] then
			self.tableViewList[var_0_40[self.selectedType]]:removeFromParent()
		end

		if not var_0_60 or var_0_60 == var_0_54 then
			self.tableViewList[var_0_40[self.selectedType]] = self:createTableView()
		else
			self.node_number = 3
			self.tableViewList[var_0_40[self.selectedType]] = self:createTableViewSmall()
		end

		self.tableViewList[var_0_40[self.selectedType]].skin_show_model = var_0_60
	else
		if self.tableViewList[var_0_40[self.selectedType]] and (self.selectedType == "1-27010" or self.tableViewList[var_0_40[self.selectedType]].can_filter) then
			self.tableViewList[var_0_40[self.selectedType]]:removeFromParent()

			self.tableViewList[var_0_40[self.selectedType]] = nil
		end

		self.tableViewList[var_0_40[self.selectedType]] = self.tableViewList[var_0_40[self.selectedType]] or self:createTableView()
	end
end

local var_0_66 = 0
local var_0_68 = cc.size(630, 1015 + GameDisplay.fix_y * 2 - GameDisplay.notch_height)

function MarketLayer:createTableView()
	hx_print("大图tableview")

	local var_133_0 = cc.TableView:create(var_0_68)

	var_133_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_133_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_133_0:setAnchorPoint(cc.p(0, 0))

	if self.node_number == 3 then
		var_133_0:setPosition(60 - 10, 61 - GameDisplay.fix_y)
	else
		var_133_0:setPosition(60, 61 - GameDisplay.fix_y)
	end

	var_133_0:setDelegate()
	self.rootlayer:addChild(var_133_0)

	var_133_0.type = self.selectedType
	var_133_0.node_number = self.node_number
	var_133_0.listData = self:filter_skin(self.listData, var_0_59)

	local var_133_1 = var_133_0.node_number == 4 and 62 or 90

	var_133_0.can_filter = self.can_filter

	var_133_0:registerScriptHandler(function(arg_135_0, arg_135_1)
		if arg_135_1 == self:getListLen(var_133_0) - 1 then
			return var_0_46[var_133_0.type].width, var_0_46[var_133_0.type].height + 60
		else
			return var_0_46[var_133_0.type].width, var_0_46[var_133_0.type].height
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_133_0:registerScriptHandler(function(arg_134_0, arg_134_1)
		local var_134_0 = arg_134_0:dequeueCell()
		local var_134_1 = 0

		if arg_134_1 == self:getListLen(var_133_0) - 1 then
			var_134_1 = var_0_46[var_133_0.type].height + 60
			var_0_66 = var_0_46[var_133_0.type].width
		else
			var_134_1 = var_0_46[var_133_0.type].height
			var_0_66 = var_0_46[var_133_0.type].width
		end

		if var_134_0 then
			var_0_65 = var_0_65 + 1

			for iter_134_0 = 1, var_133_0.node_number do
				local var_134_3 = var_134_0:getChildByName(iter_134_0)

				var_134_3:setPosition(cc.p(var_133_1 + iter_134_0 * var_0_46[var_133_0.type].offsetx + (iter_134_0 - 1) * var_134_3:getContentSize().width, var_0_46[var_133_0.type].height / 2 + var_0_46[var_133_0.type].offsety + ((arg_134_1 == self:getListLen(var_133_0) - 1 or nil) and 60)))

				var_134_3.type = var_133_0.type

				if var_133_0.listData[var_133_0.node_number * arg_134_1 + iter_134_0] then
					var_134_3:setVisible(true)
					var_134_3:update(arg_134_0.listData[var_133_0.node_number * arg_134_1 + iter_134_0])
				else
					var_134_3:setVisible(false)
				end

				if not self.startRunOutAni and var_133_0.isRunAnim and var_133_0.node_number == 1 and var_133_0.node_number * (arg_134_1 + iter_134_0) <= 4 then
					var_134_0:getChildByName(iter_134_0):setOpacity(0)
					var_134_0:getChildByName(iter_134_0):runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_134_1), cc.FadeIn:create(0.1)))
				elseif not self.startRunOutAni and var_133_0.isRunAnim and var_133_0.node_number == 3 and var_133_0.node_number * arg_134_1 + iter_134_0 <= 15 then
					var_134_0:getChildByName(iter_134_0):setOpacity(0)
					var_134_0:getChildByName(iter_134_0):runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_134_1), cc.FadeIn:create(0.1)))
				elseif var_134_0:getChildByName(iter_134_0):getOpacity() < 255 then
					var_134_0:getChildByName(iter_134_0):setOpacity(255)
				end
			end

			if math.ceil(var_0_68.height / var_134_1) <= var_0_65 then
				var_133_0.isRunAnim = false
				var_0_65 = 0
			end
		else
			var_134_0 = cc.TableViewCell:create()

			for iter_134_1 = 1, var_133_0.node_number do
				local var_134_5 = ShopSprite:createWithName("shopSpriteType" .. var_0_40[var_133_0.type])
				local var_134_6 = math.ceil(var_0_68.height / var_134_1)

				var_134_5:setPosition(cc.p(var_133_1 + iter_134_1 * var_0_46[var_133_0.type].offsetx + (iter_134_1 - 1) * var_134_5:getContentSize().width, var_0_46[var_133_0.type].height / 2 + var_0_46[var_133_0.type].offsety + ((arg_134_1 == self:getListLen(var_133_0) - 1 or nil) and 60)))

				if arg_134_1 < var_134_6 then
					var_134_5:setOpacity(0)
					var_134_5:runAction(cc.Sequence:create(cc.DelayTime:create((arg_134_1 + 1) * (LAYER_INTO_TIME / var_134_6)), cc.FadeIn:create(LAYER_INTO_TIME / var_134_6)))
				else
					var_134_5:setOpacity(255)
				end

				var_134_5.type = var_133_0.type

				var_134_5:setName(iter_134_1)
				var_134_0:addChild(var_134_5)

				if var_133_0.listData[var_133_0.node_number * arg_134_1 + iter_134_1] then
					var_134_5:setVisible(true)
					var_134_5:update(arg_134_0.listData[var_133_0.node_number * arg_134_1 + iter_134_1])
				else
					var_134_5:setVisible(false)
				end
			end
		end

		if self.startRunOutAni then
			self.startIndex = self.startIndex or arg_134_1

			local var_134_7 = LAYER_OUT_TIME / math.ceil(var_0_68.height / var_134_1)

			for iter_134_2 = 1, var_133_0.node_number do
				var_134_0:getChildByName(iter_134_2):runAction(cc.Sequence:create(cc.DelayTime:create((arg_134_1 - self.startIndex + 1) * var_134_7), cc.FadeOut:create(var_134_7)))
			end
		end

		return var_134_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_133_0:registerScriptHandler(function(arg_136_0, arg_136_1)
		return (self:getListLen(var_133_0))
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)

	return var_133_0
end

function MarketLayer:layerOutAni(arg_137_1)
	self.startRunOutAni = true

	self:updateShowingCells()
	self.rootlayer:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME), cc.CallFunc:create(arg_137_1)))
end

function MarketLayer:updateButtonList()
	for iter_138_0, iter_138_1 in pairs(self.buttonList) do
		iter_138_1.selected = self.selectedType == iter_138_1.button:getName()

		local var_138_1 = var_0_39(iter_138_1.button:getName())

		if var_138_1 == "1_23" then
			var_138_1 = "1_15"
		end

		if iter_138_1.selected then
			iter_138_1.button:loadTextures("mainScenebg/market_type/" .. var_138_1 .. "_on.png", "mainScenebg/market_type/" .. var_138_1 .. "_on.png")
		else
			iter_138_1.button:loadTextures("mainScenebg/market_type/" .. var_138_1 .. "_normal.png", "mainScenebg/market_type/" .. var_138_1 .. "_normal.png")
		end
	end
end

function MarketLayer:updateButtonRed()
	for iter_139_0, iter_139_1 in pairs(self.buttonList) do
		if self.selectedType == iter_139_1.button:getName() then
			iter_139_1.button:getChildByName("redDot"):setVisible(false)

			for iter_139_2, iter_139_3 in pairs(self.listData) do
				if iter_139_3.isnewitem then
					iter_139_1.button:getChildByName("redDot"):setVisible(true)

					break
				end
			end

			if self.btnTables then
				self.btnTables[var_0_42[self.selectedType]]:getChildByName("redDot"):setVisible(self:judgeRedDot(var_0_42[self.selectedType]))
			end
		end
	end
end

function MarketLayer:refreshTime()
	self:updateBtnSkinDiscount()
	self.refreshBtn:setVisible(self.refreshmanual[self.selectedType] > 0)

	if self.autoRefreshType[self.selectedType] == var_0_45.NEVER or self.autoRefreshType[self.selectedType] == var_0_45.MANUAL or self.autoRefreshType[self.selectedType] == var_0_45.EVERY_MONTH then
		self.refresh_bg:setVisible(false)
		self:updateBtnBuyOnekey()

		return
	else
		self.refresh_bg:setVisible(true)

		if self.refreshmanual[self.selectedType] > 0 then
			self.refresh_bg:setPositionX(460)
		else
			self.refresh_bg:setPositionX(522)
		end
	end

	local function var_140_0(arg_141_0)
		local var_141_0 = {}

		;({
			[var_0_45.EVERY_DAY] = function()
				if #arg_141_0 == 1 then
					table.insert(var_141_0, {
						str = L_MARKET_REFRESH_TIME.Time_Label_Day,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_141_0, {
						str = string.format("%02d:00", tonumber(arg_141_0[1])),
						color = cc.c3b(0, 255, 186)
					})
					table.insert(var_141_0, {
						str = L_MARKET_REFRESH_TIME.Refresh,
						color = cc.c3b(242, 242, 242)
					})
				else
					local var_142_0
					local var_142_1 = tonumber(os.date("%H"))

					for iter_142_0 = 1, #arg_141_0 do
						if var_142_1 < tonumber(arg_141_0[iter_142_0]) then
							var_142_0 = tonumber(arg_141_0[iter_142_0])

							break
						end
					end

					var_142_0 = var_142_0 or arg_141_0[1]

					local var_142_2 = string.format("%02d:00", tonumber(var_142_0))

					table.insert(var_141_0, {
						str = L_MARKET_REFRESH_TIME.Next_Time,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_141_0, {
						str = var_142_2,
						color = cc.c3b(0, 255, 186)
					})
				end
			end,
			[var_0_45.EVERY_WEEK] = function()
				if #arg_141_0 == 1 then
					table.insert(var_141_0, {
						str = L_MARKET_REFRESH_TIME.Time_Label_Week,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_141_0, {
						str = L_WEEK_TEXT[tonumber(arg_141_0[1])],
						color = cc.c3b(0, 255, 186)
					})
					table.insert(var_141_0, {
						str = L_MARKET_REFRESH_TIME.Refresh,
						color = cc.c3b(242, 242, 242)
					})
				else
					local var_143_0
					local var_143_1 = tonumber(os.date("%w"))

					for iter_143_0 = 1, #arg_141_0 do
						if var_143_1 < tonumber(arg_141_0[iter_143_0]) then
							var_143_0 = tonumber(arg_141_0[iter_143_0])

							break
						end
					end

					var_143_0 = var_143_0 or arg_141_0[1]

					table.insert(var_141_0, {
						str = L_MARKET_REFRESH_TIME.Next_Time,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_141_0, {
						str = L_WEEK_TEXT[tonumber(var_143_0)],
						color = cc.c3b(0, 255, 186)
					})
				end
			end,
			[var_0_45.EVERY_MONTH] = function()
				if #arg_141_0 == 1 then
					table.insert(var_141_0, {
						str = L_MARKET_REFRESH_TIME.Time_Label_Month,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_141_0, {
						str = string.format("%d", tonumber(arg_141_0[1])),
						color = cc.c3b(0, 255, 186)
					})
					table.insert(var_141_0, {
						str = L_MARKET_REFRESH_TIME.Day .. L_MARKET_REFRESH_TIME.Refresh,
						color = cc.c3b(242, 242, 242)
					})
				else
					local var_144_0
					local var_144_1 = tonumber(os.date("%m"))

					for iter_144_0 = 1, #arg_141_0 do
						if var_144_1 < tonumber(arg_141_0[iter_144_0]) then
							var_144_0 = tonumber(arg_141_0[iter_144_0])

							break
						end
					end

					var_144_0 = var_144_0 or arg_141_0[1]

					table.insert(var_141_0, {
						str = L_MARKET_REFRESH_TIME.Next_Time,
						color = cc.c3b(242, 242, 242)
					})
					table.insert(var_141_0, {
						str = string.format("%02d", tonumber(var_144_0)),
						color = cc.c3b(0, 255, 186)
					})
					table.insert(var_141_0, {
						str = L_MARKET_REFRESH_TIME.Day,
						color = cc.c3b(242, 242, 242)
					})
				end
			end
		})[self.autoRefreshType[self.selectedType]]()

		if not next(var_141_0) then
			var_141_0 = {
				{
					str = L_MARKET_REFRESH_TIME.No_Refresh,
					color = cc.c3b(242, 242, 242)
				}
			}
		end

		return var_141_0
	end

	local var_140_1 = (function()
		local var_145_0 = {}

		for iter_145_0 in (self.nextRefreshTime[self.selectedType] or ""):gmatch("(%d+)") do
			table.insert(var_145_0, iter_145_0)
		end

		return (var_140_0(var_145_0))
	end)()

	if self.selectedType == "1-13801" then
		var_140_1[1].str = "温馨、灿烂礼包每日"

		self.refresh_bg:setPositionX(410)
	end

	local var_140_2 = 3
	local var_140_3 = 0

	while var_140_2 >= 1 do
		if var_140_1[var_140_2] then
			self.refresh_bg:getChildByName("time_label" .. var_140_2):setAnchorPoint(cc.p(0, 0.5))
			self.refresh_bg:getChildByName("time_label" .. var_140_2):setVisible(true)
			self.refresh_bg:getChildByName("time_label" .. var_140_2):setString(var_140_1[var_140_2].str)
			self.refresh_bg:getChildByName("time_label" .. var_140_2):setColor(var_140_1[var_140_2].color)

			var_140_3 = var_140_3 + self.refresh_bg:getChildByName("time_label" .. var_140_2):getContentSize().width

			if var_140_2 == 1 then
				self.refresh_bg:setContentSize(cc.size(var_140_3 + 10, 40))
			end
		else
			self.refresh_bg:getChildByName("time_label" .. var_140_2):setVisible(false)
		end

		var_140_2 = var_140_2 - 1
	end

	local var_140_4 = 10

	while var_140_1[1] do
		self.refresh_bg:getChildByName("time_label" .. 1):setPositionX(var_140_4)

		var_140_4 = var_140_4 + self.refresh_bg:getChildByName("time_label" .. 1):getContentSize().width
	end

	self:updateBtnBuyOnekey()
end

function MarketLayer:updateBtnSkinDiscount()
	if not self.btnSkinDiscount then
		self.btnSkinDiscount = ccui.Button:create("MarketLayer/img_discount_refresh.png", nil, "MarketLayer/img_discount_refresh.png", var_0_24)

		self.panelBottom:addChild(self.btnSkinDiscount, 10)
		self.btnSkinDiscount:setPosition(self.refresh_bg:getPositionX() + 90, self.refresh_bg:getPositionY() + 10)
		Utility:addClickEventListener(self.btnSkinDiscount, handler(self, self.onBtnSkilDiscount))
	end

	self.btnSkinDiscount:setVisible(self.selectedType == "1-5201")
end

function MarketLayer:onBtnSkilDiscount(arg_147_1)
	if self.selectedType ~= "1-5201" then
		return
	end

	local shop_currency_data = require("data.shop_currency_data")

	if not shop_currency_data[self.shopList[self.marketType[self.selectedType]].id] then
		print("miss  shop currency data", self.shopList[self.marketType[self.selectedType]].id)

		return
	end

	local var_147_1 = {
		costtype = "diamond",
		surecallback = function()
			shop_manager:refresh_shop(self.shopList[self.marketType[self.selectedType]].id, function(arg_149_0)
				if arg_149_0.result == 1 then
					playermodel.diamond = playermodel.diamond - arg_149_0.cost_diamond

					global_update_gold_stone_diamond(nil, nil, arg_149_0.cost_diamond)

					for iter_149_0, iter_149_1 in ipairs(arg_149_0.consumes or {}) do
						item_manager:deleteItem(iter_149_1.entityid, iter_149_1.num)
					end

					self:updateButtonList()
					self:refreshTime()
					self:refreshTableData()
					self:updateCurActiveTime()
					self:checkpushBrowseTime()
					self:updateBlackCardDes()
					self:replaceUI()
					self:updatebtnCoupons()
				end
			end)
		end,
		own = playermodel.diamond
	}

	var_147_1.cost = shop_currency_data[self.shopList[self.marketType[self.selectedType]].id].refresh_cost or 50
	var_147_1.labels = {
		isHorizonalCenter = true,
		titleImage = "title_default.png",
		des = string.format("是否消耗钻石刷新折扣皮肤")
	}

	LayerManager:pushInLayer("PopDoLayer", var_147_1)
end

function MarketLayer:updateBtnBuyOnekey()
	if self.selectedType == "2-1" then
		local var_150_0 = self.refresh_bg:getParent()

		if var_150_0:getChildByName("btnbuyonekey") then
			var_150_0:getChildByName("btnbuyonekey"):setVisible(true)
		else
			local var_150_1 = ccui.Button:create("MarketLayer/btn_buy_onekey.png", nil, "MarketLayer/btn_buy_onekey.png", var_0_24)

			var_150_1:setName("btnbuyonekey")
			var_150_1:setAnchorPoint(cc.p(1, 0.5))
			var_150_1:setPosition(cc.p(self.refresh_bg:getPositionX() - self.refresh_bg:getContentSize().width * self.refresh_bg:getAnchorPoint().x - 20, self.refresh_bg:getPositionY() + 5))
			var_150_0:addChild(var_150_1, self.refresh_bg:getLocalZOrder())
			var_150_1:addTouchEventListener(function(arg_151_0, arg_151_1)
				if arg_151_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("PopMarketBuyOnekeyLayer")
			end)
		end
	else
		local var_150_2 = self.refresh_bg:getParent()

		if var_150_2:getChildByName("btnbuyonekey") then
			var_150_2:getChildByName("btnbuyonekey"):setVisible(false)
		end
	end
end

function MarketLayer:tisPanel()
	if self.tipsPanel then
		self.tipsPanel:setVisible(true)
		self.tipsImage:setScale(0)
		self.tipsImage:runAction(cc.ScaleTo:create(0.2, 1))
	else
		self.tipsPanel = ccui.Layout:create()

		self.tipsPanel:setBackGroundImageColor(cc.c3b(255, 255, 255))
		self.tipsPanel:setContentSize(cc.size(cc.Director:getInstance():getVisibleSize().width, cc.Director:getInstance():getVisibleSize().height))
		self.tipsPanel:setAnchorPoint(cc.p(0.5, 0.5))
		self.tipsPanel:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
		self.tipsPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self.tipsPanel:setBackGroundColor(cc.c3b(0, 0, 0))
		self.tipsPanel:setBackGroundColorOpacity(180)
		self.tipsPanel:setTouchEnabled(true)
		self.tipsPanel:addTouchEventListener(function(arg_153_0, arg_153_1)
			if arg_153_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.tipsPanel:setVisible(false)
		end)
		self:addChild(self.tipsPanel, 100)

		self.tipsImage = ccui.ImageView:create("mainScenebg/guide/17.jpg")

		self.tipsImage:setScale(0)
		self.tipsImage:setPosition(cc.p(self.tipsPanel:getContentSize().width / 2, self.tipsPanel:getContentSize().height / 2))
		self.tipsImage:runAction(cc.ScaleTo:create(0.2, 1))
		self.tipsPanel:addChild(self.tipsImage)
	end
end

function MarketLayer:showSoulGirlPop(arg_154_1, arg_154_2)
	local var_154_0 = item_data[arg_154_1.itemid].model

	if arg_154_1.limit_buy_num <= 0 and model_data[var_154_0].uncolor_clothes then
		var_154_0 = tostring(model_data[var_154_0].uncolor_clothes)
	end

	LayerManager:switchShowLayer("SkinShowPopLayer", {
		previewType = "market",
		modelId = var_154_0,
		buyInfo = arg_154_1,
		sceneType = arg_154_2
	})

	do return end

	local var_154_1 = item_data[arg_154_1.itemid].model
	local var_154_2 = ccs.GUIReader:getInstance()
	local var_154_3 = var_154_2:widgetFromJsonFile(config._DEBUG and "SoulGirlPop.json" or "SoulGirlPop.ExportJson")
	local var_154_4 = ccui.Helper:seekWidgetByName(var_154_3, "Panel_26")

	var_154_4.setLocalZOrder(var_154_2, 1)
	self:addChild(var_154_3)

	self.showSoulGirlScenePanel = ccui.Helper:seekWidgetByName(var_154_3, "Image_back")

	self.showSoulGirlScenePanel:setPosition(cc.p(320, 568))
	self.showSoulGirlScenePanel:setTouchEnabled(true)
	self.showSoulGirlScenePanel:setLocalZOrder(0)

	local var_154_5 = ccui.Helper:seekWidgetByName(var_154_3, "Button_return")

	if model_data[var_154_1].background and model_data[var_154_1].background == "dark" then
		var_154_5:loadTextures("MarketLayer/return_btn_dark.png", nil, "MarketLayer/return_btn_dark.png", var_0_24)
	else
		var_154_5:loadTextures("MarketLayer/return_btn_bright.png", nil, "MarketLayer/return_btn_bright.png", var_0_24)
	end

	var_154_5:setLocalZOrder(2)

	local function var_154_6(arg_155_0, arg_155_1)
		if arg_155_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showgirlLayer:resetCurTalkConfig()
		var_154_3:runAction(cc.RemoveSelf:create())

		var_154_3 = nil
	end

	var_154_5:setTouchEnabled(false)
	self.showSoulGirlScenePanel:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function(...)
		var_154_5:setTouchEnabled(true)
		var_154_5:addTouchEventListener(var_154_6)
	end)))

	local var_154_7 = ccui.Layout:create()

	var_154_7:setTouchEnabled(true)
	var_154_7:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_154_7:setAnchorPoint(cc.p(0, 0))
	var_154_7:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_154_7:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_154_3:addChild(var_154_7, -2)

	local var_154_8 = ccui.Helper:seekWidgetByName(var_154_3, "Panel_cute_role")
	local var_154_9 = ccui.Helper:seekWidgetByName(var_154_3, "Image_cute_role")

	var_154_9:loadTexture("roleimage/role1/" .. model_data[var_154_1].cute_role .. ".png")
	var_154_9:setPosition(cc.p(var_154_8:getContentSize().width / 2, var_154_8:getContentSize().height / 2 + 30))
	var_154_9:setScale(0.4)
	var_154_9:setVisible(false)

	local var_154_10 = ccui.Helper:seekWidgetByName(var_154_3, "Panel_up"):setPositionY(568 + GameDisplay.fix_y)

	ccui.Helper:seekWidgetByName(var_154_3, "Panel_down"):setPositionY(568 - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(var_154_3, "Panel_down"):setLocalZOrder(3)
	ccui.Helper:seekWidgetByName(var_154_3, "Panel_up"):setLocalZOrder(3)

	local var_154_11 = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_154_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_154_1].spine_model .. ".atlas", (model_data[var_154_1].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_154_1].clothes_model .. ".atlas" or nil))

	var_154_11:setScale(model_data[var_154_1].modelscale / 1.3 * 0.4, model_data[var_154_1].modelscale / 1.3 * 0.4)
	var_154_11:setContentSize(cc.size(100, 200))
	var_154_11:setPosition(cc.p(var_154_8:getContentSize().width / 2, var_154_8:getContentSize().height / 2 - 60))
	var_154_8:addChild(var_154_11, 99)
	var_154_11:playAni(nil, "idle", true)
	var_154_8:addTouchEventListener(function(arg_157_0, arg_157_1)
		if arg_157_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_157_0 = math.random(2, 5)

		local function var_157_1()
			var_154_11:playAni(nil, "idle", true)
		end

		if var_157_0 == 2 then
			var_154_11:playAni(var_157_1, "run", false)
		elseif var_157_0 == 3 then
			var_154_11:playAni(var_157_1, "yule", false)
		elseif var_157_0 == 4 then
			var_154_11:playAni(var_157_1, "chihe", false)
		else
			var_154_11:playAni(var_157_1, "fadai", false)
		end
	end)

	local var_154_12 = ccui.Helper:seekWidgetByName(var_154_3, "Label_name")
	local var_154_13 = ccui.Helper:seekWidgetByName(var_154_3, "Image_cv")

	var_154_13:loadTexture("public/panelbg/cv_bg.png", var_0_24)

	if favorfile_data[3][model_data[var_154_1].photofile_model] then
		var_154_13:setVisible(favorfile_data[3][model_data[var_154_1].photofile_model] ~= L_CV_UNSURE)

		local var_154_14 = cc.Label:createWithTTF("声优/" .. favorfile_data[3][model_data[var_154_1].photofile_model], FONT_DES, 28)

		var_154_14:setPosition(cc.p(var_154_13:getContentSize().width / 2, var_154_13:getContentSize().height / 2 - 3))
		var_154_13:addChild(var_154_14)
	else
		var_154_13:setVisible(false)
	end

	var_154_12:setFontSize(global_change_fontsize_by_length(model_data[var_154_1].name, 40, 4, 6))
	var_154_12:setString(model_data[var_154_1].name)
	var_154_12:setLocalZOrder(9999)

	local var_154_15 = ccui.Helper:seekWidgetByName(var_154_3, "Label_name_bottom")
	local var_154_16 = ccui.Helper:seekWidgetByName(var_154_3, "Label_name_top")
	local var_154_17 = model_data[var_154_1].main_name

	var_154_15:setString(model_data[var_154_1].main_name)
	var_154_16:setString(var_154_17)

	if model_data[var_154_1].background and model_data[var_154_1].background == "bright" then
		var_154_15:setColor(cc.c3b(40, 125, 205))
		var_154_16:setColor(cc.c3b(0, 255, 246))
	end

	local var_154_18 = ccui.Helper:seekWidgetByName(var_154_3, "Image_type")
	local var_154_19

	if model_data[var_154_1].live2d and not model_data[var_154_1].origin then
		var_154_19 = "MarketLayer/skin_type_live2d.png"
	elseif model_data[var_154_1].rolespine then
		var_154_19 = "MarketLayer/skin_type_spine.png"
	else
		var_154_18:setVisible(false)
	end

	local var_154_20 = model_data[var_154_1].uncolor_clothes
	local var_154_21 = ccui.Button:create("MarketLayer/btn_uncolor.png", nil, "MarketLayer/btn_uncolor.png", var_0_24)

	var_154_21:setPosition(cc.p(var_154_18:getPositionX(), var_154_18:getPositionY() + 100))
	var_154_18:getParent():addChild(var_154_21)

	local var_154_22

	if var_154_20 then
		function arg_154_1.updateLayerCallback()
			self:updateTopInfo()

			self.listData[arg_154_1.index].have_bought = self.listData[arg_154_1.index].have_bought + 1
			self.listData[arg_154_1.index].sell_out = self.listData[arg_154_1.index].buy_limit and self.listData[arg_154_1.index].buy_limit <= self.listData[arg_154_1.index].have_bought

			self:updateShowingCells()
		end

		var_154_22 = shop_manager:fixUnColorMsg(arg_154_1, tonumber(split(self.selectedType, "-")[2]))
	end

	var_154_21:setVisible(var_154_20 ~= nil)
	var_154_21:addTouchEventListener(function(arg_160_0, arg_160_1)
		if arg_160_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_160_0.curmodel == tostring(var_154_20) then
			self.showgirlLayer:update(tostring(var_154_1))

			arg_160_0.curmodel = tostring(var_154_1)

			self:updateSoulGirlPop(var_154_3, arg_154_1, arg_154_2, var_154_11)
			var_154_21:loadTextures("MarketLayer/btn_uncolor.png", nil, "MarketLayer/btn_uncolor.png", var_0_24)
		else
			self.showgirlLayer:update(tostring(var_154_20))

			arg_160_0.curmodel = tostring(var_154_20)

			self:updateSoulGirlPop(var_154_3, var_154_22, arg_154_2, var_154_11)
			var_154_21:loadTextures("MarketLayer/btn_uncolor_on.png", nil, "MarketLayer/btn_uncolor_on.png", var_0_24)
		end
	end)
	var_154_18:loadTextures(var_154_19, nil, var_154_19, var_0_24)
	var_154_18:addTouchEventListener(function(arg_161_0, arg_161_1)
		if arg_161_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:tisPanel()
	end)

	local var_154_23 = ccui.Helper:seekWidgetByName(var_154_3, "Image_cost_bottom")

	var_154_23:loadTexture("MarketLayer/cost_bottom_bright.png", var_0_24)

	local var_154_24 = ccui.Helper:seekWidgetByName(var_154_3, "Image_name")

	var_154_24:loadTexture("MarketLayer/skin_name_bottom_bright.png", var_0_24)
	var_154_24:setPositionY(var_154_24:getPositionY() + GameDisplay.height - 300)

	local var_154_25 = ccui.Helper:seekWidgetByName(var_154_3, "Button_buy")

	var_154_25:loadTextures("MarketLayer/buy_btn_bright.png", nil, "MarketLayer/buy_btn_bright.png", var_0_24)

	local var_154_26 = TempWidget:CreateTempImg("MarketLayer/apply_btn.png", var_154_25:getParent())

	var_154_26:align(cc.p(var_154_25:getAnchorPoint()), var_154_25:getPositionX(), var_154_25:getPositionY() + 120)
	var_154_26:setName("applyBtn")

	local var_154_27 = TempWidget:CreateTempBtn("MarketLayer/fight_stand_get_btn.png", var_154_25:getParent())

	var_154_27:align(cc.p(var_154_25:getAnchorPoint()), var_154_25:getPositionX(), var_154_25:getPositionY())
	var_154_27:setName("fightStandGetBtn")

	local var_154_28 = ccui.Layout:create()

	var_154_28:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_154_28:setAnchorPoint(cc.p(0.5, 0.5))
	var_154_28:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_154_28:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_154_28:setBackGroundColor(cc.c3b(0, 0, 0))
	var_154_28:setBackGroundColorOpacity(0)
	var_154_4:addChild(var_154_28, 2)

	local function var_154_30(arg_162_0, arg_162_1)
		if arg_154_1.have_bought_num == 1 then
			return true
		end

		if var_0_36[playermodel.playerid][var_154_1] > PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT + 1 and arg_154_1.have_bought_num ~= 1 then
			function arg_154_1.shopcallback()
				if var_154_3 then
					var_154_3:runAction(cc.RemoveSelf:create())
				end

				var_154_3 = nil
			end

			LayerManager:pushInLayer("PopGoodsLayer", arg_154_1)

			return true
		elseif var_0_36[playermodel.playerid][var_154_1] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT then
			var_0_36[playermodel.playerid][var_154_1] = var_0_36[playermodel.playerid][var_154_1] + 1

			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return false
		else
			return true
		end
	end

	local function var_154_31(arg_164_0, arg_164_1)
		return false
	end

	local var_154_32 = cc.EventListenerTouchOneByOne:create()

	var_154_32:setSwallowTouches(false)
	var_154_32:registerScriptHandler(var_154_30, cc.Handler.EVENT_TOUCH_BEGAN)
	var_154_32:registerScriptHandler(var_154_31, cc.Handler.EVENT_TOUCH_ENDED)
	var_154_28:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_154_32, var_154_28)
	var_154_25:addTouchEventListener(function(arg_165_0, arg_165_1)
		if arg_165_1 ~= ccui.TouchEventType.ended then
			return
		end

		function arg_154_1.shopcallback(arg_166_0)
			if var_154_3 then
				var_154_3:runAction(cc.RemoveSelf:create())
			end

			var_154_3 = nil
		end

		LayerManager:pushInLayer("PopGoodsLayer", arg_154_1)
	end)
	ccui.Helper:seekWidgetByName(var_154_3, "applyBtn"):_addEvent(function()
		if self._isShowFightModel then
			test_fight_manager:changePlayerArrayByIndes(1, major_factor_data[model_data[var_154_1].major].servant, servant_data[major_factor_data[model_data[var_154_1].major].servant].modelid)
		else
			test_fight_manager:changePlayerArrayByIndes(1, major_factor_data[model_data[var_154_1].major].servant, var_154_1)
		end
	end)
	ccui.Helper:seekWidgetByName(var_154_3, "fightStandGetBtn"):_addEvent(function()
		for iter_168_0, iter_168_1 in ipairs((Utility:parseDataByElement(item_data[servant_data[major_factor_data[model_data[var_154_1].major].servant].itemid], {
			{
				index = "targetlayer",
				name = "roleJump"
			},
			{
				index = "targetlayer_starttime",
				name = "startTime",
				hyphen = "_"
			},
			{
				index = "targetlayer_finishtime",
				name = "endTime",
				hyphen = "_"
			}
		}))) do
			if tonumber(iter_168_1.roleJump) and Utility:isTimeRangeValid(iter_168_1.startTime, iter_168_1.endTime) or tonumber(iter_168_1.roleJump) and not iter_168_1.startTime and not iter_168_1.endTime then
				Utility:executeLayerJump({
					systemid = tonumber(iter_168_1.roleJump)
				})

				return
			end
		end

		global_ShowBlockWords("暂时没有获取该角色的途径")
	end)

	if arg_154_1.have_bought_num == 1 then
		var_154_25:setVisible(false)
		var_154_23:setVisible(false)
	end

	local var_154_33 = ccui.Helper:seekWidgetByName(var_154_3, "Image_costType_new")
	local var_154_34 = ccui.Helper:seekWidgetByName(var_154_3, "Label_cost_num_new")

	self.showSoulGirlScenePanel:setVisible(true)
	var_154_33:loadTexture(arg_154_1.slidecost.costtype, var_0_24)
	var_154_34:setString(arg_154_1.slidecost.costnum)

	local var_154_35 = ccui.Helper:seekWidgetByName(var_154_3, "Panel_old_cost")

	if arg_154_1.cost_old == arg_154_1.slidecost.costnum then
		var_154_35:setVisible(false)
		var_154_33:setPositionX(var_154_33:getPositionX() - 50)
		var_154_34:setPositionX(var_154_34:getPositionX() - 50)
	else
		var_154_35:getChildByName("Label_cost_num"):setString(arg_154_1.cost_old)
		var_154_35:getChildByName("Image_costType"):loadTexture(arg_154_1.slidecost.costtype, var_0_24)
	end

	self.showgirlLayer = require("view.Layer.ShowGirlLayer"):create(var_154_1, 3)

	self.showgirlLayer:resetCurTalkConfig()

	if not var_0_36[playermodel.playerid] then
		var_0_36[playermodel.playerid] = {}
		var_0_36[playermodel.playerid][var_154_1] = var_0_36[playermodel.playerid][var_154_1] or 0
	else
		var_0_36[playermodel.playerid][var_154_1] = var_0_36[playermodel.playerid][var_154_1] or 0
	end

	self.showgirlLayer:setTalkEnabled(arg_154_1.have_bought_num > 0 or var_0_36[playermodel.playerid][var_154_1] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	self.showgirlLayer:setTouchTalkCallback(function()
		var_0_36[playermodel.playerid][var_154_1] = var_0_36[playermodel.playerid][var_154_1] + 1

		self.showgirlLayer:setTalkEnabled(arg_154_1.have_bought_num > 0 or var_0_36[playermodel.playerid][var_154_1] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	end)
	var_154_4:addChild(self.showgirlLayer, 1)

	local var_154_37 = BackGroundLayer:create(model_data[var_154_1].backgroundid, (model_data[var_154_1].is_own_full_screen_background == 1 or nil) and 2)

	var_154_4:addChild(var_154_37, 0)
	var_154_37:setName("backGroundLayer")

	if arg_154_1.limit_buy_num <= 0 and var_154_20 then
		self.showgirlLayer:update(tostring(var_154_20))

		var_154_21.curmodel = tostring(var_154_20)

		self:updateSoulGirlPop(var_154_3, var_154_22, arg_154_2, var_154_11)
		var_154_21:loadTextures("MarketLayer/btn_uncolor_on.png", nil, "MarketLayer/btn_uncolor_on.png", var_0_24)
	end

	self:initBattleStandLayout(var_154_3, var_154_1)
end

function MarketLayer:initBattleStandLayout(arg_170_1, arg_170_2)
	self._isShowFightModel = false

	local var_170_0 = TempWidget:CreateTempLayout(arg_170_1)

	var_170_0:setLocalZOrder(5)
	var_170_0:setContentSize(cc.size(250, 300))
	var_170_0:align(cc.p(1, 0), arg_170_1:getContentSize().width / 2 + 70, -GameDisplay.fix_y)

	var_170_0._curPos = cc.p(var_170_0:size().w, var_170_0:size().h / 2)
	var_170_0._nextPos = cc.p(var_170_0:size().w - 150, var_170_0:size().h / 2)
	var_170_0._isAction = false
	self._battleStandLayout = var_170_0

	local var_170_1
	local var_170_2
	local var_170_3 = 0.8
	local var_170_4 = 0.3
	local var_170_5 = {
		var_170_0._curPos,
		cc.p(var_170_0._curPos.x - 150 / 2, var_170_0._curPos.y + 80),
		var_170_0._nextPos
	}
	local var_170_6 = {
		var_170_0._nextPos,
		cc.p(var_170_0._nextPos.x + 150 / 2, var_170_0._nextPos.y - 80),
		var_170_0._curPos
	}

	local function var_170_7()
		var_170_0._isAction = true
		self._isShowFightModel = not self._isShowFightModel

		if self.showgirlLayer then
			if self.showgirlLayer:getChildByName("roleimage") then
				self.showgirlLayer:getChildByName("roleimage")._talksp = nil
			end

			if self._isShowFightModel then
				self.showgirlLayer:update(tostring(servant_data[major_factor_data[model_data[arg_170_2].major].servant].modelid))
			else
				self.showgirlLayer:update(tostring(arg_170_2))
			end

			if self.showgirlLayer:getChildByName("roleimage") then
				self.showgirlLayer:getChildByName("roleimage")._talksp = nil
			end
		end

		local var_171_0 = ccui.Helper:seekWidgetByName(arg_170_1, "Label_name_bottom")
		local var_171_1 = ccui.Helper:seekWidgetByName(arg_170_1, "Label_name_top")
		local var_171_2 = ccui.Helper:seekWidgetByName(arg_170_1, "Button_buy")
		local var_171_3 = ccui.Helper:seekWidgetByName(arg_170_1, "Image_cost_bottom")

		if self._isShowFightModel then
			var_171_2:setVisible(false)
			var_171_3:setVisible(false)
			var_171_0:setString(model_data[servant_data[major_factor_data[model_data[arg_170_2].major].servant].modelid].main_name)
			var_171_1:setString(model_data[servant_data[major_factor_data[model_data[arg_170_2].major].servant].modelid].main_name)
		else
			var_171_2:setVisible(true)
			var_171_3:setVisible(true)
			var_171_0:setString(model_data[arg_170_2].main_name)
			var_171_1:setString(model_data[arg_170_2].main_name)
		end

		local var_171_4 = false
		local var_171_5 = false
		local var_171_6
		local var_171_7
		local var_171_8
		local var_171_9

		if var_170_1._state == 0 then
			var_171_6 = var_170_1
			var_171_7 = var_170_2
			var_171_8 = var_170_0._topBg1
			var_171_9 = var_170_0._topBg2
		else
			var_171_6 = var_170_2
			var_171_7 = var_170_1
			var_171_8 = var_170_0._topBg2
			var_171_9 = var_170_0._topBg1
		end

		var_171_7:setLocalZOrder(var_171_6:getLocalZOrder() + 1)
		var_171_6:stopAllActions()
		var_171_6:runAction(cc.Sequence:create(cc.Spawn:create(cc.BezierTo:create(var_170_4, var_170_5), cc.ScaleTo:create(var_170_4, var_170_3)), cc.CallFunc:create(function()
			var_171_4 = true
			var_171_6._state = 1

			var_171_8:loadTextureEx("MarketLayer/stand_next_bg.png")

			if var_171_4 and var_171_5 then
				var_170_0._isAction = false
			end
		end)))
		var_171_7:stopAllActions()
		var_171_7:runAction(cc.Sequence:create(cc.Spawn:create(cc.BezierTo:create(var_170_4, var_170_6), cc.ScaleTo:create(var_170_4, 1)), cc.CallFunc:create(function()
			var_171_5 = true
			var_171_7._state = 0

			var_171_9:loadTextureEx("MarketLayer/stand_cur_bg.png")

			if var_171_4 and var_171_5 then
				var_170_0._isAction = false
			end
		end)))
	end

	var_170_1 = TempWidget:CreateTempImg("MarketLayer/stand_bg.png", var_170_0)
	var_170_1._state = 0

	var_170_1:align(cc.p(1, 0.5), var_170_0._curPos)
	var_170_1:_addEvent(function()
		if not var_170_0._isAction then
			var_170_7()
		end
	end)

	var_170_0._standImg1 = var_170_1

	local var_170_8 = TempWidget:CreateTempImg("", var_170_1)

	var_170_8:center()

	var_170_0._roleImage1 = var_170_8

	local var_170_9 = TempWidget:CreateTempImg("MarketLayer/stand_cur_bg.png", var_170_1)

	;(nil):setLocalZOrder(5)
	;(nil):center()

	var_170_0._topBg1 = nil

	local var_170_10 = TempWidget:CreateTempLabel("", FONT_NAME, 19, var_170_1)

	var_170_10:align(cc.p(0.5, 0), var_170_1:size().w / 2, 15)
	var_170_10:setLocalZOrder((nil):getLocalZOrder() + 1)

	var_170_0._name1 = var_170_10
	var_170_2 = TempWidget:CreateTempImg("MarketLayer/stand_bg.png", var_170_0)
	var_170_2._state = 1

	var_170_2:setScale(0.8)
	var_170_2:align(cc.p(1, 0.5), var_170_0._nextPos)
	var_170_2:_addEvent(function()
		if not var_170_0._isAction then
			var_170_7()
		end
	end)

	var_170_0._standImg2 = var_170_2

	local var_170_11 = TempWidget:CreateTempImg("", var_170_2)

	var_170_11:center()

	var_170_0._roleImage2 = var_170_11

	local var_170_12 = TempWidget:CreateTempImg("MarketLayer/stand_next_bg.png", var_170_2)

	;(nil):setLocalZOrder(5)
	;(nil):center()

	var_170_0._topBg2 = nil

	local var_170_13 = TempWidget:CreateTempLabel("", FONT_NAME, 19, var_170_2)

	var_170_13:align(cc.p(0.5, 0), var_170_1:size().w / 2, 15)
	var_170_13:setLocalZOrder((nil):getLocalZOrder() + 1)

	var_170_0._name2 = var_170_13

	self:updateBattleStandLayout(arg_170_2)
end

function MarketLayer:updateBattleStandLayout(arg_176_1)
	local var_176_0 = global_get_servant_skin(major_factor_data[model_data[arg_176_1].major].servant)

	self._battleStandLayout._roleImage1:loadTextureEx("roleimage/role/shop_image/" .. model_data[tostring(arg_176_1)].role_image .. ".png")
	self._battleStandLayout._roleImage1:setScaleX((self._battleStandLayout._standImg1:size().w - 13) / self._battleStandLayout._roleImage1:size().w)
	self._battleStandLayout._roleImage1:setScaleY((self._battleStandLayout._standImg1:size().h - 13) / self._battleStandLayout._roleImage1:size().h)
	self._battleStandLayout._name1:setString(model_data[arg_176_1].main_name)
	self._battleStandLayout._roleImage2:loadTextureEx("roleimage/role/shop_image/" .. model_data[tostring(var_176_0)].role_image .. ".png")
	self._battleStandLayout._roleImage2:setScaleX((self._battleStandLayout._standImg2:size().w - 13) / self._battleStandLayout._roleImage2:size().w)
	self._battleStandLayout._roleImage2:setScaleY((self._battleStandLayout._standImg2:size().h - 13) / self._battleStandLayout._roleImage2:size().h)
	self._battleStandLayout._name2:setString(model_data[var_176_0].main_name)
end

function MarketLayer.updateSoulGirlPop(arg_177_0, arg_177_1, arg_177_2, arg_177_3, arg_177_4)
	local var_177_0 = item_data[arg_177_2.itemid].model
	local var_177_1 = ccui.Helper:seekWidgetByName(arg_177_1, "Panel_26")
	local var_177_2 = ccui.Helper:seekWidgetByName(arg_177_1, "Button_return")

	if model_data[item_data[arg_177_2.itemid].model].background and model_data[var_177_0].background == "dark" then
		var_177_2:loadTextures("MarketLayer/return_btn_dark.png", nil, "MarketLayer/return_btn_dark.png", var_0_24)
	else
		var_177_2:loadTextures("MarketLayer/return_btn_bright.png", nil, "MarketLayer/return_btn_bright.png", var_0_24)
	end

	local var_177_3 = ccui.Helper:seekWidgetByName(arg_177_1, "Panel_cute_role")

	ccui.Helper:seekWidgetByName(arg_177_1, "Image_cute_role"):loadTexture("roleimage/role1/" .. model_data[var_177_0].cute_role .. ".png")
	ccui.Helper:seekWidgetByName(arg_177_1, "Label_name_bottom"):setString(model_data[var_177_0].main_name)
	ccui.Helper:seekWidgetByName(arg_177_1, "Label_name_top"):setString(model_data[var_177_0].main_name)
	arg_177_4:updateSpine(ROLE_SPINE_PATH .. model_data[var_177_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_177_0].spine_model .. ".atlas", (model_data[var_177_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_177_0].clothes_model .. ".atlas" or nil))
	arg_177_4:setScale(model_data[var_177_0].modelscale / 1.3 * 0.4, model_data[var_177_0].modelscale / 1.3 * 0.4)
	arg_177_4:playAni(nil, "idle", true)

	local var_177_4 = ccui.Helper:seekWidgetByName(arg_177_1, "Image_cost_bottom")
	local var_177_5 = ccui.Helper:seekWidgetByName(arg_177_1, "Button_buy")

	var_177_5:addTouchEventListener(function(arg_178_0, arg_178_1)
		if arg_178_1 ~= ccui.TouchEventType.ended then
			return
		end

		function arg_177_2.shopcallback(arg_179_0)
			if arg_177_1 then
				arg_177_1:runAction(cc.RemoveSelf:create())
			end

			arg_177_1 = nil
		end

		LayerManager:pushInLayer("PopGoodsLayer", arg_177_2)
	end)

	if arg_177_2.have_bought_num == 1 then
		var_177_5:setVisible(false)
		var_177_4:setVisible(false)
	else
		var_177_5:setVisible(true)
		var_177_4:setVisible(true)
	end

	ccui.Helper:seekWidgetByName(arg_177_1, "Image_costType_new"):loadTexture(arg_177_2.slidecost.costtype, var_0_24)
	ccui.Helper:seekWidgetByName(arg_177_1, "Label_cost_num_new"):setString(arg_177_2.slidecost.costnum)

	local var_177_6 = ccui.Helper:seekWidgetByName(arg_177_1, "Panel_old_cost")

	if arg_177_2.cost_old == arg_177_2.slidecost.costnum then
		var_177_6:setVisible(false)
	else
		var_177_6:getChildByName("Label_cost_num"):setString(arg_177_2.cost_old)
		var_177_6:getChildByName("Image_costType"):loadTexture(arg_177_2.slidecost.costtype, var_0_24)
	end

	if model_data[var_177_0].backgroundid then
		var_177_1:getChildByName("backGroundLayer"):update(model_data[var_177_0].backgroundid, (model_data[var_177_0].is_own_full_screen_background == 1 or nil) and 2)
	end
end

function MarketLayer:showFurniturePop(arg_180_1)
	local var_180_0 = ccui.Layout:create()

	var_180_0:setTouchEnabled(true)
	var_180_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_180_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_180_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_180_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_180_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_180_0:setBackGroundColorOpacity(180)
	self:addChild(var_180_0, 10)

	local var_180_1 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", var_0_24)

	var_180_1:setPosition(cc.p(var_180_0:getContentSize().width / 2, var_180_0:getContentSize().height / 2))
	var_180_1:setScaleY(0)
	var_180_1:setScaleY(0)
	var_180_1:runAction(cc.ScaleTo:create(0.2, 1.2))
	var_180_0:addChild(var_180_1)

	local var_180_2 = ccui.ImageView:create("mainScenebg/market/" .. arg_180_1.itemid .. ".jpg")

	var_180_2:setPosition(cc.p(var_180_0:getContentSize().width / 2, var_180_0:getContentSize().height / 2))
	var_180_0:addChild(var_180_2)

	local var_180_3 = ccui.ImageView:create("MarketLayer/furniture_bg.png", var_0_24)

	var_180_3:setPosition(cc.p(var_180_2:getContentSize().width / 2, var_180_2:getContentSize().height / 2))
	var_180_2:addChild(var_180_3)

	local var_180_4 = string_split(item_data[arg_180_1.itemid].name, "】")

	if #var_180_4 == 2 then
		local var_180_5 = cc.Label:createWithTTF(var_180_4[2], FONT_DES, 26)

		var_180_5:setPosition(cc.p(470, 188))
		var_180_5:setColor(cc.c3b(187, 62, 198))
		var_180_3:addChild(var_180_5)

		local var_180_6 = cc.Label:createWithTTF(var_180_4[2], FONT_DES, 26)

		var_180_6:setPosition(cc.p(472, 188))
		var_180_6:setColor(cc.c3b(0, 168, 255))
		var_180_3:addChild(var_180_6)
	else
		local var_180_7 = cc.Label:createWithTTF(item_data[arg_180_1.itemid].name, FONT_DES, 26)

		var_180_7:setPosition(cc.p(470, 188))
		var_180_7:setColor(cc.c3b(187, 62, 198))
		var_180_3:addChild(var_180_7)

		local var_180_8 = cc.Label:createWithTTF(item_data[arg_180_1.itemid].name, FONT_DES, 26)

		var_180_8:setPosition(cc.p(472, 188))
		var_180_8:setColor(cc.c3b(0, 168, 255))
		var_180_3:addChild(var_180_8)
	end

	local var_180_9 = ccui.ImageView:create(arg_180_1.slidecost.costtype, var_0_24)

	var_180_9:setPositionX(var_180_3:getContentSize().width / 2 - 30)
	var_180_9:setPositionY(-130)
	var_180_3:addChild(var_180_9)

	local var_180_10 = cc.Label:createWithTTF(arg_180_1.slidecost.costnum, FONT_DES, 23)

	var_180_10:setAnchorPoint(cc.p(0, 0.5))
	var_180_10:setPositionX(var_180_9:getPositionX() + var_180_9:getContentSize().width / 2 + 5)
	var_180_10:setPositionY(var_180_9:getPositionY())
	var_180_3:addChild(var_180_10)

	local var_180_11
	local var_180_12

	if arg_180_1.limit_buy_num == 0 then
		var_180_11 = ccui.Button:create("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_24)
		var_180_12 = cc.Label:createWithTTF(L_MARKET_GOODS_LACK, FONT_BUTTON, 26)
	else
		var_180_11 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_24)
		var_180_12 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)
	end

	var_180_12:setColor(cc.c3b(12, 12, 12))
	var_180_11:setPosition(cc.p(var_180_3:getContentSize().width / 2, -60))
	var_180_12:setPosition(cc.p(var_180_11:getContentSize().width / 2, var_180_11:getContentSize().height / 2 - 5))
	var_180_11:addChild(var_180_12)
	var_180_3:addChild(var_180_11)
	var_180_11:addTouchEventListener(function(arg_181_0, arg_181_1)
		if arg_181_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_180_1.ShopSliderCallback then
			arg_180_1.ShopSliderCallback(arg_181_0, arg_181_1, function()
				var_180_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_180_0:runAction(cc.RemoveSelf:create())
				end)))
				var_180_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_180_0:runAction(cc.RemoveSelf:create())
				end)))
			end)
		end
	end)
	var_180_2:setScaleY(0)
	var_180_2:runAction(cc.ScaleTo:create(0.2, 1))
	var_180_0:addTouchEventListener(function(arg_185_0, arg_185_1)
		var_180_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_180_0:runAction(cc.RemoveSelf:create())
		end)))
		var_180_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_180_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	self:initMiniHead(var_180_3, furnituresuit_data[item_data[arg_180_1.itemid].suit_id])
end

function MarketLayer:showFurniturePopNew(arg_188_1)
	local var_188_0 = ccui.Layout:create()

	var_188_0:setTouchEnabled(true)
	var_188_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_188_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_188_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_188_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_188_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_188_0:setBackGroundColorOpacity(180)
	self:addChild(var_188_0, 10)

	local var_188_1 = ccui.Layout:create()

	var_188_1:setTouchEnabled(true)
	var_188_1:setContentSize(cc.size(640, 480))
	var_188_1:setAnchorPoint(0.5, 0.5)
	var_188_1:setPosition(320, var_188_0:getContentSize().height / 2)
	var_188_0:addChild(var_188_1)

	local var_188_2 = ccui.ImageView:create("public/panelbg/bg_pop_big.png", var_0_24)

	var_188_2:setPosition(cc.p(var_188_1:getContentSize().width / 2, var_188_1:getContentSize().height / 2 + 20))
	var_188_1:addChild(var_188_2)

	local var_188_3 = ccui.ImageView:create("mainScenebg/market/" .. arg_188_1.itemid .. ".jpg")

	var_188_3:setPosition(cc.p(var_188_1:getContentSize().width / 2, var_188_1:getContentSize().height / 2 + 80))
	var_188_1:addChild(var_188_3)

	local var_188_4 = ccui.ImageView:create("MarketLayer/furniture_bg.png", var_0_24)

	var_188_4:setPosition(cc.p(var_188_3:getContentSize().width / 2, var_188_3:getContentSize().height / 2))
	var_188_3:addChild(var_188_4)

	local var_188_5 = string_split(item_data[arg_188_1.itemid].name, "】")

	if #var_188_5 == 2 then
		local var_188_6 = cc.Label:createWithTTF(var_188_5[2], FONT_DES, 26)

		var_188_6:setPosition(cc.p(470, 188))
		var_188_6:setColor(cc.c3b(187, 62, 198))
		var_188_4:addChild(var_188_6)

		local var_188_7 = cc.Label:createWithTTF(var_188_5[2], FONT_DES, 26)

		var_188_7:setPosition(cc.p(472, 188))
		var_188_7:setColor(cc.c3b(0, 168, 255))
		var_188_4:addChild(var_188_7)
	else
		local var_188_8 = cc.Label:createWithTTF(item_data[arg_188_1.itemid].name, FONT_DES, 26)

		var_188_8:setPosition(cc.p(470, 188))
		var_188_8:setColor(cc.c3b(187, 62, 198))
		var_188_4:addChild(var_188_8)

		local var_188_9 = cc.Label:createWithTTF(item_data[arg_188_1.itemid].name, FONT_DES, 26)

		var_188_9:setPosition(cc.p(472, 188))
		var_188_9:setColor(cc.c3b(0, 168, 255))
		var_188_4:addChild(var_188_9)
	end

	local var_188_10 = self.listData[arg_188_1.index]
	local var_188_11 = ItemSmallSprite:createSmallItem("diamond", shop_manager:getCurrencyNum(self.listData[arg_188_1.index].currency), self.listData[arg_188_1.index].discount or var_188_10.cost_old)

	var_188_11:setPosition(230, 150)

	local var_188_12 = ccui.Button:create("public/button/coupon_select_small.png", "public/button/coupon_select_small.png", "public/button/coupon_unselect_small.png", var_0_24)

	var_188_12:setPosition(var_188_11:getContentSize().width / 2 + 60, var_188_11:getContentSize().height / 2 + 60)
	var_188_11:addChild(var_188_12, 5)
	var_188_12:setScale(1.8)
	var_188_11:setScale(0.6)
	var_188_1:addChild(var_188_11)

	local var_188_13 = ItemSmallSprite:createSmallItem(var_188_10.currency2, shop_manager:getCurrencyNum(var_188_10.currency2), var_188_10.discount2 or var_188_10.cost_old2)

	var_188_1:addChild(var_188_13)
	var_188_13:setPosition(410, 150)

	local var_188_14 = ccui.Button:create("public/button/coupon_select_small.png", "public/button/coupon_select_small.png", "public/button/coupon_unselect_small.png", var_0_24)

	var_188_14:setPosition(var_188_13:getContentSize().width / 2 + 60, var_188_13:getContentSize().height / 2 + 60)
	var_188_13:addChild(var_188_14, 5)
	var_188_13:setScale(0.6)
	var_188_14:setEnabled(false)
	var_188_14:setBright(false)
	var_188_14:setScale(1.8)
	var_188_11:setTouchEnabled(true)
	var_188_13:setTouchEnabled(true)

	local var_188_15 = var_188_10.currency
	local var_188_16 = var_188_10.discount or var_188_10.cost_old

	Utility:addClickEventListener(var_188_11, function()
		var_188_12:setEnabled(true)
		var_188_12:setBright(true)
		var_188_14:setEnabled(false)
		var_188_14:setBright(false)

		var_188_15 = var_188_10.currency
		var_188_16 = var_188_10.discount or var_188_10.cost_old
	end)
	Utility:addClickEventListener(var_188_13, function()
		var_188_12:setEnabled(false)
		var_188_12:setBright(false)
		var_188_14:setEnabled(true)
		var_188_14:setBright(true)

		var_188_15 = var_188_10.currency2
		var_188_16 = var_188_10.discount2 or var_188_10.cost_old2
	end)

	local var_188_17
	local var_188_18

	if arg_188_1.limit_buy_num == 0 then
		var_188_17 = ccui.Button:create("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_24)
		var_188_18 = cc.Label:createWithTTF(L_MARKET_GOODS_LACK, FONT_BUTTON, 26)
	else
		var_188_17 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_24)
		var_188_18 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)
	end

	var_188_18:setColor(cc.c3b(12, 12, 12))
	var_188_17:setPosition(cc.p(320, 20))
	var_188_18:setPosition(cc.p(var_188_17:getContentSize().width / 2, var_188_17:getContentSize().height / 2 - 5))
	var_188_17:addChild(var_188_18)
	var_188_1:addChild(var_188_17)
	var_188_17:addTouchEventListener(function(arg_191_0, arg_191_1)
		if arg_191_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_191_0()
			var_188_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
				var_188_0:runAction(cc.RemoveSelf:create())
			end)))
		end

		if shop_manager:getCurrencyNum(var_188_15) < var_188_16 then
			if var_188_15 == SHOP_CURRENCY_DIAMOND then
				shop_manager:popGoGain(var_188_15, function()
					self:updateTopInfo()
				end)
			else
				local var_191_1 = var_188_16 - shop_manager:getCurrencyNum(var_188_15)
				local var_191_2 = {
					shopId = 110076,
					cost = 80,
					shopType = 1
				}

				LayerManager:pushInLayer("PopDoLayer", {
					costtype = "diamond",
					surecallback = function()
						shop_manager:purchase_shop_currency(var_188_15, var_191_1, function()
							if arg_188_1.ShopSliderCallback then
								arg_188_1.ShopSliderCallback(arg_191_0, arg_191_1, var_191_0, nil, var_188_15)
							end
						end, true)
					end,
					own = playermodel.diamond,
					cost = var_191_1 * var_191_2.cost,
					labels = {
						title = "家具兑换券不足",
						des = string.format("消耗%d魂晶补足%d张家具兑换券", var_191_1 * var_191_2.cost, var_191_1)
					}
				})
			end

			return
		end

		if arg_188_1.ShopSliderCallback then
			arg_188_1.ShopSliderCallback(arg_191_0, arg_191_1, var_191_0, nil, var_188_15)
		end
	end)
	var_188_1:setScaleY(0)
	var_188_1:runAction(cc.ScaleTo:create(0.2, 1, 1))
	var_188_0:addTouchEventListener(function(arg_197_0, arg_197_1)
		var_188_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_188_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	self:initMiniHead(var_188_4, furnituresuit_data[item_data[arg_188_1.itemid].suit_id])
end

function MarketLayer:initMiniHead(arg_199_1, arg_199_2)
	if (arg_199_2 and arg_199_2.servantid and major_factor_data[arg_199_2.servantid] and major_factor_data[arg_199_2.servantid].model) == nil then
		return
	end

	if arg_199_1:getChildByName("isShowHaveServant") then
		arg_199_1:getChildByName("isShowHaveServant"):removeFromParent()
	end

	if arg_199_1:getChildByName("mask") then
		arg_199_1:getChildByName("mask"):removeFromParent()
	end

	if arg_199_1:getChildByName("di") then
		arg_199_1:getChildByName("di"):removeFromParent()
	end

	local var_199_2 = cc.p(60, 150)
	local var_199_3 = "roleimage/role1/" .. model_data[var_199_0].cute_role .. ".png"
	local var_199_4

	if config._DEBUG then
		var_199_4 = cc.Sprite:create("public/rolebg/q_avatar_furniture_mask.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/q_avatar_furniture_mask.png")
	end

	local var_199_5 = cc.Sprite:create(var_199_3)

	var_199_5:setScale(0.28)
	var_199_5:setPosition(cc.p(-20, 30))

	local var_199_6 = cc.ClippingNode:create(var_199_4)

	var_199_6:setAlphaThreshold(0.5)
	var_199_6:setContentSize(cc.size(120, 112))
	var_199_6:setPosition(var_199_2)
	var_199_6:addChild(var_199_5)

	self.miniHeadNode = var_199_6

	self.miniHeadNode:setName("isShowHaveServant")
	arg_199_1:addChild(var_199_6, 99)

	maskNode = ccui.ImageView:create("public/rolebg/q_avatar_furniture_lock.png", var_0_24)

	maskNode:setName("mask")
	maskNode:setPosition(var_199_2)
	arg_199_1:addChild(maskNode, 99)
	maskNode:setVisible(self:isShowHaveServant(arg_199_2.furniture_gift_id) == false)

	local var_199_7 = ccui.ImageView:create("public/rolebg/q_avatar_furniture_di.png", var_0_24)

	var_199_7:setName("di")
	var_199_7:setPosition(var_199_2)
	arg_199_1:addChild(var_199_7, 98)
end

function MarketLayer:buyGift(arg_200_1)
	local var_200_0 = ccui.Layout:create()

	var_200_0:setTouchEnabled(true)
	var_200_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_200_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_200_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_200_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_200_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_200_0:setBackGroundColorOpacity(180)
	self:addChild(var_200_0, 10)

	local var_200_1 = ccui.ImageView:create(var_0_50[var_0_40[self.selectedType]] .. arg_200_1.itemid .. var_0_51[var_0_40[self.selectedType]])

	var_200_1:setPosition(cc.p(var_200_0:getContentSize().width / 2, var_200_0:getContentSize().height / 2))
	var_200_0:addChild(var_200_1)

	local var_200_2 = ccui.ImageView:create(arg_200_1.slidecost.costtype, var_0_24)

	var_200_2:setPositionX(var_200_1:getContentSize().width / 2 - 20)
	var_200_2:setPositionY(-130)
	var_200_1:addChild(var_200_2)

	local var_200_3 = cc.Label:createWithTTF(arg_200_1.slidecost.costnum, FONT_DES, 23)

	var_200_3:setAnchorPoint(cc.p(0, 0.5))
	var_200_3:setPositionX(var_200_2:getPositionX() + var_200_2:getContentSize().width / 2 + 5)
	var_200_3:setPositionY(var_200_2:getPositionY())
	var_200_1:addChild(var_200_3)

	local var_200_4 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_24)
	local var_200_5 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)

	var_200_5:setColor(cc.c3b(12, 12, 12))
	var_200_4:setPosition(cc.p(var_200_1:getContentSize().width / 2, -70))
	var_200_5:setPosition(cc.p(var_200_4:getContentSize().width / 2, var_200_4:getContentSize().height / 2 - 5))
	var_200_4:addChild(var_200_5)
	var_200_1:addChild(var_200_4)
	var_200_4:addTouchEventListener(function(arg_201_0, arg_201_1)
		if arg_201_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_201_0:isBright() then
			return
		end

		require("controller.l2utils"):performNodeWithDelay(arg_201_0, 2)

		if arg_200_1.ShopSliderCallback then
			arg_200_1.ShopSliderCallback(arg_201_0, arg_201_1, function()
				var_200_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_200_0:runAction(cc.RemoveSelf:create())
				end)))
			end)
		end
	end)
	var_200_1:setScaleY(0)
	var_200_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_200_0:addTouchEventListener(function(arg_204_0, arg_204_1)
		var_200_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_200_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	;(function(...)
		local var_206_0

		for iter_206_0, iter_206_1 in pairs(self.listData) do
			if iter_206_1.shopid == arg_200_1.shopid then
				var_206_0 = iter_206_1
			end
		end

		if not var_206_0 then
			return
		end

		local var_206_1 = var_200_1

		while var_206_1:getChildByName("itemsprite_" .. 1) do
			var_206_1:getChildByName("itemsprite_" .. 1):setName("itemsprite_old" .. 1)
			var_206_1:getChildByName("itemsprite_old" .. 1):runAction(cc.RemoveSelf:create())
		end

		if not shop_data[var_206_0.shopid].shop_ui_type then
			return
		end

		local var_206_3 = drop_manager:getDropMsg(item_data[var_206_0.itemid].mode_id)

		table.sort(var_206_3.equips, function(arg_207_0, arg_207_1)
			return arg_207_0._index < arg_207_1._index
		end)

		local var_206_4 = {}

		if var_206_3.diamond > 0 then
			table.insert(var_206_4, {
				itemid = "diamond",
				num = var_206_3.diamond,
				name = L_DIAMOND
			})
		end

		if var_206_3.gold > 0 then
			table.insert(var_206_4, {
				itemid = "gold",
				num = var_206_3.gold,
				name = L_GOLD
			})
		end

		local var_206_5 = {}
		local var_206_6 = false
		local var_206_7 = false

		for iter_206_2, iter_206_3 in pairs(var_206_3.equips) do
			if item_data[iter_206_3.dropid].bag_item_type == kITEM_SKIN then
				return
			end

			if item_data[iter_206_3.dropid].bag_item_type == kITEM_GIFT_FOR_FRIEND then
				var_206_7 = true
			end

			if item_data[iter_206_3.dropid].bag_item_type == kITEM_FURNITURE then
				-- block empty
			end

			table.insert(var_206_5, {
				itemid = iter_206_3.dropid,
				num = iter_206_3.dropNum
			})
		end

		if var_206_7 and var_206_7 then
			var_206_6 = true
		end

		local var_206_10 = false

		while var_206_5[1] do
			local var_206_11 = false

			if item_data[var_206_5[1].itemid].bag_item_type == kITEM_FURNITURE then
				if not var_206_10 then
					var_206_10 = true
					var_206_5[1].path = string.gsub(var_206_0.icon, ".png", "_furniture.jpg")
				else
					var_206_11 = true
				end
			end

			local var_206_12

			if var_206_11 then
				table.remove(var_206_5, 1)
			else
				var_206_12 = 1 + 1
			end
		end

		for iter_206_4, iter_206_5 in pairs(var_206_5) do
			table.insert(var_206_4, iter_206_5)
		end

		local var_206_13 = {}

		var_206_13 = var_206_6 and {
			cc.p(122, 479),
			cc.p(122, 324),
			cc.p(122, 169)
		} or #var_206_4 == 2 and {
			cc.p(122, 465),
			cc.p(122, 275)
		} or #var_206_4 == 3 and {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		} or {
			cc.p(122, 211),
			cc.p(122, 352),
			cc.p(122, 494)
		}

		for iter_206_6, iter_206_7 in pairs(var_206_4) do
			local var_206_14 = ItemSpriteShop:createSignItem()

			var_206_14:updateSignItemByItemid(iter_206_7.itemid, iter_206_7.num, nil, nil, iter_206_7.path)
			var_206_14:setName("itemsprite_" .. iter_206_6)
			var_206_14:setPosition(var_206_13[iter_206_6])
			var_206_1:addChild(var_206_14)
			var_206_14:setInfoTouchEvent(true)
			var_206_14:setSwallowTouches(true)
		end
	end)()
end

function MarketLayer.getListLen(arg_208_0, arg_208_1)
	return math.ceil(#arg_208_1.listData / arg_208_1.node_number)
end

function MarketLayer:updateShowingCells()
	local var_209_0, var_209_1 = GetTableViewShowCellIdx(self.tableViewList[var_0_40[self.selectedType]], {
		cellsize = cc.size(var_0_46[self.selectedType].width, var_0_46[self.selectedType].height),
		maxcount = self:getListLen(self.tableViewList[var_0_40[self.selectedType]])
	})

	for iter_209_0 = var_209_0, var_209_1 do
		self.tableViewList[var_0_40[self.selectedType]]:updateCellAtIndex(iter_209_0)
	end
end

function MarketLayer:updateNewAlert()
	local var_210_0 = false

	for iter_210_0, iter_210_1 in pairs(self.listData) do
		if iter_210_1.isnewitem then
			var_210_0 = true

			return
		end
	end

	if var_210_0 == false then
		alert_manager:unregister_alert(ALERT_NEW_MARKET)
	end
end

function MarketLayer:updateBlackCardDes()
	if ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img1") then
		ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img1"):setVisible(false)
	end

	if ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img2") then
		ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img2"):setVisible(false)
	end

	if self.openSingleMarket and self.selectedType == "1-3" then
		if not ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img1") then
			local var_211_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom")
			local var_211_1 = ccui.ImageView:create("MarketLayer/tips_blackcard.png", var_0_24)

			var_211_1.setAnchorPoint(var_211_0, cc.p(0.5, 0.5))
			var_211_1:setPositionX(450)
			var_211_1:setPositionY(var_211_0:getContentSize().height / 2)
			var_211_1:setName("img1")
			ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):addChild(var_211_1)
		end

		ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img1"):setVisible(true)
	end

	if self.openSingleMarket and self.selectedType == "1-11" then
		if not ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img2") then
			local var_211_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom")
			local var_211_3 = ccui.ImageView:create("MarketLayer/tips_blackcard_sp.png", var_0_24)

			var_211_3.setAnchorPoint(var_211_2, cc.p(0.5, 0.5))
			var_211_3:setPositionX(420)
			var_211_3:setPositionY(var_211_2:getContentSize().height / 2)
			var_211_3:setName("img2")
			ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):addChild(var_211_3)
		end

		ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):getChildByName("img2"):setVisible(true)
	end
end

function MarketLayer:registerTimeCheckEvent()
	local var_212_0 = {}

	for iter_212_0, iter_212_1 in pairs(self.marketData) do
		if iter_212_1.refreshtype > 0 and iter_212_1.refreshtime then
			var_212_0[iter_212_1.refreshtype] = var_212_0[iter_212_1.refreshtype] or {}

			local var_212_1 = {}

			for iter_212_2 in iter_212_1.refreshtime:gmatch("(%d+)") do
				table.insert(var_212_1, iter_212_2)
			end

			for iter_212_3, iter_212_4 in pairs(var_212_1) do
				var_212_0[iter_212_1.refreshtype][string.format("%02d", iter_212_4)] = var_212_0[iter_212_1.refreshtype][string.format("%02d", iter_212_4)] or {}
				var_212_0[iter_212_1.refreshtype][string.format("%02d", iter_212_4)][iter_212_1.type] = var_212_0[iter_212_1.refreshtype][string.format("%02d", iter_212_4)][iter_212_1.type] or true
			end
		end
	end

	local var_212_2 = {
		DAY = 3,
		HOUR = 1,
		WDAY = 2
	}

	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_213_0)
		if not var_212_0 or not next(var_212_0) then
			return
		end

		local var_213_0 = var_212_2[split(arg_213_0.eventType, "_")[1]]
		local var_213_1 = string.format("%02d", tostring(split(arg_213_0.eventType, "_")[2]))

		if var_212_0[var_213_0] and var_212_0[var_213_0][var_213_1] and var_212_0[var_213_0][var_213_1][self.selectedType] then
			self:showConfirmDialogPop()
			self:refreshTime()
			self:refreshTableData()
			self:updateCurActiveTime()
		end
	end), self)
end

function MarketLayer.showConfirmDialogPop(arg_214_0)
	local var_214_0 = L_MARKET_CONFIRM_DIALOG.des
	local var_214_1 = L_MARKET_CONFIRM_DIALOG.title
	local var_214_2 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_Chapter_require.json" or "Pop_Chapter_require.ExportJson")
	local var_214_3 = string.len(L_MARKET_CONFIRM_DIALOG.des) * 8 + 10 > 320 and 320 or string.len(var_214_0) * 8 + 10

	ccui.Helper:seekWidgetByName(var_214_2, "Panel"):setContentSize(GameDisplay.getUiScreenSize())

	local var_214_5 = ccui.Helper:seekWidgetByName(var_214_2, "box")

	var_214_5:setPositionY(var_214_5:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	ccui.Helper:seekWidgetByName(var_214_2, "description"):setContentSize(var_214_3, 60)
	ccui.Helper:seekWidgetByName(var_214_2, "title"):setString(var_214_1)
	ccui.Helper:seekWidgetByName(var_214_2, "description"):setString(var_214_0)
	ccui.Helper:seekWidgetByName(var_214_2, "image_Q"):loadTexture("roleimage/role1/100.png")

	local var_214_6 = ccui.Helper:seekWidgetByName(var_214_2, "button")

	var_214_6:getChildByName("button_label"):setString(L_BUTTON_TEXT.Sure)
	var_214_6:addTouchEventListener(function(arg_215_0, arg_215_1)
		if arg_215_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_214_2:runAction(cc.RemoveSelf:create())
	end)
	var_214_2:addTouchEventListener(function(arg_216_0, arg_216_1)
		if arg_216_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_214_2:runAction(cc.RemoveSelf:create())
	end)
	global_basic_scene:addChild(var_214_2, 100)
end

function MarketLayer:registerGuidesEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("select_market_type", function(arg_218_0)
		self.selectedType = arg_218_0.params

		self:updateButtonList()
		self:refreshTime()
		self:refreshTableData()
		self:updateCurActiveTime()
		self:checkpushBrowseTime()
	end), self)
end

function MarketLayer:getShowStat()
	if self.openSingleMarket then
		return 1
	else
		return 0
	end
end

function MarketLayer:replaceUI()
	if self.selectedType == "1-12" or self.selectedType == "1-13" then
		ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):setBackGroundImage("MarketLayer/bottom_halloween.png", var_0_24)
		self.titleSprite:setBackGroundImage("MarketLayer/top_halloween.png", var_0_24)
	elseif self.selectedType == "1-123000" then
		self.titleSprite:setBackGroundImage("MarketLayer/market_st_title.png", var_0_24)
	else
		ccui.Helper:seekWidgetByName(self.rootlayer, "panel_bottom"):setBackGroundImage("MarketLayer/under_bottom.png", var_0_24)
		self.titleSprite:setBackGroundImage("MarketLayer/maker_top.png", var_0_24)

		if self.tilepath then
			self.titleSprite:setBackGroundImage(self.tilepath, var_0_24)
			self.titleSprite:setPositionX(-170)
		else
			self.titleSprite:setPositionX(0)
		end
	end
end

function MarketLayer:playPumpkinSpine(arg_221_1)
	audio_manager:playeffectMusicTest("sound/halloween_open_package")

	if not self.skeletonData then
		self.skeletonData = SpineCacheManager:addSpineData(UI_SPINE_PATH .. "halloween_package.json", UI_SPINE_PATH .. "halloween_package.atlas")

		self.skeletonData:retain()
	end

	local var_221_0 = ccui.Layout:create()

	var_221_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_221_0:setAnchorPoint(cc.p(0, 0))
	var_221_0:setPosition(cc.p(0, 0))
	var_221_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_221_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_221_0:setBackGroundColorOpacity(180)
	cc.Director:getInstance():getRunningScene():addChild(var_221_0, 1000)
	var_221_0:runAction(cc.Sequence:create(cc.DelayTime:create(1.8), cc.CallFunc:create(function(...)
		if arg_221_1 then
			arg_221_1()
		end
	end), cc.RemoveSelf:create()))
	var_221_0:setTouchEnabled(true)
	var_221_0:addTouchEventListener(function(arg_223_0, arg_223_1)
		if arg_223_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_221_0:runAction(cc.RemoveSelf:create())

		if arg_221_1 then
			arg_221_1()
		end
	end)

	local var_221_1 = sp.SkeletonAnimation:create(self.skeletonData:getData())

	var_221_1:setPositionX(GameDisplay.width / 2)
	var_221_1:setPositionY(GameDisplay.height / 2)
	var_221_0:addChild(var_221_1)
	var_221_1:setAnimation(0, "animation", false)
end

function MarketLayer:showBachelorFurniturePop(arg_224_1)
	local var_224_0 = ccui.Layout:create()

	var_224_0:setTouchEnabled(true)
	var_224_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_224_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_224_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_224_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_224_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_224_0:setBackGroundColorOpacity(180)
	self:addChild(var_224_0, 10)

	local var_224_1 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", var_0_24)

	var_224_1:setPosition(cc.p(var_224_0:getContentSize().width / 2, var_224_0:getContentSize().height / 2))
	var_224_1:setScaleY(0)
	var_224_1:setScaleY(0)
	var_224_1:runAction(cc.ScaleTo:create(0.2, 1.2))
	var_224_0:addChild(var_224_1)

	local var_224_2 = ccui.ImageView:create("mainScenebg/market/" .. arg_224_1.itemid .. ".jpg")

	var_224_2:setPosition(cc.p(var_224_0:getContentSize().width / 2, var_224_0:getContentSize().height / 2))
	var_224_0:addChild(var_224_2)

	local var_224_3 = ccui.ImageView:create("MarketLayer/furniture_bg.png", var_0_24)

	var_224_3:setPosition(cc.p(var_224_2:getContentSize().width / 2, var_224_2:getContentSize().height / 2))
	var_224_2:addChild(var_224_3)

	local var_224_4 = string_split(item_data[arg_224_1.itemid].name, "】")

	if #var_224_4 == 2 then
		local var_224_5 = cc.Label:createWithTTF(var_224_4[2], FONT_DES, 26)

		var_224_5:setPosition(cc.p(470, 188))
		var_224_5:setColor(cc.c3b(187, 62, 198))
		var_224_3:addChild(var_224_5)

		local var_224_6 = cc.Label:createWithTTF(var_224_4[2], FONT_DES, 26)

		var_224_6:setPosition(cc.p(472, 188))
		var_224_6:setColor(cc.c3b(0, 168, 255))
		var_224_3:addChild(var_224_6)
	else
		local var_224_7 = cc.Label:createWithTTF(item_data[arg_224_1.itemid].name, FONT_DES, 26)

		var_224_7:setPosition(cc.p(470, 188))
		var_224_7:setColor(cc.c3b(187, 62, 198))
		var_224_3:addChild(var_224_7)

		local var_224_8 = cc.Label:createWithTTF(item_data[arg_224_1.itemid].name, FONT_DES, 26)

		var_224_8:setPosition(cc.p(472, 188))
		var_224_8:setColor(cc.c3b(0, 168, 255))
		var_224_3:addChild(var_224_8)
	end

	local var_224_9 = ccui.ImageView:create(arg_224_1.slidecost.costtype, var_0_24)

	var_224_9:setPositionX(var_224_3:getContentSize().width / 2 - 30)
	var_224_9:setPositionY(-130)
	var_224_3:addChild(var_224_9)

	local var_224_10 = cc.Label:createWithTTF(arg_224_1.slidecost.costnum, FONT_DES, 23)

	var_224_10:setAnchorPoint(cc.p(0, 0.5))
	var_224_10:setPositionX(var_224_9:getPositionX() + var_224_9:getContentSize().width / 2 + 5)
	var_224_10:setPositionY(var_224_9:getPositionY())
	var_224_3:addChild(var_224_10)

	local var_224_11
	local var_224_12

	if arg_224_1.limit_buy_num == 0 then
		var_224_11 = ccui.Button:create("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_24)
		var_224_12 = cc.Label:createWithTTF(L_MARKET_GOODS_LACK, FONT_BUTTON, 26)
	else
		var_224_11 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_24)
		var_224_12 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)
	end

	var_224_12:setColor(cc.c3b(12, 12, 12))
	var_224_11:setPosition(cc.p(var_224_3:getContentSize().width / 2, -60))
	var_224_12:setPosition(cc.p(var_224_11:getContentSize().width / 2, var_224_11:getContentSize().height / 2 - 5))
	var_224_11:addChild(var_224_12)
	var_224_3:addChild(var_224_11)
	var_224_2:setScaleY(0)
	var_224_2:runAction(cc.ScaleTo:create(0.2, 1))
	var_224_0:addTouchEventListener(function(arg_225_0, arg_225_1)
		var_224_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_224_0:runAction(cc.RemoveSelf:create())
		end)))
		var_224_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_224_0:runAction(cc.RemoveSelf:create())
		end)))
	end)

	local var_224_13 = ccui.ImageView:create("public/panelbg/coupon_select_bg.png", var_0_24)

	var_224_13:setScale9Enabled(true)
	var_224_13:setCapInsets(cc.rect(0, 0, 10, 10))
	var_224_13:setContentSize(cc.size(640, 45 * (#arg_224_1.couponList + 1) + (#arg_224_1.couponList + 1 - 2) * 12))
	var_224_11:setPositionY(var_224_11:getPositionY() - var_224_13:getContentSize().height + 18)
	var_224_13:setAnchorPoint(cc.p(0.5, 0))
	var_224_13:setPosition(cc.p(282, var_224_11:getPositionY() + 30))
	var_224_3:addChild(var_224_13, 1)
	var_224_9:setPositionY(var_224_9:getPositionY() - var_224_13:getContentSize().height + 18)
	var_224_10:setPositionY(var_224_9:getPositionY())

	self.selectBtnList = {}

	local var_224_14

	for iter_224_0, iter_224_1 in pairs(arg_224_1.couponList) do
		local var_224_15 = ccui.ImageView:create("public/panelbg/coupon_sprite_bg.png", var_0_24)

		var_224_15:setPosition(cc.p(var_224_13:getContentSize().width / 2, var_224_13:getContentSize().height - 45 - (var_224_15:getContentSize().height + 12) * (iter_224_0 - 1)))
		var_224_13:addChild(var_224_15)

		local var_224_16 = ccui.ImageView:create("equipment/" .. iter_224_1.id .. ".png")

		var_224_16:setPosition(cc.p(40, 23))
		var_224_16:setScale(0.3)
		var_224_15:addChild(var_224_16)

		local var_224_17 = cc.Label:createWithTTF(iter_224_1.name .. " X" .. item_manager:getItemNumber(iter_224_1.id), FONT_NAME, 20)

		var_224_17:setColor(cc.c3b(188, 206, 226))
		var_224_17:setAnchorPoint(cc.p(0, 0.5))
		var_224_17:setPosition(cc.p(80, 23))
		var_224_15:addChild(var_224_17)

		local var_224_18 = ccui.ImageView:create(arg_224_1.slidecost.costtype, var_0_24)

		var_224_18:setPosition(cc.p(355, 23))
		var_224_15:addChild(var_224_18)

		local var_224_19 = "-" .. iter_224_1.discount1

		if iter_224_1.discount1 == -1 then
			var_224_19 = L_FREE_BUY

			var_224_18:setVisible(false)
		end

		local var_224_20 = cc.Label:createWithTTF(var_224_19, FONT_NAME, 24)

		var_224_20:setColor(cc.c3b(188, 206, 226))
		var_224_20:setPosition(cc.p(400, 23))
		var_224_15:addChild(var_224_20)

		local var_224_21 = ccui.Button:create("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_24)

		self.selectBtnList[iter_224_0] = var_224_21

		var_224_21:setPosition(cc.p(444, 22))
		var_224_15:addChild(var_224_21)
		var_224_21:addTouchEventListener(function(arg_228_0, arg_228_1)
			if arg_228_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:updateSelectBtn(iter_224_0)

			var_224_14 = iter_224_1.id

			var_224_10:setString((iter_224_1.discount1 == -1 or nil) and "0")
		end)
	end

	if arg_224_1.couponList[1] then
		self:updateSelectBtn(1)

		var_224_14 = arg_224_1.couponList[1].id

		var_224_10:setString((arg_224_1.couponList[1].discount1 == -1 or nil) and "0")
	end

	var_224_11:addTouchEventListener(function(arg_229_0, arg_229_1)
		if arg_229_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_224_1.ShopSliderCallback then
			arg_224_1.ShopSliderCallback(arg_229_0, arg_229_1, function()
				var_224_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_224_0:runAction(cc.RemoveSelf:create())
				end)))
				var_224_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_224_0:runAction(cc.RemoveSelf:create())
				end)))
			end, var_224_14)
		end
	end)
end

function MarketLayer:updateSelectBtn(arg_233_1)
	for iter_233_0, iter_233_1 in pairs(self.selectBtnList) do
		if iter_233_0 == arg_233_1 then
			iter_233_1:loadTextures("public/button/coupon_select.png", "public/button/coupon_select.png", "public/button/coupon_select.png", var_0_24)
		else
			iter_233_1:loadTextures("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_24)
		end
	end
end

function MarketLayer:buyBachelorGift(arg_234_1)
	local var_234_0 = ccui.Layout:create()

	var_234_0:setTouchEnabled(true)
	var_234_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_234_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_234_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_234_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_234_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_234_0:setBackGroundColorOpacity(180)
	self:addChild(var_234_0, 10)

	local var_234_1 = ccui.ImageView:create(var_0_50[var_0_40[self.selectedType]] .. arg_234_1.itemid .. var_0_51[var_0_40[self.selectedType]])

	var_234_1:setPosition(cc.p(var_234_0:getContentSize().width / 2, var_234_0:getContentSize().height / 2 + 100))
	var_234_0:addChild(var_234_1)

	local var_234_2 = ccui.ImageView:create(arg_234_1.slidecost.costtype, var_0_24)

	var_234_2:setPositionX(var_234_1:getContentSize().width / 2 - 20)
	var_234_2:setPositionY(-130)
	var_234_1:addChild(var_234_2)

	local var_234_3 = cc.Label:createWithTTF(arg_234_1.slidecost.costnum, FONT_DES, 23)

	var_234_3:setAnchorPoint(cc.p(0, 0.5))
	var_234_3:setPositionX(var_234_2:getPositionX() + var_234_2:getContentSize().width / 2 + 5)
	var_234_3:setPositionY(var_234_2:getPositionY())
	var_234_1:addChild(var_234_3)

	local var_234_4 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_24)
	local var_234_5 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)

	var_234_5:setColor(cc.c3b(12, 12, 12))
	var_234_4:setPosition(cc.p(var_234_1:getContentSize().width / 2, -70))
	var_234_5:setPosition(cc.p(var_234_4:getContentSize().width / 2, var_234_4:getContentSize().height / 2 - 5))
	var_234_4:addChild(var_234_5)
	var_234_1:addChild(var_234_4)
	var_234_1:setScaleY(0)
	var_234_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_234_0:addTouchEventListener(function(arg_235_0, arg_235_1)
		var_234_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_234_0:runAction(cc.RemoveSelf:create())
		end)))
	end)

	local var_234_6 = ccui.ImageView:create("public/panelbg/coupon_select_bg.png", var_0_24)

	var_234_6:setScaleY(#arg_234_1.couponList + 1)
	var_234_4:setPositionY(var_234_4:getPositionY() - var_234_6:getContentSize().height * (#arg_234_1.couponList + 1) + 20)
	var_234_6:setAnchorPoint(cc.p(0.5, 0))
	var_234_6:setPosition(cc.p(282, var_234_4:getPositionY() + 40))
	var_234_1:addChild(var_234_6, 1)
	var_234_2:setPositionY(var_234_2:getPositionY() - var_234_6:getContentSize().height * (#arg_234_1.couponList + 1) + 18)
	var_234_3:setPositionY(var_234_2:getPositionY())

	self.selectBtnList = {}

	local var_234_7

	for iter_234_0, iter_234_1 in pairs(arg_234_1.couponList) do
		local var_234_8 = ccui.ImageView:create("public/panelbg/coupon_sprite_bg.png", var_0_24)

		var_234_8:setScaleY(1 / (#arg_234_1.couponList + 1))
		var_234_8:setPosition(cc.p(250, var_234_6:getContentSize().height - 13.5 - 18 * (iter_234_0 - 1)))
		var_234_6:addChild(var_234_8)

		local var_234_9 = ccui.ImageView:create("equipment/" .. iter_234_1.id .. ".png")

		var_234_9:setScale(0.3)
		var_234_9:setPosition(cc.p(40, 23))
		var_234_8:addChild(var_234_9)

		local var_234_10 = cc.Label:createWithTTF(iter_234_1.name .. " X" .. item_manager:getItemNumber(iter_234_1.id), FONT_NAME, 20)

		var_234_10:setColor(cc.c3b(188, 206, 226))
		var_234_10:setAnchorPoint(cc.p(0, 0.5))
		var_234_10:setPosition(cc.p(80, 23))
		var_234_8:addChild(var_234_10)

		local var_234_11 = ccui.ImageView:create(arg_234_1.slidecost.costtype, var_0_24)

		var_234_11:setPosition(cc.p(355, 23))
		var_234_8:addChild(var_234_11)

		local var_234_12 = "-" .. iter_234_1.discount1

		if iter_234_1.discount1 == -1 then
			var_234_12 = L_FREE_BUY

			var_234_11:setVisible(false)

			iter_234_1.discount1 = arg_234_1.slidecost.costnum
		end

		local var_234_13 = cc.Label:createWithTTF(var_234_12, FONT_NAME, 24)

		var_234_13:setColor(cc.c3b(188, 206, 226))
		var_234_13:setPosition(cc.p(400, 23))
		var_234_8:addChild(var_234_13)

		local var_234_14 = ccui.Button:create("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_24)

		self.selectBtnList[iter_234_0] = var_234_14

		var_234_14:setPosition(cc.p(444, 22))
		var_234_8:addChild(var_234_14)
		var_234_14:addTouchEventListener(function(arg_237_0, arg_237_1)
			if arg_237_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:updateSelectBtn(iter_234_0)

			var_234_7 = iter_234_1.id

			var_234_3:setString(arg_234_1.slidecost.costnum - iter_234_1.discount1)
		end)
	end

	if arg_234_1.couponList[1] then
		self:updateSelectBtn(1)

		var_234_7 = arg_234_1.couponList[1].id

		var_234_3:setString(arg_234_1.slidecost.costnum - arg_234_1.couponList[1].discount1)
	end

	var_234_4:addTouchEventListener(function(arg_238_0, arg_238_1)
		if arg_238_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_234_1.ShopSliderCallback then
			arg_234_1.ShopSliderCallback(arg_238_0, arg_238_1, function()
				var_234_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_234_0:runAction(cc.RemoveSelf:create())
				end)))
			end, var_234_7)
		end
	end)
end

function MarketLayer:initCouponsBtn()
	self.btnCoupons = ccui.Button:create("MarketLayer/btn_coupons.png", "MarketLayer/btn_coupons.png", "MarketLayer/btn_coupons.png", var_0_24)

	self.btnCoupons:setPosition(cc.p(560, ccui.Helper:seekWidgetByName(self.rootlayer, "button_back"):getPositionY() + 68 - GameDisplay.fix_y))
	self.rootlayer:addChild(self.btnCoupons, 9999)
	self:updatebtnCoupons()
end

function MarketLayer:updatebtnCoupons()
	if self.btnCoupons then
		self.btnCoupons:setVisible(self.selectedType == "1-15301")
	end
end

function MarketLayer.registerCommityEventListener(arg_243_0)
	activity_manager:registerEventListener("CommunityMainLayer", activity_manager.activityEventId.COMMUNITY_KICK_NOTICE, function(arg_244_0)
		if arg_244_0.familyid and arg_244_0.familyid == community_system_manager:getCurfamilyid() and arg_243_0.selectedType and arg_243_0.selectedType == "1-123000" then
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips7)
			LayerManager:switchShowLayer("MainLayer")
		end
	end)
end

function MarketLayer:updateFilterIcon()
	if not self.filter_layout then
		self.filter_layout = ccui.Layout:create()

		self.filter_layout:setAnchorPoint(0, 0)
		self.rootlayer:addChild(self.filter_layout, 10)
		self.filter_layout:setPosition(self.costList:getPositionX() + 80, self.costList:getPositionY())

		self.filter_btn = ccui.Button:create("MarketLayer/filter_btn.png", "MarketLayer/filter_btn.png", "MarketLayer/filter_btn.png", var_0_24)

		self.filter_btn:setAnchorPoint(0, 0)
		self.filter_layout:addChild(self.filter_btn)
		self.filter_btn:setPosition(90, -5)
		self.filter_btn:setTouchEnabled(true)

		local var_245_0 = ccui.ImageView:create("MarketLayer/skin_show_model_bg.png", var_0_24)

		var_245_0:setPosition(10, 5)
		var_245_0:setAnchorPoint(0, 0)
		self.filter_layout:addChild(var_245_0)
		var_245_0:setTouchEnabled(true)

		self.skin_small_icon = ccui.ImageView:create("MarketLayer/skin_show_off.png", var_0_24)

		self.skin_small_icon:setPosition(0, 0)
		self.skin_small_icon:setAnchorPoint(0, 0)
		var_245_0:addChild(self.skin_small_icon, 1)

		self.skin_big_icon = ccui.ImageView:create("MarketLayer/skin_show_off.png", var_0_24)

		self.skin_big_icon:setPosition(34, 0)
		self.skin_big_icon:setAnchorPoint(0, 0)
		var_245_0:addChild(self.skin_big_icon, 1)

		local var_245_1 = cc.Label:createWithTTF("小", FONT_DES, 20)

		var_245_1:setPosition(17, 14)
		var_245_0:addChild(var_245_1, 2)

		local var_245_2 = cc.Label:createWithTTF("大", FONT_DES, 20)

		var_245_2:setPosition(51, 14)
		var_245_0:addChild(var_245_2, 2)
		var_245_0:addTouchEventListener(function(arg_246_0, arg_246_1)
			if arg_246_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_0_60 = 1 - var_0_60

			self:updateTableView()
			self:updateFilterIcon()
		end)
		self.filter_btn:addTouchEventListener(function(arg_247_0, arg_247_1)
			if arg_247_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:updateFilterPop()
		end)
	end

	self.filter_layout:setVisible(self.can_filter)
	self.skin_small_icon:setVisible(var_0_60 ~= var_0_55)
	self.skin_big_icon:setVisible(var_0_60 ~= var_0_54)
	self:updateFilterBtn()
end

function MarketLayer:createTableViewSmall()
	local var_248_0 = cc.TableView:create(var_0_68)

	var_248_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_248_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_248_0:setAnchorPoint(cc.p(0, 0))
	var_248_0:setPosition(60 - 10, 61 - GameDisplay.fix_y)
	var_248_0:setDelegate()
	self.rootlayer:addChild(var_248_0)

	var_248_0.type = self.selectedType
	var_248_0.node_number = self.node_number
	var_248_0.listData = self:filter_skin(self.listData, var_0_59)

	local var_248_1 = var_248_0.node_number == 4 and 62 or 90

	var_248_0.can_filter = self.can_filter

	var_248_0:registerScriptHandler(function(arg_250_0, arg_250_1)
		if arg_250_1 == self:getListLen(var_248_0) - 1 then
			return var_0_48.width, var_0_48.height + 60
		else
			return var_0_48.width, var_0_48.height
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_248_0:registerScriptHandler(function(arg_249_0, arg_249_1)
		local var_249_0 = arg_249_0:dequeueCell()
		local var_249_1 = 0

		if arg_249_1 == self:getListLen(var_248_0) - 1 then
			var_249_1 = 260
			var_0_66 = 280
		else
			var_249_1 = 200
			var_0_66 = 280
		end

		if var_249_0 then
			var_0_65 = var_0_65 + 1

			for iter_249_0 = 1, var_248_0.node_number do
				local var_249_3 = var_249_0:getChildByName(iter_249_0)

				var_249_3:setPosition(cc.p(var_248_1 + iter_249_0 * var_0_48.offsetx + (iter_249_0 - 1) * var_249_3:getContentSize().width, var_0_48.height / 2 + var_0_48.offsety + ((arg_249_1 == self:getListLen(var_248_0) - 1 or nil) and 60)))

				var_249_3.type = var_248_0.type

				if var_248_0.listData[var_248_0.node_number * arg_249_1 + iter_249_0] then
					var_249_3:setVisible(true)
					var_249_3:update(arg_249_0.listData[var_248_0.node_number * arg_249_1 + iter_249_0])
				else
					var_249_3:setVisible(false)
				end

				if not self.startRunOutAni and var_248_0.isRunAnim and var_248_0.node_number == 1 and var_248_0.node_number * (arg_249_1 + iter_249_0) <= 4 then
					var_249_0:getChildByName(iter_249_0):setOpacity(0)
					var_249_0:getChildByName(iter_249_0):runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_249_1), cc.FadeIn:create(0.1)))
				elseif not self.startRunOutAni and var_248_0.isRunAnim and var_248_0.node_number == 3 and var_248_0.node_number * arg_249_1 + iter_249_0 <= 15 then
					var_249_0:getChildByName(iter_249_0):setOpacity(0)
					var_249_0:getChildByName(iter_249_0):runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_249_1), cc.FadeIn:create(0.1)))
				elseif var_249_0:getChildByName(iter_249_0):getOpacity() < 255 then
					var_249_0:getChildByName(iter_249_0):setOpacity(255)
				end
			end

			if math.ceil(var_0_68.height / var_249_1) <= var_0_65 then
				var_248_0.isRunAnim = false
				var_0_65 = 0
			end
		else
			var_249_0 = cc.TableViewCell:create()

			for iter_249_1 = 1, var_248_0.node_number do
				local var_249_5 = ShopSprite:createWithName("shopSpriteType" .. var_0_40[var_248_0.type], true)
				local var_249_6 = math.ceil(var_0_68.height / var_249_1)

				var_249_5:setPosition(cc.p(var_248_1 + iter_249_1 * var_0_48.offsetx + (iter_249_1 - 1) * var_249_5:getContentSize().width, var_0_48.height / 2 + var_0_48.offsety + ((arg_249_1 == self:getListLen(var_248_0) - 1 or nil) and 60)))

				if arg_249_1 < var_249_6 then
					var_249_5:setOpacity(0)
					var_249_5:runAction(cc.Sequence:create(cc.DelayTime:create((arg_249_1 + 1) * (LAYER_INTO_TIME / var_249_6)), cc.FadeIn:create(LAYER_INTO_TIME / var_249_6)))
				else
					var_249_5:setOpacity(255)
				end

				var_249_5.type = var_248_0.type

				var_249_5:setName(iter_249_1)
				var_249_0:addChild(var_249_5)

				if var_248_0.listData[var_248_0.node_number * arg_249_1 + iter_249_1] then
					var_249_5:setVisible(true)
					var_249_5:update(arg_249_0.listData[var_248_0.node_number * arg_249_1 + iter_249_1])
				else
					var_249_5:setVisible(false)
				end
			end
		end

		if self.startRunOutAni then
			self.startIndex = self.startIndex or arg_249_1

			local var_249_7 = LAYER_OUT_TIME / math.ceil(var_0_68.height / var_249_1)

			for iter_249_2 = 1, var_248_0.node_number do
				var_249_0:getChildByName(iter_249_2):runAction(cc.Sequence:create(cc.DelayTime:create((arg_249_1 - self.startIndex + 1) * var_249_7), cc.FadeOut:create(var_249_7)))
			end
		end

		return var_249_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_248_0:registerScriptHandler(function(arg_251_0, arg_251_1)
		return (self:getListLen(var_248_0))
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)

	return var_248_0
end

function MarketLayer:filter_skin(arg_252_1, arg_252_2)
	if not self.can_filter then
		return arg_252_1
	end

	local var_252_0 = {}

	for iter_252_0, iter_252_1 in ipairs(arg_252_1) do
		local var_252_1 = true

		var_252_1 = (arg_252_2.have ~= var_0_56 or false) and (arg_252_2.have == var_0_57 and not iter_252_1.haveSuit or iter_252_1.haveSuit)

		local var_252_2 = true

		if #arg_252_2.attrs == 0 then
			var_252_2 = false
		else
			for iter_252_2, iter_252_3 in ipairs(iter_252_1.fliterAttrs) do
				if var_0_61(arg_252_2.attrs, iter_252_3) then
					var_252_2 = false
				end
			end
		end

		if not var_252_1 and not var_252_2 then
			table.insert(var_252_0, iter_252_1)
		end
	end

	return var_252_0
end

function MarketLayer:updateFilterPop()
	if not self.filterPop then
		local var_253_0 = ccui.Layout:create()

		self.filterPop = var_253_0

		var_253_0:setContentSize(cc.size(640, 1600))
		var_253_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_253_0:setCascadeOpacityEnabled(false)
		var_253_0:setBackGroundColorOpacity(182)
		var_253_0:setAnchorPoint(0.5, 0.5)
		var_253_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_253_0:setPosition(GameDisplay.cx, GameDisplay.cy)
		var_253_0:setTouchEnabled(true)
		var_253_0:setLocalZOrder(1000)
		var_253_0:setVisible(true)
		var_253_0:addTouchEventListener(function(arg_254_0, arg_254_1)
			if arg_254_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_253_0:setVisible(false)
		end)
		self.rootlayer:addChild(var_253_0)

		local var_253_1 = ccui.Layout:create()

		var_253_1:setContentSize(640, 0)
		var_253_1:setAnchorPoint(0.5, 0.5)
		var_253_1:setPosition(320, 800)
		var_253_0:addChild(var_253_1)

		local var_253_2 = cc.Label:createWithTTF("筛选", FONT_DES, 28)

		var_253_2:setAnchorPoint(0, 0)
		var_253_2:setPosition(50, 200)
		var_253_1:addChild(var_253_2)

		self.filterPop.st_btns = {}

		for iter_253_0, iter_253_1 in ipairs({
			{
				name = "全部学员",
				pos = cc.p(50, 130),
				stat = var_0_56
			},
			{
				name = "已拥有学员",
				pos = cc.p(240, 130),
				stat = var_0_57
			},
			{
				name = "未拥有学员",
				pos = cc.p(430, 130),
				stat = var_0_58
			}
		}) do
			local var_253_3 = ccui.Button:create("MarketLayer/filter_btn_off.png", "MarketLayer/filter_btn_off.png", "MarketLayer/filter_btn_off.png", var_0_24)

			var_253_3:setAnchorPoint(0, 0)
			var_253_3:setPosition(iter_253_1.pos)
			var_253_1:addChild(var_253_3)
			var_253_3:addTouchEventListener(function(arg_255_0, arg_255_1)
				if arg_255_1 ~= ccui.TouchEventType.ended then
					return
				end

				if iter_253_1.stat == var_0_59.have then
					return
				end

				var_0_59.have = iter_253_1.stat

				self:updateTableView()
				self:updateFilterPop()
				self:updateFilterBtn()
			end)

			local var_253_4 = cc.Label:createWithTTF(iter_253_1.name, FONT_DES, 22)

			var_253_3:addChild(var_253_4)
			var_253_4:setPosition(81, 24)
			table.insert(self.filterPop.st_btns, var_253_3)
		end

		local var_253_5 = cc.Label:createWithTTF("筛选", FONT_DES, 28)

		var_253_5:setAnchorPoint(0, 0)
		var_253_5:setPosition(50, 60)
		var_253_1:addChild(var_253_5)

		local var_253_7 = 50
		local var_253_8 = 0

		self.filterPop.attrs_btns = {}

		for iter_253_2, iter_253_3 in ipairs(SHOP_SKIN_ATTR_ID) do
			local var_253_9 = ccui.Button:create("MarketLayer/filter_btn_off.png", "MarketLayer/filter_btn_off.png", "MarketLayer/filter_btn_off.png", var_0_24)

			var_253_9:setAnchorPoint(0, 0)
			var_253_9:setPosition(var_253_7, var_253_8)
			var_253_1:addChild(var_253_9)
			var_253_9:addTouchEventListener(function(arg_256_0, arg_256_1)
				if arg_256_1 ~= ccui.TouchEventType.ended then
					return
				end

				if var_0_61(var_0_59.attrs, iter_253_3) then
					var_0_62(var_0_59.attrs, iter_253_3)
				else
					table.insert(var_0_59.attrs, iter_253_3)
				end

				self:updateTableView()
				self:updateFilterPop()
				self:updateFilterBtn()
			end)

			local var_253_10 = cc.Label:createWithTTF(SHOP_SKIN_ATTR_NAME[iter_253_2], FONT_DES, 22)

			var_253_9:addChild(var_253_10)
			var_253_10:setPosition(81, 24)

			var_253_9.attr = iter_253_3

			table.insert(self.filterPop.attrs_btns, var_253_9)

			if iter_253_2 % 3 == 0 then
				var_253_7 = 50
				var_253_8 = var_253_8 - 70
			else
				var_253_7 = var_253_7 + 190
			end
		end
	end

	if not self.can_filter then
		self.filterPop:setVisible(false)

		return
	end

	self.filterPop:setVisible(true)

	for iter_253_4, iter_253_5 in ipairs(self.filterPop.st_btns) do
		if iter_253_4 == var_0_59.have then
			iter_253_5:loadTextures("MarketLayer/filter_btn_on.png", "MarketLayer/filter_btn_on.png", "MarketLayer/filter_btn_on.png", var_0_24)
		else
			iter_253_5:loadTextures("MarketLayer/filter_btn_off.png", "MarketLayer/filter_btn_off.png", "MarketLayer/filter_btn_off.png", var_0_24)
		end
	end

	for iter_253_6, iter_253_7 in ipairs(self.filterPop.attrs_btns) do
		if var_0_61(var_0_59.attrs, iter_253_7.attr) then
			iter_253_7:loadTextures("MarketLayer/filter_btn_on.png", "MarketLayer/filter_btn_on.png", "MarketLayer/filter_btn_on.png", var_0_24)
		else
			iter_253_7:loadTextures("MarketLayer/filter_btn_off.png", "MarketLayer/filter_btn_off.png", "MarketLayer/filter_btn_off.png", var_0_24)
		end
	end
end

function MarketLayer:updateFilterBtn()
	if var_0_59.have ~= var_0_56 or #var_0_59.attrs ~= 0 then
		self.filter_btn:loadTextures("MarketLayer/filtered_btn.png", "MarketLayer/filtered_btn.png", "MarketLayer/filtered_btn.png", var_0_24)
	else
		self.filter_btn:loadTextures("MarketLayer/filter_btn.png", "MarketLayer/filter_btn.png", "MarketLayer/filter_btn.png", var_0_24)
	end
end
