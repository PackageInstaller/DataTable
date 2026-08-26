-- chunkname: @modules/logic/scene/room/comp/RoomSceneFogComp.lua

module("modules.logic.scene.room.comp.RoomSceneFogComp", package.seeall)

local RoomSceneFogComp = class("RoomSceneFogComp", BaseSceneComp)

function RoomSceneFogComp:onInit()
	return
end

function RoomSceneFogComp:init(sceneId, levelId)
	self._scene = self:getCurScene()

	self._scene.loader:makeSureLoaded({
		RoomScenePreloader.ResFogParticle
	}, self._OnGetInstance, self)
end

function RoomSceneFogComp:_OnGetInstance()
	self._fogGO = RoomGOPool.getInstance(RoomScenePreloader.ResFogParticle, self._scene.go.fogRoot, "fog")
	self._particleSystem = self._fogGO:GetComponent(typeof(UnityEngine.ParticleSystem))
	self._renderer = self._fogGO:GetComponent(typeof(UnityEngine.Renderer))
	self._materialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()

	self:_resetTempParam()
end

function RoomSceneFogComp:_resetTempParam()
	self._tempMaxParticles = nil
	self._tempFogParamCenterY = nil
	self._tempFogParamHeight = nil
	self._tempFogParamRangeZ = nil
	self._tempFogParamRangeW = nil
	self._tempFogViewType = nil
end

function RoomSceneFogComp:setFogParam(fogParam)
	local mpbChanged = false

	if not self._tempMaxParticles or self._tempMaxParticles ~= fogParam.maxParticles * 10 then
		self._tempMaxParticles = fogParam.maxParticles * 10

		ZProj.ParticleSystemHelper.SetMaxParticles(self._particleSystem, self._tempMaxParticles)
	end

	if not self._tempFogParamCenterY or self._tempFogParamCenterY ~= fogParam.centerY or not self._tempFogParamHeight or self._tempFogParamHeight ~= fogParam.height or not self._tempFogParamRangeZ or self._tempFogParamRangeZ ~= fogParam.fogRangeZ or not self._tempFogParamRangeW or self._tempFogParamRangeW ~= fogParam.fogRangeW then
		self._tempFogParamCenterY = fogParam.centerY
		self._tempFogParamHeight = fogParam.height
		self._tempFogParamRangeZ = fogParam.fogRangeZ
		self._tempFogParamRangeW = fogParam.fogRangeW

		self._materialPropertyBlock:SetVector("_FogRange", Vector4(fogParam.centerY, fogParam.height, fogParam.fogRangeZ, fogParam.fogRangeW))

		mpbChanged = true
	end

	if not self._tempFogViewType or self._tempFogViewType ~= fogParam.fogViewType then
		self._tempFogViewType = fogParam.fogViewType
		mpbChanged = true

		self._materialPropertyBlock:SetFloat("_FogViewType", fogParam.fogViewType)
	end

	if mpbChanged then
		self._renderer:SetPropertyBlock(self._materialPropertyBlock)
	end
end

function RoomSceneFogComp:onSceneClose()
	self._fogGO = nil
	self._particleSystem = nil
	self._renderer = nil

	if self._materialPropertyBlock then
		self._materialPropertyBlock:Clear()

		self._materialPropertyBlock = nil
	end

	self:_resetTempParam()
end

return RoomSceneFogComp
