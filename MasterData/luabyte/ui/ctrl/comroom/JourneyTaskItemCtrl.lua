local M = BaseClass("JourneyTaskItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()

end

function M:UpdateItem(data)
    if data == nil then return end
    self._view.desc:SetText(data.Desc)
    self._view.first:SetActive(data.Index == 1)
    if data:IsReach() then
        -- 已达成
        self._view.uiState:SetState(2)
    else
        -- 未达成
        self._view.uiState:SetState(1)
    end
end

return M
