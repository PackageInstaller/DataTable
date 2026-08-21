local M = BaseClass("OpenOtakuSynthesisUI", BaseJumpCommand)
M.roomType = OtakuType.OtakuRoomType.EST_Compose
M.uiName = "OtakuSynthesisUI"

function M:Execute(args)
    local roomData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(M.roomType)[1]
    if roomData then
        self:ShowUI(M.uiName, roomData, args[4])
        return true
    end

    GameHelper.TipsById(5718) -- 未建造合成舱
    return false
end

return M
