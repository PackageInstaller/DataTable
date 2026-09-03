-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/extends/NodeEx.lua

local Node = cc.Node

function Node:add(child, zorder, tag)
	if tag then
		self:addChild(child, zorder, tag)
	elseif zorder then
		self:addChild(child, zorder)
	else
		self:addChild(child)
	end

	return self
end

function Node:addTo(parent, zorder, tag)
	if tag then
		parent:addChild(self, zorder, tag)
	elseif zorder then
		parent:addChild(self, zorder)
	else
		parent:addChild(self)
	end

	return self
end

function Node:removeSelf()
	self:removeFromParent()

	return self
end

function Node:align(anchorPoint, x, y)
	self:setAnchorPoint(anchorPoint)

	return self:move(x, y)
end

function Node:show()
	self:setVisible(true)

	return self
end

function Node:hide()
	self:setVisible(false)

	return self
end

function Node:move(x, y)
	if y then
		self:setPosition(x, y)
	else
		self:setPosition(x)
	end

	return self
end

function Node:moveTo(args)
	transition.moveTo(self, args)

	return self
end

function Node:moveBy(args)
	transition.moveBy(self, args)

	return self
end

function Node:fadeIn(args)
	transition.fadeIn(self, args)

	return self
end

function Node:fadeOut(args)
	transition.fadeOut(self, args)

	return self
end

function Node:fadeTo(args)
	transition.fadeTo(self, args)

	return self
end

function Node:rotate(rotation)
	self:setRotation(rotation)

	return self
end

function Node:rotateTo(args)
	transition.rotateTo(self, args)

	return self
end

function Node:rotateBy(args)
	transition.rotateBy(self, args)

	return self
end

function Node:scaleTo(args)
	transition.scaleTo(self, args)

	return self
end

function Node:onUpdate(callback)
	self:scheduleUpdateWithPriorityLua(callback, 0)

	return self
end

Node.scheduleUpdate = Node.onUpdate

function Node:onNodeEvent(eventName, callback)
	if eventName == "enter" then
		self.onEnterCallback_ = callback
	elseif eventName == "exit" then
		self.onExitCallback_ = callback
	elseif eventName == "enterTransitionFinish" then
		self.onEnterTransitionFinishCallback_ = callback
	elseif eventName == "exitTransitionStart" then
		self.onExitTransitionStartCallback_ = callback
	elseif eventName == "cleanup" then
		self.onCleanupCallback_ = callback
	end

	self:enableNodeEvents()
end

function Node:enableNodeEvents()
	if self.isNodeEventEnabled_ then
		return self
	end

	self:registerScriptHandler(function(state)
		if state == "enter" then
			self:onEnter_()
		elseif state == "exit" then
			self:onExit_()
		elseif state == "enterTransitionFinish" then
			self:onEnterTransitionFinish_()
		elseif state == "exitTransitionStart" then
			self:onExitTransitionStart_()
		elseif state == "cleanup" then
			self:onCleanup_()
		end
	end)

	self.isNodeEventEnabled_ = true

	return self
end

function Node:disableNodeEvents()
	self:unregisterScriptHandler()

	self.isNodeEventEnabled_ = false

	return self
end

function Node:onEnter()
	return
end

function Node:onExit()
	return
end

function Node:onEnterTransitionFinish()
	return
end

function Node:onExitTransitionStart()
	return
end

function Node:onCleanup()
	return
end

function Node:onEnter_()
	self:onEnter()

	if not self.onEnterCallback_ then
		return
	end

	self:onEnterCallback_()
end

function Node:onExit_()
	self:onExit()

	if not self.onExitCallback_ then
		return
	end

	self:onExitCallback_()
end

function Node:onEnterTransitionFinish_()
	self:onEnterTransitionFinish()

	if not self.onEnterTransitionFinishCallback_ then
		return
	end

	self:onEnterTransitionFinishCallback_()
end

function Node:onExitTransitionStart_()
	self:onExitTransitionStart()

	if not self.onExitTransitionStartCallback_ then
		return
	end

	self:onExitTransitionStartCallback_()
end

function Node:onCleanup_()
	self:onCleanup()

	if not self.onCleanupCallback_ then
		return
	end

	self:onCleanupCallback_()
end
