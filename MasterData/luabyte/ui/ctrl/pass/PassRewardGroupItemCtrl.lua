local M = BaseClass("PassRewardGroupItemCtrl")

function M:__init(view)
    self._view = view
end

function M:SetInfo(itemId, numberType, num, num1)
    if not num then num = 0 end
    if not num1 then num1 = 0 end
    self._view.item:SetInfo(itemId, numberType, num, num1)
end

function M:Select(v)
    self._view.item:Select(v)
end

function M:SetLock(v)
    self._view.item:SetLock(v)
end

function M:SetClickCallback(v)
    self._view.item.onClick = v
end

function M:EnablePopItem(v)
    self._view.item:EnablePopItem(v)
end

function M:SetRedPoint(index, param)
    self._view.redPoint:SetParam(index, param)
end

function M:RedPointCheck()
    self._view.redPoint:Check()
end

function M:SetActive(v)
    self._view:SetActive(v)
end

function M:RefreshRedPoint()
    self._view.redPoint:RefreshRedPoint()
end

function M:Instantiate()
    return self._view:Instantiate()
end

function M:DoDispose()
    self:OnDispose()
end

function M:OnDispose()
    if self._view then
        self._view.item:DoDispose()
        self._view:OnDispose()
        self._view = nil
    end
end

return M
