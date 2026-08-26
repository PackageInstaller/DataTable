-- chunkname: @modules/logic/scene/room/comp/RoomSceneBendingComp.lua

module("modules.logic.scene.room.comp.RoomSceneBendingComp", package.seeall)

local RoomSceneBendingComp = class("RoomSceneBendingComp", BaseSceneComp)

function RoomSceneBendingComp:onInit()
	self._bendingAmountId = UnityEngine.Shader.PropertyToID("_Curvature")
	self._bendingAmountScaledId = UnityEngine.Shader.PropertyToID("_CurvatureScaled")
	self._ambientColorId = UnityEngine.Shader.PropertyToID("_AmbientCol")
	self._fogColorId = UnityEngine.Shader.PropertyToID("_FogColor")
	self._bendingPositionId = UnityEngine.Shader.PropertyToID("_GameobjPosition")
	self._bendingNegaPositionId = UnityEngine.Shader.PropertyToID("_NegaGameobjPosition")
	self._skyMeshRenderer = nil
	self._skyPropertyBlock = nil
end

function RoomSceneBendingComp:init(sceneId, levelId)
	self._scene = self:getCurScene()

	local bendingAmount = 0.25

	self:setBendingAmount(bendingAmount)
end

function RoomSceneBendingComp:setBendingAmount(bendingAmount)
	RoomHelper.setGlobalFloat(self._bendingAmountId, bendingAmount)
	RoomHelper.setGlobalFloat(self._bendingAmountScaledId, -bendingAmount * 0.08)

	bendingAmount = RoomHelper.getGlobalFloat(self._bendingAmountId)

	RoomBendingHelper.setBendingAmount(bendingAmount)
	RoomMapController.instance:dispatchEvent(RoomEvent.BendingAmountUpdate)
end

function RoomSceneBendingComp:setAmbientColor(color)
	RoomHelper.setGlobalColor(self._ambientColorId, color)
end

function RoomSceneBendingComp:getAmbientColor()
	return UnityEngine.Shader.GetGlobalColor(self._ambientColorId)
end

function RoomSceneBendingComp:setFogColor(color)
	RoomHelper.setGlobalColor(self._fogColorId, color)
end

function RoomSceneBendingComp:getFogColor()
	return UnityEngine.Shader.GetGlobalColor(self._fogColorId)
end

function RoomSceneBendingComp:setSkylineOffset(offset)
	if not self._skyMeshRenderer then
		local skyGO = self._scene.go.skyGO

		self._skyMeshRenderer = skyGO and skyGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	end

	if not self._skyMeshRenderer then
		return
	end

	self._skyPropertyBlock = self._skyPropertyBlock or UnityEngine.MaterialPropertyBlock.New()

	self._skyPropertyBlock:SetFloat("_OffsetHorizon", offset)
	self._skyMeshRenderer:SetPropertyBlock(self._skyPropertyBlock)
end

function RoomSceneBendingComp:setBendingPosition(position)
	RoomBendingHelper.setBendingPosition(position)

	local vector = Vector4(position.x, position.y, position.z, 1)

	UnityEngine.Shader.SetGlobalVector(self._bendingPositionId, vector)

	local negaVector = Vector4(-position.x, -position.z, 1, 1)

	UnityEngine.Shader.SetGlobalVector(self._bendingNegaPositionId, negaVector)
end

function RoomSceneBendingComp:onSceneClose()
	self._skyMeshRenderer = nil

	if self._skyPropertyBlock then
		self._skyPropertyBlock:Clear()

		self._skyPropertyBlock = nil
	end
end

return RoomSceneBendingComp
