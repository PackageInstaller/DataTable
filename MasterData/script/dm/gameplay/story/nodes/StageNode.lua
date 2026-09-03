-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/nodes/StageNode.lua

module("story", package.seeall)

function register_stage_node(name, clazzOrFunc)
	if type(clazzOrFunc) == "function" then
		StageNodeFactory:addNodeCreator(name, clazzOrFunc)
	else
		StageNodeFactory:addNodeClass(name, clazzOrFunc)
	end
end

function calcPosition(position, size)
	if position == nil then
		return
	end

	size = size or cc.size(0, 0)
	size.width = size.width or 0
	size.height = size.height or 0

	local refpt = position.refpt

	refpt = refpt or cc.p(0, 0)
	refpt.x = refpt.x or 0
	refpt.y = refpt.y or 0

	if not position.x then
		local x = 0

		if not position.y then
			local y = 0

			x = x + size.width * refpt.x
			y = y + size.height * refpt.y

			return {
				x = x,
				y = y
			}
		end
	end
end

StageNode = class("StageNode", DisposableObject)

StageNode:has("_id", {
	is = "rw"
})
StageNode:has("_name", {
	is = "rw"
})
StageNode:has("_parent", {
	is = "rw"
})
StageNode:has("_children", {
	is = "r"
})
StageNode:has("_root", {
	is = "r"
})
StageNode:has("_displayType", {
	is = "rw"
})
StageNode:has("_touchEvents", {
	is = "r"
})

function StageNode:initialize(config)
	super.initialize(self)

	self._actions = self.__actions__
	self._id = config.id
	self._name = config.name
	self._renderNode = self:createRenderNode(config)

	self:setPropsForRenderNode(config)
end

function StageNode:dispose()
	local children = self._children

	if children ~= nil then
		for i, subnode in ipairs(children) do
			subnode:dispose()
		end

		self._children = nil
	end

	self:unregisterTouchEvents()

	return super.dispose(self)
end

function StageNode:setPropsForRenderNode(config)
	local node = self:getRenderNode()

	if node == nil or config == nil then
		return
	end

	self:setTouchEnabled(false)
	self:setVolatileProps(config)

	if self._layout == nil then
		self._layout = {
			stretchHeight = false,
			stretchWidth = false,
			size = node:getContentSize(),
			position = cc.p(node:getPosition()),
			mode = LayoutMode.kNormal
		}
	end

	if config.size then
		self._layout.size = config.size
	end

	if config.position then
		self._layout.position = config.position
	end

	if config.stretchWidth then
		self._layout.stretchWidth = config.stretchWidth
	end

	if config.stretchHeight then
		self._layout.stretchHeight = config.stretchHeight
	end

	if config.layoutMode then
		self._layout.mode = config.layoutMode
	end

	if config.displayType then
		self._displayType = config.displayType
	end
end

function StageNode:setVolatileProps(config)
	local node = self:getRenderNode()

	if node == nil or config == nil then
		return
	end

	if config.ignoreAPForPosition then
		node:setIgnoreAnchorPointForPosition(config.ignoreAPForPosition)
	end

	if config.anchorPoint then
		node:setAnchorPoint(config.anchorPoint)
	end

	if config.scale then
		node:setScale(config.scale)
	end

	if config.scaleX then
		node:setScaleX(config.scaleX)
	end

	if config.scaleY then
		node:setScaleY(config.scaleY)
	end

	if config.rotation then
		node:setRotation(config.rotation)
	end

	if config.rotationX then
		node:setRotationSkewX(config.rotationX)
	end

	if config.rotationY then
		node:setRotationSkewY(config.rotationY)
	end

	if config.visible ~= nil then
		node:setVisible(config.visible)
	end

	if config.zorder then
		node:setLocalZOrder(config.zorder)
	end

	if config.color then
		local color = GameStyle:stringToColor(config.color)

		node:setColor(color)
	end

	if config.opacity then
		node:setOpacity(config.opacity * 255)
	end

	if config.size then
		node:setContentSize(config.size)
	end

	if config.position then
		local parentNode = node:getParent()
		local parentSize = parentNode and parentNode:getContentSize()

		node:setPosition(calcPosition(config.position, parentSize))
	end

	if config.touchEvents then
		self._touchEvents = config.touchEvents

		self:setTouchEnabled(true)
	end

	if config.touchEnabled ~= nil then
		self:setTouchEnabled(config.touchEnabled)
	end

	if config.opacityTo then
		self:setOpacityTo(config.opacityTo)
	end
end

function StageNode:getScene()
	local scene = self.__isroot__ and self or self:getRoot()

	if scene == nil then
		return
	end

	while scene:getRoot() ~= nil do
		scene = scene:getRoot()
	end

	return scene
end

function StageNode:getAgent()
	local scene = self:getScene()

	return scene and scene:getAgent()
end

function StageNode:getDirector()
	local agent = self:getAgent()

	return agent and agent:getDirector()
end

function StageNode:getLayout()
	return self._layout
end

LayoutMode = {
	kFit = 3,
	kCover = 2,
	kNormal = 1
}

function StageNode:adjustRenderNode()
	if self._renderNode == nil then
		return
	end

	local node = self._renderNode
	local parent = self:getParent()

	if parent == nil then
		return
	end

	local parentNode = node:getParent()

	if parentNode == nil then
		return
	end

	local parentSize = parentNode:getContentSize()
	local layout = self:getLayout()
	local contentSize, position

	if layout.mode == LayoutMode.kNormal then
		local stretchWidthFactor, stretchHeightFactor = 1, 1
		local parentLayout = parent:getLayout()
		local parentDesignSize = parentLayout.size

		if parentDesignSize.width ~= 0 then
			stretchWidthFactor = parentSize.width / parentDesignSize.width
		end

		if parentDesignSize.height ~= 0 then
			stretchHeightFactor = parentSize.height / parentDesignSize.height
		end

		contentSize = layout.size

		if layout.stretchWidth then
			if node.ignoreContentAdaptWithSize then
				node:ignoreContentAdaptWithSize(false)
			end

			contentSize.width = contentSize.width * stretchWidthFactor
		end

		if layout.stretchHeight then
			if node.ignoreContentAdaptWithSize then
				node:ignoreContentAdaptWithSize(false)
			end

			contentSize.height = contentSize.height * stretchHeightFactor
		end

		position = calcPosition(layout.position, parentSize)
	elseif layout.mode == LayoutMode.kCover then
		node:coverRegion(parentSize)

		contentSize = node:getContentSize()
		position = cc.p(node:getPosition())
	elseif layout.mode == LayoutMode.kFit then
		node:fitRegion(parentSize)

		contentSize = node:getContentSize()
		position = cc.p(node:getPosition())
	end

	node:setContentSize(contentSize)

	if position then
		node:setPosition(position)
	end
end

function StageNode:refreshLayout()
	self:adjustRenderNode()
	self:doLayout()
end

function StageNode:doLayout()
	local children = self._children

	if children then
		for i, child in ipairs(children) do
			child:refreshLayout()
		end
	end
end

function StageNode:createRenderNode(config)
	return nil
end

function StageNode:getRenderNode()
	return self._renderNode
end

function StageNode:getRenderMountPoint(child)
	if self._renderMountPoints ~= nil then
		local displayType = child:getDisplayType()

		if displayType ~= nil then
			return self._renderMountPoints[displayType]
		else
			return self._renderMountPoints.default
		end
	else
		return self._renderNode
	end
end

function StageNode:_changeRoot(newRoot)
	if newRoot == nil or self._root == newRoot then
		return
	end

	local oldRoot = self._root

	if oldRoot then
		oldRoot:_unregisterChildNode(self)
	end

	self._root = newRoot

	if newRoot then
		newRoot:_registerChildNode(self)
	end

	if not self.__isroot__ then
		local children = self._children

		if children then
			for i, subnode in ipairs(children) do
				subnode:_changeRoot(newRoot)
			end
		end
	end
end

function StageNode:displayChildNode(child, zorder)
	if child == nil then
		return
	end

	local renderMountPoint = self:getRenderMountPoint(child)
	local childRenderNode = child:getRenderNode()

	if renderMountPoint and childRenderNode and childRenderNode:getParent() == nil then
		local name = child:getName()

		if name ~= nil then
			childRenderNode:setName(name)
		end

		renderMountPoint:addChild(childRenderNode, zorder or 0)
	end
end

function StageNode:hideChildNode(child)
	if child == nil then
		return
	end

	local renderMountPoint = self:getRenderMountPoint(child)
	local childRenderNode = child:getRenderNode()

	if renderMountPoint and childRenderNode and childRenderNode:getParent() == renderMountPoint then
		renderMountPoint:removeChild(childRenderNode)
	end
end

function StageNode:addChild(child, zorder, name)
	if child == nil then
		return
	end

	local oldParent = child:getParent()

	if oldParent ~= nil then
		oldParent:removeChild(child)
	end

	local children = self._children

	if children == nil then
		children = {}
		self._children = children
	end

	children[#children + 1] = child

	child:setParent(self)

	if name ~= nil then
		child:setName(name)
	end

	child:_changeRoot(self.__isroot__ and self or self._root)
	self:displayChildNode(child, zorder)
end

function StageNode:removeChild(child)
	if child == nil then
		return
	end

	local children = self._children

	if children == nil then
		return
	end

	local removed

	for i, subnode in ipairs(children) do
		if subnode == child or subnode:getName() == child then
			removed = table.remove(children, i)

			break
		end
	end

	if removed then
		removed:_changeRoot(nil)
		self:hideChildNode(removed)
	end

	return removed
end

function StageNode:getChildByName(name)
	local children = self._children

	if children ~= nil then
		for i, subnode in ipairs(children) do
			if subnode:getName() == name then
				return subnode
			end
		end
	end

	return nil
end

function StageNode:getChildrenByName(name)
	local result = {}
	local children = self._children

	if children ~= nil then
		for i, subnode in ipairs(children) do
			if subnode:getName() == name then
				result[#result + 1] = subnode
			end
		end
	end

	return result
end

function StageNode:getChildById(id)
	local children = self._children

	for i, subnode in ipairs(children) do
		if subnode:getId() == id then
			return subnode
		end
	end
end

function StageNode:setId(id)
	if self._id == id then
		return
	end

	self._id = id

	local root = self._root

	if root then
		root:_registerChildNode(self)
	end
end

function StageNode:_registerChildNode(child)
	return
end

function StageNode:_unregisterChildNode(child)
	return
end

function StageNode.class:actionRegistry()
	local actions = rawget(self.__prototype__, "__actions__")

	if actions == nil then
		if self == StageNode then
			actions = {}
		else
			local superprototype = self.superclass.__prototype__

			actions = setmetatable({}, {
				__index = function(t, k)
					local superactions = superprototype.__actions__

					return superactions and superactions[k]
				end
			})
		end

		self.__actions__ = actions
	end

	return actions
end

function StageNode.class:defineAction(name, actionDefinition)
	local myactions = self:actionRegistry()

	myactions[name] = actionDefinition
end

function StageNode.class:extendActionsForClass(actions)
	if actions == nil then
		return
	end

	local myactions = self:actionRegistry()

	for name, actionGenerator in pairs(actions) do
		myactions[name] = actionGenerator
	end
end

function StageNode:extendActionsForObject(actions)
	if actions == nil then
		return
	end

	local myactions = self._actions

	if myactions == self.__actions__ or myactions == nil then
		myactions = setmetatable({}, {
			__index = self.__actions__
		})
		self._actions = myactions
	end

	for name, actionGenerator in pairs(actions) do
		myactions[name] = actionGenerator
	end
end

function StageNode:getActionDefinition(name)
	local actions = self._actions

	return actions and actions[name]
end

local acitons = {
	addNode = AddNode,
	updateNode = UpdateNode,
	activateNode = ActivateNode
}

StageNode:extendActionsForClass(acitons)

TouchType = {
	kMoved = "moved",
	kBegan = "began",
	kEnded = "ended"
}

function StageNode:setTouchEnabled(value)
	if value then
		self:registerTouchEvents()
	else
		self:unregisterTouchEvents()
	end
end

function StageNode:registerTouchEvents()
	if self._touchListener then
		return
	end

	if self._renderNode == nil then
		return
	end

	local renderNode = self._renderNode
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
	renderNode:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, renderNode)

	self._touchListener = listener
end

function StageNode:unregisterTouchEvents()
	if self._renderNode == nil then
		return
	end

	if self._touchListener then
		self._renderNode:getEventDispatcher():removeEventListener(self._touchListener)

		self._touchListener = nil
	end
end

function StageNode:dispatchTouchEvent(touchType, touch, event, data)
	if self._touchEvents and self._touchEvents[touchType] then
		local type = self._touchEvents[touchType]

		self:getDirector():dispatch(TouchEvent:new(type, touch, event, data))
	end
end

function StageNode:onTouchBegan(touch, event)
	if not self._renderNode:isVisible() then
		return false
	end

	local worldPt = touch:getLocation()
	local contentSize = self._renderNode:getContentSize()
	local rect = cc.rect(0, 0, contentSize.width, contentSize.height)
	local nodePt = self._renderNode:convertToNodeSpace(worldPt)

	if cc.rectContainsPoint(rect, nodePt) then
		self:dispatchTouchEvent(TouchType.kBegan, touch, event, data)

		return true
	end

	return false
end

function StageNode:onTouchMoved(touch, event)
	self:dispatchTouchEvent(TouchType.kMoved, touch, event, data)
end

function StageNode:onTouchEnded(touch, event)
	self:dispatchTouchEvent(TouchType.kEnded, touch, event, data)
end

function StageNode:setOpacityTo(cfg)
	local node = self:getRenderNode()

	if cfg.valbegin or cfg.valbegin == 0 then
		node:setOpacity(cfg.valbegin)
	end

	node:runAction(cc.FadeTo:create(cfg.duration, cfg.valend))
end
