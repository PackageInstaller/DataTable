
--
-- <代码文件解释说明>
--

---@class UIMoreItemModel : UIBaseModel
---@field rewards {Id:number, Type:number, ObjId:number, Count:number}[]
local UIMoreItemModel = BaseClass("UIMoreItemModel",UIBaseModel)
local base = UIBaseModel
local this = UIMoreItemModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.rewards = data.rewards
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
