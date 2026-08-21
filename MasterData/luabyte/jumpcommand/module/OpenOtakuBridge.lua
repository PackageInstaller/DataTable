local M = BaseClass("OpenOtakuBridge", BaseJumpCommand)
M.roomType = OtakuType.OtakuRoomType.EST_Bridge
M.uiName = "BridgeUI"

function M:Execute(args)
    local roomDatas = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(M.roomType)
    local roomData = roomDatas and roomDatas[1] or nil
    if not roomData then return false end
    self:ShowUI(M.uiName, roomData)
    return true
end

return M
