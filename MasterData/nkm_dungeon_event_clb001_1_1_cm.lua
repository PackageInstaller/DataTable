local L0_1, L1_1, L2_1, L3_1
L0_1 = {}
L0_1.m_fStartCost = 5
L0_1.m_fCostSpeedRateB = 0.5
L0_1.m_BossUnitStrID = "NKM_MOB_BOSS_CLB_001_GUILTY_S_MAY_CM"
L0_1.m_fBossPosZ = 0.6
L1_1 = {}
L2_1 = {}
L2_1.m_UnitStrID = "NKM_MOB_BOSS_CLB_001_FREEDOM_KASUMI_CM"
L3_1 = {}
L3_1.m_NKM_DUNGEON_EVENT_TYPE = "NDET_DECK"
L3_1.m_fEventTimeStart = 999
L3_1.m_fEventPos = 0.15
L2_1.m_NKMDungeonEventTiming = L3_1
L1_1[1] = L2_1
L0_1.m_listDungeonDeck = L1_1
NKMDungeonTemplet = L0_1
