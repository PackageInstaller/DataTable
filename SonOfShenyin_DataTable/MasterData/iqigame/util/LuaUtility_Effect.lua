-- chunkname: @IQIGame\\Util\\LuaUtility_Effect.lua

function LuaUtility.PlayNormalEffect(effectID, position, callBack, layer, sortingLayer, sortingLayerNumber, relativeScale)
	return GameEntry.Effect:PlayNormalEffect(effectID, position, 0, 0, layer or 0, sortingLayer or 0, sortingLayerNumber or 0, relativeScale or 1, false, callBack or nil)
end

function LuaUtility.GetEffectByPlayID(effectPlayID)
	return GameEntry.Effect:GetEffectByPlayID(effectPlayID)
end

function LuaUtility.StopEffect(effectPlayID)
	GameEntry.Effect:StopEffect(effectPlayID)
end

function LuaUtility.StopAllEffect()
	GameEntry.Effect:StopAllEffect()
end

function LuaUtility.SetMemoryFilterVolumeEnable(enable)
	LuaCodeInterface.SetMemoryFilterVolumeEnable(enable)
end

function LuaUtility.SetMemoryFilterVolumeControl(value)
	LuaCodeInterface.SetMemoryFilterVolumeControl(value)
end

function LuaUtility.SetLvFilterVolumeEnable(enable)
	LuaCodeInterface.SetLvFilterVolumeEnable(enable)

	WorldMapModule.isRegularOn = enable

	if not enable then
		EventDispatcher.Dispatch(EventID.MainUI_HideHudDirectEvent)
	end
end

function LuaUtility.GetLvFilterVolumeEnable()
	return LuaCodeInterface.GetLvFilterVolumeEnable()
end

function LuaUtility.SetLvFilterVolumeControl(value)
	LuaCodeInterface.SetLvFilterVolumeControl(value)
end

function LuaUtility.SetShaderGlobalFloatValue(name, value)
	LuaCodeInterface.SetShaderGlobalFloatValue(name, value)
end

function LuaUtility.GetParticleSystemLength(gameObject)
	return LuaCodeInterface.GetParticleSystemLength(gameObject)
end

function LuaUtility.SetTimeStopFilterVolumeEnable(enabled)
	LuaCodeInterface.SetTimeStopFilterVolumeEnable(enabled)
end

function LuaUtility.SetTimeStopFilterVolumeControl(v)
	LuaCodeInterface.SetTimeStopFilterVolumeControl(v)
end

function LuaUtility.SetTimeStopFilterVolumeLerp(v)
	LuaCodeInterface.SetTimeStopFilterVolumeLerp(v)
end

function LuaUtility.SetRainEffectFilterVolumeControl(v)
	LuaCodeInterface.SetRainEffectFilterVolumeControl(v)
end
