-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLSetEffectTexture.lua

module("modules.logic.fight.entity.comp.skill.FightTLSetEffectTexture", package.seeall)

local FightTLSetEffectTexture = class("FightTLSetEffectTexture", FightTimelineTrackItem)
local PropertyId = UnityEngine.Shader.PropertyToID("_MainTex")

function FightTLSetEffectTexture:onTrackStart(fightStepData, duration, paramsArr)
	self.fightStepData = fightStepData
	self.waitSetTextureGoList = {}

	self:loadIcon()
	FightController.instance:registerCallback(FightEvent.EntityEffectLoaded, self.onEffectLoadDone, self)
end

function FightTLSetEffectTexture:getSkillId()
	if self.fightStepData then
		if not self.fightStepData then
			return
		end

		local targetEffectId = FightEnum.EffectType.BUFFACTINFOUPDATE
		local targetBuffActId = FightEnum.BuffActId.ButterflyRecordSkill

		for _, actInfo in ipairs(self.fightStepData) do
			if actInfo.effectType == targetEffectId then
				local buffActInfo = actInfo.buffActInfo

				if buffActInfo.actId == targetBuffActId then
					local array = FightStrUtil.instance:getSplitToNumberCache(buffActInfo.strParam, ",")

					return array and array[2]
				end
			end
		end
	end
end

function FightTLSetEffectTexture:loadIcon()
	local recordSkillId = self:getSkillId()
	local skillCo = recordSkillId and lua_skill.configDict[recordSkillId]
	local resUrl = skillCo and ResUrl.getSkillIcon(skillCo.icon)

	if string.nilorempty(resUrl) then
		return
	end

	self.textureLoader = MultiAbLoader.New()

	self.textureLoader:addPath(resUrl)
	self.textureLoader:startLoad(self.onLoadIconDone, self)
end

function FightTLSetEffectTexture:onLoadIconDone()
	local assetItem = self.textureLoader:getFirstAssetItem()

	self.texture = assetItem and assetItem:GetResource()

	self:trySetTexture()
end

function FightTLSetEffectTexture:trySetTexture()
	if not self.texture then
		return
	end

	for _, go in ipairs(self.waitSetTextureGoList) do
		local render = go:GetComponent(gohelper.Type_Render)
		local mat = render and render.material

		if mat then
			mat:SetTexture(PropertyId, self.texture)
		end
	end

	tabletool.clear(self.waitSetTextureGoList)
end

function FightTLSetEffectTexture:onEffectLoadDone(entityId, effectWrap)
	local effectPath = effectWrap.path

	if string.nilorempty(effectPath) then
		return
	end

	local effectName = ResUrl.getEffectName(effectPath)

	if string.nilorempty(effectName) then
		return
	end

	local effectCo = lua_fight_hudie_special_effect.configDict[effectName]

	if not effectCo then
		return
	end

	local path = effectCo.path
	local node = gohelper.findChild(effectWrap.effectGO, path)

	if not node then
		logError(string.format("`%s` 特效 没有 `%s` 节点", effectName, path))

		return
	end

	table.insert(self.waitSetTextureGoList, node)
	self:trySetTexture()
end

function FightTLSetEffectTexture:clear()
	if self.textureLoader then
		self.textureLoader:dispose()

		self.textureLoader = nil
	end

	tabletool.clear(self.waitSetTextureGoList)
	FightController.instance:unregisterCallback(FightEvent.EntityEffectLoaded, self.onEffectLoadDone, self)
end

function FightTLSetEffectTexture:onTrackEnd()
	self:clear()
end

function FightTLSetEffectTexture:onDestructor()
	self:clear()
end

return FightTLSetEffectTexture
