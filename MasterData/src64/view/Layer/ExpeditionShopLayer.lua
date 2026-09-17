local var_0_0 = config._DEBUG and 0 or 1
local network = require("network.network")
local expedition_shop_data = require("data.expedition_shop_data")
local total_skill_data = require("data.total_skill_data")
local expedition_manager = require("controller.expedition_manager")
local item_manager = require("controller.item_manager")

ExpeditionShopLayer = class("ExpeditionShopLayer", function()
	return cc.Layer:create()
end)

function ExpeditionShopLayer.create(arg_2_0, ...)
	local var_2_0 = ExpeditionShopLayer.new()

	var_2_0:initBg(...)

	return var_2_0
end

function ExpeditionShopLayer:initBg(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	self:addChild(var_3_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)

		local var_4_0 = ccui.ImageView:create("mainScenebg/expedition_shop_bg.png")

		var_4_0:setAnchorPoint(cc.p(0, 0))
		var_4_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_4_0, -1)
		self:onLoad(arg_3_1)
		var_3_0:setOpacity(102)
		var_3_0:setTouchEnabled(false)
	end)
end

function ExpeditionShopLayer:fullscreen()
	self.root:setPosition(cc.p(0, -GameDisplay.fix_y))

	self.titleNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.titleNode:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.titleNode:setPositionY(self.titleNode.full_posY)

	self.btn_back.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btn_back:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_back:setPositionY(self.btn_back.full_posY)
end

function ExpeditionShopLayer:onLoad(arg_6_1)
	self.closeCallback = arg_6_1.closeCallback
	expedition_manager.updateShopCoinNumCallback = self.updateCoinNum

	print("ExpeditionShopLayer")

	self.scheduler = cc.Director:getInstance():getScheduler()
	self.root = ccui.Layout:create()

	self.root:setTouchEnabled(true)
	self:addChild(self.root)
	self.root:setContentSize(GameDisplay.width, GameDisplay.height)

	self.titleNode = ccui.ImageView:create("ExpeditionLayer/title_shop.png", var_0_0)

	self.titleNode:setPosition(cc.p(GameDisplay.width / 2, 1080))
	self.root:addChild(self.titleNode)

	function self.onBtnBackCallback(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onDestory()
		self:runAction(cc.RemoveSelf:create())

		if self.closeCallback and type(self.closeCallback) == "function" then
			self.closeCallback()
		end
	end

	self.btn_back = BottomBtnList:create(self.onBtnBackCallback, nil, "ExpeditionLayer/di.png", {
		img = "ExpeditionLayer/btn_back.png",
		pos = cc.p(56, 35)
	})

	self.btn_back:setName("btn_back")
	self.root:addChild(self.btn_back, 99)

	local var_6_0 = ccui.ImageView:create("ExpeditionLayer/tili_bg.png", var_0_0)

	var_6_0:setAnchorPoint(cc.p(0, 0))
	var_6_0:setPosition(cc.p(350, 10))

	local var_6_1 = ccui.Text:create(L_EXPEDITION_LAYER[5], FONT_DES, 24)

	var_6_1:setAnchorPoint(cc.p(0, 0))
	var_6_1:setPosition(cc.p(60, 13))
	var_6_1:setColor(cc.c3b(187, 187, 187))
	var_6_0:addChild(var_6_1)

	local var_6_2 = ccui.Text:create("", FONT_DES, 24)

	var_6_2:setAnchorPoint(cc.p(0, 0))
	var_6_2:setPosition(cc.p(180, 13))
	var_6_2:setColor(cc.c3b(199, 253, 255))

	self.coinNumNode = var_6_2

	var_6_0:addChild(var_6_2)
	self.btn_back:addChild(var_6_0)

	self.itemNode = ccui.Layout:create()

	self.itemNode:setContentSize(cc.size(184, 299))
	self.itemNode:setVisible(false)
	self:addChild(self.itemNode)

	local var_6_3 = ccui.Button:create("", "", "", var_0_0)

	var_6_3:setName("bg")
	var_6_3:setAnchorPoint(cc.p(0, 0))
	var_6_3:setPosition(cc.p(0, 20))
	self.itemNode:addChild(var_6_3)

	local var_6_4 = ccui.ImageView:create("ExpeditionLayer/shop_icon_bg.png", var_0_0)

	var_6_4:setName("iconBg")
	var_6_4:setAnchorPoint(cc.p(0, 0))
	var_6_4:setPosition(cc.p(15, -15))
	var_6_3:addChild(var_6_4)

	local var_6_5 = ccui.ImageView:create("ExpeditionLayer/shop_icon.png", var_0_0)

	var_6_5:setName("icon")
	var_6_5:setAnchorPoint(cc.p(0, 0))
	var_6_5:setPosition(cc.p(42, -20))
	var_6_3:addChild(var_6_5)

	local var_6_6 = ccui.ImageView:create("ExpeditionLayer/shop_icon.png", var_0_0)

	var_6_6:setName("item")
	var_6_6:setAnchorPoint(cc.p(0, 0))
	var_6_6:setPosition(cc.p(42, 160))
	var_6_3:addChild(var_6_6)

	local var_6_7 = ccui.Text:create("", FONT_DES, 24)

	var_6_7:setName("price")
	var_6_7:setAnchorPoint(cc.p(0, 0))
	var_6_7:setPosition(cc.p(87, -10))
	var_6_3:addChild(var_6_7)

	local var_6_8 = ccui.Text:create("", FONT_DES, 24)

	var_6_8:setName("title")
	var_6_8:setPosition(cc.p(90, 130))
	var_6_3:addChild(var_6_8)

	local var_6_9 = ccui.Text:create("", FONT_DES, 18)

	var_6_9:setName("des")
	var_6_9:setContentSize(cc.size(150, 200))
	var_6_9:ignoreContentAdaptWithSize(false)
	var_6_9:setPosition(cc.p(20, 90))
	var_6_9:setAnchorPoint(cc.p(0, 1))
	var_6_3:addChild(var_6_9)
	self:init(function()
		self:initItemNum()
		self:initUI()
	end)
	self:fullscreen()
end

function ExpeditionShopLayer:onDestory()
	if self.usualScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.usualScheduler)

		self.usualScheduler = nil
	end

	expedition_manager.updateShopCoinNumCallback = nil
end

function ExpeditionShopLayer.init(arg_10_0, arg_10_1)
	network:rpc("get_expedition_shop_info", nil, function(arg_11_0)
		if arg_11_0.result == 1 then
			arg_10_0:initInfo(arg_11_0.itemlist)

			if type(arg_10_1) == "function" then
				arg_10_1()
			end
		end
	end)
end

function ExpeditionShopLayer:initInfo(arg_12_1)
	self.shopInfo = {}

	for iter_12_0, iter_12_1 in pairs(expedition_shop_data) do
		local var_12_0 = 0
		local var_12_1 = 0

		for iter_12_2, iter_12_3 in pairs(arg_12_1) do
			if iter_12_3.id == iter_12_1.id then
				var_12_0 = iter_12_3.havenum
				var_12_1 = iter_12_3.limitnum

				break
			end
		end

		local var_12_2 = ""

		if iter_12_1.type == EXPEDITION.SHOP_ITEMTYPE.SKILL then
			assert(total_skill_data[iter_12_1.skill_id], string.format("curSkillData is nil, the skillid is %d", iter_12_1.skill_id))

			var_12_2 = "ExpeditionLayer/skill_bg" .. total_skill_data[iter_12_1.skill_id].skill_rare .. ".png"
		elseif iter_12_1.type == EXPEDITION.SHOP_ITEMTYPE.REBORN then
			var_12_2 = "ExpeditionLayer/no_skill_bg.png"
		end

		local var_12_3 = {
			index = #self.shopInfo + 1,
			id = iter_12_1.itemid,
			name = iter_12_1.name,
			type = iter_12_1.type,
			price = iter_12_1.price,
			limitNum = var_12_1,
			haveBuy = var_12_0
		}

		var_12_3.iconPath = "skill_new/skill/" .. (iter_12_1.item_icon or 22822) .. ".png"
		var_12_3.bgPath = var_12_2
		var_12_3.item_info = iter_12_1.item_info

		table.insert(self.shopInfo, var_12_3)
	end

	table.sort(self.shopInfo, function(arg_13_0, arg_13_1)
		return arg_13_0.id < arg_13_1.id
	end)
end

function ExpeditionShopLayer:initUI()
	if self.shopInfo == nil then
		return
	end

	local var_14_0 = self.shopInfo
	local var_14_1 = 184
	local var_14_2 = 320

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()

		self.listViewNode = nil
	end

	self.listViewNode = self:getTableView(var_14_0, math.ceil(#self.shopInfo / 3), function(arg_15_0)
		return var_14_1, var_14_2
	end, cc.size(640, GameDisplay.height - 120 - 70), function(arg_16_0, arg_16_1)
		local var_16_1 = arg_16_0:dequeueCell()

		if var_16_1 == nil then
			var_16_1 = cc.TableViewCell:new()
		end

		local var_16_2 = var_16_1:getChildByName("item")

		if var_16_2 then
			var_16_2:removeFromParent()
		end

		local var_16_4 = self:getMainItemNode()

		var_16_1:addChild(var_16_4)
		var_16_4:setName("item")
		var_16_4:setVisible(true)

		for iter_16_0 = 1, 3 do
			local var_16_5 = var_14_0[arg_16_1 * 3 + iter_16_0]
			local var_16_6 = var_16_4:getChildByName("item" .. iter_16_0)

			if var_14_0[arg_16_1 * 3 + iter_16_0] then
				var_16_6:setVisible(true)

				local var_16_7 = var_16_6:getChildByName("bg")
				local var_16_8 = var_16_7:getChildByName("price")
				local var_16_9 = var_16_7:getChildByName("item")
				local var_16_10 = var_16_7:getChildByName("title")
				local var_16_11 = var_16_7:getChildByName("des")

				var_16_7:loadTextures(var_14_0[arg_16_1 * 3 + iter_16_0].bgPath, var_14_0[arg_16_1 * 3 + iter_16_0].bgPath, var_14_0[arg_16_1 * 3 + iter_16_0].bgPath, var_0_0)
				var_16_8:setString("x" .. var_14_0[arg_16_1 * 3 + iter_16_0].price)
				var_16_9:loadTexture(var_14_0[arg_16_1 * 3 + iter_16_0].iconPath, var_0_0)
				var_16_7:setSwallowTouches(false)
				var_16_7:addTouchEventListener(function(arg_17_0, arg_17_1)
					if arg_17_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_17_0:getTouchBeganPosition().y - arg_17_0:getTouchEndPosition().y) > 50 then
						return
					end

					self:openConfirmpanel(var_16_5)
				end)
				var_16_10:setString(var_14_0[arg_16_1 * 3 + iter_16_0].name)
				var_16_11:setString(var_14_0[arg_16_1 * 3 + iter_16_0].item_info)
			else
				var_16_6:setVisible(false)
			end
		end

		return var_16_1
	end, function(arg_18_0, arg_18_1)
		return
	end)

	self.listViewNode:setPosition(cc.p(0, 70))
	self.listViewNode:setVisible(true)
	self.root:addChild(self.listViewNode)
end

function ExpeditionShopLayer.openConfirmpanel(arg_19_0, arg_19_1)
	LayerManager:pushInLayer("PopDoLayer", {
		labels = {
			title = L_ADD_ARENA_TIMES.button,
			des = string.format(L_EXPEDITION_LAYER[3], arg_19_1.price, arg_19_1.name),
			button = L_BATTLEPASS_BUY.button
		},
		surecallback = function()
			network:rpc("expedition_shop_buy_item", {
				itemid = arg_19_1.id
			}, function(arg_21_0)
				if arg_21_0.result == 1 then
					item_manager:deleteItem(expedition_manager:getCoinList(true).id, arg_19_1.price)
					arg_19_0:updateCoinNum()
					expedition_manager:useItemEffect(arg_19_1)
					arg_19_0:playBuyItemEffect(arg_19_1)
					AnalyticManager.expedition_shop_buy_item({
						itemid = arg_19_1.id
					})

					if type(callback) == "function" then
						callback()
					end
				else
					global_ShowBlockWords(L_EXPEDITION_LAYER[4])
				end
			end)
		end
	})
end

function ExpeditionShopLayer:playBuyItemEffect(arg_22_1)
	if arg_22_1 == nil then
		return
	end

	if self.root:getChildByName("effect") then
		self.root:getChildByName("effect"):removeFromParent()
	end

	local var_22_0 = ccui.Layout:create()

	var_22_0:setContentSize(cc.size(640, 1136 + GameDisplay.fix_y))
	var_22_0:setName("effect")
	var_22_0:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2))
	self.root:addChild(var_22_0, 999)
	var_22_0:addChild((ccui.ImageView:create("mainScenebg/expedition_shop_bg.png")))
	var_22_0:setTouchEnabled(true)

	local var_22_1 = -GameDisplay.width / 2
	local var_22_2 = -GameDisplay.height / 2
	local var_22_3

	if arg_22_1.type == EXPEDITION.SHOP_ITEMTYPE.SKILL then
		var_22_3 = cc.p(380 + var_22_1, 120 + var_22_2)
	elseif arg_22_1.type == EXPEDITION.SHOP_ITEMTYPE.REBORN then
		var_22_3 = cc.p(480 + var_22_1, 120 + var_22_2)
	end

	local var_22_4 = self.listViewNode:cellAtIndex(math.ceil(arg_22_1.index / 3) - 1):getChildByName("item"):getChildByName("item" .. (arg_22_1.index - 1) % 3 + 1):getChildByName("bg")
	local var_22_5 = var_22_4:getChildByName("item")
	local var_22_6 = var_22_5:clone()

	var_22_6:setPosition(cc.p(var_22_5.x + var_22_1, var_22_4:convertToWorldSpace(cc.p(var_22_6:getPositionX(), var_22_6:getPositionY())).y + var_22_2))
	var_22_6:runAction((cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_22_3.x, var_22_3.y)), cc.RemoveSelf:create())))
	var_22_0:addChild(var_22_6, 999)

	local var_22_7 = ccui.ImageView:create("ExpeditionLayer/btn_team.png", var_0_0)
	local var_22_8 = ccui.ImageView:create("ExpeditionLayer/btn_skill_profit.png", var_0_0)
	local var_22_9 = ccui.ImageView:create("ExpeditionLayer/btn_shop.png", var_0_0)

	var_22_7:setPosition(cc.p(499 + var_22_1, 120 + var_22_2))
	var_22_8:setPosition(cc.p(405 + var_22_1, 120 + var_22_2))
	var_22_9:setPosition(cc.p(583 + var_22_1, 120 + var_22_2))
	var_22_0:addChild(var_22_7)
	var_22_0:addChild(var_22_8)
	var_22_0:addChild(var_22_9)
	self:usualSchedulerWithCallback(function()
		var_22_0:runAction(cc.RemoveSelf:create())
	end, 0.5)
end

function ExpeditionShopLayer:getMainItemNode()
	local var_24_0 = ccui.Layout:create()

	var_24_0:setTouchEnabled(false)
	var_24_0:setContentSize(cc.size(640, 299))
	var_24_0:setName("item")

	for iter_24_0 = 1, 3 do
		local var_24_1 = self.itemNode:clone()

		var_24_1:setVisible(true)
		var_24_1:setName("item" .. iter_24_0)
		var_24_0:addChild(var_24_1)
		var_24_1:setPositionX(-180 + 205 * iter_24_0)
	end

	return var_24_0
end

function ExpeditionShopLayer.getTableView(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6)
	local var_25_0 = cc.TableView:create(arg_25_4)

	var_25_0:setVisible(false)
	var_25_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_25_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_25_0:setDelegate()
	var_25_0:registerScriptHandler(function(arg_26_0)
		return arg_25_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_25_0:registerScriptHandler(function(arg_27_0)
		arg_25_0:scrollViewDidScroll(arg_27_0)
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_25_0:registerScriptHandler(function(arg_28_0, arg_28_1)
		arg_25_6(arg_28_0, arg_28_1)
	end, cc.TABLECELL_TOUCHED)
	var_25_0:registerScriptHandler(function(arg_29_0, arg_29_1)
		local var_29_0 = 100
		local var_29_1 = 100

		if type(arg_25_3) == "function" then
			var_29_0, var_29_1 = arg_25_3(arg_29_1)
		end

		return var_29_0, var_29_1
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_25_0:registerScriptHandler(function(arg_30_0, arg_30_1)
		return arg_25_5(arg_30_0, arg_30_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_25_0:reloadData()
	var_25_0:setAnchorPoint(cc.p(0, 1))

	return var_25_0
end

function ExpeditionShopLayer.scrollViewDidScroll(arg_31_0, arg_31_1)
	print("scrollViewDidScroll")
end

function ExpeditionShopLayer:lateUpdate(arg_32_1)
	if self.cinemaScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

		self.cinemaScheduler = nil
	end

	self.cinemaScheduler = self.scheduler:scheduleScriptFunc(function()
		if self.cinemaScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

			self.cinemaScheduler = nil
		end

		if type(arg_32_1) == "function" then
			arg_32_1()
		end
	end, 0, false)
end

function ExpeditionShopLayer:updateCoinNum()
	expedition_manager:updateCoinNum()
	self:initItemNum()
end

function ExpeditionShopLayer:initItemNum()
	local var_35_0 = expedition_manager:getCoinList(true)

	if var_35_0 == nil then
		return
	end

	self.coinNumNode:setString(var_35_0.num)
end

function ExpeditionShopLayer:usualSchedulerWithCallback(arg_36_1, arg_36_2)
	arg_36_2 = arg_36_2 or 1

	if self.usualScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.usualScheduler)
	end

	self.usualScheduler = self.scheduler:scheduleScriptFunc(function()
		if type(arg_36_1) == "function" then
			arg_36_1()
		end

		if self.usualScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.usualScheduler)
		end
	end, arg_36_2, false)
end
