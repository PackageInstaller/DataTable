

local UIPlayerInceptionInfoModel = BaseClass("UIPlayerInceptionInfoModel",UIBaseModel);
local base = UIBaseModel;
local this = UIPlayerInceptionInfoModel;

function this.OnCreate(self)
    base.OnCreate(self);
end

function this.OnEnable(self,callBack)
    self.callBack = callBack
    base.OnEnable(self);
    self:OnRefresh();
end
function this.OnRefresh(self)

end

local function OnSummonInfoChg(self,resultList)
    self:UIBroadcast(UIMessageNames.ON_SUMMON_INFO_CHG,resultList);
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddDataListener(DataMessageNames.ON_SUMMON_INFO_CHG,OnSummonInfoChg)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDisable(self)
    base.OnDisable(self);
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this