-- chunkname: @IQIGame\\Module\\Battle\\Util\\BattleEffectUtility.lua

BattleEffectUtility = {}

function BattleEffectUtility.HideCommonEffect(effectPlayID)
	LuaUtility.StopEffect(effectPlayID)
end

function BattleEffectUtility.ShowCommonEffectToTransform(effectID, targetTransform, showSuccessCallback)
	if targetTransform == nil then
		logError("BattleEffectUtility.ShowCommonEffectToTransform : targetTransform is nil.")

		return 0
	end

	return LuaUtility.PlayNormalEffect(effectID, targetTransform.position, showSuccessCallback)
end

function BattleEffectUtility.ShowCommonEffectToGrid(effectID, gridIndex, gridEffectAnchor, showSuccessCallback)
	local battleGridView = BattleView.GetGridByGridIndex(gridIndex)

	if battleGridView == nil then
		logError("BattleEffectUtility.ShowCommonEffectToGrid : gridIndex={0} is invalid.", gridIndex)

		return 0
	end

	local gridEffectTransform = battleGridView.gridEffectAnchors[gridEffectAnchor or 0]

	if gridEffectTransform == nil then
		logError("BattleEffectUtility.ShowCommonEffectToGrid : gridEffectAnchor={0} is invalid.", gridEffectAnchor)

		return 0
	end

	return BattleEffectUtility.ShowCommonEffectToTransform(effectID, gridEffectTransform, showSuccessCallback)
end
