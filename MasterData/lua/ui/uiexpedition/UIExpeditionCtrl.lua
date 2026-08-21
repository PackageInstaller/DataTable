local UIExpeditionCtrl = BaseClass("UIExpeditionCtrl",UIBaseCtrl);
local this = UIExpeditionCtrl

function this.CloseSelf(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIExpedition)
end

return this