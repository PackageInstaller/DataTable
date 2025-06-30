
--
-- <代码文件解释说明>
--

---@class UIUseOptionalItemModel : UIBaseModel
---@field id number
---@field item Item
local UIUseOptionalItemModel = BaseClass("UIUseOptionalItemModel",UIBaseModel)
local base = UIBaseModel
local this = UIUseOptionalItemModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.id = data.id
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type ItemComponent
    local ItemComponent = Game.Scene.Player:GetComponent("ItemComponent")
    self.item = ItemComponent.Items[self.id]
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
