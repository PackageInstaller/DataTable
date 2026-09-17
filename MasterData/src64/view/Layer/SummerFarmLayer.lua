local var_0_0 = config._DEBUG and 0 or 1
local ObjectPool = require("view.Layer.ObjectPool")
local activity_manager = require("controller.activity_manager")
local summer_farm_maneger = require("controller.summer_farm_maneger")
local playermodel = require("model.playermodel")
local var_0_5 = {
	"plantItem/watermelon_",
	"plantItem/strawberry_",
	"plantItem/grape_",
	"plantItem/pineapple_"
}
local var_0_6 = 80
local var_0_7 = 860 + GameDisplay.fix_y * 0.5
local var_0_8 = 160
local var_0_9 = 145 + GameDisplay.fix_y * 0.35
local var_0_10 = 140
local var_0_11 = "SummerFarmLayer/"
local var_0_12 = 1
local var_0_13 = 10
local var_0_14 = 29
local var_0_15 = 30

SummerFarmLayer = class("SummerFarmLayer", function()
	return ccui.Layout:create()
end)

function SummerFarmLayer.create(arg_2_0)
	local var_2_0 = SummerFarmLayer.new()

	var_2_0:init()

	return var_2_0
end

function SummerFarmLayer:init()
	if not summer_farm_maneger.playid then
		summer_farm_maneger.saveLastGame = false
	elseif summer_farm_maneger.playid ~= playermodel.playerid then
		summer_farm_maneger.saveLastGame = false
	end

	summer_farm_maneger.playid = playermodel.playerid

	if not summer_farm_maneger.saveLastGame then
		if summer_farm_maneger:checkLocalData() then
			summer_farm_maneger.isPlayAni = false
			self.curTouchHandle = nil
			summer_farm_maneger.saveLastGame = true
		else
			summer_farm_maneger:initData()
			summer_farm_maneger:loadData()

			summer_farm_maneger.saveLastGame = false
		end
	else
		summer_farm_maneger.isPlayAni = false
		self.curTouchHandle = nil
	end

	summer_farm_maneger:registeredUIRef(self)
	self:initUI(summer_farm_maneger.saveLastGame)
	self:initPlantSelectPanel()
	summer_farm_maneger:testUpdate()
	self:updateUI()

	for iter_3_0 = 1, 12 do
		summer_farm_maneger.soils[iter_3_0].soil:updateSoil(summer_farm_maneger.soils[iter_3_0])
	end

	self:showGuidePanel()
end

function SummerFarmLayer:initUI(arg_4_1)
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)

	self.bg = ccui.ImageView:create(var_0_11 .. "bg.png", var_0_0)

	self.rootlayer:addChild(self.bg)
	self.bg:setPosition(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y - 40)

	local var_4_0 = ccui.Button:create(var_0_11 .. "title.png", nil, var_0_11 .. "title.png", var_0_0)

	self.rootlayer:addChild(var_4_0, var_0_12)
	var_4_0:setAnchorPoint(0, 1)
	var_4_0:setPosition(0, GameDisplay.height - GameDisplay.fix_y - 10)
	var_4_0:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "SummerFarm"
		})
	end)

	local var_4_1 = ccui.ImageView:create(var_0_11 .. "maxScoreBg.png", var_0_0)

	self.rootlayer:addChild(var_4_1, var_0_12)
	var_4_1:setAnchorPoint(0.5, 1)
	var_4_1:setPosition(GameDisplay.width / 2 + 200, var_4_0:getPositionY() - 45)

	self.maxScoreLabel = cc.Label:createWithTTF("9999", FONT_NAME, 32)

	var_4_1:addChild(self.maxScoreLabel)
	self.maxScoreLabel:setAnchorPoint(0, 0)
	self.maxScoreLabel:setPosition(100, 15)
	self.maxScoreLabel:setColor(cc.c3b(104, 65, 21))

	local var_4_2 = ccui.ImageView:create(var_0_11 .. "scoreBg.png", var_0_0)

	self.rootlayer:addChild(var_4_2, var_0_12)
	var_4_2:setAnchorPoint(0.5, 1)
	var_4_2:setPosition(GameDisplay.width / 2 + 200, var_4_0:getPositionY() - 115)

	self.curScoreLabel = cc.Label:createWithTTF("9999", FONT_NAME, 32)

	var_4_2:addChild(self.curScoreLabel)
	self.curScoreLabel:setAnchorPoint(0, 0)
	self.curScoreLabel:setPosition(100, 15)
	self.curScoreLabel:setColor(cc.c3b(104, 65, 21))

	local var_4_3 = ccui.ImageView:create(var_0_11 .. "ordersBg.png", var_0_0)

	self.rootlayer:addChild(var_4_3, var_0_12)
	var_4_3:setAnchorPoint(0.5, 1)
	var_4_3:setPosition(GameDisplay.width / 2, var_4_0:getPositionY() - 200)

	self.ordersLayout = ccui.Layout:create()

	self.ordersLayout:setPosition(158, 130)
	self.ordersLayout:setLayoutType(ccui.LayoutType.HORIZONTAL)
	self.ordersLayout:setAnchorPoint(0, 0)
	var_4_3:addChild(self.ordersLayout)

	self.remainTimesLabel = cc.Label:createWithTTF("25", FONT_NAME, 36)

	var_4_3:addChild(self.remainTimesLabel)
	self.remainTimesLabel:setAnchorPoint(0, 0)
	self.remainTimesLabel:setPosition(505, 75)
	self.remainTimesLabel:setColor(cc.c3b(84, 53, 12))

	local var_4_4 = ccui.Button:create(var_0_11 .. "btn_finishOrder.png", nil, var_0_11 .. "btn_finishOrder.png", var_0_0)

	var_4_3:addChild(var_4_4)
	var_4_4:setAnchorPoint(0, 0)
	var_4_4:setPosition(465, 15)
	var_4_4:addTouchEventListener(function(arg_6_0, arg_6_1)
		if not self.curTouchHandle then
			self.curTouchHandle = arg_6_0
		elseif self.curTouchHandle ~= arg_6_0 then
			return
		end

		if arg_6_1 ~= ccui.TouchEventType.ended then
			if arg_6_1 == ccui.TouchEventType.canceled then
				self.curTouchHandle = nil
			end

			return
		end

		self.curTouchHandle = nil

		summer_farm_maneger:clickOrderFinishHandle()
	end)

	local var_4_5 = ccui.ImageView:create(var_0_11 .. "return_bg.png", var_0_0)

	self.rootlayer:addChild(var_4_5, var_0_12)
	var_4_5:setAnchorPoint(0.5, 0)
	var_4_5:setPosition(GameDisplay.width / 2, -GameDisplay.fix_y)

	local var_4_6 = ccui.Button:create(var_0_11 .. "btn_return.png", nil, var_0_11 .. "btn_return.png", var_0_0)

	var_4_5:addChild(var_4_6)
	var_4_6:setAnchorPoint(0, 0)
	var_4_6:setPosition(0, 0)
	var_4_6:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		summer_farm_maneger.saveLastGame = true

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.uprootBtn = ccui.Button:create(var_0_11 .. "btn_uproot.png", nil, var_0_11 .. "btn_uproot.png", var_0_0)

	var_4_5:addChild(self.uprootBtn)
	self.uprootBtn:setAnchorPoint(0, 0)
	self.uprootBtn:setPosition(470, 0)

	self.uprootBtn.showShovel = true

	self.uprootBtn:addTouchEventListener(function(arg_8_0, arg_8_1)
		if not self.curTouchHandle then
			self.curTouchHandle = arg_8_0
		elseif self.curTouchHandle ~= arg_8_0 then
			return
		end

		if arg_8_1 ~= ccui.TouchEventType.ended then
			if arg_8_1 == ccui.TouchEventType.canceled then
				self.curTouchHandle = nil
			end

			return
		end

		self.curTouchHandle = nil

		self:shovelBtnHandle(self.uprootBtn.showShovel)
	end)

	local var_4_7 = ccui.Button:create(var_0_11 .. "btn_task.png", nil, var_0_11 .. "btn_task.png", var_0_0)

	var_4_5:addChild(var_4_7)
	var_4_7:setAnchorPoint(0, 0)
	var_4_7:setPosition(310, 0)
	var_4_7:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSummerTSTaskLayer", {
			activityId = 722,
			usemodule = "activityGame2"
		})
	end)

	local function var_4_8(arg_10_0, arg_10_1)
		local var_10_0 = ccui.Layout:create()

		var_10_0:setTouchEnabled(true)
		var_10_0:setContentSize(cc.size(var_0_10 - 10, var_0_10 - 10))
		var_10_0:setAnchorPoint(0, 0)
		var_10_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_10_0:addTouchEventListener(function(arg_11_0, arg_11_1)
			if not self.curTouchHandle then
				self.curTouchHandle = arg_11_0
			elseif self.curTouchHandle ~= arg_11_0 then
				return
			end

			if arg_11_1 ~= ccui.TouchEventType.ended then
				if arg_11_1 == ccui.TouchEventType.canceled then
					self.curTouchHandle = nil
				end

				return
			end

			self.curTouchHandle = nil

			summer_farm_maneger:soilTouchHandle(arg_10_0)
		end)
		arg_10_1:addChild(var_10_0, 999)
	end

	local function var_4_9(arg_12_0, arg_12_1)
		self["shovelBtn_" .. arg_12_0] = ccui.Button:create(var_0_11 .. "btn_Shovel.png", nil, var_0_11 .. "btn_Shovel.png", var_0_0)

		self["shovelBtn_" .. arg_12_0]:setAnchorPoint(0, 0)
		self["shovelBtn_" .. arg_12_0]:setPosition(arg_12_1:getPositionX(), arg_12_1:getPositionY())
		self["shovelBtn_" .. arg_12_0]:addTouchEventListener(function(arg_13_0, arg_13_1)
			if not self.curTouchHandle then
				self.curTouchHandle = arg_13_0
			elseif self.curTouchHandle ~= arg_13_0 then
				return
			end

			if arg_13_1 ~= ccui.TouchEventType.ended then
				if arg_13_1 == ccui.TouchEventType.canceled then
					self.curTouchHandle = nil
				end

				return
			end

			self.curTouchHandle = nil

			summer_farm_maneger:shovelHandle(arg_12_0)
		end)
		self.bg:addChild(self["shovelBtn_" .. arg_12_0], var_0_14)
		self["shovelBtn_" .. arg_12_0]:setVisible(false)
	end

	for iter_4_0 = 1, 12 do
		local var_4_10 = SummerSoil:create({
			pos = cc.p(var_0_6 + (iter_4_0 - 1) % 4 * var_0_8, var_0_7 - (math.ceil(iter_4_0 / 4) - 1) * var_0_9)
		})

		self.bg:addChild(var_4_10, 2)

		if not arg_4_1 then
			summer_farm_maneger.soils[iter_4_0] = {}
			summer_farm_maneger.soils[iter_4_0].plant = nil
			summer_farm_maneger.soils[iter_4_0].growTimes = 0
			summer_farm_maneger.soils[iter_4_0].rewardNeedTimes = 0
		end

		summer_farm_maneger.soils[iter_4_0].soil = var_4_10

		var_4_8(iter_4_0, var_4_10)
		var_4_9(iter_4_0, var_4_10)
	end

	self.plantSelectPanelBg = ccui.ImageView:create(var_0_11 .. "plantSelectPanelBg.png", var_0_0)

	self.bg:addChild(self.plantSelectPanelBg, var_0_12)
	self.plantSelectPanelBg:setAnchorPoint(0, 0)
	self.plantSelectPanelBg:setPosition(cc.p(0, 240 - GameDisplay.fix_y * 0.85))

	self.shovelAni = sp.SkeletonAnimation:create("spine/summerTowerSwap/summerFarm/" .. "farm_shovel.json", "spine/summerTowerSwap/summerFarm/" .. "farm_shovel.atlas", 1)
	self.waterAni = sp.SkeletonAnimation:create("spine/summerTowerSwap/summerFarm/" .. "farm_water.json", "spine/summerTowerSwap/summerFarm/" .. "farm_water.atlas", 1)
	self.harvestAni = sp.SkeletonAnimation:create("spine/summerTowerSwap/summerFarm/" .. "harvest.json", "spine/summerTowerSwap/summerFarm/" .. "harvest.atlas", 1)
	self.seedAni = sp.SkeletonAnimation:create("spine/summerTowerSwap/summerFarm/" .. "seed.json", "spine/summerTowerSwap/summerFarm/" .. "seed.atlas", 1)

	self.bg:addChild(self.shovelAni, var_0_15)
	self.bg:addChild(self.waterAni, var_0_15)
	self.bg:addChild(self.harvestAni, var_0_15)
	self.bg:addChild(self.seedAni, var_0_15)
	self.shovelAni:setVisible(false)
	self.waterAni:setVisible(false)
	self.harvestAni:setVisible(false)
	self.seedAni:setVisible(false)
end

function SummerFarmLayer.initData(arg_14_0)
	return
end

function SummerFarmLayer:updateUI()
	self.remainTimesLabel:setString(summer_farm_maneger.remainTime)
	self.maxScoreLabel:setString(summer_farm_maneger.maxscore)
	self.curScoreLabel:setString(summer_farm_maneger.score)
end

function SummerFarmLayer:initOrders(arg_16_1)
	local function var_16_0(arg_17_0)
		local var_17_0 = ccui.ImageView:create(var_0_11 .. "orderItemBg.png", var_0_0)

		var_17_0:setAnchorPoint(0, 0)

		local var_17_1 = ccui.ImageView:create(var_0_11 .. "orderLabelBg.png", var_0_0)

		var_17_0:addChild(var_17_1)
		var_17_1:setPosition(0, 0)
		var_17_1:setAnchorPoint(0, 0)

		local var_17_2 = cc.Label:createWithTTF(arg_17_0.num, FONT_NAME, 16)

		var_17_0:addChild(var_17_2)
		var_17_2:setAnchorPoint(0, 0)
		var_17_2:setPosition(57, 10)
		var_17_2:setName("num")

		local var_17_3 = ccui.ImageView:create(var_0_11 .. var_0_5[arg_17_0.type] .. "3.png", var_0_0)

		var_17_3:setScale(0.8)
		var_17_3:setAnchorPoint(0, 0)
		var_17_3:setPosition(10, 20)
		var_17_0:addChild(var_17_3)

		local var_17_4 = ccui.ImageView:create(var_0_11 .. "finshItem_mask.png", var_0_0)

		var_17_4:setAnchorPoint(0, 0)
		var_17_4:setPosition(0, 0)
		var_17_0:addChild(var_17_4)
		var_17_4:setName("finsh_mask")
		var_17_4:setVisible(false)
		var_17_0:setName("item_" .. arg_17_0.type)

		return var_17_0
	end

	self.ordersLayout:removeAllChildren()

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		self.ordersLayout:addChild((var_16_0(iter_16_1)))
	end

	self.ordersLayout:setScale(#arg_16_1 > 3 and 0.75 or 1)
end

function SummerFarmLayer:updateOrders()
	for iter_18_0, iter_18_1 in ipairs(summer_farm_maneger.ordersInfo) do
		self.ordersLayout:getChildByName("item_" .. iter_18_1.type):getChildByName("finsh_mask"):setVisible(iter_18_1.num <= summer_farm_maneger.plantInfo[iter_18_1.type].warehouseNum)
	end
end

function SummerFarmLayer:initPlantSelectPanel()
	local var_19_0 = -10

	local function var_19_1(arg_20_0)
		local var_20_0 = ccui.Layout:create()

		var_20_0:setPosition(var_19_0, 0)
		var_20_0:setAnchorPoint(0, 0)

		local var_20_1 = ccui.ImageView:create(var_0_11 .. "plantBg.png", var_0_0)

		var_20_0:addChild(var_20_1)
		var_20_1:setAnchorPoint(0, 0)
		var_20_1:setPosition(20, 50)
		var_20_1:setName("plantBg")

		local var_20_2 = ccui.Button:create(var_0_11 .. var_0_5[arg_20_0] .. "3.png", nil, var_0_11 .. var_0_5[arg_20_0] .. "3.png", var_0_0)

		var_20_0:addChild(var_20_2)
		var_20_2:setAnchorPoint(0, 0)
		var_20_2:setPosition(50, 90)

		if arg_20_0 == 2 then
			var_20_2:setPosition(50, 100)
		end

		var_20_2:setName("plant")

		local var_20_3 = ccui.ImageView:create(var_0_11 .. "lockedBg.png", var_0_0)

		var_20_0:addChild(var_20_3)
		var_20_3:setAnchorPoint(0, 0)
		var_20_3:setPosition(20, 50)
		var_20_3:setName("lockedBg")
		var_20_3:setVisible(false)

		local var_20_4 = ccui.ImageView:create(var_0_11 .. "needTimeIcon.png", var_0_0)

		var_20_0:addChild(var_20_4)
		var_20_4:setAnchorPoint(0, 0)
		var_20_4:setPosition(80, 70)
		var_20_4:setName("needTimeIcon")

		local var_20_5 = cc.Label:createWithTTF("0", FONT_NAME, 17)

		var_20_0:addChild(var_20_5)
		var_20_5:setPosition(108, 80)
		var_20_5:setName("needTime")

		local var_20_6 = ccui.ImageView:create(var_0_11 .. "warehouseBg.png", var_0_0)

		var_20_0:addChild(var_20_6)
		var_20_6:setAnchorPoint(0, 0)
		var_20_6:setPosition(30, 210)

		local var_20_7 = ccui.ImageView:create(var_0_11 .. "warehouseIcon.png", var_0_0)

		var_20_0:addChild(var_20_7)
		var_20_7:setAnchorPoint(0, 0)
		var_20_7:setPosition(20, 215)

		local var_20_8 = cc.Label:createWithTTF("0", FONT_NAME, 21)

		var_20_0:addChild(var_20_8)
		var_20_8:setAnchorPoint(0, 0)
		var_20_8:setPosition(90, 221)
		var_20_8:setName("warehouseNum")

		local var_20_9 = ccui.ImageView:create(var_0_11 .. "rewardBg.png", var_0_0)

		var_20_0:addChild(var_20_9)
		var_20_9:setAnchorPoint(0, 0)
		var_20_9:setPosition(30, 25)

		local var_20_10 = ccui.ImageView:create(var_0_11 .. "rewardIcon.png", var_0_0)

		var_20_0:addChild(var_20_10)
		var_20_10:setAnchorPoint(0, 0)
		var_20_10:setPosition(20, 20)

		local var_20_11 = cc.Label:createWithTTF("0", FONT_NAME, 21)

		var_20_0:addChild(var_20_11)
		var_20_11:setAnchorPoint(0, 0)
		var_20_11:setPosition(90, 28)
		var_20_11:setName("rewardNum")

		local var_20_12 = ccui.ImageView:create(var_0_11 .. "lv.png", var_0_0)

		var_20_12:setPosition(20, 178)
		var_20_12:setAnchorPoint(0, 0)
		var_20_0:addChild(var_20_12)
		var_20_12:setName("lvBg")

		local var_20_13 = ccui.Slider:create()

		var_20_13:loadBarTexture(var_0_11 .. "LV-off.png", var_0_0)
		var_20_13:loadProgressBarTexture(var_0_11 .. "LV-ON.png", var_0_0)
		var_20_13:setAnchorPoint(0, 0)
		var_20_13:setPercent(80)
		var_20_13:setName("progressBar")
		var_20_0:addChild(var_20_13)
		var_20_13:setPosition(50, 183)

		local var_20_14 = cc.Label:createWithTTF("20", FONT_NAME, 16)

		var_20_0:addChild(var_20_14)
		var_20_14:setAnchorPoint(0, 0)
		var_20_14:setPosition(60, 185)
		var_20_14:setName("levelNum")

		var_19_0 = var_19_0 + var_0_8 - 10

		var_20_2:addTouchEventListener(function(arg_21_0, arg_21_1)
			self:plantSelectTouchHandle(arg_21_0, arg_21_1, arg_20_0)
		end)

		return var_20_0
	end

	for iter_19_0 = 1, 4 do
		self["selectItem" .. iter_19_0] = var_19_1(iter_19_0)

		self.plantSelectPanelBg:addChild(self["selectItem" .. iter_19_0])
	end
end

function SummerFarmLayer:updatePlantSelectPanel(arg_22_1, arg_22_2)
	local var_22_0 = self["selectItem" .. arg_22_2]

	self["selectItem" .. arg_22_2]:getChildByName("plantBg"):setVisible(not arg_22_1.locked)
	var_22_0:getChildByName("plant"):setVisible(not arg_22_1.locked)
	var_22_0:getChildByName("progressBar"):setVisible(not arg_22_1.locked)
	var_22_0:getChildByName("needTimeIcon"):setVisible(not arg_22_1.locked)
	var_22_0:getChildByName("lvBg"):setVisible(not arg_22_1.locked)
	var_22_0:getChildByName("lockedBg"):setVisible(arg_22_1.locked)
	var_22_0:getChildByName("needTime"):setString(arg_22_1.locked and "" or arg_22_1.needTime)
	var_22_0:getChildByName("warehouseNum"):setString(arg_22_1.locked and "" or arg_22_1.warehouseNum)
	var_22_0:getChildByName("rewardNum"):setString(arg_22_1.locked and "" or arg_22_1.rewardNum)
	var_22_0:getChildByName("levelNum"):setString(arg_22_1.locked and "" or arg_22_1.level)
	var_22_0:getChildByName("progressBar"):setPercent(arg_22_1.locked and 0 or 100 * arg_22_1.exp / arg_22_1.levelup_need_exp)
end

function SummerFarmLayer:plantSelectTouchHandle(arg_23_1, arg_23_2, arg_23_3)
	if summer_farm_maneger.remainTime <= 0 then
		global_ShowBlockWords("剩余时间不足哦~")

		if self.movePlantSprite then
			self.movePlantSprite:setVisible(false)
		end

		return
	end

	if not self.curTouchHandle then
		self.curTouchHandle = arg_23_1
	elseif self.curTouchHandle ~= arg_23_1 then
		return
	end

	if arg_23_2 == ccui.TouchEventType.began then
		if not self.movePlantSprite then
			self.movePlantSprite = ccui.ImageView:create(var_0_11 .. var_0_5[arg_23_3] .. "3.png", var_0_0)

			self.bg:addChild(self.movePlantSprite, var_0_13)
		end

		self.movePlantSprite:loadTexture(var_0_11 .. var_0_5[arg_23_3] .. "3.png", var_0_0)
	elseif arg_23_2 == ccui.TouchEventType.moved then
		self.movePlantSprite:setVisible(true)
		self.movePlantSprite:setPosition((self.bg:convertToNodeSpace(arg_23_1:getTouchMovePosition())))

		return
	else
		self.curTouchHandle = nil

		self.movePlantSprite:setVisible(false)

		local var_23_0 = self.bg:convertToNodeSpace(arg_23_1:getTouchEndPosition())

		for iter_23_0, iter_23_1 in ipairs(summer_farm_maneger.soils) do
			if math.abs(iter_23_1.soil:getPositionX() - var_23_0.x) < var_0_10 / 2 and math.abs(iter_23_1.soil:getPositionY() - var_23_0.y) < var_0_10 / 2 then
				summer_farm_maneger:plantHandle(iter_23_0, arg_23_3)

				return
			end
		end
	end
end

function SummerFarmLayer:shovelBtnHandle()
	if summer_farm_maneger.isPlayAni then
		return
	end

	for iter_24_0 = 1, 12 do
		self["shovelBtn_" .. iter_24_0]:setVisible(self.uprootBtn.showShovel)
	end

	self.uprootBtn:loadTextures(var_0_11 .. (self.uprootBtn.showShovel and "btn_shovel_cancel.png" or "btn_uproot.png"), nil, var_0_11 .. (self.uprootBtn.showShovel and "btn_shovel_cancel.png" or "btn_uproot.png"), var_0_0)

	self.uprootBtn.showShovel = not self.uprootBtn.showShovel
end

function SummerFarmLayer:initNextLevelPanel(arg_25_1)
	if not self.nextLayer then
		local var_25_0 = ccui.Layout:create()

		var_25_0:setContentSize(cc.size(640, 1600))
		var_25_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_25_0:setCascadeOpacityEnabled(false)
		var_25_0:setBackGroundColorOpacity(122)
		var_25_0:setAnchorPoint(0.5, 0.5)
		var_25_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_25_0:setPosition(GameDisplay.cx, GameDisplay.cy)
		var_25_0:setTouchEnabled(false)
		var_25_0:setLocalZOrder(1000)
		var_25_0:setVisible(true)
		var_25_0:addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_25_0:setVisible(false)
		end)
		self.rootlayer:addChild(var_25_0)

		self.nextLayer = var_25_0

		local var_25_1 = sp.SkeletonAnimation:create("spine/summerTowerSwap/summerFarm/" .. "farm_success.json", "spine/summerTowerSwap/summerFarm/" .. "farm_success.atlas", 1)

		var_25_0:addChild(var_25_1)
		var_25_1:setPosition(320, 800)
		var_25_1:setName("farm_success")

		local var_25_2 = ccui.Layout:create()

		var_25_0:addChild(var_25_2)
		var_25_2:setPosition(0, 400)
		var_25_2:setName("bg")

		local var_25_3 = ccui.Layout:create()

		var_25_3:setPosition(70, 430)
		var_25_3:setLayoutType(ccui.LayoutType.HORIZONTAL)
		var_25_3:setAnchorPoint(0, 0)
		var_25_2:addChild(var_25_3)
		var_25_3:setName("ordersLayout")

		local var_25_4 = ccui.Button:create(var_0_11 .. "btn_nextLevel.png", nil, var_0_11 .. "btn_nextLevel.png", var_0_0)

		var_25_2:addChild(var_25_4)
		var_25_4:setPosition(320, 230)
		var_25_4:addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_25_0:setVisible(false)
		end)
	end

	self.nextLayer:setVisible(true)
	self.nextLayer:getChildByName("bg"):setOpacity(0)
	self.nextLayer:getChildByName("farm_success"):setAnimation(0, "farm_success", false)
	self.nextLayer:getChildByName("farm_success"):registerSpineEventHandler(function()
		self.nextLayer:getChildByName("bg"):runAction((cc.FadeIn:create(0.5)))
		self.nextLayer:setTouchEnabled(true)
	end, SP_ANIMATION_COMPLETE)

	local function var_25_5(arg_29_0)
		local var_29_0 = ccui.ImageView:create(var_0_11 .. "orderItemBg.png", var_0_0)

		var_29_0:setAnchorPoint(0, 0)

		local var_29_1 = ccui.ImageView:create(var_0_11 .. "orderLabelBg.png", var_0_0)

		var_29_0:addChild(var_29_1)
		var_29_1:setPosition(0, 0)
		var_29_1:setAnchorPoint(0, 0)

		local var_29_2 = cc.Label:createWithTTF(arg_29_0.num, FONT_NAME, 16)

		var_29_0:addChild(var_29_2)
		var_29_2:setAnchorPoint(0, 0)
		var_29_2:setPosition(57, 10)
		var_29_2:setName("num")

		local var_29_3 = ccui.ImageView:create(var_0_11 .. var_0_5[arg_29_0.type] .. "3.png", var_0_0)

		var_29_3:setScale(0.8)
		var_29_3:setAnchorPoint(0, 0)
		var_29_3:setPosition(10, 20)
		var_29_0:addChild(var_29_3)
		var_29_0:setName("item_" .. arg_29_0.type)
		var_29_0:setScale(1.5)

		local var_29_4 = ccui.LinearLayoutParameter:create()

		var_29_4:setGravity(ccui.LinearGravity.centerHorizontal)
		var_29_4:setMargin({
			left = 30,
			right = 30
		})
		var_29_0:setLayoutParameter(var_29_4)

		return var_29_0
	end

	local var_25_6 = self.nextLayer:getChildByName("bg"):getChildByName("ordersLayout")

	var_25_6:removeAllChildren()

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		var_25_6:addChild((var_25_5(iter_25_1)))
	end

	var_25_6:setScale(#arg_25_1 > 3 and 0.75 or 1)
end

function SummerFarmLayer:initEndPanel(arg_30_1)
	if not self.exitLayer then
		local var_30_0 = ccui.Layout:create()

		var_30_0:setContentSize(cc.size(640, 1600))
		var_30_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_30_0:setCascadeOpacityEnabled(false)
		var_30_0:setBackGroundColorOpacity(122)
		var_30_0:setAnchorPoint(0.5, 0.5)
		var_30_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_30_0:setPosition(GameDisplay.cx, GameDisplay.cy)
		var_30_0:setTouchEnabled(false)
		var_30_0:setLocalZOrder(1000)
		var_30_0:setVisible(true)
		var_30_0:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_30_0:setVisible(false)
		end)
		self.rootlayer:addChild(var_30_0)

		self.exitLayer = var_30_0

		local var_30_1 = sp.SkeletonAnimation:create("spine/summerTowerSwap/summerFarm/" .. "farm_failure.json", "spine/summerTowerSwap/summerFarm/" .. "farm_failure.atlas", 1)

		var_30_0:addChild(var_30_1)
		var_30_1:setPosition(320, 800)
		var_30_1:setName("farm_failure")

		local var_30_2 = ccui.Layout:create()

		var_30_0:addChild(var_30_2)
		var_30_2:setPosition(0, 400)
		var_30_2:setName("bg")

		local var_30_3 = ccui.Layout:create()

		var_30_3:setPosition(70, 430)
		var_30_3:setLayoutType(ccui.LayoutType.HORIZONTAL)
		var_30_3:setAnchorPoint(0, 0)
		var_30_2:addChild(var_30_3)
		var_30_3:setName("ordersLayout")

		local var_30_4 = ccui.Button:create(var_0_11 .. "btn_failed_return.png", nil, var_0_11 .. "btn_failed_return.png", var_0_0)

		var_30_2:addChild(var_30_4)
		var_30_4:setPosition(210, 230)

		summer_farm_maneger.saveLastGame = false

		var_30_4:addTouchEventListener(function(arg_32_0, arg_32_1)
			if arg_32_1 ~= ccui.TouchEventType.ended then
				return
			end

			summer_farm_maneger:initData()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)

		local var_30_5 = ccui.Button:create(var_0_11 .. "orders_failed_restart.png", nil, var_0_11 .. "orders_failed_restart.png", var_0_0)

		var_30_5:addTouchEventListener(function(arg_33_0, arg_33_1)
			if arg_33_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.exitLayer:setVisible(false)
			self:restartGame()
		end)
		var_30_2:addChild(var_30_5)
		var_30_5:setPosition(430, 230)
	end

	self.exitLayer:setVisible(true)
	self.exitLayer:getChildByName("bg"):setOpacity(0)
	self.exitLayer:getChildByName("farm_failure"):setAnimation(0, "farm_failure", false)
	self.exitLayer:getChildByName("farm_failure"):registerSpineEventHandler(function()
		self.exitLayer:getChildByName("bg"):runAction((cc.FadeIn:create(0.5)))
	end, SP_ANIMATION_COMPLETE)

	local function var_30_6(arg_35_0, arg_35_1)
		local var_35_0 = ccui.ImageView:create(var_0_11 .. "orderItemBg.png", var_0_0)

		var_35_0:setAnchorPoint(0, 0)

		local var_35_1 = ccui.ImageView:create(var_0_11 .. "orderLabelBg.png", var_0_0)

		var_35_0:addChild(var_35_1)
		var_35_1:setPosition(0, 0)
		var_35_1:setAnchorPoint(0, 0)

		local var_35_2 = cc.Label:createWithTTF(arg_35_0.num, FONT_NAME, 16)

		var_35_0:addChild(var_35_2)
		var_35_2:setAnchorPoint(0, 0)
		var_35_2:setPosition(57, 10)
		var_35_2:setName("num")

		local var_35_3 = ccui.ImageView:create(var_0_11 .. var_0_5[arg_35_0.type] .. "3.png", var_0_0)

		var_35_3:setScale(0.8)
		var_35_3:setAnchorPoint(0, 0)
		var_35_3:setPosition(10, 20)
		var_35_0:addChild(var_35_3)

		local var_35_4 = ccui.ImageView:create(var_0_11 .. (arg_35_1 >= arg_35_0.num and "finishIcon.png" or "failIcon.png"), var_0_0)

		var_35_4:setScale(0.66)
		var_35_4:setAnchorPoint(0, 0)
		var_35_4:setPosition(47, 60)
		var_35_0:addChild(var_35_4)
		var_35_0:setName("item_" .. arg_35_0.type)
		var_35_0:setScale(1.5)

		local var_35_5 = ccui.LinearLayoutParameter:create()

		var_35_5:setGravity(ccui.LinearGravity.centerHorizontal)
		var_35_5:setMargin({
			left = 30,
			right = 30
		})
		var_35_0:setLayoutParameter(var_35_5)

		return var_35_0
	end

	local var_30_7 = self.exitLayer:getChildByName("bg"):getChildByName("ordersLayout")

	var_30_7:removeAllChildren()

	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		var_30_7:addChild((var_30_6(iter_30_1, summer_farm_maneger.plantInfo[iter_30_1.type].warehouseNum)))
	end

	var_30_7:setScale(#arg_30_1 > 3 and 0.75 or 1)
end

function SummerFarmLayer:showGuidePanel()
	if cc.UserDefault:getInstance():getBoolForKey("SummerFarmGuide" .. playermodel.playerid, false) then
		return
	end

	local var_36_0 = ccui.Layout:create()

	var_36_0:setContentSize(cc.size(640, 1600))
	var_36_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_36_0:setCascadeOpacityEnabled(false)
	var_36_0:setBackGroundColorOpacity(180)
	var_36_0:setAnchorPoint(0.5, 0.5)
	var_36_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_36_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_36_0:setTouchEnabled(true)
	var_36_0:setLocalZOrder(1000)
	var_36_0:setVisible(true)
	self.rootlayer:addChild(var_36_0)

	local var_36_1 = sp.SkeletonAnimation:create("spine/summerTowerSwap/summerFarm/" .. "farm_guide_1.json", "spine/summerTowerSwap/summerFarm/" .. "farm_guide_1.atlas", 1)

	var_36_0:addChild(var_36_1, var_0_15)
	var_36_1:setPosition(320, 800)

	local var_36_2 = sp.SkeletonAnimation:create("spine/summerTowerSwap/summerFarm/" .. "farm_guide_2.json", "spine/summerTowerSwap/summerFarm/" .. "farm_guide_2.atlas", 1)

	var_36_0:addChild(var_36_2, var_0_15)
	var_36_2:setPosition(320, 900)
	var_36_2:setVisible(false)

	local var_36_3 = sp.SkeletonAnimation:create("spine/summerTowerSwap/summerFarm/" .. "farm_guide_3.json", "spine/summerTowerSwap/summerFarm/" .. "farm_guide_3.atlas", 1)

	var_36_0:addChild(var_36_3, var_0_15)
	var_36_3:setPosition(320, 900)
	var_36_3:setVisible(false)

	local var_36_4 = false
	local var_36_5 = 1

	var_36_1:setAnimation(0, "farm_guide_1", true)
	var_36_1:registerSpineEventHandler(function()
		var_36_4 = true
	end, SP_ANIMATION_COMPLETE)

	local var_36_6 = ccui.ImageView:create(var_0_11 .. "role_Bg.png", var_0_0)

	var_36_0:addChild(var_36_6, var_0_15)
	var_36_6:setAnchorPoint(0, 0)
	var_36_6:setPosition(0, 300)

	local var_36_7 = ccui.ImageView:create(var_0_11 .. "guie_explain_bg.png", var_0_0)

	var_36_0:addChild(var_36_7, var_0_15)
	var_36_7:setAnchorPoint(0, 0)
	var_36_7:setPosition(160, 380)

	local var_36_8 = cc.Label:createWithTTF("拖动水果至土地播种", FONT_NAME, 26)

	var_36_0:addChild(var_36_8, var_0_15)
	var_36_8:setAnchorPoint(0, 0)
	var_36_8:setPosition(220, 460)

	local var_36_9 = {
		var_36_1,
		var_36_2,
		var_36_3
	}
	local var_36_10 = {
		"farm_guide_1",
		"farm_guide_2",
		"farm_guide_3"
	}
	local var_36_11 = {
		"拖动水果至土地播种",
		"点击水果苗浇水",
		"点击水果进行收获"
	}

	var_36_0:addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_36_4 then
			return
		end

		var_36_9[var_36_5]:setVisible(false)

		var_36_5 = var_36_5 + 1
		var_36_4 = false

		if var_36_5 > 3 then
			cc.UserDefault:getInstance():setBoolForKey("SummerFarmGuide" .. playermodel.playerid, true)
			var_36_0:setVisible(false)

			return
		end

		var_36_9[var_36_5]:setVisible(true)
		var_36_9[var_36_5]:setAnimation(0, var_36_10[var_36_5], true)
		var_36_8:setString(var_36_11[var_36_5])
		var_36_9[var_36_5]:registerSpineEventHandler(function()
			var_36_4 = true
		end, SP_ANIMATION_COMPLETE)
	end)
end

function SummerFarmLayer:restartGame()
	summer_farm_maneger:loadData()

	for iter_40_0 = 1, 12 do
		summer_farm_maneger.soils[iter_40_0].plant = nil
		summer_farm_maneger.soils[iter_40_0].growTimes = 0
		summer_farm_maneger.soils[iter_40_0].rewardNeedTimes = 0

		summer_farm_maneger.soils[iter_40_0].soil:updateSoil(summer_farm_maneger.soils[iter_40_0])
	end

	self:initOrders(summer_farm_maneger.ordersInfo)
	summer_farm_maneger:testUpdate()
	self:updateUI()
end

SummerSoil = class("SummerSoil", function()
	return ccui.ImageView:create(var_0_11 .. "soilBg.png", var_0_0)
end)

function SummerSoil.create(arg_42_0, arg_42_1)
	local var_42_0 = SummerSoil.new()

	var_42_0:init(arg_42_1)

	return var_42_0
end

function SummerSoil:init(arg_43_1)
	self:setPosition(arg_43_1.pos)
	self:setAnchorPoint(0.5, 0.5)

	self.progressBarBg = ccui.ImageView:create(var_0_11 .. "progressBarBg_1.png", var_0_0)

	self.progressBarBg:setPosition(cc.p(10, 125))
	self.progressBarBg:setAnchorPoint(0, 0)
	self:addChild(self.progressBarBg)

	self.progressBar = ccui.Slider:create()

	self.progressBar:loadBarTexture(var_0_11 .. "progress_bg.png", var_0_0)
	self.progressBar:loadProgressBarTexture(var_0_11 .. "progress_on.png", var_0_0)
	self.progressBar:setAnchorPoint(cc.p(0, 0))
	self.progressBar:setPercent(80)
	self.progressBar:setPositionX(10)
	self.progressBar:setName("progressBar")
	self.progressBarBg:addChild(self.progressBar)

	local var_43_0 = ccui.ImageView:create(var_0_11 .. "clockIcon.png", var_0_0)

	self.progressBarBg:addChild(var_43_0)
	var_43_0:setPosition(cc.p(-10, 0))
	var_43_0:setAnchorPoint(0, 0)

	self.growUpRemainLabel = cc.Label:createWithTTF("0", FONT_NAME, 20)

	self.progressBarBg:addChild(self.growUpRemainLabel)
	self.growUpRemainLabel:setAnchorPoint(0, 0)
	self.growUpRemainLabel:setPosition(100, 30)
	self.growUpRemainLabel:setPosition(cc.p(20, 5))

	self.plant = ccui.ImageView:create(var_0_11 .. "plantItem/pineapple_1.png", var_0_0)

	self.plant:setAnchorPoint(0.5, 0.5)
	self.plant:setPosition(70, 70)
	self:addChild(self.plant)
	self.growUpRemainLabel:setVisible(false)
	self.progressBarBg:setVisible(false)
	self.plant:setVisible(false)
end

function SummerSoil:updateSoil(arg_44_1)
	if not arg_44_1.plant then
		self.progressBarBg:setVisible(false)
		self.plant:setVisible(false)
		self.growUpRemainLabel:setVisible(false)

		return
	end

	self.progressBarBg:setVisible(true)
	self.plant:setVisible(true)
	self.growUpRemainLabel:setVisible(true)
	self.progressBarBg:loadTexture(var_0_11 .. "progressBarBg_" .. arg_44_1.plant .. ".png", var_0_0)
	self.progressBar:setPercent(100 * arg_44_1.growTimes / arg_44_1.rewardNeedTimes)

	local var_44_0
	local var_44_2

	if 100 * arg_44_1.growTimes / arg_44_1.rewardNeedTimes >= 100 then
		var_44_0 = 3
		var_44_2 = 0
	else
		var_44_0 = 100 * arg_44_1.growTimes / arg_44_1.rewardNeedTimes >= 50 and 2 or 1
		var_44_2 = arg_44_1.rewardNeedTimes - arg_44_1.growTimes
	end

	self.plant:loadTexture(var_0_11 .. var_0_5[arg_44_1.plant] .. var_44_0 .. ".png", var_0_0)
	self.growUpRemainLabel:setString(var_44_2)
end
