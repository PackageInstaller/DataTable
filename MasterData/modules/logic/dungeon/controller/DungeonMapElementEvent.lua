-- chunkname: @modules/logic/dungeon/controller/DungeonMapElementEvent.lua

module("modules.logic.dungeon.controller.DungeonMapElementEvent", package.seeall)

local DungeonMapElementEvent = _M

DungeonMapElementEvent.OnSetClickDown = 90301
DungeonMapElementEvent.OnUpdateElementArrow = 90302
DungeonMapElementEvent.OnChangeMap = 90303
DungeonMapElementEvent.OnLoadSceneFinish = 90304
DungeonMapElementEvent.OnDisposeScene = 90305
DungeonMapElementEvent.OnInitElements = 90306
DungeonMapElementEvent.OnDisposeOldMap = 90307
DungeonMapElementEvent.OnFocusElement = 90308
DungeonMapElementEvent.OnFinishAndDisposeElement = 90309
DungeonMapElementEvent.OnClickExploreElement = 90310
DungeonMapElementEvent.OnNormalDungeonInitElements = 90311
DungeonMapElementEvent.OnElementAdd = 90312
DungeonMapElementEvent.OnElementRemove = 90313
DungeonMapElementEvent.OnRecheckElement = 90314
DungeonMapElementEvent.OnRecheckInteractive = 90315

return DungeonMapElementEvent
