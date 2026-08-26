-- chunkname: @modules/logic/explore/map/unit/ExplorePrismUnit.lua

module("modules.logic.explore.map.unit.ExplorePrismUnit", package.seeall)

local ExplorePrismUnit = class("ExplorePrismUnit", ExploreBaseLightUnit)

function ExplorePrismUnit:getLightRecvType()
	return ExploreEnum.LightRecvType.Custom
end

function ExplorePrismUnit:onLightEnter(lightMO)
	if not self.mo:isInteractEnabled() then
		return
	end

	local mapLight = ExploreController.instance:getMapLight()

	mapLight:beginCheckStatusChange(self.id, self:haveLight())
	self:addLights()
	mapLight:endCheckStatus()
end

function ExplorePrismUnit:onInteractChange(nowInteract)
	ExplorePrismUnit.super.onInteractChange(self, nowInteract)

	if self.animComp._curAnim ~= ExploreAnimEnum.AnimName.uToN then
		local mapLight = ExploreController.instance:getMapLight()

		mapLight:beginCheckStatusChange(self.id, self:haveLight())
		self:checkLight()
		mapLight:endCheckStatus()
	else
		ExploreModel.instance:setStepPause(true)
	end
end

function ExplorePrismUnit:onAnimEnd(preAnim, nowAnim)
	ExplorePrismUnit.super.onAnimEnd(self, preAnim, nowAnim)

	if preAnim == ExploreAnimEnum.AnimName.uToN then
		local mapLight = ExploreController.instance:getMapLight()

		mapLight:beginCheckStatusChange(self.id, self:haveLight())
		self:checkLight()
		mapLight:endCheckStatus()
		ExploreModel.instance:setStepPause(false)
	end
end

function ExplorePrismUnit:onLightExit()
	local mapLight = ExploreController.instance:getMapLight()

	mapLight:beginCheckStatusChange(self.id, self:haveLight())
	self:removeLights()
	mapLight:endCheckStatus()
end

function ExplorePrismUnit:setEmitLight(isNoEmit)
	ExplorePrismUnit.super.setEmitLight(self, isNoEmit)

	if isNoEmit then
		local mapLight = ExploreController.instance:getMapLight()

		mapLight:removeUnitEmitLight(self)
		self:removeLights()
		mapLight:updateLightsByUnit(self)
		self:playAnim(self:getIdleAnim())
	else
		self:checkLight()
	end
end

function ExplorePrismUnit:checkLight()
	local map = ExploreController.instance:getMap()

	if not map:isInitDone() then
		return
	end

	local mapLight = ExploreController.instance:getMapLight()

	if not self.mo:isInteractEnabled() then
		mapLight:removeUnitEmitLight(self)
		self:removeLights()
		mapLight:updateLightsByUnit(self)

		return
	end

	local haveLight = self:haveLight()

	mapLight:beginCheckStatusChange(self.id, self:haveLight())
	mapLight:removeUnitEmitLight(self)
	mapLight:updateLightsByUnit(self)
	self:removeLights()

	if self:isHaveIlluminant() and not self._isNoEmitLight then
		self:addLights()
	end

	mapLight:endCheckStatus()
end

function ExplorePrismUnit:haveLight()
	return self.lightComp:haveLight()
end

function ExplorePrismUnit:onBallLightChange()
	self:checkLight()
end

function ExplorePrismUnit:addLights()
	self.lightComp:addLight(self.mo.unitDir)
end

function ExplorePrismUnit:removeLights()
	self.lightComp:removeAllLight()
end

function ExplorePrismUnit:isCustomShowOutLine()
	local showIcon = not self.mo:isInteractEnabled()

	return showIcon, showIcon and "modules/explore/common/sprite/prefabs/msts_icon_xiuli.prefab"
end

function ExplorePrismUnit:isHaveIlluminant()
	local mapLight = ExploreController.instance:getMapLight()

	return mapLight:haveLight(self)
end

function ExplorePrismUnit:getFixItemId()
	return self.mo.fixItemId
end

return ExplorePrismUnit
