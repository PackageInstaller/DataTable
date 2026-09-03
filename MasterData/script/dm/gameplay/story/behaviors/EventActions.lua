-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/EventActions.lua

module("story", package.seeall)

AddEventListener = class("AddEventListener", BaseAction)

function AddEventListener:initialize()
	super.initialize(self)
end

function AddEventListener:start(args)
	if args.type == nil or args.listener == nil then
		return BehaviorResult.Success
	end

	local blocked = args.blocked
	local oneshot = args.oneshot
	local actionName = args.listener
	local target = args.target
	local context = self.context
	local director = context:getDirector()

	function onEnd()
		if oneshot then
			director:removeEventListenerById(args.id)
		end

		if blocked then
			self:finish(BehaviorResult.Success)
		end
	end

	local function listener(event)
		if event:getType() == args.type then
			if target and actionName then
				local actionDef = target:getActionDefinition(actionName)

				if actionDef == nil then
					return nil
				end

				local action

				if type(actionDef) == "function" then
					action = actionDef(target, {
						event = event
					})
				end

				if action then
					action:run(context, onEnd)

					return
				end
			end

			onEnd()
		end
	end

	self._id = args.id

	director:addEventListener(args.type, nil, listener)
	director:registerRemoveEvents(args.id, function()
		director:removeEventListener(args.type, nil, listener)
	end)

	if not blocked then
		return BehaviorResult.Success
	end
end

function AddEventListener:abort(result)
	if self._id then
		local context = self.context
		local director = context:getDirector()

		director:removeEventListenerById(self._id)
	end

	super.abort(self, result)
end

function sandbox.addEventListener(config)
	return AddEventListener:new():setArgs(config.args)
end

DispatchEvent = class("DispatchEvent", BaseAction)

function DispatchEvent:initialize()
	super.initialize(self)
end

function DispatchEvent:start(args)
	local context = self.context
	local director = context:getDirector()

	if args.type == nil then
		return BehaviorResult.Success
	end

	local event = Event:new(args.type, args.data)

	director:dispatch(event)
end

function sandbox.dispatchEvent(config)
	return DispatchEvent:new():setArgs(config.args)
end

RemoveEventListener = class("RemoveEventListener", BaseAction)

function RemoveEventListener:initialize()
	super.initialize(self)
end

function RemoveEventListener:start(args)
	local context = self.context
	local director = context:getDirector()

	if args.id == nil then
		return BehaviorResult.Success
	end

	director:removeEventListenerById(args.id)

	return BehaviorResult.Success
end

function sandbox.removeEventListener(config)
	return RemoveEventListener:new():setArgs(config.args)
end

Wait = class("Wait", BaseAction)

function Wait:initialize()
	super.initialize(self)
end

function Wait:start(args)
	dump(args, "Wait")

	local context = self.context
	local director = context:getDirector()

	if args.type == nil then
		return BehaviorResult.Success
	end

	self._type = args.type

	director:addEventListener(args.type, self, self.onNotified)

	local scene = context:getScene()
	local maskNode = scene:getChildById("guideMask")

	if maskNode and args.mask then
		maskNode:mask(args.mask.touchMask, args.mask.opacity)

		if args.mask.touchMask then
			self._waitDurationCallBack = delayCallByTime(args.waitTimt or 5000, function()
				maskNode:mask(true, 125)

				local skipBtn = scene:getChildById("guideSkipButton")

				skipBtn:show(args.type)

				local agent = context:getAgent()
				local guideName = agent:getCurrentScriptName()
				local content = {
					type = "loginpoint",
					point = guideName .. "_bug"
				}

				StatisticSystem:send(content)
			end)
		end
	end

	if args.duration then
		self._durationCallBack = delayCallByTime(args.duration * 1000, function()
			return self:finish(BehaviorResult.Success)
		end)
	end

	self._statisticPoint = args.statisticPoint
end

function Wait:onNotified(event)
	if event:getType() == self._type then
		local context = self.context

		if context then
			local director = context:getDirector()

			director:removeEventListener(self._type, self, self.onNotified)

			local scene = context:getScene()
			local maskNode = scene:getChildById("guideMask")

			if maskNode then
				maskNode:hide()
			end
		end

		if self._durationCallBack then
			cancelDelayCall(self._durationCallBack)

			self._durationCallBack = nil
		end

		if self._waitDurationCallBack then
			cancelDelayCall(self._waitDurationCallBack)

			self._waitDurationCallBack = nil
		end

		if self._statisticPoint and self._statisticPoint ~= "" then
			local content = {
				type = "loginpoint",
				point = self._statisticPoint
			}

			StatisticSystem:send(content)

			self._statisticPoint = nil
		end

		self:finish(BehaviorResult.Success)
	end
end

function Wait:abort(result)
	if self._type then
		local context = self.context
		local director = context:getDirector()

		director:removeEventListener(self._type, self, self.onNotified)
	end

	if self._durationCallBack then
		cancelDelayCall(self._durationCallBack)

		self._durationCallBack = nil
	end

	if self._waitDurationCallBack then
		cancelDelayCall(self._waitDurationCallBack)

		self._waitDurationCallBack = nil
	end

	super.abort(self, result)
end

function sandbox.wait(config)
	return Wait:new():setArgs(config.args)
end

SetValue = class("SetValue", BaseAction)

function SetValue:initialize()
	super.initialize(self)
end

function SetValue:start(args)
	local context = self.context

	context:setVar(args.name, args.value)

	return BehaviorResult.Success
end

function sandbox.setValue(config)
	return SetValue:new():setArgs(config.args)
end

SendStaticPoint = class("SendStaticPoint", BaseAction)

function SendStaticPoint:initialize()
	super.initialize(self)
end

function SendStaticPoint:start(args)
	local content = {
		type = "loginpoint",
		point = args.point
	}

	StatisticSystem:send(content)

	return BehaviorResult.Success
end

function sandbox.sendStaticPoint(config)
	return SendStaticPoint:new():setArgs(config.args)
end

CheckGuideView = class("CheckGuideView", BaseAction)

function CheckGuideView:initialize()
	super.initialize(self)
end

function CheckGuideView:start(args)
	local context = self.context

	if not args.viewName then
		local scene = context:getInjector():getInstance("BaseSceneMediator", "activeScene")
		local topViewName = scene:getTopViewName()
		local eventDispatcher = context:getEventDispatcher()

		if topViewName ~= args.viewName then
			eventDispatcher:dispatchEvent(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
		else
			local topView = scene:getTopView()
			local homeMediator = scene:getMediatorMap():retrieveMediator(topView)

			homeMediator:setupClickEnvs()
		end

		return BehaviorResult.Success
	end
end

function sandbox.checkGuideView(config)
	return CheckGuideView:new():setArgs(config.args)
end

PopToHomeView = class("PopToHomeView", BaseAction)

function PopToHomeView:initialize()
	super.initialize(self)
end

function PopToHomeView:start(args)
	local context = self.context

	if not args.viewName then
		local scene = context:getInjector():getInstance("BaseSceneMediator", "activeScene")
		local topViewName = scene:getTopViewName()
		local eventDispatcher = context:getEventDispatcher()

		if topViewName ~= args.viewName then
			eventDispatcher:dispatchEvent(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
		end

		return BehaviorResult.Success
	end
end

function sandbox.popToHomeView(config)
	return PopToHomeView:new():setArgs(config.args)
end

StoryRecordSave = class("StoryRecordSave", BaseAction)

function StoryRecordSave:initialize()
	super.initialize(self)
end

function StoryRecordSave:start(args)
	local scriptName = args.name
	local storyAgent = self.context:getAgent()

	storyAgent:save(scriptName)

	return BehaviorResult.Success
end

function sandbox.storyRecordSave(config)
	return StoryRecordSave:new():setArgs(config.args)
end
