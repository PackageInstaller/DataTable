-- chunkname: @modules/logic/fight/model/SkillEffectStatModel.lua

module("modules.logic.fight.model.SkillEffectStatModel", package.seeall)

local SkillEffectStatModel = class("SkillEffectStatModel", ListScrollModel)

function SkillEffectStatModel:onInit()
	self.idCounter = 1
	self.toggleId = 1
	self.titleMO = {}
	self.maxMO = {}
	self.totalMO = {}
	self.type1MOList = {}
	self.type2MOList = {}
	self.type1MOCount = 0
	self.type2MOCount = 0

	self:clearStat()
end

function SkillEffectStatModel:switchTab(toggleId)
	self.toggleId = toggleId
end

function SkillEffectStatModel:clearStat()
	self._maxParticleSystem = 0
	self._maxParticleCount = 0
	self._maxMaterialCount = 0
	self._maxTextureCount = 0
end

function SkillEffectStatModel:statistic()
	self.type1MOCount = 0
	self.type2MOCount = 0
	self.idCounter = 1

	local effectPrefabList = {}
	local usingDict = FightEffectPool.getId2UsingWrapDict()

	for _, wrap in pairs(usingDict) do
		if not gohelper.isNil(wrap.effectGO) then
			table.insert(effectPrefabList, wrap.effectGO)
		end
	end

	local max1, max2, max3, max4 = 0, 0, 0, 0

	for _, effectGO in ipairs(effectPrefabList) do
		local c1, c2, c3, c4 = self:_statSingle(effectGO)

		if c1 > 0 or c2 > 0 or c3 > 0 or c4 > 0 then
			self.type2MOCount = self.type2MOCount + 1

			local type2MO = self.type2MOList[self.type2MOCount]

			if not type2MO then
				type2MO = {}
				self.type2MOList[self.type2MOCount] = type2MO
			end

			self:_setMO(type2MO, effectGO.name, effectGO, c1, c2, c3, c4)
		end

		max1 = max1 + c1
		max2 = max2 + c2
		max3 = max3 + c3
		max4 = max4 + c4
	end

	self:_setMO(self.titleMO, "", nil, "粒子系统", "粒子数", "材质数", "贴图数")
	self:_setMO(self.totalMO, "总计", nil, max1, max2, max3, max4)

	if max1 < self._maxParticleSystem then
		self._maxParticleSystem = self._maxParticleSystem or max1
	end

	if max2 < self._maxParticleCount then
		self._maxParticleCount = self._maxParticleCount or max2
	end

	if max3 < self._maxMaterialCount then
		self._maxMaterialCount = self._maxMaterialCount or max3
	end

	if max4 < self._maxTextureCount then
		self._maxTextureCount = self._maxTextureCount or max4
	end

	self:_setMO(self.maxMO, "最大数", nil, self._maxParticleSystem, self._maxParticleCount, self._maxMaterialCount, self._maxTextureCount)

	local list = {}

	if self.toggleId == 1 then
		for i = 1, self.type1MOCount do
			table.insert(list, self.type1MOList[i])
		end
	else
		for i = 1, self.type2MOCount do
			table.insert(list, self.type2MOList[i])
		end
	end

	table.sort(list, function(mo1, mo2)
		if mo1.particleCount ~= mo2.particleCount then
			return mo1.particleCount > mo2.particleCount
		elseif mo1.particleSystem ~= mo2.particleSystem then
			return mo1.particleSystem > mo2.particleSystem
		else
			return mo1.id < mo2.id
		end
	end)
	table.insert(list, 1, self.totalMO)
	table.insert(list, 1, self.maxMO)
	table.insert(list, 1, self.titleMO)
	self:setList(list)
end

function SkillEffectStatModel:_statSingle(go)
	if not go.activeInHierarchy then
		return 0, 0, 0, 0
	end

	local c1, c2, c3, c4 = 0, 0, 0, 0
	local particleSystem = go:GetComponent(typeof("UnityEngine.ParticleSystem"))

	if particleSystem then
		c1 = c1 + 1
		c2 = c2 + particleSystem.particleCount
	end

	local renderer = go:GetComponent(typeof("UnityEngine.Renderer"))

	if renderer then
		local sharedMaterials = renderer.sharedMaterials
		local len = sharedMaterials.Length

		for i = 0, len - 1 do
			local material = sharedMaterials[i]

			if not gohelper.isNil(material) then
				c3 = c3 + 1

				local texturePropertyNames = material:GetTexturePropertyNames()

				for j = 0, texturePropertyNames.Length - 1 do
					local texturePropertyName = texturePropertyNames[j]

					if material:GetTexture(texturePropertyName) then
						c4 = c4 + 1
					end
				end
			end
		end
	end

	if c1 > 0 or c2 > 0 or c3 > 0 or c4 > 0 then
		self.type1MOCount = self.type1MOCount + 1

		local type1MO = self.type1MOList[self.type1MOCount]

		if not type1MO then
			type1MO = {}
			self.type1MOList[self.type1MOCount] = type1MO
		end

		self:_setMO(type1MO, go.name, go, c1, c2, c3, c4)
	end

	local tr = go.transform
	local childCount = tr.childCount

	for i = 0, childCount - 1 do
		local cc1, cc2, cc3, cc4 = self:_statSingle(tr:GetChild(i).gameObject)

		c1 = c1 + cc1
		c2 = c2 + cc2
		c3 = c3 + cc3
		c4 = c4 + cc4
	end

	return c1, c2, c3, c4
end

function SkillEffectStatModel:_setMO(type1MO, name, go, c1, c2, c3, c4)
	type1MO.name = name
	type1MO.go = go
	type1MO.particleSystem = c1
	type1MO.particleCount = c2
	type1MO.materialCount = c3
	type1MO.textureCount = c4
	type1MO.id = self.idCounter
	self.idCounter = self.idCounter + 1
end

SkillEffectStatModel.instance = SkillEffectStatModel.New()

return SkillEffectStatModel
