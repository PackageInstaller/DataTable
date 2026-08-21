local M = BaseClass("OpenOtakuManufacturingCabin", BaseJumpCommand)
M.roomType = OtakuType.OtakuRoomType.EST_Produce

function M:Execute(args)
    local index = SafeUnpack(args)
    local dataMgr = OtakuRoomDataMgr:GetInstance()
    local roomData = dataMgr:RoomDatasByRoomType(M.roomType)[index]
    local roomId = roomData and roomData:RoomId() or nil
    if roomId then
        dataMgr:EnterRoomStudioByType(M.roomType, roomId,M.onComplete)
        return true
    end

    GameHelper.TipsById(5579) --房间未建造
    return false
end

return M
