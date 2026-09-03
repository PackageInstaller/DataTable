-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/view/TreeView.lua

EVT_TREE_NODE_CHANGED = "EVT_TREE_NODE_CHANGED"
EVT_TREE_NODE_SELECTED = "EVT_TREE_NODE_SELECTED"
TreeDelegate = TreeDelegate or {}

function TreeDelegate:new()
	local result = setmetatable({}, {
		__index = TreeDelegate
	})

	result:initialize()

	return result
end

function TreeDelegate:initialize()
	self._clickCallBack = nil
end

function TreeDelegate:setClickCallBack(callback)
	self._clickCallBack = callback
end

Tree = class("Tree", BaseWidget, _M)

Tree:has("_eventDispatcher", {
	is = "r"
})

function Tree:initialize(view)
	super.initialize(self, view)

	self._eventDispatcher = EventDispatcher:new()
	self._rootNode = nil
end

function Tree:dispose()
	super.dispose(self)

	if self._rootNode then
		self._rootNode:removeAllChildren()

		self._rootNode = nil
	end

	if self._eventDispatcher ~= nil then
		self._eventDispatcher:clearAllListeners()

		self._eventDispatcher = nil
	end
end

function Tree:createRoot(node, name, space, isHide)
	if not self._rootNode then
		self._rootNode = TreeNode:new(node, name, space, isHide, self._eventDispatcher)

		local posY = self:getView():getContentSize().height

		self._height = node:getContentSize().height

		self:getView():addChild(self._rootNode:getView())
		self._rootNode:setPosition(cc.p(0, posY - self._height))
		self:getEventDispatcher():addEventListener(EVT_TREE_NODE_CHANGED, self, self.handleUpdate, false, 0)
		self:getEventDispatcher():addEventListener(EVT_TREE_NODE_SELECTED, self, self.handleNodeSelect, false, 0)
	end
end

function Tree:addFirstLayer(node, strName, space, isHide)
	if self._rootNode then
		local firstNode = TreeNode:new(node, strName, space, isHide, self._eventDispatcher)

		self._rootNode:addNode(firstNode)

		return firstNode
	end

	return nil
end

function Tree:addSecondLayer(node, secondIdx, strName, space, isHide)
	if self._rootNode then
		local firstNode = self._rootNode:getNodeByIndex(secondIdx)

		if firstNode then
			local secNode = TreeNode:new(node, strName, space, isHide, self._eventDispatcher)

			firstNode:addNode(secNode)

			return secNode
		end
	end

	return nil
end

function Tree:getRootNode()
	return self._rootNode
end

function Tree:handleUpdate(event)
	local newHeight = 0

	if self._rootNode then
		local cSize = self:getView():getContentSize()

		newHeight = self._rootNode:getListHeight()

		self:getView():setInnerContainerSize(cc.size(cSize.width, newHeight))

		if newHeight < cSize.height then
			self._rootNode:setPosition(cc.p(0, cSize.height - self._height))
		else
			self._rootNode:setPosition(cc.p(0, newHeight - self._height))
		end

		self._rootNode:updateList()
	end
end

function Tree:handleNodeSelect(event)
	local percent = event:getData()
	local scrollView = self:getView()
	local innerSize = scrollView:getInnerContainerSize()
	local minY = scrollView:getContentSize().height - innerSize.height

	scrollView:jumpToPercentVertical(math.min(math.abs(percent / minY), 1) * 100)
end

function Tree:jumpToByPos(percent)
	local scrollView = self:getView()
	local innerSize = scrollView:getInnerContainerSize()
	local minY = scrollView:getContentSize().height - innerSize.height

	scrollView:jumpToPercentVertical(math.min(math.abs(percent / minY), 1) * 100)
end

TreeNode = class("TreeNode", BaseWidget, _M)

function TreeNode:initialize(view, name, space, isHide, treeEventDispatcher)
	super.initialize(self, view)

	self._treeEventDispatcher = treeEventDispatcher
	self._userdata = {}
	self._clickEvent = nil
	self._clickContext = nil

	self:init(view, name, space, isHide)
	self:setTouchEvent()
end

function TreeNode:dispose()
	super.dispose(self)
	self._nodeContainer:release()

	self._nodeContainer = nil
end

function TreeNode:init(view, name, space, isHide)
	self._w = view:getContentSize().width
	self._h = view:getContentSize().height
	self._name = name
	self._isOpen = true
	self._isHide = isHide
	self._pNode = nil
	self._nodeArr = {}
	self._space = space
	self._selected = false
	self._touchListener = nil
	self._nodeContainer = ccui.Layout:create()

	self._nodeContainer:setAnchorPoint(cc.p(0, 0))
	self._nodeContainer:addTo(self:getView()):setPosition(cc.p(0, 0))
	self._nodeContainer:retain()
end

function TreeNode:setUserData(data)
	self._userdata = data
end

function TreeNode:registClickEvent(event, contex)
	self._clickEvent = event
	self._clickContext = contex
end

function TreeNode:setTouchEvent()
	if self._touchListener then
		return
	end

	self:getView():addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			-- block empty
		elseif eventType == ccui.TouchEventType.canceled then
			-- block empty
		elseif eventType == ccui.TouchEventType.ended then
			if #self._nodeArr > 0 then
				local pNode = self._pNode

				pNode:closeChildList()

				if not self._isOpen then
					self:openList()
				end
			end

			if self._clickEvent and self._clickContext then
				self._clickEvent(self._clickContext, self._userdata)

				if self._treeEventDispatcher then
					local touchPos = self:getView():getPositionY()
					local height = self:getView():getContentSize().height
					local per = math.abs(touchPos) - height

					if #self._nodeArr > 0 then
						self._treeEventDispatcher:dispatchEvent(Event:new(EVT_TREE_NODE_SELECTED, per))
					end
				end
			end
		end
	end)
end

function TreeNode:selectedHandler(event)
	if #self._nodeArr > 0 then
		return
	end
end

function TreeNode:updateList()
	self:cleanList()

	local currentNode, prevNode

	for i = 1, #self._nodeArr do
		currentNode = self._nodeArr[i]

		self._nodeArr[i]:updateList()

		if i == 1 then
			currentNode:setPositionY(-currentNode:getContentSize().height)
		else
			prevNode = self._nodeArr[i - 1]

			local nextPosY = self._nodeArr[i - 1]:getPositionY() - self._nodeArr[i - 1]:getContentSize().height - self._space

			if prevNode:isOpen() then
				nextPosY = nextPosY - prevNode._nodeContainer:getContentSize().height
			end

			currentNode:setPositionY(nextPosY)
		end

		self._nodeContainer:addChild(currentNode:getView())
	end
end

function TreeNode:runAction(move, fade)
	if self._isRunAction then
		return
	end

	self._isRunAction = true

	local callbackFunc = cc.CallFunc:create(function()
		self._isRunAction = false
	end)
	local action = cc.Speed:create(cc.Spawn:create(move, fade, callbackFunc), 1)

	self:getView():runAction(action)
end

function TreeNode:cleanList()
	for i = 1, #self._nodeArr do
		local node = self._nodeArr[i]

		if node then
			self._nodeContainer:removeChild(node:getView(), false)
		end
	end
end

function TreeNode:isOpen()
	return self._isOpen
end

function TreeNode:setPosition(pos)
	self:getView():setPosition(pos)
end

function TreeNode:setPositionX(posx)
	self:getView():setPositionX(posx)
end

function TreeNode:getPositionX()
	return self:getView():getPositionX()
end

function TreeNode:setPositionY(y)
	self:getView():setPositionY(y)
end

function TreeNode:getPositionY()
	return self:getView():getPositionY()
end

function TreeNode:getContentSize()
	return self:getView():getContentSize()
end

function TreeNode:getNodeByIndex(index)
	if index < 0 or index > #self._nodeArr then
		return nil
	end

	return self._nodeArr[index]
end

function TreeNode:addNode(node)
	local posX = (self:getContentSize().width - node._w) / 2

	if #self._nodeArr > 0 then
		node:setPosition(cc.p(posX, self._nodeArr[#self._nodeArr]:getPositionY() - node._h - node._space))
	else
		node:setPosition(cc.p(posX, 0))
	end

	node._pNode = self

	local heightOffset = self._nodeContainer:getContentSize().height + node:getContentSize().height + self._space
	local width = node:getContentSize().width

	self._nodeContainer:setContentSize(cc.size(width, heightOffset))
	self._nodeContainer:addChild(node:getView())

	self._nodeArr[#self._nodeArr + 1] = node

	if self._treeEventDispatcher then
		self._treeEventDispatcher:dispatchEvent(Event:new(EVT_TREE_NODE_CHANGED))
	end
end

function TreeNode:getListHeight()
	local height = 0

	for i = 1, #self._nodeArr do
		local node = self._nodeArr[i]

		height = height + node:getContentSize().height + self._space

		if node._isOpen then
			height = height + node:getListHeight()
		end
	end

	return height
end

function TreeNode:selected()
	self._bSelected = true

	if #self._nodeArr > 0 then
		return
	end
end

function TreeNode:unSelected()
	self._bSelected = false
end

function TreeNode:openList()
	self._isOpen = true

	self:getView():addChild(self._nodeContainer)

	if self._treeEventDispatcher then
		self._treeEventDispatcher:dispatchEvent(Event:new(EVT_TREE_NODE_CHANGED))
	end
end

function TreeNode:closeList()
	self._isOpen = false

	self:getView():removeChild(self._nodeContainer, false)

	if self._treeEventDispatcher then
		self._treeEventDispatcher:dispatchEvent(Event:new(EVT_TREE_NODE_CHANGED))
	end
end

function TreeNode:closeChildList()
	for i = 1, #self._nodeArr do
		self._nodeArr[i]:closeList()
	end
end
