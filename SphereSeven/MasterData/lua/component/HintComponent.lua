---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/7/11 9:54
---@class HintComponent
---@field Shop HintNode @ 商店 - "GeneralShop" "SkinShop" "StarLightStoneShop"
---@field Friend HintNode @ 好友 - "Requests" - id
---@field Post HintNode @ 邮箱
---@field Intens HintNode @ 强化
---@field Task HintNode @ 任务 - taskType - taskId
---@field Prop HintNode @ 道具
---@field Recruit HintNode @ 抽卡 - recruitId
---@field Room HintNode @ 自宅
---@field Handbook HintNode @ 图鉴
---@field Inform HintNode @ 公告
---@field Risk HintNode @
---@field Activity HintNode @ 活动
---@field SingleActivity HintNode @ 一些单独的活动
---@field Expedition HintNode @ 远征
---@field Card HintNode @ 角色 - "Cards" ( 新角色, 点击后消失 ); - "Intens" ( 角色详情页里, 用来判断强化状态 )
---@field Item HintNode @ 道具 - itemId
---@field conditionHinds table<HintNode, string> @ 条件红点 所有有额外条件的,跟其他系统有关的. 商店购买 除了跟商品状态有关也跟等级之类的有关
local HintComponent = BaseClass("HintComponent", Component)
local base = Component
local this = HintComponent


local function CreateNode(name)
    return Game.Registry:NewObject("HintNode",{name = name})
end

function this:Awake()
    base.Awake(self)
    self:Create()
end

function this:Create()
    self.Shop = CreateNode("Shop")
    self.Friend = CreateNode("Friend")
    self.Post = CreateNode("Post")
    self.Task = CreateNode("Task")
    self.Handbook = CreateNode("Handbook")
    self.Inform = CreateNode("Inform")
    self.Risk =  CreateNode("Risk")
    self.Activity = CreateNode("Activity")
    self.SingleActivity = CreateNode("SingleActivity")
    self.Recruit = CreateNode("Recruit")
    self.Expedition = CreateNode("Expedition")
    self.Card = CreateNode("Card")
    self.Item = CreateNode("Item")
    self.Room = CreateNode("Room")
    self.hints = {}
    self.conditionHinds = {}
end

function this:AddHint(name)
    self.hints[name] = CreateNode(name)
end

function this:AddCondition(hint, goodsId)
    self.conditionHinds[hint] = goodsId
end

function this:RefreshCondition()
    for hint, goodsId in pairs(self.conditionHinds) do
        local hintCount = 0
        local zExcel
        local goodsInfo
        if Z_Store[goodsId] ~= nil then
            zExcel = Z_Store[goodsId]
            goodsInfo = Game.Scene.Player:GetComponent("ShopComponent").PurchasesDetailList[zExcel.StoreType][goodsId]
        else
            zExcel = Z_StarLightStoneShop[goodsId]
            goodsInfo = Game.Scene.Player:GetComponent("StarLightRebateComponent").PurchasesDetail[1][goodsId]
        end

        local buyTimes = 0
        if goodsInfo ~= nil then
            buyTimes = goodsInfo.buy_times
        end
        if not string.IsNullOrEmpty(zExcel.OnSaleStartCondition) then
            if zExcel.TotalPrice == 0 and UIPublic.CheckCondition(zExcel.OnSaleStartCondition) then
                if zExcel.QuotaNum > buyTimes or zExcel.QuotaNum == 0 then
                -- 价格为0 购买次数未达到上限
                    hintCount = 1
                end
            end
        else
            if zExcel.TotalPrice == 0 then
                if zExcel.QuotaNum > buyTimes or zExcel.QuotaNum == 0 then
                -- 价格为0 购买次数未达到上限
                    hintCount = 1
                end
            end
        end

        hint:SetCount(hintCount)
    end
end

function this.Dispose(self)
    base.Dispose(self)
end




return this