local LuckDrawCtrl = BaseClass("LuckDrawCtrl",BaseUICtrl)
local M = LuckDrawCtrl

function M:Init()
    self._view.tsBtn_once.onClick = function(go) self:_OnClicktsBtn_once(go)  end
    self._view.tsBtn_ten.onClick = function(go) self:_OnClicktsBtn_ten(go) end

    self._view.ProbabilityBtn:onClick (function(g)
    local context = UIContextMgr:GetInstance():GetContext("LuckDraw")
    local cfg = context._configs
    local cardPoolId = 0
    for _, value in pairs(cfg) do
        --for _, zv in pairs(value) do
        cardPoolId = value.jackpot
        --end
    end
        UIContextMgr:GetInstance():Show("LotteryProbability",cardPoolId)
    end)

    self._costItem1 = self._view.trans_consume1
    self._costItem2 = self._view.trans_consume2
end

function M:OnEnter()
    GameHelper.DoPlayerAction(PlayerAction.ShowLuckDraw)    self.cfg = {}
    self.cfg = nil
    for k,v in pairs(self:GetContext()._configs) do
        self.cfg = v
    end
    self:_SetCost(self.cfg)
end


function M:OnDispose()
    self._view.tsBtn_once.onClick = nil
    self._view.tsBtn_once = nil
    self._view.tsBtn_ten.onClick = nil
    self._view.tsBtn_ten = nil
    M.super.OnDispose(self)
end

function M:_OnClicktsBtn_once(go)
    --UIContextMgr:GetInstance():Show("LuckDrawSignIn")
    local context = UIContextMgr:GetInstance():GetContext("LuckDraw")
    local cfg
    for key, value in pairs(context._configs) do
        cfg = value
    end
    context:Lotto(cfg.id,1)
end

function M:_OnClicktsBtn_ten(go)
    --UIContextMgr:GetInstance():Show("LuckDrawSignIn")
    local context = UIContextMgr:GetInstance():GetContext("LuckDraw")
    local cfg
    for key, value in pairs(context._configs) do
        cfg = value
    end
    context:Lotto(cfg.id,5)

end

function M:_SetCost(lottoCfgs)
    self._lotteryCostItems = {}
    --目前只支持2个
    for i = 1 , 2 do 
        --1 为单抽  2为10连
        --local cfgs = lottoCfgs[i].costItem
        local itemId
        local itemNum 
        local isEnough 
        itemId,itemNum,isEnough = LotteryHelper.GetCostItemByShow(lottoCfgs,i == 1)
        self["_costItem"..i]:SetWarningNumber(itemNum)
        self["_costItem"..i]:Action(itemId,itemNum)
        table.insert( self._lotteryCostItems, itemId )
    end
end 



return LuckDrawCtrl