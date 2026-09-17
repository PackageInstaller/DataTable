ActivityFallingLayer = class("ActivityFallingLayer", function()
	return ccui.Layout:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local L2Actor = require("view.Sprite.L2Actor")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local jumpgame_conf_data = require("data.jumpgame_conf_data")
local item_data = require("data.item_data")
local drop_manager = require("controller.drop_manager")
local network = require("network.network")
local var_0_8 = "ActivityFallingLayer/"
local var_0_9 = 570
local var_0_10 = 140

function ActivityFallingLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityFallingLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityFallingLayer:init(arg_3_1)
	self._rootlayer = cc.Layer:create()

	self:addChild(self._rootlayer)

	local var_3_0 = ccui.Layout:create()

	var_3_0:setContentSize(cc.size(640, 1600))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setCascadeOpacityEnabled(false)
	var_3_0:setBackGroundColorOpacity(128)
	var_3_0:setAnchorPoint(0.5, 0.5)
	var_3_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_3_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_3_0:setTouchEnabled(false)
	var_3_0:setLocalZOrder(1000)
	var_3_0:setName("layout")
	var_3_0:setVisible(false)
	self._rootlayer:addChild(var_3_0)

	if arg_3_1 then
		self.activityid = arg_3_1.activityid or 550
	end

	self:initData()
	self:initReward(function()
		self:initUI()
	end)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			if self.scheduleid then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleid)
			end

			if self.scoreScheduleid then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scoreScheduleid)
			end
		end
	end)
end

function ActivityFallingLayer:initData()
	self.data = {}

	if jumpgame_conf_data[self.activityid .. "_jumpgame"] then
		local var_6_0 = 1

		while jumpgame_conf_data[self.activityid .. "_jumpgame"]["score" .. var_6_0] and jumpgame_conf_data[self.activityid .. "_jumpgame"]["drop" .. var_6_0] do
			self.data[var_6_0] = {}
			self.data[var_6_0].drop = jumpgame_conf_data[self.activityid .. "_jumpgame"]["drop" .. var_6_0]
			self.data[var_6_0].score = jumpgame_conf_data[self.activityid .. "_jumpgame"]["score" .. var_6_0]
			var_6_0 = var_6_0 + 1
		end

		self.tableSize = var_6_0
	else
		global_ShowBlockWords(L_FALLINGLAYER[1])

		return
	end

	table.sort(self.data, function(arg_7_0, arg_7_1)
		return arg_7_0.score < arg_7_1.score
	end)
end

function ActivityFallingLayer:initUI()
	self:initRewardLayer()
	self:initBg()
	self:initTitle()
	self:initKeyBoardListener()
	self:initStartLayer()
	self:initRestartLayer()
	self:initPauseLayer()
end

function ActivityFallingLayer:initBg()
	local var_9_0 = ccui.ImageView:create(var_0_8 .. "bg.png", var_0_0)

	var_9_0:setAnchorPoint(0, 0)
	var_9_0:setPositionY(-100)
	self._rootlayer:addChild(var_9_0)

	local var_9_1 = ccui.Button:create("public/button/bottom_return_btn_archives.png", nil, "public/button/bottom_return_btn_archives.png", var_0_0)

	var_9_1:setPosition(cc.p(50, 80 - GameDisplay.fix_y))
	var_9_1:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self._rootlayer:addChild(var_9_1, 9999999)

	self.returnBtn = var_9_1
end

function ActivityFallingLayer:initTitle()
	local var_11_0 = ccui.ImageView:create(var_0_8 .. "title.png", var_0_0)

	var_11_0:setAnchorPoint(0, 1)
	var_11_0:setPosition(0, GameDisplay.origin_design_y + GameDisplay.fix_y)
	var_11_0:setLocalZOrder(1000)
	self._rootlayer:addChild(var_11_0)

	self.hearts = {}

	for iter_11_0 = 1, 5 do
		local var_11_1 = ccui.ImageView:create(var_0_8 .. "heart.png", var_0_0)

		var_11_1:setName("heart" .. iter_11_0)
		var_11_1:setPosition(30 * iter_11_0, 35)
		var_11_0:addChild(var_11_1)
		table.insert(self.hearts, var_11_1)
	end

	self.curScore = 0

	local var_11_2 = cc.Label:createWithTTF("" .. 0, FONT_NAME, 40)

	var_11_2:setPosition(300, 35)

	self.curScoreLabel = var_11_2

	var_11_0:addChild(var_11_2)

	local var_11_3 = ccui.Button:create(var_0_8 .. "btn_rank.png", nil, var_0_8 .. "btn_rank.png", var_0_0)

	var_11_3:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityFallingRankLayer", {
			type = "jumpgame",
			activityid = self.activityid,
			maxScore = self.maxScore
		})
	end)
	var_11_3:setPosition(570, 35)
	var_11_0:addChild(var_11_3)

	local var_11_4 = ccui.Button:create(var_0_8 .. "btn_reward.png", nil, var_0_8 .. "btn_reward.png", var_0_0)

	var_11_4:setPosition(450, 35)
	var_11_4:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.rewardLayer:setVisible(true)
	end)
	var_11_0:addChild(var_11_4)

	local var_11_5 = ccui.ImageView:create(var_0_8 .. "stab.png", var_0_0)

	self.stab = var_11_5

	var_11_5:setAnchorPoint(0, 0)
	var_11_5:setPosition(0, -var_11_0:getContentSize().height + 10)
	var_11_0:addChild(var_11_5)
end

function ActivityFallingLayer:initFloorLayer()
	local var_14_0 = cc.Layer:create()

	self._rootlayer:addChild(var_14_0)
	var_14_0:setPosition(0, 0)
	var_14_0:setAnchorPoint(0, 0)

	self.floorLayer = var_14_0

	for iter_14_0, iter_14_1 in pairs({
		{
			320,
			500
		},
		{
			100,
			300
		},
		{
			450,
			0
		},
		{
			300,
			-200
		}
	}) do
		self.floorLayer:addChild((self:initFloor(cc.p(iter_14_1[1], iter_14_1[2]))))
	end
end

function ActivityFallingLayer.initFloor(arg_15_0, arg_15_1)
	local var_15_0 = ccui.ImageView:create(var_0_8 .. "floor.png", var_0_0)

	var_15_0:setName("on")
	var_15_0:setPosition(arg_15_1)

	return var_15_0
end

local var_0_11 = false
local var_0_12 = ""

function ActivityFallingLayer:initBaseGame()
	self:initFloorLayer()

	local var_16_0 = self:createL2Actor(209620)

	function var_16_0.resumePos()
		var_16_0:setPosition(320, 640)
		var_16_0:setPosition(320, 900)
	end

	var_16_0.resumePos()
	var_16_0:setName("player")
	self._rootlayer:addChild(var_16_0)

	self.player = var_16_0

	local var_16_1 = ccui.Button:create(var_0_8 .. "btn_left.png", nil, var_0_8 .. "btn_left.png", var_0_0)

	var_16_1:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 == ccui.TouchEventType.ended then
			var_0_11 = false

			var_16_0:playAni(nil, "idle", true)
		end

		if arg_18_1 == ccui.TouchEventType.began then
			var_0_12 = "left"
			var_0_11 = true

			var_16_0:playAni(nil, "run", true)
			var_16_0:setScaleX(-1)
		end
	end)
	var_16_1:setPosition(100, 100)
	var_16_1:setLocalZOrder(100)
	self._rootlayer:addChild(var_16_1)

	local var_16_2 = ccui.Button:create(var_0_8 .. "btn_right.png", nil, var_0_8 .. "btn_right.png", var_0_0)

	var_16_2:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 == ccui.TouchEventType.ended then
			var_0_11 = false

			var_16_0:playAni(nil, "idle", true)
		end

		if arg_19_1 == ccui.TouchEventType.began then
			var_0_12 = "right"
			var_0_11 = true

			var_16_0:playAni(nil, "run", true)
			var_16_0:setScaleX(1)
		end
	end)
	var_16_2:setPosition(540, 100)
	var_16_2:setLocalZOrder(100)
	self._rootlayer:addChild(var_16_2)

	local var_16_3 = ccui.Button:create(var_0_8 .. "btn_pause.png", nil, var_0_8 .. "btn_pause.png", var_0_0)

	var_16_3:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isDefeat then
			return
		end

		self:unscheduleUpdate()
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleid)
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scoreScheduleid)
		self.pauseLayer:setVisible(true)
		self._rootlayer:getChildByName("layout"):setVisible(true)
	end)
	var_16_3:setPosition(320, 100)
	var_16_3:setLocalZOrder(100)
	self._rootlayer:addChild(var_16_3)

	self.floorSpeed = 200
	self.initialVelocity = -150

	local var_16_4 = -980
	local var_16_5 = 900

	self.heart = 5

	local var_16_6 = false
	local var_16_7 = 0
	local var_16_8 = 350

	function self.update(arg_21_0)
		if var_16_0:getPositionY() > GameDisplay.origin_design_y - 100 or var_16_0:getPositionY() < -70 or self.heart <= 0 then
			if not self.invincible then
				self.isDefeat = true

				self.restartLayer:setVisible(true)
				self._rootlayer:getChildByName("layout"):setVisible(true)
				self.restartLayer.curSocreLabel:setString(self.curScore)
				var_16_0:playAni(nil, "idle", true)

				if self.curScore > self.maxScore then
					self:updateAllScore()
				end

				self:unscheduleUpdate()
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleid)
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scoreScheduleid)

				return
			else
				self.player:resumePos()
			end
		end

		var_16_7 = 0

		local var_21_0 = self.floorSpeed + arg_21_0
		local var_21_1 = var_16_0:getPositionX()
		local var_21_2 = var_16_0:getPositionY()
		local var_21_3 = self.initialVelocity + var_16_4 * arg_21_0

		if not var_16_6 then
			var_16_0:setPositionY(var_21_2 + (self.initialVelocity + var_16_4 * arg_21_0) * arg_21_0)
		else
			var_16_0:setPositionY(var_21_2 + var_16_5 * arg_21_0)
		end

		self.initialVelocity = var_21_3

		if self.floorLayer then
			for iter_21_0, iter_21_1 in pairs((self.floorLayer:getChildren())) do
				local var_21_4 = iter_21_1:getPositionX()
				local var_21_5 = iter_21_1:getPositionY()

				if var_21_5 > 1200 then
					iter_21_1:stopAllActions()
					iter_21_1:removeFromParent()

					break
				end

				iter_21_1:setPositionY(var_21_5 + var_21_0 * arg_21_0)

				if iter_21_1.isLeft then
					if var_21_4 > 120 then
						iter_21_1:setPositionX(var_21_4 - var_21_0 / 2 * arg_21_0)
					else
						iter_21_1.isRight = true
						iter_21_1.isLeft = false
					end
				elseif iter_21_1.isRight then
					if var_21_4 < 520 then
						iter_21_1:setPositionX(var_21_4 + var_21_0 / 2 * arg_21_0)
					else
						iter_21_1.isLeft = true
						iter_21_1.isRight = false
					end
				end

				local var_21_6 = iter_21_1:getBoundingBox()

				var_21_6.width = math.floor(var_21_6.width)
				var_21_6.height = math.floor(var_21_6.height)
				var_21_6.x = math.floor(var_21_6.x)
				var_21_6.y = math.floor(var_21_6.y)

				local var_21_7 = var_16_0:getBoundingBox()

				var_21_7.width = 50
				var_21_7.height = 60
				var_21_7.x = var_16_0:getPositionX() - var_21_7.width / 2
				var_21_7.y = var_16_0:getPositionY() - 5

				if cc.rectIntersectsRect(var_21_6, var_21_7) then
					if iter_21_1:getName() == "spring" and var_16_6 then
						break
					end

					if var_21_5 <= var_21_2 then
						var_16_0:setPositionY(var_21_5 + 16)

						if iter_21_1:getName() ~= "slide" then
							if iter_21_1.isLeft then
								var_16_0:setPositionX(var_21_1 - var_21_0 / 2 * arg_21_0)
							elseif iter_21_1.isRight then
								var_16_0:setPositionX(var_21_1 + var_21_0 / 2 * arg_21_0)
							end
						end
					elseif iter_21_1:getName() == "spring" then
						break
					end

					self.initialVelocity = -150

					if not iter_21_1.isAdd then
						iter_21_1.isAdd = true

						if iter_21_1:getName() ~= "nail" and self.heart < 5 then
							self.heart = self.heart + 1

							for iter_21_2, iter_21_3 in pairs(self.hearts) do
								if iter_21_3:getName() == "heart" .. self.heart then
									iter_21_3:setVisible(true)
								end
							end
						end
					end

					if iter_21_1:getName() == "off" then
						iter_21_1:runAction((cc.Sequence:create(cc.DelayTime:create(1), (cc.CallFunc:create(function()
							iter_21_1:stopAllActions()
							iter_21_1:removeFromParent()
						end)))))
					elseif iter_21_1:getName() == "spring" then
						if not iter_21_1.isRunAction then
							iter_21_1.isRunAction = true

							iter_21_1:loadTexture(var_0_8 .. "floor_spring_on.png", var_0_0)
							var_16_0:runAction((cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
								var_16_6 = true

								iter_21_1:loadTexture(var_0_8 .. "floor_spring_off.png", var_0_0)
							end), cc.DelayTime:create(0.2), (cc.CallFunc:create(function()
								var_16_6 = false
								iter_21_1.isRunAction = false
							end)))))
						end
					elseif iter_21_1:getName() == "slide" then
						if iter_21_1:getTag() == 1 then
							var_16_0:setPositionX(var_21_1 - 200 * arg_21_0)

							var_16_7 = -200
						else
							var_16_0:setPositionX(var_21_1 + 200 * arg_21_0)

							var_16_7 = 200
						end
					elseif iter_21_1:getName() == "nail" and not iter_21_1.isHurt then
						self.heart = self.heart - 1
						iter_21_1.isHurt = true

						for iter_21_4, iter_21_5 in pairs(self.hearts) do
							if iter_21_5:getName() == "heart" .. self.heart + 1 then
								iter_21_5:setVisible(false)
							end
						end
					end
				end
			end
		end

		if var_0_11 then
			if var_0_12 == "left" and var_21_1 > 0 then
				var_16_0:setPositionX(var_21_1 + (-var_16_8 + var_16_7) * arg_21_0)
			elseif var_0_12 == "right" and var_21_1 < 640 then
				var_16_0:setPositionX(var_21_1 + (var_16_8 + var_16_7) * arg_21_0)
			end
		end
	end

	self:scheduleUpdateWithPriorityLua(self.update, 0)
	self:initScheduleFloor()
	self:initScheduleScore()
end

function ActivityFallingLayer:updateAllScore()
	self.maxScore = self.curScore

	self.rewardLayer:getChildByName("bg"):getChildByName("scoreLabel"):setString(self.maxScore)
	self.maxScoreLabel.update(self.maxScore)
	self:updateScore(self.maxScore)
	self.rewardTableView:reloadData()
end

function ActivityFallingLayer:updateUI()
	self.floorLayer:removeAllChildren()
	self:initFloorLayer()
	self:updateScore(self.curScore)
	self._rootlayer:getChildByName("player").resumePos()

	self.curScore = 0
	self.initialVelocity = -150
	self.floorSpeed = 200

	self:scheduleUpdateWithPriorityLua(self.update, 0)
	self:initScheduleFloor()
	self:initScheduleScore()
	self.curScoreLabel:setString(self.curScore)

	self.heart = 5

	for iter_26_0, iter_26_1 in pairs(self.hearts) do
		iter_26_1:setVisible(true)
	end
end

function ActivityFallingLayer:initStartLayer()
	self.startLayer = cc.Layer:create()

	self._rootlayer:addChild(self.startLayer)

	local var_27_0 = ccui.ImageView:create(var_0_8 .. "wind_start.png", var_0_0)

	var_27_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	self.startLayer:addChild(var_27_0)
	self.startLayer:setLocalZOrder(1000)

	local var_27_1 = ccui.Button:create(var_0_8 .. "btn_start.png", nil, var_0_8 .. "btn_start.png", var_0_0)

	var_27_1:setPosition(var_27_0:getContentSize().width / 2, 70)
	var_27_1:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:initBaseGame()
		self.startLayer:setVisible(false)
		self.returnBtn:setVisible(false)
	end)
	var_27_0:addChild(var_27_1)

	local var_27_2 = cc.Label:createWithTTF(L_FALLINGLAYER[3], FONT_NAME, 30)

	var_27_2:setColor(cc.c3b(246, 82, 246))
	var_27_2:setPosition(var_27_0:getContentSize().width / 2, var_27_0:getContentSize().height - 100)
	var_27_0:addChild(var_27_2)

	local var_27_3 = cc.Label:createWithTTF(self.maxScore, FONT_NAME, 72)

	var_27_3:setPosition(var_27_0:getContentSize().width / 2, var_27_0:getContentSize().height / 2)
	var_27_0:addChild(var_27_3)
end

function ActivityFallingLayer:initRestartLayer()
	self.restartLayer = cc.Layer:create()

	self._rootlayer:addChild(self.restartLayer)

	local var_29_0 = ccui.ImageView:create(var_0_8 .. "wind_pause.png", var_0_0)

	var_29_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	self.restartLayer:addChild(var_29_0)
	self.restartLayer:setLocalZOrder(1000)
	self.restartLayer:setVisible(false)

	local var_29_1 = var_29_0:getContentSize()
	local var_29_2 = cc.Label:createWithTTF(L_FALLINGLAYER[4], FONT_NAME, 30)

	var_29_2:setPosition(var_29_1.width / 2, var_29_1.height - 30)
	var_29_2:setColor(cc.c3b(246, 82, 246))
	var_29_0:addChild(var_29_2)

	local var_29_3 = cc.Label:createWithTTF(self.curScore, FONT_NAME, 72)

	var_29_3:setPosition(var_29_1.width / 2, var_29_1.height / 2)
	var_29_0:addChild(var_29_3)

	self.restartLayer.curSocreLabel = var_29_3

	local var_29_4 = cc.Label:createWithTTF(L_FALLINGLAYER[5] .. self.maxScore, FONT_DES, 24)

	var_29_4:setPosition(var_29_1.width / 2, 20)
	var_29_4:setColor(cc.c3b(246, 82, 246))

	self.maxScoreLabel = var_29_4

	function self.maxScoreLabel.update(arg_30_0)
		var_29_4:setString(L_FALLINGLAYER[5] .. arg_30_0)
	end

	var_29_0:addChild(var_29_4)
	ccui.ImageView:create(var_0_8 .. "wind_shadow.png", var_0_0):setPosition(GameDisplay.cx, GameDisplay.cy - var_29_1.height / 2 - 125)

	local var_29_5 = ccui.Button:create(var_0_8 .. "btn_yellow.png", nil, var_0_8 .. "btn_yellow.png", var_0_0)

	var_29_5:setPosition(490, -100)
	var_29_5:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.isDefeat = false

		self:updateUI()
		self.restartLayer:setVisible(false)
		self._rootlayer:getChildByName("layout"):setVisible(false)
	end)
	var_29_0:addChild(var_29_5)

	local var_29_6 = cc.Label:createWithTTF(L_FALLINGLAYER[6], FONT_NAME, 30)

	var_29_6:setPosition(var_29_5:getContentSize().width / 2, var_29_5:getContentSize().height / 2)
	var_29_6:setColor(cc.c3b(61, 47, 40))
	var_29_5:addChild(var_29_6)

	local var_29_7 = ccui.Button:create(var_0_8 .. "btn_blue.png", nil, var_0_8 .. "btn_blue.png", var_0_0)

	var_29_7:setPosition(150, -100)
	var_29_7:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	var_29_0:addChild(var_29_7)

	local var_29_8 = cc.Label:createWithTTF(L_FALLINGLAYER[7], FONT_NAME, 30)

	var_29_8:setPosition(var_29_7:getContentSize().width / 2, var_29_7:getContentSize().height / 2)
	var_29_8:setColor(cc.c3b(24, 31, 68))
	var_29_7:addChild(var_29_8)
end

function ActivityFallingLayer:initPauseLayer()
	self.pauseLayer = cc.Layer:create()

	self._rootlayer:addChild(self.pauseLayer)

	local var_33_0 = ccui.ImageView:create(var_0_8 .. "wind_pause.png", var_0_0)

	var_33_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	self.pauseLayer:addChild(var_33_0)
	self.pauseLayer:setLocalZOrder(1000)
	self.pauseLayer:setVisible(false)

	local var_33_1 = ccui.ImageView:create(var_0_8 .. "pause.png", var_0_0)

	var_33_1:setPosition(var_33_0:getContentSize().width / 2, var_33_0:getContentSize().height / 2)
	var_33_0:addChild(var_33_1)

	local var_33_2 = ccui.Button:create(var_0_8 .. "btn_yellow.png", nil, var_0_8 .. "btn_yellow.png", var_0_0)

	var_33_2:setPosition(490, -100)
	var_33_2:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.isDefeat = false

		self.pauseLayer:setVisible(false)
		self._rootlayer:getChildByName("layout"):setVisible(false)
		self:scheduleUpdateWithPriorityLua(self.update, 0)
		self:initScheduleFloor()
		self:initScheduleScore()
	end)
	var_33_0:addChild(var_33_2)

	local var_33_3 = cc.Label:createWithTTF(L_FALLINGLAYER[8], FONT_NAME, 30)

	var_33_3:setPosition(var_33_2:getContentSize().width / 2, var_33_2:getContentSize().height / 2)
	var_33_3:setColor(cc.c3b(61, 47, 40))
	var_33_2:addChild(var_33_3)

	local var_33_4 = ccui.Button:create(var_0_8 .. "btn_blue.png", nil, var_0_8 .. "btn_blue.png", var_0_0)

	var_33_4:setPosition(150, -100)
	var_33_4:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	var_33_0:addChild(var_33_4)

	local var_33_5 = cc.Label:createWithTTF(L_FALLINGLAYER[7], FONT_NAME, 30)

	var_33_5:setPosition(var_33_4:getContentSize().width / 2, var_33_4:getContentSize().height / 2)
	var_33_5:setColor(cc.c3b(24, 31, 68))
	var_33_4:addChild(var_33_5)
end

function ActivityFallingLayer:initRewardLayer()
	local var_36_0 = cc.Layer:create()

	self._rootlayer:addChild(var_36_0)

	self.rewardLayer = var_36_0

	var_36_0:setLocalZOrder(9999)
	var_36_0:setVisible(false)

	local var_36_1 = cc.EventListenerTouchOneByOne:create()

	var_36_1:setSwallowTouches(true)
	var_36_1:registerScriptHandler(function(arg_37_0, arg_37_1)
		if var_36_0:isVisible() then
			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_36_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_36_1, var_36_0)

	local var_36_2 = ccui.ImageView:create(var_0_8 .. "rewardbg.png", var_0_0)

	var_36_2:setName("bg")
	var_36_2:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_36_0:addChild(var_36_2)

	local var_36_3 = ccui.Button:create(var_0_8 .. "close.png", nil, var_0_8 .. "close.png", var_0_0)

	var_36_3:setPosition(var_36_2:getContentSize().width - 40, var_36_2:getContentSize().height - 40)
	var_36_3:addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_36_0:setVisible(false)
	end)
	var_36_2:addChild(var_36_3)

	local var_36_4 = ccui.Button:create(var_0_8 .. "info.png", nil, var_0_8 .. "info.png", var_0_0)

	var_36_4:setPosition(35, var_36_2:getContentSize().height - 35)
	var_36_4:addTouchEventListener(function(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityFallingLayer" .. self.activityid
		})
	end)
	var_36_2:addChild(var_36_4)

	local var_36_5 = ccui.ImageView:create(var_0_8 .. "score.png", var_0_0)

	var_36_5:setPosition(120, var_36_2:getContentSize().height - 35)
	var_36_2:addChild(var_36_5)

	local var_36_6 = cc.Label:createWithTTF(self.maxScore, FONT_NAME, 48)

	var_36_6:setPosition(100, var_36_2:getContentSize().height - 80)
	var_36_6:setName("scoreLabel")
	var_36_2:addChild(var_36_6)

	local var_36_7 = ccui.Button:create(var_0_8 .. "btn_getall.png", var_0_8 .. "btn_getall_off.png", var_0_8 .. "btn_getall.png", var_0_0)

	var_36_7:setPosition(var_36_2:getContentSize().width / 2, -70)
	var_36_7:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)

	self.rewardTableView = cc.TableView:create(cc.size(580, 590))

	self.rewardTableView:setPosition(cc.p(16, 22))
	self.rewardTableView:setDelegate()
	self.rewardTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_36_2:addChild(self.rewardTableView)
	self.rewardTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rewardTableView:registerScriptHandler(function(arg_42_0, arg_42_1)
		return var_0_9, var_0_10
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.rewardTableView:registerScriptHandler(function(arg_41_0, arg_41_1)
		local var_41_0 = arg_41_0:dequeueCell()

		if not var_41_0 then
			var_41_0 = cc.TableViewCell:create()

			local var_41_1 = self:createNode(arg_41_1 + 1)

			var_41_1:setName("node")
			var_41_1:setAnchorPoint(cc.p(0, 0))
			var_41_1:setPosition(cc.p(5, 0))

			if arg_41_1 <= math.floor(var_36_2:getContentSize().height / var_0_10) then
				var_41_1:setOpacity(0)
				var_41_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_41_1), cc.FadeIn:create(0.1)))
			else
				var_41_1:setOpacity(255)
			end

			var_41_0:addChild(var_41_1)
		else
			local var_41_2 = var_41_0:getChildByName("node")

			var_41_2:setOpacity(255)
			self:updateNode(var_41_2, arg_41_1 + 1)
		end

		return var_41_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.rewardTableView:registerScriptHandler(function(arg_43_0, arg_43_1)
		return self.tableSize - 1
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.rewardTableView:reloadData()
end

function ActivityFallingLayer:createNode(arg_44_1)
	local var_44_0 = cc.Node:create()
	local var_44_1 = self.data[arg_44_1].score
	local var_44_2 = self.data[arg_44_1].score > self.maxScore and 2 or self.rewardStatus and self.rewardStatus[arg_44_1] and self.rewardStatus[arg_44_1] or 0
	local var_44_3 = ccui.ImageView:create(var_0_8 .. "item.png", var_0_0)

	var_44_3:setName("bg")
	var_44_0:addChild(var_44_3)
	var_44_3:setAnchorPoint(0, 0)

	local var_44_4 = cc.Label:createWithTTF(var_44_1, FONT_NAME, 36)

	var_44_4:setPosition(70, var_44_3:getContentSize().height / 2)
	var_44_4:setName("scoreLabel")
	var_44_0:addChild(var_44_4)

	local var_44_5 = drop_manager:getDropMsg(self.data[arg_44_1].drop)

	for iter_44_0 = 1, 3 do
		local var_44_6 = ItemSpriteActivityRecharge:createSignItem()

		var_44_6:setName("sp" .. iter_44_0)
		var_44_6:setPosition(190 + (iter_44_0 - 1) * 95, var_44_3:getContentSize().height / 2)
		var_44_3:addChild(var_44_6)
		var_44_6:setInfoTouchEvent(true)
		var_44_6:setSwallowTouches(false)
		var_44_6:setVisible(false)
	end

	table.sort(var_44_5.equips, function(arg_45_0, arg_45_1)
		return arg_45_0._index < arg_45_1._index
	end)

	local var_44_7 = {}

	if var_44_5.diamond > 0 then
		table.insert(var_44_7, {
			itemid = "diamond",
			num = var_44_5.diamond,
			name = L_DIAMOND
		})
	end

	if var_44_5.gold > 0 then
		table.insert(var_44_7, {
			itemid = "gold",
			num = var_44_5.gold,
			name = L_GOLD
		})
	end

	local var_44_8 = {}

	for iter_44_1, iter_44_2 in pairs(var_44_5.equips) do
		table.insert(var_44_8, {
			itemid = iter_44_2.dropid,
			num = iter_44_2.dropNum,
			name = item_data[iter_44_2.dropid].name
		})
	end

	for iter_44_3, iter_44_4 in pairs(var_44_8) do
		table.insert(var_44_7, iter_44_4)
	end

	if var_44_7 then
		for iter_44_5, iter_44_6 in pairs(var_44_7) do
			var_44_3:getChildByName("sp" .. iter_44_5):updateSignItemByItemid(var_44_7[iter_44_5].itemid, var_44_7[iter_44_5].num)
			var_44_3:getChildByName("sp" .. iter_44_5):setVisible(true)
		end
	end

	local var_44_9 = ccui.Button:create()

	var_44_9:setName("rewardBtn")
	var_44_9:setPosition(500, var_44_3:getContentSize().height / 2)
	var_44_3:addChild(var_44_9)

	if var_44_2 == 0 then
		var_44_9:loadTextures(var_0_8 .. "btn_get.png", var_0_8 .. "btn_get.png", var_0_8 .. "btn_get.png", var_0_0)
	elseif var_44_2 == 1 then
		var_44_9:loadTextures(var_0_8 .. "btn_reward_on.png", var_0_8 .. "btn_reward_on.png", var_0_8 .. "btn_reward_on.png", var_0_0)
	elseif var_44_2 == 2 then
		var_44_9:loadTextures(var_0_8 .. "btn_reward_off.png", var_0_8 .. "btn_reward_off.png", var_0_8 .. "btn_reward_off.png", var_0_0)
	end

	var_44_9.index = arg_44_1
	var_44_9.status = var_44_2

	var_44_9:addTouchEventListener(function(arg_46_0, arg_46_1)
		if arg_46_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_46_0.status ~= 0 then
			return
		end

		self:touchRward(arg_46_0.index)
	end)

	return var_44_0
end

function ActivityFallingLayer:updateNode(arg_47_1, arg_47_2)
	arg_47_1:getChildByName("scoreLabel"):setString(self.data[arg_47_2].score)

	local var_47_0 = drop_manager:getDropMsg(self.data[arg_47_2].drop)
	local var_47_1 = arg_47_1:getChildByName("bg")

	table.sort(var_47_0.equips, function(arg_48_0, arg_48_1)
		return arg_48_0._index < arg_48_1._index
	end)

	local var_47_2 = {}

	if var_47_0.diamond > 0 then
		table.insert(var_47_2, {
			itemid = "diamond",
			num = var_47_0.diamond,
			name = L_DIAMOND
		})
	end

	if var_47_0.gold > 0 then
		table.insert(var_47_2, {
			itemid = "gold",
			num = var_47_0.gold,
			name = L_GOLD
		})
	end

	local var_47_3 = {}

	for iter_47_0, iter_47_1 in pairs(var_47_0.equips) do
		table.insert(var_47_3, {
			itemid = iter_47_1.dropid,
			num = iter_47_1.dropNum,
			name = item_data[iter_47_1.dropid].name
		})
	end

	for iter_47_2, iter_47_3 in pairs(var_47_3) do
		table.insert(var_47_2, iter_47_3)
	end

	if var_47_2 then
		for iter_47_4, iter_47_5 in pairs(var_47_2) do
			var_47_1:getChildByName("sp" .. iter_47_4):updateSignItemByItemid(var_47_2[iter_47_4].itemid, var_47_2[iter_47_4].num)
			var_47_1:getChildByName("sp" .. iter_47_4):setVisible(true)
		end
	end

	local var_47_4 = var_47_1:getChildByName("rewardBtn")

	var_47_4.index = arg_47_2

	local var_47_5 = self.data[arg_47_2].score > self.maxScore and 2 or self.rewardStatus and self.rewardStatus[arg_47_2] and self.rewardStatus[arg_47_2] or 0

	if var_47_5 == 0 then
		var_47_4:loadTextures(var_0_8 .. "btn_get.png", var_0_8 .. "btn_get.png", var_0_8 .. "btn_get.png", var_0_0)
	elseif var_47_5 == 1 then
		var_47_4:loadTextures(var_0_8 .. "btn_reward_on.png", var_0_8 .. "btn_reward_on.png", var_0_8 .. "btn_reward_on.png", var_0_0)
	elseif var_47_5 == 2 then
		var_47_4:loadTextures(var_0_8 .. "btn_reward_off.png", var_0_8 .. "btn_reward_off.png", var_0_8 .. "btn_reward_off.png", var_0_0)
	end

	var_47_4.status = var_47_5

	var_47_4:addTouchEventListener(function(arg_49_0, arg_49_1)
		if arg_49_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_49_0.status ~= 0 then
			return
		end

		self:touchRward(arg_49_0.index)
	end)
end

function ActivityFallingLayer.initScheduleFloor(arg_50_0)
	arg_50_0.scheduleid = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		arg_50_0:createFloor()
	end, 2, false)
end

function ActivityFallingLayer.initScheduleScore(arg_52_0)
	arg_52_0.scoreScheduleid = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		arg_52_0.curScore = arg_52_0.curScore + 1

		arg_52_0.curScoreLabel:setString("" .. arg_52_0.curScore)
	end, 1, false)
end

function ActivityFallingLayer:updateFloorByTime(arg_54_1)
	if self.scheduleid then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleid)

		self.scheduleid = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
			self:createFloor()
		end, arg_54_1, false)
	end
end

function ActivityFallingLayer:initKeyBoardListener()
	local var_56_0 = cc.EventListenerKeyboard:create()

	var_56_0:registerScriptHandler(function(arg_57_0, arg_57_1)
		if arg_57_0 == cc.KeyCode.KEY_A then
			var_0_12 = "left"
			var_0_11 = true

			self.player:setScaleX(-1)
		elseif arg_57_0 == cc.KeyCode.KEY_D then
			var_0_12 = "right"
			var_0_11 = true

			self.player:setScaleX(1)
		elseif arg_57_0 == cc.KeyCode.KEY_P then
			self:updateScore(2000)
		elseif arg_57_0 == cc.KeyCode.KEY_O then
			self:updateScore(1000)
		elseif arg_57_0 == cc.KeyCode.KEY_M then
			self.invincible = true

			global_ShowBlockWords("invincible")
		end

		if self.player then
			self.player:playAni(nil, "run", true)
		end
	end, cc.Handler.EVENT_KEYBOARD_PRESSED)
	var_56_0:registerScriptHandler(function()
		var_0_12 = nil
		var_0_11 = false

		if self.player then
			self.player:playAni(nil, "idle", true)
		end
	end, cc.Handler.EVENT_KEYBOARD_RELEASED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_56_0, self)
end

function ActivityFallingLayer.createL2Actor(arg_59_0, arg_59_1)
	local var_59_0 = global_get_servant_skin(arg_59_1)
	local var_59_1 = 0.2
	local var_59_2 = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_59_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_59_0].spine_model .. ".atlas", (model_data[var_59_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_59_0].clothes_model .. ".atlas" or nil))

	var_59_2:setName("spine")
	var_59_2:setScale(var_59_1, var_59_1)
	var_59_2:playAni(nil, "idle", true)

	return var_59_2
end

function ActivityFallingLayer:createFloor()
	local var_60_0 = math.random()
	local var_60_1

	if var_60_0 < 0.2 then
		var_60_1 = ccui.ImageView:create(var_0_8 .. "floor_false.png", var_0_0)

		var_60_1:setName("off")
	elseif var_60_0 < 0.4 then
		var_60_1 = ccui.ImageView:create(var_0_8 .. "floor_nail.png", var_0_0)

		var_60_1:setName("nail")
	elseif var_60_0 < 0.6 then
		if math.random() < 0.5 then
			var_60_1 = ccui.ImageView:create(var_0_8 .. "floor_left.png", var_0_0)

			var_60_1:setTag(1)
		else
			var_60_1 = ccui.ImageView:create(var_0_8 .. "floor_right.png", var_0_0)

			var_60_1:setTag(2)
		end

		var_60_1:setName("slide")
	elseif var_60_0 < 0.7 then
		var_60_1 = ccui.ImageView:create(var_0_8 .. "floor_spring_off.png", var_0_0)

		var_60_1:setName("spring")
	else
		var_60_1 = ccui.ImageView:create(var_0_8 .. "floor.png", var_0_0)

		var_60_1:setName("on")
	end

	local var_60_2 = math.random()

	if var_60_2 < 0.1 then
		var_60_1.isLeft = true
	elseif var_60_2 < 0.2 then
		var_60_1.isRight = true
	end

	var_60_1:setPosition(math.random(120, GameDisplay.origin_design_x - 120), -20 - 100 * math.random())
	self.floorLayer:addChild(var_60_1)
end

function ActivityFallingLayer:updateScore(arg_61_1)
	network:rpc("activity_jumpgame_update_score", {
		type = "jumpgame",
		activityid = self.activityid,
		score = arg_61_1
	}, function(arg_62_0)
		print(dump(arg_62_0), "msg")
	end)
end

function ActivityFallingLayer:initReward(arg_63_1)
	network:rpc("activity_jumpgame_get_info", {
		type = "jumpgame",
		activityid = self.activityid
	}, function(arg_64_0)
		print(dump(arg_64_0), "inittttt")

		local var_64_0

		for iter_64_0, iter_64_1 in pairs(arg_64_0.items) do
			if iter_64_1.type == "jumpgame" then
				self.maxScore = iter_64_1.score
				var_64_0 = iter_64_1.reward
			end
		end

		self.maxScore = self.maxScore or 0
		var_64_0 = var_64_0 or 0
		self.rewardStatus = {}

		while var_64_0 > 0 do
			self.rewardStatus[0] = var_64_0 % 2

			local var_64_2 = tostring(var_64_0 % 2) .. ""

			var_64_0 = math.floor(var_64_0 / 2)
		end

		if arg_63_1 then
			arg_63_1()
		end
	end)
end

function ActivityFallingLayer:touchRward(arg_65_1)
	network:rpc("activity_jumpgame_reward", {
		type = "jumpgame",
		activityid = self.activityid,
		index = arg_65_1
	}, function(arg_66_0)
		if arg_66_0.result == 1 then
			if arg_66_0.items and #arg_66_0.items > 0 then
				global_gain({
					items = arg_66_0.items,
					gold = arg_66_0.gold,
					diamond = arg_66_0.diamond
				})
			end
		elseif arg_66_0.result == 2 then
			global_ShowBlockWords(L_FALLINGLAYER[9])
		elseif arg_66_0.result == 3 then
			global_ShowBlockWords(L_FALLINGLAYER[10])
		end

		self:updateReward(arg_65_1)
	end)
end

function ActivityFallingLayer:updateReward(arg_67_1)
	self:initReward(function()
		self.rewardTableView:updateCellAtIndex(arg_67_1 - 1)
	end)
end
