local TestLuaScrollItemCtrl = BaseClass("TestLuaScrollItemCtrl")
local M = TestLuaScrollItemCtrl

function M:__init(view)
    self._view = view
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:UpdateItem(data)
    if data == nil then
        return
    end
    self._view.txt_itemDes:SetText(ConfigHelper.GetLocalString(179))
end

return TestLuaScrollItemCtrl
