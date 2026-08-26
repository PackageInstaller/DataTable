-- chunkname: @modules/logic/toughbattle/controller/ToughBattleEvent.lua

module("modules.logic.toughbattle.controller.ToughBattleEvent", package.seeall)

local ToughBattleEvent = _M
local _get = GameUtil.getUniqueTb()

ToughBattleEvent.StageUpdate = _get()
ToughBattleEvent.ToughBattleActChange = _get()
ToughBattleEvent.InitFightIndex = _get()
ToughBattleEvent.ToughBattleActBtnShow = _get()
ToughBattleEvent.BeginPlayFightSucessAnim = _get()
ToughBattleEvent.GuideCurStage = _get()
ToughBattleEvent.GuideSetElementsActive = _get()
ToughBattleEvent.GuideFocusElement = _get()
ToughBattleEvent.GuideClickElement = _get()
ToughBattleEvent.GuideOpenBossInfoView = _get()

return ToughBattleEvent
