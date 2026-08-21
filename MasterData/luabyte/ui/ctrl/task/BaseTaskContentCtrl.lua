local BaseTaskContentCtrl = BaseClass("BaseTaskContentCtrl", BaseUICtrl)
local M = BaseTaskContentCtrl


function M:SetActive(v)
    self._view:SetActive(v)
end

function M:SetDataList(list)

end

return BaseTaskContentCtrl
