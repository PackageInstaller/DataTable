-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/worldBoss/WorldBossHero.lua

WorldBossHero = class("WorldBossHero", DmBaseUI)

WorldBossHero:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WorldBossHero:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
WorldBossHero:has("_leadStageArenaSystem", {
	is = "r"
}):injectWith("LeadStageArenaSystem")

local moveActionTag = 90960
local moveSpeed = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBoss_ModelWalkSpeed", "content")

KActivityHolidayHeroActionSta = {
	kIdel = "stand",
	kMove = "walk"
}

local posList = {
	cc.p(150, 120),
	cc.p(150, 30),
	cc.p(690, 120),
	cc.p(690, 30),
	cc.p(1050, 120),
	cc.p(1050, 30),
	cc.p(1630, 120),
	cc.p(1630, 30)
}

function WorldBossHero:initialize(view)
	super.initialize(self, view)
	self:setupView()

	self._baseNode = ccui.Layout:create()

	self._baseNode:setContentSize(cc.size(100, 120))

	self._createSta = false

	self:getView():addChild(self._baseNode)
end

function WorldBossHero:dispose()
	super.dispose(self)
end

function WorldBossHero:enterWithData(posIndex)
	self._currentState = nil
	self._standTimes = 0
	self._walkEndTime = 0
	self._scale = 0.7
	self._pos = posList[posIndex]
	self._posIndex = posIndex
	self._heroOffset = cc.p(0, 0)

	self:getView():setPosition(self._pos)
	self:initHeroAnim()
	self:initNameInfo()
	self:initBubble()

	self._createSta = true

	self:switchHeroSta(KActivityHolidayHeroActionSta.kMove)
end

function WorldBossHero:getPosIndex()
	return self._posIndex
end

function WorldBossHero:setHeroInfo(heroInfo, delegate)
	self._heroInfo = heroInfo
	self._modelId = IconFactory:getRoleModelByKey("HeroBase", self._heroInfo:getModelId())
	self._delegate = delegate

	self._baseNode:setTouchEnabled(true)
end

function WorldBossHero:setupView()
	return
end

function WorldBossHero:initHeroAnim()
	self._animNode = RoleFactory:createHeroAnimation(self._modelId, "stand")

	self._animNode:setScale(self._scale)
	self._animNode:posite(50, 0)
	self._baseNode:addChild(self._animNode)
end

function WorldBossHero:switchHeroSta(sta)
	if not self._createSta then
		return
	end

	self._currentState = sta

	self:playAnimation(self._currentState)
	self._baseNode:stopActionByTag(moveActionTag)

	if sta == KActivityHolidayHeroActionSta.kIdel then
		self:heroIdel()
	elseif sta == KActivityHolidayHeroActionSta.kMove then
		self:heroMove()
	end

	self:setHeroZorder()
end

function WorldBossHero:initBubble()
	self._bubbleNode = ccui.Widget:create()

	self._bubbleNode:setCascadeOpacityEnabled(true)
	self._bubbleNode:addTo(self._baseNode):posite(50, 120)

	local bubbleImg = ccui.Scale9Sprite:createWithSpriteFrameName("zhandou_bg_qipao_1.png")

	bubbleImg:setCapInsets(cc.rect(40, 21, 10, 5))
	bubbleImg:setContentSize(cc.size(200, 96))
	bubbleImg:addTo(self._bubbleNode)
	bubbleImg:setName("bubbleImg")
	bubbleImg:setAnchorPoint(0, 0)
	bubbleImg:setFlippedX(true)
	bubbleImg:setPositionY(-25)

	local bubbleText = ccui.Text:create("", TTF_FONT_FZYH_M, 18)

	bubbleText:setColor(cc.c3b(0, 0, 0))
	bubbleText:getVirtualRenderer():setDimensions(180, 0)
	bubbleText:addTo(self._bubbleNode):posite(12, -8)
	bubbleText:setName("bubbleText")
	bubbleText:setAnchorPoint(0, 0)
	self._bubbleNode:setVisible(false)
end

function WorldBossHero:showBubble(text)
	local staySec = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBoss_ModelSpwanSec", "content")

	if self._bubbleNode:isVisible() then
		return
	end

	self._bubbleNode:setVisible(true)
	self._bubbleNode:setOpacity(0)

	local bubbleText = self._bubbleNode:getChildByName("bubbleText")

	bubbleText:setString(text)

	local size = bubbleText:getContentSize()
	local bubbleImg = self._bubbleNode:getChildByName("bubbleImg")
	local height = math.max(41, size.height + 25)
	local strlen = utf8.len(text) * 18
	local w = math.min(200, strlen + 30)

	bubbleText:setPositionX(-w + 15)
	bubbleImg:setContentSize(cc.size(w, height))

	local fadeIn = cc.FadeIn:create(0.2)
	local delay = cc.DelayTime:create(staySec)
	local callback = cc.CallFunc:create(function()
		self._bubbleNode:setVisible(false)
		self:switchHeroSta(KActivityHolidayHeroActionSta.kMove)
	end)

	self._bubbleNode:runAction(cc.Sequence:create(fadeIn, delay, callback))
end

function WorldBossHero:initNameInfo()
	self._nameInfoNode = cc.Node:create()

	self._nameInfoNode:addTo(self._baseNode):posite(50, 150)

	local nameImg = ccui.Scale9Sprite:createWithSpriteFrameName("stageArena_name_di.png")

	nameImg:setCapInsets(cc.rect(40, 21, 10, 5))
	nameImg:setContentSize(cc.size(162, 35))
	nameImg:addTo(self._nameInfoNode)
	nameImg:setName("nameImg")

	local nameText = ccui.Text:create(self._heroInfo:getNickName(), TTF_FONT_FZYH_M, 18)
	local rid = self._heroInfo:getRid()
	local mrid = self._developSystem:getRid()

	nameText:setColor(rid == mrid and cc.c3b(170, 240, 20) or cc.c3b(255, 255, 255))
	nameText:getVirtualRenderer():setDimensions(180, 0)
	nameText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	nameText:addTo(self._nameInfoNode):posite(0, 2)
	nameText:setName("nameText")

	local icon = ccui.ImageView:create(leadStageArenaPicPath, ccui.TextureResType.plistType)

	icon:setAnchorPoint(0, 0.5)
	icon:setScale(0.3)
	icon:addTo(self._nameInfoNode)
	self._nameInfoNode:setVisible(true)
end

function WorldBossHero:heroIdel()
	local staySec = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Newyear_ModelStaySec", "content")
	local times = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Newyyear_ModelStayTimes", "content")

	self._standTimes = self._standTimes + 1

	if self._standTimes == times then
		self._standTimes = 0

		local list = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBoss_MainBubble", "content")
		local random = math.random(1, #list)

		self:showBubble(Strings:get(list[random]))
	else
		local delay = cc.DelayTime:create(staySec)
		local callback = cc.CallFunc:create(function()
			self:switchHeroSta(KActivityHolidayHeroActionSta.kMove)
		end)

		self._baseNode:runAction(cc.Sequence:create(delay, callback))
	end
end

function WorldBossHero:afterMoveAction()
	if self._gameServerAgent:remoteTimeMillis() > self._walkEndTime then
		self:switchHeroSta(KActivityHolidayHeroActionSta.kIdel)
	else
		self:heroMove()
	end
end

function WorldBossHero:getHeroCanGoPos(posIndex)
	local list = {}

	for i, v in pairs(posList) do
		if posIndex ~= i and not self._delegate:hasHeroStay(i) then
			list[#list + 1] = v
		end
	end

	return list
end

function WorldBossHero:getNewPosIndex()
	for i, v in pairs(posList) do
		if v.x == self._pos.x and v.y == self._pos.y then
			return i
		end
	end
end

function WorldBossHero:heroMove()
	self._baseNode:stopActionByTag(moveActionTag)

	local posInfoList = self:getHeroCanGoPos(self._posIndex)

	if #posInfoList > 0 then
		local index = math.random(1, #posInfoList)
		local posTo = posInfoList[index]
		local startTime = app.getTime()
		local updateTime = startTime
		local posNow = self._pos
		local posNext = posTo

		self._pos = cc.p(posTo.x, posTo.y)
		self._posIndex = self:getNewPosIndex()

		local offset = cc.p(posNext.x - posNow.x, posNext.y - posNow.y)
		local delta = math.abs(math.floor(cc.pGetDistance(posNow, posNext)))
		local heroMoveTime = delta / moveSpeed
		local view = self:getView()

		if posNow.x > posNext.x then
			self._animNode:setScaleX(-1 * self._scale)
		else
			self._animNode:setScaleX(self._scale * 1)
		end

		local action = schedule(self._baseNode, function()
			local timeNow = app.getTime()
			local timeEnd = timeNow

			if timeNow - startTime > heroMoveTime then
				timeEnd = startTime + heroMoveTime
			end

			local timeOffset = timeEnd - updateTime

			updateTime = timeEnd

			if timeNow - startTime >= heroMoveTime then
				self._baseNode:stopActionByTag(moveActionTag)
				self:afterMoveAction()
			end

			local timePercent = timeOffset / heroMoveTime
			local moveOffset = cc.p(offset.x * timePercent, offset.y * timePercent)
			local positionX = view:getPositionX()
			local positionY = view:getPositionY()

			view:setPosition(cc.p(positionX + moveOffset.x, positionY + moveOffset.y))
			self:setHeroZorder()
		end, 0)

		action:setTag(moveActionTag)
	else
		self:switchHeroSta(KActivityHolidayHeroActionSta.kIdel)
	end
end

function WorldBossHero:playAnimation(name)
	self._currentState = name

	self._animNode:playAnimation(0, name, true)
end

function WorldBossHero:setHeroZorder()
	local view = self:getView()

	view:setLocalZOrder(10000 - self._view:getPositionY())
end
