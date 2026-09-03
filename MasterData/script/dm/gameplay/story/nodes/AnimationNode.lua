-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/nodes/AnimationNode.lua

module("story", package.seeall)

AnimationNode = class("AnimationNode", StageNode)

local actions = {
	play = PlayAnimationAction,
	stop = StopAnimationAction,
	pause = PauseAnimationAction,
	resume = ResumeAnimationAction,
	freezeFrame = FreezeAnimationAction,
	playWithFrame = PlayWithFrameAnimationAction
}

AnimationNode:extendActionsForClass(actions)
register_stage_node("Animation", function(config)
	local animType
	local resource = config.resource

	if resource then
		if #resource == 2 then
			for i = 1, #resource do
				if type(resource[i]) ~= "string" then
					return nil, "type error"
				elseif string.find(resource[i], ".skel") then
					animType = SpineNode

					break
				end
			end
		end

		if #resource == 1 then
			animType = FlashNode
		end
	end

	if animType ~= nil then
		return animType:new(config)
	end

	return nil, "type error"
end)

FlashNode = class("FlashNode", AnimationNode)

function FlashNode:initialize(config)
	super.initialize(self, config)
end

function FlashNode:createRenderNode(config)
	local renderNode = cc.MovieClip:create(config.resource[1])

	renderNode:gotoAndStop(1)

	return renderNode
end

function FlashNode:play(name, loop, frameIndex, callback)
	local animLoop = loop or false
	local renderNode = self:getRenderNode()

	if not renderNode then
		callback("complete")

		return
	end

	if animLoop then
		renderNode:play()
		callback("complete")
	elseif frameIndex then
		renderNode:gotoAndPlay(1)

		self.animCallbackID = renderNode:addCallbackAtFrame(frameIndex, function()
			callback("complete")

			if self.animCallbackID then
				self:getRenderNode():stop()
				self:getRenderNode():removeCallback(self.animCallbackID)

				self.animCallbackID = nil
			end
		end)
	else
		renderNode:gotoAndPlay(1)

		self.animCallbackID = renderNode:addEndCallback(function()
			callback("complete")

			if self.animCallbackID then
				self:getRenderNode():removeCallback(self.animCallbackID)

				self.animCallbackID = nil
			end
		end)
	end
end

function FlashNode:playWithFrame(startFrame, endFrame, speed, callback)
	local renderNode = self:getRenderNode()

	if not renderNode then
		callback("complete")

		return
	end

	local startFrame = startFrame or 1

	if startFrame then
		renderNode:gotoAndPlay(startFrame)
		renderNode:setPlaySpeed(speed or 1)

		self.animCallbackID = endFrame and renderNode:addCallbackAtFrame(endFrame, function()
			callback("complete")

			if self.animCallbackID then
				renderNode:stop()
				renderNode:removeCallback(self.animCallbackID)

				self.animCallbackID = nil
			end
		end) or renderNode:addEndCallback(function()
			callback("complete")

			if self.animCallbackID then
				renderNode:stop()
				renderNode:removeCallback(self.animCallbackID)

				self.animCallbackID = nil
			end
		end)
	end
end

function FlashNode:stop()
	local renderNode = self:getRenderNode()

	if renderNode then
		renderNode:gotoAndStop(1)
	end
end

function FlashNode:pause()
	local renderNode = self:getRenderNode()

	if renderNode then
		renderNode:stop()
	end
end

function FlashNode:resume()
	local renderNode = self:getRenderNode()

	if renderNode then
		renderNode:resume()
	end
end

function FlashNode:freezeFrame(frameIndex)
	local renderNode = self:getRenderNode()

	if renderNode then
		renderNode:gotoAndStop(frameIndex)
	end
end

SpineNode = class("SpineNode", AnimationNode)

function SpineNode:initialize(config)
	super.initialize(self, config)
end

function SpineNode:createRenderNode(config)
	local renderNode

	return string.find(config.resource[1], ".skel") and sp.SkeletonAnimation:create(config.resource[1]) or sp.SkeletonAnimation:create(config.resource[2])
end

function SpineNode:getSpineAnim()
	return self._renderNode
end

function SpineNode:play(name, loop, frame, callback)
	local animLoop = loop or false
	local spineAnim = self:getSpineAnim()

	if not spineAnim then
		if callback then
			callback("complete")
		end

		return
	end

	spineAnim:resumeAnimation()
	spineAnim:playAnimation(0, name, animLoop)

	if animLoop then
		if callback then
			callback("complete")
		end
	else
		spineAnim:registerSpineEventHandler(function(event)
			if event.type == "complete" then
				if callback then
					callback("complete")
				end

				spineAnim:unregisterSpineEventHandler(sp.EventType.ANIMATION_COMPLETE)
			end
		end, sp.EventType.ANIMATION_COMPLETE)
	end
end

function SpineNode:stop()
	local spineAnim = self:getSpineAnim()

	if spineAnim then
		spineAnim:stopAnimation()
	end
end

function SpineNode:pause()
	local spineAnim = self:getSpineAnim()

	if spineAnim then
		spineAnim:pauseAnimation()
	end
end

function SpineNode:resume()
	local spineAnim = self:getSpineAnim()

	if spineAnim then
		spineAnim:resumeAnimation()
	end
end

function SpineNode:freezeFrame(frameIndex)
	local spineAnim = self:getSpineAnim()

	if spineAnim then
		spineAnim:goToFrameIndexAndPaused(0, frameIndex)
	end
end

function SpineNode:playWithFrame(startFrame, endFrame, speed, callback, name)
	local spineAnim = self:getSpineAnim()

	if not spineAnim then
		callback("complete")

		return
	end

	spineAnim:resumeAnimation()
	spineAnim:playAnimationInFrameIndex(0, name, startFrame)
	spineAnim:setTimeScale(speed)
	spineAnim:removeUserEvent(name, "frame")
	spineAnim:addUserEventEx(name, "frame", endFrame)
	spineAnim:registerSpineEventHandler(function(event)
		if event.type == "event" and event.eventData.name == "frame" then
			spineAnim:pauseAnimation()
			spineAnim:unregisterSpineEventHandler(sp.EventType.ANIMATION_EVENT)

			if callback then
				callback("complete")
			end
		end
	end, sp.EventType.ANIMATION_EVENT)
end

kSpineAnimScale = 0.7
RoleNode = class("RoleNode", SpineNode)

RoleNode:has("_modelId", {
	is = "r"
})

local actions = {
	roleMoveTo = RoleMoveTo,
	roleMoveBy = RoleMoveBy
}

RoleNode:extendActionsForClass(actions)
register_stage_node("RoleModel", RoleNode)

function RoleNode:initialize(config)
	self._modelId = config.modelId

	super.initialize(self, config)
end

function RoleNode:createRenderNode(config)
	local renderNode = cc.Node:create()
	local modelConfig = ConfigReader:getRecordById("RoleModel", self._modelId)
	local width = modelConfig.Width * kSpineAnimScale
	local height = modelConfig.Height * kSpineAnimScale
	local size = cc.size(width, height)

	renderNode:setContentSize(size)

	local modelNode = cc.Node:create()
	local animationId = ConfigReader:getDataByNameIdAndKey("RoleModel", self._modelId, "Id")
	local spineAnim = sp.SkeletonAnimation:create("asset/anim/" .. animationId .. ".skel")

	spineAnim:setScale(kSpineAnimScale)
	spineAnim:addTo(modelNode):setName("spine_node")
	spineAnim:playAnimation(0, "stand", true)
	modelNode:addTo(renderNode):posite(width * 0.5, 0):setName("model_node")

	return renderNode
end

function RoleNode:setVolatileProps(config)
	super.setVolatileProps(self, config)

	if config.forward then
		self:setForward(config.forward)
	end
end

function RoleNode:getSpineAnim()
	return self._renderNode:getChildByFullName("model_node.spine_node")
end

function RoleNode:setForward(forward)
	local modelNode = self._renderNode:getChildByName("model_node")

	modelNode:setScaleX(forward)
end

function RoleNode:getForward()
	local modelNode = self._renderNode:getChildByName("model_node")

	return modelNode:getScaleX()
end

function RoleNode:moveWithDuration(targetPos, duration, spineAnim, onReached)
	local position = cc.p(self._renderNode:getPosition())

	if position.x == targetPos.x and position.y == targetPos.y then
		if onReached then
			onReached()
		end

		return
	end

	self:setForward(targetPos.x < position.x and -1 or 1)

	spineAnim = spineAnim or "run"

	self:play(spineAnim, true)

	local callFuncAct = cc.CallFunc:create(function()
		self:play("stand", true)

		if onReached then
			onReached()
		end
	end)
	local kMoveActionTag = 65537

	self._renderNode:stopActionByTag(kMoveActionTag)

	local action = cc.Sequence:create(cc.MoveTo:create(duration, targetPos), callFuncAct)

	action:setTag(kMoveActionTag)
	self._renderNode:runAction(action)
end

function RoleNode:moveWithSpeed(targetPos, speed, spineAnim, onReached)
	local position = cc.p(self._renderNode:getPosition())
	local offset = cc.pSub(targetPos, position)
	local duration = math.max(math.abs(offset.x / speed), math.abs(offset.y / speed))

	self:moveWithDuration(targetPos, duration, spineAnim, onReached)
end

GifNode = class("GifNode", StageNode)

register_stage_node("Gif", GifNode)

function GifNode:initialize(config)
	super.initialize(self, config)
end

function GifNode:createRenderNode(config)
	return (cc.CacheGif:create(config.gif))
end
