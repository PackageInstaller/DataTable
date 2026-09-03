-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleHeadWidget.lua

BattleHeadWidget = class("BattleHeadWidget", BattleWidget, _M)

function BattleHeadWidget:initialize(view, isLeft, isGradual)
	super.initialize(self, view)

	if isGradual then
		self._hpWidget = BattleHeadGradualHpWidget:new(view, isLeft) or BattleHeadTierHpWidget:new(view, isLeft)
	end

	if isLeft then
		self:setIsLeft()
	end

	self:_setupUI()
end

function BattleHeadWidget:dispose()
	super.dispose(self)
	self._hpWidget:dispose()
end

function BattleHeadWidget:setIsLeft()
	self._isLeft = true

	self._hpWidget:setIsLeft(true)
end

function BattleHeadWidget:modifyMaxHp(maxHp, orgMaxHp)
	self._hpWidget:setMaxHpValue(orgMaxHp, maxHp)
end

function BattleHeadWidget:setHpFormat(isFormat)
	self._hpWidget:setIsFormat(isFormat)
end

function BattleHeadWidget:_setupUI()
	self._content = self:getView():getChildByFullName("content")

	local mpbar = self._content:getChildByFullName("mpbar.mpbar")
	local offsetMpX = self._isLeft and 7 or -7
	local offsetMpY = 2

	self._mpbar3 = cc.MovieClip:create("bnengliangcc_xuetiao"):posite(mpbar:getPosition()):offset(offsetMpX, offsetMpY):addTo(mpbar:getParent())

	self._mpbar3:setScaleX(mpbar:getScaleX())
	self._mpbar3:gotoAndStop(100)

	self._mpbar2 = cc.MovieClip:create("bnengliangbb_xuetiao"):posite(mpbar:getPosition()):offset(offsetMpX, offsetMpY):addTo(mpbar:getParent())

	self._mpbar2:setScaleX(mpbar:getScaleX())
	self._mpbar2:gotoAndStop(100)

	self._mpbar1 = cc.MovieClip:create("bnengliang_xuetiao"):posite(mpbar:getPosition()):offset(offsetMpX, offsetMpY):addTo(mpbar:getParent())

	self._mpbar1:setScaleX(mpbar:getScaleX())
	self._mpbar1:gotoAndStop(1)
	mpbar:removeFromParent()

	self._cardText = self._content:getChildByFullName("text_card")
	self._headNode = self._content:getChildByFullName("head")

	self._headNode:setVisible(false)

	self._baseColorTrans = self._view:getColorTransform()
	self._originPos = cc.p(self._content:getPosition())
end

function BattleHeadWidget:setMasterIcon(modelId)
	if self._headNode:getChildByName("SpecificIcon") then
		return
	end

	if not modelId then
		return
	end

	self._headNode:setVisible(true)
	self._headNode:removeChildByName("HeadIcon")

	local stencil = self._headNode:getChildByName("stencil"):clone()

	stencil:setVisible(true)
	stencil:setPositionY(0)

	local img = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe10",
		id = modelId
	})

	img:setScaleX(self._isLeft and 1 or -1)
	img:addTo(self._headNode):posite(0, 0):setName("HeadIcon")
end

function BattleHeadWidget:setSpecificIcon(filePath)
	local img = cc.Sprite:create(filePath)

	if not img then
		return
	end

	self._headNode:setVisible(true)
	self._headNode:removeChildByName("SpecificIcon")

	local stencil = self._headNode:getChildByName("stencil"):clone()

	stencil:setVisible(true)
	stencil:setPositionY(0)
	stencil:setAnchorPoint(cc.p(0, 0))

	local size = stencil:getContentSize()

	img:setAnchorPoint(cc.p(0, 0))
	img:setPosition(cc.p(0, 0))
	img:offset(12, -2)
	img:setFlippedX(not self._isLeft)

	sprite = ClippingNodeUtils.getClippingNodeByData({
		stencil = stencil,
		content = img
	}, alpha)

	sprite:setContentSize(size)
	sprite:setScaleX(self._isLeft and 1 or -1)
	sprite:setAnchorPoint(cc.p(0.5, 0.5))
	sprite:setIgnoreAnchorPointForPosition(false)
	sprite:addTo(self._headNode):posite(0, 0):setName("SpecificIcon")
end

function BattleHeadWidget:setListener(listener)
	self._listener = listener
end

function BattleHeadWidget:setHp(value, maxHp)
	self._hpWidget:setHp(value, maxHp, self._dataModel)
end

function BattleHeadWidget:setRp(value, maxRp)
	local mpPercent = value / maxRp * 100
	local percentFix = math.max(math.floor(mpPercent), 1)

	if self._prevRpPercent ~= percentFix then
		self._mpbar1:clearCallbacks()
		self._mpbar2:clearCallbacks()
		self._mpbar3:clearCallbacks()
	end

	if self._prevRpPercent == nil then
		self._mpbar1:setVisible(true)
		self._mpbar2:setVisible(false)
		self._mpbar3:setVisible(false)
		self._mpbar1:gotoAndStop(percentFix)
		self._mpbar2:gotoAndStop(101 - percentFix)
		self._mpbar3:gotoAndStop(101 - percentFix)
	elseif percentFix > self._prevRpPercent then
		self._mpbar1:setVisible(true)
		self._mpbar2:setVisible(false)
		self._mpbar3:setVisible(false)

		local frame1 = 101 - self._mpbar2:getCurrentFrame()
		local trgtFrame = percentFix
		local curFrame = self._prevRpPercent
		local bar = self._mpbar1
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
		else
			bar:gotoAndStop(trgtFrame)
		end

		self._mpbar2:gotoAndStop(101 - percentFix)
		self._mpbar3:gotoAndStop(101 - percentFix)
	elseif percentFix < self._prevRpPercent then
		self._mpbar1:setVisible(false)
		self._mpbar2:setVisible(true)
		self._mpbar3:setVisible(true)

		local frame1 = 101 - self._mpbar1:getCurrentFrame()
		local trgtFrame = 101 - percentFix
		local curFrame = 101 - self._prevRpPercent
		local bar = self._mpbar2
		local bar2 = self._mpbar3
		local speed = (trgtFrame - (curFrame == frame1 and bar:getCurrentFrame() or frame1)) / 24

		speed = speed > 50 and 0 or speed

		if speed > 0 then
			bar:setPlaySpeed(speed * 1.5)
			bar2:setPlaySpeed(speed * 1)
			bar:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
			end)
			bar2:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
			end)

			if curFrame == frame1 then
				bar:play()
				bar2:play()
			else
				bar:gotoAndPlay(frame1)
				bar2:gotoAndPlay(frame1)
			end
		else
			bar:gotoAndStop(trgtFrame)
			bar2:gotoAndStop(trgtFrame)
		end

		self._mpbar1:gotoAndStop(percentFix)
	end

	self._prevRpPercent = percentFix

	if maxRp <= value then
		if not self._rpBarEffect then
			self._rpBarEffect = cc.Node:create():posite(self._mpbar1:getPosition()):offset(self._isLeft and -7 or 7, 1):addTo(self._mpbar1:getParent())

			local anim1 = cc.MovieClip:create("nenglman_xuetiao")

			anim1:addTo(self._rpBarEffect)
		end

		self._rpBarEffect:setVisible(true)
	elseif self._rpBarEffect then
		self._rpBarEffect:setVisible(false)
	end
end

function BattleHeadWidget:setCardNum(cardNum)
	if cardNum then
		self._cardNum = cardNum

		self._cardText:setString(tostring(cardNum))
	end
end

function BattleHeadWidget:reduceCard(cardType)
	if cardType == "skill" then
		return
	end

	if self._cardNum and self._cardNum > 0 then
		self._cardNum = self._cardNum - 1 or 0
	end

	self._cardText:setString(tostring(self._cardNum))
end

function BattleHeadWidget:addCard(cardType)
	if cardType == "skill" then
		return
	end

	if self._cardNum and self._cardNum >= 0 then
		self._cardNum = self._cardNum + 1 or 1
	end

	self._cardText:setString(tostring(self._cardNum))
end

function BattleHeadWidget:updateHeadInfo(data, dataModel)
	self._dataModel = dataModel

	self._hpWidget:setMaxHp(data.maxHp)
	self:setMasterIcon(data.modelId)
	self._hpWidget:setPrevHpPercent(nil)

	self._prevRpPercent = nil

	self._hpWidget:setHp(data.hp, nil, self._dataModel)
	self:setRp(data.mp, data.maxMp)
end

function BattleHeadWidget:shine(context)
	self._hpWidget:shine(context)
end

function BattleHeadWidget:shake(context)
	self._hpWidget:shake(context)
end

function BattleHeadWidget:updateHeros(heros)
	self._heros = heros
	self._heroInfos = {}
end

function BattleHeadWidget:spawnHero(dataModel)
	if self._heros and next(self._heros) ~= nil then
		local heroId = dataModel:getRoleId()

		for i = 1, #self._heros do
			if heroId == self._heros[i] then
				self._prevHpPercent = nil

				self:updateHeroHpInfo(heroId, dataModel:getHp(), dataModel:getMaxHp())

				return true
			end
		end
	end
end

function BattleHeadWidget:updateHeroHpInfo(heroId, hp, maxHp)
	if self._heros and next(self._heros) ~= nil then
		local totalHp, totalMaxHp = 0, 0
		local changed = false

		for i = 1, #self._heros do
			self._heroInfos[i] = self._heroInfos[i] or {}

			if self._heros[i] == heroId then
				if hp then
					self._heroInfos[i].hp = hp
				end

				if maxHp then
					self._heroInfos[i].maxHp = maxHp
				end

				changed = true
			end

			totalHp = totalHp + (self._heroInfos[i].hp or 0)
			totalMaxHp = totalMaxHp + (self._heroInfos[i].maxHp or 0)
		end

		if changed then
			self:setHp(totalHp, totalMaxHp)
		end
	end
end

function BattleHeadWidget:unitFlee(heroId)
	if self._heros and next(self._heros) ~= nil then
		local totalHp, totalMaxHp = 0, 0
		local fleeIndex

		for i = 1, #self._heros do
			self._heroInfos[i] = self._heroInfos[i] or {}

			if self._heros[i] == heroId then
				fleeIndex = i
			else
				totalHp = totalHp + (self._heroInfos[i].hp or 0)
				totalMaxHp = totalMaxHp + (self._heroInfos[i].maxHp or 0)
			end
		end

		if fleeIndex then
			self._hpWidget:setHp(totalHp, totalMaxHp)
			table.remove(self._heros, fleeIndex)
			table.remove(self._heroInfos, fleeIndex)
		end
	end
end
