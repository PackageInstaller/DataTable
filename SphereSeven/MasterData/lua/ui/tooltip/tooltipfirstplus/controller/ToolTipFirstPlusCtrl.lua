---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/12 17:40
---

local ToolTipFirstPlusCtrl = BaseClass("ToolTipFirstPlusCtrl",UIBaseCtrl)
this = ToolTipFirstPlusCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipFirstPlus);
end

return this