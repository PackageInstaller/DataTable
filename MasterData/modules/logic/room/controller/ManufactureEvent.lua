-- chunkname: @modules/logic/room/controller/ManufactureEvent.lua

module("modules.logic.room.controller.ManufactureEvent", package.seeall)

local ManufactureEvent = _M

ManufactureEvent.ChangeSelectedSlotItem = 1
ManufactureEvent.PlayAddManufactureItemEff = 2
ManufactureEvent.OneKeySelectCustomManufactureItem = 3
ManufactureEvent.ChangeSelectedCritterSlotItem = 13
ManufactureEvent.ChangeSelectedTransportPath = 14
ManufactureEvent.OnEnterManufactureBuildingView = 15
ManufactureEvent.ManufactureBuildingViewChange = 16
ManufactureEvent.ManufactureReadNewFormula = 17
ManufactureEvent.PlayCritterBuildingBgm = 18
ManufactureEvent.ManufactureOverViewFocusAddPop = 19
ManufactureEvent.OnWrongTipViewChange = 20
ManufactureEvent.ManufactureInfoUpdate = 100
ManufactureEvent.TradeLevelChange = 101
ManufactureEvent.ManufactureBuildingInfoChange = 102
ManufactureEvent.CritterWorkInfoChange = 103
ManufactureEvent.GuideFocusCritter = 200
ManufactureEvent.OnCloseManufactureBuildingDetailView = 300

return ManufactureEvent
