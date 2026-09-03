-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/basis/BattleEventDispatcher.lua

function MAKE_EventDispatcher(clazz)
	if clazz then
		if not clazz.class then
			local metaclass = clazz
			local original_new = metaclass.new

			function metaclass:new(...)
				local instance = original_new(self, ...)

				instance["$eventListeners"] = {}

				return instance
			end

			function clazz:addListener(event, listener, priority)
				local listenerList = self["$eventListeners"][event]

				if listenerList == nil then
					listenerList = PrioritizedListeners:new()
					self["$eventListeners"][event] = listenerList
				end

				listenerList:add(listener, priority)
			end

			function clazz:removeListener(event, listener)
				local eventListeners = self["$eventListeners"]
				local listenerList = eventListeners and eventListeners[event]

				if listenerList == nil then
					return
				end

				listenerList:remove(listener)
			end

			function clazz:dispatchEvent(event, ...)
				local eventListeners = self["$eventListeners"]
				local listenerList = eventListeners and eventListeners[event]

				if listenerList == nil then
					return
				end

				listenerList:fire(event, ...)
			end

			return clazz
		end
	end
end

BattleEventDispatcher = class("BattleEventDispatcher")

MAKE_EventDispatcher(BattleEventDispatcher)
