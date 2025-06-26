

---@class ToolTipFirstCtrl : UIBaseCtrl
local ToolTipFirstCtrl = BaseClass("ToolTipFirstCtrl",UIBaseCtrl)
this = ToolTipFirstCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipFirstStarLight);
end

return this