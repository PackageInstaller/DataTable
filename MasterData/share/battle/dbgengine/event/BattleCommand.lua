local BattleCommand = {
  rd_InitBattle = 1001,
  rd_BattleCut = 1002,
  rd_RecoverBattle = 1004,
  rd_CommandResult = 1005,
  rd_ClientAction = 1006,
  rd_BattleInstantCut = 1007,
  lg_UseCard = 2001,
  lg_BoutEnd = 2002,
  lg_GM = 2003,
  lg_UseUltiSkill = 2004,
  lg_ExtraBout = 2005,
  lg_SelectTargets = 2006,
  lg_ChangeGameSpeed = 2007,
  lg_Confirm = 2008,
  lg_UseKeeperSkill = 2009,
  lg_CancelSelectTargets = 2010,
  lg_SelectInitCard = 2011,
  lg_Giveup = 2012,
  lg_ClientAction = 2013,
  lg_ClickInitCard = 2014,
  lg_SwitchOceanModel = 2015,
  lg_BloodRecoverSkill = 2016,
  lg_UseDimensionSkill = 2017,
  lg_UseSilverKeyAwake = 2018,
  lg_RewindToBout = 2019,
  lg_UpdatePrivilegeLevel = 2020,
  lg_UseChaosType2Skill = 2022,
  lg_UseChaosType2Skill2 = 2023,
  lg_RobotAction = 3001
}
BattleCommand.ResumeCommands = {
  [BattleCommand.lg_SelectTargets] = true,
  [BattleCommand.lg_Confirm] = true,
  [BattleCommand.lg_CancelSelectTargets] = true
}
BattleCommand.IgnoreWaitingCommands = {
  [BattleCommand.lg_RewindToBout] = true,
  [BattleCommand.lg_UpdatePrivilegeLevel] = true
}
return BattleCommand
