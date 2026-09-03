-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/widgets/LoopWidget.lua

LoopDir = {
	kRight = 2,
	kDown = 4,
	kLeft = 1,
	kUp = 3
}
LoopWidget = class("LoopWidget", _G.DisposableObject, _M)

function LoopWidget:initialize(config)
	super.initialize(self)

	self._config = config
	self._winSize = config.size
	self._itemInterval = config.interval
	self._loopDir = config.loopDir
	self._startPos = config.startPos
	self._res = config.res
	self._speed = config.speed
	self._items = Queue:new()

	function self._items:getElementByIndex(index)
		return self._elements[index]
	end

	self._view = self:setupView(config)
end

function LoopWidget:dispose()
	self:stop()
	super.dispose(self)
end

function LoopWidget:getView()
	return self._view
end

function LoopWidget:reverse()
	if self._items then
		self:pause()

		if self._loopDir == LoopDir.kLeft then
			self._loopDir = LoopDir.kRight
		elseif self._loopDir == LoopDir.kRight then
			self._loopDir = LoopDir.kLeft
		elseif self._loopDir == LoopDir.kUp then
			self._loopDir = LoopDir.kDown
		elseif self._loopDir == LoopDir.kDown then
			self._loopDir = LoopDir.kUp
		end

		local tmp = {}

		for i = 1, self._items:size() do
			tmp[#tmp + 1] = self._items:popFront()
		end

		for i = #tmp, 1, -1 do
			self._items:pushBack(tmp[i])
		end

		self:resume()
	end
end

function LoopWidget:setupView(config)
	local windowSize = self._winSize
	local view = ccui.Layout:create()

	view:setContentSize(windowSize)
	view:setClippingEnabled(true)

	local interval = self._itemInterval
	local loopDir = self._loopDir
	local startPos = self._startPos
	local res = self._res
	local items = self._items

	function items:getElementByIndex(index)
		return self._elements[index]
	end

	local ws, intervalX, intervalY

	if loopDir == LoopDir.kLeft then
		ws = windowSize.width
		intervalX = interval
		intervalY = 0
	elseif loopDir == LoopDir.kRight then
		ws = windowSize.width
		intervalX = -interval
		intervalY = 0
	elseif loopDir == LoopDir.kUp then
		ws = windowSize.height
		intervalX = 0
		intervalY = -interval
	elseif loopDir == LoopDir.kDown then
		ws = windowSize.height
		intervalX = 0
		intervalY = interval
	end

	local itemCount = math.ceil(ws / interval) + 1

	for i = 1, itemCount do
		local item = cc.Sprite:create(res)

		item:setAnchorPoint(cc.p(0, 0))
		item:addTo(view):posite(startPos.x + (i - 1) * intervalX, startPos.y + (i - 1) * intervalY)
		items:pushBack(item)
	end

	return view
end

function LoopWidget:play()
	local function update(task, dt)
		local items = self._items
		local speed = self._speed
		local loopDir = self._loopDir
		local interval = self._itemInterval
		local windowSize = self._winSize
		local fontItem = items:front()
		local distance = dt * speed
		local anchor = fontItem:getAnchorPoint()
		local x, y = fontItem:getPosition()
		local size = fontItem:getContentSize()
		local ws, intervalX, intervalY, offsetX, offsetY, isLoop

		if loopDir == LoopDir.kLeft then
			ws = windowSize.width
			intervalX = interval
			intervalY = 0
			offsetX = -distance
			offsetY = 0
			isLoop = x - anchor.x * size.width + -distance + interval <= 0
		elseif loopDir == LoopDir.kRight then
			ws = windowSize.width
			intervalX = -interval
			intervalY = 0
			offsetX = distance
			offsetY = 0
			isLoop = windowSize.width <= x + (1 - anchor.x) * size.width + distance - interval
		elseif loopDir == LoopDir.kUp then
			intervalX = 0
			intervalY = -interval
			offsetX = 0
			offsetY = distance
			isLoop = windowSize.height <= y + (1 - anchor.y) * size.height + distance - interval
		elseif loopDir == LoopDir.kDown then
			ws = windowSize.height
			intervalX = 0
			intervalY = interval
			offsetX = 0
			offsetY = -distance
			isLoop = y - anchor.y * size.height + -distance + interval <= 0
		end

		if isLoop then
			local fontItem = items:popFront()

			items:pushBack(fontItem)
		end

		for i = 1, items:size() do
			local item = items:getElementByIndex(i)

			if i == 1 then
				item:offset(offsetX, offsetY)
			else
				local fontItem = items:front()

				item:posite(fontItem:getPositionX() + (i - 1) * intervalX, fontItem:getPositionY() + (i - 1) * intervalY)
			end
		end
	end

	self:stop()

	self._scheduler = LuaScheduler:new()

	self._scheduler:start()
	self._scheduler:schedule(update, 0)
end

function LoopWidget:pause()
	if self._scheduler then
		self._scheduler:pause()
	end
end

function LoopWidget:resume()
	if self._scheduler then
		self._scheduler:resume()
	end
end

function LoopWidget:stop()
	if self._scheduler then
		self._scheduler:stop()

		self._scheduler = nil
	end
end

LoopGroupWidget = class("LoopGroupWidget", _G.DisposableObject, _M)

function LoopGroupWidget:initialize(config)
	super.initialize(self)

	self._loopNodes = {}
	self._view = self:setupView(config)
end

function LoopGroupWidget:dispose()
	self:stop()
	super.dispose(self)
end

function LoopGroupWidget:getView()
	return self._view
end

function LoopGroupWidget:setupView(config)
	local size = config.size
	local loopDir = config.loopDir
	local interval = config.interval

	if not config.speed then
		local view = ccui.Layout:create()

		view:setContentSize(size)

		for _, loopNodeConfig in ipairs(config.loopNodes) do
			loopNodeConfig.size = loopNodeConfig.size or size
			loopNodeConfig.loopDir = loopNodeConfig.loopDir or loopDir
			loopNodeConfig.interval = loopNodeConfig.interval or interval

			if not loopNodeConfig.speedRatio then
				local speedRatio = 1

				loopNodeConfig.speed = loopNodeConfig.speed or speedRatio * config.speed

				local loopWidget = LoopWidget:new(loopNodeConfig)
				local loopNode = loopWidget:getView()

				loopNode:setAnchorPoint(0, 0)
				loopNode:addTo(view)

				self._loopNodes[#self._loopNodes + 1] = loopWidget
			end
		end

		return view
	end
end

function LoopGroupWidget:reverse()
	for _, loopWidget in ipairs(self._loopNodes) do
		loopWidget:reverse()
	end
end

function LoopGroupWidget:play()
	for _, loopWidget in ipairs(self._loopNodes) do
		loopWidget:play()
	end
end

function LoopGroupWidget:pause()
	for _, loopWidget in ipairs(self._loopNodes) do
		loopWidget:pause()
	end
end

function LoopGroupWidget:resume()
	for _, loopWidget in ipairs(self._loopNodes) do
		loopWidget:resume()
	end
end

function LoopGroupWidget:stop()
	for _, loopWidget in ipairs(self._loopNodes) do
		loopWidget:stop()
	end
end
