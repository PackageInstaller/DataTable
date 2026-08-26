-- chunkname: @modules/logic/battlepass/controller/BpEvent.lua

module("modules.logic.battlepass.controller.BpEvent", package.seeall)

local BpEvent = _M

BpEvent.OnGetInfo = 1
BpEvent.OnGetBonus = 2
BpEvent.OnUpdateScore = 3
BpEvent.OnUpdatePayStatus = 4
BpEvent.OnBuyLevel = 5
BpEvent.OnTaskUpdate = 6
BpEvent.OnRedDotUpdate = 7
BpEvent.onSelectBonusGet = 8
BpEvent.SetGetAllCallBack = 100
BpEvent.SetGetAllEnable = 101
BpEvent.TapViewOpenAnimBegin = 102
BpEvent.TapViewCloseAnimBegin = 103
BpEvent.TapViewCloseAnimEnd = 104
BpEvent.OnTaskFinishAnim = 105
BpEvent.ShowUnlockBonusAnim = 106
BpEvent.OnViewOpenFinish = 107
BpEvent.BonusAnimEnd = 108
BpEvent.ForcePlayBonusAnim = 109
BpEvent.TaskTabChange = 110
BpEvent.OnLevelUp = 111

return BpEvent
