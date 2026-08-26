-- chunkname: @modules/logic/survival/util/SurvivalHelper.lua

module("modules.logic.survival.util.SurvivalHelper", package.seeall)

local SurvivalHelper = class("SurvivalHelper")
local sqrt3 = math.sqrt(3)
local zeroV3 = Vector3()

function SurvivalHelper:getDistance(a, b)
	return (math.abs(a.q - b.q) + math.abs(a.r - b.r) + math.abs(a.s - b.s)) / 2
end

function SurvivalHelper:getAllPointsByDis(point, dis)
	if not dis or not point or dis <= 0 then
		return {}
	end

	local list = {}
	local len = 0

	for q = -dis, dis do
		for r = -dis, dis do
			for s = -dis, dis do
				if q + r + s == 0 then
					len = len + 1

					local node = SurvivalMapModel.instance:getCacheHexNode(len)

					node:set(q + point.q, r + point.r, s + point.s)
					table.insert(list, node)
				end
			end
		end
	end

	return list
end

function SurvivalHelper:hexPointToWorldPoint(q, r)
	return r / 4 * sqrt3 + q * sqrt3 / 2, 0, -r * 3 / 4
end

function SurvivalHelper:worldPointToHex(x, y, z)
	local q = (z + x * sqrt3) * 2 / 3
	local r = -z * 4 / 3
	local s = -q - r
	local roundQ = Mathf.Round(q)
	local roundR = Mathf.Round(r)
	local roundS = Mathf.Round(s)
	local absQ = math.abs(q - roundQ)
	local absR = math.abs(r - roundR)
	local absS = math.abs(s - roundS)

	if absR < absQ and absS < absQ then
		roundQ = -roundR - roundS
	elseif absS < absR then
		roundR = -roundQ - roundS
	else
		roundS = -roundQ - roundR
	end

	return roundQ, roundR, roundS
end

function SurvivalHelper:getScene3DPos(screenPos, yPos)
	yPos = yPos or 0
	screenPos = screenPos or GamepadController.instance:getMousePosition()

	local mainCamera = CameraMgr.instance:getMainCamera()
	local ray = mainCamera:ScreenPointToRay(screenPos)
	local dir = ray.direction

	if dir.y == 0 then
		return zeroV3
	end

	local origin = ray.origin
	local num = -(origin.y - yPos) / dir.y

	return origin:Add(dir:Mul(num))
end

function SurvivalHelper:getDir(fromPos, toPos)
	local q = toPos.q - fromPos.q
	local r = toPos.r - fromPos.r
	local max_val = math.max(math.abs(q), math.abs(r))
	local base_q, base_r = math.floor(q / max_val), math.floor(r / max_val)

	for dir, pos in pairs(SurvivalEnum.DirToPos) do
		if pos.q == base_q and pos.r == base_r then
			return dir
		end
	end

	logError("not dir! " .. tostring(fromPos) .. " " .. tostring(toPos))
end

function SurvivalHelper:screenPosToRay(screenPos)
	screenPos = screenPos or GamepadController.instance:getMousePosition()

	local camera = CameraMgr.instance:getMainCamera()

	return (camera:ScreenPointToRay(screenPos))
end

function SurvivalHelper:isInSeasonAndVersion(co)
	if not co then
		return false
	end

	local outSideMo = SurvivalModel.instance:getOutSideInfo()

	if not outSideMo then
		return false
	end

	local needVersions = co.versions

	if not string.nilorempty(needVersions) then
		local list = GameUtil.splitString2(needVersions, true)

		for _, versions in ipairs(list) do
			table.sort(versions)

			if not self:isSame(versions, outSideMo.versions) then
				return false
			end
		end
	end

	local needSeasons = co.seasons

	if not string.nilorempty(needSeasons) then
		local arr = string.splitToNumber(needSeasons, "#")

		if not tabletool.indexOf(arr, outSideMo.season) then
			return false
		end
	end

	return true
end

function SurvivalHelper:isSame(arrA, arrB)
	if not arrA or not arrB then
		return false
	end

	if #arrA ~= #arrB then
		return false
	end

	for k, v in ipairs(arrA) do
		if arrB[k] ~= v then
			return false
		end
	end

	return true
end

function SurvivalHelper:makeArrFull(arr, empty, row, col)
	local min = row * col
	local len = #arr

	if len < min then
		for i = len + 1, min do
			table.insert(arr, empty)
		end
	else
		local num = len % col

		if num ~= 0 then
			for i = num + 1, col do
				table.insert(arr, empty)
			end
		end
	end
end

function SurvivalHelper:getOperResult(oper, num1, num2)
	if oper == SurvivalEnum.ConditionOper.GE then
		return num2 <= num1
	elseif oper == SurvivalEnum.ConditionOper.EQ then
		return num1 == num2
	elseif oper == SurvivalEnum.ConditionOper.LE then
		return num1 <= num2
	end
end

function SurvivalHelper:fitlterPath(path)
	if not path or #path < 3 then
		return path
	end

	local newPath = {
		path[1]
	}
	local prevDir = self:getDir(path[1], path[2])

	for i = 2, #path - 1 do
		local currentDir = self:getDir(path[i], path[i + 1])

		if currentDir ~= prevDir then
			table.insert(newPath, path[i])

			prevDir = currentDir
		end
	end

	table.insert(newPath, path[#path])

	return newPath
end

function SurvivalHelper:addNodeToDict(dict, node, value)
	dict[node.q] = dict[node.q] or {}

	if value == nil then
		value = node
	end

	dict[node.q][node.r] = value
end

function SurvivalHelper:removeNodeToDict(dict, node)
	if not dict[node.q] then
		return
	end

	dict[node.q][node.r] = nil
end

function SurvivalHelper:isHaveNode(dict, node)
	if not dict[node.q] then
		return nil
	end

	return dict[node.q][node.r] ~= nil
end

function SurvivalHelper:getValueFromDict(dict, node)
	if not dict[node.q] then
		return nil
	end

	return dict[node.q][node.r]
end

function SurvivalHelper:getDirMustHave(fromPos, toPos)
	local q = toPos.q - fromPos.q
	local r = toPos.r - fromPos.r
	local max_val = math.max(math.abs(q), math.abs(r))
	local base_q, base_r = math.floor(q / max_val), math.floor(r / max_val)

	for dir, pos in pairs(SurvivalEnum.DirToPos) do
		if pos.q == base_q and pos.r == base_r then
			return dir
		end
	end

	return SurvivalEnum.Dir.Right
end

function SurvivalHelper:getLine(start, en)
	local x1 = start.q
	local y1 = start.r
	local z1 = start.s
	local x2 = en.q
	local y2 = en.r
	local z2 = en.s
	local dx = x2 - x1
	local dy = y2 - y1
	local dz = z2 - z1
	local ts = {
		0,
		1
	}

	self:_collectHalfIntegerCrossings(ts, x1, x2, dx)
	self:_collectHalfIntegerCrossings(ts, y1, y2, dy)
	self:_collectHalfIntegerCrossings(ts, z1, z2, dz)
	table.sort(ts)

	local uniqTs = {}

	for _, t in ipairs(ts) do
		if #uniqTs == 0 or math.abs(t - uniqTs[#uniqTs]) > 0 then
			table.insert(uniqTs, t)
		end
	end

	local set = {}
	local list = {}

	for i = 1, #uniqTs - 1 do
		local tA = uniqTs[i]
		local tB = uniqTs[i + 1]
		local tm = (tA + tB) / 2
		local sx = x1 + dx * tm
		local sy = y1 + dy * tm
		local sz = z1 + dz * tm
		local rx, ry, rz = self:_cubeRound(sx, sy, sz)
		local key = string.format("%s_%s_%s", rx, ry, rz)

		if not set[key] then
			set[key] = true

			local node = SurvivalHexNode.New(rx, ry, rz)

			table.insert(list, node)
		end
	end

	return list
end

function SurvivalHelper:_collectHalfIntegerCrossings(ts, c1, c2, dc)
	if dc == 0 then
		return
	end

	local minVal = math.min(c1, c2)
	local maxVal = math.max(c1, c2)
	local kMin = math.floor(minVal) - 1
	local kMax = math.floor(maxVal) + 1

	for k = kMin, kMax do
		local t = (k + 0.5 - c1) / dc

		if t > 0 and t < 1 then
			table.insert(ts, t)
		end
	end
end

function SurvivalHelper:_cubeRound(x, y, z)
	local rx = Mathf.Round(x)
	local ry = Mathf.Round(y)
	local rz = Mathf.Round(z)
	local xDiff = math.abs(rx - x)
	local yDiff = math.abs(ry - y)
	local zDiff = math.abs(rz - z)

	if yDiff < xDiff and zDiff < xDiff then
		rx = -ry - rz
	elseif zDiff < yDiff then
		ry = -rx - rz
	else
		rz = -rx - ry
	end

	return rx, ry, rz
end

SurvivalHelper.instance = SurvivalHelper.New()

return SurvivalHelper
