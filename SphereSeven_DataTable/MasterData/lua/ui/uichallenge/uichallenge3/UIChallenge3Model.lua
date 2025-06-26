---
---

local UIChallenge3Model = BaseClass("UIChallenge3Model",UIBaseModel)
local base = UIBaseModel
local this = UIChallenge3Model

function this.OnCreate(self)
    base.OnCreate(self)
end


function this.OnEnable(self)
    base.OnEnable(self);
end

function this.OnRefresh(self)

end

local function OnTimeReset(self)
    self:UIBroadcast(UIMessageNames.ON_TIME_RESET)
end

local function OnChallengeDiffChg(self)
    self:UIBroadcast(UIMessageNames.ON_CHALLENGE_DIFF_CHG)
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddDataListener(DataMessageNames.ON_TIME_RESET,OnTimeReset)
    self:AddDataListener(DataMessageNames.ON_CHALLENGE_DIFF_CHG, OnChallengeDiffChg)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveDataListener(DataMessageNames.ON_TIME_RESET)
    self:RemoveDataListener(DataMessageNames.ON_CHALLENGE_DIFF_CHG)
end

function this.OnDisable(self)
    base.OnDisable(self);
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end


return this