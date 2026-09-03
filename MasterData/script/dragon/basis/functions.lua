-- chunkname: @/tmp/or_script/lua_compile/dragon/basis/functions.lua

function __associated_delegate__(object)
	local function wrappedFunction(f)
		return function(delegate, ...)
			local self = delegate["$self"]

			if DisposableObject:isDisposed(self) then
				return
			end

			return f(self, ...)
		end
	end

	return function(delegate)
		assert(type(delegate) == "table")

		if delegate["$self"] == nil then
			for k, v in pairs(delegate) do
				if type(v) == "function" then
					delegate[k] = wrappedFunction(v)
				end
			end

			setmetatable(delegate, {
				__newindex = function(t, k, v)
					if type(v) == "function" then
						v = wrappedFunction(v)
					end

					rawset(t, k, v)
				end
			})
		end

		delegate["$self"] = object

		return delegate
	end
end
