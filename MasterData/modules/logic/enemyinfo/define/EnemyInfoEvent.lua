-- chunkname: @modules/logic/enemyinfo/define/EnemyInfoEvent.lua

module("modules.logic.enemyinfo.define.EnemyInfoEvent", package.seeall)

local EnemyInfoEvent = _M

EnemyInfoEvent.UpdateBattleInfo = 1
EnemyInfoEvent.SelectMonsterChange = 2
EnemyInfoEvent.ShowTip = 3
EnemyInfoEvent.HideTip = 4

return EnemyInfoEvent
