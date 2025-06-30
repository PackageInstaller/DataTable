-- chunkname: @IQIGame\\Net\\NetSoulResponse.lua

function net_soul.evolutionResult(code, soul)
	SoulModule.OnResultSoulEvolution(soul)
end

function net_soul.updateSoul(soul)
	if not LotteryModule.PushUpdateSoulMsgWhenDrawing(soul) then
		SoulModule.OnUpdateSoul(soul)
	end
end

function net_soul.resetTalentResult(code, soul, getItems)
	SoulModule.OnReqResetTalent(soul, getItems)
end

function net_soul.useSoulExpItemResult(code)
	SoulModule.OnReqAddExp()
end

function net_soul.unlockSkillResult(code)
	SoulModule.OnReqUnlockSkill()
end

function net_soul.unlockResult_delegate(code)
	NetCommController.Responded()
	SoulModule.OnResultUnlockSoul(code)
end

function net_soul.activeTalentResult(code, soul)
	SoulModule.OnResultActivateTalent(soul)
end

function net_soul.activeTalentGroupResult(code, soul)
	SoulModule.OnReqActiveTalentGroupResult(soul)
end

function net_soul.activationSkillStrengthenResult(code)
	SoulModule.ActivationSkillStrengthenResult()
end

function net_soul.notifySoulMood(soulCid, oldMood, nowMood, type)
	SoulModule.UpdateSoulMood(soulCid, oldMood, nowMood, type)
end

function net_soul.unlockSkillGroupResult(code)
	SkillModule.UnlockSkillGroupResult()
end

function net_soul.notifyRepetitionUnlockSoul(soulCid)
	SoulModule.UnlockWhenSoulExisted(soulCid)
end

function net_soul.activeSpecialSpiritResult(code, soulCid, id)
	SoulModule.OnReqActiveSpecialSpiritResult(soulCid, id)
end
