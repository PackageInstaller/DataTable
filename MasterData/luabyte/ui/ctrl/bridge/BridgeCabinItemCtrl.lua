local M = BaseClass("BridgeCabinItemCtrl")

function M:__init(view)
    self._view = view
end

function M:UpdateItem(data)
    if data == nil then return end
    local roomType = data.roomType
    local level = data.bridgeLvFunc()
    local roomNum = OtakuRoomDataMgr:GetInstance():GetRoomNumByType(roomType)
    local maxRoomNum = OtakuRoomDataMgr:GetInstance():GetRoomBuildLimitByType(roomType, level)
    local maxLevel = OtakuRoomDataMgr:GetInstance():GetRoomLvLimitByType(roomType, level)
    self._view.imgIcon:SetPic(data.icon)
    self._view.txtCabin:SetText(data.nameId)
    self._view.txtLevel:SetText(tostring(maxLevel))
    self._view.txtNum:SetText(roomNum .. "/" .. maxRoomNum)
    -- self._view.txtSettle:SetText(tostring(data.maxNum))-- 入驻人数不显示 By DuSir 9/2
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
