-- chunkname: @IQIGame\\Module\\Warehouse\\ItemEffect.lua

ItemEffect = {}

function ItemEffect.GetEffectText(resText, effectID, effectParam)
	local resultString = resText

	if effectID == Constant.EffectTypeID.ID_DROP_1 then
		resultString = resText
	elseif effectID == Constant.EffectTypeID.ID_GET_SOUL_1 then
		resultString = string.format(resText, CfgSoulTable[effectParam[1]].Name)
	end

	return resultString
end
