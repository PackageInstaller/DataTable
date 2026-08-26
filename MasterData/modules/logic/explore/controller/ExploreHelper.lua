-- chunkname: @modules/logic/explore/controller/ExploreHelper.lua

module("modules.logic.explore.controller.ExploreHelper", package.seeall)

local ExploreHelper = _M
local _navigateMask = LayerMask.GetMask("Scene")
local _sceneMask = LayerMask.GetMask("SceneOpaque", "Unit", "Scene")
local _triggerMask = LayerMask.GetMask(SceneLayer.UI3D, SceneLayer.UI3DAfterPostProcess)

function ExploreHelper.getXYByKey(key)
	local pos = string.split(key, "_")
	local x = tonumber(pos[1])
	local y = tonumber(pos[2])

	return x, y
end

function ExploreHelper.getNavigateMask()
	return _navigateMask
end

function ExploreHelper.getSceneMask()
	return _sceneMask
end

function ExploreHelper.getTriggerMask()
	return _triggerMask
end

function ExploreHelper.getKey(pos)
	return ExploreHelper.getKeyXY(pos.x, pos.y)
end

function ExploreHelper.getKeyXY(x, y)
	return string.format("%s_%s", x, y)
end

function ExploreHelper.tileToPos(pos)
	return Vector3(pos.x * ExploreConstValue.TILE_SIZE + 0.5, 0, pos.y * ExploreConstValue.TILE_SIZE + 0.5)
end

function ExploreHelper.posToTile(pos)
	return Vector2(math.floor(pos.x / ExploreConstValue.TILE_SIZE), math.floor(pos.z / ExploreConstValue.TILE_SIZE))
end

function ExploreHelper.isPosEqual(posA, posB)
	return posA == posB or posA.x == posB.x and posA.y == posB.y
end

function ExploreHelper.getDistance(posA, posB)
	return math.abs(posA.x - posB.x) + math.abs(posA.y - posB.y)
end

function ExploreHelper.getDistanceRound(posA, posB)
	return math.max(math.abs(posA.x - posB.x), math.abs(posA.y - posB.y))
end

function ExploreHelper.getDir(dir)
	return (dir + 360) % 360
end

local dirToXYDic = {
	[0] = {
		x = 0,
		y = 1
	},
	[90] = {
		x = 1,
		y = 0
	},
	[180] = {
		x = 0,
		y = -1
	},
	[270] = {
		x = -1,
		y = 0
	}
}

function ExploreHelper.dirToXY(dir)
	dir = ExploreHelper.getDir(dir)

	return dirToXYDic[dir]
end

function ExploreHelper.xyToDir(x, y)
	for dir, pos in pairs(dirToXYDic) do
		if pos.x == x and pos.y == y then
			return dir
		end
	end

	return 0
end

function ExploreHelper.getCornerNum(path, startPos)
	if not path or #path <= 0 then
		return 0
	end

	local count = 0
	local lastNode = path[1]
	local lastCornerValue

	local function calcCorner(node)
		local cornerValue = 0

		if lastNode.x == node.x then
			cornerValue = -1
		elseif lastNode.y == node.y then
			cornerValue = 1
		end

		if not lastCornerValue or lastCornerValue ~= cornerValue then
			count = count + 1
			lastCornerValue = cornerValue
		end
	end

	for i = 2, #path do
		local v = path[i]

		calcCorner(v)

		lastNode = v
	end

	calcCorner(startPos)

	return count - 1
end

function ExploreHelper.getBit(value, index)
	local b = bit.lshift(1, index - 1)

	return bit.band(value, b)
end

function ExploreHelper.setBit(value, index, isSet)
	local b = bit.lshift(1, index - 1)

	if isSet then
		value = bit.bor(value, b)
	else
		b = bit.bnot(b)
		value = bit.band(value, b)
	end

	return value
end

function ExploreHelper.triggerAudio(audioId, isBindGo, go, unitId)
	if not audioId or audioId <= 0 then
		return
	end

	local triggerId = isBindGo and AudioMgr.instance:trigger(audioId, go) or AudioMgr.instance:trigger(audioId)

	if unitId then
		local scene = GameSceneMgr.instance:getCurScene()

		scene.audio:onTriggerAudio(unitId, triggerId)
	end
end

return ExploreHelper
