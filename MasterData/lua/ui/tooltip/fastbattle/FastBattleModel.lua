local FastBattleModel = BaseClass("FastBattleModel",UIBaseModel)
local base = UIBaseModel
local this = FastBattleModel

local function OnItemInfoChg(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_ITEM_INFO_CHG)
end

function this.OnCreate(self)
    base.OnCreate(self)
    self.data = nil
end

function this.OnEnable(self,data)
    base.OnEnable(self)
    self:OnRefresh(data)
end

function this.OnRefresh(self,data)
    self.data = data
end

function this.OnAddListener(self)
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_ITEM_INFO_CHG, OnItemInfoChg)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_ITEM_INFO_CHG)
end

function this.OnDisable(self)
    base.OnDisable(self)

end

function this.OnDestroy(self)
    self.data = nil
    base.OnDestroy(self)
end

return this

