-- chunkname: @System\\Reflection\\BindingFlags.lua

if System.Reflection == nil then
	System.Reflection = {}
end

local function GetMask(...)
	local arg = {
		...
	}
	local value = 0

	for i = 1, #arg do
		value = value + arg[i]
	end

	return value
end

local BindingFlags = {
	Default = 0,
	SetField = 2048,
	GetField = 1024,
	Instance = 4,
	GetProperty = 4096,
	SuppressChangeType = 131072,
	NonPublic = 32,
	PutRefDispProperty = 32768,
	Static = 8,
	IgnoreReturn = 16777216,
	OptionalParamBinding = 262144,
	FlattenHierarchy = 64,
	ExactBinding = 65536,
	Public = 16,
	InvokeMethod = 256,
	SetProperty = 8192,
	DeclaredOnly = 2,
	CreateInstance = 512,
	PutDispProperty = 16384,
	IgnoreCase = 1
}

System.Reflection.BindingFlags = BindingFlags
System.Reflection.BindingFlags.GetMask = GetMask

return BindingFlags
