Loader:Require("FightLogic.FightDef")
Loader:Require("FightLogic.FightLog")
Loader:Require("FightLogic.Random")
Loader:Require("FightLogic.Filter")
Loader:Require("FightLogic.FightAPI")
Loader:Require("FightLogic.SkillBase")
Loader:Require("FightLogic.Halo")

Loader:Require("skill.SkillInclude")
Loader:AddReplaceFile("g_SkillList")


g_SkillPath = "skill."
Loader:Require("FightLogic.buff.BuffBase")

Loader:Require("buffer.BufferInclude")
Loader:AddReplaceFile("g_BufferList")


g_BufferPath = "buffer."
Loader:Require("FightLogic.FightEventMgr")
Loader:Require("logic.PvpMatchMgr")
Loader:Require("FightLogic.FightCard")
Loader:Require("FightLogic.Team")
Loader:Require("FightLogic.fight.FightMgr")
Loader:Require("FightLogic.fight.FightHelp")