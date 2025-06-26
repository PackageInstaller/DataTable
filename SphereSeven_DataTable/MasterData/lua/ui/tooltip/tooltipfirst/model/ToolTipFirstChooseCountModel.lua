
--
-- <代码文件解释说明>
--

---@class ToolTipFirstChooseCountModel : UIBaseModel
local ToolTipFirstChooseCountModel = BaseClass("ToolTipFirstChooseCountModel",UIBaseModel)
local base = UIBaseModel
local this = ToolTipFirstChooseCountModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.message = data.message
    self.title = data.title
    self.tempId = data.tempId
    self.maxCount = data.maxCount
    self.callBack = data.callBack
    self.isShowCurrentCount =data.isShowCurrentCount
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type ItemComponent
    local ItemComponent = Game.Scene.Player:GetComponent("ItemComponent")
    self.item = ItemComponent:GetItem(self.tempId)
    if self.item ~= nil then
        if self.maxCount == nil or self.maxCount > self.item.Amount then
            self.maxCount = self.item.Amount
        end
    end
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
