-- chunkname: @modules/logic/fightuiswitch/controller/FightUISwitchEvent.lua

module("modules.logic.fightuiswitch.controller.FightUISwitchEvent", package.seeall)

local FightUISwitchEvent = _M

FightUISwitchEvent.UseFightUIStyle = 1
FightUISwitchEvent.SelectFightUIStyle = 2
FightUISwitchEvent.SelectFightUIEffect = 3
FightUISwitchEvent.LoadFinish = 4
FightUISwitchEvent.cancelClassifyReddot = 5

return FightUISwitchEvent
