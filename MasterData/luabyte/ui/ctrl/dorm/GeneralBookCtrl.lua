local GeneralBookCtrl = BaseClass("GeneralBookCtrl", BaseUICtrl)
local M = GeneralBookCtrl

function M:Init()
    self._view.mask.transform:onClick(Bind(self, self._OnClickMask))
end

function M:OnEnter(furnitureId)
    local cfg = ConfigHelper.GetCfgByLua("furnitureDesc", furnitureId)
    
    --通用故事书
    if cfg.type == 1 then
        self._view.RoleImage:SetPic(cfg.leftPhoto)
        self._view.LeftText:SetText(cfg.leftWords)
        self._view.TitleText:SetText(cfg.rightTitle)
        self._view.ContentText:SetText(cfg.rightWords)
    end
end

--点击关闭
function M:_OnClickMask(go)
    self:Close()
end

return GeneralBookCtrl
