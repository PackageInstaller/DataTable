---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/12 19:55
---

local UIShopCtrl = BaseClass("UIShopCtrl",UIBaseCtrl)

local this = UIShopCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIShop);
end

function this.OpenStoneShopWindow()  --打开星石商店
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIStoneShop);
end

function this.OpenMonthCardShopWindow() --月卡商店
    Game.Scene.Player:GetComponent("MonthCardComponent"):OpenViewType()
end

function this.OpenGeneralShopWindow()  --通用商店
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIGeneralShop);
end

function this.OpenSandShopWindow() --星砂商店
    UIManager:GetInstance():OpenWindow(UIWindowNames.UISandShop);
end

function this.OpenMagicShopWindow() --魔晶商店
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIMagicShop);
end

function this.OpenStarKingShopWindow() --星皇点商店
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIStarKingShop);
end

function this.OpenPropsForShopWindow() --道具兑换
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIPropsForShop);
end

function this.OpenSkinShopWindow() --皮肤商店
    UIManager:GetInstance():OpenWindow(UIWindowNames.UISkinShop);
end

return this;