
--
-- <代码文件解释说明>
--

---@class UIEquipLevelUpCtrl
---@field model UIEquipLevelUpModel
local UIEquipLevelUpCtrl = BaseClass("UIEquipLevelUpCtrl",UIBaseCtrl)
local this = UIEquipLevelUpCtrl

function this.closeSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIEquipLevelUp)
end

function this:SendLevelUpRequest(equipId)
    PublicRequest.SendRequest(
        PROTOCOL.EquipmentPackLevelUpReq,
        { eid = equipId },
        nil
    )
end

return this
