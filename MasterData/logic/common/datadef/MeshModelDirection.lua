-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/datadef/MeshModelDirection.lua

module("logic.common.datadef.MeshModelDirection", package.seeall)

local MeshModelDirection = {}

MeshModelDirection.Right = Vector3.right
MeshModelDirection.Left = Vector3.left
MeshModelDirection.Forward = Vector3.forward
MeshModelDirection.Back = Vector3.back
MeshModelDirection.Default = MeshModelDirection.Back
MeshModelDirection[1] = MeshModelDirection.Forward
MeshModelDirection[2] = MeshModelDirection.Right
MeshModelDirection[3] = MeshModelDirection.Back
MeshModelDirection[4] = MeshModelDirection.Left

function MeshModelDirection.lookAtDirectionOrEnum(unit, lookAtDirection, direction)
	if lookAtDirection and not MeshModelDirection.isLockDirection(unit) then
		local x, z = lookAtDirection:getXZ()

		unit.meshModel:lookAtDir(x, 0, z)
	else
		local lookAtVec3 = MeshModelDirection[direction]

		unit.meshModel:lookAtDirVec3(lookAtVec3)
	end
end

function MeshModelDirection.isLockDirection(unit)
	local modelCO = ModelConfig.instance:getModelConfig(unit.property:getModelCode())

	return ModelCOUtil.isLockDirection(modelCO)
end

return MeshModelDirection
