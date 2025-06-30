
--
-- <代码文件解释说明>
--

---@class UIFormationChooseSupportModel : UIBaseModel
---@field role SocietyRole
local UIFormationChooseSupportModel = BaseClass("UIFormationChooseSupportModel",UIBaseModel)
local base = UIBaseModel
local this = UIFormationChooseSupportModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.role = data.role
    self.callBack = data.callBack
    self:OnRefresh()
end

function this:OnRefresh()

end

function this:OnRefreshSupport()
    self:UIBroadcast(UIMessageNames.ON_SUPPORT_CHG)
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
