
--
-- <代码文件解释说明>
--

---@class UIBossraidTeamInfoModel : UIBaseModel
---@field data BossraidLeaderboardRecord
local UIBossraidTeamInfoModel = BaseClass("UIBossraidTeamInfoModel",UIBaseModel)
local base = UIBaseModel
local this = UIBossraidTeamInfoModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.data = data.data
    self:OnRefresh()
end

function this:OnRefresh()

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
