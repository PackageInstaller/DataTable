-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ToLua\\System\\ValueType.lua

local getmetatable = getmetatable
local Vector3 = Vector3
local Vector2 = Vector2
local Vector4 = Vector4
local Quaternion = Quaternion
local Color = Color
local Ray = Ray
local Bounds = Bounds
local Touch = Touch
local LayerMask = LayerMask
local RaycastHit = RaycastHit
local ValueType = {
	LayerMask = 9,
	Vector4 = 5,
	Ray = 6,
	Color = 4,
	Touch = 8,
	Quaternion = 2,
	RaycastHit = 10,
	Vector3 = 1,
	Bounds = 7,
	Vector2 = 3,
	None = 0
}

function GetLuaValueType(udata)
	local meta = getmetatable(udata)

	if meta == nil then
		return ValueType.None
	elseif meta == Vector3 then
		return ValueType.Vector3
	elseif meta == Quaternion then
		return ValueType.Quaternion
	elseif meta == Vector4 then
		return ValueType.Vector4
	elseif meta == Vector2 then
		return ValueType.Vector2
	elseif meta == Color then
		return ValueType.Color
	elseif meta == Ray then
		return ValueType.Ray
	elseif meta == Bounds then
		return ValueType.Bounds
	elseif meta == Touch then
		return ValueType.Touch
	elseif meta == LayerMask then
		return ValueType.LayerMask
	elseif meta == RaycastHit then
		return ValueType.RaycastHit
	else
		return ValueType.None
	end
end
