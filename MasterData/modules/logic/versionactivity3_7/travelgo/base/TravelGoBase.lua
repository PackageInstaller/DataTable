-- chunkname: @modules/logic/versionactivity3_7/travelgo/base/TravelGoBase.lua

module("modules.logic.versionactivity3_7.travelgo.base.TravelGoBase", package.seeall)

local TravelGoBase = class("TravelGoBase")

function TravelGoBase:ctor(data)
	self.isAwake = false
	self.isEnable = false
	self.parent = nil
	self._components = nil
	self.__eventTbs = nil

	function self._trackback(...)
		return self:trackback(...)
	end

	if data then
		self:setData(data)
	end
end

function TravelGoBase:onSetData(data)
	return
end

function TravelGoBase:onAwake()
	return
end

function TravelGoBase:onEnable()
	return
end

function TravelGoBase:onDisable()
	return
end

function TravelGoBase:onDispose()
	return
end

function TravelGoBase:setData(data)
	self.data = data

	xpcall(self.onSetData, self._trackback, self, data)
end

function TravelGoBase:awake(isEnable)
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

function TravelGoBase:enable()
	if self.isEnable then
		return
	end

	self.isEnable = true

	xpcall(self.onEnable, self._trackback, self)

	local comps = self:getComponents()

	for i, v in ipairs(comps) do
		if not v.isEnable then
			v:enable()
		end
	end
end

function TravelGoBase:disable()
	if not self.isEnable then
		return
	end

	local comps = self:getComponents()

	for i, v in ipairs(comps) do
		if v.isEnable then
			v:disable()
		end
	end

	if self.__eventTbs then
		for _, evtInfo in ipairs(self.__eventTbs) do
			evtInfo[1]:unregisterCallback(evtInfo[2], evtInfo[3], evtInfo[4])
			logWarn("TravelGoBase 清空事件监听 ", tostring(evtInfo[1]), tostring(evtInfo[2]), tostring(evtInfo[3]), tostring(evtInfo[4]))
		end

		self.__eventTbs = nil
	end

	self.isEnable = false

	xpcall(self.onDisable, self._trackback, self)
end

function TravelGoBase:dispose()
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

	xpcall(self.onDispose, self._trackback, self)

	self.isAwake = false
end

function TravelGoBase:addComponentByObject(travelGoBase)
	travelGoBase:setParentComponent(self)

	local comps = self:getComponents()

	table.insert(comps, travelGoBase)

	if self.isAwake then
		travelGoBase:awake(self.isEnable)
	end

	if self.isEnable then
		travelGoBase:enable()
	end

	return travelGoBase
end

function TravelGoBase:setParentComponent(travelGoBase)
	self.parent = travelGoBase
end

function TravelGoBase:getComponents()
	self._components = self._components or {}

	return self._components
end

function TravelGoBase:addEventCb(ctrlInstance, evtName, callback, cbObj, priority)
	if not ctrlInstance or not evtName or not callback then
		logError("UserDataDispose:addEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	ctrlInstance:registerCallback(evtName, callback, cbObj, priority)

	if self.__eventTbs == nil then
		self.__eventTbs = {}
	end

	for _, evtInfo in ipairs(self.__eventTbs) do
		if evtInfo[1] == ctrlInstance and evtInfo[2] == evtName and evtInfo[3] == callback and evtInfo[4] == cbObj then
			return
		end
	end

	table.insert(self.__eventTbs, {
		ctrlInstance,
		evtName,
		callback,
		cbObj
	})
end

function TravelGoBase:removeEventCb(ctrlInstance, evtName, callback, cbObj)
	if not ctrlInstance or not evtName or not callback then
		logError("UserDataDispose:removeEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	if self.__eventTbs then
		for i, evtInfo in ipairs(self.__eventTbs) do
			if evtInfo[1] == ctrlInstance and evtInfo[2] == evtName and evtInfo[3] == callback and evtInfo[4] == cbObj then
				table.remove(self.__eventTbs, i)

				break
			end
		end
	end

	ctrlInstance:unregisterCallback(evtName, callback, cbObj)
end

function TravelGoBase:trackback(msg)
	__G__TRACKBACK__(msg)
end

return TravelGoBase
