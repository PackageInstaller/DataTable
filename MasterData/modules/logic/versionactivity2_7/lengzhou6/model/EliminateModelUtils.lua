-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/EliminateModelUtils.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.EliminateModelUtils", package.seeall)

local EliminateModelUtils = class("EliminateModelUtils")

function EliminateModelUtils.mergePointArray(rowPoints, colPoints)
	local result = {}

	for i = 1, #rowPoints do
		table.insert(result, rowPoints[i])
	end

	local filteredColPoints = {}

	for i = 1, #colPoints do
		local colEle = colPoints[i]
		local isRepeat = false

		for j = 1, #result do
			local rowEle = result[j]

			if colEle.x == rowEle.x and colEle.y == rowEle.y then
				isRepeat = true

				break
			end
		end

		if not isRepeat then
			table.insert(filteredColPoints, colEle)
		end
	end

	for i = 1, #filteredColPoints do
		table.insert(result, filteredColPoints[i])
	end

	return result
end

function EliminateModelUtils.exclusivePoint(points, exclusivePoint)
	local result = {}

	for i = 1, #points do
		local point = points[i]

		if point.x ~= exclusivePoint.x or point.y ~= exclusivePoint.y then
			table.insert(result, point)
		end
	end

	return result
end

function EliminateModelUtils.getRandomNumberByWeight(weights)
	local totalWeight = 0

	for _, weight in ipairs(weights) do
		totalWeight = totalWeight + weight
	end

	local randomWeight = math.random() * totalWeight
	local cumulativeWeight = 0

	for i, weight in ipairs(weights) do
		cumulativeWeight = cumulativeWeight + weight

		if randomWeight <= cumulativeWeight then
			return i
		end
	end
end

return EliminateModelUtils
