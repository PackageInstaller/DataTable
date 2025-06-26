
--
-- <代码文件解释说明>
--

---@class UIRoleInfoModel : UIBaseModel
---@field role SocietyRole
local UIRoleInfoModel = BaseClass("UIRoleInfoModel",UIBaseModel)
local base = UIBaseModel
local this = UIRoleInfoModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.role = data.role
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
