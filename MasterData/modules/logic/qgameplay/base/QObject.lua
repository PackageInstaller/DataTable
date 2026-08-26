-- chunkname: @modules/logic/qgameplay/base/QObject.lua

module("modules.logic.qgameplay.base.QObject", package.seeall)

local QObject = class("QObject")

function QObject:ctor(...)
	self.isAwake = false
	self.isEnable = false
	self.parent = nil
	self._components = nil
	self._eventsDic = nil
	self._timersDic = nil

	function self._trackback(...)
		return self:trackback(...)
	end

	if ... then
		self._data = {
			...
		}
	end
end

function QObject:onAwake()
	return
end

function QObject:onEnable()
	return
end

function QObject:onSetData(...)
	return
end

function QObject:onDisable()
	return
end

function QObject:onDispose()
	return
end

function QObject:awake(isEnable)
	if isEnable == nil then
		isEnable = true
	end

	if self.isAwake then
		return
	end

	self.isAwake = true

	xpcall(self.onAwake, self._trackback, self)

	if isEnable then
		self:enable()
	end

	local comps = self:getComponents()

	for i, v in ipairs(comps) do
		if not v.isAwake then
			v:awake(isEnable)
		end
	end
end

function QObject:enable()
	if self.isEnable then
		return
	end

	if not self.isAwake then
		self:awake()
	end

	self.isEnable = true

	local comps = self:getComponents()

	for i, v in ipairs(comps) do
		if not v.isEnable then
			v:enable()
		end
	end

	xpcall(self.onEnable, self._trackback, self)
	xpcall(self.onSetData, self._trackback, self, unpack(self._data or {}))
end

function QObject:setData(...)
	self._data = {
		...
	}

	xpcall(self.onSetData, self._trackback, self, ...)
end

function QObject:disable()
	if not self.isEnable then
		return
	end

	local comps = self:getComponents()

	for i, v in ipairs(comps) do
		if v.isEnable then
			v:disable()
		end
	end

	self:cleanEventsByPos(1)
	self:cleanTimersByPos(1)

	self.isEnable = false

	xpcall(self.onDisable, self._trackback, self)

	return true
end

function QObject:dispose()
	if self.isEnable then
		self:disable()
	end

	local comps = self:getComponents()

	for i = #comps, 1, -1 do
		local comp = comps[i]

		comp:dispose()
	end

	if self._components then
		tabletool.clear(self._components)
	end

	self:cleanEventsByPos(2)
	self:cleanTimersByPos(2)
	xpcall(self.onDispose, self._trackback, self)

	self.isAwake = false
end

function QObject:addComponentByObject(baseObj)
	baseObj:setParentComponent(self)

	local comps = self:getComponents()

	table.insert(comps, baseObj)

	if self.isAwake then
		baseObj:awake(self.isEnable)
	end

	return baseObj
end

function QObject:setParentComponent(baseObj)
	self.parent = baseObj
end

function QObject:getComponents()
	self._components = self._components or {}

	return self._components
end

function QObject:addEventCb(ctrlInstance, evtName, callback, cbObj, priority)
	if not ctrlInstance or not evtName or not callback then
		logError("QObject:addEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	local t = self:getEventTbs()

	self:addEventCb2(t, ctrlInstance, evtName, callback, cbObj, priority)
end

function QObject:getEventTbs()
	self._eventsDic = self._eventsDic or {}

	return self:getEventsTbsByState()
end

function QObject:getEventsTbsByState()
	local key = self.isEnable and 1 or 2

	self._eventsDic[key] = self._eventsDic[key] or {}

	return self._eventsDic[key]
end

function QObject:addEventCb2(eventTbs, ctrlInstance, evtName, callback, cbObj, priority)
	for _, evtInfo in ipairs(eventTbs) do
		if evtInfo[1] == ctrlInstance and evtInfo[2] == evtName and evtInfo[3] == callback and evtInfo[4] == cbObj then
			return
		end
	end

	ctrlInstance:registerCallback(evtName, callback, cbObj, priority)
	table.insert(eventTbs, {
		ctrlInstance,
		evtName,
		callback,
		cbObj
	})
end

function QObject:removeEventCb(ctrlInstance, evtName, callback, cbObj)
	if not ctrlInstance or not evtName or not callback then
		logError("QObject:removeEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	if not self._eventsDic then
		return
	end

	for k, t in pairs(self._eventsDic) do
		if self:removeEventCb2(t, ctrlInstance, evtName, callback, cbObj) then
			return true
		end
	end
end

function QObject:removeEventCb2(eventTbs, ctrlInstance, evtName, callback, cbObj)
	if eventTbs then
		for i, evtInfo in ipairs(eventTbs) do
			if evtInfo[1] == ctrlInstance and evtInfo[2] == evtName and evtInfo[3] == callback and evtInfo[4] == cbObj then
				table.remove(eventTbs, i)
				ctrlInstance:unregisterCallback(evtName, callback, cbObj)

				return true
			end
		end
	end
end

function QObject:cleanEventsByPos(pos)
	if self._eventsDic and self._eventsDic[pos] then
		local eventTbs = self._eventsDic[pos]

		for _, evtInfo in ipairs(eventTbs) do
			evtInfo[1]:unregisterCallback(evtInfo[2], evtInfo[3], evtInfo[4])
		end

		self._eventsDic[pos] = nil
	end
end

function QObject:runDelay(callback, cbObj, delay)
	self:recordTimer(callback, cbObj)
	TaskDispatcher.runDelay(callback, cbObj, delay)
end

function QObject:runRepeat(callback, cbObj, delay)
	self:recordTimer(callback, cbObj)
	TaskDispatcher.runRepeat(callback, cbObj, delay)
end

function QObject:getTimerTbs()
	self._timersDic = self._timersDic or {}

	return self:getTimersByState()
end

function QObject:getTimersByState()
	local key = self.isEnable and 1 or 2

	self._timersDic[key] = self._timersDic[key] or {}

	return self._timersDic[key]
end

function QObject:recordTimer(callback, cbObj)
	local t = self:getTimerTbs()
	local info = {
		cbObj = cbObj,
		callback = callback
	}

	table.insert(t, info)
end

function QObject:cancelTask(callback, cbObj)
	if not self._timersDic then
		return
	end

	for k, t in pairs(self._timersDic) do
		if self:cancelTask2(t, callback, cbObj) then
			return true
		end
	end
end

function QObject:cancelTask2(t, callback, cbObj)
	if not t then
		return
	end

	for i, v in ipairs(t) do
		if v.cbObj == cbObj and v.callback == callback then
			table.remove(t, i)
			TaskDispatcher.cancelTask(callback, cbObj)

			return true
		end
	end
end

function QObject:cleanTimersByPos(pos)
	if self._timersDic and self._timersDic[pos] then
		local t = self._timersDic[pos]

		for i, info in ipairs(t) do
			TaskDispatcher.cancelTask(info.callback, info.cbObj)
		end

		self._timersDic[pos] = nil
	end
end

function QObject:trackback(msg)
	__G__TRACKBACK__(msg)
end

return QObject
