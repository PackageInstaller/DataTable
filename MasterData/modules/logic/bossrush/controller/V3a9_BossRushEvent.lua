-- chunkname: @modules/logic/bossrush/controller/V3a9_BossRushEvent.lua

module("modules.logic.bossrush.controller.V3a9_BossRushEvent", package.seeall)

local V3a9_BossRushEvent = _M
local _get = GameUtil.getUniqueTb()

V3a9_BossRushEvent.onRefreshV3a9ModeTeamInfo = _get()
V3a9_BossRushEvent.OnModifyHeroGroup = _get()
V3a9_BossRushEvent.OnModifyEquip = _get()
V3a9_BossRushEvent.OnResetStage = _get()
V3a9_BossRushEvent.onRefreshAddBondGroupId = _get()
V3a9_BossRushEvent.onClickBondHeroItem = _get()
V3a9_BossRushEvent.onRefreshExpandBond = _get()
V3a9_BossRushEvent.onSwitchHeroExpandBonds = _get()
V3a9_BossRushEvent.onClickExpandBonds = _get()
V3a9_BossRushEvent.onUseAssistHero = _get()

return V3a9_BossRushEvent
