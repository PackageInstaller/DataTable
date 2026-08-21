local GiftItemCtrl = BaseClass("GiftItemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))
local M = GiftItemCtrl
M._heroLayer = PhysicsMgr.NamesToLayer("TeamA")

function M:Init()
    self._data = nil
    self._touchCallback = nil
    self._view.BtnTips.transform:onClick(Bind(self, self.ClickTips))
end

function M:EnableTouch(enable)
    if enable then
        UITouchHandle.SetTouchHandle(self._view, self)
    else
        UITouchHandle.DisposeTouchHandle(self._view)
    end
end

function M:SetDragCallback(callback)
    self._touchCallback = callback
end

function M:ClickTips(go)
    GameHelper.PopItem(self._data.data.Id, 0, self._view)
end

function M:SetSelect(isSelect)
    self:Select(isSelect)
end

function M:SetDragMode()
    self._view.UpBg:SetActive(false)
    self._view.TextBg:SetActive(false)
end

function M:SetDraging(isDrag)
    self:Select(isDrag)
end

function M:Copy(container)
    local copyData = {}
    copyData.isSelect = self._data.isSelect
    copyData.selectable = self._data.selectable
    copyData.data = self._data.data
    copyData.isUp = self._data.isUp
    copyData.isAct = self._data.isAct
    local copyItem = GiftItemCtrl.New(self._view:Instantiate())
    copyItem._view:SetParent(container)
    copyItem:UpdateItem(copyData)
    copyItem.parent = self
    copyItem:SetRaycast(false)
    UITouchHandle.DisposeTouchHandle(copyItem._view)
    copyItem:ChangeGiftState()
    return copyItem
end

function M:Refresh()
    self:UpdateItem(self._data)
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self._data = data
    self:Select(data.isSelect)
    local d = data.data
    self:SetItemNameActive(true)
    self:SetInfo(d.Id, ItemNumberType.TOTLE, d.Num)
    self._view.UpBg:SetActive(data.isUp)
    self._view.transform:SetLocalRotation(0, 0, 0)
end

function M:ChangeGiftState()
    self._view.QualityColor.gameObject:SetActive(false)
    self._view.BtnTips.gameObject:SetActive(false)
    self._view.UpBg.gameObject:SetActive(false)
    self._view.Name.gameObject:SetActive(false)
    self._view.TextBg.gameObject:SetActive(false)
    self._view.Act.gameObject:SetActive(false)
end

function M:GetData()
    return self._data
end

function M:GetColliderLayer()
    return M._heroLayer
end

function M:OnDrag(eventData, isRange)
    if self._data.selectable == false then
        return
    end
    self._touchCallback(UITouchHandle.EventType.Draging, self, eventData, isRange)
end

function M:OnBeginDrag(eventData)
    if self._data.selectable == false then
        return
    end
    self._touchCallback(UITouchHandle.EventType.StartDrag, self, eventData, true)
end

function M:OnEndDrag(eventData, isRange)
    if self._data.selectable == false then
        return
    end
    self._touchCallback(UITouchHandle.EventType.EndDrag, self, eventData, isRange)
end

function M:SetPosByScreen(container, screenPos)
    self._view.transform:SetPosByScreenPos(container, screenPos)
end

function M:OnDispose()
    self:EnableTouch(false)
    self._responeGift = nil
    self.parent = nil
    self._touchCallback = nil
end

function M:Destory()
    if self._view then
        UITouchHandle.DisposeTouchHandle(self._view)
        self._view:DestroyImmediate()
    end
    self:OnDispose()
    self._view = nil
end

return GiftItemCtrl
