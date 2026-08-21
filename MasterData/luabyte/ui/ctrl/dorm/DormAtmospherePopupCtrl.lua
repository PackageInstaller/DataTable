local DormAtmospherePopupCtrl = BaseClass("DormAtmospherePopupCtrl", BaseUICtrl)
local M = DormAtmospherePopupCtrl

function M:Init()
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self._view.RewardBtn:onClick(Bind(self, self.OnClickReward))
    self._view.Mask:onClick(Bind(self, self.OnClickMask))
    self.items = {}
end

function M:OnEnter(heroId)
    if #self.items > 0 then
        for i = 1, #self.items do
            GameUtil.DestroyGo(self.items[i]._view.gameObject)
        end
    end
    self.heroId = heroId
    self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    self.curAtmosphere = OtakuFurniturDataMgr:GetAtmosphere(heroId)
    self.isMax = self:IsMaxLevel()
    if self.isMax then
        self._view.CurrentValue:SetText(tostring(self.curAtmosphere))
        self._view.UIState:SetState(2)
    else
        self.targetCfg = ConfigHelper.GetCfgsByLua("atmosphere",
            { heroId = self.heroId, level = self.rshd.Atmosphere + 1 })
        self._view.CurrentValue:SetText(tostring(self.curAtmosphere))
        self._view.TargetValue:SetText(tostring(self.targetCfg[1].buffLabel))
        self.canReward = self.curAtmosphere >= self.targetCfg[1].buffLabel
        self:InitItemList()
        self._view.UIState:SetState(1)
        if self.canReward then
            self._view.BtnState:SetState(1)
        else
            self._view.BtnState:SetState(2)
        end
    end
end

function M:IsMaxLevel()
    local heroAtmospheres = ConfigHelper.GetCfgsByLua("atmosphere", { heroId = self.heroId })
    self.maxLevel = 0
    for k, v in pairs(heroAtmospheres) do
        if v.level > self.maxLevel then
            self.maxLevel = v.level
        end
    end
    if self.rshd.Atmosphere == self.maxLevel then
        return true
    end
    return false
end

function M:OnClickReward()
    if self.canReward then
        DormDataMgr:RequestAwardAtmosphere(self.heroId, Bind(self, self.RewardCallback))
    end
end

function M:OnClickMask()
    self:Close()
end

function M:RewardCallback(msg)
    GameHelper.ShowGetItemsByItems(msg.Awards)
    self:OnEnter(self.heroId)
    EventMgr:Broadcast(UIMessageNames.DORM_UPDATE_ATMOSPHERE, self.heroId)
end

function M:InitItemList()
    self.items = {}
    self.rewards = ConfigHelper.GetCfg("itemGroup", self.targetCfg[1].gift)
    local ctrlItemCls = require("UI.Ctrl.Common.CommonItemCtrl")
    for key, value in pairs(self.rewards.items) do
        local itemView = self._view.item:Instantiate()
        itemView:SetParent(self._view.Content)
        itemView:SetActive(true)
        local ctrlItem = ctrlItemCls.New(itemView)
        ctrlItem:SetInfo(value, 1, self.rewards.cnts[key]);
        ctrlItem:EnablePopItem(true);
        table.insert(self.items, ctrlItem)
    end
end

function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return DormAtmospherePopupCtrl
