-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/unit/UnitRetrieveSceneAdjutant.lua

module("logic.extensions.retrieve.scene.unit.UnitRetrieveSceneAdjutant", package.seeall)

local M = class("UnitRetrieveSceneAdjutant", ReusableUnitBase)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)

	self.heroId = false
	self._skinId = false
end

function M:reset()
	M.super.reset(self)
end

function M:getId()
	return self.id
end

function M:setHeroId(heroId)
	self.heroId = heroId
end

function M:getHeroId()
	return self.heroId
end

function M:setSkinId(skinId)
	self._skinId = skinId
end

function M:getSkinId()
	return self._skinId
end

function M:setElementId(elementId)
	self._elementId = elementId
end

function M:getElementId()
	return self._elementId
end

function M:setPointId(pointId)
	self._pointId = pointId
end

function M:getPointId()
	return self._pointId
end

function M:isAdjutant()
	return true
end

function M:setModelId(modelId)
	self._modelId = modelId
end

function M:getModelId()
	return self._modelId
end

function M:getModelData()
	local modelId = self:getModelId()
	local modelData = ModelConfig.instance:getModelData(modelId)

	return modelData
end

function M:getTargetSceneType()
	return SceneType.Retrieve
end

function M:getTag()
	return UnitTag.Player
end

function M:getLayer()
	return SceneLayer.Unit_Value
end

function M:checkInScene()
	local scene = SceneMgr.instance:getCurScene()
	local sceneTyp = scene and scene:getSceneType() or nil

	return sceneTyp == SceneType.Retrieve
end

function M:_initComponents()
	self:_addComponent("meshModel", UnitCompMainSceneMeshModel)
	self:_addComponent("collider", UnitCompCollider)
	self:_addComponent("animClip", UnitCompMainSceneAnimClip)
	self:_addComponent("animCtrl", UnitCompMainSceneAnimCtrl)
	self:_addComponent("animSeqCtrl", UnitCompMainSceneSeqAnimCtrl)
	self:_addComponent("animFaceCtrl", UnitCompMainSceneFaceAnimCtrl)
	self:_addComponent("changeEff", UnitCompMainSceneHeroChangeEff)
	self:_addComponent("xinmaoNode", UnitCompMainHeroXinMao)
	self:_addComponent("enterShow", UnitCompMainSceneEnterShow)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
end

return M
