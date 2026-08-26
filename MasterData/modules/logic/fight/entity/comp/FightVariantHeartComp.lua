-- chunkname: @modules/logic/fight/entity/comp/FightVariantHeartComp.lua

module("modules.logic.fight.entity.comp.FightVariantHeartComp", package.seeall)

local FightVariantHeartComp = class("FightVariantHeartComp", FightBaseClass)

FightVariantHeartComp.VariantKey = {
	"_STYLIZATIONMOSTER_ON",
	"_STYLIZATIONMOSTER2_ON",
	"_STYLIZATIONMOSTER3_ON",
	"_STYLIZATIONMOSTER2_ON",
	"_STYLE_JOINT_ON",
	"_STYLE_RAIN_STORM_ON",
	"_STYLE_ASSIST_ON",
	"_STYLIZATIONMOSTER4_ON",
	"_STYLE_SHADOW_ON",
	"_STYLIZATIONMOSTER5_ON",
	"_STYLIZATIONMOSTER5_ON",
	"_STYLIZATIONMOSTER5_ON"
}

local TextureKey = "_NoiseMap3"
local TextureName = {
	"noise_01_manual",
	"noise_02_manual",
	"",
	"noise_03_manual",
	"noise_sty_joint2_manual",
	"textures/style_rain_strom_manual",
	"textures/style_assist_noise_manual",
	"textures/noise_05_manual",
	"",
	"textures/noise_06_manual",
	"textures/noise_06_manual",
	"textures/noise_06_manual"
}
local PowKey = "_Pow"
local Pow_w_Value = {
	{
		0.4,
		0.9,
		1.2,
		2.4
	},
	[3] = {
		0.08,
		0.09,
		0.1,
		0.1
	},
	[4] = {
		0,
		0,
		0,
		0
	},
	[5] = {
		0.4,
		0.9,
		1.2,
		2.4
	}
}
local StyOffsetKey = "_StyOffset"
local StyOffset_x_Value = {
	0,
	0,
	0,
	1,
	0,
	nil,
	nil,
	nil,
	nil,
	0,
	1,
	2
}
local effectPrefabDict = {
	[8] = "roleeffects/roleeffect_glitch"
}

function FightVariantHeartComp:onConstructor(entity)
	self.entity = entity
	self._hostEntity = entity
	self.go = entity.go

	self:com_registFightEvent(FightEvent.OnSpineMaterialChange, self._onMatChange, LuaEventSystem.Low)
	self:com_registFightEvent(FightEvent.OnSpineLoaded, self._onSpineLoaded)
end

function FightVariantHeartComp:setEntity(entity)
	self._hostEntity = entity

	self:_change()
end

function FightVariantHeartComp:_onMatChange(entityId, mat)
	if entityId == self.entity.id then
		self:_change()
	end
end

function FightVariantHeartComp:_onSpineLoaded(spine)
	if spine == self.entity.spine then
		self:_change()
	end
end

function FightVariantHeartComp:_change()
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if not self._hostEntity or not self._hostEntity:getMO() then
		return
	end

	local mat, buffMo = self.entity.buff and self.entity.buff:getBuffMatName()

	if not string.nilorempty(mat) then
		local buffCo = buffMo and buffMo:getCO()

		if buffCo then
			local co = lua_buff_mat_variant.configDict[buffCo.typeId]

			if co then
				local variantId = co.variant

				if variantId and FightVariantHeartComp.VariantKey[variantId] then
					self:_changeVariant(variantId)

					return
				end
			end
		end
	end

	local entityMO = self._hostEntity:getMO()
	local monsterCO = entityMO and entityMO:getCO()
	local variantId = monsterCO and monsterCO.heartVariantId

	if not variantId or not FightVariantHeartComp.VariantKey[variantId] then
		return
	end

	if gohelper.isNil(self.entity.go) then
		return
	end

	if not self.entity.spineRenderer:hasSkeletonAnim() then
		return
	end

	self:_changeVariant(variantId)
end

function FightVariantHeartComp:_changeVariant(variantId)
	local variantKey = FightVariantHeartComp.VariantKey[variantId]
	local textureName = TextureName[variantId]
	local styOffset_x_Value = StyOffset_x_Value[variantId]
	local size = FightHelper.getModelSize(self.entity)

	if Pow_w_Value[variantId] then
		local mat = self.entity.spineRenderer:getReplaceMat()

		if not mat then
			return
		end

		if variantKey then
			mat:EnableKeyword(variantKey)
		end

		if Pow_w_Value[variantId] and mat:HasProperty(PowKey) then
			local vec = mat:GetVector(PowKey)

			vec.w = Pow_w_Value[variantId]

			mat:SetVector(PowKey, vec)
		end

		if styOffset_x_Value then
			mat:SetFloat(StyOffsetKey, styOffset_x_Value)
		end

		if not string.nilorempty(textureName) then
			self._texturePath = ResUrl.getRoleSpineMatTex(textureName)

			loadAbAsset(self._texturePath, false, self._onLoadCallback, self)
		end

		local effectRes = effectPrefabDict[variantId]

		if not effectRes then
			self:clearLoader()
			self:clearEffect()

			self.curEffectRes = nil
		elseif not self.effectWrap or self.curEffectRes ~= effectRes then
			self.curEffectRes = effectRes

			self:clearLoader()

			self.effectLoader = MultiAbLoader.New()

			local effectFullPath = FightHelper.getEffectUrlWithLod(effectRes)
			local abPath = FightHelper.getEffectAbPath(effectFullPath)

			self.effectLoader:addPath(abPath)
			self.effectLoader:startLoad(self.onEffectLoaded, self)
		end
	end
end

function FightVariantHeartComp:onEffectLoaded()
	self.effectWrap = self.entity.effect:addHangEffect(self.curEffectRes, ModuleEnum.SpineHangPointRoot)

	self.effectWrap:setLocalPos(0, 0, 0)
end

function FightVariantHeartComp:_onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem

		self._assetItem = assetItem

		assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		local texture = assetItem:GetResource(self._texturePath)
		local mat = self.entity.spineRenderer:getReplaceMat()

		mat:SetTexture(TextureKey, texture)
	end
end

function FightVariantHeartComp:clearEffect()
	if self.effectWrap then
		self.entity.effect:removeEffect(self.effectWrap)

		self.effectWrap = nil
	end
end

function FightVariantHeartComp:clearLoader()
	if self.effectLoader then
		self.effectLoader:dispose()

		self.effectLoader = nil
	end
end

function FightVariantHeartComp:onDestructor()
	self:clearLoader()
	self:clearEffect()

	self.curEffectRes = nil

	if self._assetItem then
		self._assetItem:Release()

		self._assetItem = nil
	end
end

return FightVariantHeartComp
