local M = BaseClass("FreeChooseItemCtrl", UIBaseComponent)

function M:__init()
    self._itemData = nil
    self._callback = nil
    self._view.downBtn:onClick(Bind(self, self._OnClickMinus))
    self._view.clickBg:onClick(Bind(self, self._OnClickBg))
    self._view.clickBg:onLongPress(Bind(self, self._OnPressBg))
    self._view.clickBg:SetLongPressTimes(1)
    self._view.item:EnableClick(false)
    self._view.item:Select(false)
end

function M:_OnClickMinus(go)
    if self._callback and self._callback(false) then
        self._itemData.selectedCount = self._itemData.selectedCount - 1
        self:UpdateItem(self._itemData)
    end
end

function M:_OnPressBg(go)
    self._isPress = true
    self._view.clickBg:SetLongPressTimes(0.1)
    if self._callback and self._callback(true) then
        self._itemData.selectedCount = self._itemData.selectedCount + 1
        self:UpdateItem(self._itemData)
    end
end

function M:_OnClickBg(go)
    if self._isPress then
        self._view.clickBg:SetLongPressTimes(1)
        self._isPress = false
        return
    end
    if self._callback and self._callback(true) then
        self._itemData.selectedCount = self._itemData.selectedCount + 1
        self:UpdateItem(self._itemData)
    end
end

function M:SetClickCallback(callback)
    self._callback = callback
end

function M:UpdateItem(item)
    self._itemData = item
    local itemId = item.itemId
    self._view.item:SetInfo(itemId, ItemNumberType.TOTLE, self._itemData.Count)
    self._view.numObj:SetActive(self._itemData.selectedCount > 0)
    self._view.useNum:SetText(tostring(self._itemData.selectedCount))
    self._view.downBtn:SetActive(self._itemData.selectedCount > 0)
    local num = ItemDataMgr:GetInstance():GetItemNumById(itemId)
    self._view.txtItemCount:SetText(ConfigHelper.GetLocalString(4114) .. num)
end

function M:OnDestroy()
    self._view.downBtn:onClick(nil)
    self._view.clickBg:onClick(nil)
    self._view.clickBg:onLongPress(nil)
    self._callback = nil
    M.super.OnDestroy(self)
end

return M
