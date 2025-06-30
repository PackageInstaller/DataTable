
--
-- <代码文件解释说明>
--

---@class UIThingsDetailFightSoulModel : UIBaseModel
---@field fightSoulId number
---@field star number
---@field level number
---@field isMax boolean
local UIThingsDetailFightSoulModel = BaseClass("UIThingsDetailFightSoulModel",UIBaseModel)
local base = UIBaseModel
local this = UIThingsDetailFightSoulModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.fightSoulId = data.tempId
    self.isMax = false
    self.star = 1
    self.level = 1
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
