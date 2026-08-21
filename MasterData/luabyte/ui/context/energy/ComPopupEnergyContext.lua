local M = BaseClass("ComPopupEnergyContext", BaseContext)

function M:Open()
    local energy = EnergyMgr:GetInstance():EnergyValue()
    local limit = EnergyMgr:GetInstance():MaxEnergyLimit()
    if energy >= limit then
        -- 可以体力已达上限
        GameHelper.TipsById(5216)
        return
    end

    self:_Show()
end

return M
