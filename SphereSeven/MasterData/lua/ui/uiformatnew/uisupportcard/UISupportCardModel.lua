
--
-- <代码文件解释说明>
--

---@class UISupportCardModel : UIBaseModel
---@field battleUnit BattleUnit @ battleUnit数据
local UISupportCardModel = BaseClass("UISupportCardModel",UIBaseModel)
local base = UIBaseModel
local this = UISupportCardModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.battleUnit = data.battleUnit
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
