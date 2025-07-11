﻿-- chunkname: @IQIGame\\Events\\EventDispatcher.lua

EventDispatcher = {
	EventHandlers = {}
}

function EventDispatcher.AddEventListener(stype, eventHandler)
	if stype == nil or eventHandler == nil then
		error("AddEventListener error : params can not be nil.", 2)

		return
	end

	if type(stype) ~= "string" or type(eventHandler) ~= "function" then
		error("AddEventListener error : type error.", 2)

		return
	end

	local handlers = EventDispatcher.EventHandlers[stype]

	if handlers == nil then
		handlers = {
			eventHandler
		}
		EventDispatcher.EventHandlers[stype] = handlers
	else
		for i = 1, #handlers do
			if handlers[i] == eventHandler then
				return
			end
		end

		table.insert(handlers, eventHandler)
	end
end

function EventDispatcher.RemoveEventListener(stype, eventHandler)
	if stype == nil or eventHandler == nil then
		error("RemoveEventListeners error : params can not be nil.", 2)

		return
	end

	if type(stype) ~= "string" or type(eventHandler) ~= "function" then
		error("RemoveEventListeners error : type error ", 2)

		return
	end

	local handlers = EventDispatcher.EventHandlers[stype]
	local funcIndex = -1

	if handlers ~= nil and #handlers > 0 then
		for i = 1, #handlers do
			if handlers[i] == eventHandler then
				funcIndex = i

				break
			end
		end

		if funcIndex ~= -1 then
			table.remove(handlers, funcIndex)
		end
	end
end

function EventDispatcher.Dispatch(stype, ...)
	if stype == nil then
		error("Dispatcher error : params can not be nil.", 2)

		return
	end

	if type(stype) ~= "string" then
		error("Dispatcher error : stype error", 2)

		return
	end

	local handlers = EventDispatcher.EventHandlers[stype]

	if handlers == nil or #handlers <= 0 then
		return
	end

	local tempTable = table.clone(handlers)

	for i, v in ipairs(tempTable) do
		v(...)
	end
end
