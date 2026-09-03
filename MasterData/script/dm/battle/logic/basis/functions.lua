-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/basis/functions.lua

kBattleSideA = 1
kBattleSideB = -1

function opposeBattleSide(side)
	return side and -side
end

function judgeBattleSide(desc)
	if desc == "SideA" then
		return kBattleSideA
	elseif desc == "SideB" then
		return kBattleSideB
	end

	return nil
end

local maxn = table.maxn

function remove_value(array, value)
	for i = 1, maxn(array) do
		if array[i] == value then
			return table.remove(array, i)
		end
	end
end

function remove_values(array, value)
	local n = maxn(array)
	local hole = 1

	for i = 1, n do
		local val = array[i]

		if val == value then
			array[i] = nil
		else
			if hole ~= i then
				array[hole] = val
				array[i] = nil
			end

			hole = hole + 1
		end
	end

	return array
end

function remove_if(array, pred)
	local n = maxn(array)
	local hole = 1

	for i = 1, n do
		local val = array[i]

		if pred(i, val) then
			array[i] = nil
		else
			if hole ~= i then
				array[hole] = val
				array[i] = nil
			end

			hole = hole + 1
		end
	end

	return array
end

kBattleSideAWin = 1
kBattleSideBWin = -1
kBattleDraw = 0
kBattleSideALose = kBattleSideBWin
kBattleSideBLose = kBattleSideAWin

function fillTableWithDefaults(dest, defaults)
	local result = dest or {}

	for name, value in pairs(defaults) do
		if result[name] == nil then
			result[name] = value
		end
	end

	return result
end

battlelog = cclog or function(...)
	print("[BATTLE]", ...)
end
battlelogf = cclogf or function(fmt, ...)
	local msg = string.format(fmt, ...)

	print("[BATTLE]", msg)
end
battledump = dump or function(obj, label)
	print(string.format("*** Trying to dump object %s (%s) ***", tostring(obj), tostring(label)))
end
