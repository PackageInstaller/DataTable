-- chunkname: @modules/logic/scene/luacomp/SceneLuaCompSpineDynamicShadow.lua

module("modules.logic.scene.luacomp.SceneLuaCompSpineDynamicShadow", package.seeall)

local SceneLuaCompSpineDynamicShadow = class("SceneLuaCompSpineDynamicShadow", LuaCompBase)

function SceneLuaCompSpineDynamicShadow:ctor(param)
	if string.nilorempty(param[1]) then
		logError("场景阴影贴图未配置，请检查 C场景表.xlsx-export_场景表现")

		return
	end

	self._texturePath = ResUrl.getRoleSpineMatTex(param[1])

	if param[2] then
		local param2 = string.splitToNumber(param[2], "#")

		self._vec_ShadowMap_ST = Vector4.New(param2[1], param2[2], param2[3], param2[4])
	end

	if param[3] then
		local param3 = string.splitToNumber(param[3], "#")

		self._vec_ShadowMapOffset = Vector4.New(param3[1], param3[2], param3[3], param3[4])
	end
end

function SceneLuaCompSpineDynamicShadow:init(go)
	self._loader = MultiAbLoader.New()
	self._needSetMatDict = nil
end

function SceneLuaCompSpineDynamicShadow:addEventListeners()
	self.addEventCb(self, FightController.instance, FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSpineMaterialChange, self._onSpineMatChange, self)
end

function SceneLuaCompSpineDynamicShadow:removeEventListeners()
	self.removeEventCb(self, FightController.instance, FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSpineMaterialChange, self._onSpineMatChange, self)
end

function SceneLuaCompSpineDynamicShadow:onStart()
	if not self._texturePath then
		return
	end

	self._loader:addPath(self._texturePath)
	self._loader:startLoad(self._onLoadCallback, self)

	local allEntitys = FightHelper.getAllEntitys()

	for _, entity in ipairs(allEntitys) do
		if entity.spine and entity.spine:getSpineGO() then
			self:_setSpineMat(entity.spineRenderer:getReplaceMat())
		end
	end
end

function SceneLuaCompSpineDynamicShadow:_onLoadCallback()
	if self._needSetMatDict then
		for material, _ in pairs(self._needSetMatDict) do
			self:_setSpineMat(material)
		end

		self._needSetMatDict = nil
	end
end

function SceneLuaCompSpineDynamicShadow:_onSpineLoaded(unitSpine)
	self:_setSpineMat(unitSpine.unitSpawn.spineRenderer:getReplaceMat())
end

function SceneLuaCompSpineDynamicShadow:_onSpineMatChange(entityId, material)
	self:_setSpineMat(material)
end

function SceneLuaCompSpineDynamicShadow:_setSpineMat(material)
	if not material then
		return
	end

	if self._loader then
		local assetItem = self._loader:getFirstAssetItem()

		if assetItem then
			local texture = assetItem:GetResource(self._texturePath)

			material:EnableKeyword("_SHADOW_DYNAMIC_ON")

			if self._vec_ShadowMap_ST then
				material:SetVector("_ShadowMap_ST", self._vec_ShadowMap_ST)
			end

			if self._vec_ShadowMapOffset then
				material:SetVector("_ShadowMapOffset", self._vec_ShadowMapOffset)
			end

			material:SetTexture("_ShadowMap", texture)
		else
			self._needSetMatDict = self._needSetMatDict or {}
			self._needSetMatDict[material] = true
		end
	end
end

function SceneLuaCompSpineDynamicShadow:onDestroy()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._needSetMatDict = nil
end

return SceneLuaCompSpineDynamicShadow
