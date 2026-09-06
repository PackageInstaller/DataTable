-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/model/TimeCheckCacheQueue.lua

module("logic.extensions.mainui.model.TimeCheckCacheQueue", package.seeall)

local TimeCheckCacheQueue = class("TimeCheckCacheQueue")

function TimeCheckCacheQueue:ctor()
	self:reset()
end

function TimeCheckCacheQueue:reset()
	self._queue = {}
	self._index = 0
	self._bRemoving = false
end

function TimeCheckCacheQueue:pushBack(info, cd, ignoreCD)
	if checknumber(cd) ~= 0 or ignoreCD then
		self._index = self._index + 1

		local data = {
			info = info,
			cd = cd,
			key = self._index
		}

		table.insert(self._queue, data)

		return self._index, data
	else
		printWarn("insert to queue failed. cd is nil or 0", debug.traceback())
	end
end

function TimeCheckCacheQueue:getQueue()
	return self._queue
end

function TimeCheckCacheQueue:popFront(time)
	if time == nil or time <= 0 then
		return
	end

	local info

	while info == nil and #self._queue > 0 do
		if self._bRemoving then
			return nil, true
		end

		local data = self._queue[1]

		table.remove(self._queue, 1)

		if time <= data.cd then
			info = data.info
		end
	end

	return info
end

function TimeCheckCacheQueue:remove(index)
	self._bRemoving = true

	local bFound = false
	local target

	for i, data in pairs(self._queue) do
		if data.key == index then
			target = table.remove(self._queue, i, 1)
			bFound = true

			break
		end
	end

	self._bRemoving = false

	return bFound, target
end

return TimeCheckCacheQueue
