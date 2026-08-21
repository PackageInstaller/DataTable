local L0_1, L1_1, L2_1, L3_1
L0_1 = {}
L0_1.m_fStartCost = 10
L0_1.m_fCostSpeedRateB = 1.2
L0_1.m_BossUnitStrID = "NKM_MOB_BOSS_EQC_ESPR_PILE"
L0_1.m_fBossPosZ = 0.6
L1_1 = {}
L2_1 = {}
L3_1 = {}
L3_1.NST_ATK = 4.0
L3_1.NST_DEF = 1.0
L3_1.NST_HP = 1.5
L2_1.m_StatFactor = L3_1
L1_1.m_AddStatData = L2_1
L0_1.m_BossRespawnUnitTemplet = L1_1
NKMDungeonTemplet = L0_1
