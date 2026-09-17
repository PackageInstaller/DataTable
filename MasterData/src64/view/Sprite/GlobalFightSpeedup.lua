GlobalFightSpeedup = class("GlobalFightSpeedup", function()
	if config._DEBUG then
		return cc.Sprite:create("public/accelerate_bg1.png")
	else
		return cc.Sprite:createWithSpriteFrameName("public/accelerate_bg1.png")
	end
end)

function GlobalFightSpeedup.create(arg_2_0)
	local var_2_0 = GlobalFightSpeedup.new()

	var_2_0:init()

	return var_2_0
end

function GlobalFightSpeedup:init()
	self.remain_time = 60

	self:initTimer()

	if config._DEBUG then
		self.ring = cc.Sprite:create("public/accelerate_bg1_ring.png") or cc.Sprite:createWithSpriteFrameName("public/accelerate_bg1_ring.png")
	end

	local var_3_0 = self:getContentSize()

	self.ring:setAnchorPoint(cc.p(0.5, 0.5))
	self.ring:setPosition(cc.p(var_3_0.width / 2 - 4, var_3_0.height / 2 + 8))
	self:addChild(self.ring)
	self.ring:runAction(cc.RepeatForever:create(cc.RotateBy:create(0.2, 360)))
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "enter" then
			global_fight_speedup = 1

			self:initTimeScheduler()
		elseif arg_4_0 == "exit" then
			global_fight_speedup = 0

			if self.scheduleid then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleid)

				self.scheduleid = nil
			end
		end
	end)
end

function GlobalFightSpeedup.initTimeScheduler(arg_5_0)
	arg_5_0.scheduleid = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_6_0)
		arg_5_0.remain_time = arg_5_0.remain_time - 1

		arg_5_0:updateTimer()

		if arg_5_0.remain_time <= 0 or arg_5_0.remain_time > 60 then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_5_0.scheduleid)

			arg_5_0.scheduleid = nil

			arg_5_0:runAction(cc.RemoveSelf:create())
		end
	end, 1, false)
end

function GlobalFightSpeedup:initTimer()
	self.timelabel = cc.Label:createWithTTF("01:00", "fonts/W5.ttf", 18)

	self.timelabel:setAnchorPoint(cc.p(0.5, 0))
	self.timelabel:setPosition(cc.p(self:getContentSize().width / 2, 0))
	self:addChild(self.timelabel)
end

function GlobalFightSpeedup:updateTimer()
	self.timelabel:setString(string.format("%02d:%02d", math.floor(self.remain_time / 60), math.floor(self.remain_time % 60)))
end
