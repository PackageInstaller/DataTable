-- chunkname: @modules/logic/fight/entity/comp/FightVariantCrayonComp.lua

module("modules.logic.fight.entity.comp.FightVariantCrayonComp", package.seeall)

local FightVariantCrayonComp = class("FightVariantCrayonComp", FightBaseClass)
local SceneNames = {
	m_s62_jzsylb = true
}
local VariantKey = "_STYLIZATIONPLAYER_ON"
local NoiceMapKey = "_NoiseMap3"
local ShadowMapKey = "_ShadowMap"
local NoiceMapName = "crayonmap1_manual"
local ShadowMapName = "crayonmap2_manual"

function FightVariantCrayonComp:onConstructor(entity)
	self.entity = entity
	self.go = entity.go

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded)
	self:com_registFightEvent(FightEvent.OnSpineMaterialChange, self._onMatChange, LuaEventSystem.Low)
	self:com_registFightEvent(FightEvent.OnSpineLoaded, self._onSpineLoaded)
end

function FightVariantCrayonComp:_onMatChange(entityId, mat)
	if entityId == self.entity.id then
		self:_change()
	end
end

function FightVariantCrayonComp:_onSpineLoaded(spine)
	if spine == self.entity.spine then
		self:_change()
	end
end

function FightVariantCrayonComp:_onLevelLoaded()
	if self:_needChange() then
		self:_change()
	else
		local mat = self.entity.spineRenderer:getReplaceMat()

		if not mat then
			return
		end

		mat:DisableKeyword(VariantKey)
	end
end

function FightVariantCrayonComp:_needChange()
	local levelId = GameSceneMgr.instance:getCurScene():getCurLevelId()
	local sceneLevelCO = lua_scene_level.configDict[levelId]

	return SceneNames[sceneLevelCO.resName] ~= nil
end

function FightVariantCrayonComp:_change()
	if not self:_needChange() then
		return
	end

	local mat = self.entity.spineRenderer:getReplaceMat()

	if not mat then
		return
	end

	mat:EnableKeyword(VariantKey)

	self._noiceMapPath = ResUrl.getRoleSpineMatTex(NoiceMapName)
	self._shadowMapPath = ResUrl.getRoleSpineMatTex(ShadowMapName)

	loadAbAsset(self._noiceMapPath, false, self._onLoadCallback1, self)
	loadAbAsset(self._shadowMapPath, false, self._onLoadCallback2, self)
end

function FightVariantCrayonComp:_onLoadCallback1(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem1

		self._assetItem1 = assetItem

		assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		local texture = assetItem:GetResource(self._noiceMapPath)
		local mat = self.entity.spineRenderer:getReplaceMat()

		mat:SetTexture(NoiceMapKey, texture)
	end
end

function FightVariantCrayonComp:_onLoadCallback2(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem2

		self._assetItem2 = assetItem

		assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		local texture = assetItem:GetResource(self._shadowMapPath)
		local mat = self.entity.spineRenderer:getReplaceMat()

		mat:SetTexture(ShadowMapKey, texture)
	end
end

function FightVariantCrayonComp:onDestructor()
	if self._assetItem1 then
		self._assetItem1:Release()

		self._assetItem1 = nil
	end

	if self._assetItem2 then
		self._assetItem2:Release()

		self._assetItem2 = nil
	end
end

return FightVariantCrayonComp
