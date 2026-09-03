-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/GuideActions.lua

module("story", package.seeall)

GuideClick = class("GuideClick", BaseAction)

function GuideClick:start(args)
	local context = self.context
	local scene = context:getScene()
	local actor = scene:getChildById("click")

	if actor == nil then
		return BehaviorResult.Success
	end

	local director = context:getDirector()
	local env = director:getClickEnv(args.id)
	local targetNode = env and env.targetNode

	if targetNode == nil then
		return BehaviorResult.Success
	end

	local onClick = env.onClick
	local maskNode = scene:getChildById("guideMask")
	local guiderNode = scene:getChildById("guider")
	local guideText = scene:getChildById("guideText")
	local guideSkipBtn = scene:getChildById("guideSkipButton")
	local autoTriggerClickTask

	local function onEnd()
		actor:hide()

		if maskNode then
			maskNode:hide()
		end

		if guiderNode then
			guiderNode:hide()
		end

		if guideText then
			guideText:hide()
		end

		if guideSkipBtn then
			guideSkipBtn:hide()
		end

		if autoTriggerClickTask then
			cancelDelayCall(autoTriggerClickTask)
		end

		self:finish(BehaviorResult.Success)

		if args.statisticPoint then
			local content = {
				type = "loginpoint",
				point = args.statisticPoint
			}

			StatisticSystem:send(content)
		end
	end

	local function clickListener(sender, eventType)
		if args.wait == nil then
			onEnd()
		end

		if onClick then
			onClick(sender, ccui.TouchEventType.ended)
		end
	end

	if args.duration then
		autoTriggerClickTask = delayCallByTime(args.duration * 1000, function()
			clickListener(targetNode, ccui.TouchEventType.ended)
		end)
	end

	local targetSize = targetNode:getContentSize()
	local targetNodeAP = targetNode:getAnchorPoint()

	if not args.offset then
		local offset = cc.p(0, 0)
		local pt = cc.p(targetNode:getPositionX() + offset.x, targetNode:getPositionY() + offset.y)
		local centerPt = cc.p(pt.x + targetSize.width * (0.5 - targetNodeAP.x), pt.y + targetSize.height * (0.5 - targetNodeAP.y))
		local targetPt = targetNode:getParent():convertToWorldSpace(centerPt)

		if maskNode and args.mask then
			local var_1_1 = {
				showGuideBtn = true,
				hasAction = true,
				holePos = targetPt,
				style = args.mask.style,
				maskData = args.mask.config,
				offset = args.mask.offset
			}

			var_1_1.callback = args.mask.callback and onEnd

			local guideConfig = var_1_1

			maskNode:mask(args.mask.touchMask, args.mask.opacity, guideConfig)
		end

		if args.wait then
			local callback = function(self, event)
				cclog("callback:" .. event:getType())

				if event:getType() == args.wait then
					director:removeEventListener(args.wait, self, callback)
					onEnd()
				end
			end

			director:addEventListener(args.wait, self, callback)

			function self._removeWaitListener()
				director:removeEventListener(args.wait, self, callback)
			end
		end

		local clickData = {}

		clickData.style = args.style
		clickData.arrowPos = args.arrowPos
		clickData.targetPt = targetPt
		clickData.clickSize = args.clickSize
		clickData.clickOffset = args.clickOffset
		clickData.text = args.text
		clickData.hasHand = args.hasHand

		if guiderNode and args.say then
			guiderNode:say(args.say.guider, args.say.content, args.say.name, args.guideAudio, function()
				actor:click(clickData, clickListener)
			end)
			guiderNode:setVolatileProps(args.say)
		else
			actor:click(clickData, clickListener)
		end

		if guideText and args.textArgs then
			guideText:show(args.textArgs)
		end

		if args.guideAudio then
			local curAudio = context:getVar("guideAudio")

			if curAudio then
				AudioEngine:getInstance():stopEffect(curAudio)
			end

			local guideAudioId = AudioEngine:getInstance():playEffect(args.guideAudio, false)

			context:setVar("guideAudio", guideAudioId)
		end
	end
end

function GuideClick:abort(result)
	if self._removeWaitListener then
		self._removeWaitListener()

		self._removeWaitListener = nil
	end

	super.abort(self, result)
end

function sandbox.click(config)
	return GuideClick:new():setArgs(config.args)
end

GuideShow = class("GuideShow", BaseAction)

function GuideShow:start(args)
	local context = self.context
	local scene = context:getScene()
	local actor = scene:getChildById("showNode")

	if actor == nil then
		return BehaviorResult.Success
	end

	local guideText = scene:getChildById("guideText")
	local autoTriggerClickTask

	local function onEnd()
		actor:hide()

		if guideText then
			guideText:hide()
		end

		if args.statisticPoint then
			local content = {
				type = "loginpoint",
				point = args.statisticPoint
			}

			StatisticSystem:send(content)
		end

		if self._autoTriggerClickTask then
			cancelDelayCall(self._autoTriggerClickTask)

			self._autoTriggerClickTask = nil
		end

		self:finish(BehaviorResult.Success)
	end

	if args.duration then
		self._autoTriggerClickTask = delayCallByTime(args.duration * 1000, function()
			onEnd()
		end)
	end

	local function clickListener(sender, eventType)
		onEnd()
	end

	if args.id and args.id ~= "" then
		local director = context:getDirector()
		local env = director:getClickEnv(args.id)
		local targetNode = env and env.targetNode

		if targetNode then
			local targetSize = targetNode:getContentSize()
			local targetNodeAP = targetNode:getAnchorPoint()

			if not args.offset then
				local offset = cc.p(0, 0)
				local pt = cc.p(targetNode:getPositionX() + offset.x, targetNode:getPositionY() + offset.y)
				local centerPt = cc.p(pt.x + targetSize.width * (0.5 - targetNodeAP.x), pt.y + targetSize.height * (0.5 - targetNodeAP.y))

				args.targetPt = targetNode:getParent():convertToWorldSpace(centerPt)
				args.targetNode = targetNode
			end
		end
	end

	actor:show(args, clickListener)

	if guideText and args.textArgs then
		guideText:show(args.textArgs)
	end

	if args.guideAudio then
		local curAudio = context:getVar("guideAudio")

		if curAudio then
			AudioEngine:getInstance():stopEffect(curAudio)
		end

		local guideAudioId = AudioEngine:getInstance():playEffect(args.guideAudio, false)

		context:setVar("guideAudio", guideAudioId)
	end
end

function GuideShow:abort(result)
	if self._autoTriggerClickTask then
		cancelDelayCall(self._autoTriggerClickTask)

		self._autoTriggerClickTask = nil
	end

	if self._removeWaitListener then
		self._removeWaitListener()

		self._removeWaitListener = nil
	end

	super.abort(self, result)
end

function sandbox.guideShow(config)
	return GuideShow:new():setArgs(config.args)
end

DragGuide = class("DragGuide", BaseAction)

function DragGuide:start(args)
	local context = self.context
	local scene = context:getScene()
	local actor = scene:getChildById("click")

	if actor == nil then
		return BehaviorResult.Success
	end

	local director = context:getDirector()
	local dragData = args.drag
	local env1 = director:getClickEnv(dragData.id1)
	local targetNode1 = env1 and env1.targetNode

	if targetNode1 == nil then
		return BehaviorResult.Success
	end

	local env2 = director:getClickEnv(dragData.id2)
	local targetNode2 = env2 and env2.targetNode

	if targetNode2 == nil then
		return BehaviorResult.Success
	end

	local onClick = env1.onClick
	local maskNode = scene:getChildById("guideMask")
	local guiderNode = scene:getChildById("guider")
	local guideText = scene:getChildById("guideText")
	local guideSkipBtn = scene:getChildById("guideSkipButton")
	local guideDragLine = scene:getChildById("guideDragLine")
	local __tmp_getTouchBeganPosition = targetNode1.getTouchBeganPosition
	local __tmp_getTouchMovePosition = targetNode1.getTouchMovePosition
	local __tmp_getTouchEndPosition = targetNode1.getTouchEndPosition
	local __tmp_getLocation = targetNode1.getLocation
	local __tmp_getStartLocation = targetNode1.getStartLocation

	function targetNode1.getTouchBeganPosition()
		return guideDragLine._touchLayer:getTouchBeganPosition()
	end

	function targetNode1.getTouchMovePosition()
		return guideDragLine._touchLayer:getTouchMovePosition()
	end

	function targetNode1.getTouchEndPosition()
		return guideDragLine._touchLayer:getTouchEndPosition()
	end

	guideDragLine._touchLayer._lastLocation = cc.p(0, 0)

	function targetNode1.getLocation()
		return guideDragLine._touchLayer._lastLocation
	end

	function targetNode1.getStartLocation()
		return guideDragLine._touchLayer:getTouchBeganPosition()
	end

	local autoTriggerClickTask

	local function onEnd()
		actor:hide()

		if maskNode then
			maskNode:hide()
		end

		if guiderNode then
			guiderNode:hide()
		end

		if guideText then
			guideText:hide()
		end

		if guideSkipBtn then
			guideSkipBtn:hide()
		end

		if guideDragLine then
			guideDragLine:hide()
		end

		if autoTriggerClickTask then
			cancelDelayCall(autoTriggerClickTask)
		end

		targetNode1.getTouchBeganPosition = __tmp_getTouchBeganPosition
		targetNode1.getTouchMovePosition = __tmp_getTouchMovePosition
		targetNode1.getTouchEndPosition = __tmp_getTouchEndPosition
		targetNode1.getLocation = __tmp_getLocation
		targetNode1.getStartLocation = __tmp_getStartLocation

		self:finish(BehaviorResult.Success)

		if args.statisticPoint then
			StatisticSystem:send({
				type = "loginpoint",
				point = args.statisticPoint
			})
		end
	end

	local function hitTest(node, point)
		local localPoint = point
		local size = node:getContentSize()
		local ap = node:getAnchorPoint()
		local wpos = node:getParent():convertToWorldSpace(cc.p(node:getPositionX(), node:getPositionY()))

		wpos = cc.p(wpos.x - size.width * ap.x, wpos.y - size.height * ap.y)

		local rect = cc.rect(wpos.x, wpos.y, size.width, size.height)

		print("localPoint", localPoint.x, localPoint.y)
		print("wpos", wpos.x, wpos.y)

		if cc.rectContainsPoint(rect, localPoint) then
			return true
		end

		return false
	end

	local isMoveState = false

	local function touchListener(sender, eventType)
		local pos

		if eventType == ccui.TouchEventType.began then
			pos = sender:getTouchBeganPosition()
			guideDragLine._touchLayer._lastLocation = cc.p(pos.x, pos.y)

			if hitTest(targetNode1, pos) then
				onClick(targetNode1, eventType)

				isMoveState = true
			else
				local dispatcher = DmGame:getInstance()

				dispatcher:dispatch(ShowTipEvent({
					once = true,
					tip = Strings:get("NewPlayerGuide_Tips")
				}))
			end
		elseif eventType == ccui.TouchEventType.moved then
			pos = sender:getTouchMovePosition()
			guideDragLine._touchLayer._lastLocation = cc.p(pos.x, pos.y)

			if isMoveState then
				onClick(targetNode1, eventType)
			end
		elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
			pos = sender:getTouchEndPosition()
			guideDragLine._touchLayer._lastLocation = cc.p(pos.x, pos.y)

			if isMoveState then
				local isSuccess = onClick(targetNode1, eventType)

				if isSuccess == false then
					local dispatcher = DmGame:getInstance()

					dispatcher:dispatch(ShowTipEvent({
						once = true,
						tip = Strings:get("NewPlayerGuide_Tips")
					}))
				end
			end

			isMoveState = false
		end
	end

	local targetSize = targetNode1:getContentSize()
	local targetNodeAP = targetNode1:getAnchorPoint()

	if not dragData.offset then
		local offset = cc.p(0, 0)
		local pt = cc.p(targetNode1:getPositionX() + offset.x, targetNode1:getPositionY() + offset.y)
		local centerPt = cc.p(pt.x + targetSize.width * (0.5 - targetNodeAP.x), pt.y + targetSize.height * (0.5 - targetNodeAP.y))
		local targetPt = targetNode1:getParent():convertToWorldSpace(centerPt)
		local targetNextSize = targetNode2:getContentSize()
		local targetNextNodeAP = targetNode2:getAnchorPoint()

		if not dragData.nextOffset then
			local nextOffset = cc.p(0, 0)
			local nextPt = cc.p(targetNode2:getPositionX() + nextOffset.x, targetNode2:getPositionY() + nextOffset.y)
			local centerNextPt = cc.p(nextPt.x + targetNextSize.width * (0.5 - targetNextNodeAP.x), nextPt.y + targetNextSize.height * (0.5 - targetNextNodeAP.y))
			local targetNextPt = targetNode2:getParent():convertToWorldSpace(centerNextPt)

			if not dragData.arrowOffset then
				local arrowOffset = cc.p(0, 0)

				if not dragData.rotation then
					local rotation = 0
					local beganPos = cc.p(targetPt.x + arrowOffset.x, targetPt.y + arrowOffset.y)

					guideDragLine:show({
						autoRotation = true,
						beginPos = beganPos,
						endPos = targetNextPt,
						arrowOffset = arrowOffset,
						rotation = rotation,
						listener = touchListener
					})

					if args.wait then
						local callback = function(self, event)
							cclog("callback:" .. event:getType())

							if event:getType() == args.wait then
								director:removeEventListener(args.wait, self, callback)
								onEnd()
							end
						end

						director:addEventListener(args.wait, self, callback)

						function self._removeWaitListener()
							director:removeEventListener(args.wait, self, callback)
						end
					end

					if guideText and args.textArgs then
						guideText:show(args.textArgs)
					end

					if args.guideAudio then
						local curAudio = context:getVar("guideAudio")

						if curAudio then
							AudioEngine:getInstance():stopEffect(curAudio)
						end

						local guideAudioId = AudioEngine:getInstance():playEffect(args.guideAudio, false)

						context:setVar("guideAudio", guideAudioId)
					end
				end
			end
		end
	end
end

function DragGuide:abort(result)
	if self._removeWaitListener then
		self._removeWaitListener()

		self._removeWaitListener = nil
	end

	super.abort(self, result)
end

function sandbox.dragGuide(config)
	return DragGuide:new():setArgs(config.args)
end

GuiderSay = class("GuiderSay", BaseAction)

function GuiderSay:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	actor:say(args.guider, args.content, args.name, args.guideAudio)
	actor:setVolatileProps(args)

	if args.audio then
		local curAudio = context:getVar("guideAudio")

		if curAudio then
			AudioEngine:getInstance():stopEffect(curAudio)
		end

		dump(args.audio, "args.guideAudio__")

		local guideAudioId = AudioEngine:getInstance():playEffect(args.audio, false)

		context:setVar("guideAudio", guideAudioId)
	end

	return BehaviorResult.Success
end

GuiderHide = class("GuiderHide", BaseAction)

function GuiderHide:start(args)
	cclog("GuiderHide_wnt_____")

	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	actor:hide()

	return BehaviorResult.Success
end

GuidePopViewPlay = class("GuidePopViewPlay", BaseAction)

function GuidePopViewPlay:start(args)
	cclog("GuidePopViewPlay")

	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	local function callback()
		local eventDispatcher = self.context:getEventDispatcher()

		self:finish(BehaviorResult.Success)
		eventDispatcher:dispatchEvent(ViewEvent:new(EVT_POP_VIEW, nil, nil, nil))
	end

	actor:play(callback)
end

GuideEnterBattleAnimPlay = class("GuideEnterBattleAnimPlay", BaseAction)

function GuideEnterBattleAnimPlay:start(args)
	cclog("GuideEnterBattleAnimPlay")

	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	local function callback()
		self.context:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_PUSH_VIEW, self.context:getInjector():getInstance("CommonStageChapterView"), {}, {
			stageType = "NORMAL",
			chapterIndex = 1
		}))
		self:finish(BehaviorResult.Success)
	end

	actor:play(callback)
end

GuideTextHide = class("GuideTextHide", BaseAction)

function GuideTextHide:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	actor:hide()

	return BehaviorResult.Success
end

GuideTextShow = class("GuideTextShow", BaseAction)

function GuideTextShow:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	actor:show(args)

	return BehaviorResult.Success
end

GuideDragLineNodeHide = class("GuideDragLineNodeHide", BaseAction)

function GuideDragLineNodeHide:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	actor:hide()

	return BehaviorResult.Success
end

GuideDragLineNodeShow = class("GuideDragLineNodeShow", BaseAction)

function GuideDragLineNodeShow:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	actor:show(args)

	return BehaviorResult.Success
end
