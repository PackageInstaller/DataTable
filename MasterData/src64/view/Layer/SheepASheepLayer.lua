SheepASheepLayer = class("SheepASheepLayer", function()
	return ccui.Layout:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

function SheepASheepLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SheepASheepLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function SheepASheepLayer:init(arg_3_1)
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)
	self.rootlayer:setPosition(0, -GameDisplay.fix_y)

	self.resPath = "SheepASheepLayer/"

	local var_3_0 = ccui.ImageView:create(self.resPath .. "bg.png", var_0_0)

	self.rootlayer:addChild(var_3_0)
	var_3_0:setAnchorPoint(0, 0)
	var_3_0:setPosition(0, 0)

	self.activityId = 593
	self.score = 0

	self:initTitle()
	self:initBottom()
	self:initStack()
	self:updateCardPool()
	self:initResetLayer()
	self:initExitLayer()
end

function SheepASheepLayer:initTitle()
	local var_4_0 = ccui.ImageView:create(self.resPath .. "titleBg.png", var_0_0)

	self.rootlayer:addChild(var_4_0)
	var_4_0:setAnchorPoint(0, 1)
	var_4_0:setPosition(0, GameDisplay.height)

	local var_4_1 = ccui.Button:create(self.resPath .. "title.png", nil, self.resPath .. "title.png", var_0_0)

	self.rootlayer:addChild(var_4_1)
	var_4_1:setAnchorPoint(0, 1)
	var_4_1:setPosition(0, GameDisplay.height)
	var_4_1:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "SheepASheepLayer"
		})
	end)

	local var_4_2 = cc.Label:createWithTTF(L_FALLINGLAYER[1], FONT_NAME, 30)

	self.rootlayer:addChild(var_4_2)
	var_4_2:setPosition(320, 1000 + GameDisplay.fix_y * 2)

	local var_4_3 = ccui.ImageView:create(self.resPath .. "scoreBg.png", var_0_0)

	self.rootlayer:addChild(var_4_3)
	var_4_3:setPosition(320, 950 + GameDisplay.fix_y * 2)

	local var_4_4 = cc.Label:createWithTTF(0, FONT_NAME, 36)

	var_4_4:setColor(cc.c3b(246, 82, 246))
	var_4_3:addChild(var_4_4)
	var_4_4:setPosition(var_4_3:getContentSize().width / 2, var_4_3:getContentSize().height / 2)

	self.scoreLabel = var_4_4
end

function SheepASheepLayer:initBottom()
	local var_6_0 = ccui.ImageView:create(self.resPath .. "bottomBg.png", var_0_0)

	self.rootlayer:addChild(var_6_0)
	var_6_0:setAnchorPoint(0, 0)
	var_6_0:setPosition(0, 0)

	local var_6_1 = ccui.Button:create(self.resPath .. "returnBtn.png", nil, self.resPath .. "returnBtn.png", var_0_0)

	var_6_0:addChild(var_6_1)
	var_6_1:setPosition(40, 40)
	var_6_1:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.exitLayer:setVisible(true)
	end)
end

function SheepASheepLayer:initStack()
	local var_8_0 = ccui.ImageView:create(self.resPath .. "stack.png", var_0_0)

	self.rootlayer:addChild(var_8_0)
	var_8_0:setPosition(320, 130 + GameDisplay.fix_y)

	local var_8_1 = ccui.Layout:create()

	var_8_1:setContentSize(cc.size(640, 1600))
	var_8_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_8_1:setCascadeOpacityEnabled(false)
	var_8_1:setBackGroundColorOpacity(0)
	var_8_1:setAnchorPoint(0.5, 0.5)
	var_8_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_8_1:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_8_1:setTouchEnabled(true)
	var_8_1:setLocalZOrder(1000)
	var_8_1:setVisible(false)
	self.rootlayer:addChild(var_8_1)

	self.touchlayer = var_8_1

	self:updateStack()
end

function SheepASheepLayer:updateCardPool()
	self.cardPool = {}

	for iter_9_0, iter_9_1 in pairs((require("data.xxlhq_data"))) do
		local var_9_1 = ccui.Button:create(self.resPath .. "roleBg.png", nil, self.resPath .. "roleBg.png", var_0_0)

		self.rootlayer:addChild(var_9_1)
		var_9_1:setLocalZOrder(iter_9_1.z)

		local var_9_2 = var_9_1:getContentSize()

		var_9_1:setPosition(var_9_2.width * iter_9_1.x, 300 + var_9_2.height * iter_9_1.y - var_9_2.height + GameDisplay.fix_y)

		var_9_1.z = iter_9_1.z
		var_9_1.index = iter_9_0

		var_9_1:setName("card" .. iter_9_0)
		var_9_1:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.stack.push(arg_10_0)
			arg_10_0:setTouchEnabled(false)
		end)

		local var_9_3 = ccui.ImageView:create()

		var_9_1:addChild(var_9_3)
		var_9_3:setScale(0.41)
		var_9_3:setPosition(var_9_2.width / 2, var_9_2.height / 2)

		var_9_1.girlImg = var_9_3

		local var_9_4 = ccui.ImageView:create(self.resPath .. "rolewind.png", var_0_0)

		var_9_1:addChild(var_9_4)
		var_9_4:setPosition(var_9_2.width / 2, var_9_2.height / 2)

		local var_9_5 = ccui.ImageView:create(self.resPath .. "rolemask.png", var_0_0)

		var_9_1:addChild(var_9_5)
		var_9_5:setPosition(var_9_2.width / 2, var_9_2.height / 2)
		var_9_5:setVisible(false)

		var_9_1.rolemask = var_9_5
		self.cardPool[iter_9_0] = var_9_1
	end

	local var_9_6 = {
		59339001,
		59339002,
		59339003,
		59339004,
		59339005,
		59339006,
		59339007,
		59339008,
		59339009,
		13112090
	}
	local var_9_7 = {}

	for iter_9_2 = 1, #self.cardPool / 3 do
		local var_9_8 = math.random(1, #var_9_6)

		for iter_9_3 = 1, 3 do
			local var_9_9

			repeat
				var_9_9 = math.random(1, #self.cardPool)
			until not var_9_7[var_9_9]

			var_9_7[var_9_9] = true

			if self.cardPool[var_9_9] then
				self.cardPool[var_9_9].girlImg:loadTexture("equipment/" .. var_9_6[var_9_8] .. ".png")

				self.cardPool[var_9_9].type = var_9_8
			end
		end
	end

	function self.cardPool.update()
		for iter_11_0 = 1, #self.cardPool do
			self.cardPool[iter_11_0]:setTouchEnabled(true)
			self.cardPool[iter_11_0]:setColor(cc.c3b(255, 255, 255))
			self.cardPool[iter_11_0].rolemask:setVisible(false)
		end

		for iter_11_1 = 1, #self.cardPool - 1 do
			local var_11_0 = self.cardPool[iter_11_1]:getPositionX()
			local var_11_1 = self.cardPool[iter_11_1]:getPositionY()

			for iter_11_2 = iter_11_1 + 1, #self.cardPool do
				if self.cardPool[iter_11_1].z > self.cardPool[iter_11_2].z then
					break
				end

				local var_11_2 = self.cardPool[iter_11_2]:getPositionX()
				local var_11_3 = self.cardPool[iter_11_2]:getPositionY()

				if var_11_0 < var_11_2 + 82 and var_11_1 < var_11_3 + 82 and var_11_0 > var_11_2 - 82 and var_11_1 > var_11_3 - 82 then
					self.cardPool[iter_11_1]:setTouchEnabled(false)
					self.cardPool[iter_11_1]:setColor(cc.c3b(128, 128, 128))
					self.cardPool[iter_11_1].rolemask:setVisible(true)

					break
				end
			end
		end
	end

	self.cardPool.update()
end

function SheepASheepLayer:updateStack()
	if self.stack then
		for iter_12_0, iter_12_1 in pairs(self.stack) do
			if type(iter_12_1) == "userdata" then
				iter_12_1:removeFromParent()
			end
		end
	end

	self.stack = {}

	function self.stack:push()
		if #self.stack >= 7 then
			self:updateTitle()
			self.resetLayer:setVisible(true)
			AnalyticManager.sheepGameScore({
				ctype = "fail",
				score = self.score
			})

			return
		end

		local var_13_0 = #self.stack

		local function var_13_1()
			self.stack.update()
			self.touchlayer:setVisible(false)

			if #self.stack >= 7 then
				self:updateTitle()
				self.resetLayer:setVisible(true)
				AnalyticManager.sheepGameScore({
					ctype = "fail",
					score = self.score
				})
			end

			if #self.cardPool == 0 and #self.stack == 0 then
				self:updateTitle()
				self.resetLayer:setVisible(true)
				AnalyticManager.sheepGameScore({
					ctype = "success",
					score = self.score
				})
			end
		end

		local var_13_2 = 0

		if #self.stack <= 1 then
			var_13_2 = var_13_0

			self:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(155 + (var_13_0 - 1) * 82, 130 + GameDisplay.fix_y)), cc.DelayTime:create(0.1), cc.CallFunc:create(function()
				var_13_1()
			end)))
		else
			for iter_13_0 = 1, var_13_0 do
				if self.type == self.stack[iter_13_0].type then
					var_13_2 = iter_13_0
				end
			end

			if var_13_2 == 0 then
				var_13_2 = var_13_0

				self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
					self.touchlayer:setVisible(true)
				end), cc.MoveTo:create(0.1, cc.p(155 + (var_13_0 - 1) * 82, 130 + GameDisplay.fix_y)), cc.DelayTime:create(0.1), cc.CallFunc:create(function()
					var_13_1()
				end)))
			else
				self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
					self.touchlayer:setVisible(true)
				end), cc.MoveTo:create(0.1, cc.p(155 + (var_13_2 - 1) * 82, 130 + GameDisplay.fix_y)), cc.DelayTime:create(0.1), cc.CallFunc:create(function()
					var_13_1()
				end)))

				for iter_13_1 = var_13_2 + 1, var_13_0 do
					self.stack[iter_13_1]:runAction(cc.MoveTo:create(0.1, cc.p(155 + (iter_13_1 - 1) * 82, 130 + GameDisplay.fix_y)))
				end
			end
		end

		table.insert(self.stack, var_13_2 + 1, self)

		for iter_13_2 = 1, #self.cardPool do
			if self.cardPool[iter_13_2].index == self.index then
				table.remove(self.cardPool, iter_13_2)

				break
			end
		end

		self.cardPool.update()
	end

	function self.stack.update()
		if #self.stack >= 3 then
			for iter_20_0 = 3, #self.stack do
				if self.stack[iter_20_0].type == self.stack[iter_20_0 - 1].type and self.stack[iter_20_0].type == self.stack[iter_20_0 - 2].type then
					self.stack[iter_20_0]:setVisible(false)
					self.stack[iter_20_0 - 1]:setVisible(false)
					self.stack[iter_20_0 - 2]:setVisible(false)
					self.stack[iter_20_0]:removeFromParent()
					self.stack[iter_20_0 - 1]:removeFromParent()
					self.stack[iter_20_0 - 2]:removeFromParent()

					for iter_20_1 = iter_20_0 + 1, #self.stack do
						self.stack[iter_20_1]:runAction(cc.MoveTo:create(0.1, cc.p(155 + (iter_20_1 - 5) * 82, 130 + GameDisplay.fix_y)))
					end

					table.remove(self.stack, iter_20_0)
					table.remove(self.stack, iter_20_0 - 1)
					table.remove(self.stack, iter_20_0 - 2)

					self.score = self.score + 1

					self.scoreLabel:setString(self.score)

					break
				end
			end
		end
	end
end

function SheepASheepLayer:updateTitle()
	local var_21_0 = RoleDefault:getInstance():getIntegerForKey("SheepMaxScore", 0)

	self.resetScoreLabel:setString(self.score)

	if var_21_0 < self.score then
		var_21_0 = self.score

		RoleDefault:getInstance():setStringForKey("SheepMaxScore", self.score)
	end

	self.maxScoreLabel:setString(var_21_0)
end

function SheepASheepLayer:initResetLayer()
	local var_22_0 = ccui.Layout:create()

	var_22_0:setContentSize(cc.size(640, 1600))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_0:setCascadeOpacityEnabled(false)
	var_22_0:setBackGroundColorOpacity(122)
	var_22_0:setAnchorPoint(0.5, 0.5)
	var_22_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_22_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_22_0:setTouchEnabled(true)
	var_22_0:setLocalZOrder(1000)
	var_22_0:setVisible(false)
	self.rootlayer:addChild(var_22_0)

	self.resetLayer = var_22_0

	local var_22_1 = ccui.ImageView:create(self.resPath .. "winbg.png", var_0_0)

	var_22_0:addChild(var_22_1)
	var_22_1:setPosition(320, 800 + GameDisplay.fix_y)

	local var_22_2 = cc.Label:createWithTTF(L_FALLINGLAYER[4], FONT_NAME, 30)

	var_22_2:setColor(cc.c3b(246, 82, 246))
	var_22_1:addChild(var_22_2)
	var_22_2:setPosition(320, 150)

	local var_22_3 = cc.Label:createWithTTF(0, FONT_NAME, 72)

	var_22_1:addChild(var_22_3)
	var_22_3:setPosition(320, 80)

	self.resetScoreLabel = var_22_3

	local var_22_4 = cc.Label:createWithTTF(0, FONT_NAME, 24)

	var_22_1:addChild(var_22_4)
	var_22_4:setPosition(320, 25)

	self.maxScoreLabel = var_22_4

	local var_22_5 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_0)

	var_22_1:addChild(var_22_5)
	var_22_5:setPosition(150, -100)

	local var_22_6 = cc.Label:createWithTTF(L_FALLINGLAYER[7], FONT_NAME, 28)

	var_22_5:addChild(var_22_6)
	var_22_6:setPosition(var_22_5:getContentSize().width / 2, var_22_5:getContentSize().height / 2)
	var_22_6:setColor(cc.c3b(0, 0, 0))
	var_22_5:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.sheepGameScore({
			ctype = "exit",
			score = self.score
		})
		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	local var_22_7 = ccui.Button:create("public/button/public_button_normal_y.png", nil, "public/button/public_button_normal_y.png", var_0_0)

	var_22_1:addChild(var_22_7)
	var_22_7:setPosition(490, -100)

	local var_22_8 = cc.Label:createWithTTF(L_FALLINGLAYER[6], FONT_NAME, 28)

	var_22_7:addChild(var_22_8)
	var_22_8:setPosition(var_22_7:getContentSize().width / 2, var_22_7:getContentSize().height / 2)
	var_22_8:setColor(cc.c3b(0, 0, 0))
	var_22_7:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.resetLayer:setVisible(false)
		self:updateCardPool()
		self:updateStack()
	end)
end

function SheepASheepLayer:initExitLayer()
	local var_25_0 = ccui.Layout:create()

	var_25_0:setContentSize(cc.size(640, 1600))
	var_25_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_25_0:setCascadeOpacityEnabled(false)
	var_25_0:setBackGroundColorOpacity(122)
	var_25_0:setAnchorPoint(0.5, 0.5)
	var_25_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_25_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_25_0:setTouchEnabled(true)
	var_25_0:setLocalZOrder(1000)
	var_25_0:setVisible(false)
	self.rootlayer:addChild(var_25_0)

	self.exitLayer = var_25_0

	local var_25_1 = ccui.ImageView:create(self.resPath .. "winbg.png", var_0_0)

	var_25_0:addChild(var_25_1)
	var_25_1:setPosition(320, 800 + GameDisplay.fix_y)

	local var_25_2 = cc.Label:createWithTTF(L_EXIT_GAME, FONT_NAME, 30)

	var_25_1:addChild(var_25_2)
	var_25_2:setPosition(320, 80)
	var_25_2:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_25_2:setLineHeight(60)

	local var_25_3 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_0)

	var_25_1:addChild(var_25_3)
	var_25_3:setPosition(150, -100)

	local var_25_4 = cc.Label:createWithTTF(L_RETURN, FONT_NAME, 28)

	var_25_3:addChild(var_25_4)
	var_25_4:setPosition(var_25_3:getContentSize().width / 2, var_25_3:getContentSize().height / 2)
	var_25_4:setColor(cc.c3b(0, 0, 0))
	var_25_3:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.exitLayer:setVisible(false)
	end)

	local var_25_5 = ccui.Button:create("public/button/public_button_normal_y.png", nil, "public/button/public_button_normal_y.png", var_0_0)

	var_25_1:addChild(var_25_5)
	var_25_5:setPosition(490, -100)

	local var_25_6 = cc.Label:createWithTTF(L_SURE_EXIT, FONT_NAME, 28)

	var_25_5:addChild(var_25_6)
	var_25_6:setPosition(var_25_5:getContentSize().width / 2, var_25_5:getContentSize().height / 2)
	var_25_6:setColor(cc.c3b(0, 0, 0))
	var_25_5:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end
