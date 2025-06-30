
--
-- <代码文件解释说明>
--

---@class UIBattlePassRewardModel : UIBaseModel
---@field pass Pass
---@field response protocol.ReceivePassRewardsResp
local UIBattlePassRewardModel = BaseClass("UIBattlePassRewardModel",UIBaseModel)
local base = UIBaseModel
local this = UIBattlePassRewardModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.passId = data.passId
    self.beginLevel = data.beginLevel
    self.endLevel = data.endLevel
    self.response = data.response
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type PassComponent
    local passComponent = Game.Scene.Player:GetComponent("PassComponent")
    self.pass = passComponent:GetPass(self.passId)
end

function this:OnAddListener()
    base.OnAddListener(self)
    -- self:AddDataListener(DataMessageNames.xxx,func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- self:RemoveDataListener(DataMessageNames.xxx)
end

return this
