--baoruichang

local UICookClassCtrl = BaseClass("UICookClassCtrl")
local M = UICookClassCtrl

function M:__init(view)
    self._view = view
end

function M:UpdateData(data)
    --{id = id,haveNum = haveNum,needNum = needNum}
    if not data then
        self._view.state:SetState(3)
        return
    end
    self._view.imgIcon:SetItemIcon(data.id)
    if data.haveNum==data.needNum then
        self._view.state:SetState(2)
    else
        self._view.state:SetState(1)
    end
    self._view.labNum:SetText(tostring(data.needNum))
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UICookClassCtrl
