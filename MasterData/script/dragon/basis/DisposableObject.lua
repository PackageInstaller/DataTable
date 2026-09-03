-- chunkname: @/tmp/or_script/lua_compile/dragon/basis/DisposableObject.lua

local DisposedObjectMetatables = {}

local function getDisposedMetatable(class)
	local meta = DisposedObjectMetatables[class]

	if meta == nil then
		meta = {
			__metatable = "disposed",
			__index = function(t, k)
				local mem = class.__prototype__[k]

				if mem == nil then
					return nil
				end

				if type(mem) == "function" then
					return function(...)
						local message = string.format("Trying to call `%s:%s()` after the object being disposed!", class:name(), k)

						if DEBUG ~= nil and DEBUG >= 2 and __G__TRACKBACK__ ~= nil then
							__G__TRACKBACK__(message, 2)
						else
							print(debug.traceback(message, 2))
						end

						return mem(...)
					end
				end

				return mem
			end
		}
		DisposedObjectMetatables[class] = meta
	end

	return meta
end

DisposableObject = objectlua.Object:subclass("DisposableObject")

function DisposableObject:initialize()
	super.initialize(self)

	self.__refcnt = 1
end

function DisposableObject:dispose()
	self:releaseAllObjects()

	self.__disposed = true

	if DEBUG ~= nil and DEBUG > 0 and getmetatable(self) ~= "disposed" then
		local meta = self.class.__prototype__
		local disposed_meta = getDisposedMetatable(self.class)
		local meta_accessor = meta.__metatable

		meta.__metatable = nil

		setmetatable(self, disposed_meta)

		meta.__metatable = meta_accessor
	end
end

function DisposableObject.class:isDisposed(object)
	return object.__disposed
end

function DisposableObject:retain()
	self.__refcnt = (self.__refcnt or 0) + 1
end

function DisposableObject:release()
	self.__refcnt = self.__refcnt - 1

	if self.__refcnt == 0 then
		self:dispose()
	end
end

function DisposableObject:retainObject(obj)
	if obj == nil or obj.retain == nil then
		return obj
	end

	if self._retainedObjects == nil then
		self._retainedObjects = {}
	end

	local cnt = self._retainedObjects[obj]

	if cnt == nil then
		obj:retain()

		self._retainedObjects[obj] = 1
	else
		self._retainedObjects[obj] = cnt + 1
	end

	return obj
end

function DisposableObject:releaseObject(obj)
	if obj == nil or obj.release == nil then
		return
	end

	if self._retainedObjects == nil then
		return
	end

	local cnt = self._retainedObjects[obj]

	if cnt == nil then
		return
	end

	assert(cnt > 0)

	cnt = cnt - 1

	if cnt <= 0 then
		self._retainedObjects[obj] = nil

		obj:release()
	else
		self._retainedObjects[obj] = cnt
	end
end

function DisposableObject:releaseAllObjects()
	if self._retainedObjects == nil then
		return
	end

	for obj, cnt in pairs(self._retainedObjects) do
		obj:release()
	end

	self._retainedObjects = nil
end

function DisposableObject:autoManageObject(obj)
	if self._retainedObjects and self._retainedObjects[obj] ~= nil then
		return obj
	end

	if obj and self:retainObject(obj) then
		obj:release()
	end

	return obj
end
