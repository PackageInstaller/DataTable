
local ToolTipBuffDetailCtrl = BaseClass("ToolTipThirdCtrl",ToolTipBuffDetailCtrl)
local this = ToolTipBuffDetailCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipBuffDetail)
end

return this
