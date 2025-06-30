
--
-- <代码文件解释说明>
--

---@class UIHandBookPropertyModel : UIBaseModel
local UIHandBookPropertyModel = BaseClass("UIHandBookPropertyModel",UIBaseModel)
local base = UIBaseModel
local this = UIHandBookPropertyModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
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
