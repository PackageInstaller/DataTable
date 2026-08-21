local RoomTimeItemCtrl = BaseClass("RoomTimeItemCtrl")
local M = RoomTimeItemCtrl

function M:__init(view)
    self._view = view
    self._view.transform:onClick(Bind(self, self._ClickLink))
end

--打开宿舍
function M:_ClickLink(go)
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self._data = data
    self._view.Text:SetText(self._data.desc)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return RoomTimeItemCtrl
