local UIActivityCtrl = BaseClass("UIActivityCtrl",UIBaseCtrl);
local this = UIActivityCtrl

function this.CloseSelf(v)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIActivity);
end
return this