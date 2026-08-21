local DormRoleFashionCardItemCtrl = BaseClass("DormRoleFashionCardItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))
local M = DormRoleFashionCardItemCtrl

function M:Init()
    self._view:onClick(Bind(self, self._OnClickItem))
    self._RoleFashionUICtr = UIContextMgr:GetInstance():GetCtrl("DormRoleFashionUI")
end

function M:UpdateItem(data, idx)
    self._data = data
    self._idx = idx
    self:RefreshView(idx)
end

-- 刷新界面
function M:RefreshView(idx)
    -- 设置时装图片
    self._view.rawImg:SetPic(self._data.skinCfg.fashionPicture)
    self.CurItemId = self._RoleFashionUICtr:GetSelectedIndex()
    if self._RoleFashionUICtr:GetSelectedIndex() == idx then
        self._view.arrowSelect:SetActive(true)
        self._view.item:SetAsLastSibling()
    else
        self._view.arrowSelect:SetActive(false)
    end
end

function M:_OnClickItem()
    if self._RoleFashionUICtr:GetSelectedIndex() ~= self._idx then
        self._RoleFashionUICtr:_SetCenterChild(self._idx)
    end
end

function M:OnDispose()
    M.super.OnDispose(self)
end
return M