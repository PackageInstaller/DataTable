AirPlaneLayer = class("AirPlaneLayer", function()
	return cc.Layer:create()
end)

local activity_manager = require("controller.activity_manager")
local component_manager = require("controller.component_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local task_data = require("data.task_data")
local var_0_7 = config._DEBUG and 0 or 1
local var_0_8 = "AirPlaneLayer/"
local var_0_9 = 0
local var_0_10 = 1
local var_0_11 = {
	[0] = "title.png",
	"title2.png"
}
local var_0_12 = {
	[0] = "exchange_btn.png",
	"ARtask_btn.png"
}

local function var_0_13(arg_2_0)
	local var_2_0 = -1
	local var_2_1 = require("data.horcrux_data")[arg_2_0].horcruxt

	for iter_2_0, iter_2_1 in pairs((require("data.photofile_HelpGirl_data"))) do
		if arg_2_0 == iter_2_1.item_id then
			var_2_0 = iter_2_0

			break
		end
	end

	if var_2_0 == -1 then
		return
	end

	LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
		id = var_2_0,
		itemid = arg_2_0
	})
end

local function var_0_14(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = drop_manager:getDropMsg(arg_3_0)
	local var_3_1
	local var_3_2

	if not arg_3_2 then
		if var_3_0.gold ~= 0 then
			var_3_1 = "gold"
			var_3_2 = var_3_0.gold
		elseif var_3_0.diamond ~= 0 then
			var_3_1 = "diamond"
			var_3_2 = var_3_0.diamond
		elseif var_3_0.equips then
			for iter_3_0, iter_3_1 in pairs(var_3_0.equips) do
				var_3_1 = iter_3_1.dropid
				var_3_2 = iter_3_1.dropNum
			end
		end
	else
		var_3_1 = arg_3_2
		var_3_2 = arg_3_3
	end

	local var_3_4 = ccui.ImageView:create()

	if item_data[var_3_1].bag_item_type == kITEM_SKIN then
		var_3_4:loadTexture("roleimage/role1/" .. model_data[item_data[var_3_1].model].cute_role .. ".png")
		var_3_4:setScale(0.3)
	elseif item_data[var_3_1].bag_item_type == kITEM_HORCRUX then
		local var_3_5 = drop_manager:getAllDropsNotMerge(arg_3_0)[1].item_attr
		local var_3_6 = ccui.Layout:create()

		var_3_6:setName("starsPanel")
		var_3_6:setScale(1.75)
		var_3_6:setPositionY(58)
		var_3_6:setPositionX(200)
		var_3_4:addChild(var_3_6, 5)

		local var_3_7 = 0

		if var_3_5 then
			for iter_3_2, iter_3_3 in var_3_5:gmatch("([^&]+)=([^&]+)") do
				if iter_3_2 == "star" then
					var_3_7 = tonumber(iter_3_3)
				end
			end
		end

		for iter_3_4 = 1, var_3_7 do
			local var_3_8

			if config._DEBUG then
				var_3_8 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_3_8:setPosition(25, (iter_3_4 - 1) * 24 - 30)
			var_3_6:addChild(var_3_8)
		end

		var_3_4:loadTexture("equipment/" .. item_data[var_3_1].image_id .. ".png")
		var_3_4:setScale(0.3)
	elseif item_data[var_3_1].bag_item_type == kITEM_COMPONENT then
		var_3_4:removeFromParent()

		var_3_4 = nil
		var_3_4 = component_manager:create_component_icon(var_3_1)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		var_3_4:setScale(0.75)
	elseif item_data[var_3_1].image_id then
		var_3_4:loadTexture("equipment/" .. item_data[var_3_1].image_id .. ".png")
		var_3_4:setScale(0.75)
	end

	var_3_4:setTouchEnabled(arg_3_1)
	var_3_4:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[var_3_1].bag_item_type == kITEM_HORCRUX then
			var_0_13(var_3_1)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_3_1
			})
		end
	end)

	return var_3_4, var_3_2, name
end

function AirPlaneLayer.create(arg_5_0, arg_5_1)
	local var_5_0 = AirPlaneLayer.new()

	var_5_0:init(arg_5_1)

	return var_5_0
end

function AirPlaneLayer:init(arg_6_1)
	self.activityId = 735
	self.layerName = "AirPlaneLayer_" .. self.activityId

	print((activity_manager:getActivityObj(735)))

	self.panelType = var_0_9

	self:initUI()
	activity_manager:enter_airplane_get_conf(self.activityId)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
		end
	end)
	self:registerEventListener()
	self:addTouchEvent()
end

function AirPlaneLayer:initUI()
	self.rootLayer = ccui.ImageView:create(var_0_8 .. "bg.png", var_0_7)

	self:addChild(self.rootLayer)
	self.rootLayer:setAnchorPoint(0, 0)
	self.rootLayer:setPosition(0, 0)
	self.rootLayer:setPositionY(-GameDisplay.fix_y)

	self.bannerBg = ccui.ImageView:create(var_0_8 .. "banner_bg.png", var_0_7)

	self.rootLayer:addChild(self.bannerBg)
	self.bannerBg:setAnchorPoint(0, 1)
	self.bannerBg:setPosition(0, 0)
	self.bannerBg:setPositionY(GameDisplay.height)

	self.title = ccui.Button:create(var_0_8 .. "title.png", nil, var_0_8 .. "title.png", var_0_7)

	self.rootLayer:addChild(self.title)
	self.title:setAnchorPoint(0, 1)
	self.title:setPosition(0, GameDisplay.height)
	self.title:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "airplane"
		})
	end)

	self.task_btn = ccui.Button:create(var_0_8 .. "task_btn.png", nil, var_0_8 .. "task_btn.png", var_0_7)

	self.rootLayer:addChild(self.task_btn, 10)
	self.task_btn:setAnchorPoint(1, 1)
	self.task_btn:setPosition(GameDisplay.width - 20, GameDisplay.height - GameDisplay.fix_y * 0.8 - 20)

	self.gift_btn = ccui.Button:create(var_0_8 .. "gift_btn.png", nil, var_0_8 .. "gift_btn.png", var_0_7)

	self.rootLayer:addChild(self.gift_btn, 10)
	self.gift_btn:setAnchorPoint(1, 1)
	self.gift_btn:setPosition(GameDisplay.width - 20, GameDisplay.height - 120 - GameDisplay.fix_y * 0.8)

	self.exchange_btn = ccui.Button:create(var_0_8 .. "exchange_btn.png", nil, var_0_8 .. "exchange_btn.png", var_0_7)

	self.rootLayer:addChild(self.exchange_btn, 10)
	self.exchange_btn:setAnchorPoint(1, 0)
	self.exchange_btn:setPosition(GameDisplay.width - 20, 10)

	self.return_btn = ccui.Button:create(var_0_8 .. "return_btn.png", nil, var_0_8 .. "return_btn.png", var_0_7)

	self.rootLayer:addChild(self.return_btn, 10)
	self.return_btn:setAnchorPoint(0, 0)
	self.return_btn:setPosition(20, 10)
	self:initTaskPanel()
	self:initShopPanel()
	self.shopPanel:setVisible(false)
end

function AirPlaneLayer:initTaskPanel()
	self.taskPanel = ccui.Layout:create()

	self.taskPanel:setAnchorPoint(cc.p(0, 1))
	self.taskPanel:setContentSize(cc.size(GameDisplay.width, 660 + 1.8 * GameDisplay.fix_y))
	self.taskPanel:setPosition(cc.p(0, self.bannerBg:getPositionY() - self.bannerBg:getContentSize().height))
	self.rootLayer:addChild(self.taskPanel)

	local var_10_0 = ccui.ImageView:create(var_0_8 .. "task_turns_bg.png", var_0_7)

	var_10_0:setAnchorPoint(0, 1)
	var_10_0:setPosition(20, self.taskPanel:getContentSize().height - 10)
	self.taskPanel:addChild(var_10_0)

	self.task_turns_label = cc.Label:createWithTTF("", FONT_DES, 30)

	self.task_turns_label:setColor(cc.c3b(138, 109, 86))
	var_10_0:addChild(self.task_turns_label)
	self.task_turns_label:setAnchorPoint(0, 0.5)
	self.task_turns_label:setPosition(20, 30)

	self.task_next_turn_btn = ccui.Button:create(var_0_8 .. "next_turn_btn.png", nil, var_0_8 .. "next_turn_btn.png", var_0_7)

	self.task_next_turn_btn:setAnchorPoint(0, 0)
	self.task_next_turn_btn:setPositionX(300)
	self.taskPanel:addChild(self.task_next_turn_btn)

	self.one_key_reward_btn = ccui.Button:create(var_0_8 .. "one_key_reward_btn.png", nil, var_0_8 .. "one_key_reward_btn.png", var_0_7)

	self.one_key_reward_btn:setAnchorPoint(0, 0)
	self.one_key_reward_btn:setPositionX(470)
	self.taskPanel:addChild(self.one_key_reward_btn)
end

function AirPlaneLayer:updateTask()
	if self.taksView then
		self.taksView:reloadData()

		return
	end

	self.taksView = cc.TableView:create(cc.size(GameDisplay.width, self.taskPanel:getContentSize().height - 160))

	self.taksView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taksView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taksView:setAnchorPoint(cc.p(0, 0))
	self.taksView:setPosition(10, 100)
	self.taksView:setDelegate()
	self.taskPanel:addChild(self.taksView)
	self.taksView:registerScriptHandler(function(arg_13_0, arg_13_1)
		return 600, 140
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taksView:registerScriptHandler(function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:dequeueCell()

		if not var_12_0 then
			var_12_0 = cc.TableViewCell:create()

			local var_12_2 = self:createTaskSprite(self.taskList[arg_12_1 + 1], arg_12_1 + 1)

			var_12_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_12_2:setPosition(cc.p(GameDisplay.width / 2 - 10, 65))
			var_12_0:addChild(var_12_2)
		else
			self:updateTaskSprite(var_12_0:getChildByTag(100), self.taskList[arg_12_1 + 1], arg_12_1 + 1)
		end

		return var_12_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taksView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taksView:reloadData()
end

function AirPlaneLayer.createTaskSprite(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = ccui.ImageView:create(var_0_8 .. "task_bottom.png", var_0_7)

	var_15_0:setTag(100)

	local var_15_1 = ccui.ListView:create()

	var_15_1:setDirection(ccui.ScrollViewDir.horizontal)
	var_15_1:setContentSize(cc.size(270, 80))
	var_15_1:setPosition(cc.p(175, 25))
	var_15_0:addChild(var_15_1)
	var_15_1:setBackGroundColorOpacity(100)
	var_15_1:setBounceEnabled(true)
	var_15_1:setName("droplist")

	for iter_15_0, iter_15_1 in pairs(drop_manager:getDropMsg(arg_15_1.drop).equips) do
		local var_15_2 = ccui.Layout:create()

		var_15_2:setContentSize(cc.size(80, 80))

		local var_15_3 = ccui.ImageView:create(var_0_8 .. "task_reward_bg.png", var_0_7)

		var_15_3:setPosition(cc.p(50, 40))

		local var_15_4, var_15_5 = var_0_14(arg_15_1.drop, true, iter_15_1.dropid, iter_15_1.dropNum)

		var_15_4:setPosition(30, 45)
		var_15_4:setScale(var_15_4:getScale() * 0.5)
		var_15_3:addChild(var_15_4)
		var_15_2:addChild(var_15_3)

		local var_15_6 = ccui.ImageView:create(var_0_8 .. "task_reward_labelbg.png", var_0_7)

		var_15_6:setAnchorPoint(0, 0)
		var_15_3:addChild(var_15_6)

		local var_15_7 = cc.Label:createWithTTF("x" .. var_15_5, FONT_DES, 14)

		var_15_7:setPosition(32, 10)
		var_15_6:addChild(var_15_7)
		var_15_1:pushBackCustomItem(var_15_2)
	end

	local var_15_8 = var_0_8 .. "btn_goto.png"

	if arg_15_1.status >= 1 then
		var_15_8 = var_0_8 .. "btn_got.png"
	elseif arg_15_1.percent >= 100 then
		var_15_8 = var_0_8 .. "btn_get_reward.png"
	end

	local var_15_9 = ccui.Button:create(var_15_8, nil, var_15_8, var_0_7)

	var_15_9:setPosition(cc.p(548, 66))
	var_15_9:setName("btn")
	var_15_0:addChild(var_15_9)
	var_15_9:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_15_1.status >= 1 then
			return
		end

		if arg_15_1.percent >= 100 then
			activity_manager:getArtTaskReward(arg_15_0.activityId, arg_15_1.taskid)
		else
			arg_15_0:taskJumpTo(arg_15_1.jump)
		end
	end)

	local var_15_11 = cc.Label:createWithTTF((arg_15_1.percent >= 0 or nil) and (arg_15_1.finished > arg_15_1.need and string.format("%s/%s", arg_15_1.need, arg_15_1.need) or string.format("%s/%s", arg_15_1.finished, arg_15_1.need)), FONT_TITLE, 28)

	var_15_11:setAnchorPoint(cc.p(0.5, 0.5))
	var_15_11:setPosition(cc.p(105, 70))
	var_15_11:setName("percent")
	var_15_11:setVisible(arg_15_1.percent >= 0)
	var_15_11:setColor(cc.c3b(109, 83, 62))
	var_15_0:addChild(var_15_11)

	local var_15_12 = cc.Label:createWithTTF("银币", FONT_NAME, 24)

	var_15_12:setAnchorPoint(cc.p(0.5, 0.5))
	var_15_12:setPosition(cc.p(105, 40))
	var_15_12:setName("yinbi")
	var_15_12:setVisible(arg_15_1.percent >= 0)
	var_15_12:setColor(cc.c3b(109, 83, 62))
	var_15_0:addChild(var_15_12)

	return var_15_0
end

function AirPlaneLayer.updateTaskSprite(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_1:setTag(100)

	local var_17_0 = arg_17_1:getChildByName("title")
	local var_17_1 = var_0_8 .. "btn_goto.png"

	if arg_17_2.status >= 1 then
		var_17_1 = var_0_8 .. "btn_got.png"
	elseif arg_17_2.percent >= 100 then
		var_17_1 = var_0_8 .. "btn_get_reward.png"
	end

	arg_17_1:getChildByName("btn"):loadTextures(var_17_1, nil, var_17_1, var_0_7)

	if arg_17_2.percent >= 0 then
		arg_17_1:getChildByName("percent"):setString(arg_17_2.finished > arg_17_2.need and string.format("%s/%s", arg_17_2.need, arg_17_2.need) or string.format("%s/%s", arg_17_2.finished, arg_17_2.need))
	end

	arg_17_1:getChildByName("percent"):setVisible(arg_17_2.percent >= 0)
	arg_17_1:getChildByName("yinbi"):setVisible(arg_17_2.percent >= 0)
	arg_17_1:getChildByName("btn"):addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_17_2.status >= 1 then
			return
		end

		if arg_17_2.percent >= 100 then
			activity_manager:getArtTaskReward(arg_17_0.activityId, arg_17_2.taskid)
		else
			arg_17_0:taskJumpTo(arg_17_2.jump)
		end
	end)

	local var_17_3 = arg_17_1:getChildByName("droplist")

	var_17_3:removeAllChildren()

	for iter_17_0, iter_17_1 in pairs(drop_manager:getDropMsg(arg_17_2.drop).equips) do
		local var_17_4 = ccui.Layout:create()

		var_17_4:setContentSize(cc.size(80, 80))

		local var_17_5 = ccui.ImageView:create(var_0_8 .. "task_reward_bg.png", var_0_7)

		var_17_5:setPosition(cc.p(50, 40))

		local var_17_6, var_17_7 = var_0_14(arg_17_2.drop, true, iter_17_1.dropid, iter_17_1.dropNum)

		var_17_6:setPosition(30, 45)
		var_17_6:setScale(var_17_6:getScale() * 0.5)
		var_17_5:addChild(var_17_6)
		var_17_4:addChild(var_17_5)

		local var_17_8 = ccui.ImageView:create(var_0_8 .. "task_reward_labelbg.png", var_0_7)

		var_17_8:setAnchorPoint(0, 0)
		var_17_5:addChild(var_17_8)

		local var_17_9 = cc.Label:createWithTTF("x" .. var_17_7, FONT_DES, 14)

		var_17_9:setPosition(32, 10)
		var_17_8:addChild(var_17_9)
		var_17_3:pushBackCustomItem(var_17_4)
	end
end

function AirPlaneLayer:initShopPanel()
	self.shopPanel = ccui.ImageView:create(var_0_8 .. "shop_bg.png", var_0_7)

	self.shopPanel:setAnchorPoint(cc.p(0, 1))
	self.shopPanel:setPosition(cc.p(0, self.bannerBg:getPositionY() - self.bannerBg:getContentSize().height))
	self.rootLayer:addChild(self.shopPanel)

	local var_19_0 = ccui.Button:create(var_0_8 .. "key_point_icon.png", nil, var_0_8 .. "key_point_icon.png", var_0_7)

	var_19_0:setAnchorPoint(1, 1)
	var_19_0:setPosition(self.shopPanel:getContentSize().width - 180, self.shopPanel:getContentSize().height - 75)
	self.shopPanel:addChild(var_19_0)
	var_19_0:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopItemLayer", {
			itemid = activity_manager:getAPKeyPoint(self.activityId)
		})
	end)

	self.key_point_label = cc.Label:createWithTTF("9999", FONT_DES, 28)

	self.shopPanel:addChild(self.key_point_label)
	self.key_point_label:setAnchorPoint(0, 0.5)
	self.key_point_label:setPosition(self.shopPanel:getContentSize().width - 160, self.shopPanel:getContentSize().height - 100)

	for iter_19_0, iter_19_1 in ipairs({
		{
			x = 150,
			y = 600
		},
		{
			x = 170,
			y = 730
		},
		{
			x = 330,
			y = 600
		},
		{
			x = 420,
			y = 730
		},
		{
			x = 500,
			y = 600
		}
	}) do
		local var_19_1 = ccui.Button:create(var_0_8 .. "shop" .. iter_19_0 .. "_on.png", nil, var_0_8 .. "shop" .. iter_19_0 .. "_on.png", var_0_7)

		self.shopPanel:addChild(var_19_1)
		var_19_1:setPosition(iter_19_1.x, iter_19_1.y)
		var_19_1:setName("shop_btn" .. iter_19_0)
		var_19_1:addTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:switchShopTurns(iter_19_0)
		end)
	end

	for iter_19_2 = 1, 3 do
		local var_19_2 = ccui.ImageView:create(var_0_8 .. "shop_item_bg.png", var_0_7)

		self.shopPanel:addChild(var_19_2)
		var_19_2:setPosition(100 + 200 * iter_19_2 - 180, 350)
		var_19_2:setName("shop_item_bg" .. iter_19_2)

		local var_19_3 = cc.Label:createWithTTF("魂立方", FONT_DES, 20)

		var_19_2:addChild(var_19_3)
		var_19_3:setAnchorPoint(0.5, 0.5)
		var_19_3:setPosition(80, 255)
		var_19_3:setName("item_name")

		local var_19_4 = ccui.ImageView:create(var_0_8 .. "shop_reward_bg.png", var_0_7)

		var_19_2:addChild(var_19_4)
		var_19_4:setPosition(85, 175)
		var_19_4:setName("item_bg")

		local var_19_5 = ccui.ImageView:create(var_0_8 .. "itemnum_labelbg.png", var_0_7)

		var_19_2:addChild(var_19_5)
		var_19_5:setAnchorPoint(0.5, 0.5)
		var_19_5:setPosition(85, 175)
		var_19_5:setName("labelbg")

		local var_19_6 = cc.Label:createWithTTF("x1", FONT_DES, 24)

		var_19_5:addChild(var_19_6)
		var_19_6:setAnchorPoint(0.5, 0.5)
		var_19_6:setPosition(var_19_5:getContentSize().width / 2, 15)
		var_19_6:setName("itemnum_label")

		local var_19_7 = cc.Label:createWithTTF("限购0/3次", FONT_DES, 20)

		var_19_2:addChild(var_19_7)
		var_19_7:setAnchorPoint(0.5, 0.5)
		var_19_7:setPosition(80, 95)
		var_19_7:setName("limit_label")

		local var_19_8 = ccui.ImageView:create(var_0_8 .. "key_point_bg.png", var_0_7)

		var_19_2:addChild(var_19_8)
		var_19_8:setPosition(80, 48)
		var_19_8:setName("point_bg")

		local var_19_9 = cc.Label:createWithTTF("x9999", FONT_DES, 24)

		var_19_8:addChild(var_19_9)
		var_19_9:setAnchorPoint(0.5, 0.5)
		var_19_9:setPosition(90, 32)
		var_19_9:setName("pointnum")
		var_19_8:setTouchEnabled(true)
		var_19_8:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			activity_manager:buy_airplane_shop(self.activityId, self.now_shopturns, iter_19_2)
		end)
	end
end

function AirPlaneLayer:updateShopPanel(arg_23_1)
	self.now_shopturns = arg_23_1.index or self.now_shopturns or 1

	local var_23_0 = arg_23_1.index <= arg_23_1.shop_turns

	for iter_23_0 = 1, 5 do
		local var_23_1 = self.shopPanel:getChildByName("shop_btn" .. iter_23_0)

		if iter_23_0 <= arg_23_1.shop_turns then
			var_23_1:loadTextures(var_0_8 .. "shop" .. iter_23_0 .. "_on.png", nil, var_0_8 .. "shop" .. iter_23_0 .. "_on.png", var_0_7)
		else
			var_23_1:loadTextures(var_0_8 .. "shop" .. iter_23_0 .. "_off.png", nil, var_0_8 .. "shop" .. iter_23_0 .. "_off.png", var_0_7)
		end

		if iter_23_0 == arg_23_1.index then
			if not self.select_icon then
				self.select_icon = ccui.ImageView:create(var_0_8 .. "select_icon.png", var_0_7)

				self.shopPanel:addChild(self.select_icon)
			end

			self.select_icon:setPosition(var_23_1:getPositionX(), var_23_1:getPositionY() + 66)
		end
	end

	for iter_23_1 = 1, 3 do
		local var_23_2 = self.shopPanel:getChildByName("shop_item_bg" .. iter_23_1)

		if not arg_23_1[iter_23_1].dropid then
			var_23_2:getChildByName("point_bg"):setTouchEnabled(false)

			break
		end

		var_23_2:getChildByName("point_bg"):setTouchEnabled(var_23_0)

		local var_23_3 = var_23_2:getChildByName("item_name")
		local var_23_4 = var_23_2:getChildByName("item_bg")
		local var_23_5 = var_23_2:getChildByName("limit_label")
		local var_23_6 = var_23_2:getChildByName("point_bg"):getChildByName("pointnum")
		local var_23_7 = var_23_2:getChildByName("labelbg"):getChildByName("itemnum_label")

		var_23_4:removeChildByName("sp")

		local var_23_8, var_23_9, var_23_10 = var_0_14(arg_23_1[iter_23_1].dropid, true)

		var_23_8:setName("sp")
		var_23_8:setPosition(var_23_4:getContentSize().width / 2, var_23_4:getContentSize().height / 2 + 10)
		var_23_4:addChild(var_23_8)
		var_23_3:setString(var_23_10)
		var_23_5:setString(string.format("限购 %d/%d 次", arg_23_1[iter_23_1].buy_count or 0, arg_23_1[iter_23_1].limit or 0))
		var_23_6:setString(arg_23_1[iter_23_1].need)
		var_23_7:setString("x" .. var_23_9)
	end

	self.key_point_label:setString(arg_23_1.pointnum)
end

function AirPlaneLayer:updateTaskPanel()
	activity_manager:getActivityObj(self.activityId):getActivityTaskList(nil, function(arg_25_0, arg_25_1)
		if arg_25_0 ~= 1 then
			return
		end

		self.taskList = {}

		for iter_25_0, iter_25_1 in pairs(arg_25_1.list) do
			iter_25_1.name = task_data[iter_25_1.taskid].name
			iter_25_1.task_des = task_data[iter_25_1.taskid].task_des
			iter_25_1.image = task_data[iter_25_1.taskid].image
			iter_25_1.drop = task_data[iter_25_1.taskid].drop
			iter_25_1.jump = task_data[iter_25_1.taskid].jump
			iter_25_1.order = task_data[iter_25_1.taskid].order

			if iter_25_1.status == 1 then
				iter_25_1.percent = -1
			end

			table.insert(self.taskList, iter_25_1)
		end

		table.sort(self.taskList, function(arg_26_0, arg_26_1)
			if arg_26_0.percent == arg_26_1.percent then
				return arg_26_0.order < arg_26_1.order
			else
				return arg_26_0.percent > arg_26_1.percent
			end
		end)
		self:updateTask()
		activity_manager:update_alert(self.activityId, "airplane", arg_25_1.list)
	end, false, nil, "airplane")
	self.task_turns_label:setString(string.format(L_COMMON_AIRPLANE_TEXT[1], activity_manager:getAPTaskTurns(self.activityId), (activity_manager:getAPMaxTaskTurns(self.activityId))))
end

function AirPlaneLayer:switchPanel(arg_27_1)
	if self.panelType == arg_27_1 then
		return
	end

	self.panelType = arg_27_1

	self.taskPanel:setVisible(self.panelType == var_0_9)
	self.shopPanel:setVisible(self.panelType == var_0_10)
	self.title:loadTextures(var_0_8 .. var_0_11[self.panelType], nil, var_0_8 .. var_0_11[self.panelType], var_0_7)
	self.exchange_btn:loadTextures(var_0_8 .. var_0_12[self.panelType], nil, var_0_8 .. var_0_12[self.panelType], var_0_7)

	if arg_27_1 == var_0_9 then
		self:updateTaskPanel()
	else
		activity_manager:updateShopPanelData(self.activityId, 1)
	end
end

function AirPlaneLayer:switchShopTurns(arg_28_1)
	if self.now_shopturns == arg_28_1 then
		return
	end

	activity_manager:updateShopPanelData(self.activityId, arg_28_1)
end

function AirPlaneLayer:addTouchEvent()
	self.exchange_btn:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchPanel(1 - self.panelType)
	end)
	self.task_next_turn_btn:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:go_next_turns_tasks(self.activityId)
	end)
	self.return_btn:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.task_btn:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopCommonTaskLayer", {
			usemodule = "airplane_daily",
			activityId = self.activityId
		})
	end)
	self.one_key_reward_btn:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getActivityObj(self.activityId):getActivityTaskList(nil, function(arg_35_0, arg_35_1)
			if arg_35_0 ~= 1 then
				global_ShowBlockWords(L_COMMON_AIRPLANE_TEXT[2])

				return
			end

			global_gain(arg_35_1)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE)
		end, true, nil, "airplane")
	end)
	self.gift_btn:addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_36_0 = activity_manager:getGiftBuyJump(self.activityId)

		if var_36_0 then
			require("controller.goto_system_manager")
			goto_complete_system({
				jump_to_system = var_36_0 .. "@"
			})
		end
	end)
end

function AirPlaneLayer:registerEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_AIRPLANE_DATA_UPDATE, function(arg_38_0)
		self:updateShopPanel(arg_38_0)
		self:updateKeyPointNum()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_39_0)
		self:updateTaskPanel()
		self:updateKeyPointNum()
		self:updateAlert()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_40_0)
		self:updateKeyPointNum()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_41_0)
		self:updateKeyPointNum()
	end), self)
end

function AirPlaneLayer:updateKeyPointNum()
	self.key_point_label:setString((item_manager:getItemNumber((activity_manager:getAPKeyPoint(self.activityId)))))
end

function AirPlaneLayer:updateAlert()
	local var_43_0 = {
		x = 90,
		y = 100
	}

	activity_manager:getActivityObj(self.activityId):getActivityTaskList(nil, function(arg_44_0, arg_44_1)
		if arg_44_0 ~= 1 then
			return
		end

		for iter_44_0, iter_44_1 in pairs(arg_44_1.list) do
			if iter_44_1.status == 0 and iter_44_1.percent >= 100 then
				global_add_alert_tag(self.task_btn, var_43_0)

				return
			end
		end

		global_remove_alert_tag(self.task_btn)
	end, false, nil, "airplane_daily")
end

function AirPlaneLayer.taskJumpTo(arg_45_0, arg_45_1)
	if arg_45_1 then
		require("controller.goto_system_manager")
		goto_complete_system({
			jump_to_system = arg_45_1
		})
	end
end
