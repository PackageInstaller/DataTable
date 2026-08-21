local M = BaseClass("BossWarLvUpUICtrl", BaseUICtrl)


function M:Init()
    self._view.btn_mask:onClick(Bind(self, self.Close))
end

function M:OnEnter(level)
    self._view.uiState:SetState(level)
end

return M
