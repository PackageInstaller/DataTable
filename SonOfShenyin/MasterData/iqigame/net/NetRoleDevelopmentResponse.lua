-- chunkname: @IQIGame\\Net\\NetRoleDevelopmentResponse.lua

function net_hero.breakThroughResult(code, preview, hero)
	RoleDevelopmentModule.RoleBreachResult(preview, hero)
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_hero.useSoulExpItemResult(code, cri, preview, hero)
	RoleDevelopmentModule.RoleUpdradeResult(cri, preview, hero)
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_hero.notifyHeros(heros)
	RoleDevelopmentModule.NotifyHeroChange(heros)
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_skill.upgradeSkillResult(code, oldSkill, skillpod, isUp)
	RoleDevelopmentModule.RoleSkillUpgradeResult(code, oldSkill, skillpod, isUp)
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_skill.strengSkillResult(code, skillpod)
	RoleDevelopmentModule.RoleSkillBreachResult(code, skillpod)
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_skill.unloadSkillResult(code)
	RoleDevelopmentModule.RoleSkillUnloadResult()
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_skill.wearSkillResult(code)
	RoleDevelopmentModule.RoleSkillWearResult()
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_skill.lockSkillResult(code)
	RoleDevelopmentModule.RoleSkillLockResult()
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_hero.unlockPersonalityResult(code, personalityId)
	WarlockModule.UnlockPersonalitySucceed(personalityId)
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_hero.favorabilityExpItemResult(code, up)
	RoleExtendModule.FavorabilityExpItemResult(code)
	EventDispatcher.Dispatch(EventID.FavorabilityExpItemResult, up)
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_skill.purifySkillResult(code, oldSkillpod, skillpod)
	DiySkillModule.PurifySkillResult(oldSkillpod, skillpod)
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_hero.ascendingStartResult(code)
	RoleDevelopmentModule.AscendingStartResult()
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_hero.breakPrizeResult(code, heroPOD, itemShowList)
	RoleDevelopmentModule.GetBreakRewardResult(heroPOD, itemShowList)
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function net_hero.previewHeroMaxResult(code, heroPOD)
	RoleDevelopmentModule.PreviewHeroMaxResult(heroPOD)
end
