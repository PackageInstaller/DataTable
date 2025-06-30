-- chunkname: @IQIGame\\Module\\Util\\EffectUtility.lua

EffectUtility = {}

function EffectUtility.GetEffectTargetObjs(mountType, battleUnit, skillHitPODs)
	local effectTargets = {}

	if mountType == Constant.SkillEffectMountType.SELF or mountType == Constant.SkillEffectMountType.SELF_UNATTACHED then
		table.insert(effectTargets, {
			gameObject = battleUnit.gameObject,
			monsterConfigId = battleUnit.monsterConfigID,
			entityId = battleUnit.entityID
		})
	elseif mountType == Constant.SkillEffectMountType.TARGET or mountType == Constant.SkillEffectMountType.TARGET_UNATTACHED then
		for i = 1, #skillHitPODs do
			local targetUnit = BattleModel.GetBattleUnitByUnitID(skillHitPODs[i].UnitID)

			table.insert(effectTargets, {
				gameObject = targetUnit.gameObject,
				monsterConfigId = targetUnit.monsterConfigId,
				entityId = targetUnit.entityId
			})
		end
	end

	return effectTargets
end
