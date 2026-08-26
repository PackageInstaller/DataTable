-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/TianShiNaNaHelper.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaHelper", package.seeall)

local TianShiNaNaHelper = class("TianShiNaNaHelper")
local tempV2, tempV3, zero, tempQ = Vector2(), Vector3(), Vector3(), Quaternion()

function TianShiNaNaHelper.nodeToV3(node)
	tempV3.x = (node.x + node.y) * TianShiNaNaEnum.GridXOffset
	tempV3.y = (node.y - node.x) * TianShiNaNaEnum.GridYOffset
	tempV3.z = (node.y - node.x) * TianShiNaNaEnum.GridZOffset

	return tempV3
end

function TianShiNaNaHelper.v3ToNode(pos)
	local x = pos.x / TianShiNaNaEnum.GridXOffset
	local y = pos.y / TianShiNaNaEnum.GridYOffset

	tempV2.x = Mathf.Round((x - y) / 2)
	tempV2.y = Mathf.Round((x + y) / 2)

	return tempV2
end

function TianShiNaNaHelper.getV2(x, y)
	tempV2.x = x or 0
	tempV2.y = y or 0

	return tempV2
end

function TianShiNaNaHelper.getV3(x, y, z)
	tempV3.x = x or 0
	tempV3.y = y or 0
	tempV3.z = z or 0

	return tempV3
end

function TianShiNaNaHelper.getRoundDis(x1, y1, x2, y2)
	return math.abs(x1 - x2) + math.abs(y1 - y2)
end

function TianShiNaNaHelper.getMinDis(x1, y1, x2, y2)
	return math.max(math.abs(x1 - x2), math.abs(y1 - y2))
end

function TianShiNaNaHelper.isPosSame(pos1, pos2)
	return pos1.x == pos2.x and pos1.y == pos2.y
end

function TianShiNaNaHelper.havePos(list, pos)
	for _, p in pairs(list) do
		if TianShiNaNaHelper.isPosSame(pos, p) then
			return true
		end
	end

	return false
end

function TianShiNaNaHelper.getClickNodePos(position)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local worldpos = recthelper.screenPosToWorldPos(position or GamepadController.instance:getMousePosition(), mainCamera, zero)
	local offset = TianShiNaNaModel.instance.nowScenePos

	worldpos.x = worldpos.x - offset.x
	worldpos.y = worldpos.y - offset.y

	return TianShiNaNaHelper.v3ToNode(worldpos)
end

function TianShiNaNaHelper.getSortIndex(x, y)
	local depth = x - y

	return 500 + depth * 2
end

function TianShiNaNaHelper.getDir(from, to, defaultDir)
	if from.x > to.x then
		return TianShiNaNaEnum.OperDir.Left
	elseif from.x < to.x then
		return TianShiNaNaEnum.OperDir.Right
	elseif from.y > to.y then
		return TianShiNaNaEnum.OperDir.Back
	elseif from.y < to.y then
		return TianShiNaNaEnum.OperDir.Forward
	else
		return defaultDir or TianShiNaNaEnum.OperDir.Right
	end
end

function TianShiNaNaHelper.lerpQ(q1, q2, t)
	t = Mathf.Clamp(t, 0, 1)

	local q = tempQ

	if Quaternion.Dot(q1, q2) < 0 then
		q.x = q1.x + t * (-q2.x - q1.x)
		q.y = q1.y + t * (-q2.y - q1.y)
		q.z = q1.z + t * (-q2.z - q1.z)
		q.w = q1.w + t * (-q2.w - q1.w)
	else
		q.x = q1.x + (q2.x - q1.x) * t
		q.y = q1.y + (q2.y - q1.y) * t
		q.z = q1.z + (q2.z - q1.z) * t
		q.w = q1.w + (q2.w - q1.w) * t
	end

	return tempQ
end

function TianShiNaNaHelper.lerpV3(p1, p2, t)
	t = Mathf.Clamp(t, 0, 1)
	tempV3.x = p1.x + (p2.x - p1.x) * t
	tempV3.y = p1.y + (p2.y - p1.y) * t
	tempV3.z = p1.z + (p2.z - p1.z) * t

	return tempV3
end

function TianShiNaNaHelper.getCanOperDirs(heroPos, cubeType)
	local canPlaceDirs = {}

	canPlaceDirs[TianShiNaNaEnum.OperDir.Left] = TianShiNaNaModel.instance:isNodeCanPlace(heroPos.x - 1, heroPos.y, cubeType == TianShiNaNaEnum.CubeType.Type1)
	canPlaceDirs[TianShiNaNaEnum.OperDir.Right] = TianShiNaNaModel.instance:isNodeCanPlace(heroPos.x + 1, heroPos.y, cubeType == TianShiNaNaEnum.CubeType.Type1)
	canPlaceDirs[TianShiNaNaEnum.OperDir.Forward] = TianShiNaNaModel.instance:isNodeCanPlace(heroPos.x, heroPos.y + 1, cubeType == TianShiNaNaEnum.CubeType.Type1)
	canPlaceDirs[TianShiNaNaEnum.OperDir.Back] = TianShiNaNaModel.instance:isNodeCanPlace(heroPos.x, heroPos.y - 1, cubeType == TianShiNaNaEnum.CubeType.Type1)

	if cubeType == TianShiNaNaEnum.CubeType.Type2 then
		canPlaceDirs[TianShiNaNaEnum.OperDir.Left] = canPlaceDirs[TianShiNaNaEnum.OperDir.Left] and TianShiNaNaModel.instance:isNodeCanPlace(heroPos.x - 2, heroPos.y)
		canPlaceDirs[TianShiNaNaEnum.OperDir.Right] = canPlaceDirs[TianShiNaNaEnum.OperDir.Right] and TianShiNaNaModel.instance:isNodeCanPlace(heroPos.x + 2, heroPos.y)
		canPlaceDirs[TianShiNaNaEnum.OperDir.Forward] = canPlaceDirs[TianShiNaNaEnum.OperDir.Forward] and TianShiNaNaModel.instance:isNodeCanPlace(heroPos.x, heroPos.y + 2)
		canPlaceDirs[TianShiNaNaEnum.OperDir.Back] = canPlaceDirs[TianShiNaNaEnum.OperDir.Back] and TianShiNaNaModel.instance:isNodeCanPlace(heroPos.x, heroPos.y - 2)
	end

	canPlaceDirs[TianShiNaNaEnum.OperDir.Left] = canPlaceDirs[TianShiNaNaEnum.OperDir.Left] or nil
	canPlaceDirs[TianShiNaNaEnum.OperDir.Right] = canPlaceDirs[TianShiNaNaEnum.OperDir.Right] or nil
	canPlaceDirs[TianShiNaNaEnum.OperDir.Forward] = canPlaceDirs[TianShiNaNaEnum.OperDir.Forward] or nil
	canPlaceDirs[TianShiNaNaEnum.OperDir.Back] = canPlaceDirs[TianShiNaNaEnum.OperDir.Back] or nil

	return canPlaceDirs
end

function TianShiNaNaHelper.getOperDir(xDrag, yDrag)
	if xDrag >= 0 and yDrag <= 0 then
		return TianShiNaNaEnum.OperDir.Right
	elseif xDrag <= 0 and yDrag >= 0 then
		return TianShiNaNaEnum.OperDir.Left
	elseif xDrag >= 0 and yDrag >= 0 then
		return TianShiNaNaEnum.OperDir.Forward
	elseif xDrag <= 0 and yDrag <= 0 then
		return TianShiNaNaEnum.OperDir.Back
	end
end

function TianShiNaNaHelper.isRevertDir(nowOper, xDrag, yDrag)
	if nowOper == TianShiNaNaEnum.OperDir.Left and xDrag > 0 then
		return true
	elseif nowOper == TianShiNaNaEnum.OperDir.Right and xDrag < 0 then
		return true
	elseif nowOper == TianShiNaNaEnum.OperDir.Forward and yDrag < 0 then
		return true
	elseif nowOper == TianShiNaNaEnum.OperDir.Back and yDrag > 0 then
		return true
	end
end

function TianShiNaNaHelper.getOperOffset(dir)
	tempV2:Set(0, 0)

	if dir == TianShiNaNaEnum.OperDir.Left then
		tempV2.x = -1
	elseif dir == TianShiNaNaEnum.OperDir.Right then
		tempV2.x = 1
	elseif dir == TianShiNaNaEnum.OperDir.Forward then
		tempV2.y = 1
	elseif dir == TianShiNaNaEnum.OperDir.Back then
		tempV2.y = -1
	end

	return tempV2
end

function TianShiNaNaHelper.getLimitTimeStr()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity2_2Enum.ActivityId.TianShiNaNa)

	if not actInfoMo then
		return ""
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		return TimeUtil.SecondToActivityTimeFormat(offsetSecond)
	end

	return ""
end

function TianShiNaNaHelper.isBanOper()
	return GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.TianShiNaNaBanOper)
end

return TianShiNaNaHelper
