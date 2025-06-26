
local UINoviceGuideModel = BaseClass("UINoviceGuideModel",UIBaseModel);
local base = UIBaseModel;
local this = UINoviceGuideModel;

function this.OnCreate(self)
    base.OnCreate(self);
end

function this.OnEnable(self)
    base.OnEnable(self);
end
local function OnGuideCh(self,cid,num,isrun)
    --local guide=Game.Scene:GetComponent("GuideComponent")
    --local cid,num,isrun=guide:GetCurrentData()
    self:UIBroadcast(UIMessageNames.ON_Guide_CHG,cid,num,isrun);
end
local function ON_Guide_Click(self,cid,num,isrun,minStep)
    self:UIBroadcast(UIMessageNames.ON_Guide_Click,cid,num,isrun,minStep)
end

local function ON_Guide_CHG_MIN(self,cid,num,isrun,minStep,isFinger)
    --local guide=Game.Scene:GetComponent("GuideComponent")
    --local cid,num,isrun=guide:GetCurrentData()
    --local minStep = guide.minStep
    self:UIBroadcast(UIMessageNames.ON_Guide_CHG_MIN,cid,num,isrun,minStep,isFinger)
end

local function OnScenechg(self)
    self:UIBroadcast(UIMessageNames.ON_SCENE_CHG)
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddDataListener(DataMessageNames.ON_Guide_CHG,OnGuideCh)
    self:AddDataListener(DataMessageNames.ON_Guide_Click,ON_Guide_Click)
    self:AddDataListener(DataMessageNames.ON_Guide_CHG_MIN,ON_Guide_CHG_MIN)
    self:AddDataListener(DataMessageNames.ON_SCENE_CHG, OnScenechg)
end
function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveDataListener(DataMessageNames.ON_Guide_CHG)
    self:RemoveDataListener(DataMessageNames.ON_Guide_Click)
    self:RemoveDataListener(DataMessageNames.ON_Guide_CHG_MIN)
    self:RemoveDataListener(DataMessageNames.ON_SCENE_CHG)
end
function this.OnDisable(self)
    base.OnDisable(self);
end
function this.OnDestroy(self)
    base.OnDestroy(self);
end


return this;
