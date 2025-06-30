
local ToolTipLoginCtrl = BaseClass("ToolTipLoginCtrl",UIBaseCtrl)
local this = ToolTipLoginCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipLogin)
end

return this
