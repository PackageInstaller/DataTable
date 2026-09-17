local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = "SummerTowerSwapLayer/"
local tower_swap_manager = require("controller.tower_swap_manager")
local ObjectPool = require("view.Layer.ObjectPool")
local summerTS_tower_data = require("data.summerTS_tower_data")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local activity_towerswap_conf = require("data.activity_towerswap_conf")
local var_0_8 = {
	"seashell_",
	"waterJug_",
	"gold_",
	"sandShovels_",
	"watermelon_"
}
local var_0_9 = 6
local var_0_10 = 6
local var_0_11 = 80
local var_0_14 = 930
local var_0_15 = 95
local var_0_16 = 80
local var_0_17 = 100
local var_0_18 = 1140
local var_0_19 = 1
local var_0_20 = 10
local var_0_21 = 20
local var_0_22 = 30
local var_0_24 = 10
local var_0_25 = 20
local var_0_26 = 0
local var_0_27 = 1
local var_0_28 = 2
local var_0_29 = 3

local function var_0_30(arg_1_0, arg_1_1)
	local var_1_0 = {
		x = arg_1_1.x - arg_1_0.x,
		y = arg_1_1.y - arg_1_0.y
	}

	return math.atan2(var_1_0.y, var_1_0.x) * 180 / math.pi
end

local var_0_32 = require("view.Layer.ObjectPool"):new()

function var_0_32:getObjectByMyType(arg_3_1, arg_3_2)
	local var_3_0 = self:getObject(arg_3_1)

	if var_3_0 then
		return var_3_0
	else
		local var_3_1 = arg_3_2:create(arg_3_1)

		var_3_1.type = arg_3_1

		self:createObject(var_3_1)
	end

	return self:getObject(arg_3_1)
end

function var_0_32:clearAllActiveObject()
	for iter_4_0, iter_4_1 in pairs(self.activePool) do
		iter_4_1.isActive = false

		iter_4_1:setVisible(false)

		if iter_4_1.initAttribute then
			iter_4_1:initAttribute()
		end
	end

	self.activePool = {}
end

SummerTowerSwapLayer = class("SummerTowerSwapLayer", function()
	return ccui.Layout:create()
end)

function SummerTowerSwapLayer.initObjsPool(arg_6_0, arg_6_1)
	arg_6_0.towersPool = var_0_32:new()
	arg_6_0.monstersPool = var_0_32:new()
	arg_6_0.bulletsPool = var_0_32:new()
end

function SummerTowerSwapLayer.create(arg_7_0, arg_7_1)
	local var_7_0 = SummerTowerSwapLayer.new()

	var_7_0:init(arg_7_1)

	return var_7_0
end

function SummerTowerSwapLayer:init(arg_8_1)
	print_lua_table(arg_8_1)

	self.activityId = arg_8_1.activityId

	tower_swap_manager:registeredUIRef(self)
	tower_swap_manager:initData({
		activityId = self.activityId,
		callback = function()
			for iter_9_0 = 1, var_0_9 do
				for iter_9_1 = 1, var_0_10 do
					tower_swap_manager:registeredTowersInfo(iter_9_0, iter_9_1, "positionX", var_0_11)
					tower_swap_manager:registeredTowersInfo(iter_9_0, iter_9_1, "positionY", var_0_14)
				end
			end
		end
	})
	self:initUI()
	self:initObjsPool()
	self:updateUI()
	self:registerScriptHandler(function(arg_10_0)
		if arg_10_0 == "exit" then
			tower_swap_manager:release()
		end
	end)

	if config._DEBUG then
		hx_print("GM指令")

		local var_8_0 = ccui.Button:create("public/button/public_button_red.png", nil, "public/button/public_button_red.png", var_0_0)
		local var_8_1 = cc.Label:createWithTTF("GM指令", FONT_NAME, 28)

		var_8_1:setPosition(cc.p(var_8_0:getContentSize().width / 2, var_8_0:getContentSize().height / 2))
		var_8_0:addChild(var_8_1)
		var_8_0:setPosition(500, GameDisplay.height - 70 - GameDisplay.fix_y)
		self.rootlayer:addChild(var_8_0, 9999)
		var_8_0:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:popGMLayer()
		end)
	end
end

function SummerTowerSwapLayer:initUI()
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)

	self.bg = ccui.ImageView:create(var_0_1 .. "bg.png", var_0_0)

	self.rootlayer:addChild(self.bg, var_0_19)
	self.bg:setPosition(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y - 40)

	local var_12_0 = ccui.Button:create(var_0_1 .. "title.png", nil, var_0_1 .. "title.png", var_0_0)

	self.rootlayer:addChild(var_12_0, var_0_24)
	var_12_0:setAnchorPoint(0, 1)
	var_12_0:setPosition(0, GameDisplay.height - GameDisplay.fix_y - 30)
	var_12_0:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "Activity_guard_" .. self.activityId
		})
	end)

	local var_12_1 = ccui.ImageView:create(var_0_1 .. "gold_bg.png", var_0_0)

	self.rootlayer:addChild(var_12_1, var_0_24)
	var_12_1:setAnchorPoint(0.5, 1)
	var_12_1:setPosition(GameDisplay.width / 2 + 200, var_12_0:getPositionY() - 70)

	local var_12_2 = ccui.ImageView:create(var_0_1 .. "total_score_bg.png", var_0_0)

	self.rootlayer:addChild(var_12_2, var_0_24)
	var_12_2:setAnchorPoint(0.5, 1)
	var_12_2:setPosition(GameDisplay.width / 2 + 180, var_12_0:getPositionY() - 130)

	local var_12_3 = ccui.ImageView:create(var_0_1 .. "levelBg.png", var_0_0)

	self.rootlayer:addChild(var_12_3, var_0_24)
	var_12_3:setAnchorPoint(0.5, 1)
	var_12_3:setPosition(GameDisplay.width / 2 + 230, var_12_0:getPositionY() - 180)

	local var_12_4 = ccui.ImageView:create(var_0_1 .. "stepsBg.png", var_0_0)

	self.rootlayer:addChild(var_12_4, var_0_24)
	var_12_4:setAnchorPoint(0.5, 1)
	var_12_4:setPosition(GameDisplay.width / 2 - 130, var_12_3:getPositionY() + 20)

	local var_12_5 = ccui.ImageView:create(var_0_1 .. "hpBg.png", var_0_0)

	self.rootlayer:addChild(var_12_5, var_0_24)
	var_12_5:setAnchorPoint(0.5, 1)
	var_12_5:setPosition(GameDisplay.width / 2 + 60, var_12_3:getPositionY() + 20)

	local var_12_6 = ccui.Button:create(var_0_1 .. "revert_btn.png", nil, var_0_1 .. "revert_btn.png", var_0_0)

	self.rootlayer:addChild(var_12_6, var_0_24)
	var_12_6:setAnchorPoint(0.5, 1)
	var_12_6:setPosition(GameDisplay.width / 2 - 260, var_12_3:getPositionY())
	var_12_6:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		tower_swap_manager:revertHandle()
	end)

	local var_12_7 = ccui.ImageView:create(var_0_1 .. "return_bg.png", var_0_0)

	self.rootlayer:addChild(var_12_7, var_0_24)
	var_12_7:setAnchorPoint(0.5, 0)
	var_12_7:setPosition(GameDisplay.width / 2, -GameDisplay.fix_y)

	local var_12_8 = ccui.Button:create(var_0_1 .. "btn_return.png", nil, var_0_1 .. "btn_return.png", var_0_0)

	var_12_7:addChild(var_12_8)
	var_12_8:setAnchorPoint(0, 0)
	var_12_8:setPosition(0, 0)
	var_12_8:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopDoLayer", {
			surecallback = function()
				AnalyticManager.beach_defense_exit({
					ctype = "back",
					day = tower_swap_manager.level,
					score = tower_swap_manager.score
				})
				require("network.network"):rpc("activity_update_towerswap_score", {
					activityid = self.activityId,
					score = tower_swap_manager.score
				}, function(arg_17_0)
					return
				end)
				LayerManager:switchShowLayer("ActivityFightCollectionLayer", {
					activityId = self.activityId
				})
			end,
			labels = {
				titleImage = "title_warorder.png",
				des = "返回仅保留当前关卡的初始状态哦~"
			}
		})
	end)

	self.stepsLabel = cc.Label:createWithTTF("0", FONT_NAME, 22)

	var_12_4:addChild(self.stepsLabel)
	self.stepsLabel:setAnchorPoint(0, 0)
	self.stepsLabel:setPosition(88, 27)
	self.stepsLabel:setColor(cc.c3b(78, 0, 255))

	self.scoreLabel = cc.Label:createWithTTF("总得分：" .. "100000", FONT_NAME, 22)

	var_12_2:addChild(self.scoreLabel)
	self.scoreLabel:setAnchorPoint(0, 0)
	self.scoreLabel:setPosition(60, 18)

	self.hpLayout = ccui.Layout:create()

	self.hpLayout:setPosition(80, 45)
	self.hpLayout:setLayoutType(ccui.LayoutType.HORIZONTAL)
	self.hpLayout:setAnchorPoint(0, 0)
	var_12_5:addChild(self.hpLayout)

	self.levelLabel = cc.Label:createWithTTF("20", FONT_NAME, 22)

	var_12_3:addChild(self.levelLabel)
	self.levelLabel:setAnchorPoint(0, 0)
	self.levelLabel:setPosition(65, 18)

	for iter_12_0 = 1, 5 do
		self.hpLayout:addChild((ccui.ImageView:create(var_0_1 .. "hpItem.png", var_0_0)))
	end

	local var_12_9 = ccui.Button:create(var_0_1 .. "btn_reward.png", nil, var_0_1 .. "btn_reward.png", var_0_0)

	var_12_7:addChild(var_12_9)
	var_12_9:setAnchorPoint(0, 0)
	var_12_9:setPosition(500, 6)
	var_12_9:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSummerTSTaskLayer", {
			activityId = self.activityId
		})
	end)

	local var_12_10 = ccui.Button:create(var_0_1 .. "shop_button.png", nil, var_0_1 .. "shop_button.png", var_0_0)

	var_12_7:addChild(var_12_10)
	var_12_10:setAnchorPoint(0, 0)
	var_12_10:setPosition(350, 6)
	var_12_10:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_19_0 = activity_towerswap_conf[self.activityId]

		if activity_towerswap_conf[self.activityId].shop then
			goto_complete_system({
				jump_to_system = var_19_0.shop
			})
		end
	end)

	if not activity_towerswap_conf[self.activityId].shop then
		var_12_10:setVisible(false)
	end

	local var_12_11 = ccui.Button:create(var_0_1 .. "physical_bg.png", nil, var_0_1 .. "physical_bg.png", var_0_0)

	var_12_7:addChild(var_12_11)
	var_12_11:setAnchorPoint(0, 0)
	var_12_11:setPosition(180, 6)
	var_12_11:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		tower_swap_manager:buyPhysical({
			activityid = self.activityId
		})
	end)

	self.physicalLabel = cc.Label:createWithTTF("5/5", FONT_NAME, 22)

	var_12_11:addChild(self.physicalLabel)
	self.physicalLabel:setPosition(92, 30)
	self.physicalLabel:setColor(cc.c3b(78, 0, 255))

	self.goldLabel = cc.Label:createWithTTF("99999", FONT_NAME, 22)

	var_12_1:addChild(self.goldLabel)
	self.goldLabel:setPosition(110, 38)
	self.goldLabel:setColor(cc.c3b(78, 0, 255))
end

function SummerTowerSwapLayer:initEndPanel()
	if self.exitLayer then
		self.exitLayer:setVisible(true)

		local var_21_0 = self.exitLayer:getChildByName("bg")

		var_21_0:getChildByName("scoreLabel"):setString(tower_swap_manager.score)
		var_21_0:getChildByName("levelLabel"):setString(tower_swap_manager.level)

		return
	end

	local var_21_1 = ccui.Layout:create()

	var_21_1:setContentSize(cc.size(640, 1600))
	var_21_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_21_1:setCascadeOpacityEnabled(false)
	var_21_1:setBackGroundColorOpacity(122)
	var_21_1:setAnchorPoint(0.5, 0.5)
	var_21_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_21_1:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_21_1:setTouchEnabled(true)
	var_21_1:setLocalZOrder(1000)
	var_21_1:setVisible(true)
	self.rootlayer:addChild(var_21_1)

	self.exitLayer = var_21_1

	local var_21_2 = ccui.ImageView:create(var_0_1 .. "endBg.png", var_0_0)

	var_21_1:addChild(var_21_2)
	var_21_2:setPosition(320, 800)
	var_21_2:setName("bg")

	local var_21_3 = cc.Label:createWithTTF(L_HEXA_CUR_LABEL, FONT_NAME, 48)

	var_21_3:setColor(cc.c3b(253, 234, 194))
	var_21_2:addChild(var_21_3)
	var_21_3:setPosition(220, 530)
	var_21_3:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)

	local var_21_4 = cc.Label:createWithTTF(tower_swap_manager.score, FONT_NAME, 40)

	var_21_4:setColor(cc.c3b(255, 255, 255))
	var_21_2:addChild(var_21_4)
	var_21_4:setPosition(400, 530)
	var_21_4:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_21_4:setName("scoreLabel")

	local var_21_5 = cc.Label:createWithTTF("存活天数:", FONT_NAME, 48)

	var_21_5:setColor(cc.c3b(253, 234, 194))
	var_21_2:addChild(var_21_5)
	var_21_5:setPosition(220, 430)
	var_21_5:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)

	local var_21_6 = cc.Label:createWithTTF(tower_swap_manager.level, FONT_NAME, 40)

	var_21_6:setColor(cc.c3b(255, 255, 255))
	var_21_2:addChild(var_21_6)
	var_21_6:setPosition(400, 430)
	var_21_6:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_21_6:setName("levelLabel")

	local var_21_7 = ccui.Button:create(var_0_1 .. "btn_end_return.png", nil, var_0_1 .. "btn_end_return.png", var_0_0)

	var_21_2:addChild(var_21_7)
	var_21_7:setPosition(190, 150)
	var_21_7:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	local var_21_8 = ccui.Button:create(var_0_1 .. "btn_restart.png", nil, var_0_1 .. "btn_restart.png", var_0_0)

	var_21_8:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.towersPool:clearAllActiveObject()
		self.monstersPool:clearAllActiveObject()
		self.bulletsPool:clearAllActiveObject()
		tower_swap_manager:initData({
			activityId = self.activityId,
			callback = function()
				for iter_24_0 = 1, var_0_9 do
					for iter_24_1 = 1, var_0_10 do
						tower_swap_manager:registeredTowersInfo(iter_24_0, iter_24_1, "positionX", var_0_11)
						tower_swap_manager:registeredTowersInfo(iter_24_0, iter_24_1, "positionY", var_0_14)
					end
				end
			end
		})
		self.exitLayer:setVisible(false)
		self.nightMask:setVisible(false)
	end)
	var_21_2:addChild(var_21_8)
	var_21_8:setPosition(450, 150)
end

function SummerTowerSwapLayer:initTowerPanelUI()
	for iter_25_0 = 1, var_0_9 do
		for iter_25_1 = 1, var_0_10 do
			local var_25_0 = self.towersPool:getObjectByMyType(tower_swap_manager.towerPanelInfo[iter_25_0][iter_25_1].InitType, TowerSprite)

			var_25_0:registration(iter_25_0, iter_25_1)
			var_25_0:setPosition(tower_swap_manager.towerPanelInfo[iter_25_0][iter_25_1].positionX, tower_swap_manager.towerPanelInfo[iter_25_0][iter_25_1].positionY)
			var_25_0:setLevel(tower_swap_manager.towerPanelInfo[iter_25_0][iter_25_1].InitLevel)
			var_25_0:setAttribute()
		end
	end
end

function SummerTowerSwapLayer:updateUI()
	self.scoreLabel:setString("总得分：" .. tower_swap_manager.score)
	self.levelLabel:setString(tower_swap_manager.level)
	self.stepsLabel:setString(tower_swap_manager.swapTimes)
	self.physicalLabel:setString(tower_swap_manager.physical .. "/" .. tower_swap_manager.max_physical)
	self.goldLabel:setString(item_manager:getItemNumber(73500001))
	self:updateHp()
end

function SummerTowerSwapLayer:updateHp()
	if self.hpLayout:getChildrenCount() == tower_swap_manager.hp then
		return
	else
		self.hpLayout:removeAllChildren()

		for iter_27_0 = 1, tower_swap_manager.hp do
			self.hpLayout:addChild((ccui.ImageView:create(var_0_1 .. "hpItem.png", var_0_0)))
		end
	end
end

function SummerTowerSwapLayer:initNightTimeMask()
	if self.nightMask then
		self.nightMask:setVisible(true)

		return
	end

	local var_28_0 = ccui.Layout:create()

	var_28_0:setContentSize(cc.size(640, 1600))
	var_28_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_28_0:setCascadeOpacityEnabled(false)
	var_28_0:setBackGroundColorOpacity(100)
	var_28_0:setAnchorPoint(0.5, 0.5)
	var_28_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_28_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_28_0:setTouchEnabled(false)
	var_28_0:setVisible(true)
	self.rootlayer:addChild(var_28_0, var_0_25)

	self.nightMask = var_28_0

	local var_28_1

	if cc.UserDefault:getInstance():getBoolForKey("TowerSwapTwiceSpeed", false) then
		var_28_1 = var_0_1 .. "twice_btn_on.png" or var_0_1 .. "twice_btn_off.png"
	end

	self.twice_speed_btn = ccui.Button:create(var_28_1, nil, var_28_1, var_0_0)

	var_28_0:addChild(self.twice_speed_btn)
	self.twice_speed_btn:setPosition(560, 1040)
	self.twice_speed_btn:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_29_0 = cc.UserDefault:getInstance():getBoolForKey("TowerSwapTwiceSpeed", false)

		cc.UserDefault:getInstance():setBoolForKey("TowerSwapTwiceSpeed", not var_29_0)

		local var_29_1

		if not var_29_0 then
			var_29_1 = var_0_1 .. "twice_btn_on.png" or var_0_1 .. "twice_btn_off.png"
		end

		self.twice_speed_btn:loadTextures(var_29_1, nil, var_29_1, var_0_0)
	end)
end

function SummerTowerSwapLayer:showBossChannelTip()
	if not self.bossChannelTip then
		self.bossChannelTip = ccui.ImageView:create(var_0_1 .. "bossTip.png", var_0_0)

		self.bg:addChild(self.bossChannelTip)
	end

	if tower_swap_manager.level % 10 ~= 0 then
		self.bossChannelTip:setVisible(false)

		return
	end

	local var_30_0 = RoleDefault:getInstance():getIntegerForKey("TSBossChannelIndex", 0)

	if var_30_0 == 0 then
		var_30_0 = math.random(6)

		RoleDefault:getInstance():setIntegerForKey("TSBossChannelIndex", var_30_0)
	end

	tower_swap_manager.bossChannelIndex = var_30_0

	self.bossChannelTip:setPositionX(tower_swap_manager.towerPanelInfo[6][tower_swap_manager.bossChannelIndex].positionX)
	self.bossChannelTip:setPositionY(tower_swap_manager.towerPanelInfo[6][tower_swap_manager.bossChannelIndex].positionY - 150)
	self.bossChannelTip:setVisible(true)
	self.bossChannelTip:runAction((cc.Blink:create(3, 3)))
end

function SummerTowerSwapLayer.updateEndPanel(arg_31_0)
	return
end

function SummerTowerSwapLayer:updateBossHpProgress(arg_32_1)
	if not self.bossHpProgress then
		local var_32_0 = ccui.ImageView:create(var_0_1 .. "hp_bg.png", var_0_0)

		var_32_0:setPosition(cc.p(320, 380))

		local var_32_1 = ccui.Slider:create()

		var_32_1:loadBarTexture(var_0_1 .. "hp_progress_bg.png", var_0_0)
		var_32_1:loadProgressBarTexture(var_0_1 .. "hp_progress_on.png", var_0_0)
		var_32_1:setPosition(cc.p(227, 30))
		var_32_1:setName("progressBar")
		var_32_1:setScaleX(0.9)

		if not self.nightMask then
			return
		end

		self.nightMask:addChild(var_32_0)
		var_32_0:addChild(var_32_1)

		self.bossHpProgress = var_32_0
	end

	self.bossHpProgress:setVisible(true)
	self.bossHpProgress:getChildByName("progressBar"):setPercent(arg_32_1 / (tower_swap_manager.level * 5) * 100)
end

function SummerTowerSwapLayer:hideBossHpProgress()
	if self.bossHpProgress then
		self.bossHpProgress:setVisible(false)
	end
end

function SummerTowerSwapLayer:showGoldChooseEventLayer(arg_34_1, arg_34_2)
	print("showGoldChooseEventLayer")
	print(arg_34_1)

	if not arg_34_1 then
		return
	end

	if not self.goldEventChooseLayer then
		local var_34_0 = ccui.Layout:create()

		var_34_0:setContentSize(cc.size(640, 1600))
		var_34_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_34_0:setCascadeOpacityEnabled(false)
		var_34_0:setBackGroundColorOpacity(122)
		var_34_0:setAnchorPoint(0.5, 0.5)
		var_34_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_34_0:setPosition(GameDisplay.cx, GameDisplay.cy)
		var_34_0:setTouchEnabled(true)
		var_34_0:setLocalZOrder(1000)
		var_34_0:setVisible(true)
		self.rootlayer:addChild(var_34_0)

		self.goldEventChooseLayer = var_34_0

		local var_34_1 = ccui.ImageView:create(var_0_1 .. "role_img.png", var_0_0)

		var_34_0:addChild(var_34_1)
		var_34_1:setAnchorPoint(0, 0)
		var_34_1:setPosition(0, 420)

		local var_34_2 = ccui.ImageView:create(var_0_1 .. "talk_bg.png", var_0_0)

		var_34_0:addChild(var_34_2)
		var_34_2:setAnchorPoint(0, 0)
		var_34_2:setPosition(170, 440)
		var_34_2:setName("textBg")

		local var_34_3 = cc.Label:createWithTTF("", FONT_NAME, 26)

		var_34_0:addChild(var_34_3)
		var_34_3:setAnchorPoint(0, 0)
		var_34_3:setPosition(210, 580)
		var_34_3:setName("text")

		for iter_34_0, iter_34_1 in ipairs(var_0_8) do
			local var_34_4 = ccui.ImageView:create(var_0_1 .. "item_choose.png", var_0_0)

			var_34_4:setTouchEnabled(true)
			var_34_2:addChild(var_34_4)

			local var_34_5 = ccui.ImageView:create(var_0_1 .. "TowerItem/" .. iter_34_1 .. "0.png", var_0_0)

			var_34_5:setPosition(37, 37)
			var_34_4:setName("item_bg_" .. iter_34_0)
			var_34_4:addChild(var_34_5)
			var_34_4:setPosition(0 + 80 * iter_34_0, 80)
		end
	end

	self.goldEventChooseLayer:setVisible(true)
	self.goldEventChooseLayer:getChildByName("text"):setString(({
		[var_0_27] = "班长想要更多哪种道具？",
		[var_0_28] = "班长想要消除哪种道具？"
	})[arg_34_1])

	local var_34_6 = self.goldEventChooseLayer:getChildByName("textBg")

	for iter_34_2, iter_34_3 in ipairs(var_0_8) do
		var_34_6:getChildByName("item_bg_" .. iter_34_2):addTouchEventListener(function(arg_35_0, arg_35_1)
			if arg_35_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_34_2 then
				arg_34_2(iter_34_2)
			end

			self.goldEventChooseLayer:setVisible(false)
		end)
	end
end

local var_0_33 = 0
local var_0_34 = 1
local var_0_35 = 2
local var_0_36 = 3
local var_0_37 = {
	"",
	"shuipao",
	"baoxiang",
	"jianta",
	"dapao"
}
local var_0_38 = {
	0,
	0,
	-30,
	-30,
	-35
}

TowerSprite = class("TowerSprite", function()
	return cc.Node:create()
end)

function TowerSprite.create(arg_37_0, arg_37_1)
	local var_37_0 = TowerSprite.new()

	var_37_0:init(arg_37_1)

	return var_37_0
end

function TowerSprite:init(arg_38_1)
	tower_swap_manager.UIRef.bg:addChild(self, var_0_20)

	self.type = arg_38_1

	for iter_38_0 = 0, 4 do
		if config._DEBUG then
			self["sprite_" .. iter_38_0] = cc.Sprite:create(var_0_1 .. "TowerItem/" .. var_0_8[arg_38_1] .. iter_38_0 .. ".png") or cc.Sprite:createWithSpriteFrameName(var_0_1 .. "TowerItem/" .. var_0_8[arg_38_1] .. iter_38_0 .. ".png")
		end

		self:addChild(self["sprite_" .. iter_38_0])
	end

	self:initAttribute()

	local var_38_1 = ccui.Layout:create()

	var_38_1:setTouchEnabled(true)
	var_38_1:setContentSize(cc.size(var_0_15 - 30, var_0_16 - 30))
	var_38_1:setAnchorPoint(0.5, 0.5)
	var_38_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_38_1:addTouchEventListener(function(arg_39_0, arg_39_1)
		if self.isMoving then
			return
		end

		tower_swap_manager:itemTouchHandle(arg_39_0, arg_39_1, self)
	end)
	self:addChild(var_38_1, 999)

	if var_0_37[self.type] ~= "" then
		self.ani = sp.SkeletonAnimation:create("spine/summerTowerSwap/tower/" .. var_0_37[self.type] .. ".json", "spine/summerTowerSwap/tower/" .. var_0_37[self.type] .. ".atlas", 1)

		self.ani:setPositionY(var_0_38[self.type])
		self.ani:setAnchorPoint(0.5, 0.5)
		self:addChild(self.ani)
		self.ani:setVisible(false)
	end
end

function TowerSprite:setLevel(arg_40_1)
	self.level = arg_40_1

	for iter_40_0 = 0, 4 do
		if iter_40_0 == arg_40_1 then
			self["sprite_" .. iter_40_0]:setVisible(true)
		else
			self["sprite_" .. iter_40_0]:setVisible(false)
		end
	end
end

function TowerSprite:levelUp()
	if self.level < 4 then
		self:MoveToWithCoordinate(self.registrationX, self.registrationY, 3)
	end
end

function TowerSprite:MoveToWithCoordinate(arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	self.isMoving = true
	arg_42_4 = arg_42_4 or 0.5

	local var_42_0 = 2

	if arg_42_3 == 2 then
		tower_swap_manager:addDispelCount()

		if self.ani then
			self.ani:setVisible(false)
		end

		self["sprite_" .. self.level]:setVisible(true)

		local var_42_1 = cc.FadeOut:create(0.2 / var_42_0)
		local var_42_2 = cc.FadeIn:create(0.2 / var_42_0)

		self["sprite_" .. self.level]:runAction(var_42_1)
		self["sprite_" .. self.level]:runAction(cc.Sequence:create(var_42_1, var_42_2, var_42_1, var_42_2, cc.MoveTo:create(arg_42_4 / var_42_0, cc.p(tower_swap_manager.towerPanelInfo[arg_42_1][arg_42_2].positionX - self:getPositionX(), tower_swap_manager.towerPanelInfo[arg_42_1][arg_42_2].positionY - self:getPositionY())), cc.CallFunc:create(function()
			self["sprite_" .. self.level]:setPosition(0, 0)
			self:initAttribute()
			tower_swap_manager.UIRef.towersPool:recycleObject(self)
			tower_swap_manager:completeDispel()

			self.isMoving = false
		end)))
	elseif arg_42_3 == 1 then
		tower_swap_manager:addFallCount()

		if arg_42_5 then
			arg_42_5(arg_42_4)
		end

		self:runAction(cc.Sequence:create(cc.MoveTo:create(arg_42_4, cc.p(tower_swap_manager.towerPanelInfo[arg_42_1][arg_42_2].positionX, tower_swap_manager.towerPanelInfo[arg_42_1][arg_42_2].positionY)), cc.CallFunc:create(function()
			tower_swap_manager:completeFall()

			self.isMoving = false
		end)))
	elseif arg_42_3 == 3 then
		tower_swap_manager:addDispelCount()

		local var_42_3 = cc.FadeOut:create(0.2 / var_42_0)
		local var_42_4 = cc.FadeIn:create(0.2 / var_42_0)

		self["sprite_" .. self.level]:runAction(cc.Sequence:create(var_42_3, var_42_4, var_42_3, var_42_4, cc.FadeIn:create(arg_42_4 / var_42_0), cc.FadeIn:create(0.05), cc.CallFunc:create(function()
			self:setLevel(self.level + 1)
			self:setAttribute()
			tower_swap_manager:completeDispel()

			self.isMoving = false
		end)))
	elseif arg_42_3 == 4 then
		tower_swap_manager:addDispelCount()
		self["sprite_" .. self.level]:setVisible(false)
		self.ani:setVisible(true)
		self.ani:setAnimation(0, self.level, false)
		self.ani:registerSpineEventHandler(function()
			tower_swap_manager.swapTimes = tower_swap_manager.swapTimes + self.stepReward

			tower_swap_manager:updateUIRef()
			self:initAttribute()
			tower_swap_manager.UIRef.towersPool:recycleObject(self)
			tower_swap_manager:completeDispel()

			self.isMoving = false

			self["sprite_" .. self.level]:setVisible(true)
			self.ani:setVisible(false)
		end, SP_ANIMATION_COMPLETE)
	elseif arg_42_3 == 5 then
		self["sprite_" .. self.level]:setVisible(false)
		self.ani:setVisible(true)
		self.ani:setAnimation(0, self.level, false)

		tower_swap_manager.is_special_events = true

		self.ani:registerSpineEventHandler(function()
			tower_swap_manager.swapTimes = tower_swap_manager.swapTimes + self.stepReward

			tower_swap_manager:updateUIRef()

			if arg_42_5 then
				arg_42_5()
			end
		end, SP_ANIMATION_COMPLETE)
	elseif arg_42_3 == 6 then
		if self.ani then
			self.ani:setVisible(false)
		end

		self["sprite_" .. self.level]:setVisible(true)

		local var_42_5 = cc.FadeOut:create(0.2 / var_42_0)
		local var_42_6 = cc.FadeIn:create(0.2 / var_42_0)

		self["sprite_" .. self.level]:runAction(var_42_5)
		self["sprite_" .. self.level]:runAction(cc.Sequence:create(var_42_5, var_42_6, var_42_5, var_42_6, cc.CallFunc:create(function()
			self["sprite_" .. self.level]:setPosition(0, 0)
			self:initAttribute()

			if arg_42_5 then
				arg_42_5()
			end

			self.isMoving = false

			tower_swap_manager.UIRef.towersPool:recycleObject(self)
		end)))
	end
end

function TowerSprite:initAttribute()
	self.isMoving = false
	self.attack = 0
	self.stepReward = 0
	self.slow = 0
	self.level = 0
	self.registrationX = nil
	self.registrationY = nil
	self.levelMoveToX = nil
	self.levelMoveToY = nil
	self._state = var_0_33
	self.attacklist = {}
	self._lastAttack = 0
	self.attackCD = 1
	self._isAttackAni = false

	if self.ani then
		self.ani:setVisible(false)
	end

	self:setLevel(0)
end

function TowerSprite:setAttribute()
	self.attack = summerTS_tower_data[(self.type - 1) * 5 + self.level + 1].damge or 0
	self.stepReward = summerTS_tower_data[(self.type - 1) * 5 + self.level + 1].stepReward or 0
	self.slow = summerTS_tower_data[(self.type - 1) * 5 + self.level + 1].slow or 0
	self.attackCD = summerTS_tower_data[(self.type - 1) * 5 + self.level + 1].attackCD or 0
	self._lastAttack = self.attackCD

	if self.type == 5 then
		self._lastAttack = self.attackCD - math.random(10) * 0.2
	end
end

function TowerSprite:deregistration()
	print(self.registrationX, self.registrationY)

	tower_swap_manager.towerPanelInfo[self.registrationX][self.registrationY].towerItem = nil

	self:MoveToWithCoordinate(self.levelMoveToX or self.registrationX, self.levelMoveToY or self.registrationY, 2, 0.5)
end

function TowerSprite.registration(arg_52_0, arg_52_1, arg_52_2)
	tower_swap_manager:registeredTowersInfo(arg_52_1, arg_52_2, "towerItem", arg_52_0)

	arg_52_0.registrationX = arg_52_1
	arg_52_0.registrationY = arg_52_2
end

function TowerSprite:Homing()
	self:setPosition(tower_swap_manager.towerPanelInfo[self.registrationX][self.registrationY].positionX, tower_swap_manager.towerPanelInfo[self.registrationX][self.registrationY].positionY)
end

function TowerSprite:Swap(arg_54_1, arg_54_2)
	self:registration(arg_54_1, arg_54_2)
	self:setPosition(tower_swap_manager.towerPanelInfo[arg_54_1][arg_54_2].positionX, tower_swap_manager.towerPanelInfo[arg_54_1][arg_54_2].positionY)
end

function TowerSprite:fallDown(arg_55_1)
	tower_swap_manager.towerPanelInfo[self.registrationX][self.registrationY].towerItem = nil

	self:registration(self.registrationX + arg_55_1, self.registrationY)
	self:MoveToWithCoordinate(self.registrationX, self.registrationY, 1)
end

function TowerSprite:fallDownNew(arg_56_1, arg_56_2, arg_56_3)
	self:registration(arg_56_2, arg_56_3)
	self:setPositionX(tower_swap_manager.towerPanelInfo[arg_56_2][arg_56_3].positionX)
	self:setPositionY(tower_swap_manager.towerPanelInfo[1][arg_56_3].positionY + var_0_16 * arg_56_1)
	self.sprite_0:setOpacity(0)
	self:MoveToWithCoordinate(arg_56_2, arg_56_3, 1, nil, function(arg_57_0)
		self.sprite_0:runAction((cc.FadeIn:create(arg_57_0)))
	end)
end

function TowerSprite.setLevelMoveTo(arg_58_0, arg_58_1, arg_58_2)
	arg_58_0.levelMoveToX = arg_58_1
	arg_58_0.levelMoveToY = arg_58_2
end

function TowerSprite:updateFightState(arg_59_1)
	if #tower_swap_manager.liveMonstersPool == 0 then
		self:switchState(var_0_33)

		return
	end

	if self._state == var_0_33 then
		return
	elseif self._state == var_0_34 then
		self:updateCheckEnemy(arg_59_1)
	elseif self._state == var_0_35 then
		self:updateAttack(arg_59_1)
	elseif self._state == var_0_36 then
		-- block empty
	end
end

function TowerSprite:switchState(arg_60_1)
	if self._state == arg_60_1 then
		return
	end

	self._state = arg_60_1

	if arg_60_1 == var_0_33 then
		self["sprite_" .. self.level]:setVisible(true)

		if self.ani then
			self.ani:setVisible(false)
		end

		if self.type == 5 then
			self._lastAttack = self.attackCD - math.random(10) * 0.2
		end
	elseif arg_60_1 == var_0_34 then
		self.attacklist = {}
	end
end

function TowerSprite:updateCheckEnemy(arg_61_1)
	self._lastAttack = self._lastAttack + arg_61_1

	if self.attackCD > self._lastAttack then
		return
	end

	if self.level == 0 or self.type == 3 then
		self:switchState(var_0_36)

		return
	end

	for iter_61_0, iter_61_1 in ipairs(tower_swap_manager.liveMonstersPool) do
		if iter_61_1._state == 1 then
			if self.type == 1 then
				if math.sqrt(math.pow(iter_61_1:getPositionX() - self:getPositionX(), 2) + math.pow(iter_61_1:getPositionY() - self:getPositionY(), 2)) < 0.5 * var_0_15 then
					table.insert(self.attacklist, iter_61_1)
				end
			elseif self.type == 2 then
				if math.abs(iter_61_1:getPositionY() - self:getPositionY()) < var_0_16 * 0.5 then
					table.insert(self.attacklist, iter_61_1)
					self:switchState(var_0_35)

					if iter_61_1:getPositionX() < self:getPositionX() then
						self.ani:setScaleX(-1)
					else
						self.ani:setScaleX(1)
					end

					return
				end
			elseif self.type == 4 then
				if math.sqrt(math.pow(iter_61_1:getPositionX() - self:getPositionX(), 2) + math.pow(iter_61_1:getPositionY() - self:getPositionY(), 2)) < 1.5 * var_0_15 then
					table.insert(self.attacklist, iter_61_1)
					self:switchState(var_0_35)

					return
				end
			elseif self.type == 5 and math.abs(iter_61_1:getPositionX() - self:getPositionX()) < var_0_15 / 2 then
				table.insert(self.attacklist, iter_61_1)
				self:switchState(var_0_35)

				if iter_61_1:getPositionY() > self:getPositionY() then
					self.ani:setScaleY(-1)
					self.ani:setPositionY(-var_0_38[self.type])
				else
					self.ani:setScaleY(1)
					self.ani:setPositionY(var_0_38[self.type])
				end

				return
			end
		end
	end

	if #self.attacklist > 0 then
		self:switchState(var_0_35)
	end
end

function TowerSprite:updateAttack(arg_62_1)
	self._lastAttack = self._lastAttack + arg_62_1

	if self.attackCD > self._lastAttack then
		return
	end

	for iter_62_0, iter_62_1 in ipairs(self.attacklist) do
		if self.type ~= 3 and self.type ~= 1 then
			if not iter_62_1 or iter_62_1._state ~= 1 or not iter_62_1.isActive then
				self:switchState(var_0_34)

				return
			end

			if self._isAttackAni then
				return
			end

			self._lastAttack = 0

			if self.type == 5 or self.type == 2 then
				self._lastAttack = self._lastAttack + math.random(50) * 0.001
			end

			self._isAttackAni = true

			self["sprite_" .. self.level]:setVisible(false)

			iter_62_1.attackLockNum = iter_62_1.attackLockNum + 1

			self.ani:setVisible(true)
			self.ani:setTimeScale(self.attackCD > 0.6 and 1 or 0.6 / self.attackCD)
			self.ani:setAnimation(0, self.level, false)
			self.ani:registerSpineEventHandler(function()
				tower_swap_manager.UIRef.bulletsPool:getObjectByMyType(self.type, SummerTSBullet):setAttribute({
					damage = self.attack,
					px = self:getPositionX(),
					py = self:getPositionY(),
					target = iter_62_1
				})

				self._isAttackAni = false

				self:switchState(var_0_34)
			end, SP_ANIMATION_COMPLETE)

			return
		elseif iter_62_1 and iter_62_1._state == 1 and iter_62_1.isActive then
			iter_62_1.slow = self.slow
		end
	end

	self:switchState(var_0_34)
end

function TowerSprite.updateWaiting(arg_64_0, arg_64_1)
	return
end

function TowerSprite:clickHandle()
	if self.type ~= 3 then
		return
	end

	if self.level == 0 then
		return
	end

	tower_swap_manager:clearRevertArray()

	local var_65_0 = var_0_26

	if math.random(5) == 1 then
		var_65_0 = math.random(3)
	end

	var_65_0 = config._DEBUG and tower_swap_manager.UIRef.gm_gold_event or var_65_0

	if var_65_0 == var_0_26 then
		tower_swap_manager.towerPanelInfo[self.registrationX][self.registrationY].towerItem = nil

		self:MoveToWithCoordinate(nil, nil, 4, nil)
	else
		tower_swap_manager:trigger_gold_special_events(var_65_0, self)
	end
end

function TowerSprite:becomeOther(arg_66_1, arg_66_2, arg_66_3)
	tower_swap_manager.towerPanelInfo[self.registrationX][self.registrationY].towerItem = nil

	local var_66_0 = tower_swap_manager.UIRef.towersPool:getObjectByMyType(arg_66_1, TowerSprite)

	if not var_66_0:getParent() then
		tower_swap_manager.UIRef.bg:addChild(var_66_0)
	end

	var_66_0:registration(self.registrationX, self.registrationY)
	var_66_0:setPositionX(tower_swap_manager.towerPanelInfo[self.registrationX][self.registrationY].positionX)
	var_66_0:setPositionY(tower_swap_manager.towerPanelInfo[self.registrationX][self.registrationY].positionY)

	if arg_66_2 then
		var_66_0:setLevel(arg_66_2)
	end

	var_66_0:setAttribute()
	var_66_0["sprite_" .. var_66_0.level]:setVisible(false)

	if arg_66_3 then
		tower_swap_manager:addBecomeCount()
	end

	self:MoveToWithCoordinate(nil, nil, 6, nil, function()
		var_66_0["sprite_" .. var_66_0.level]:setVisible(true)
		var_66_0:setVisible(true)

		if arg_66_3 then
			tower_swap_manager:completeBecome()
		end
	end)
end

local var_0_39 = 0
local var_0_40 = 1
local var_0_41 = 2
local var_0_42 = 3
local var_0_43 = 1
local var_0_44 = 0

SummerTSMonster = class("SummerTSMonster", function()
	return cc.Node:create()
end)

function SummerTSMonster.create(arg_69_0, arg_69_1)
	local var_69_0 = SummerTSMonster.new()

	var_69_0:init(arg_69_1)

	return var_69_0
end

function SummerTSMonster:init(arg_70_1)
	self.type = arg_70_1

	self:createAni(arg_70_1)
	self:switchState(var_0_39)
end

function SummerTSMonster:registered(arg_71_1, arg_71_2, arg_71_3)
	self.ani:setVisible(true)
	self.aniDie:setVisible(false)
	self:setAttribute()
	self:InitPosition(tower_swap_manager:registLiveMonster(self), arg_71_1, arg_71_2, arg_71_3)
	self:switchState(var_0_40)
end

function SummerTSMonster:InitPosition(arg_72_1, arg_72_2, arg_72_3, arg_72_4)
	if arg_72_2 then
		self:setPositionX(arg_72_3 + math.random(-35, 35))
		self:setPositionY(arg_72_4 + math.random(-35, 35))
	else
		self:setPositionX(tower_swap_manager.towerPanelInfo[1][(self.type == var_0_43 or nil) and (tower_swap_manager.bossChannelIndex or math.random(6))].positionX)
		self:setPositionY(var_0_17 - arg_72_1 * 10)
	end
end

function SummerTSMonster:createAni(arg_73_1)
	self.ani = sp.SkeletonAnimation:create("spine/summerTowerSwap/monster/" .. (self.type == var_0_43 and "da" or "xiao") .. ".json", "spine/summerTowerSwap/monster/" .. (self.type == var_0_43 and "da" or "xiao") .. ".atlas", 1)

	self:addChild(self.ani)

	self.aniDie = sp.SkeletonAnimation:create("spine/summerTowerSwap/monster/" .. "siwang.json", "spine/summerTowerSwap/monster/" .. "siwang.atlas", 1)

	self:addChild(self.aniDie)
	tower_swap_manager.UIRef.bg:addChild(self, var_0_21)
	self:setScale(self.type == var_0_43 and 1 or 0.3)
end

function SummerTSMonster:setAttribute()
	self._state = var_0_39

	if self.type == var_0_43 then
		self.hp = tower_swap_manager.level * 5 or 5
	end

	self.dieAniEnd = false
	self.slow = 1
	self.speed = 60
	self.attackLockNum = 0
end

function SummerTSMonster:updateFightState(arg_75_1)
	if self.type == var_0_43 then
		tower_swap_manager.UIRef:updateBossHpProgress(self.hp)
	end

	if self._state == var_0_39 then
		return
	elseif self._state == var_0_40 then
		self:updateFlying(arg_75_1)
	elseif self._state == var_0_41 then
		self:updateDied(arg_75_1)
	elseif self._state == var_0_42 then
		self:updateFightWin(arg_75_1)
	end
end

function SummerTSMonster:switchState(arg_76_1)
	if self._state == arg_76_1 then
		return
	end

	self._state = arg_76_1

	if arg_76_1 == var_0_40 then
		self.ani:setAnimation(0, self.type == var_0_43 and "da" or "xiao", true)
	end
end

function SummerTSMonster:updateFlying(arg_77_1)
	if self.hp <= 0 then
		self:switchState(var_0_41)
	end

	self:setPositionY(self:getPositionY() + self.speed * arg_77_1 * self.slow)

	self.slow = 1

	if self:getPositionY() >= var_0_18 then
		self:switchState(var_0_42)
	end
end

function SummerTSMonster:updateDied(arg_78_1)
	self.ani:setVisible(false)
	self.aniDie:setVisible(true)
	self.aniDie:setAnimation(0, "siwang", false)

	local var_78_0 = self:getPositionX()
	local var_78_1 = self:getPositionY()

	if self.hp <= 0 then
		tower_swap_manager.score = tower_swap_manager.score + (self.type == var_0_43 and 500 or 5)

		tower_swap_manager:updateUIRef()
	end

	if self.type == var_0_43 then
		for iter_78_0 = 1, 10 do
			tower_swap_manager.UIRef.monstersPool:getObjectByMyType(var_0_44, SummerTSMonster):registered(true, var_78_0, var_78_1)
		end
	end

	self.aniDie:registerSpineEventHandler(function()
		tower_swap_manager.UIRef.monstersPool:recycleObject(self)

		self.dieAniEnd = true
	end, SP_ANIMATION_COMPLETE)
	self:switchState(var_0_39)
end

function SummerTSMonster:updateFightWin(arg_80_1)
	if self.type == var_0_43 then
		self:switchState(var_0_41)
	else
		tower_swap_manager:reduceHP()
		self:switchState(var_0_41)
	end
end

function SummerTSMonster:getDamage(arg_81_1)
	self.hp = self.hp - arg_81_1
end

local var_0_49 = {
	"",
	"shuipao_effect",
	"",
	"jianta_effect",
	"dapao_effect"
}

SummerTSBullet = class("SummerTSBullet", function()
	return cc.Node:create()
end)

function SummerTSBullet.create(arg_83_0, arg_83_1)
	local var_83_0 = SummerTSBullet.new()

	var_83_0:init(arg_83_1, level)

	return var_83_0
end

function SummerTSBullet:init(arg_84_1)
	self.ani = sp.SkeletonAnimation:create("spine/summerTowerSwap/tower/" .. var_0_49[arg_84_1] .. ".json", "spine/summerTowerSwap/tower/" .. var_0_49[arg_84_1] .. ".atlas", 1)

	self.ani:setAnimation(0, "zidan", true)
	self:addChild(self.ani)
	tower_swap_manager.UIRef.bg:addChild(self, var_0_22)
end

function SummerTSBullet:setAttribute(arg_85_1)
	self.damage = arg_85_1.damage
	self.speed = 600
	self.target = arg_85_1.target

	self:setPosition(cc.p(arg_85_1.px, arg_85_1.py))
end

function SummerTSBullet:update(arg_86_1)
	if not self.target or self.target._state ~= 1 or not self.target.isActive then
		self:destory()

		return
	end

	local var_86_0 = self:getPositionX() - self.target:getPositionX()
	local var_86_1 = self:getPositionY() - self.target:getPositionY()
	local var_86_2 = math.max(math.abs(var_86_0), math.abs(var_86_1))

	if math.abs(var_86_0) < 10 and math.abs(var_86_1) < 10 then
		self.target:getDamage(self.damage)
		self:destory()
	else
		self:setRotation(-var_0_30(cc.p(self:getPositionX(), self:getPositionY()), (cc.p(self.target:getPositionX(), self.target:getPositionY()))))
		self:setPositionX(self:getPositionX() - self.speed * arg_86_1 * var_86_0 / var_86_2)
		self:setPositionY(self:getPositionY() - self.speed * arg_86_1 * var_86_1 / var_86_2)
	end
end

function SummerTSBullet:destory()
	self.target.attackLockNum = self.target.attackLockNum - 1
	self.damage = 0
	self.speed = 0
	self.target = nil

	self.ani:setAnimation(0, "", false)
	tower_swap_manager.UIRef.bulletsPool:recycleObject(self)
end

function SummerTowerSwapLayer:showGuidePanel()
	if RoleDefault:getInstance():getBoolForKey("TowerSwapGuide", false) then
		return
	end

	RoleDefault:getInstance():setBoolForKey("TowerSwapGuide", true)

	local var_88_0 = ccui.Layout:create()

	var_88_0:setContentSize(cc.size(640, 1600))
	var_88_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_88_0:setCascadeOpacityEnabled(false)
	var_88_0:setBackGroundColorOpacity(180)
	var_88_0:setAnchorPoint(0.5, 0.5)
	var_88_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_88_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_88_0:setTouchEnabled(true)
	var_88_0:setLocalZOrder(1000)
	var_88_0:setVisible(true)
	self.rootlayer:addChild(var_88_0)

	self.guide_index = 1

	for iter_88_0 = 1, 4 do
		local var_88_1 = ccui.ImageView:create(var_0_1 .. "tip" .. iter_88_0 .. ".png", var_0_0)

		var_88_0:addChild(var_88_1)
		var_88_1:setPosition(320, 800)
		var_88_1:setName("tip_" .. iter_88_0)
	end

	local var_88_2 = ccui.Button:create(var_0_1 .. "tip_pre_btn.png", nil, var_0_1 .. "tip_pre_btn.png", var_0_0)

	var_88_0:addChild(var_88_2)
	var_88_2:setPosition(30, 800)
	var_88_2:setAnchorPoint(0, 0.5)

	local var_88_3 = ccui.Button:create(var_0_1 .. "tip_next_btn.png", nil, var_0_1 .. "tip_next_btn.png", var_0_0)

	var_88_0:addChild(var_88_3)
	var_88_3:setPosition(GameDisplay.width - 30, 800)
	var_88_3:setAnchorPoint(1, 0.5)

	local var_88_4 = ccui.Button:create(var_0_1 .. "close_btn.png", nil, var_0_1 .. "close_btn.png", var_0_0)

	var_88_0:addChild(var_88_4)
	var_88_4:setPosition(GameDisplay.width - 100, 1060)

	local function var_88_5()
		for iter_89_0 = 1, 4 do
			if iter_89_0 == self.guide_index then
				var_88_0:getChildByName("tip_" .. iter_89_0):setVisible(true)
			else
				var_88_0:getChildByName("tip_" .. iter_89_0):setVisible(false)
			end
		end

		var_88_2:setVisible(true)
		var_88_3:setVisible(true)

		if self.guide_index == 1 then
			var_88_2:setVisible(false)
		elseif self.guide_index == 4 then
			var_88_3:setVisible(false)
		end
	end

	var_88_2:addTouchEventListener(function(arg_90_0, arg_90_1)
		if arg_90_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.guide_index ~= 1 then
			self.guide_index = self.guide_index - 1
		end

		var_88_5()
	end)
	var_88_3:addTouchEventListener(function(arg_91_0, arg_91_1)
		if arg_91_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.guide_index ~= 4 then
			self.guide_index = self.guide_index + 1
		end

		var_88_5()
	end)
	var_88_4:addTouchEventListener(function(arg_92_0, arg_92_1)
		if arg_92_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_88_0:setVisible(false)
		tower_swap_manager:checkDispel()
		tower_swap_manager:startGame()
	end)
	var_88_5()
end

function SummerTowerSwapLayer:popGMLayer()
	if not config._DEBUG then
		return
	end

	if self.GMLayer then
		self.GMLayer:setVisible(true)

		return
	end

	local var_93_0 = ccui.Layout:create()

	var_93_0:setContentSize(cc.size(640, 1600))
	var_93_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_93_0:setCascadeOpacityEnabled(false)
	var_93_0:setBackGroundColorOpacity(0)
	var_93_0:setAnchorPoint(0.5, 0.5)
	var_93_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_93_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_93_0:setTouchEnabled(true)
	var_93_0:setLocalZOrder(1000)
	var_93_0:setVisible(true)
	self.rootlayer:addChild(var_93_0)

	self.GMLayer = var_93_0

	var_93_0:addTouchEventListener(function(arg_94_0, arg_94_1)
		if arg_94_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.GMLayer:setVisible(false)
	end)

	local var_93_1 = ccui.ImageView:create("public/twist/selectup_soft_bg.png")

	var_93_1:setPosition(320, 800)
	var_93_0:addChild(var_93_1)

	for iter_93_0, iter_93_1 in ipairs({
		{
			name = "宝箱事件正常概率",
			func = function()
				self.gm_gold_event = nil

				global_ShowBlockWords("成功")
			end
		},
		{
			name = "宝箱必定事件一",
			func = function()
				self.gm_gold_event = var_0_27

				global_ShowBlockWords("成功")
			end
		},
		{
			name = "宝箱必定事件二",
			func = function()
				self.gm_gold_event = var_0_28

				global_ShowBlockWords("成功")
			end
		},
		{
			name = "宝箱必定事件三",
			func = function()
				self.gm_gold_event = var_0_29

				global_ShowBlockWords("成功")
			end
		},
		{
			name = "关卡 + 1",
			func = function()
				tower_swap_manager:passGameLevel(function()
					global_ShowBlockWords("成功")
				end)
			end
		},
		{
			name = "分数 + 500",
			func = function()
				tower_swap_manager.score = tower_swap_manager.score + 500

				require("network.network"):rpc("activity_update_towerswap_score", {
					activityid = self.activityId,
					score = tower_swap_manager.score
				}, function(arg_102_0)
					if arg_102_0.result == 1 then
						global_ShowBlockWords("成功")
					end
				end)
			end
		},
		{
			name = "步数 + 1",
			func = function()
				tower_swap_manager.swapTimes = tower_swap_manager.swapTimes + 1

				global_ShowBlockWords("成功")
			end
		}
	}) do
		local var_93_2 = ccui.Button:create("public/button/public_button_red.png", nil, "public/button/public_button_red.png", var_0_0)
		local var_93_3 = cc.Label:createWithTTF(iter_93_1.name, FONT_NAME, 22)

		var_93_3:setPosition(cc.p(var_93_2:getContentSize().width / 2, var_93_2:getContentSize().height / 2))
		var_93_2:addChild(var_93_3)
		var_93_2:setPosition(cc.p(150 + (iter_93_0 + 1) % 2 * 230, GameDisplay.height / 2 - GameDisplay.fix_y - 140 - (math.floor(iter_93_0 / 2) + iter_93_0 % 2 - 1) * 100))
		var_93_1:addChild(var_93_2)
		var_93_2:addTouchEventListener(function(arg_104_0, arg_104_1)
			if arg_104_1 ~= ccui.TouchEventType.ended then
				return
			end

			iter_93_1.func()
			self:updateUI()
		end)
	end
end
