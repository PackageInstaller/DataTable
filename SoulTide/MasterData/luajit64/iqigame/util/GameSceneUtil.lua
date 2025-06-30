-- chunkname: @IQIGame\\Util\\GameSceneUtil.lua

local m = {}

function m.GetHexagonAroundXY(currentX, currentY, isLuaIndex)
	local resultDelta = 0

	if isLuaIndex then
		currentX = currentX - 1
		currentY = currentY - 1
		resultDelta = 1
	end

	local aroundIndexes = {}

	if currentX % 2 == 0 then
		table.insert(aroundIndexes, {
			currentX,
			currentY + 1
		})
		table.insert(aroundIndexes, {
			currentX - 1,
			currentY
		})
		table.insert(aroundIndexes, {
			currentX + 1,
			currentY
		})
		table.insert(aroundIndexes, {
			currentX - 1,
			currentY - 1
		})
		table.insert(aroundIndexes, {
			currentX,
			currentY - 1
		})
		table.insert(aroundIndexes, {
			currentX + 1,
			currentY - 1
		})
	else
		table.insert(aroundIndexes, {
			currentX - 1,
			currentY + 1
		})
		table.insert(aroundIndexes, {
			currentX,
			currentY + 1
		})
		table.insert(aroundIndexes, {
			currentX + 1,
			currentY + 1
		})
		table.insert(aroundIndexes, {
			currentX - 1,
			currentY
		})
		table.insert(aroundIndexes, {
			currentX + 1,
			currentY
		})
		table.insert(aroundIndexes, {
			currentX,
			currentY - 1
		})
	end

	if resultDelta ~= 0 then
		for i = 1, #aroundIndexes do
			aroundIndexes[i][1] = aroundIndexes[i][1] + resultDelta
			aroundIndexes[i][2] = aroundIndexes[i][2] + resultDelta
		end
	end

	return aroundIndexes
end

return m
