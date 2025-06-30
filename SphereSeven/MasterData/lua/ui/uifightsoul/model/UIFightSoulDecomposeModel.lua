
--
-- <代码文件解释说明>
--

---@class UIFightSoulDecomposeModel : UIBaseModel
local UIFightSoulDecomposeModel = BaseClass("UIFightSoulDecomposeModel",UIBaseModel)
local base = UIBaseModel
local this = UIFightSoulDecomposeModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    self.fightSoulList = Game.Scene.Player:GetComponent("FightSoulComponent").FightSouls

end

local function ON_FIGHTSOUL_DATA_UPDATE(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_FIGHTSOUL_DATA_UPDATE,ON_FIGHTSOUL_DATA_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
end

return this
