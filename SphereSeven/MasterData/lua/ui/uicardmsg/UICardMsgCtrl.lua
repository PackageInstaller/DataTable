---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/23 16:56
---


local UICardMsgCtrl = BaseClass("UICardMsgCtrl",UIBaseCtrl);
local this = UICardMsgCtrl;

function this.CloseSelf(gameObject)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UICardMsg);
end

function this.OpenChangeSkinWindow(gameObject)
    local data = gameObject:GetComponent("BindData"):Get("self");
    UIManager:GetInstance():OpenWindow(UIWindowNames.UISkin,data.model.card);
end

function this.OpenHandBookWindow(gameObject)
    
end

return this;