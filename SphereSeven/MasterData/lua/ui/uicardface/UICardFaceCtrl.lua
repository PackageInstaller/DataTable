---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/25 9:59
---


local UICardFaceCtrl = BaseClass("UICardFaceCtrl",UIBaseCtrl);

local this = UICardFaceCtrl;

function this.CloseSelf(v)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UICardFace);
end

return this;