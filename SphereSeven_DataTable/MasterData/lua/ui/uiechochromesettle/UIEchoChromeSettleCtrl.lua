local UIEchoChromeSettleCtrl = BaseClass("UIEchoChromeSettleCtrl",UIBaseCtrl);
local this = UIEchoChromeSettleCtrl;

function this.CloseSelf(v)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIEchoChromeSettle);
end

return this;