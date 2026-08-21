local M = BaseClass("CircularScrollViewItem")

function M:__init(view)
    self._view = view
    self.view = view 
    self:Init()
end

function M:Init()
    -- body
end

function M:UpdateItem(data, idx)

end

function M:SetCircularScroll(scroll)
    self._circularScroll = scroll 
end

function M:RefreshList()
    if self._circularScroll then 
        self._circularScroll:UpdateList()
    end
end

function M:Dispose()
    self:OnDispose()
end

function M:OnDispose()
    if self._view and self._view.OnDispose then
        self._view:OnDispose()
    end
    self._view = nil
end

return M
