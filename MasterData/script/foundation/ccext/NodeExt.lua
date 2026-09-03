-- chunkname: @/tmp/or_script/lua_compile/foundation/ccext/NodeExt.lua

if not _G.cc then
	_G.cc.BlendMode = {
		kAdd = 1,
		kNormal = 0
	}

	local function RawMethod(cls, methodName)
		local rawMethods = cls.__rawMethods

		if rawMethods == nil then
			rawMethods = {}
			cls.__rawMethods = rawMethods
		end

		local method = rawMethods[methodName]

		if method == nil then
			method = cls[methodName]
			rawMethods[methodName] = cls[methodName]
		end

		return method
	end

	if not _G.cc.Node then
		local Node = CCNode
		local rawRegisterScriptHandler = RawMethod(Node, "registerScriptHandler")

		function Node:registerScriptHandler(callback)
			local node = self

			if callback == nil then
				return
			end

			local handlers = node.__scriptHandlers

			if handlers == nil then
				handlers = {}
				node.__scriptHandlers = handlers

				rawRegisterScriptHandler(node, function(eventType)
					if node.__scriptHandlers then
						local handlers = {}

						for i, v in ipairs(node.__scriptHandlers) do
							handlers[i] = v
						end

						for _, callback in ipairs(handlers) do
							callback(eventType)
						end
					end
				end)
			end

			handlers[#handlers + 1] = callback
		end

		local rawUnregisterScriptHandler = RawMethod(Node, "unregisterScriptHandler")

		function Node:unregisterScriptHandler(callback)
			local node = self
			local handlers = node.__scriptHandlers

			if handlers == nil then
				return
			end

			if callback ~= nil then
				local len = #handlers

				for i = len, 1, -1 do
					local func = handlers[i]

					if func == callback then
						table.remove(handlers, i)
					end
				end
			end

			if callback == nil or #handlers == 0 then
				rawUnregisterScriptHandler(node)

				node.__scriptHandlers = nil
			end
		end

		function Node:atExit(callback)
			local node = self
			local handlers = node.__exitCallbacks

			if handlers == nil then
				handlers = {}
				node.__exitCallbacks = handlers

				self:registerScriptHandler(function(eventType)
					if eventType == "exit" then
						local handlers = node.__exitCallbacks

						if handlers then
							for _, callback in ipairs(handlers) do
								callback(node)
							end
						end

						node.__exitCallbacks = nil
					end
				end)
			end

			handlers[#handlers + 1] = callback
		end

		function Node:changeParent(newParent, zorder, cleanup)
			assert(newParent ~= nil)

			local node = self
			local oldParent = node:getParent()

			if oldParent ~= newParent then
				if oldParent.moveChild ~= nil then
					oldParent:moveChild(newParent, node, zorder or node:getLocalZOrder(), cleanup)
				else
					node:retain()

					if oldParent ~= nil then
						node:removeFromParent(cleanup)
					end

					if zorder ~= nil then
						newParent:addChild(node, zorder)
					else
						newParent:addChild(node)
					end

					node:release()
				end
			end

			return node
		end

		function Node:setGray(isGray)
			self:setSaturation(isGray and -100 or 0)
		end
	end
end
