---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UIInformCtrl = BaseClass("UIInformCtrl",UIBaseCtrl);
local this = UIInformCtrl


function this.CloseSelf(self) 
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIInform)
end


return this;

