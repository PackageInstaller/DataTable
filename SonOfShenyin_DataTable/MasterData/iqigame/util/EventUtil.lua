-- chunkname: @IQIGame\\Util\\EventUtil.lua

EventUtil = {
	EventProxyNameTemplate = "__delegateOn%sProxy",
	EventHandlerNameTemplate = "__On%sHandler"
}

function EventUtil.HasEventListener(owner, eventName)
	if owner.__delegateProxyTable == nil then
		return false
	end

	local delegateProxyFunc = owner.__delegateProxyTable[eventName]

	if delegateProxyFunc ~= nil then
		return true
	end

	return false
end

function EventUtil.AddEventListener(owner, eventName, customHandler)
	if owner.__delegateProxyTable == nil then
		owner.__delegateProxyTable = {}
	end

	local delegateProxyFunc = owner.__delegateProxyTable[eventName]

	if delegateProxyFunc ~= nil then
		logError("table {0} 重复注册事件 {1}", owner, eventName)

		return
	end

	function delegateProxyFunc(...)
		local handler = customHandler

		if handler == nil then
			local handlerFuncName = EventUtil.GetEventHandlerFuncName(eventName)

			handler = owner[handlerFuncName]

			if handler == nil then
				logError("未找到注册事件 {0} 回调处理函数 {1}", eventName, handlerFuncName)

				return
			end
		end

		handler(owner, unpack({
			...
		}))
	end

	owner.__delegateProxyTable[eventName] = delegateProxyFunc

	EventDispatcher.AddEventListener(eventName, delegateProxyFunc)
end

function EventUtil.RemoveEventListener(owner, eventName)
	local delegateProxyTable = owner.__delegateProxyTable

	if delegateProxyTable == nil then
		return
	end

	local delegateProxyFunc = delegateProxyTable[eventName]

	if delegateProxyFunc == nil then
		return
	end

	EventDispatcher.RemoveEventListener(eventName, delegateProxyFunc)

	owner.__delegateProxyTable[eventName] = nil
end

function EventUtil.ClearEventListener(owner)
	local delegateProxyTable = owner.__delegateProxyTable

	ForPairs(delegateProxyTable, function(_eventName, _delegateProxyFunc)
		EventDispatcher.RemoveEventListener(_eventName, _delegateProxyFunc)
	end)

	owner.__delegateProxyTable = nil
end

function EventUtil.GetEventHandlerFuncName(eventName)
	return string.format(EventUtil.EventHandlerNameTemplate, eventName)
end
