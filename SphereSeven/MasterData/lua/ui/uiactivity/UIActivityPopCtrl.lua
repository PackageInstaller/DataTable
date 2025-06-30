local UIActivityPopCtrl = BaseClass("UIActivityPopCtrl",UIBaseCtrl);
local this = UIActivityPopCtrl

function this.CloseSelf(v)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIActivityPop);
end
return this