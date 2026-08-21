local baseCtrl = require("Framework.UI.Component.CircularScrollViewItem")
local M = BaseClass("ChapterNameItemCtrl", baseCtrl)

function M:UpdateItem(data, idx)
    if data == nil then return end
    self._view.mNum:SetText(string.format("%02d", idx - 1))
    self._view.mName:SetText(data.name)
    local type = data.type + 470; -- 471:普通  472：困难
    self._view.cnType:SetText(type)
end

function M:Dispose()
    -- body
    M.super.Dispose(self)
end

return M
