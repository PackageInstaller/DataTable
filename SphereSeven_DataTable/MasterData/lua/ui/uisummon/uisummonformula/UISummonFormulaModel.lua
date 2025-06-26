
--
-- <代码文件解释说明>
--

---@class UISummonFormulaModel : UIBaseModel
local UISummonFormulaModel = BaseClass("UISummonFormulaModel",UIBaseModel)
local base = UIBaseModel
local this = UISummonFormulaModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.poolId = data.poolId
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
