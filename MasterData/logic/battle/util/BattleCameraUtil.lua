-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleCameraUtil.lua

module("logic.battle.util.BattleCameraUtil", package.seeall)

local BattleCameraUtil = {}
local kTempVec3 = Vector3.New()

local function kTweenPositionSetter(x, y, z)
	local boardMgr = BattleMgr.instance:getBoardMgr()

	y = boardMgr:interpolateWorldYOffset(x, z)

	kTempVec3:Set(x, y, z)

	return kTempVec3
end

function BattleCameraUtil.doFollowPosition(x, y, z, duration)
	local tween = VirtualCameraMgr.instance:doFollowPosition(x, y, z, duration)

	VirtualCameraMgr.instance:setPositionTweenSetterHandler(kTweenPositionSetter)

	return tween
end

return BattleCameraUtil
