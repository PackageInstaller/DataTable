local FirstRechargeUICtrl = BaseClass("FirstRechargeUICtrl", BaseUICtrl)
local M = FirstRechargeUICtrl

function M:Init()
    self._view.BtnRecharge:onClick(Bind(self, self.OnClickRecharge))
    self._view.BtnReward:onClick(Bind(self, self.OnClickReward))
    self._view.BtnPlay:onClick(Bind(self, self.OnClickVideo))
    self._view.BtnHero:onClick(Bind(self, self.OnClickHero))
    self.rewardItemGroups = ConfigHelper.GetSystemParams(330)
    self.jumpId = ConfigHelper.GetSystemParam(331)
    self.tabDayItems = {}
    self.RechargeStateHandler = EventMgr:AddListener(UIMessageNames.RECHARGE_STATE_UPDATE, Bind(self, self.SetBtnState))
end

function M:OnClickHero()
    UIContextMgr:GetInstance():Show("RoleInformationUI", { [0] = 140004, Length = 1 }, 0, 2, true)
end

function M:OnClickVideo()
    UIContextMgr:GetInstance():Show("Lottery_PV","Video/haijinsha_show.mp4")
end 

function M:OnEnter()
    self:SetBtnState()
    self:_InitItemList()
end

function M:SetBtnState()
    self.firstRechargeState = RechargeDataMgr:GetInstance():GetFirstRechargeState()
    if self.firstRechargeState then
        local value = RechargeDataMgr:GetInstance():CheckFirstRechargeReward()
        if value == nil then
            self._view.UIState:SetState(3)
        else
           if value == true then
               self._view.UIState:SetState(2)
           else
               self._view.UIState:SetState(4)
           end
        end
    else
        self._view.UIState:SetState(1)
    end
end

function M:_InitItemList()
    if #self.tabDayItems > 0 then
        for i = 1, #self.tabDayItems do
            GameUtil.DestroyGo(self.tabDayItems[i]._view.gameObject)
        end
    end
    self.tabDayItems = {}
    local ctrlItemCls = require("UI.Ctrl.Shop.FirstRechargeDayItemCtrl")
    for i = 0, self.rewardItemGroups.Length - 1 do
        local rewards = ConfigHelper.GetCfg("itemGroup", self.rewardItemGroups[i])
        local datas = {}
        for key, id in pairs(rewards.items) do
            local data = {}
            data.id = id
            data.num = rewards.cnts[key]
            table.insert(datas, data)
        end
        local itemView = self._view.DayItem:Instantiate()
        local item = ctrlItemCls.New(itemView)
        table.insert(self.tabDayItems, item)
        item:SetActive(true)
        item:SetInfo(datas, i+1)
    end
end

function M:OnClickRecharge()
    --self:Close()
    local jumpOk , callbackObj = GameHelper.Jump(self.jumpId)
    if jumpOk and callbackObj then 
        callbackObj.callback = function()
            self:Close()
        end
    end
end

function M:OnClickReward()
    RechargeDataMgr:GetInstance():RequestFirstChargeReward(Bind(self, self.RechargeCallback))
end

function M:RechargeCallback(rewards)
    IRedPointMgr:ForceCheck(RedPointConst.FirseRechargeRedPointChecker)
    GameHelper.ShowGetItemsByItems(rewards, Bind(self, self.OnEnter))
end

-- 点击设置退出按键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:Close()
    UIContextMgr:GetInstance():Close(UIDefine.UIActivity)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.RECHARGE_STATE_UPDATE, self.RechargeStateHandler)
    M.super.OnDispose(self)
    self.tabDayItems = nil
end

return FirstRechargeUICtrl
