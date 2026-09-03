-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleGuideWidget.lua

BattleGuideWidget = class("BattleGuideWidget", BaseWidget)

local autoTriggerClickTask

function BattleGuideWidget:initialize(view, args, callback)
	super.initialize(self, view)

	self._callback = callback
	self._data = args
end

function BattleGuideWidget:dispose()
	if autoTriggerClickTask then
		cancelDelayCall(autoTriggerClickTask)

		autoTriggerClickTask = nil
	end

	self:getView():removeFromParent(true)
	super.dispose(self)
end

function BattleGuideWidget:setupView(data)
	local targetNode = data.targetNode
	local targetNextNode = data.targetNextNode
	local clickListener = data.clickListener
	local targetSize = targetNode:getContentSize()
	local targetNodeAP = targetNode:getAnchorPoint()

	if not data.offset then
		local offset = cc.p(0, 0)
		local arrowOffset = data.arrowOffset
		local duration = data.duration
		local pt = cc.p(targetNode:getPositionX() + offset.x, targetNode:getPositionY() + offset.y)
		local centerPt = cc.p(pt.x + targetSize.width * (0.5 - targetNodeAP.x), pt.y + targetSize.height * (0.5 - targetNodeAP.y))
		local targetPt = targetNode:getParent():convertToWorldSpace(centerPt)
		local winSize = cc.Director:getInstance():getVisibleSize()
		local renderNode = cc.Node:create()

		renderNode:setContentSize(winSize)

		local touchLayer = ccui.Layout:create()

		touchLayer:setAnchorPoint(cc.p(0.5, 0.5))
		touchLayer:addTo(renderNode, 3):center(renderNode:getContentSize())
		touchLayer:setContentSize(cc.size(winSize.width, winSize.height))
		touchLayer:setTouchEnabled(true)
		touchLayer:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				self:onClickMaskLayer()
				self:showMsg("NewPlayerGuide_Tips")
			end
		end)

		local maskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 0))

		maskLayer:setContentSize(cc.size(winSize.width, winSize.height))
		maskLayer:addTo(renderNode, 2)

		local msSprite = cc.MaskSprite:create("asset/story/guidequanmask.png")

		msSprite:setScale(data.maskNodeScale or 0.8)

		local maskBeginNode = cc.MaskBeginNode:create(msSprite)

		maskBeginNode:setInverted(true)
		maskBeginNode:addTo(renderNode, 1)
		maskBeginNode:getEndNode():addTo(renderNode, 3)
		maskBeginNode:setIsEnabled(true)
		maskBeginNode:setVisible(true)
		msSprite:setPosition(targetPt)

		self.guideView = nil
		self.guideNextView = nil

		local guideWidget

		if data.style == "drag_auto" then
			local beganPos = cc.p(targetPt.x + arrowOffset.x, targetPt.y + arrowOffset.y)
			local targetNextSize = targetNextNode:getContentSize()
			local targetNextNodeAP = targetNextNode:getAnchorPoint()

			if not data.nextOffset then
				local nextOffset = cc.p(0, 0)
				local nextPt = cc.p(targetNextNode:getPositionX() + nextOffset.x, targetNextNode:getPositionY() + nextOffset.y)
				local centerNextPt = cc.p(nextPt.x + targetNextSize.width * (0.5 - targetNextNodeAP.x), nextPt.y + targetNextSize.height * (0.5 - targetNextNodeAP.y))
				local targetNextPt = targetNextNode:getParent():convertToWorldSpace(centerNextPt)

				guideWidget = GuideDrag:new({
					beginPos = beganPos,
					endPos = targetNextPt
				})
			end
		else
			guideWidget = GuideWidget:new({
				circleScale = data.circleScale,
				style = data.style
			})

			guideWidget:updateArrow(data.arrowPos)
		end

		local guideView = guideWidget:getView()

		self.guideView = guideView

		local clickPanel = guideView:getChildByName("click_panel")

		guideView:addTo(renderNode, 1000)

		local arrowScale = data.arrowScale
		local rotation = data.rotation

		guideView:setPosition(cc.p(targetPt.x + arrowOffset.x, targetPt.y + arrowOffset.y))
		guideView:setRotation(rotation)
		guideView:setScaleX(arrowScale.x)
		guideView:setScaleY(arrowScale.y)

		local panelWidth, panelHeight = targetNode:getContentSize().width, targetNode:getContentSize().height

		if panelWidth ~= 0 and panelHeight ~= 0 then
			clickPanel:setContentSize(targetNode:getContentSize())
		end

		clickPanel:setTouchEnabled(true)
		clickPanel:addTouchEventListener(function(sender, eventType)
			if autoTriggerClickTask then
				cancelDelayCall(autoTriggerClickTask)

				autoTriggerClickTask = nil
			end

			if eventType == ccui.TouchEventType.began then
				self:hideGuideWidget()
				self:showNextGuideWidget()
			elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
				self:hideNextGuideWidget()
				self:showGuideWidget()
			end

			clickListener(sender, eventType, function(isCancel)
				if isCancel then
					if duration and duration > 0 then
						autoTriggerClickTask = delayCallByTime(duration * 1000, function()
							clickListener(clickPanel, ccui.TouchEventType.ended, function()
								self:dispose()
							end, true)
						end)
					end

					self:showMsg("NewPlayerGuide_Tips")
				else
					self:dispose()
				end
			end)
		end)

		if targetNextNode then
			local targetNextSize = targetNextNode:getContentSize()
			local targetNextNodeAP = targetNextNode:getAnchorPoint()

			if not data.nextOffset then
				local nextOffset = cc.p(0, 0)
				local nextPt = cc.p(targetNextNode:getPositionX() + nextOffset.x, targetNextNode:getPositionY() + nextOffset.y)
				local centerNextPt = cc.p(nextPt.x + targetNextSize.width * (0.5 - targetNextNodeAP.x), nextPt.y + targetNextSize.height * (0.5 - targetNextNodeAP.y))
				local targetNextPt = targetNextNode:getParent():convertToWorldSpace(centerNextPt)
				local var_3_4 = {}

				var_3_4.arrowPos = data.arrowNextPos or 6
				var_3_4.style = data.nextStyle
				var_3_4.circleScale = data.circleScale

				local guideNextWidget = GuideWidget:new(var_3_4)
				local guideNextView = guideNextWidget:getView()

				self.guideNextView = guideNextView

				guideNextView:addTo(renderNode, 1001)
				guideNextView:setPosition(cc.p(targetNextPt.x, targetNextPt.y))
			end
		end

		if duration and duration > 0 then
			autoTriggerClickTask = delayCallByTime(duration * 1000, function()
				clickListener(clickPanel, ccui.TouchEventType.ended, function()
					self:dispose()
				end, true)
			end)
		end

		if data.text and data.text ~= "" then
			if not data.textRefpt then
				local guideText = GuideText:new(data)
				local guideTextView = guideText:getView()

				guideTextView:addTo(renderNode, 1000)
			end
		end

		renderNode:addTo(self:getView())

		self._maskLayer = maskLayer
		self._opacity = 0

		self:hideNextGuideWidget()
		self:showGuideWidget()
	end
end

function BattleGuideWidget:showMsg(msgId)
	local dispatcher = DmGame:getInstance()

	dispatcher:dispatch(ShowTipEvent({
		once = true,
		tip = Strings:get(msgId)
	}))
end

function BattleGuideWidget:onClickMaskLayer(sender, touchType)
	self:runStageAction()
end

function BattleGuideWidget:runStageAction()
	local function resetData()
		self._stageOneRunning = false
		self._stageTwoRunning = false
		self._stageThreeRunning = false
	end

	local fadeTo = cc.FadeTo:create(0.5, 127.5)
	local stageOneCall = cc.CallFunc:create(function()
		self._stageOneRunning = false
		self._stageTwoRunning = true
		self._stageThreeRunning = false
	end)
	local timeDelay = cc.DelayTime:create(1)
	local stageTwoCall = cc.CallFunc:create(function()
		self._stageOneRunning = false
		self._stageTwoRunning = false
		self._stageThreeRunning = true
	end)
	local fadeBack = cc.FadeTo:create(0.5, self._opacity)
	local callback = cc.CallFunc:create(function()
		self._maskLayer:setOpacity(self._opacity)
		resetData()
	end)
	local sequence = cc.Sequence:create(fadeTo, stageOneCall, timeDelay, stageTwoCall, fadeBack, callback)

	if self._stageOneRunning == true then
		return
	elseif self._stageTwoRunning == true then
		self._maskLayer:stopAllActions()

		local sequence = cc.Sequence:create(stageOneCall, timeDelay, stageTwoCall, fadeBack, callback)

		self._maskLayer:runAction(sequence)

		return
	elseif self._stageThreeRunning == true then
		local opacity = self._maskLayer:getOpacity()
		local fadeToTime = (opacity - self._opacity) / (127.5 - self._opacity) * 0.5
		local fadeTo = cc.FadeTo:create(fadeToTime, 127.5)

		sequence = cc.Sequence:create(fadeTo, stageOneCall, timeDelay, stageTwoCall, fadeBack, callback)
	end

	self._maskLayer:runAction(sequence)

	self._stageOneRunning = true
	self._stageTwoRunning = false
	self._stageThreeRunning = false
end

function BattleGuideWidget:hideGuideWidget()
	if self.guideNextView and self.guideView then
		self.guideView:setVisible(false)
	end
end

function BattleGuideWidget:showGuideWidget()
	if self.guideNextView and self.guideView then
		self.guideView:setVisible(true)
	end
end

function BattleGuideWidget:hideNextGuideWidget()
	if self.guideNextView and self.guideNextView then
		self.guideNextView:setVisible(false)
	end
end

function BattleGuideWidget:showNextGuideWidget()
	if self.guideNextView and self.guideNextView then
		self.guideNextView:setVisible(true)
	end
end
