-- chunkname: @modules/logic/room/mgr/RoomEditorMgr.lua

module("modules.logic.room.mgr.RoomEditorMgr", package.seeall)

local RoomEditorMgr = class("RoomEditorMgr")

function RoomEditorMgr:start()
	RoomController.instance:setEditorMode(true)
	ViewMgr.instance:openView(ViewName.RoomDebugEntranceView)
end

function RoomEditorMgr:exit()
	return
end

RoomEditorMgr.instance = RoomEditorMgr.New()

return RoomEditorMgr
