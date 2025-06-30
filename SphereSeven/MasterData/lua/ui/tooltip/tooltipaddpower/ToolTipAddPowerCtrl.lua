
local ToolTipAddPowerCtrl = BaseClass("ToolTipAddPowerCtrl",UIBaseCtrl)
local this = ToolTipAddPowerCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipAddPower)
end

return this
