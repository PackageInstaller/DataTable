-- chunkname: @modules/logic/teach/controller/TeachNoteEvent.lua

module("modules.logic.teach.controller.TeachNoteEvent", package.seeall)

local TeachNoteEvent = _M

TeachNoteEvent.ClickTopicItem = 1001
TeachNoteEvent.GetServerTopicInfo = 2001
TeachNoteEvent.GetServerTopicReward = 2002
TeachNoteEvent.GetServerTeachNoteFinalReward = 2003
TeachNoteEvent.GetServerSetOpenSuccess = 2004

return TeachNoteEvent
