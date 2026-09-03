-- chunkname: @/tmp/or_script/lua_compile/foundation/ccext/MovieClipExt.lua

MCGroupManager = MCGroupManager or {}

local timelineDriver = cc.MCTimelineDriver:getInstance()

function MCGroupManager:findTimelineGroup(groupName)
	if groupName == nil then
		return timelineDriver:getDefaultTimelineGroup()
	end

	if self._groups == nil then
		return nil
	end

	return self._groups[groupName]
end

function MCGroupManager:newTimelineGroup(groupName)
	if groupName == nil then
		return nil
	end

	if self._groups == nil then
		self._groups = {}
	end

	assert(self._groups[groupName] == nil)

	local group = cc.MCTimelineGroup:create()

	if group ~= nil then
		group:retain()
	end

	self._groups[groupName] = group

	return group
end

function MCGroupManager:getTimelineGroup(groupName)
	local group = self:findTimelineGroup(groupName)

	if group == nil and groupName ~= nil then
		group = self:newTimelineGroup(groupName)
	end

	return group
end

function MCGroupManager:clearAllGroups()
	if self._groups == nil then
		return
	end

	for name, group in pairs(self._groups) do
		group:release()
	end

	self._groups = nil
end

local MovieClip = cc.MovieClip

MovieClip.__raw_create = MovieClip.__raw_create or MovieClip.create

function MovieClip:create(libName, groupName)
	local obj = MovieClip:__raw_create(libName)

	if obj == nil then
		return nil
	end

	obj._libName = libName

	if groupName ~= nil then
		obj:setTimelineGroupByName(groupName)
	end

	return obj
end

function MovieClip:getLibName()
	return self._libName
end

function MovieClip:getGroupName()
	return self._groupName
end

function MovieClip:setTimelineGroupByName(name)
	local group = MCGroupManager:getTimelineGroup(name)

	if group ~= nil then
		self._groupName = name

		self:setTimelineGroup(group)
	else
		self._groupName = nil

		self:setTimelineGroup(nil)
	end
end

function MovieClip:setLuaEndCallback(func)
	if self.__endCall__ ~= nil and self.__endCall__ ~= 0 then
		self:removeCallback(self.__endCall__)

		self.__endCall__ = nil
	end

	if func ~= nil then
		self.__endCall__ = self:addEndCallback(function(fid, mc, ...)
			func(mc, ...)
		end)
	end
end

MovieClip.__raw_setScriptInterpreter = MovieClip.__raw_setScriptInterpreter or MovieClip.setScriptInterpreter

function MovieClip:setScriptInterpreter(func)
	self:setIsScriptEnabled(func ~= nil)
	MovieClip.__raw_setScriptInterpreter(self, func)
end
