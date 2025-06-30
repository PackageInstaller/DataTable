

local UIRiskModel = BaseClass("UIRiskModel",UIBaseModel);
local base = UIBaseModel
local this = UIRiskModel


function this.OnCreate(self)
    base.OnCreate(self);
end

function this.OnEnable(self,data)
    base.OnEnable(self);
    --self.data = data
end

local function OnPlayInfoChg(self)
    self:UIBroadcast(UIMessageNames.ON_RISK_PLAY_POS)
end


function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddDataListener(DataMessageNames.ON_RISK_PLAY_POS,OnPlayInfoChg)
end


function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveDataListener(DataMessageNames.ON_RISK_PLAY_POS)
   
end

function this.OnDisable(self)
    base.OnDisable(self);

end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;