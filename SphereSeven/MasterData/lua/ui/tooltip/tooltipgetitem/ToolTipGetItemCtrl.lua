
---@class ToolTipGetItemCtrl : UIBaseCtrl
local ToolTipGetItemCtrl = BaseClass("ToolTipGetItemCtrl",UIBaseCtrl)
local this = ToolTipGetItemCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipGetItem);
end

return this