local BossBarSprite = class("BossBarSprite", function()
	return cc.Node:create()
end)

function BossBarSprite:createHpBar(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = BossBarSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)

	return var_2_0
end

function BossBarSprite:createParent()
	return (BossBarSprite.new())
end

local var_0_1 = "fight/boss_blood1.png"
local var_0_2 = "fight/boss_blood_bg.png"
local var_0_3 = "fight/boss_blood_mid.png"
local var_0_5 = "fonts/boss_blood_number.png"
local var_0_7 = {}

var_0_7[1] = "fight/boss_blood2.png"
var_0_7[2] = "fight/boss_blood1.png"

function BossBarSprite:init(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	self.curHp = arg_4_1
	self.totalHp = arg_4_2
	self.hpCount = arg_4_3
	self.curhpCount = arg_4_3
	self.direction = arg_4_4
	self.barActions = {}
	self.running = false
	self.hp_percent = cc.Label:createWithTTF(string.format("%d%%", math.floor(self:getHpPercent())), FONT_DES, 32)

	self.hp_percent:setSkewY(10)
	self:addChild(self.hp_percent, 5)

	self.hp_count = cc.Label:createWithCharMap(var_0_5, 28, 27, 48)

	self.hp_count:setScale(0.8)
	self:addChild(self.hp_count, 5)

	self.bar1 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_1) or cc.Sprite:createWithSpriteFrameName(var_0_1)))

	self.bar1:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bar1:setBarChangeRate(cc.p(1, 0))
	self.bar1:setSkewY(30)
	self:addChild(self.bar1, 3)

	self.bar2 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_3) or cc.Sprite:createWithSpriteFrameName(var_0_3)))

	self.bar2:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bar2:setBarChangeRate(cc.p(1, 0))

	self.bar2.status = "reduce"

	self.bar2:setSkewY(30)
	self:addChild(self.bar2, 2)

	if config._DEBUG then
		self.bg = cc.Sprite:create(var_0_2) or cc.Sprite:createWithSpriteFrameName(var_0_2)
	end

	self.bg:setSkewY(30)
	self:addChild(self.bg, 1)

	if arg_4_4 == 1 then
		self.bar1:setMidpoint(cc.p(0, 0))
		self.bar2:setMidpoint(cc.p(0, 0))
		self.hp_percent:setAnchorPoint(cc.p(1, 0))
		self.hp_percent:setPosition(cc.p(self.bg:getContentSize().width / 2, self.bg:getContentSize().height / 2))
		self.hp_count:setAnchorPoint(cc.p(1, 0.5))
		self.hp_count:setPosition(cc.p(self.bg:getContentSize().width / 2 - 10, 0))
	end

	self:setBoss(arg_4_5)
	self:updateHpBar(self.curhpCount)
	self:setTotalHp(arg_4_2)
	self:setCurHp(arg_4_1)
	self:createShieldBar()
end

function BossBarSprite:setBoss(arg_5_1)
	local var_5_0

	if config._DEBUG then
		var_5_0 = cc.Sprite:create("fight/boss_name_bg.png") or cc.Sprite:createWithSpriteFrameName("fight/boss_name_bg.png")
	end

	var_5_0:setPosition(cc.p(-12, 32))
	self:addChild(var_5_0, 5)

	local var_5_1 = cc.Label:createWithTTF(arg_5_1.name, FONT_DES, 20)

	var_5_1:setAnchorPoint(cc.p(0, 0.5))
	var_5_1:setPosition(cc.p(var_5_0:getContentSize().width / 2 - 190, var_5_0:getContentSize().height / 2 + 3))
	var_5_0:addChild(var_5_1, 2)

	local var_5_2

	if config._DEBUG then
		var_5_2 = cc.Scale9Sprite:create("fight/boss_name.png") or cc.Scale9Sprite:createWithSpriteFrameName("fight/boss_name.png")
	end

	var_5_2:setCapInsets(cc.rect(50, 10, 10, 10))
	var_5_2:setPreferredSize(cc.size(math.max(var_5_2:getContentSize().width, var_5_1:getContentSize().width + 100), var_5_2:getContentSize().height))
	var_5_2:setAnchorPoint(cc.p(0, 0.5))
	var_5_2:setPosition(cc.p(var_5_0:getContentSize().width / 2 - 240, var_5_0:getContentSize().height / 2 + 3))
	var_5_0:addChild(var_5_2, 1)

	local var_5_3

	if config._DEBUG then
		var_5_3 = cc.Sprite:create("fight/boss_head_bg.png") or cc.Sprite:createWithSpriteFrameName("fight/boss_head_bg.png")
	end

	var_5_3:setPosition(cc.p(-285, 0))
	self:addChild(var_5_3, 6)

	local var_5_4

	if config._DEBUG then
		var_5_4 = cc.Sprite:create("public/rolebg/icon_bg.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/icon_bg.png")
	end

	local var_5_5 = cc.Sprite:create("role/wuji/" .. arg_5_1.headimg .. ".png")

	var_5_5:setPosition(cc.p(var_5_4:getContentSize().width / 2, var_5_4:getContentSize().height / 2))
	var_5_4:addChild(var_5_5, 1)
	var_5_4:setScale(0.6)
	var_5_4:setPosition(cc.p(var_5_3:getContentSize().width / 2 + 4, var_5_3:getContentSize().height / 2 + 36))
	var_5_3:addChild(var_5_4)

	local var_5_6

	if config._DEBUG then
		var_5_6 = cc.Sprite:create(CAREER_ICON[arg_5_1.careericon]) or cc.Sprite:createWithSpriteFrameName(CAREER_ICON[arg_5_1.careericon])
	end

	var_5_6:setPosition(cc.p(var_5_3:getContentSize().width / 2 - 40, var_5_3:getContentSize().height / 2 - 46))
	var_5_6:setScale(0.66)
	var_5_3:addChild(var_5_6, 3)

	local var_5_7

	if config._DEBUG then
		var_5_7 = cc.Sprite:create("fight/frame_boss_lv.png") or cc.Sprite:createWithSpriteFrameName("fight/frame_boss_lv.png")
	end

	var_5_7:setPosition(cc.p(var_5_3:getContentSize().width / 2, var_5_3:getContentSize().height / 2 - 45))
	var_5_3:addChild(var_5_7, 2)

	local var_5_8 = cc.Label:createWithTTF(L_ITEMPANEL_SORT_STR.level2 .. tostring(arg_5_1.lv), FONT_DES, 16)

	var_5_8:setColor(cc.c3b(255, 224, 54))
	var_5_8:setAnchorPoint(cc.p(0.5, 0.5))
	var_5_8:setPosition(cc.p(var_5_7:getContentSize().width / 2 + 13, var_5_7:getContentSize().height / 2))
	var_5_7:addChild(var_5_8)
end

function BossBarSprite:dequeueBarColor(arg_6_1)
	if arg_6_1 == self.hpcount then
		return var_0_7[#var_0_7]
	else
		return var_0_7[(arg_6_1 - 1) % #var_0_7 + 1]
	end
end

function BossBarSprite:updateHpBar(arg_7_1)
	local var_7_0 = self:dequeueBarColor(arg_7_1)
	local var_7_1 = arg_7_1 > 1 and self:dequeueBarColor(arg_7_1 - 1) or var_0_2

	if config._DEBUG then
		self.bar1:getSprite():setTexture(var_7_0)
		self.bg:setTexture(var_7_1)
	else
		self.bar1:getSprite():setSpriteFrame(var_7_0)
		self.bg:setSpriteFrame(var_7_1)
	end

	if arg_7_1 > 0 then
		self.bar1:setPercentage(100)
		self.bar2:setPercentage(100)
	end

	self.hp_count:setString(":" .. arg_7_1)
end

function BossBarSprite:updateSubHpBar(arg_8_1)
	if self.bar2.status == arg_8_1 then
		return
	end

	self.bar2.status = arg_8_1 == "add" and "add" or "reduce"
end

function BossBarSprite:getHpPercent()
	return 100 * (self.curHp + self.totalHp * (self.curhpCount - 1)) / (self.totalHp * self.hpCount)
end

function BossBarSprite:setPercent(arg_10_1, arg_10_2)
	arg_10_1:setPercentage(arg_10_2)
end

function BossBarSprite:setCurHp(arg_11_1)
	self.curHp = arg_11_1

	self:setPercent(self.bar1, self.curHp * 100 / self.totalHp)
	self:setPercent(self.bar2, self.curHp * 100 / self.totalHp)
	self.hp_percent:setString(string.format("%d%%", math.floor(self:getHpPercent())))
end

function BossBarSprite:resetCurHp(arg_12_1)
	if arg_12_1 == 0 then
		self.curHp = 0
	else
		self.curHp = arg_12_1 % self.totalHp

		if self.curHp == 0 then
			self.curHp = self.totalHp
		end
	end

	self.curhpCount = math.ceil(arg_12_1 / self.totalHp)

	self:updateHpBar(self.curhpCount)
	self:setPercent(self.bar1, self.curHp * 100 / self.totalHp)
	self:setPercent(self.bar2, self.curHp * 100 / self.totalHp)
	self.hp_percent:setString(string.format("%d%%", math.floor(self:getHpPercent())))
end

function BossBarSprite:setTotalHp(arg_13_1)
	self.totalHp = arg_13_1

	self:setPercent(self.bar1, self.curHp * 100 / self.totalHp)
	self:setPercent(self.bar2, self.curHp * 100 / self.totalHp)
	self.hp_percent:setString(string.format("%d%%", math.floor(self:getHpPercent())))
end

function BossBarSprite:setHpCount(arg_14_1)
	self.hpCount = arg_14_1
	self.curhpCount = arg_14_1

	self:updateHpBar(arg_14_1)
end

function BossBarSprite:resetBar()
	self.curHp = self.totalHp

	self:removeAllBarActions()

	for iter_15_0 = self.curhpCount, self.hpCount do
		self:pushInBarAction("all", "add", iter_15_0)
	end

	self.curhpCount = self.hpCount
end

function BossBarSprite:runBar(arg_16_1)
	if arg_16_1 == 0 then
		return
	end

	local var_16_0 = self.curHp + self.totalHp * (self.curhpCount - 1) + arg_16_1

	if self.curHp + self.totalHp * (self.curhpCount - 1) + arg_16_1 > self.totalHp * self.hpCount then
		var_16_0 = self.totalHp * self.hpCount
	end

	if var_16_0 < 0 then
		var_16_0 = 0
	end

	local var_16_1 = var_16_0 % self.totalHp

	if var_16_0 % self.totalHp == 0 and var_16_0 >= self.totalHp then
		var_16_1 = self.totalHp
	end

	local var_16_2 = math.ceil(var_16_0 / self.totalHp)

	if var_16_2 > self.curhpCount then
		for iter_16_0 = self.curhpCount, var_16_2 - 1 do
			self:pushInBarAction("all", "add", iter_16_0)
		end
	elseif var_16_2 < self.curhpCount then
		for iter_16_1 = self.curhpCount, var_16_2 + 1, -1 do
			self:pushInBarAction("all", "reduce", iter_16_1)
		end
	end

	self:pushInBarAction("normal", arg_16_1 > 0 and "add" or "reduce", var_16_1, var_16_2)

	self.curHp = var_16_1
	self.curhpCount = var_16_2
end

function BossBarSprite:pushInBarAction(...)
	table.insert(self.barActions, {
		...
	})

	if not self.running then
		self:dequeueNextAction()()
	end
end

function BossBarSprite:dequeueNextAction()
	local var_18_0 = table.remove(self.barActions, 1)

	if not var_18_0 then
		return function()
			self.running = false
		end
	end

	if var_18_0[1] == "all" then
		if var_18_0[2] == "add" then
			return function()
				self.running = true

				self.bar2:stopAllActions()
				self.bar1:stopAllActions()
				self.bar1:runAction(cc.ProgressTo:create(0.2, 100))
				self:updateSubHpBar("add")
				self.bar2:setPercentage(100)
				self.bar2:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					if var_18_0[3] < self.hpCount then
						self:updateHpBar(var_18_0[3] + 1)
					end

					self:dequeueNextAction()()
				end)))
				self.hp_percent:setString(string.format("%d%%", math.floor(100 * var_18_0[3] / self.hpCount)))
			end
		else
			return function()
				self.running = true

				self.bar2:stopAllActions()
				self.bar1:stopAllActions()
				self.bar1:setPercentage(0)
				self:updateSubHpBar("reduce")
				self.bar2:runAction(cc.Sequence:create(cc.ProgressTo:create(0.2, 0), cc.CallFunc:create(function()
					self.bar2:setPercentage(0)

					if var_18_0[3] > 1 then
						self:updateHpBar(var_18_0[3] - 1)
					else
						self.hp_count:setString(":0")
					end

					self:dequeueNextAction()()
				end)))
				self.hp_percent:setString(string.format("%d%%", math.floor(100 * (var_18_0[3] - 1) / self.hpCount)))
			end
		end
	elseif var_18_0[2] == "add" then
		return function()
			self.running = true

			self.bar2:stopAllActions()
			self.bar1:stopAllActions()
			self.bar1:runAction(cc.ProgressTo:create(0.1, var_18_0[3] * 100 / self.totalHp))
			self:updateSubHpBar("add")
			self.bar2:setPercentage(var_18_0[3] * 100 / self.totalHp)
			self.hp_percent:setString(string.format("%d%%", math.floor(100 * (var_18_0[3] + self.totalHp * (var_18_0[4] - 1)) / (self.totalHp * self.hpCount))))
			self:dequeueNextAction()()
		end
	else
		return function()
			self.running = true

			self.bar2:stopAllActions()
			self.bar1:stopAllActions()
			self:updateSubHpBar("reduce")
			self.bar1:setPercentage(var_18_0[3] * 100 / self.totalHp)
			self.bar2:runAction(cc.ProgressTo:create(0.1, var_18_0[3] * 100 / self.totalHp))

			if var_18_0[4] <= 0 then
				self.hp_percent:setString("0%")
				self.hp_count:setString(":0")
			else
				self.hp_percent:setString(string.format("%d%%", math.floor(100 * (var_18_0[3] + self.totalHp * (var_18_0[4] - 1)) / (self.totalHp * self.hpCount))))
			end

			self:dequeueNextAction()()
		end
	end
end

function BossBarSprite:removeAllBarActions()
	self.barActions = {}
	self.running = false

	self.bar1:stopAllActions()
	self.bar2:stopAllActions()
end

local var_0_8 = "fight/boss_shield_bg.png"
local var_0_9 = "fight/boss_shield.png"

function BossBarSprite:createShieldBar()
	self.totalShield = 0
	self.curShield = 0

	if config._DEBUG then
		self.shield = cc.Sprite:create(var_0_8) or cc.Sprite:createWithSpriteFrameName(var_0_8)
	end

	self.shield:setPosition(cc.p(-2, -self.bar2:getContentSize().height / 2 - 4))
	self:addChild(self.shield, 4)

	if config._DEBUG then
		self.shieldBar = cc.ProgressTimer:create(cc.Sprite:create(var_0_9)) or cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(var_0_9))
	end

	self.shieldBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.shieldBar:setBarChangeRate(cc.p(1, 0))
	self.shieldBar:setMidpoint(cc.p(0, 0))
	self.shieldBar:setPosition(cc.p(self.shield:getContentSize().width / 2, self.shield:getContentSize().height / 2))
	self.shield:addChild(self.shieldBar)
	self.shieldBar:setPercentage(0)
	self.shield:setVisible(false)
end

function BossBarSprite:addShield(arg_28_1)
	self.totalShield = arg_28_1
	self.curShield = arg_28_1

	self.shieldBar:stopAllActions()
	self.shield:setVisible(true)
	self.shieldBar:setPercentage(100)
end

function BossBarSprite:reduceShield(arg_29_1, arg_29_2)
	self.curShield = self.curShield - arg_29_1

	if arg_29_2 then
		self.shieldBar:stopAllActions()
		self.shieldBar:runAction(cc.Sequence:create(cc.ProgressTo:create(0.1, self.curShield / self.totalShield * 100), cc.CallFunc:create(function()
			if self.curShield <= 0 then
				self.shield:setVisible(false)
			end
		end)))
	else
		self.shieldBar:stopAllActions()
		self.shieldBar:setPercentage(self.curShield / self.totalShield * 100)

		if self.curShield <= 0 then
			self.shield:setVisible(false)
		end
	end
end

return BossBarSprite
