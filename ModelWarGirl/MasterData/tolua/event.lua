-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ToLua\\event.lua

local setmetatable = setmetatable
local xpcall = xpcall
local pcall = pcall
local assert = assert
local rawget = rawget
local error = error
local print = print
local traceback = traceback
local ilist = ilist
local logerror = logerror
local jit = jit
local _xpcall = {}

setmetatable(_xpcall, _xpcall)

function _xpcall:__call(...)
	local flag = true
	local msg

	if jit then
		if self.obj == nil then
			flag, msg = xpcall(self.func, traceback, ...)
		else
			flag, msg = xpcall(self.func, traceback, self.obj, ...)
		end
	else
		local args = {
			...
		}

		if self.obj == nil then
			local function func()
				self.func(unpack(args))
			end

			flag, msg = xpcall(func, traceback)
		else
			local function func()
				self.func(self.obj, unpack(args))
			end

			flag, msg = xpcall(func, traceback)
		end
	end

	return flag, msg
end

function _xpcall.__eq(lhs, rhs)
	return lhs.func == rhs.func and lhs.obj == rhs.obj
end

local function xfunctor(func, obj)
	local st = {
		func = func,
		obj = obj
	}

	setmetatable(st, _xpcall)

	return st
end

local _pcall = {}

function _pcall:__call(...)
	local flag = true
	local msg

	if self.obj == nil then
		flag, msg = pcall(self.func, ...)
	else
		flag, msg = pcall(self.func, self.obj, ...)
	end

	return flag, msg
end

function _pcall.__eq(lhs, rhs)
	return lhs.func == rhs.func and lhs.obj == rhs.obj
end

local ExceptionFunc

local function functor(func, obj)
	local st = {
		func = func,
		obj = obj
	}

	setmetatable(st, _pcall)

	return st
end

local _event = {
	keepSafe = false,
	name = "",
	lock = false
}

function _event.__index(t, k)
	return rawget(_event, k)
end

function _event.SetExceptionFunc(exceFunc)
	ExceptionFunc = exceFunc
end

function _event:Add(func, obj)
	assert(func)

	if self.keepSafe then
		self.list:push(xfunctor(func, obj))
	else
		self.list:push(xfunctor(func, obj))
	end
end

function _event:Remove(func, obj)
	assert(func)

	for i, v in ilist(self.list) do
		if v.func == func and v.obj == obj then
			if self.lock then
				self.rmList:push({
					func = func,
					obj = obj
				})

				if self.inRmFuncs then
					if not self.inRmFuncs[func] then
						self.inRmFuncs[func] = {}
					end

					if obj then
						self.inRmFuncs[func][obj] = true
					end
				end
			else
				self.list:remove(i)
			end
		end
	end
end

function _event:Count()
	return self.list.length
end

function _event:Clear()
	self.list:clear()
	self.rmList:clear()

	for func, funcInfo in pairs(self.inRmFuncs) do
		self.inRmFuncs[func] = nil
	end

	self.lock = false
	self.keepSafe = false
end

function _event:Dump()
	local count = 0

	for _, v in ilist(self.list) do
		if v.obj then
			-- block empty
		end

		count = count + 1
	end
end

function _event:__call(...)
	local safe = self.keepSafe
	local _list = self.list
	local _rmList = self.rmList

	self.lock = true

	for func, funcInfo in pairs(self.inRmFuncs) do
		self.inRmFuncs[func] = nil
	end

	for i, f in ilist(_list) do
		if not self.inRmFuncs[f.func] or f.obj and not self.inRmFuncs[f.func][f.obj] then
			local flag, msg = f(...)

			if not flag then
				if safe then
					_rmList:push({
						func = f.func,
						obj = f.obj
					})
				end

				if ExceptionFunc then
					ExceptionFunc(msg)
				end
			end
		end
	end

	for _, v in ilist(_rmList) do
		for i, item in ilist(_list) do
			if v.func == item.func and v.obj == item.obj then
				_list:remove(i)

				break
			end
		end
	end

	_rmList:clear()

	self.lock = false
end

setmetatable(_event, _event)

function event(name, safe)
	local ev = {
		name = name
	}

	ev.keepSafe = safe or false
	ev.rmList = list:new()
	ev.list = list:new()
	ev.inRmFuncs = {}

	setmetatable(ev, _event)

	return ev
end

UpdateBeat = event("Update", false)
LateUpdateBeat = event("LateUpdate", false)
FixedUpdateBeat = event("FixedUpdate", false)
CoUpdateBeat = event("CoUpdate", false)

local Time = Time
local UpdateBeat = UpdateBeat
local LateUpdateBeat = LateUpdateBeat
local FixedUpdateBeat = FixedUpdateBeat
local CoUpdateBeat = CoUpdateBeat

function Update(deltaTime, unscaledDeltaTime)
	Time:SetDeltaTime(deltaTime, unscaledDeltaTime)
	UpdateBeat()
end

function LateUpdate()
	LateUpdateBeat()
	CoUpdateBeat()
	Time:SetFrameCount()
end

function FixedUpdate(fixedDeltaTime)
	Time:SetFixedDelta(fixedDeltaTime)
	FixedUpdateBeat()
end

function PrintEvents()
	UpdateBeat:Dump()
	FixedUpdateBeat:Dump()
end
