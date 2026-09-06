-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/elementspark/UnitElementSparkElem.lua

module("logicscene.scene.unit.impl.elementspark.UnitElementSparkElem", package.seeall)

local UnitElementSparkElem = class("UnitElementSparkElem", SceneUnitBase)

function UnitElementSparkElem:getTag()
	return UnitTag.TilingSceneElem
end

function UnitElementSparkElem:getLayer()
	return SceneLayer.InteractiveObject_Value
end

function UnitElementSparkElem:Awake()
	self._planId = ElementSparkController.instance:getMapPlanId()
	self._chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(self._planId, self.chunkId)

	UnitElementSparkElem.super.Awake(self)
end

function UnitElementSparkElem:_initComponents()
	self:_addComponent("transform", UnitCompTransform)

	if self._chunkCfg.chunkType ~= GameEnum.ElementSparkChunkType.Blank and self._chunkCfg.chunkType ~= GameEnum.ElementSparkChunkType.Guard then
		self:_addComponent("hud", UnitCompHudElementSpark)
	end

	self:_addComponent("hudTag", UnitCompHudElementSparkTag)
end

function UnitElementSparkElem:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, 0)

	if self.hud then
		self.hud:setHudOffset(0, 1, 0)

		self.hud.chunkId = self.chunkId
	end
end

function UnitElementSparkElem:onUnitDestroyed()
	self:clearSceneUnit()
	self:OnDestroy()
end

function UnitElementSparkElem:onUnitInVisible(go)
	UnitElementSparkElem.super.onUnitInVisible(self, go)
	ElementSparkSceneController.instance:removeUnit(self.chunkId, self.id)
end

function UnitElementSparkElem:onUnitVisible(go)
	UnitElementSparkElem.super.onUnitVisible(self, go)
	ElementSparkSceneController.instance:addUnit(self.chunkId, self.id)

	local collider = go:GetComponentInChildren(ComponentType.BoxCollider)

	collider = collider or go:GetComponentInChildren(ComponentType.CapsuleCollider)

	if collider then
		local cgo = collider.gameObject

		cgo.name = go.name
		cgo.layer = self:getLayer()

		goutil.setActive(cgo, self._chunkCfg.chunkType ~= "blank")
	end

	go.layer = self._chunkCfg.chunkType == "blank" and SceneLayer.Default_Value or self:getLayer()

	self:_setIcon(go)
	self:_setOrder()
	self:updateHud()
end

function UnitElementSparkElem:_setOrder()
	if not self._gameObject then
		return
	end

	GoUtil.SetSortingOrder(self._gameObject, self._chunkCfg.chunkOrder)

	local txt = goutil.findChild(self._gameObject, "text")

	if txt then
		GoUtil.SetSortingOrder(txt, self._chunkCfg.chunkOrder + 1000)
	end
end

function UnitElementSparkElem:getUnitHudDesc()
	local belongCampId = ElementSparkModel.instance:getChunkBelong(self.chunkId)
	local activityId = ElementSparkController.instance:getActivityId()
	local zhanlingStr = ""

	if self._chunkCfg.chunkType ~= GameEnum.ElementSparkChunkType.Camp then
		if belongCampId > 0 then
			local campCfg = ElementSparkConfig.instance:getCampCfgById(activityId, belongCampId)

			zhanlingStr = string.format("\n%s占领", campCfg.name)
		else
			zhanlingStr = "\n未占领"
		end
	end

	return string.format("%s%s", self._chunkCfg.chunkName, zhanlingStr)
end

function UnitElementSparkElem:updateHud()
	if not self:isVisible() then
		return
	end

	local go = self:getGameObject()

	if not go then
		return
	end

	if self.hud then
		self.hud:_setHud()
	end

	if self.hudTag then
		self.hudTag:_setHud()
	end
end

function UnitElementSparkElem:_setIcon(go)
	local icon = goutil.findChild(go, "icon")

	if not icon then
		return
	end

	if self._chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Guard then
		local render = icon:GetComponent(ComponentType.SpriteRenderer)
		local atlas = icon:GetComponent(ComponentType.UIImageSpriteAtlas)
		local level = self._chunkCfg.star
		local idx = level - 2

		render.sprite = atlas:GetSpriteByIndex(idx)
	elseif self._chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Camp then
		local render = icon:GetComponent(ComponentType.SpriteRenderer)
		local atlas = icon:GetComponent(ComponentType.UIImageSpriteAtlas)
		local belong = ElementSparkModel.instance:getChunkBelong(self.chunkId)

		render.sprite = atlas:GetSpriteByIndex(belong - 1)
	end
end

return UnitElementSparkElem
