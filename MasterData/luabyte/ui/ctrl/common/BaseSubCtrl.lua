local M = BaseClass("BaseSubCtrl")

-- 子面板Ctrl

function M:__init(view)
    self._view = view
    self:Init()
end

function M:Init()
    -- body
end

-- 入口函数
function M:OpenPanel()
    -- body
end

function M:Instantiate()
    if self._view then
        local newView = self._view:Instantiate()
        newView:SetParent(self._view._transform.parent)
        return self._class_type.New(newView)
    end
    return nil
end

function M:ShowPanel()
    self._view:SetActive(true)
end

function M:HidePanel()
    self._view:SetActive(false)
end

function M:SetActive(value)
    self._view:SetActive(value)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
