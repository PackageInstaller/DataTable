
--
-- <代码文件解释说明>
--

---@class UIBossraidSectionInfoModel : UIBaseModel
local UIBossraidSectionInfoModel = BaseClass("UIBossraidSectionInfoModel",UIBaseModel)
local base = UIBaseModel
local this = UIBossraidSectionInfoModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.levelId = data.levelId
    self.levelConfig = Z_BossraidLevel[self.levelId]
    self.bossraidId = data.bossraidId
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type BossraidComponent
    local bossraidComponent = Game.Scene.Player:GetComponent("BossraidComponent")
    self.bossraid = bossraidComponent:GetBossraidById(self.bossraidId)
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
