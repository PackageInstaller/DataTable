-- chunkname: @modules/logic/sp02/operationactivity/helper/AtomicOperationActivityHelper.lua

module("modules.logic.sp02.operationactivity.helper.AtomicOperationActivityHelper", package.seeall)

local AtomicOperationActivityHelper = class("AtomicOperationActivityHelper")

function AtomicOperationActivityHelper.dist(a, b)
	local dx, dy = a[1] - b[1], a[2] - b[2]

	return dx * dx + dy * dy
end

function AtomicOperationActivityHelper.findNearPoint(points)
	local res = {}

	for i = 1, #points do
		local tmp = {}

		for j = 1, #points do
			if i ~= j then
				table.insert(tmp, {
					d = AtomicOperationActivityHelper.dist(points[i], points[j]),
					p = j
				})
			end
		end

		table.sort(tmp, function(a, b)
			return a.d < b.d
		end)

		res[i] = tmp
	end

	return res
end

function AtomicOperationActivityHelper.getScoreLevel(score)
	local scoreParam = AtomicOperationActivityConfig.instance:getConstStr(AtomicOperationActivityEnum.ConstId.RewardScore)
	local scoreDataList = string.split(scoreParam, "|")

	for _, scoreData in ipairs(scoreDataList) do
		local param = string.split(scoreData, "#")

		if score >= tonumber(param[2]) then
			return param[1], tonumber(param[3])
		end
	end
end

return AtomicOperationActivityHelper
