-- 打开餐厅
local M = BaseClass("OpenRestaurant", BaseJumpCommand)
M.roomType = OtakuType.OtakuRoomType.EST_Canteen
-- M.moduleId = ModuleConfig.Restaurant.id

function M:Execute(args)
    local index = SafeUnpack(args)
    local roomData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(M.roomType)[index]
    if roomData then
        self:ShowUI(UIDefine.RestaurantRootUI, roomData)
        return true
    end

    GameHelper.TipsById(950)
    return false
end

return M
