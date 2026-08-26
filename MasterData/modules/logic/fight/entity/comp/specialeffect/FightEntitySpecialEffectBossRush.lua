-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffectBossRush.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBossRush", package.seeall)

local FightEntitySpecialEffectBossRush = class("FightEntitySpecialEffectBossRush", FightBaseClass)
local VariantKey = "_STYLIZATIONMOSTER2_ON"
local NoiceMapKey = "_NoiseMap3"
local NoiseMapName = "noise_02_manual"
local PowKey = "_Pow"
local Pow_w_Value = {
	0,
	0.75,
	0.85,
	0.95
}
local BuffBreakId = {
	[51400031] = true,
	[514000102] = true
}

function FightEntitySpecialEffectBossRush:onConstructor(entity)
	self._entity = entity
	self._textureAssetItem = nil
	self._texture = nil
	self._isLoadingTexture = false
	self._stageEffectList = {}

	self:com_registSingleTimer(self._delayCheckMat, 0.01)
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
	self:com_registFightEvent(FightEvent.OnSpineLoaded, self._onSpineLoaded)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
end

function FightEntitySpecialEffectBossRush:_onSkillPlayStart(entity, skillId, fightStepData, timelineName)
	if entity and self._entity ~= entity and entity:getMO() and FightCardDataHelper.isBigSkill(skillId) then
		self._uniqueSkill = skillId

		self:hideSpecialEffects("UniqueSkill")
	end
end

function FightEntitySpecialEffectBossRush:_onSkillPlayFinish(entity, skillId, fightStepData, timelineName)
	if self._uniqueSkill and skillId == self._uniqueSkill then
		self._uniqueSkill = nil

		self:showSpecialEffects("UniqueSkill")
	end
end

function FightEntitySpecialEffectBossRush:_onBuffUpdate(targetId, effectType, buffId, buffUid)
	if targetId ~= self._entity.id then
		return
	end

	if BuffBreakId[buffId] then
		if effectType == FightEnum.EffectType.BUFFDEL then
			local mat = self._entity.spineRenderer:getReplaceMat()

			if mat then
				mat:DisableKeyword(VariantKey)
			end

			self:_delayCheckMat()
		else
			local delay = 0.5 / FightModel.instance:getSpeed()

			self:com_registSingleTimer(self._delayCheckMat, delay)
		end
	end
end

function FightEntitySpecialEffectBossRush:_delayCheckMat()
	self._pow_w_Value = nil

	local mat = self._entity.spineRenderer:getReplaceMat()

	if not mat then
		return
	end

	local pow_w_Value = 0
	local buffDic = self._entity:getMO():getBuffDic()
	local hasBreakBuff = false

	for _, buffMO in pairs(buffDic) do
		if BuffBreakId[buffMO.buffId] then
			hasBreakBuff = true
			pow_w_Value = 1

			break
		end
	end

	local bossStage
	local hasStageEffect = false

	if not hasBreakBuff then
		local info = BossRushModel.instance:getMultiHpInfo()

		if info then
			if not info.multiHpIdx then
				local multiHpIdx = 0

				bossStage = multiHpIdx + 1
				bossStage = Mathf.Clamp(multiHpIdx + 1, 1, 4)

				if multiHpIdx + 1 ~= 1 then
					hasStageEffect = true
					pow_w_Value = Pow_w_Value[bossStage]
				end
			end
		end
	end

	self:_dealHangPointEffect(bossStage, hasBreakBuff)

	if not hasBreakBuff and not hasStageEffect then
		return
	end

	self._pow_w_Value = pow_w_Value

	mat:EnableKeyword(VariantKey)

	local vec = mat:GetVector(PowKey)

	vec.w = pow_w_Value

	mat:SetVector(PowKey, vec)

	if self._isLoadingTexture then
		return
	end

	if self._texture then
		self:_setTexture()
	else
		loadAbAsset(ResUrl.getRoleSpineMatTex(NoiseMapName), false, self._onLoadCallback, self)
	end
end

function FightEntitySpecialEffectBossRush:_onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self._textureAssetItem

		self._isLoadingTexture = false
		self._textureAssetItem = assetItem

		assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		self._texture = assetItem:GetResource()

		self:_setTexture()
	end
end

function FightEntitySpecialEffectBossRush:_setTexture()
	local mat = self._entity.spineRenderer:getReplaceMat()

	mat:SetTexture(NoiceMapKey, self._texture)

	local entitys = FightHelper.getSideEntitys(self._entity:getSide())

	for _, partEntity in ipairs(entitys) do
		if partEntity ~= self._entity then
			self:_setOtherPartMat(partEntity)
		end
	end
end

function FightEntitySpecialEffectBossRush:_onSpineLoaded(unitSpine)
	if not self._pow_w_Value or self._pow_w_Value == 1 then
		return
	end

	local partEntity = unitSpine.unitSpawn

	if partEntity:getSide() == self._entity:getSide() and partEntity ~= self._entity then
		self:_setOtherPartMat(partEntity)
	end
end

function FightEntitySpecialEffectBossRush:_setOtherPartMat(partEntity)
	if not self._pow_w_Value or self._pow_w_Value == 1 then
		return
	end

	if partEntity.spineRenderer then
		local partEntityMat = partEntity.spineRenderer:getReplaceMat()

		if partEntityMat then
			partEntityMat:EnableKeyword(VariantKey)

			local vec = partEntityMat:GetVector(PowKey)

			vec.w = self._pow_w_Value

			partEntityMat:SetVector(PowKey, vec)
			partEntityMat:SetTexture(NoiceMapKey, self._texture)
		end
	end
end

function FightEntitySpecialEffectBossRush:_dealHangPointEffect(bossStage, hasBreakBuff)
	for _, effectWrap in ipairs(self._stageEffectList) do
		FightEffectPool.returnEffect(effectWrap)
		FightEffectPool.returnEffectToPoolContainer(effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, effectWrap)
	end

	tabletool.clear(self._stageEffectList)

	if hasBreakBuff then
		return
	end

	local skinId = self._entity:getMO().skin
	local cos = lua_bossrush_skin_effect.configDict[skinId]

	if cos then
		local side = self._entity:getSide()

		for _, co in pairs(cos) do
			if bossStage == co.stage then
				local paths = string.split(co.effects, "#")
				local hangPoints = string.split(co.hangpoints, "#")
				local scales = string.split(co.scales, "#")

				for i, path in ipairs(paths) do
					if not hangPoints[i] then
						local hangPoint = ModuleEnum.SpineHangPointRoot
						local hangPointGO = self._entity:getHangPoint(hangPoint)
						local effectFullPath = FightHelper.getEffectUrlWithLod(path)
						local effectWrap = FightEffectPool.getEffect(effectFullPath, side, nil, nil, hangPointGO)

						FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)
						effectWrap:setLocalPos(0, 0, 0)

						local scaleArr = string.splitToNumber(scales[i], ",")

						effectWrap:setEffectScale(scaleArr[1] or 1, scaleArr[2] or 1, scaleArr[3] or 1)
						table.insert(self._stageEffectList, effectWrap)
					end
				end

				break
			end
		end
	end
end

function FightEntitySpecialEffectBossRush:showSpecialEffects(key)
	if not self._stageEffectList then
		return
	end

	self:_clearMissingEffect()

	for _, effectWrap in ipairs(self._stageEffectList) do
		effectWrap:setActive(true, key or self.__cname)
	end
end

function FightEntitySpecialEffectBossRush:hideSpecialEffects(key)
	if not self._stageEffectList then
		return
	end

	self:_clearMissingEffect()

	for _, effectWrap in ipairs(self._stageEffectList) do
		effectWrap:setActive(false, key or self.__cname)
	end
end

function FightEntitySpecialEffectBossRush:_clearMissingEffect()
	for i = #self._stageEffectList, 1, -1 do
		if gohelper.isNil(self._stageEffectList[i].containerGO) then
			table.remove(self._stageEffectList, i)
		end
	end
end

function FightEntitySpecialEffectBossRush:onDestructor()
	if self._stageEffectList then
		for _, effectWrap in ipairs(self._stageEffectList) do
			FightEffectPool.returnEffect(effectWrap)
			FightEffectPool.returnEffectToPoolContainer(effectWrap)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, effectWrap)
		end
	end

	self._stageEffectList = nil

	if self._textureAssetItem then
		self._textureAssetItem:Release()

		self._textureAssetItem = nil
	end

	self._texture = nil
end

return FightEntitySpecialEffectBossRush
