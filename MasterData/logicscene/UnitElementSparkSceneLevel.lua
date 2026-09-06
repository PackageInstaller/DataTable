-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/elementspark/UnitElementSparkSceneLevel.lua

module("logicscene.scene.unit.impl.elementspark.UnitElementSparkSceneLevel", package.seeall)

local UnitElementSparkSceneLevel = class("UnitElementSparkSceneLevel", SceneUnitBase)

function UnitElementSparkSceneLevel:getTag()
	return UnitTag.SceneElement
end

function UnitElementSparkSceneLevel:getLayer()
	return SceneLayer.Default_Value
end

function UnitElementSparkSceneLevel:Awake()
	UnitElementSparkSceneLevel.super.Awake(self)
end

function UnitElementSparkSceneLevel:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
end

function UnitElementSparkSceneLevel:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, 0)
end

function UnitElementSparkSceneLevel:onUnitVisible(go)
	UnitElementSparkSceneLevel.super.onUnitVisible(self, go)
	self:updateLevel()
end

function UnitElementSparkSceneLevel:updateLevel()
	if not self:isVisible() then
		return
	end

	local go = self:getGameObject()

	if not go then
		return
	end

	local atlas = go:GetComponent(ComponentType.UIImageSpriteAtlas)
	local render = go:GetComponent(ComponentType.SpriteRenderer)
	local belong = ElementSparkModel.instance:getChunkBelong(self.chunkId)
	local enabled = belong > 0

	render.enabled = enabled

	if enabled then
		local planId = ElementSparkController.instance:getMapPlanId()
		local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, self.chunkId)
		local idx = 0

		if chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Guard then
			local level = ElementSparkModel.instance:getChunkLevel(self.chunkId)

			idx = (belong - 1) * 3 + level - 1
		else
			idx = (belong - 1) * 3
		end

		render.sprite = atlas:GetSpriteByIndex(idx)
	end
end

return UnitElementSparkSceneLevel
