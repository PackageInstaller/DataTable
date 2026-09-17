BondLayer = class("BondLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = {
	CANACTIVE = 4,
	HAVEACTIVATED = 0,
	UNLEVELUP = 3,
	UNACTIVE_NONE = 1,
	UNACTIVE_UNALL = 2,
	CANLEVELUP = 5
}
local var_0_1 = {
	REVIEW = 3,
	FIRST = 2,
	LOCK = 1,
	UNHAVE = 0
}
local var_0_2 = {
	"BondLayer/bondDetail/btn_watch_lock.png",
	"BondLayer/bondDetail/btn_watch_normal.png",
	"BondLayer/bondDetail/btn_watch_review.png"
}
local var_0_3 = {
	[0] = "BondLayer/level0.png",
	"BondLayer/level1.png",
	"BondLayer/level2.png",
	"BondLayer/level3.png"
}
local var_0_4 = {
	"BondLayer/bondDetail/btn_active_off.png",
	"BondLayer/bondDetail/btn_active_off.png",
	"BondLayer/bondDetail/btn_level_off.png",
	"BondLayer/bondDetail/btn_active.png",
	"BondLayer/bondDetail/btn_level.png"
}
local var_0_5 = {
	[1] = "BondLayer/line.png",
	[2] = "BondLayer/line_on.png"
}
local bond_story_data = require("data.bond_story_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.MovingView")
require("view.Sprite.ConfirmDialogSprite")

local l2utils = require("controller.l2utils")
local hexie_manager = require("controller.hexie_manager")
local bond_manager = require("controller.bond_manager")
local var_0_10 = config._DEBUG and 0 or 1

function BondLayer.create(arg_2_0, ...)
	local var_2_0 = BondLayer.new()

	var_2_0:onLoad(...)

	return var_2_0
end

function BondLayer:fullscreen()
	self.root:setPosition(cc.p(0, -GameDisplay.fix_y))

	self.btn_back.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btn_back:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_back:setPositionY(self.btn_back.full_posY)

	self.listViewNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.listViewNode:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.listViewNode:setPositionY(self.listViewNode.full_posY)

	self.btn_tips.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.btn_tips:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_tips:setPositionY(self.btn_tips.full_posY)

	self.titleNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.titleNode:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.titleNode:setPositionY(self.titleNode.full_posY)

	self.downLineNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.downLineNode:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.downLineNode:setPositionY(self.downLineNode.full_posY)

	for iter_3_0, iter_3_1 in pairs(self.bondDetailPanelNode:getChildren()) do
		iter_3_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - iter_3_1:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		iter_3_1:setPositionY(iter_3_1.full_posY)
	end

	for iter_3_2, iter_3_3 in pairs(self.bondResultlPanelNode:getChildren()) do
		iter_3_3.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - iter_3_3:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		iter_3_3:setPositionY(iter_3_3.full_posY)
	end

	self.itemNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.itemNode:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.itemNode:setPositionY(self.itemNode.full_posY)

	self.item0Node.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.item0Node:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.item0Node:setPositionY(self.item0Node.full_posY)
end

function BondLayer:onLoad(arg_4_1)
	self.params = arg_4_1
	self.root = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "BondLayer.json" or "BondLayer.ExportJson")

	self:addChild(self.root)
	self:initUINode()
	self:initInfo()
	bond_manager:init(function()
		self:initPanel()
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.clearScheduler ~= nil then
				self.scheduler:unscheduleScriptEntry(self.clearScheduler)

				self.clearScheduler = nil
			end

			local alert_manager = require("controller.alert_manager")

			if bond_manager:isShowRemind() then
				alert_manager:register_alert(ALERT_BOND)
			else
				alert_manager:unregister_alert(ALERT_BOND, true)
			end
		end
	end)

	self.scheduler = cc.Director:getInstance():getScheduler()

	self:fullscreen()
end

function BondLayer:initUINode()
	self.itemNode = self.root:getChildByName("item")
	self.item0Node = self.root:getChildByName("item_0")

	self.itemNode:setVisible(false)
	self.item0Node:setVisible(false)

	self.listViewNode = self.root:getChildByName("listView")

	function self.onBtnBackCallback(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("返回主界面")

		if self.params and type(self.params.exitCallback) == "function" then
			self.params.exitCallback()
		end

		if self.clearScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.clearScheduler)

			self.clearScheduler = nil
		end

		self.clearScheduler = self.scheduler:scheduleScriptFunc(function()
			if self.clearScheduler ~= nil then
				self.scheduler:unscheduleScriptEntry(self.clearScheduler)

				self.clearScheduler = nil
			end

			if not self.params or self.params.isJump ~= true then
				LayerManager:removePopLayer()
			end
		end, 0, false)
	end

	self.btn_back = BottomBtnList:create(self.onBtnBackCallback)

	self.btn_back:setName("btn_back")
	self.root:addChild(self.btn_back)

	self.btn_tips = self.root:getChildByName("btn_tips")

	self.btn_tips:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "bond_layer"
		})
	end)

	self.titleNode = self.root:getChildByName("title")

	self.titleNode:setLocalZOrder(1)

	self.downLineNode = self.root:getChildByName("down_line")

	self.downLineNode:setLocalZOrder(1)
	self.btn_back:setLocalZOrder(1)
	self.btn_tips:setLocalZOrder(1)

	self.bondDetailPanelNode = self.root:getChildByName("bondDetailPanel")

	self.bondDetailPanelNode:setLocalZOrder(1)
	self.bondDetailPanelNode:setVisible(false)
	self.bondDetailPanelNode:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.bondDetailPanelNode:setVisible(false)
	end)
	self.bondDetailPanelNode:setBackGroundImage("BondLayer/bondDetail/bg.png", var_0_10)

	self.postCardNode = self.bondDetailPanelNode:getChildByName("postcard")

	self.postCardNode:setVisible(false)
	self.postCardNode:setTouchEnabled(true)
	self.postCardNode:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curBondDetailInfo.bondStatus ~= var_0_0.CANACTIVE and self.curBondDetailInfo.bondStatus ~= var_0_0.UNACTIVE_NONE and self.curBondDetailInfo.bondStatus ~= var_0_0.UNACTIVE_UNALL then
			if self.curBondDetailInfo.levelList[1].btnPlotStatus == var_0_1.LOCK then
				global_ShowBlockWords(L_BOND_TIPS.STILL_LOCK)
			else
				self:autoPlayPlotTalk(1)
				self.bondDetailPanelNode:getChildByName("effectPanel"):getChildByName("level" .. 1):getChildByName("btn_plot"):getChildByName("redDot"):setVisible(false)
			end
		end
	end)

	local var_7_0 = ccui.Layout:create()

	var_7_0:setAnchorPoint(cc.p(0, 0))
	var_7_0:setClippingEnabled(true)
	var_7_0:setPositionX(0)
	var_7_0:setPositionY(0)
	var_7_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_7_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_7_0:setBackGroundColorOpacity(120)
	var_7_0:setName("darkPanel")

	self.maskNode = var_7_0

	self.postCardNode:addChild(var_7_0)

	self.bondResultlPanelNode = self.root:getChildByName("bondResultlPanel")

	self.bondResultlPanelNode:setLocalZOrder(1)
	self.bondResultlPanelNode:setVisible(false)
	self.bondResultlPanelNode:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isCanCloseResultPanel == false then
			return
		end

		self.bondResultlPanelNode:setVisible(false)
	end)
	self.bondResultlPanelNode:setBackGroundImage("BondLayer/bondDetail/bg.png", var_0_10)
	self.root:getChildByName("bg"):loadTexture("BondLayer/bg.png", var_0_10)
end

function BondLayer.initInfo(arg_14_0)
	arg_14_0.curBondDetailInfo = {}
	arg_14_0.curBondResultInfo = {}
end

function BondLayer:initPanel()
	local var_15_0 = bond_manager:getBondInfo()

	if var_15_0 == nil then
		return
	end

	local var_15_1 = var_15_0
	local var_15_2 = #var_15_0

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()
	end

	self.listViewNode = self:getTableView(var_15_1, #var_15_0, cc.size(640, 341), cc.size(640, GameDisplay.height + GameDisplay.fix_y - 40), function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_16_2[arg_16_1 + 1]
		local var_16_1 = #arg_16_2[arg_16_1 + 1].playerList
		local var_16_2 = arg_16_0:dequeueCell()

		if var_16_2 == nil then
			var_16_2 = cc.TableViewCell:new()
		end

		local var_16_4 = var_16_2:getChildByName("item")

		if var_16_4 then
			var_16_4:removeFromParent()

			var_16_4 = nil
		end

		var_16_4 = var_16_0.isDouble and self.item0Node:clone() or self.itemNode:clone()

		var_16_2:addChild(var_16_4)
		var_16_4:setName("item")

		if arg_16_1 + 1 ~= var_15_2 then
			var_16_4:setPosition(cc.p(0, 0))
		else
			var_16_4:setPosition(cc.p(0, 80 + GameDisplay.fix_y))
		end

		var_16_4:setVisible(true)

		local var_16_5 = var_16_4:getChildByName("name")
		local var_16_6 = var_16_4:getChildByName("level")
		local var_16_7 = var_16_4:getChildByName("des")
		local var_16_8 = var_16_4:getChildByName("btn_goToUp")
		local var_16_9 = var_16_4:getChildByName("btn_goToActive")
		local var_16_10 = var_16_4:getChildByName("btn_haveActivated")
		local var_16_11 = var_16_4:getChildByName("btn_unHaveAll")
		local var_16_12 = var_16_4:getChildByName("studentList1")
		local var_16_13 = var_16_4:getChildByName("studentList2")

		var_16_5:setFontName(FONT_NAME)
		var_16_5:setString(var_16_0.name)
		var_16_5:setLocalZOrder(1)
		var_16_5:setPositionX(-15)

		local var_16_14 = cc.Label:createWithTTF(var_16_0.name, FONT_NAME, 30)
		local var_16_15 = cc.Label:createWithTTF(var_16_0.name, FONT_NAME, 30)
		local var_16_16, var_16_17 = var_16_5:getPosition()

		var_16_14:setAnchorPoint(cc.p(0, 0.5))
		var_16_14:setPosition(var_16_16 - 2, var_16_17)
		var_16_14:setColor(cc.c3b(255, 71, 255))
		var_16_15:setAnchorPoint(cc.p(0, 0.5))
		var_16_15:setPosition(var_16_16 + 2, var_16_17)
		var_16_15:setColor(cc.c3b(78, 255, 255))
		var_16_4:addChild(var_16_14)
		var_16_4:addChild(var_16_15)

		local var_16_18 = {}

		if var_16_0.isDouble then
			for iter_16_0 = 1, 4 do
				local var_16_19 = var_16_12:getChildByName("studentItem" .. iter_16_0)

				var_16_19.lineNode = var_16_12:getChildByName("line" .. iter_16_0)
				var_16_18[#var_16_18 + 1] = var_16_19
			end

			for iter_16_1 = 1, 4 do
				local var_16_20 = var_16_13:getChildByName("studentItem" .. iter_16_1)

				var_16_20.lineNode = var_16_13:getChildByName("line" .. iter_16_1)
				var_16_18[#var_16_18 + 1] = var_16_20
			end
		else
			for iter_16_2 = 1, 4 do
				local var_16_21 = var_16_12:getChildByName("studentItem" .. iter_16_2)

				var_16_21.lineNode = var_16_12:getChildByName("line" .. iter_16_2)
				var_16_18[#var_16_18 + 1] = var_16_21
			end
		end

		if var_16_0.bondStatus == var_0_0.UNACTIVE_NONE or var_16_0.bondStatus == var_0_0.UNACTIVE_UNALL then
			var_16_8:setVisible(false)
			var_16_9:setVisible(false)
			var_16_10:setVisible(false)
			var_16_11:setVisible(true)
		elseif var_16_0.bondStatus == var_0_0.CANACTIVE then
			var_16_8:setVisible(false)
			var_16_9:setVisible(true)
			var_16_10:setVisible(false)
			var_16_11:setVisible(false)
		elseif var_16_0.bondStatus == var_0_0.UNLEVELUP then
			var_16_8:setVisible(true)
			var_16_8:getChildByName("redDot"):setVisible(false)
			var_16_9:setVisible(false)
			var_16_10:setVisible(false)
			var_16_11:setVisible(false)
		elseif var_16_0.bondStatus == var_0_0.CANLEVELUP then
			var_16_8:setVisible(true)
			var_16_8:getChildByName("redDot"):setVisible(true)
			var_16_9:setVisible(false)
			var_16_10:setVisible(false)
			var_16_11:setVisible(false)
		else
			var_16_8:setVisible(false)
			var_16_9:setVisible(false)
			var_16_10:setVisible(true)
			var_16_11:setVisible(false)
		end

		var_16_6:loadTexture(var_0_3[var_16_0.curLevel], var_0_10)
		var_16_7:setString(var_16_0.des)

		if var_16_0.curLevel == 0 then
			var_16_7:setColor(cc.c3b(196, 187, 221))
		else
			var_16_7:setColor(cc.c3b(255, 255, 255))
		end

		for iter_16_3 = 1, #var_16_18 do
			local var_16_22 = var_16_18[iter_16_3]

			if iter_16_3 <= var_16_1 then
				var_16_22:setVisible(true)

				local var_16_23 = var_16_0.playerList[iter_16_3]
				local var_16_24 = var_16_22:getChildByName("bg")
				local var_16_25 = var_16_22:getChildByName("name")
				local var_16_26 = var_16_22:getChildByName("name_bg")
				local var_16_27 = var_16_22:getChildByName("kuang")
				local var_16_28 = var_16_22.lineNode

				var_16_24:loadTexture(var_16_0.playerList[iter_16_3].bgPath, var_0_10)
				var_16_25:setString(var_16_23.name)

				local var_16_29

				if config._DEBUG then
					var_16_29 = cc.Sprite:create("BondLayer/student_mask.png") or cc.Sprite:createWithSpriteFrameName("BondLayer/student_mask.png")
				end

				var_16_29:setScale(0.9)

				local var_16_30 = cc.Sprite:create(var_16_23.playerPath)

				var_16_30:setScale(0.46)

				local var_16_31 = cc.ClippingNode:create(var_16_29)

				var_16_31:setAlphaThreshold(0)
				var_16_31:setContentSize(cc.size(52, 143))
				var_16_31:setPosition(cc.p(56, 109))
				var_16_31:addChild(var_16_30)
				var_16_22:addChild(var_16_31)

				local var_16_32 = ccui.ImageView:create("BondLayer/lock.png", var_0_10)

				var_16_32:setPosition(cc.p(90, 40))
				var_16_26:addChild(var_16_32)

				if var_16_23.isHave == 1 then
					var_16_24:setOpacity(255)
					var_16_27:setOpacity(255)
					var_16_30:setOpacity(255)
					var_16_32:setVisible(false)
				else
					var_16_24:setOpacity(165.75)
					var_16_27:setOpacity(165.75)
					var_16_30:setOpacity(165.75)
					var_16_32:setVisible(true)
				end

				if iter_16_3 ~= 5 and var_16_28 and var_16_23.isHave == 1 and var_16_0.playerList[iter_16_3 - 1] and var_16_0.playerList[iter_16_3 - 1].isHave == 1 or iter_16_3 == 5 and var_16_28 and var_16_23.isHave == 1 and var_16_0.playerList[1] and var_16_0.playerList[1].isHave == 1 then
					var_16_28:loadTexture(var_0_5[2], var_0_10)
				elseif var_16_28 then
					var_16_28:loadTexture(var_0_5[1], var_0_10)
				end

				var_16_27:setLocalZOrder(1)
				var_16_26:setLocalZOrder(1)
				var_16_25:setLocalZOrder(1)
			else
				var_16_22:setVisible(false)

				if var_16_22.lineNode then
					var_16_22.lineNode:setVisible(false)
				end
			end
		end

		var_16_8:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("打开羁绊详情弹窗")
			self.bondDetailPanelNode:setVisible(true)
			self:onBtnDetailCallback(arg_17_0, arg_17_1)
		end)
		var_16_9:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("打开羁绊详情弹窗")
			self.bondDetailPanelNode:setVisible(true)
			self:onBtnDetailCallback(arg_18_0, arg_18_1)
		end)
		var_16_10:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("打开羁绊详情弹窗")
			self.bondDetailPanelNode:setVisible(true)
			self:onBtnDetailCallback(arg_19_0, arg_19_1)
		end)
		var_16_11:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_16_0.bondStatus == var_0_0.UNACTIVE_UNALL or var_16_0.bondStatus == var_0_0.UNACTIVE_NONE then
				print("无法激活")
				self:jumpConfirmPanel(0)
			elseif var_16_0.bondStatus == var_0_0.UNLEVELUP then
				print("无法升级")
				self:jumpConfirmPanel(var_16_0.curLevel)
			end
		end)

		var_16_8.indexId = var_16_0.id
		var_16_9.indexId = var_16_0.id
		var_16_10.indexId = var_16_0.id
		var_16_4.indexId = var_16_0.id

		var_16_4:setTouchEnabled(false)

		return var_16_2
	end, function(arg_21_0, arg_21_1)
		print("click ")
		print("打开羁绊详情弹窗")
		self.bondDetailPanelNode:setVisible(true)
		self:onBtnDetailCallback({
			indexId = arg_21_1:getChildByName("item").indexId
		})
	end)

	self.listViewNode:setPosition(cc.p(26, 0 - GameDisplay.fix_y))
	self.root:addChild(self.listViewNode)
end

function BondLayer:scrollToIndex(arg_22_1)
	local var_22_0 = 1
	local var_22_1 = bond_manager:getBondInfo()

	for iter_22_0, iter_22_1 in pairs(var_22_1) do
		if iter_22_1.id == arg_22_1 then
			var_22_0 = iter_22_0

			break
		end
	end

	local var_22_2 = 0

	if var_22_0 >= 2 then
		var_22_2 = math.min(100, math.floor(100 * (var_22_0 + 1) / #var_22_1))
	end

	if self.scrollScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.scrollScheduler)
	end

	self.scrollScheduler = self.scheduler:scheduleScriptFunc(function()
		if self.scrollScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.scrollScheduler)
		end

		self.listViewNode:scrollToPercent(var_22_2, nil, false)
	end, 0, false)
end

function BondLayer:onBtnDetailCallback(arg_24_1, arg_24_2)
	print("bondDetailPanel")

	local var_24_0 = self.bondDetailPanelNode:getChildByName("bg")
	local var_24_1 = self.bondDetailPanelNode:getChildByName("postcard_bg")
	local var_24_2 = self.bondDetailPanelNode:getChildByName("title")
	local var_24_3 = self.bondDetailPanelNode:getChildByName("effectPanel")
	local var_24_4 = self.bondDetailPanelNode:getChildByName("studentPanel")
	local var_24_5 = var_24_4:getChildByName("listView")
	local var_24_6 = var_24_4:getChildByName("item")

	var_24_6:setVisible(false)

	local var_24_7 = self.bondDetailPanelNode:getChildByName("btn_operate")
	local var_24_8 = arg_24_1.indexId

	self.curBondDetailInfo = cloneconf(bond_manager:getBondInfo(arg_24_1.indexId))

	if self.curBondDetailInfo.postcard == nil then
		var_24_0:loadTexture("BondLayer/bondDetail/bg0.png", var_0_10)
		var_24_0:setAnchorPoint(cc.p(0, 0))
		var_24_0:setPosition(cc.p(40, 288))
		var_24_1:setVisible(false)
		self.postCardNode:setVisible(false)
		var_24_2:setPositionY(805)
		var_24_3:setPositionY(545)
		var_24_4:setPositionY(316)
		var_24_7:setPositionY(241)
	else
		var_24_0:loadTexture("BondLayer/bondDetail/bg1.png", var_0_10)
		var_24_0:setAnchorPoint(cc.p(0, 0))
		var_24_0:setPosition(cc.p(40, 125))
		var_24_1:setVisible(true)
		var_24_1:setAnchorPoint(cc.p(0, 0))
		var_24_1:setPosition(cc.p(80, 625))
		self.postCardNode:setVisible(true)
		self.postCardNode:loadTexture("mainScenebg/bondpostcard/" .. self.curBondDetailInfo.postcard .. ".png")
		self.postCardNode:setAnchorPoint(cc.p(0, 0))
		self.postCardNode:setPosition(cc.p(85, 630))
		self.postCardNode:setScale(0.9)

		if self.curBondDetailInfo.bondStatus ~= var_0_0.CANACTIVE and self.curBondDetailInfo.bondStatus ~= var_0_0.UNACTIVE_NONE and self.curBondDetailInfo.bondStatus ~= var_0_0.UNACTIVE_UNALL then
			self.maskNode:setVisible(false)
		else
			self.maskNode:setContentSize(self.postCardNode:getContentSize())
			self.maskNode:setVisible(true)
		end

		var_24_2:setPositionY(965)
		var_24_3:setPositionY(395)
		var_24_4:setPositionY(166)
		var_24_7:setPositionY(91)
	end

	var_24_2:setString(self.curBondDetailInfo.name)

	if self.curBondDetailInfo.bondStatus == var_0_0.HAVEACTIVATED then
		var_24_7:setVisible(false)
	else
		var_24_7:setVisible(true)
		var_24_7:loadTextures(var_0_4[self.curBondDetailInfo.bondStatus], nil, var_0_4[self.curBondDetailInfo.bondStatus], var_0_10)
	end

	var_24_7:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curBondDetailInfo.bondStatus == var_0_0.CANACTIVE or self.curBondDetailInfo.bondStatus == var_0_0.CANLEVELUP then
			print("可以激活")
			bond_manager:operateBond({
				indexId = var_24_8,
				id = self.curBondDetailInfo.id,
				maxLevel = self.curBondDetailInfo.maxLevel,
				addLevel = self.curBondDetailInfo.addLevel,
				curLevel = self.curBondDetailInfo.curLevel
			}, function(arg_26_0)
				if not arg_26_0.addLevel then
					-- block empty
				end

				self:onBtnDetailCallback({
					indexId = var_24_8
				})

				local var_26_1 = {
					name = self.curBondDetailInfo.name,
					des = self.curBondDetailInfo.des,
					bondStatus = self.curBondDetailInfo.bondStatus
				}

				var_26_1.addLevel = arg_26_0.addLevel or 1
				self.curBondResultInfo = var_26_1

				self:onBtnResultCallback()
				self:initPanel()
				self:scrollToIndex(self.curBondDetailInfo.id)
				cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("updateNewSchoolDeanOfficeData")))
			end)
		elseif self.curBondDetailInfo.bondStatus == var_0_0.UNACTIVE_UNALL or self.curBondDetailInfo.bondStatus == var_0_0.UNACTIVE_NONE then
			print("无法激活")
			self:jumpConfirmPanel(0)
		elseif self.curBondDetailInfo.bondStatus == var_0_0.UNLEVELUP then
			print("无法升级")
			self:jumpConfirmPanel(self.curBondDetailInfo.curLevel)
		end
	end)

	for iter_24_0 = 1, 3 do
		local var_24_9 = self.curBondDetailInfo.levelList[iter_24_0]
		local var_24_10 = var_24_3:getChildByName("level" .. iter_24_0)
		local var_24_11 = var_24_10:getChildByName("des")

		var_24_11:getVirtualRenderer():setMaxLineWidth(320)

		local var_24_12 = var_24_10:getChildByName("effect")

		var_24_12:setPositionY(7)

		local var_24_13 = var_24_10:getChildByName("icon")
		local var_24_14 = var_24_10:getChildByName("btn_plot")

		if iter_24_0 <= self.curBondDetailInfo.curLevel then
			var_24_11:setColor(cc.c3b(255, 255, 255))
			var_24_12:setColor(cc.c3b(255, 216, 133))
		else
			var_24_11:setColor(cc.c3b(137, 137, 137))
			var_24_12:setColor(cc.c3b(137, 137, 137))
		end

		if string.utf8len(var_24_9.des1) > 17 then
			var_24_11:setFontSize(18)
		else
			var_24_11:setFontSize(24)
		end

		var_24_11:setString(var_24_9.des1)
		var_24_12:setString(var_24_9.des3)

		if (self.curBondDetailInfo.bondStatus == var_0_0.CANACTIVE or self.curBondDetailInfo.bondStatus == var_0_0.CANLEVELUP) and iter_24_0 <= self.curBondDetailInfo.maxLevel and iter_24_0 > self.curBondDetailInfo.curLevel then
			var_24_13:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(1), cc.FadeIn:create(1)))))
		else
			var_24_13:stopAllActions()
			var_24_13:setOpacity(255)
		end

		if var_24_9.btnPlotStatus == var_0_1.UNHAVE then
			var_24_14:setVisible(false)
		elseif var_24_9.btnPlotStatus == var_0_1.LOCK then
			var_24_14:setVisible(false)
		elseif var_24_9.btnPlotStatus == var_0_1.FIRST then
			var_24_14:setVisible(true)
			var_24_14:setTouchEnabled(true)
		else
			var_24_14:setVisible(true)
			var_24_14:setTouchEnabled(true)
		end

		local var_24_15 = var_0_2[2]

		var_24_14:setPositionY(62)
		var_24_14:loadTextures(var_24_15, var_24_15, var_24_15, var_0_10)
		var_24_14:getChildByName("redDot"):setVisible(var_24_9.btnPlotStatus == var_0_1.FIRST)
		var_24_14:addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_24_9.btnPlotStatus == var_0_1.LOCK then
				global_ShowBlockWords(L_BOND_TIPS.STILL_LOCK)
			else
				self:autoPlayPlotTalk(iter_24_0)
				var_24_14:getChildByName("redDot"):setVisible(false)
			end
		end)
	end

	var_24_5:removeAllItems()

	if self.curBondDetailInfo.playerList == nil then
		return
	end

	for iter_24_1 = 1, #self.curBondDetailInfo.playerList do
		local var_24_16 = self.curBondDetailInfo.playerList[iter_24_1]
		local var_24_17 = var_24_6:clone()

		var_24_17:setName("item" .. iter_24_1)
		var_24_17:setVisible(true)
		var_24_17:setScale(0.9)
		var_24_17:setContentSize(cc.size(110, 90))

		local var_24_18 = var_24_17:getChildByName("bg")
		local var_24_19 = var_24_17:getChildByName("name")
		local var_24_20 = var_24_17:getChildByName("player")
		local var_24_21 = var_24_17:getChildByName("type")
		local var_24_22 = var_24_17:getChildByName("contract")

		var_24_17:getChildByName("lock"):setVisible(var_24_16.isHave ~= 1)
		var_24_22:setVisible(var_24_16.isHave == 1 and var_24_16.curVibrationLevel ~= 0)
		var_24_22:setPosition(cc.p(60, 65))
		var_24_22:loadTexture(var_24_16.contractPath, var_0_10)
		var_24_18:loadTexture(var_24_16.detailBgPath, var_0_10)
		var_24_20:loadTexture(var_24_16.detailPlayerPath)
		var_24_20:setScale(0.85)
		var_24_20:setPosition(cc.p(var_24_20:getPositionX() + 5, var_24_20:getPositionY() + 5))
		var_24_21:loadTexture(var_24_16.typePath, var_0_10)
		var_24_21:setPosition(cc.p(-130, -90))
		var_24_19:setString(var_24_16.name)
		var_24_19:setPositionX(45)

		local var_24_23 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_10)

		var_24_23:setPosition(cc.p(110, 85))
		var_24_17:addChild(var_24_23)
		var_24_23:setVisible(var_24_16.isCanVibration == true)
		var_24_18:addTouchEventListener(function(arg_28_0, arg_28_1)
			if arg_28_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not hexie_manager:canShowServant(var_24_16.id) then
				return
			end

			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				cursoul = var_24_16.id,
				exitCallback = function()
					bond_manager:updateBreakOutInfo(function()
						if LayerManager:getCurrentLayerName() == "BondLayer" then
							self:initPanel()
							self:scrollToIndex(self.curBondDetailInfo.id)
							self:onBtnDetailCallback({
								indexId = var_24_8
							})
						end
					end)
				end
			})
		end)
		var_24_5:pushBackCustomItem(var_24_17)
	end

	var_24_5:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	var_24_5:setItemsMargin(0)
	var_24_5:refreshView()
	var_24_5:jumpToLeft()

	for iter_24_2, iter_24_3 in pairs(self.bondDetailPanelNode:getChildren()) do
		iter_24_3.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - iter_24_3:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		iter_24_3:setPositionY(iter_24_3.full_posY)
	end
end

function BondLayer:onBtnResultCallback()
	print("bondResultPanel")

	if self.curBondResultInfo == nil then
		return
	end

	self.bondResultlPanelNode:setVisible(true)

	self.isCanCloseResultPanel = false

	local var_31_0 = self.bondResultlPanelNode:getChildByName("name")
	local var_31_1 = self.bondResultlPanelNode:getChildByName("name_kuang")

	self.bondResultlPanelNode:getChildByName("di"):setVisible(false)
	self.bondResultlPanelNode:getChildByName("element1"):setVisible(false)
	self.bondResultlPanelNode:getChildByName("element2"):setVisible(false)
	self.bondResultlPanelNode:getChildByName("element3"):setVisible(false)

	local var_31_2 = self.bondResultlPanelNode:getChildByName("label1")
	local var_31_3 = self.bondResultlPanelNode:getChildByName("label2")
	local var_31_4 = self.bondResultlPanelNode:getChildByName("label1_1")
	local var_31_5 = self.bondResultlPanelNode:getChildByName("label2_1")

	self.bondResultlPanelNode:getChildByName("title"):setVisible(false)
	var_31_0:setString(self.curBondResultInfo.name)
	var_31_4:setPositionX(330)
	var_31_4:setString(self.curBondResultInfo.des)
	self.bondResultlPanelNode:getChildByName("new"):setVisible(false)
	var_31_1:setVisible(false)
	var_31_0:setVisible(false)
	var_31_2:setVisible(false)
	var_31_3:setVisible(false)
	var_31_4:setVisible(false)
	var_31_5:setVisible(false)
	self.bondResultlPanelNode:getChildByName("tips"):setVisible(false)

	local var_31_6 = self.bondResultlPanelNode:getChildByName("spine")

	if var_31_6 ~= nil then
		var_31_6:removeFromParent()

		var_31_6 = nil
	end

	if self.curBondResultInfo.bondStatus == var_0_0.CANLEVELUP then
		var_31_6 = L2Skeleton:create("spine/ui/jiban/jibantisheng.json", "spine/ui/jiban/jibantisheng.atlas")

		var_31_6:refreshSkeleton()
		var_31_6:play("jibantisheng", false)
	else
		var_31_6 = L2Skeleton:create("spine/ui/jiban/jibanjihuo.json", "spine/ui/jiban/jibanjihuo.atlas")

		var_31_6:refreshSkeleton()
		var_31_6:play("jibanjihuo", false)
	end

	var_31_6:setName("spine")
	var_31_6:setPosition(cc.p(355, 530))
	var_31_6:setVisible(true)
	var_31_6:registerListener(SP_ANIMATION_COMPLETE, function(arg_32_0)
		return
	end)
	self:bondSchedulerWithCallback(function()
		var_31_1:setVisible(true)
		var_31_0:setVisible(true)
		var_31_4:setVisible(true)

		self.isCanCloseResultPanel = true
	end)
	self.bondResultlPanelNode:addChild(var_31_6)
	var_31_1:setLocalZOrder(1)
	var_31_0:setLocalZOrder(1)
	var_31_2:setLocalZOrder(1)
	var_31_3:setLocalZOrder(1)
	var_31_4:setLocalZOrder(1)
	var_31_5:setLocalZOrder(1)

	var_31_6.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_31_6:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	var_31_6:setPositionY(var_31_6.full_posY)
end

function BondLayer.getTableView(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5, arg_34_6)
	local var_34_0 = arg_34_3.width
	local var_34_1 = arg_34_3.height
	local var_34_2 = cc.TableView:create(arg_34_4)

	var_34_2:setVisible(true)
	var_34_2:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_34_2:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_34_2:setDelegate()
	var_34_2:registerScriptHandler(function(arg_35_0)
		return arg_34_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_34_2:registerScriptHandler(function(arg_36_0)
		arg_34_0:scrollViewDidScroll(arg_36_0)
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_34_2:registerScriptHandler(function(arg_37_0, arg_37_1)
		arg_34_6(arg_37_0, arg_37_1)
	end, cc.TABLECELL_TOUCHED)
	var_34_2:registerScriptHandler(function(arg_38_0, arg_38_1)
		if arg_34_1[arg_38_1 + 1].isDouble == true and arg_38_1 + 1 == arg_34_2 then
			return var_34_0, var_34_1 + 240 + 80 + GameDisplay.fix_y
		elseif arg_34_1[arg_38_1 + 1].isDouble == true and arg_38_1 + 1 ~= arg_34_2 then
			return var_34_0, var_34_1 + 240
		elseif arg_34_1[arg_38_1 + 1].isDouble ~= true and arg_38_1 + 1 == arg_34_2 then
			return var_34_0, var_34_1 + 80 + GameDisplay.fix_y
		else
			return var_34_0, var_34_1
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_34_2:registerScriptHandler(function(arg_39_0, arg_39_1)
		return arg_34_5(arg_39_0, arg_39_1, arg_34_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_34_2:reloadData()
	var_34_2:setAnchorPoint(cc.p(0, 1))

	return var_34_2
end

function BondLayer.scrollViewDidScroll(arg_40_0, arg_40_1)
	return
end

function BondLayer:autoPlayPlotTalk(arg_41_1)
	local var_41_0

	if arg_41_1 == nil then
		arg_41_1 = self.curBondDetailInfo.curLevel
	else
		var_41_0 = arg_41_1
	end

	bond_manager:playBondPlot({
		id = self.curBondDetailInfo.id,
		level = arg_41_1
	}, function()
		self:playPlotTalk((bond_manager:getClassificationId(self.curBondDetailInfo, var_41_0)))
	end)
end

function BondLayer:playPlotTalk(arg_43_1)
	local var_43_0

	if arg_43_1 == nil or not bond_story_data[arg_43_1] then
		do return end

		var_43_0 = {
			key = "bond_story",
			testWords = bond_story_data[arg_43_1].dec
		}
	end

	var_43_0.testTitle = bond_story_data[arg_43_1].name

	LayerManager:pushInLayer("PopActivityDetail", var_43_0)
	self.bondResultlPanelNode:setVisible(false)
end

function BondLayer:bondSchedulerWithCallback(arg_44_1)
	if self.bondScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.bondScheduler)
	end

	self.bondScheduler = self.scheduler:scheduleScriptFunc(function()
		if type(arg_44_1) == "function" then
			arg_44_1()
		end

		if self.bondScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.bondScheduler)
		end
	end, 1, false)
end

function BondLayer.jumpConfirmPanel(arg_46_0, arg_46_1)
	arg_46_1 = arg_46_1 or 0

	local var_46_0 = ConfirmDialogSprite:create(L_BOND_TIPS.NO_MATCH, L_BOND_TIPS.NO_MATCH_TO_JUMP[arg_46_1 + 1], {
		surecallback = function()
			LayerManager:removePopLayer()
			LayerManager:switchShowLayer("TwisteggLayer")
		end
	})

	global_basic_scene:addChild(var_46_0, 10)
	var_46_0:setName("dialog")
end
