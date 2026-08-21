
---@class UICardListModel : UIBaseModel
local UICardListModel = BaseClass("UICardListModel",UIBaseModel);
local base = UIBaseModel
local this = UICardListModel



function this.OnCreate(self)
    base.OnCreate(self);
   
end

---@param self UICardListModel
function this.OnEnable(self,data)
    if data == nil then data = {} end
    self.cardInit = data.cardInit
    self.callBack = data.callBack
    self.cardList = data.cardList
    self.type = data.type
    base.OnEnable(self);
    self:OnRefresh();
end

function this.OnRefresh(self)

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
    base.OnDestroy(self);
end

return this;
