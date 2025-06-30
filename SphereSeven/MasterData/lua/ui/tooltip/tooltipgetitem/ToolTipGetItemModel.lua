---@class ToolTipGetItemData
---@field hideCloseBtn boolean
---@field hideBackBtn boolean
---@field hideConfirmBtn boolean
---@field callBack function @ 确认回调 (先默认关闭此页面 再调用回调)
---@field cancelCallBack function @ 取消回调 (先默认关闭此页面 再调用回调)
---@field alignment number @ text对齐
---@field title string @ 标题文本 (nil 为默认"提示")
---@field topText string @ 顶部文本 (nil 为默认"")
---@field bottomText string @ 底部文本 (nil 为默认"")
---@field itemText string @ 物品文本 (nil 为默认"")
---@field items {id:number, count:number}[] @ 物品id 用于显示道具, 物品数量 (nil 为不显示数量)

---@class ToolTipGetItemModel : UIBaseModel
---@field data ToolTipGetItemData
local ToolTipGetItemModel = BaseClass("ToolTipGetItemModel",UIBaseModel)
local base = UIBaseModel
local this = ToolTipGetItemModel

function this.OnCreate(self)
    base.OnCreate(self);
    self.data = nil;
end

function this.OnEnable(self,data)
    base.OnEnable(self);
    self:OnRefresh(data);
end

function this.OnRefresh(self,data)
    self.data = data;
end

function this.OnAddListener(self)
    base.OnAddListener(self);
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDisable(self)
    base.OnDisable(self);
    
end

function this.OnDestroy(self)
    self.data = nil;
    base.OnDestroy(self);
end

return this

