-- chunkname: @modules/logic/critter/controller/CritterSummonEvent.lua

module("modules.logic.critter.controller.CritterSummonEvent", package.seeall)

local CritterSummonEvent = _M

CritterSummonEvent.onSummonSkip = 101
CritterSummonEvent.onStartSummon = 102
CritterSummonEvent.onDragEnd = 103
CritterSummonEvent.onResetSummon = 104
CritterSummonEvent.onEndSummon = 105
CritterSummonEvent.onCloseGetCritter = 106
CritterSummonEvent.onStartSummonAnim = 107
CritterSummonEvent.onCanDrag = 108
CritterSummonEvent.onOpenEgg = 109
CritterSummonEvent.onCloseRoomCriiterDetailSimpleView = 110
CritterSummonEvent.onSelectParentCritter = 201
CritterSummonEvent.onRemoveParentCritter = 202
CritterSummonEvent.onIncubateCritterPreviewReply = 203

return CritterSummonEvent
