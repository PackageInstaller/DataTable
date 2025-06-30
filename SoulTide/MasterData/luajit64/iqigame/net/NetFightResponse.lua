-- chunkname: @IQIGame\\Net\\NetFightResponse.lua

function net_fight.notifyStartFight(isLocalFight, fightPOD, userData)
	if fightPOD.BattleType == Constant.BattleType.Panda then
		PandaBattleModule.Instance:StartBattle(isLocalFight, fightPOD, userData)
	elseif fightPOD.BattleType == Constant.BattleType.DualTeamExploreNormal then
		DualTeamExploreModule.NotifyStartBattle(isLocalFight, fightPOD, userData)
	elseif fightPOD.BattleType == Constant.BattleType.GuildChallenge or fightPOD.BattleType == Constant.BattleType.GuildTraining then
		GuildBattleModule.Instance:StartBattle(isLocalFight, fightPOD, userData)
	elseif fightPOD.BattleType == Constant.BattleType.Mining then
		MiningBattleModule.Instance:StartBattle(isLocalFight, fightPOD, userData)
	elseif fightPOD.BattleType == Constant.BattleType.AmusementParkChallenge or fightPOD.BattleType == Constant.BattleType.AmusementParkExBoss then
		AmusementParkBattleModule.Instance:StartBattle(isLocalFight, fightPOD, userData)
	else
		MainCityBattleModule.Instance:StartBattle(isLocalFight, fightPOD, userData)
	end
end
