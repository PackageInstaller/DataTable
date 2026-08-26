-- chunkname: @modules/logic/scene/survival/entity/SurvivalBlockEntity.lua

module("modules.logic.scene.survival.entity.SurvivalBlockEntity", package.seeall)

local SurvivalBlockEntity = class("SurvivalBlockEntity", LuaCompBase)
local bit = require("bit")

function SurvivalBlockEntity.Create(blockCo, root)
	local go = gohelper.create3d(root, tostring(blockCo.pos))
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(blockCo.pos.q, blockCo.pos.r)
	local rootTrans = go.transform

	transformhelper.setLocalPos(rootTrans, x, y, z)
	transformhelper.setLocalRotation(rootTrans, 0, blockCo.dir * 60 + 30, 0)

	local blockRes = SurvivalMapHelper.instance:getBlockRes(blockCo.assetPath)

	if blockRes then
		local blockGo = gohelper.clone(blockRes, go)
		local trans = blockGo.transform

		transformhelper.setLocalPos(trans, 0, 0, 0)
		transformhelper.setLocalRotation(trans, 0, 0, 0)
		transformhelper.setLocalScale(trans, 1, 1, 1)
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalBlockEntity, blockCo)
end

function SurvivalBlockEntity:ctor(data)
	self._data = data
end

local TerrainLayerIndex = 9

function SurvivalBlockEntity:init(go)
	self.go = go
	self._terrainMRs = self:getUserDataTb_()

	local meshRenderers = go:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, meshRenderers.Length - 1 do
		local meshRenderer = meshRenderers[i]
		local layerMask = meshRenderer.renderingLayerMask

		if bit.band(layerMask, 2^TerrainLayerIndex) ~= 0 then
			table.insert(self._terrainMRs, meshRenderer)
		end
	end

	if not self._terrainMRs[1] then
		return
	end

	self._isInFog = SurvivalMapModel.instance:isInFog(self._data.pos)

	for _, terrainMR in pairs(self._terrainMRs) do
		SurvivalMapHelper.instance:getSceneFogComp():setBlockStatu(terrainMR, self._isInFog, self._isInRain)
	end
end

function SurvivalBlockEntity:addEventListeners()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapExploredPointUpdate, self._onFogUpdate, self)
end

function SurvivalBlockEntity:removeEventListeners()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapExploredPointUpdate, self._onFogUpdate, self)
end

function SurvivalBlockEntity:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function SurvivalBlockEntity:_onFogUpdate()
	if not self._terrainMRs[1] then
		return
	end

	local isInFog = SurvivalMapModel.instance:isInFog(self._data.pos)

	if isInFog ~= self._isInFog then
		self._isInFog = isInFog

		for _, terrainMR in pairs(self._terrainMRs) do
			SurvivalMapHelper.instance:getSceneFogComp():setBlockStatu(terrainMR, isInFog)
		end
	end
end

function SurvivalBlockEntity:onDestroy()
	return
end

return SurvivalBlockEntity
