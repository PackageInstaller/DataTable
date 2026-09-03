-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/behaviors/DialogueActions.lua

module("story", package.seeall)

DialogueAddPortrait = class("DialogueAddPortrait", BaseAction)

function DialogueAddPortrait:initialize()
	super.initialize(self)
end

function DialogueAddPortrait:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	local actorRenderNode = actor:getRenderNode()

	if actorRenderNode then
		-- block empty
	end

	local context = self.context
	local scene = context:getScene()
	local portraitNode = scene:getChildById(args.id)

	if portraitNode then
		return BehaviorResult.Success
	end

	local portraitIds = context:getVar("portraitIds")
	local newPortraintIds = {}
	local portraitIdNum = 0

	if portraitIds then
		portraitIdNum = #portraitIds

		for k, v in pairs(portraitIds) do
			newPortraintIds[k] = v
		end
	end

	newPortraintIds[portraitIdNum + 1] = args.id

	context:setVar("portraitIds", newPortraintIds)

	args.type = args.type or "Portrait"
	portraitNode = StageNodeFactory:createNodeWithConfig(args)

	if portraitNode then
		scene:addChild(portraitNode, args.zorder)
		portraitNode:refreshLayout()
	end

	return BehaviorResult.Success
end

DialogueRemovePortrait = class("DialogueRemovePortrait", BaseAction)

function DialogueRemovePortrait:initialize()
	super.initialize(self)
end

function DialogueRemovePortrait:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	local context = self.context
	local scene = context:getScene()
	local portraitNode = scene:getChildById(args.id)
	local portraitIds = context:getVar("portraitIds")
	local newPortraintIds = {}

	if portraits then
		for k, portraitId in pairs(portraitIds) do
			if portraitId ~= args.id then
				newPortraintIds[#newPortraintIds + 1] = portraitId
			end
		end

		context:setVar("portraitIds", newPortraintIds)
	end

	if portraitNode == nil then
		return BehaviorResult.Success
	end

	scene:removeChild(portraitNode)
	portraitNode:dispose()

	return BehaviorResult.Success
end

DialogueRemoveAllPortrait = class("DialogueRemoveAllPortrait", BaseAction)

function DialogueRemoveAllPortrait:initialize()
	super.initialize(self)
end

function DialogueRemoveAllPortrait:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	local context = self.context
	local scene = context:getScene()

	if actor then
		local portraitIds = context:getVar("portraitIds")

		if portraitIds then
			for _, portraitId in pairs(portraitIds) do
				local portraitNode = scene:getChildById(portraitId)

				if portraitNode then
					scene:removeChild(portraitNode)
					portraitNode:dispose()
				end
			end
		end

		context:setVar("portraitIds", nil)
	end

	return BehaviorResult.Success
end

DialogueSpeak = class("DialogueSpeak", BaseAction)

function DialogueSpeak:initialize()
	super.initialize(self)
end

function DialogueSpeak:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	local contents = {}

	if type(args.content) == "string" then
		contents[1] = args.content
	else
		contents = args.content
	end

	local portraits = {}
	local context = self.context
	local scene = context:getScene()
	local portraitIds = context:getVar("portraitIds")

	if portraitIds then
		for _, portraitId in pairs(portraitIds) do
			local portraitNode = scene:getChildById(portraitId)

			if portraitNode then
				portraits[#portraits + 1] = portraitNode
			end
		end
	end

	args.contents = contents
	args.portraits = portraits

	actor:speak(args, function()
		if self:isRunning() then
			self:finish(BehaviorResult.Success)
		end
	end)
	context:getAgent():addStoryStatisticStep(100)
	context:getAgent():addStoryValidPlayCount()

	if args.audio then
		local curAudio = context:getVar("guideAudio")

		if curAudio then
			AudioEngine:getInstance():stopEffect(curAudio)
		end

		dump(args.audio, "args.guideAudio__")

		local guideAudioId = AudioEngine:getInstance():playEffect(args.audio, false)

		context:setVar("guideAudio", guideAudioId)
	end
end

DialogueHide = class("DialogueHide", BaseAction)

function DialogueHide:initialize()
	super.initialize(self)
end

function DialogueHide:start(args)
	local actor = self:getActor()
	local context = self.context
	local scene = context:getScene()

	if not args.clearPortrait then
		if actor then
			actor:hide()

			if args.clearPortrait then
				local portraitIds = context:getVar("portraitIds")

				if portraitIds then
					for _, portraitId in pairs(portraitIds) do
						local portraitNode = scene:getChildById(portraitId)

						if portraitNode then
							scene:removeChild(portraitNode)
							portraitNode:dispose()
						end
					end

					context:setVar("portraitIds", nil)
				end
			end
		end

		return BehaviorResult.Success
	end
end

DialogueShow = class("DialogueShow", BaseAction)

function DialogueShow:initialize()
	super.initialize(self)
end

function DialogueShow:start(args)
	local actor = self:getActor()
	local context = self.context
	local scene = context:getScene()

	if actor then
		actor:show()
	end

	return BehaviorResult.Success
end

DialogueReset = class("DialogueReset", BaseAction)

function DialogueReset:initialize()
	super.initialize(self)
end

function DialogueReset:start(args)
	local actor = self:getActor()

	if actor then
		local portraits = {}
		local context = self.context
		local scene = context:getScene()
		local portraitIds = context:getVar("portraitIds")

		if portraitIds then
			for _, portraitId in pairs(portraitIds) do
				local portraitNode = scene:getChildById(portraitId)

				if portraitNode then
					portraits[#portraits + 1] = portraitNode
				end
			end
		end

		actor:reset(portraits)
	end

	return BehaviorResult.Success
end

NormalDialogueSpeak = class("NormalDialogueSpeak", BaseAction)

function NormalDialogueSpeak:initialize()
	super.initialize(self)
end

function NormalDialogueSpeak:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	args.translateMap = self.context:getVar("translate")

	actor:speak(args, function()
		self:finish(BehaviorResult.Success)
	end)
end

NormalDialogueHide = class("NormalDialogueHide", BaseAction)

function NormalDialogueHide:initialize()
	super.initialize(self)
end

function NormalDialogueHide:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

ColorBackGroundShow = class("ColorBackGroundShow", BaseAction)

function ColorBackGroundShow:initialize()
	super.initialize(self)
end

function ColorBackGroundShow:start(args)
	local actor = self:getActor()

	if actor then
		actor:show(args)
	end

	return BehaviorResult.Success
end

ColorBackGroundHide = class("ColorBackGroundHide", BaseAction)

function ColorBackGroundHide:initialize()
	super.initialize(self)
end

function ColorBackGroundHide:start(args)
	local actor = self:getActor()

	if actor then
		actor:hide()
	end

	return BehaviorResult.Success
end

DialogueChooseShow = class("DialogueChooseShow", BaseAction)

function DialogueChooseShow:initialize()
	super.initialize(self)
end

function DialogueChooseShow:start(args)
	local actor = self:getActor()

	if actor == nil then
		local scene = self.context:getScene()

		actor = scene:getChildById("DialogueChoose")

		if actor == nil then
			return BehaviorResult.Success
		end
	end

	actor:show(args, function(index)
		if self:isRunning() then
			local context = self.context
			local storyAgent = context:getAgent()

			if storyAgent and storyAgent.addDialogue then
				storyAgent:addDialogue({
					content = args.content[index]
				}, "C")
			end

			self:finish(BehaviorResult.Success)
		end
	end)

	local context = self.context

	context:getAgent():addStoryValidPlayCount()
end

function DialogueChooseShow:getActionName()
	return "DialogueChooseShow"
end

PrinterEffectShow = class("PrinterEffectShow", BaseAction)

function PrinterEffectShow:initialize()
	super.initialize(self)
end

function PrinterEffectShow:start(args)
	local actor = self:getActor()

	if actor == nil then
		local scene = self.context:getScene()

		actor = scene:getChildById("PrinterEffect")

		if actor == nil then
			return BehaviorResult.Success
		end
	end

	actor:show(args, function()
		if self:isRunning() then
			self:finish(BehaviorResult.Success)
		end
	end)

	if args.audio then
		local curAudio = self.context:getVar("printerEffectudio")

		if curAudio then
			AudioEngine:getInstance():stopEffect(curAudio)
		end

		local guideAudioId = AudioEngine:getInstance():playEffect(args.audio, false)

		self.context:setVar("printerEffectudio", guideAudioId)
	end

	local context = self.context

	context:getAgent():addStoryValidPlayCount()
end

PrinterEffectHide = class("PrinterEffectHide", BaseAction)

function PrinterEffectHide:initialize()
	super.initialize(self)
end

function PrinterEffectHide:start(args)
	local actor = self:getActor()

	if actor == nil then
		local scene = self.context:getScene()

		actor = scene:getChildById("PrinterEffect")

		if actor == nil then
			return BehaviorResult.Success
		end
	end

	actor:hide(args, function()
		self:finish(BehaviorResult.Success)
	end)
end

ChapterDialogShow = class("ChapterDialogShow", BaseAction)

function ChapterDialogShow:initialize()
	super.initialize(self)
end

function ChapterDialogShow:start(args)
	local actor = self:getActor()

	if actor == nil then
		local scene = self.context:getScene()

		actor = scene:getChildById("ChapterDialog")

		if actor == nil then
			return BehaviorResult.Success
		end
	end

	actor:show(args, function()
		if self:isRunning() then
			self:finish(BehaviorResult.Success)
		end
	end)

	if args.audio then
		local curAudio = self.context:getVar("ChapterDialogAudio")

		if curAudio then
			AudioEngine:getInstance():stopEffect(curAudio)
		end

		local guideAudioId = AudioEngine:getInstance():playEffect(args.audio, false)

		self.context:setVar("ChapterDialogAudio", guideAudioId)
	end
end

ChapterDialogHide = class("ChapterDialogHide", BaseAction)

function ChapterDialogHide:initialize()
	super.initialize(self)
end

function ChapterDialogHide:start(args)
	local actor = self:getActor()

	if actor == nil then
		local scene = self.context:getScene()

		actor = scene:getChildById("ChapterDialog")

		if actor == nil then
			return BehaviorResult.Success
		end
	end

	actor:hide(args, function()
		self:finish(BehaviorResult.Success)
	end)
end

RenameDialogShow = class("RenameDialogShow", BaseAction)

function RenameDialogShow:initialize()
	super.initialize(self)
end

function RenameDialogShow:start(args)
	local developSystem = self.context:getInjector():getInstance("DevelopSystem")
	local bagSystem = developSystem:getBagSystem()
	local changeNameTimes = bagSystem:getTimeRecordById(TimeRecordType.kChangeName)._time

	if changeNameTimes > 0 then
		self:finish(BehaviorResult.Success)

		return
	end

	local scene = self.context:getScene()
	local actor = scene:getChildById("renameDialog")

	if actor == nil then
		actor = StageNodeFactory:createRenameDialog(scene)
	end

	actor:show(args, function()
		if self:isRunning() then
			scene:removeChild(actor)
			self:finish(BehaviorResult.Success)
		end
	end)

	if args.audio then
		local curAudio = self.context:getVar("RenameDialogAudio")

		if curAudio then
			AudioEngine:getInstance():stopEffect(curAudio)
		end

		local guideAudioId = AudioEngine:getInstance():playEffect(args.audio, false)

		self.context:setVar("RenameDialogAudio", guideAudioId)
	end
end

function sandbox.renameDialogShowAction(config)
	return RenameDialogShow:new():setArgs(config.args)
end

RenameDialogHide = class("RenameDialogHide", BaseAction)

function RenameDialogHide:initialize()
	super.initialize(self)
end

function RenameDialogHide:start(args)
	local scene = self.context:getScene()

	actor = scene:getChildById("renameDialog")

	if actor == nil then
		return BehaviorResult.Success
	end

	actor:hide(args, function()
		self:finish(BehaviorResult.Success)
	end)
end

function sandbox.renameDialogHideAction(config)
	return RenameDialogHide:new():setArgs(config.args)
end

CurtainUpdateColor = class("CurtainUpdateColor", BaseAction)

function CurtainUpdateColor:initialize()
	super.initialize(self)
end

function CurtainUpdateColor:start(args)
	local actor = self:getActor()

	if actor == nil then
		return BehaviorResult.Success
	end

	actor:updateColor(args)

	return BehaviorResult.Success
end

MessageNodeShow = class("MessageNodeShow", BaseAction)

function MessageNodeShow:initialize()
	super.initialize(self)
end

function MessageNodeShow:start(args)
	local actor = self:getActor()

	if actor == nil then
		local scene = self.context:getScene()

		actor = scene:getChildById("messageNode")

		if actor == nil then
			return BehaviorResult.Success
		end
	end

	actor:show(args, function()
		if self:isRunning() then
			self:finish(BehaviorResult.Success)
		end
	end)
end

MessageNodeHide = class("MessageNodeHide", BaseAction)

function MessageNodeHide:initialize()
	super.initialize(self)
end

function MessageNodeHide:start(args)
	local actor = self:getActor()

	if actor == nil then
		local scene = self.context:getScene()

		actor = scene:getChildById("messageNode")

		if actor == nil then
			return BehaviorResult.Success
		end
	end

	actor:hide(args, function()
		self:finish(BehaviorResult.Success)
	end)
end

StoryNewsNodeShow = class("StoryNewsNodeShow", BaseAction)

function StoryNewsNodeShow:initialize()
	super.initialize(self)
end

function StoryNewsNodeShow:start(args)
	local actor = self:getActor()

	if actor == nil then
		local scene = self.context:getScene()

		actor = scene:getChildById("newsNode")

		if actor == nil then
			return BehaviorResult.Success
		end
	end

	actor:show(args, function()
		if self:isRunning() then
			self:finish(BehaviorResult.Success)
		end
	end)

	local context = self.context

	context:getAgent():addStoryValidPlayCount()
end

StoryNewsNodeHide = class("StoryNewsNodeHide", BaseAction)

function StoryNewsNodeHide:initialize()
	super.initialize(self)
end

function StoryNewsNodeHide:start(args)
	local actor = self:getActor()

	if actor == nil then
		local scene = self.context:getScene()

		actor = scene:getChildById("newsNode")

		if actor == nil then
			return BehaviorResult.Success
		end
	end

	actor:hide(args, function()
		self:finish(BehaviorResult.Success)
	end)
end

WorldScrollTextNodeShow = class("WorldScrollTextNodeShow", BaseAction)

function WorldScrollTextNodeShow:initialize()
	super.initialize(self)
end

function WorldScrollTextNodeShow:start(args)
	local actor = self:getActor()

	if actor == nil then
		local scene = self.context:getScene()

		actor = scene:getChildById("worldScrollText")

		if actor == nil then
			return BehaviorResult.Success
		end
	end

	actor:show(args, function()
		if self:isRunning() then
			self:finish(BehaviorResult.Success)
		end
	end)
end

WorldScrollTextNodeHide = class("WorldScrollTextNodeHide", BaseAction)

function WorldScrollTextNodeHide:initialize()
	super.initialize(self)
end

function WorldScrollTextNodeHide:start(args)
	local actor = self:getActor()

	if actor == nil then
		local scene = self.context:getScene()

		actor = scene:getChildById("worldScrollText")

		if actor == nil then
			return BehaviorResult.Success
		end
	end

	actor:hide(args, function()
		self:finish(BehaviorResult.Success)
	end)
end

StoryChooseDialogShow = class("StoryChooseDialogShow", BaseAction)

function StoryChooseDialogShow:initialize()
	super.initialize(self)
end

function StoryChooseDialogShow:start(args)
	local scene = self.context:getScene()
	local actor = scene:getChildById("storyChooseDialog")

	if actor == nil then
		actor = StageNodeFactory:createStoryChooseDialog(scene)
	end

	actor:show(args, function()
		if self:isRunning() then
			scene:removeChild(actor)
			self:finish(BehaviorResult.Success)
		end
	end)
end

function sandbox.storyChooseDialogShowAction(config)
	return StoryChooseDialogShow:new():setArgs(config.args)
end
