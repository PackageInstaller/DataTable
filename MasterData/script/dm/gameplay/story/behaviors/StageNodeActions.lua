-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/StageNodeActions.lua

module("story", package.seeall)

ChangeTexture = class("ChangeTexture", BaseAction)

function ChangeTexture:initialize()
	super.initialize(self)
end

function ChangeTexture:start(args)
	local actor = self:getActor()

	if actor then
		local renderNode = actor:getRenderNode()

		if renderNode then
			local imagePath = CommonUtils.getPathByType(args.pathType, args.image)

			renderNode:loadTexture(imagePath, args.resType)
		end
	end

	return BehaviorResult.Success
end

playMovieClipNode = class("playMovieClipNode", BaseAction)

function playMovieClipNode:initialize()
	super.initialize(self)
end

function playMovieClipNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:play(args)
	end

	return BehaviorResult.Success
end

hideMovieClipNode = class("hideMovieClipNode", BaseAction)

function hideMovieClipNode:initialize()
	super.initialize(self)
end

function hideMovieClipNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

PortraitNodeScaleTo = class("PortraitNodeScaleTo", BaseAction)

function PortraitNodeScaleTo:initialize()
	super.initialize(self)
end

function PortraitNodeScaleTo:start(args)
	local actor = self:getActor()

	if actor and args.duration and args.scale then
		local renderNode = actor:getRenderNode()

		if renderNode then
			local action = cc.Sequence:create(cc.ScaleTo:create(args.duration, args.scale), cc.CallFunc:create(function()
				actor:setPortraitScale(args.scale)
				self:finish(BehaviorResult.Success)
			end), nil)

			renderNode:runAction(action)
		else
			return BehaviorResult.Success
		end
	else
		return BehaviorResult.Success
	end
end

PortraitNodeBrightnessTo = class("PortraitNodeBrightnessTo", BaseAction)

function PortraitNodeBrightnessTo:initialize()
	super.initialize(self)
end

function PortraitNodeBrightnessTo:start(args)
	local actor = self:getActor()

	if actor and args.duration and args.brightness then
		local renderNode = actor:getRenderNode()

		if renderNode then
			local action = cc.Sequence:create(BrightnessTo:create(args.duration, args.brightness), cc.CallFunc:create(function()
				actor:setBrightness(args.brightness)
				self:finish(BehaviorResult.Success)
			end), nil)

			renderNode:runAction(action)
		else
			return BehaviorResult.Success
		end
	else
		return BehaviorResult.Success
	end
end

PortraitNodeBlendFlashScreen = class("PortraitNodeBlendFlashScreen", BaseAction)

function PortraitNodeBlendFlashScreen:initialize()
	super.initialize(self)
end

function PortraitNodeBlendFlashScreen:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	if args.arr and #args.arr > 0 then
		actor:runBlendFlashScreen(args, function()
			self:finish(BehaviorResult.Success)
		end)
	else
		return BehaviorResult.Success
	end
end

AddNode = class("AddNode", BaseAction)

function AddNode:initialize()
	super.initialize(self)
end

function AddNode:start(args)
	local parent = self:getActor()

	if parent then
		local node = StageNodeFactory:createNodeWithConfig(args)

		parent:addChild(node, args.zorder)
		node:refreshLayout()
	end

	return BehaviorResult.Success
end

UpdateNode = class("UpdateNode", BaseAction)

function UpdateNode:initialize()
	super.initialize(self)
end

function UpdateNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:setVolatileProps(args)
	end

	return BehaviorResult.Success
end

ActivateNode = class("ActivateNode", BaseAction)

function ActivateNode:initialize()
	super.initialize(self)
end

function ActivateNode:start(args)
	local actor = self:getActor()

	return BehaviorResult.Success
end

RockScreen = class("RockScreen", BaseAction)

function RockScreen:initialize()
	super.initialize(self)
end

function RockScreen:start(args)
	local context = self.context
	local scene = context:getScene()
	local renderNode = scene:getRenderNode()

	if renderNode == nil then
		return BehaviorResult.Success
	end

	if self._runningAction then
		renderNode:stopAction(self._runningAction)

		self._runningAction = nil
	end

	local rockAction = RockAction:create(args.freq, args.strength)

	self._runningAction = cc.Sequence:create(rockAction, cc.CallFunc:create(function()
		self:finish(BehaviorResult.Success)

		self._runningAction = nil
	end))

	renderNode:runAction(self._runningAction)
end

function RockScreen:abort(result)
	if self._runningAction then
		local context = self.context
		local scene = context:getScene()
		local renderNode = scene:getRenderNode()

		renderNode:stopAction(self._runningAction)

		self._runningAction = nil
	end

	super.abort(self, result)
end

function sandbox.rockScreen(config)
	return RockScreen:new():setArgs(config.args)
end

FlashScreen = class("FlashScreen", BaseAction)

function FlashScreen:initialize()
	super.initialize(self)
end

function FlashScreen:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	actor:flashScreen(args, function()
		self:finish(BehaviorResult.Success)
	end)
end

MaskNodeHide = class("MaskNodeHide", BaseAction)

function MaskNodeHide:initialize()
	super.initialize(self)
end

function MaskNodeHide:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	actor:hide()

	return BehaviorResult.Success
end

EnterScene = class("EnterScene", BaseAction)

function EnterScene:initialize()
	super.initialize(self)
end

function EnterScene:createAction(name, scene, args)
	local actionDef = scene:getActionDefinition(name)

	if actionDef == nil then
		return nil
	end

	if type(actionDef) == "function" then
		return actionDef(scene, args)
	end
end

function EnterScene:start(args)
	if args.scene == nil then
		return BehaviorResult.Success
	end

	local context = self.context
	local agent = context:getAgent()
	local actionName = args.action

	if agent:isSaved(actionName) then
		return BehaviorResult.Success
	end

	if agent.setEnterSceneAction then
		agent:setEnterSceneAction(self)
	end

	local scene = StageNodeFactory:createScene(args.scene:stage())

	scene:setAgent(agent)
	context:setScene(scene)

	local curSceneMediator = agent:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local sceneParent = curSceneMediator:getResidentLayer()
	local winSize = cc.Director:getInstance():getVisibleSize()
	local renderNode = scene:getRenderNode()
	local kGuideLayer = 10

	renderNode:addTo(sceneParent, kGuideLayer):posite(0, 0):setContentSize(winSize)
	scene:refreshLayout()

	local posY = renderNode:getPositionY()
	local posX = renderNode:getPositionX()
	local wpos = renderNode:convertToWorldSpace(cc.p(0, 0))

	renderNode:setPositionY(posY - wpos.y)
	renderNode:setPositionX(posX - wpos.x)

	local function onEnd()
		if scene ~= nil then
			local renderNode = scene:getRenderNode()

			if renderNode then
				renderNode:removeFromParent(true)
			end

			scene:dispose()

			scene = nil
		end
	end

	local action = self:createAction(args.action, scene, context:getVariables())

	if action == nil then
		return BehaviorResult.Success
	end

	self._actions = {}
	self._actions[1] = action

	local play
	local index = 1

	function play()
		local ac = self._actions[index]

		self._action = ac
		index = index + 1

		local function onFinish()
			if self._actions[index] then
				ac:setOnAbortFunc(nil)
				play()
			else
				onEnd()
				self:finish(BehaviorResult.Success)
			end
		end

		ac:setOnAbortFunc(onEnd)
		ac:run(context, onFinish)
	end

	play()
end

function EnterScene:addNextAction(actionName)
	local context = self.context
	local scene = context:getScene()

	self._actions[#self._actions + 1] = self:createAction(actionName, scene, context:getVariables())
end

function EnterScene:abort(result)
	if self._action ~= nil then
		self._action:abort()

		self._action = nil
	end

	self._actions = {}

	super.abort(self, result)
end

function sandbox.enterScene(config)
	return EnterScene:new():setArgs(config.args)
end

enterSceneFollowAction = class("enterSceneFollowAction", BaseAction)

function enterSceneFollowAction:initialize()
	super.initialize(self)
end

function enterSceneFollowAction:start(args)
	if args.name then
		local context = self.context
		local agent = context:getAgent()

		agent:addEnterFollowAction(args.name)
	end

	return BehaviorResult.Success
end

function sandbox.enterSceneFollowAction(config)
	return enterSceneFollowAction:new():setArgs(config.args)
end

Sleep = class("Sleep", BaseAction)

function Sleep:initialize()
	super.initialize(self)
end

function Sleep:start(args)
	if not args.duration then
		delayCallByTime(args.duration * 1000, function()
			self:finish(BehaviorResult.Success)
		end)
	end
end

function sandbox.sleep(config)
	return Sleep:new():setArgs(config.args)
end

Save = class("Save", BaseAction)

function Save:initialize()
	super.initialize(self)
end

function Save:start(args)
	local context = self.context

	context:save(args.steps)

	return BehaviorResult.Success
end

function sandbox.save(config)
	return Save:new():setArgs(config.args)
end

SkipButtonHide = class("SkipButtonHide", BaseAction)

function SkipButtonHide:initialize()
	super.initialize(self)
end

function SkipButtonHide:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

SkipButtonShow = class("SkipButtonShow", BaseAction)

function SkipButtonShow:initialize()
	super.initialize(self)
end

function SkipButtonShow:start(args)
	local actor = self:getActor()

	if actor then
		actor:show(args)
	end

	return BehaviorResult.Success
end

GuideSkipAllButtonHide = class("GuideSkipAllButtonHide", BaseAction)

function GuideSkipAllButtonHide:initialize()
	super.initialize(self)
end

function GuideSkipAllButtonHide:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

GuideSkipAllButtonShow = class("GuideSkipAllButtonShow", BaseAction)

function GuideSkipAllButtonShow:initialize()
	super.initialize(self)
end

function GuideSkipAllButtonShow:start(args)
	local actor = self:getActor()

	if actor then
		actor:show()
	end

	return BehaviorResult.Success
end

ReviewButtonNodeHide = class("ReviewButtonNodeHide", BaseAction)

function ReviewButtonNodeHide:initialize()
	super.initialize(self)
end

function ReviewButtonNodeHide:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

ReviewButtonNodeShow = class("ReviewButtonNodeShow", BaseAction)

function ReviewButtonNodeShow:initialize()
	super.initialize(self)
end

function ReviewButtonNodeShow:start(args)
	local actor = self:getActor()

	if actor then
		actor:show()
	end

	return BehaviorResult.Success
end

AutoPlayButtonNodeHide = class("AutoPlayButtonNodeHide", BaseAction)

function AutoPlayButtonNodeHide:initialize()
	super.initialize(self)
end

function AutoPlayButtonNodeHide:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

ReviewButtonNodeShow = class("AutoPlayButtonNodeShow", BaseAction)

function AutoPlayButtonNodeShow:initialize()
	super.initialize(self)
end

function AutoPlayButtonNodeShow:start(args)
	local actor = self:getActor()

	if actor then
		actor:show()
	end

	return BehaviorResult.Success
end

HideButtonNodeHide = class("HideButtonNodeHide", BaseAction)

function HideButtonNodeHide:initialize()
	super.initialize(self)
end

function HideButtonNodeHide:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

HideButtonNodeShow = class("HideButtonNodeShow", BaseAction)

function HideButtonNodeShow:initialize()
	super.initialize(self)
end

function HideButtonNodeShow:start(args)
	local actor = self:getActor()

	if actor then
		actor:show()
	end

	return BehaviorResult.Success
end

RunScript = class("RunScript", BaseAction)

function RunScript:initialize()
	super.initialize(self)
end

function RunScript:start(args)
	local context = self.context
	local agent = context:getAgent()

	self._runningScript = agent:_runScript(args.scriptname, args.setEnv, function()
		self._runningScript = nil

		self:finish(BehaviorResult.Success)
	end)
end

function RunScript:abort(result)
	if self._runningScript then
		self._runningScript:abort(result)

		self._runningScript = nil
	end
end

function sandbox.runScript(config)
	return RunScript:new():setArgs(config.args)
end

OptionSpeak = class("OptionSpeak", BaseAction)

function OptionSpeak:initialize()
	super.initialize(self)
end

function OptionSpeak:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	args.translateMap = self.context:getVar("translate")

	if args.style then
		actor:speak(args, function(optionId)
			self:saveCurOptionId(optionId)
			self:finish(BehaviorResult.Success)
		end)
	else
		actor:speak(args, function(optionLibId, optionId)
			self:saveOptionRecord(optionLibId, optionId)
			self:finish(BehaviorResult.Success)
		end)
	end
end

function OptionSpeak:saveOptionRecord(optionLibId, optionId)
	local context = self.context
	local option = context:getVar("option")

	if option then
		option[optionLibId] = {
			select = optionId,
			after = {}
		}
	else
		local record = {}

		record[optionLibId] = {
			select = optionId,
			after = {}
		}

		context:setVar("option", record)
	end

	self:saveCurOptionId(optionId)
end

function OptionSpeak:saveCurOptionId(optionId)
	self.context:setVar("curOptionId", optionId)
end

function OptionSpeak:abort(result)
	local actor = self:getActor()

	if actor then
		actor:removeSchedule()
	end

	super.abort(self, result)
end

OptionHide = class("OptionHide", BaseAction)

function OptionHide:initialize()
	super.initialize(self)
end

function OptionHide:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

ExecOptionResult = class("ExecOptionResult", BaseAction)

function ExecOptionResult:initialize()
	super.initialize(self)
end

function ExecOptionResult:start(args)
	local curOptionId = self.context:getVar("curOptionId")
	local optionEvent = ConfigReader:getDataByNameIdAndKey("Option", curOptionId, "Event")

	if optionEvent and optionEvent.type == EventPointType.kReward then
		self._action = sandbox.rewardShow({
			args = {
				reward = optionEvent.reward
			}
		})
	elseif optionEvent and optionEvent.type == EventPointType.kStory then
		local optionMap = self.context:getVar("option")

		if optionMap == nil then
			return BehaviorResult.Success
		end

		for _, record in pairs(optionMap) do
			if record.select == curOptionId then
				local innerOption = record.after

				self._action = sandbox.runScript({
					args = {
						scriptname = optionEvent.story
					},
					setEnv = function(context)
						context:setVar("option", innerOption)
					end
				})
			end
		end
	else
		return BehaviorResult.Success
	end

	self._action:run(self.context, function()
		self:finish(BehaviorResult.Success)
	end)
end

function ExecOptionResult:abort(result)
	if self._action then
		self._action:abort(result)

		self._action = nil
	end
end

function sandbox.execOptionResult(config)
	return ExecOptionResult:new():setArgs(config.args)
end

Vibrate = class("Vibrate", BaseAction)

function Vibrate:start(args)
	cc.Device:vibrate(args.duration)

	return BehaviorResult.Success
end

function sandbox.vibrate(config)
	return Vibrate:new():setArgs(config.args)
end

hideVideoSpriteNode = class("hideVideoSpriteNode", BaseAction)

function hideVideoSpriteNode:initialize()
	super.initialize(self)
end

function hideVideoSpriteNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

playVideoSpriteNode = class("playVideoSpriteNode", BaseAction)

function playVideoSpriteNode:initialize()
	super.initialize(self)
end

function playVideoSpriteNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:play(args)
	end

	return BehaviorResult.Success
end

stopVideoSpriteNode = class("stopVideoSpriteNode", BaseAction)

function stopVideoSpriteNode:initialize()
	super.initialize(self)
end

function stopVideoSpriteNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:stop()
	end

	return BehaviorResult.Success
end

pauseVideoSpriteNode = class("pauseVideoSpriteNode", BaseAction)

function pauseVideoSpriteNode:initialize()
	super.initialize(self)
end

function pauseVideoSpriteNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:pause()
	end

	return BehaviorResult.Success
end

resumeVideoSpriteNode = class("resumeVideoSpriteNode", BaseAction)

function resumeVideoSpriteNode:initialize()
	super.initialize(self)
end

function resumeVideoSpriteNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:resume()
	end

	return BehaviorResult.Success
end

playEndVideoSpriteNode = class("playEndVideoSpriteNode", BaseAction)

function playEndVideoSpriteNode:initialize()
	super.initialize(self)
end

function playEndVideoSpriteNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:playEnd(args, function()
			self:finish(BehaviorResult.Success)
		end)
	end
end

playParticleNode = class("playParticleNode", BaseAction)

function playParticleNode:initialize()
	super.initialize(self)
end

function playParticleNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:play(args)
	end

	return BehaviorResult.Success
end

hideParticleNode = class("hideParticleNode", BaseAction)

function hideParticleNode:initialize()
	super.initialize(self)
end

function hideParticleNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

showFlashMaskNode = class("showFlashMaskNode", BaseAction)

function showFlashMaskNode:initialize()
	super.initialize(self)
end

function showFlashMaskNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:show(args)
	end

	return BehaviorResult.Success
end

hideFlashMaskNode = class("hideFlashMaskNode", BaseAction)

function hideFlashMaskNode:initialize()
	super.initialize(self)
end

function hideFlashMaskNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

showImageFlashNode = class("showImageFlashNode", BaseAction)

function showImageFlashNode:initialize()
	super.initialize(self)
end

function showImageFlashNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:show(args)
	end

	return BehaviorResult.Success
end

hideImageFlashNode = class("hideImageFlashNode", BaseAction)

function hideImageFlashNode:initialize()
	super.initialize(self)
end

function hideImageFlashNode:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide(args)
	end

	return BehaviorResult.Success
end
