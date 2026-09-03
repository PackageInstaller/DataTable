-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/CardArrayWidget.lua

CardWidgetSlot = class("CardWidgetSlot", objectlua.Object, _M)
KSlotType = {
	NORMAL = 1,
	EXTRA = 2
}

function CardWidgetSlot:initialize(container)
	super.initialize(self)

	self._node = container
	self._slotType = KSlotType.NORMAL
end

function CardWidgetSlot:getContainerNode()
	return self._node
end

function CardWidgetSlot:getCard()
	return self._card
end

function CardWidgetSlot:getSlotType()
	return self._slotType
end

function CardWidgetSlot:setSlotType(type)
	self._slotType = type
end

function CardWidgetSlot:setCard(cardWidget, action)
	if self._card == cardWidget then
		return
	end

	if self._card then
		local cardNode = self._card:getView()

		cardNode:removeFromParent(true)
	end

	self._card = cardWidget

	if cardWidget then
		if cardWidget then
			cardWidget:setNormalMod()
		end

		local function setupCardNode()
			local cardNode = cardWidget:getView()

			if cardNode:getParent() == nil then
				self._node:getChildByName("node"):addChild(cardNode, 1)
			else
				cardNode:changeParent(self._node:getChildByName("node"), 1)
			end

			cardWidget:restoreNormalState(cc.p(0, 0))
		end

		if action == nil then
			setupCardNode()
		else
			cardWidget:startEnterAnimation(action, function()
				if cardWidget == self._card then
					setupCardNode()
				end
			end)
		end
	else
		self._node:getChildByName("node"):stopAllActions()
		self._node:getChildByName("node"):posite(0, 0)
	end
end

function CardWidgetSlot:hitTest(globalPoint)
	if self._card == nil or self._card:isEntering() or not self._card:isAvailable() then
		return false
	end

	return self._card:hitTest(globalPoint)
end

CardArrayWidget = class("CardArrayWidget", BattleWidget, _M)

local kPreviewScale = 0.54

function CardArrayWidget:FlyCard(endCall)
	local collectObj = {}

	for k, v in pairs(self._cardSlots) do
		if v:getSlotType() == KSlotType.EXTRA and v:getCard() then
			collectObj[#collectObj + 1] = v:getCard()
		end
	end

	local scene = cc.Director:getInstance():getRunningScene()
	local actionCnt = 0
	local pos = {
		{
			cc.p(scene:getContentSize().width / 2, scene:getContentSize().height / 2)
		},
		{
			cc.p(scene:getContentSize().width / 2 - 100, scene:getContentSize().height / 2),
			cc.p(scene:getContentSize().width / 2 + 100, scene:getContentSize().height / 2)
		}
	}

	self._flyingItemsArray = {}

	for k, v in pairs(collectObj) do
		local target = ccui.ImageView:create(v:getRes())

		target:setScale(0.6)
		scene:addChild(target)
		target:setPosition(pos[#collectObj][k])

		local descPos = v:getView():getParent():convertToWorldSpace(cc.p(v:getView():getPosition()))
		local callback = cc.CallFunc:create(function()
			actionCnt = actionCnt - 1

			if actionCnt <= 0 then
				endCall()
			end

			self._flyingItemsArray[target] = nil

			target:removeFromParent()
		end)

		target:setOpacity(0)

		local upmove = cc.MoveTo:create(0.2, cc.p(target:getPositionX(), target:getPositionY() + 50))
		local up = cc.Spawn:create(upmove, cc.FadeTo:create(0.2, 255))
		local spawn = cc.Spawn:create(cc.MoveTo:create(0.4, cc.p(descPos)), cc.ScaleTo:create(0.4, 0.3))
		local sequence = cc.Sequence:create(cc.EaseSineIn:create(up), cc.DelayTime:create(0.5), cc.EaseSineOut:create(spawn), callback)

		target:runAction(sequence)

		actionCnt = actionCnt + 1
		self._flyingItemsArray[target] = target
	end
end

function CardArrayWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
	self:registerTouchEvents()
	self:setTouchEnabled(true)
end

function CardArrayWidget:dispose()
	self:unregisterTouchEvents()

	for k, v in pairs(self._flyingItemsArray or {}) do
		v:removeFromParent()
	end

	super.dispose(self)
end

function CardArrayWidget:clearAll()
	self:clearActiveCard()

	for i = 1, 4 do
		self._cardSlots[i]:setCard(nil)
	end

	for k, v in pairs(self._previewCards or {}) do
		if not v:isExtraCard() then
			v:getView():removeFromParent()
		end
	end

	self._previewCards = nil

	self._remainLabel:setString(0)
end

function CardArrayWidget:initSubviews(view)
	self._cardSlots = {}

	for i = 1, 4 do
		local container = view:getChildByName("C" .. i)

		self._cardSlots[i] = CardWidgetSlot:new(container)

		self._cardSlots[i]:setSlotType(KSlotType.NORMAl)
	end

	for i = 1, 2 do
		local container = view:getChildByName("E" .. i)

		container:setScale(0.7)
		container:offset(60, 0)

		local slotInstance = CardWidgetSlot:new(container)

		self._cardSlots[#self._cardSlots + 1] = slotInstance

		slotInstance:setSlotType(KSlotType.EXTRA)
	end

	self._previewContainer = view:getChildByName("preview")

	local remainNode = view:getChildByName("remain")

	self._remainLabel = view:getChildByName("remain_lab")

	self._remainLabel:setString(0)

	self._nextLabel = view:getChildByName("_next_label")
end

function CardArrayWidget:getCardAtIndex(index)
	local slot = self._cardSlots[index]

	return slot and slot:getCard()
end

function CardArrayWidget:setCardAtIndex(index, cardWidget)
	local slot = self._cardSlots[index]

	if slot then
		if slot:getCard() == self._activeCard then
			self:resetActiveCard()
		end

		if slot:getCard() == self._hittedCard then
			self:clearHittedCard()
		end

		slot:setCard(cardWidget)
	end
end

function CardArrayWidget:pushPreviewCard(cardWidget)
	assert(cardWidget ~= nil, "Invalid argument")

	if self._previewCards == nil then
		self._previewCards = {}
	end

	self._previewCards[#self._previewCards + 1] = cardWidget

	if cardWidget then
		cardWidget:setPreviewMod()

		local cardNode = cardWidget:getView()

		self._previewContainer:addChild(cardNode)
		cardNode:setPosition(0, 0)
		cardNode:setScale(kPreviewScale)
	end
end

function CardArrayWidget:disposePreviewCard()
	local previewCard = self:popPreviewCard()

	if previewCard == nil then
		return
	end

	previewCard:getView():removeFromParent()
end

function CardArrayWidget:popPreviewCard()
	if self._previewCards == nil then
		return nil
	end

	local topIndex = #self._previewCards
	local topCard = self._previewCards[topIndex]

	if topCard then
		self._previewCards[topIndex] = nil
	end

	return topCard
end

local kMove2Durations = {
	0.2,
	0.133,
	0.067
}

function CardArrayWidget:putPreviewCardAtIndex(index, actionDelay, timeScale)
	local targetSlot = self._cardSlots[index]

	if targetSlot == nil then
		return
	end

	local previewCard = self:popPreviewCard()

	if previewCard == nil then
		return
	end

	if timeScale == nil then
		timeScale = 1
	end

	local action

	if timeScale < 2 then
		local c4Node = self._cardSlots[4]:getContainerNode()
		local c4Pos = cc.p(c4Node:getPosition())
		local origPos = cc.p(self._previewContainer:getPosition())
		local move1 = cc.MoveTo:create(0.1 / timeScale, cc.pSub(c4Pos, origPos))
		local scale1 = cc.ScaleTo:create(0.1 / timeScale, 1)

		action = cc.Spawn:create(move1, scale1)

		local duration = kMove2Durations[index]

		if duration ~= nil then
			local trgtNode = targetSlot:getContainerNode()
			local pos = cc.p(trgtNode:getPosition())
			local move2 = cc.MoveTo:create(duration / timeScale, cc.pSub(pos, origPos))

			action = cc.Sequence:create(action, move2)
		end

		if action and actionDelay ~= nil and actionDelay > 0 then
			action = cc.Sequence:create(cc.DelayTime:create(actionDelay / timeScale), action)
		end
	end

	targetSlot:setCard(previewCard, action)
	previewCard:setIndex(index)

	return previewCard
end

function CardArrayWidget:freshEnergyStatus(energy, remain)
	for i, slot in ipairs(self._cardSlots) do
		local card = slot:getCard()

		if card then
			card:freshEnergyStatus(energy, remain)
		end
	end
end

function CardArrayWidget:getRemainingCount()
	return self._remainCount
end

function CardArrayWidget:setRemainingCount(count)
	self._remainCount = count

	if count == tonumber(self._remainLabel:getString()) then
		return
	end

	self._remainLabel:stopAllActions()

	local callFunc = cc.CallFunc:create(function()
		self._remainLabel:setString(count)
	end)
	local scale1 = cc.ScaleTo:create(0.2, 2)
	local scale2 = cc.ScaleTo:create(0.2, 1)

	self._remainLabel:runAction(cc.Sequence:create(scale1, callFunc, scale2))
end

function CardArrayWidget:setListener(listener)
	self._listener = listener
end

function CardArrayWidget:setTouchEnabled(enabled)
	self._touchEnabled = enabled
end

function CardArrayWidget:isTouchEnabled()
	return self._touchEnabled
end

function CardArrayWidget:registerTouchEvents()
	if self._touchListener then
		return
	end

	local view = self:getView()
	local listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(true)
	listener:registerScriptHandler(function(touch, event)
		return self:onTouchBegan(touch, event)
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(function(touch, event)
		return self:onTouchMoved(touch, event)
	end, cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(function(touch, event)
		return self:onTouchEnded(touch, event)
	end, cc.Handler.EVENT_TOUCH_ENDED)
	listener:registerScriptHandler(function(touch, event)
		if self._listener then
			self._listener:dragCancelled()
		end
	end, cc.Handler.EVENT_TOUCH_CANCELLED)
	view:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, view)

	self._touchListener = listener
end

function CardArrayWidget:unregisterTouchEvents()
	if self._touchListener then
		self:getView():getEventDispatcher():removeEventListener(self._touchListener)

		self._touchListener = nil
	end
end

function CardArrayWidget:onTouchBegan(touch, event)
	local pt = touch:getLocation()
	local hittedSlot

	for i, slot in ipairs(self._cardSlots) do
		if slot:hitTest(pt) then
			hittedSlot = slot

			break
		end
	end

	if not hittedSlot then
		return false
	end

	self._hittedSlot = hittedSlot
	self._touchBeginPosition = pt
	self._hittedCard = hittedSlot:getCard()
	self._moving = false

	if self._listener and self._hittedCard:getType() == "hero" then
		-- block empty
	else
		-- block empty
	end

	if self._listener and self._listener._mainMediator then
		self._listener._mainMediator:setGuideLayerVisible(false)
	end

	return true
end

function CardArrayWidget:onTouchMoved(touch, event)
	local hittedCard = self._hittedCard

	if hittedCard == nil then
		return
	end

	local cardNode = hittedCard:getView()
	local pt = touch:getLocation()
	local moved = cc.pSub(pt, self._touchBeginPosition)

	if cc.pGetLength(moved) > 10 and self._listener then
		self._listener:hideSkillTip()
	end

	if not self._touchEnabled then
		return true
	end

	if self._moving then
		if self._hittedCard:getType() == "hero" then
			local newPos = cc.pAdd(self._originCardPosition, moved)

			cardNode:setPosition(newPos)

			if self._listener then
				self._listener:dragMoved(self, self._hittedCard, pt)
			end
		elseif self._hittedCard:getType() == "skill" then
			moved.x = moved.x / cardNode:getParent():getParent():getScale()
			moved.y = moved.y / cardNode:getParent():getParent():getScale()

			local newPos = cc.pAdd(self._originCardPosition, moved)

			cardNode:setPosition(newPos)

			if self._hittedSlot:getSlotType() == KSlotType.EXTRA then
				if not cardNode.isSimpleShow then
					self._hittedCard:simpleShow(true)
				end

				if self._listener then
					self._listener:dragExtraSkillMoved(self, self._hittedCard, pt)
				end
			end
		end
	elseif cc.pGetLength(moved) > 10 and hittedCard:isEnergyEnough() and not hittedCard:isLock() then
		if self._activeCard then
			self:resetActiveCard()
		end

		self._moving = true
		self._originCardPosition = cc.p(cardNode:getPosition())

		cardNode:getParent():setLocalZOrder(99)

		if self._listener and self._hittedCard:getType() == "hero" then
			self._listener:dragBegan(self, self._hittedCard)
		elseif self._hittedCard:getType() == "skill" and self._hittedSlot:getSlotType() == KSlotType.EXTRA then
			self._listener:dragExtraSkillBegan(self, self._hittedCard)
		end
	end

	if self._listener and self._listener._mainMediator then
		self._listener._mainMediator:setGuideLayerVisible(false)
	end
end

function CardArrayWidget:onTouchEnded(touch, event)
	if self._listener then
		self._listener:hideSkillTip()
	end

	if not self._touchEnabled then
		self._hittedCard = nil

		return true
	end

	if self._hittedCard == nil then
		return
	end

	local pt = touch:getLocation()

	if self._moving then
		local hittedCard = self._hittedCard
		local cardNode = hittedCard:getView()

		if not tolua.isnull(cardNode) then
			cardNode:getParent():setLocalZOrder(1)
		end

		if self._listener and hittedCard:getType() == "hero" then
			self._listener:dragEnded(self, hittedCard, pt)
		elseif self._listener and hittedCard:getType() == "skill" then
			if self._hittedSlot:getSlotType() == KSlotType.EXTRA then
				if self._listener then
					self._listener:dragExtraSkillEnded(self, self._hittedCard, pt)
				end
			else
				self._listener:applySkillCard(self, hittedCard, pt)
			end
		end
	else
		local hittedSlot

		for i, slot in ipairs(self._cardSlots) do
			if slot:hitTest(pt) then
				hittedSlot = slot

				break
			end
		end

		if hittedSlot and self._hittedCard == hittedSlot:getCard() and (self._hittedCard:getType() == "hero" or self._hittedCard:getType() == "skill") then
			if self._hittedCard == self._activeCard then
				self:resetActiveCard()
			else
				self:setActiveCard(self._hittedCard)
			end
		end
	end

	self._hittedCard = nil
	self._hittedSlot = nil

	if self._listener and self._listener._mainMediator then
		self._listener._mainMediator:setGuideLayerVisible(true)
	end
end

function CardArrayWidget:forceTouchEnded()
	if self._listener then
		self._listener:hideSkillTip()
	end

	if not self._touchEnabled then
		self._hittedCard = nil

		return true
	end

	if self._hittedCard == nil then
		return
	end

	if self._moving then
		local hittedCard = self._hittedCard
		local cardNode = hittedCard:getView()

		cardNode:getParent():setLocalZOrder(1)

		if self._listener and hittedCard:getType() == "hero" then
			self._listener:dragEnded(self, hittedCard, cc.p(-10000, -10000))
		elseif self._listener and hittedCard:getType() == "skill" then
			self._listener:applySkillCard(self, hittedCard, cc.p(-10000, -10000))
		end
	else
		self:resetActiveCard()
	end

	self._hittedCard = nil
	self._hittedSlot = nil
end

function CardArrayWidget:setActiveCard(hittedCard)
	if self._activeCard then
		self:resetActiveCard()
	end

	hittedCard:enterActiveState()

	self._activeCard = hittedCard

	local cardNode = hittedCard:getView()

	self._originCardPosition = cc.p(cardNode:getParent():getPosition())

	cardNode:getParent():setLocalZOrder(99)

	if self._listener and (hittedCard:getType() == "hero" or hittedCard:getType() == "skill") then
		self._listener:startPut(self, self._activeCard)
	end
end

function CardArrayWidget:resetActiveCard()
	if self._activeCard ~= nil then
		if self._activeCard:getType() == "skill" then
			self._listener:hideSkillCardTip()
		end

		self._activeCard:restoreNormalState(self._originCardPosition)

		self._activeCard = nil

		if self._listener then
			self._listener:cancelPut()
		end
	end
end

function CardArrayWidget:clearActiveCard()
	self._activeCard = nil
end

function CardArrayWidget:clearHittedCard()
	self._hittedCard = nil
end

function CardArrayWidget:visitCards(visitor)
	if not visitor then
		return
	end

	for i = 1, 4 do
		local slot = self._cardSlots[i]
		local card = slot and slot:getCard()

		if card then
			visitor(slot, card, i)
		end
	end
end

function CardArrayWidget:resetHittedCard()
	if self._hittedCard then
		self._hittedCard:getView():setVisible(true)
		self._hittedCard:setStatus("norm")
		self._hittedCard:restoreNormalState(cc.p(0, 0))

		self._hittedCard = nil

		return true
	end

	return false
end

function CardArrayWidget:guideTouchBegan(hittedCard, pt)
	if not hittedCard then
		return
	end

	self._touchBeginPosition = pt
	self._hittedCard = hittedCard
	self._moving = false

	if self._listener and self._hittedCard:getType() == "hero" then
		-- block empty
	else
		-- block empty
	end

	AudioEngine:getInstance():playEffect("Se_Click_Pickup", false)

	return true
end

function CardArrayWidget:guideTouchMoved(pt)
	local hittedCard = self._hittedCard

	if hittedCard == nil then
		return
	end

	local cardNode = hittedCard:getView()
	local moved = cc.pSub(pt, self._touchBeginPosition)

	if cc.pGetLength(moved) > 10 and self._listener then
		self._listener:hideSkillTip()
	end

	if self._moving then
		local newPos = cc.pAdd(self._originCardPosition, moved)

		cardNode:setPosition(newPos)

		if self._listener then
			self._listener:dragMoved(self, self._hittedCard, pt)
		end
	elseif cc.pGetLength(moved) > 10 then
		if self._activeCard then
			self:resetActiveCard()
		end

		self._moving = true
		self._originCardPosition = cc.p(cardNode:getPosition())

		cardNode:getParent():setLocalZOrder(99)

		if self._listener then
			self._listener:dragBegan(self, self._hittedCard)
		end
	end
end

function CardArrayWidget:guideTouchEnded(pt, pushSta)
	if self._listener then
		self._listener:hideSkillTip()
	end

	if self._moving and self._hittedCard then
		local hittedCard = self._hittedCard
		local cardNode = hittedCard:getView()

		cardNode:getParent():setLocalZOrder(1)

		if self._listener then
			if pushSta then
				self._listener:dragEnded(self, hittedCard, pt)
			else
				pt.x = 0
				pt.y = 0

				self._listener:dragEnded(self, hittedCard, pt)
			end
		end
	end

	self:clearHittedCard()
end

function CardArrayWidget:setGray(sta)
	for k, v in pairs(self._cardSlots) do
		local containerNode = v:getContainerNode()

		containerNode:setGray(sta)
	end
end
