
--
-- <代码文件解释说明>
--

---@class UIBossraidSweepModel : UIBaseModel
local UIBossraidSweepModel = BaseClass("UIBossraidSweepModel",UIBaseModel)
local base = UIBaseModel
local this = UIBossraidSweepModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.levelType = data.level
    self.levelId = data.levelId
    self.callback = data.callBack
    self.maxCount = 
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
