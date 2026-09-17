PopGuideLayer = class("PopGuideLayer", function()
	return cc.Layer:create()
end)

local var_0_1

function PopGuideLayer.create(arg_2_0, arg_2_1)
	if not (function(arg_3_0)
		if arg_3_0.guidetype == 0 then
			if arg_3_0.fightlevel > 40 then
				return
			end

			if not POP_FIGHT_FALL_IMG[arg_3_0.fightdifficulty][arg_3_0.fightlevel] then
				return
			end
		elseif arg_3_0.guidetype == 1 then
			if not POP_FIGHT_SUCCESS_IMG[arg_3_0.fightdifficulty][arg_3_0.fightlevel] then
				return
			end
		end

		return true
	end)(arg_2_1) then
		return
	end

	local var_2_0 = PopGuideLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopGuideLayer.getInstance()
	return var_0_1
end

function PopGuideLayer:init(arg_5_1)
	var_0_1 = self
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setCascadeOpacityEnabled(true)
	self:addChild(self.rootLayer)

	if arg_5_1.guidetype then
		self.guidetype = arg_5_1.guidetype
	else
		return
	end

	self.bg = ccui.Button:create("mainScenebg/zhi_lose.jpg", "mainScenebg/zhi_lose.jpg", "mainScenebg/zhi_lose.jpg")

	self.bg:setAnchorPoint(cc.p(0.5, 0.5))
	self.bg:setOpacity(0)
	self.bg:setPosition(cc.p(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2))
	self.rootLayer:addChild(self.bg, 0)
	self.bg:runAction(cc.FadeIn:create(0.5))
	self:initTimeLabel()

	if self.guidetype ~= 0 then
		-- block empty
	end

	if arg_5_1.fightlevel then
		self.fightlevel = arg_5_1.fightlevel
	else
		return
	end

	if arg_5_1.fightdifficulty then
		self.fightDifficulty = arg_5_1.fightdifficulty
	else
		return
	end

	self:fightGuide()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_1 = nil

			if self.callback then
				self.callback()
			end
		end
	end)
end

function PopGuideLayer:fightGuide()
	if self.guidetype == 0 then
		local var_7_0 = self.fightlevel

		if self.fightlevel < 21 then
			var_7_0 = 20
		elseif self.fightlevel < 41 then
			var_7_0 = 40
		end

		local var_7_1 = POP_FIGHT_FALL_IMG[self.fightDifficulty][var_7_0]

		if POP_FIGHT_FALL_IMG[self.fightDifficulty][var_7_0] then
			self.bg:loadTextures(var_7_1, var_7_1, var_7_1)
		end
	elseif self.guidetype == 1 then
		if POP_FIGHT_SUCCESS_IMG[self.fightDifficulty][self.fightlevel] then
			self.bg:loadTextures(POP_FIGHT_SUCCESS_IMG[self.fightDifficulty][self.fightlevel], POP_FIGHT_SUCCESS_IMG[self.fightDifficulty][self.fightlevel], POP_FIGHT_SUCCESS_IMG[self.fightDifficulty][self.fightlevel])
		end
	end
end

function PopGuideLayer:initTimeLabel()
	local var_8_0 = cc.Label:createWithTTF(L_POPGUIDE_TIME_LABEL, "fonts/new.ttf", 24)

	var_8_0:setPosition(cc.p(550, 80))
	var_8_0:setAnchorPoint(cc.p(0.5, 0.5))
	self.bg:addChild(var_8_0, 5)

	local var_8_1 = cc.Label:createWithCharMap("fonts/num1.png", 16, 20, 43)

	var_8_1:setString("3")
	var_8_1:setAnchorPoint(cc.p(1, 0.5))
	var_8_1:setPosition(cc.p(var_8_0:getPositionX() - var_8_0:getContentSize().width / 2 - 10, var_8_0:getPositionY()))
	self.bg:addChild(var_8_1)

	local var_8_2 = 3

	self.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		var_8_1:setString(var_8_2)

		var_8_2 = var_8_2 - 1

		if var_8_2 < 0 then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
			var_8_1:setVisible(false)
			var_8_0:setString(L_GUIDENEW_CLOSE_BTN)
			self.bg:addTouchEventListener(function(arg_10_0, arg_10_1)
				if arg_10_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:runAction(cc.RemoveSelf:create())
			end)
		end
	end, 1, false)
end
