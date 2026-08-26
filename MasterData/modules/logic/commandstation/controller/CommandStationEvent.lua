-- chunkname: @modules/logic/commandstation/controller/CommandStationEvent.lua

module("modules.logic.commandstation.controller.CommandStationEvent", package.seeall)

local CommandStationEvent = _M
local _get = GameUtil.getUniqueTb()

CommandStationEvent.MoveTimeline = _get()
CommandStationEvent.SelectTimePoint = _get()
CommandStationEvent.ChangeEventCategory = _get()
CommandStationEvent.MapLoadFinish = _get()
CommandStationEvent.HideVersionSelectView = _get()
CommandStationEvent.ChangeVersionId = _get()
CommandStationEvent.ClickDispatch = _get()
CommandStationEvent.DispatchHeroListChange = _get()
CommandStationEvent.DispatchStart = _get()
CommandStationEvent.DispatchFinish = _get()
CommandStationEvent.DispatchChangeTab = _get()
CommandStationEvent.TimelineAnimDone = _get()
CommandStationEvent.SceneFocusPos = _get()
CommandStationEvent.FocusEvent = _get()
CommandStationEvent.EventReadChange = _get()
CommandStationEvent.BeforeEventFinish = _get()
CommandStationEvent.AfterEventFinish = _get()
CommandStationEvent.SelectedEvent = _get()
CommandStationEvent.CancelSelectedEvent = _get()
CommandStationEvent.EventCreateFinish = _get()
CommandStationEvent.MoveScene = _get()
CommandStationEvent.RTGoHide = _get()
CommandStationEvent.ClickRelationShipBoardCharacter = _get()
CommandStationEvent.UpdateCharacterState = _get()
CommandStationEvent.OneClickClaimReward = _get()
CommandStationEvent.OnTaskUpdate = _get()
CommandStationEvent.OnPaperUpdate = _get()
CommandStationEvent.OnBonusUpdate = _get()
CommandStationEvent.OnGetCommandPostInfo = _get()

return CommandStationEvent
