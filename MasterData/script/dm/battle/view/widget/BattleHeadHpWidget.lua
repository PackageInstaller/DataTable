-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleHeadHpWidget.lua

BattleHeadHpWidget = class("BattleHeadHpWidget", DisposableObject, _M)

function BattleHeadHpWidget:initialize()
	super.initialize(self)
end

function BattleHeadHpWidget:dispose()
	super.dispose(self)
end

function BattleHeadHpWidget:setIsFormat(isFormat)
	self._isFormat = isFormat
end

local HpColor = {
	Red = {
		g = 0,
		b = 0,
		contrast = 20,
		r = 0.8
	},
	White = {
		g = 0.9,
		saturation = 0,
		contrast = 20,
		r = 0.9,
		o_b = 255,
		o_g = 255,
		o_r = 255,
		b = 0.9
	}
}
local HpTierMap = {
	"zhandou_bg_tx_xue01_2.png",
	"zhandou_bar_01.png",
	"zhandou_bar_02.png",
	"zhandou_bar_03.png",
	"zhandou_bar_04.png"
}

local function formatCount(count)
	if count <= 99999 then
		return tostring(math.floor(count)), false
	else
		local curLanage = getCurrentLanguage()

		if curLanage == GameLanguageType.CN then
			if count > 100000000 then
				count = count - count % 10000000
				count = string.format("%.1f", count / 100000000) .. "e"
			else
				count = count - count % 1000
				count = string.format("%.1f", count / 10000) .. "w"
			end
		elseif count > 100000000 then
			count = count - count % 10000000
			count = string.format("%.1f", count / 100000000) .. "e"
		else
			count = count - count % 100
			count = string.format("%.1f", count / 1000) .. "k"
		end

		return count, true
	end
end

BattleHeadTierHpWidget = class("BattleHeadTierHpWidget", BattleHeadHpWidget, _M)

BattleHeadTierHpWidget:has("_hpTierCount", {
	is = "rw"
})
BattleHeadTierHpWidget:has("_currentHpTier", {
	is = "rw"
})
BattleHeadTierHpWidget:has("_maxHp", {
	is = "rw"
})
BattleHeadTierHpWidget:has("_prevHpPercent", {
	is = "rw"
})

function BattleHeadTierHpWidget:initialize(headView, isLeft)
	super.initialize(self)
	self:setIsLeft(isLeft)

	self._isFormat = true
	self._headView = headView
	self._hpTierCount = 1
	self._currentHpTier = 1

	self:_setupUI()

	self._colors = {
		HpColor.Red,
		HpColor.White,
		HpColor.Red
	}
	self._shakes = {
		cc.p(0.5, 13.2),
		cc.p(7.5, -8.25),
		cc.p(-8, -4.95),
		cc.p(3.9, 4.65),
		cc.p(-6.699999999999999, -1.1000000000000005)
	}
end

function BattleHeadTierHpWidget:dispose()
	super.dispose(self)

	if self._hpBarTask then
		self._hpBarTask:stop()

		self._hpBarTask = nil
	end
end

function BattleHeadTierHpWidget:setIsLeft(isLeft)
	self._isLeft = isLeft

	if self._isLeft then
		self._shakes = {
			cc.p(-0.5, 13.2),
			cc.p(-7.5, -8.25),
			cc.p(8, -4.95),
			cc.p(-3.9, 4.65),
			cc.p(6.699999999999999, -1.1000000000000005)
		}
	end
end

function BattleHeadTierHpWidget:setHpTierCount(tiers)
	self._hpTierCount = tiers
	self._currentHpTier = nil
end

function BattleHeadTierHpWidget:_reloadHpBarTier()
	local index = self._currentHpTier == self._hpTierCount and 1 or self._currentHpTier == 1 and 5 or (self._currentHpTier - 2) % 3 + 2
	local index2 = self._currentHpTier == 2 and 5 or (self._currentHpTier - 3) % 3 + 2

	self._barPic1:loadTexture(HpTierMap[index], ccui.TextureResType.plistType)
	self._barPic2:loadTexture(HpTierMap[index], ccui.TextureResType.plistType)
	self._barPic3:setVisible(self._currentHpTier > 1)

	if self._currentHpTier > 1 then
		self._barPic3:loadTexture(HpTierMap[index2], ccui.TextureResType.plistType)
	end
end

function BattleHeadTierHpWidget:_setupUI()
	self._content = self._headView:getChildByFullName("content")
	self._barbg = self._content:getChildByName("bar_bg")

	local hpbar = self._content:getChildByFullName("hpbar.hpbar")

	self._barPic3 = ccui.ImageView:create()

	self._barPic3:loadTexture(HpTierMap[1], ccui.TextureResType.plistType)
	self._barPic3:posite(hpbar:getPosition()):offset(0, -1):addTo(hpbar:getParent())
	self._barPic3:setVisible(false)

	self._hp_gray = self._content:getChildByFullName("hp_gray")

	self._hp_gray:setVisible(false)
	self._hp_gray:setScaleX(0)

	self._hpbar4 = self:createHpBar(hpbar, "bxuetiaoc_xuetiao", 1)
	self._hpbar3 = self:createHpBar(hpbar, "bxuetiaob_xuetiao", 100)
	self._hpbar2 = self:createHpBar(hpbar, "bxuetiaoa_xuetiao")
	self._hpbar1 = self:createHpBar(hpbar, "bxuetiao_xuetiao")
	self._barPic2 = ccui.ImageView:create()

	self._barPic2:loadTexture(HpTierMap[1], ccui.TextureResType.plistType)
	self._barPic2:addTo(self._hpbar2:getChildByName("bar"))
	self._hpbar2:gotoAndStop(1)

	self._barPic1 = ccui.ImageView:create()

	self._barPic1:loadTexture(HpTierMap[1], ccui.TextureResType.plistType)
	self._barPic1:addTo(self._hpbar1:getChildByName("bar"))
	self._hpbar1:gotoAndStop(100)

	self._hpbarShine4 = self:createHpBarShine(self._hpbar4)

	self._hpbar4:setUpdateFrameHook(function(mc, frame)
		local shine = mc:getChildByName("shine")

		shine:setPositionX(-165 + 326 * frame / 100)

		if frame <= 3 then
			shine:setVisible(false)
		end
	end)

	self._hpbarShine3 = self:createHpBarShine(self._hpbar3)

	self._hpbar3:setUpdateFrameHook(function(mc, frame)
		local shine = mc:getChildByName("shine")

		shine:setPositionX(165 - 331 * frame / 100)

		if frame > 97 then
			shine:setVisible(false)
		end
	end)

	self._hpbarShine2 = self:createHpBarShine(self._hpbar2)

	self._hpbar2:setUpdateFrameHook(function(mc, frame)
		local shine = mc:getChildByName("shine")

		shine:setPositionX(-165 + 326 * frame / 100)

		if frame <= 3 then
			shine:setVisible(false)
		end
	end)

	self._hpbarShine1 = self:createHpBarShine(self._hpbar1)

	self._hpbar1:setUpdateFrameHook(function(mc, frame)
		local shine = mc:getChildByName("shine")

		shine:setPositionX(165 - 331 * frame / 100)

		if frame > 97 then
			shine:setVisible(false)
		end
	end)
	hpbar:removeFromParent()

	self._hpText = self._content:getChildByFullName("text_hp")

	self._hpText:enableOutline(cc.c4b(20, 50, 10, 204), 2)

	self._hpPercentText = self._content:getChildByFullName("text_hp_percent")
	self._baseColorTrans = self._headView:getColorTransform()
	self._originPos = cc.p(self._content:getPosition())
end

function BattleHeadTierHpWidget:createHpBarShine(parent)
	local hpBarShine = cc.MovieClip:create("guangtt_xuetiao"):posite(-166, 0):addTo(parent)

	hpBarShine:setName("shine")
	hpBarShine:setVisible(false)
	hpBarShine:addEndCallback(function(cid, mc)
		mc:stop()
		mc:setVisible(false)
	end)

	return hpBarShine
end

function BattleHeadTierHpWidget:createHpBar(hpbar, clipName, toFrame)
	local offsetHpX = self._isLeft and 3 or -3
	local offsetHpY = 0
	local hpBarNew
	local wrapLayer = ccui.Layout:create()

	wrapLayer:setAnchorPoint(cc.p(self._isLeft and 0 or 1, 0.5))
	wrapLayer:setContentSize(hpbar:getContentSize())
	wrapLayer:addTo(hpbar:getParent())

	local hpBarNew = cc.MovieClip:create(clipName):center(wrapLayer:getContentSize()):offset(offsetHpX, offsetHpY):addTo(wrapLayer)

	hpBarNew:setScaleX(hpbar:getScaleX())

	if toFrame then
		hpBarNew:gotoAndStop(toFrame)
	end

	return hpBarNew
end

function BattleHeadTierHpWidget:setMaxHpValue(orgMax, newMax)
	local grayPercent = newMax / orgMax

	if self._content:getChildByFullName("hpbar"):isVisible() then
		self._hp_gray:setVisible(true)
	else
		return
	end

	local function grayAction(duration, value)
		return cc.ScaleTo:create(duration, value, 1)
	end

	self._hpbar1:getParent():stopAllActions()
	self._hpbar2:getParent():stopAllActions()
	self._hpbar3:getParent():stopAllActions()
	self._hpbar4:getParent():stopAllActions()
	self._hp_gray:stopAllActions()
	self._hp_gray:runAction(grayAction(0.2, 1 - grayPercent))
	self._hpbar1:getParent():runAction(grayAction(0.2, grayPercent))
	self._hpbar2:getParent():runAction(grayAction(0.2, grayPercent))
	self._hpbar3:getParent():runAction(grayAction(0.2, grayPercent))
	self._hpbar4:getParent():runAction(grayAction(0.2, grayPercent))
end

function BattleHeadTierHpWidget:setHp(value, maxHp, dataModel)
	if maxHp then
		self._maxHp = maxHp
	end

	self._hp = math.min(math.ceil(value), self._maxHp)
	self._hp = math.max(self._hp, 0)

	local singleMaxHp = math.max(self._maxHp / self._hpTierCount, 1)
	local showHp = self._hp % singleMaxHp

	if showHp == 0 and singleMaxHp <= self._hp then
		showHp = singleMaxHp
	end

	local tierIndex = math.max(math.ceil(self._hp / singleMaxHp), 1)

	if tierIndex ~= self._currentHpTier then
		self._prevHpPercent = self._currentHpTier and (tierIndex > self._currentHpTier and 0 or 100) or nil
		self._currentHpTier = tierIndex

		self:_reloadHpBarTier()
	end

	local percent = showHp / singleMaxHp
	local percentFix = math.min(math.max(math.floor(percent * 100), 5), 100)

	if percentFix < 30 then
		if not self._warningEffect then
			local offsetX = 250
			local offsetY = 20

			self._warningEffect = cc.Node:create():posite(self._barbg:getPosition()):offset(0, -self._barbg:getContentSize().height):addTo(self._content, -1)

			local anim1 = cc.MovieClip:create("xinjinggaoa_xuetiao")

			anim1:addTo(self._warningEffect)
			anim1:setScaleX(self._barbg:isFlippedX() and -1 or 1)
			anim1:offset((self._barbg:isFlippedX() or nil) and (-offsetX or offsetX), offsetY)

			self._warningEffect1 = cc.Node:create():posite(self._barbg:getPosition()):offset(0, -self._barbg:getContentSize().height):addTo(self._content, 1)

			local anim2 = cc.MovieClip:create("xinjinggaob_xuetiao")

			anim2:addTo(self._warningEffect1)
			anim2:setScaleX(self._barbg:isFlippedX() and -1 or 1)
			anim2:offset((self._barbg:isFlippedX() or nil) and (-offsetX or offsetX), offsetY)
		end

		self._warningEffect:setVisible(true)
		self._warningEffect1:setVisible(true)
	elseif self._warningEffect then
		self._warningEffect:setVisible(false)
		self._warningEffect1:setVisible(false)
	end

	if self._prevHpPercent ~= percentFix then
		self._hpbar1:clearCallbacks()
		self._hpbar2:clearCallbacks()
		self._hpbar3:clearCallbacks()
		self._hpbar4:clearCallbacks()
	end

	if self._prevHpPercent == nil then
		self._hpbar1:setVisible(true)
		self._hpbar2:setVisible(false)
		self._hpbar3:setVisible(false)
		self._hpbar4:setVisible(false)
		self._hpbar1:gotoAndStop(101 - percentFix)
		self._hpbar2:gotoAndStop(percentFix)
		self._hpbar3:gotoAndStop(101 - percentFix)
		self._hpbar4:gotoAndStop(percentFix)
	elseif percentFix > self._prevHpPercent then
		self._hpbar1:setVisible(false)
		self._hpbar2:setVisible(true)
		self._hpbar3:setVisible(false)
		self._hpbar4:setVisible(true)

		if not self._curingEffect then
			local offsetHpX = self._isLeft and -4 or 4
			local offsetHpY = -0.5

			self._curingEffect = cc.MovieClip:create("daxuetiaohuifu_xuetiao"):posite(self._hpbar1:getPosition()):offset(offsetHpX, offsetHpY):addTo(self._hpbar1:getParent())

			self._curingEffect:setScaleX(self._barbg:isFlippedX() and -1 or 1)
		end

		if not self._curingEffect:isVisible() then
			self._curingEffect:setVisible(true)
			self._curingEffect:gotoAndPlay(1)
			self._curingEffect:addEndCallback(function(cid, mc)
				mc:stop()
				mc:setVisible(false)
			end)
		else
			self._curingEffect:clearCallbacks()
			self._curingEffect:addCallbackAtFrame((self._curingEffect:getCurrentFrame() - 2) % 15 + 1, function(cid, mc, frame)
				mc:stop()
				mc:setVisible(false)
			end)
		end

		local frame1 = 101 - self._hpbar1:getCurrentFrame()
		local frame2 = 101 - self._hpbar3:getCurrentFrame()
		local trgtFrame = percentFix
		local curFrame = self._prevHpPercent
		local bar = self._hpbar2
		local bar2 = self._hpbar4
		local speed = (trgtFrame - (curFrame == frame1 and bar:getCurrentFrame() or frame1)) / 24

		speed = speed > 50 and 0 or speed

		if speed > 0 then
			bar:setPlaySpeed(speed * 1)
			bar2:setPlaySpeed(speed * 1.5)
			bar:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
				bar2:setVisible(false)
			end)
			bar2:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
			end)

			if curFrame == frame1 then
				bar:play()
			else
				bar:gotoAndPlay(frame1)
			end

			if curFrame == frame2 then
				bar2:play()
			else
				bar2:gotoAndPlay(frame2)
			end

			bar:getChildByName("shine"):setVisible(true)
			bar:getChildByName("shine"):gotoAndPlay(1)
			bar2:getChildByName("shine"):setVisible(true)
			bar2:getChildByName("shine"):gotoAndPlay(1)
		else
			bar:gotoAndStop(trgtFrame)
			bar2:gotoAndStop(trgtFrame)
		end

		self._hpbar1:gotoAndStop(101 - percentFix)
		self._hpbar3:gotoAndStop(101 - percentFix)
	elseif percentFix < self._prevHpPercent then
		self._hpbar1:setVisible(true)
		self._hpbar2:setVisible(false)
		self._hpbar3:setVisible(true)
		self._hpbar4:setVisible(false)

		local frame1 = 101 - self._hpbar2:getCurrentFrame()
		local frame2 = 101 - self._hpbar4:getCurrentFrame()
		local trgtFrame = 101 - percentFix
		local curFrame = 101 - self._prevHpPercent
		local bar = self._hpbar1
		local bar2 = self._hpbar3
		local speed = (trgtFrame - (curFrame == frame1 and bar:getCurrentFrame() or frame1)) / 24

		speed = speed > 5 and 0 or speed

		if speed > 0 then
			bar:setPlaySpeed(speed * 1.5)
			bar2:setPlaySpeed(speed * 1)
			bar:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
			end)
			bar2:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
				mc:setVisible(false)
			end)

			if curFrame == frame1 then
				bar:play()
			else
				bar:gotoAndPlay(frame1)
			end

			if curFrame == frame2 then
				bar2:play()
			else
				bar2:gotoAndPlay(frame2)
			end

			bar:getChildByName("shine"):setVisible(true)
			bar:getChildByName("shine"):gotoAndPlay(1)
			bar2:getChildByName("shine"):setVisible(true)
			bar2:getChildByName("shine"):gotoAndPlay(1)
		else
			bar:gotoAndStop(trgtFrame)
			bar2:gotoAndStop(trgtFrame)
		end

		self._hpbar2:gotoAndStop(percentFix)
		self._hpbar4:gotoAndStop(percentFix)
	end

	self._prevHpPercent = percentFix

	self:_updateHpLabel()
end

function BattleHeadTierHpWidget:_updateHpLabel()
	if self._hpTierCount and self._hpTierCount > 1 then
		self._hpText:setString("X" .. tostring(self._currentHpTier))
		self._hpPercentText:setString("")
	else
		local percent = self._hp / math.max(self._maxHp, 1)

		if self._isFormat then
			self._hpText:setString(formatCount(self._hp) .. "/" .. formatCount(self._maxHp))
		else
			self._hpText:setString(self._hp .. "/" .. self._maxHp)
		end

		self._hpPercentText:setString(tostring(string.format("%.f%%", percent * 100)))
	end
end

function BattleHeadTierHpWidget:shine(context)
	local function setHpBarColor(args)
		local trans = {}

		table.deepcopy(self._baseColorTrans, trans)

		local mults, offsets = trans.mults, trans.offsets

		self._hpbar:setSaturation(args.saturation or 0)
		self._hpbar:setContrast(args.contrast or 0)
		self._hpbar:setColorTransform(ColorTransform(args.r or mults.x, args.g or mults.y, args.b or mults.z, args.a or mults.w, args.o_r or offsets.x, args.o_g or offsets.y, args.o_b or offsets.z, args.o_a or offsets.w))
	end

	local function shake(offset)
		if offset then
			self._content:offset(offset.x, offset.y)
		end
	end

	if self._hpBarTask then
		self._hpBarTask:stop()
	end

	self._tick = 0
	self._hpBarTask = context:scalableSchedule(function(task, dt)
		if self._hpBarTask ~= task then
			task:stop()

			return
		end

		self._tick = self._tick + 1

		if self._colors[self._tick] then
			setHpBarColor(self._colors[self._tick])
			shake(self._shakes[self._tick])
		else
			setHpBarColor({})
			self._content:setPosition(self._originPos)
			task:stop()

			self._hpBarTask = nil
		end
	end, 0.05, true)
end

function BattleHeadTierHpWidget:shake(context)
	local function shake(offset)
		if offset then
			self._content:offset(offset.x, offset.y)
		end
	end

	if self._hpBarTask then
		self._hpBarTask:stop()
	end

	self._tick = 0
	self._hpBarTask = context:scalableSchedule(function(task, dt)
		if self._hpBarTask ~= task then
			task:stop()

			return
		end

		self._tick = self._tick + 1

		if self._shakes[self._tick] then
			shake(self._shakes[self._tick])
		else
			self._content:setPosition(self._originPos)
			task:stop()

			self._hpBarTask = nil
		end
	end, 0.06, true)
end

local HpGradualMap = {
	"zhandou_bg_bossxt_1.png",
	"zhandou_bg_bossxt_2.png",
	"zhandou_bg_bossxt_3.png"
}
local HpImgMap = {
	"zhandou_icon_xue.png",
	"zhandou_icon_xue_2.png",
	"zhandou_icon_xue_3.png"
}

BattleHeadGradualHpWidget = class("BattleHeadGradualHpWidget", BattleHeadHpWidget, _M)

BattleHeadGradualHpWidget:has("_maxHp", {
	is = "rw"
})
BattleHeadGradualHpWidget:has("_prevHpPercent", {
	is = "rw"
})

function BattleHeadGradualHpWidget:initialize(headView, isLeft)
	super.initialize(self)
	self:setIsLeft(isLeft)

	self._headView = headView

	self:_setupUI()

	self._colors = {
		HpColor.Red,
		HpColor.White,
		HpColor.Red
	}
	self._shakes = {
		cc.p(0.5, 13.2),
		cc.p(7.5, -8.25),
		cc.p(-8, -4.95),
		cc.p(3.9, 4.65),
		cc.p(-6.699999999999999, -1.1000000000000005)
	}
end

function BattleHeadGradualHpWidget:dispose()
	super.dispose(self)

	if self._hpBarTask then
		self._hpBarTask:stop()

		self._hpBarTask = nil
	end
end

function BattleHeadGradualHpWidget:_setupUI()
	local content = self._headView:getChildByFullName("content")

	self._content = content

	local hpbar = content:getChildByFullName("hpbar.hpbar")

	self._hpbar = hpbar
	self._imgHp = content:getChildByName("img_hp")
	self._hpText = content:getChildByFullName("text_hp")
	self._hp_gray = content:getChildByFullName("hp_gray")

	self._hp_gray:offset(9, 0)
	self._hp_gray:setScaleX(0)

	local graySize = self._hp_gray:getContentSize()

	graySize.height = graySize.height - 2

	self._hp_gray:setContentSize(graySize)
	self._hpText:enableOutline(cc.c4b(20, 50, 10, 204), 2)

	self._barbg = content:getChildByName("bar_bg")
	self._hpbar2 = self:createHpBar(hpbar, "bxuetiaoa_large_xuetiao")
	self._hpbar1 = self:createHpBar(hpbar, "bxuetiaolarge_xuetiao")
	self._barPic2 = ccui.ImageView:create()

	self._barPic2:loadTexture(HpGradualMap[1], ccui.TextureResType.plistType)
	self._barPic2:addTo(self._hpbar2:getChildByName("bar"))
	self._hpbar2:gotoAndStop(1)

	self._barPic1 = ccui.ImageView:create()

	self._barPic1:loadTexture(HpGradualMap[1], ccui.TextureResType.plistType)
	self._barPic1:addTo(self._hpbar1:getChildByName("bar"))
	self._hpbar1:gotoAndStop(100)

	self._hpbarShine2 = self:createHpBarShine(self._hpbar2)

	self._hpbar2:setUpdateFrameHook(function(mc, frame)
		local shine = mc:getChildByName("shine")

		shine:setPositionX(-383 + 770 * frame / 100)

		if frame <= 3 then
			shine:setVisible(false)
		end
	end)

	self._hpbarShine1 = self:createHpBarShine(self._hpbar1)

	self._hpbar1:setUpdateFrameHook(function(mc, frame)
		local shine = mc:getChildByName("shine")

		shine:setPositionX(383 - 770 * frame / 100)

		if frame > 97 then
			shine:setVisible(false)
		end
	end)
	hpbar:removeFromParent()

	self._hpPercentText = content:getChildByFullName("text_hp_percent")
	self._baseColorTrans = self._headView:getColorTransform()
	self._originPos = cc.p(content:getPosition())
end

function BattleHeadGradualHpWidget:setIsLeft(isLeft)
	self._isLeft = isLeft

	if self._isLeft then
		self._shakes = {
			cc.p(-0.5, 13.2),
			cc.p(-7.5, -8.25),
			cc.p(8, -4.95),
			cc.p(-3.9, 4.65),
			cc.p(6.699999999999999, -1.1000000000000005)
		}
	end
end

function BattleHeadGradualHpWidget:createHpBarShine(parent)
	local hpBarShine = cc.MovieClip:create("guangtt_xuetiao"):posite(-166, 0):addTo(parent)

	hpBarShine:setName("shine")
	hpBarShine:setVisible(false)
	hpBarShine:addEndCallback(function(cid, mc)
		mc:stop()
		mc:setVisible(false)
	end)

	return hpBarShine
end

function BattleHeadGradualHpWidget:_createWaringEffect()
	if not self._warningEffect then
		local offsetX = 250
		local offsetY = 20

		self._warningEffect = cc.Node:create():posite(self._barbg:getPosition()):offset(0, -self._barbg:getContentSize().height):addTo(self._content, -1)

		local anim1 = cc.MovieClip:create("xinjinggaoa_xuetiao")

		anim1:addTo(self._warningEffect)
		anim1:setScaleX(self._barbg:isFlippedX() and -1 or 1)
		anim1:offset((self._barbg:isFlippedX() or nil) and (-offsetX or offsetX), offsetY)

		self._warningEffect1 = cc.Node:create():posite(self._barbg:getPosition()):offset(0, -self._barbg:getContentSize().height):addTo(self._content, 1)

		local anim2 = cc.MovieClip:create("xinjinggaob_xuetiao")

		anim2:addTo(self._warningEffect1)
		anim2:setScaleX(self._barbg:isFlippedX() and -1 or 1)
		anim2:offset((self._barbg:isFlippedX() or nil) and (-offsetX or offsetX), offsetY)
	end
end

function BattleHeadGradualHpWidget:_createCuringEffect()
	if not self._curingEffect then
		local offsetHpX = self._isLeft and -4 or 4
		local offsetHpY = -0.5

		self._curingEffect = cc.MovieClip:create("daxuetiaohuifu_xuetiao"):posite(self._hpbar1:getPosition()):offset(offsetHpX, offsetHpY):addTo(self._hpbar1:getParent())

		self._curingEffect:setScaleX(self._barbg:isFlippedX() and -1 or 1)
	end
end

function BattleHeadGradualHpWidget:_reloadHpBarPic(prePercent, curPercent)
	local loadTexture = ""
	local hpImg = ""

	if curPercent >= 50 then
		loadTexture = HpGradualMap[1]
		hpImg = HpImgMap[1]
	elseif curPercent >= 30 and curPercent < 50 then
		loadTexture = HpGradualMap[2]
		hpImg = HpImgMap[2]
	elseif curPercent < 30 then
		loadTexture = HpGradualMap[3]
		hpImg = HpImgMap[3]
	end

	self._imgHp:loadTexture(hpImg, ccui.TextureResType.plistType)
	self._barPic1:loadTexture(loadTexture, ccui.TextureResType.plistType)
	self._barPic2:loadTexture(loadTexture, ccui.TextureResType.plistType)
end

function BattleHeadGradualHpWidget:createHpBar(hpbar, clipName, toFrame)
	local offsetHpX = self._isLeft and 3 or -3
	local offsetHpY = 0
	local hpBarNew
	local wrapLayer = ccui.Layout:create()

	wrapLayer:setAnchorPoint(cc.p(self._isLeft and 0 or 1, 0.5))
	wrapLayer:setContentSize(hpbar:getContentSize())
	wrapLayer:addTo(hpbar:getParent())

	local hpBarNew = cc.MovieClip:create(clipName):center(wrapLayer:getContentSize()):offset(offsetHpX, offsetHpY):addTo(wrapLayer)

	hpBarNew:setScaleX(hpbar:getScaleX())

	if toFrame then
		hpBarNew:gotoAndStop(toFrame)
	end

	return hpBarNew
end

function BattleHeadGradualHpWidget:setMaxHpValue(orgMax, newMax)
	local grayPercent = newMax / orgMax

	self._hp_gray:setVisible(true)

	local function grayAction(duration, value)
		return cc.ScaleTo:create(duration, value, 1)
	end

	self._hpbar1:getParent():stopAllActions()
	self._hpbar2:getParent():stopAllActions()
	self._hp_gray:stopAllActions()
	self._hpbar1:getParent():runAction(grayAction(0.2, grayPercent))
	self._hpbar2:getParent():runAction(grayAction(0.2, grayPercent))
	self._hp_gray:runAction(grayAction(0.2, 1 - grayPercent))
end

function BattleHeadGradualHpWidget:setHp(value, maxHp, dataModel)
	if maxHp then
		self._maxHp = maxHp
	end

	self._hp = math.max(math.min(math.ceil(value), self._maxHp), 0)

	local percent = self._hp / self._maxHp
	local percentFix = math.min(math.max(math.floor(percent * 100), 1), 100)

	if percentFix < 30 then
		self:_createWaringEffect()
		self._warningEffect:setVisible(true)
		self._warningEffect1:setVisible(true)
	elseif self._warningEffect then
		self._warningEffect:setVisible(false)
		self._warningEffect1:setVisible(false)
	end

	if self._prevHpPercent ~= percentFix then
		self._hpbar1:clearCallbacks()
		self._hpbar2:clearCallbacks()
		self:_reloadHpBarPic(self._prevHpPercent, percentFix)
	end

	if self._prevHpPercent == nil then
		self._hpbar1:setVisible(true)
		self._hpbar2:setVisible(false)
		self._hpbar1:gotoAndStop(101 - percentFix)
		self._hpbar2:gotoAndStop(percentFix)
	elseif percentFix > self._prevHpPercent then
		self._hpbar1:setVisible(false)
		self._hpbar2:setVisible(true)
		self:_createCuringEffect()

		if not self._curingEffect:isVisible() then
			self._curingEffect:setVisible(true)
			self._curingEffect:gotoAndPlay(1)
			self._curingEffect:addEndCallback(function(cid, mc)
				mc:stop()
				mc:setVisible(false)
			end)
		else
			self._curingEffect:clearCallbacks()
			self._curingEffect:addCallbackAtFrame((self._curingEffect:getCurrentFrame() - 2) % 15 + 1, function(cid, mc, frame)
				mc:stop()
				mc:setVisible(false)
			end)
		end

		local frame1 = 101 - self._hpbar1:getCurrentFrame()
		local trgtFrame = percentFix
		local curFrame = self._prevHpPercent
		local bar = self._hpbar2
		local speed = (trgtFrame - (curFrame == frame1 and bar:getCurrentFrame() or frame1)) / 24

		speed = speed > 50 and 0 or speed

		if speed > 0 then
			bar:setPlaySpeed(speed * 1)
			bar:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
			end)

			if curFrame == frame1 then
				bar:play()
			else
				bar:gotoAndPlay(frame1)
			end

			bar:getChildByName("shine"):setVisible(true)
			bar:getChildByName("shine"):gotoAndPlay(1)
		else
			bar:gotoAndStop(trgtFrame)
		end

		self._hpbar1:gotoAndStop(101 - percentFix)
	elseif percentFix < self._prevHpPercent then
		self._hpbar1:setVisible(true)
		self._hpbar2:setVisible(false)

		local frame1 = 101 - self._hpbar2:getCurrentFrame()
		local trgtFrame = 101 - percentFix
		local curFrame = 101 - self._prevHpPercent
		local bar = self._hpbar1
		local speed = (trgtFrame - (curFrame == frame1 and bar:getCurrentFrame() or frame1)) / 24

		speed = speed > 5 and 0 or speed

		if speed > 0 then
			bar:setPlaySpeed(speed * 1.5)
			bar:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
			end)

			if curFrame == frame1 then
				bar:play()
			else
				bar:gotoAndPlay(frame1)
			end

			bar:getChildByName("shine"):setVisible(true)
			bar:getChildByName("shine"):gotoAndPlay(1)
		else
			bar:gotoAndStop(trgtFrame)
		end

		self._hpbar2:gotoAndStop(percentFix)
	end

	self._prevHpPercent = percentFix

	self:_updateHpLabel()
end

function BattleHeadGradualHpWidget:_updateHpLabel()
	local percent = self._hp / math.max(self._maxHp, 1)

	if self._isFormat then
		self._hpText:setString(formatCount(self._hp) .. "/" .. formatCount(self._maxHp))
	else
		self._hpText:setString(self._hp .. "/" .. self._maxHp)
	end

	self._hpPercentText:setString(tostring(string.format("%.f%%", percent * 100)))
end

function BattleHeadGradualHpWidget:shine(context)
	local function setHpBarColor(args)
		local trans = {}

		table.deepcopy(self._baseColorTrans, trans)

		local mults, offsets = trans.mults, trans.offsets

		self._hpbar:setSaturation(args.saturation or 0)
		self._hpbar:setContrast(args.contrast or 0)
		self._hpbar:setColorTransform(ColorTransform(args.r or mults.x, args.g or mults.y, args.b or mults.z, args.a or mults.w, args.o_r or offsets.x, args.o_g or offsets.y, args.o_b or offsets.z, args.o_a or offsets.w))
	end

	local function shake(offset)
		if offset then
			self._content:offset(offset.x, offset.y)
		end
	end

	if self._hpBarTask then
		self._hpBarTask:stop()
	end

	self._tick = 0
	self._hpBarTask = context:scalableSchedule(function(task, dt)
		if self._hpBarTask ~= task then
			task:stop()

			return
		end

		self._tick = self._tick + 1

		if self._colors[self._tick] then
			setHpBarColor(self._colors[self._tick])
			shake(self._shakes[self._tick])
		else
			setHpBarColor({})
			self._content:setPosition(self._originPos)
			task:stop()

			self._hpBarTask = nil
		end
	end, 0.05, true)
end

function BattleHeadGradualHpWidget:shake(context)
	local function shake(offset)
		if offset then
			self._content:offset(offset.x, offset.y)
		end
	end

	if self._hpBarTask then
		self._hpBarTask:stop()
	end

	self._tick = 0
	self._hpBarTask = context:scalableSchedule(function(task, dt)
		if self._hpBarTask ~= task then
			task:stop()

			return
		end

		self._tick = self._tick + 1

		if self._shakes[self._tick] then
			shake(self._shakes[self._tick])
		else
			self._content:setPosition(self._originPos)
			task:stop()

			self._hpBarTask = nil
		end
	end, 0.06, true)
end
