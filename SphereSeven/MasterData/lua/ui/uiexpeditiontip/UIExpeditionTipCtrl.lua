local UIExpeditionTipCtrl = BaseClass("UIExpeditionTipCtrl",UIBaseCtrl);
local this = UIExpeditionTipCtrl

function this.CloseSelf(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIExpeditionTip)
end

return this