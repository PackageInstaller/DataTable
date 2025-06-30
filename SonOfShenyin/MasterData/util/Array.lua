-- chunkname: @Util\\Array.lua

function table.clone(t)
	local newT = {}

	for k, v in pairs(t) do
		newT[k] = t[k]
	end

	return newT
end
