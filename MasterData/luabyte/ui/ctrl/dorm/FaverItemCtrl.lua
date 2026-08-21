local FaverItemCtrl = BaseClass("FaverItemCtrl", UIBaseComponent)
local M = FaverItemCtrl
local sfmt = string.format

function M:__init(view)
    self._view = view
end

function M:UpdateData(unlockWord)
    -- local tips = ConfigHelper.GetLocalString(5741)
    -- self._view.labTitle:SetText(sfmt(tips, favorLevel))
    self._view.labDesc:SetText(unlockWord)
end

return FaverItemCtrl
