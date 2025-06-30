
--
-- <代码文件解释说明>
--

---@class UIOptionalSkinModel : UIBaseModel
local UIOptionalSkinModel = BaseClass("UIOptionalSkinModel",UIBaseModel)
local base = UIBaseModel
local this = UIOptionalSkinModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.id = data.id
    self.tempId = data.tempId
    self.isUse = data.isUse
    if self.isUse == nil then
        self.isUse = false
    end
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
