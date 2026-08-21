local M = BaseClass("ComNumBarCtrl")

function M:__init(view)
    self._view = view
    self.m_minNum = 1
    self.m_onNumChanged = nil
    self._view.btn_plus:onLongPress(function(go)
        self._view.btn_plus:SetLongPressTimes(0.15)
        self:_SetNumber(self.m_selectNum + 1)
    end)
    self._view.btn_minus:onLongPress(function(go)
        self._view.btn_minus:SetLongPressTimes(0.15)
        self:_SetNumber(self.m_selectNum - 1)
    end)
    self._view.btn_plus:SetLongPressTimes(0.5)
    self._view.btn_minus:SetLongPressTimes(0.5)
    self._view.btn_min:onClick(function(go) self:_SetNumber(1) end)
    self._view.btn_max:onClick(function(go) self:_SetNumber(self.m_maxNum) end)
    self._view.btn_plus:onClick(function(go) self:_SetNumber(self.m_selectNum + 1) end)
    self._view.btn_minus:onClick(function(go) self:_SetNumber(self.m_selectNum - 1) end)
    self._view.btn_plus:onUp(function(go) self._view.btn_plus:SetLongPressTimes(0.5) end)
    self._view.btn_minus:onUp(function(go) self._view.btn_minus:SetLongPressTimes(0.5) end)
end

function M:SetNumberInfo(selectNumber, maxNumber, onChangeNumber)
    self.m_maxNum = maxNumber
    self.m_onNumChanged = onChangeNumber
    self:_SetNumber(selectNumber)
end

function M:SetNumBarInfo(curNum, maxNum, minNum)
    if maxNum < minNum then
        self.m_maxNum = minNum
    else
        self.m_maxNum = maxNum
    end
    self.m_minNum = minNum
    self:_SetNumber(curNum)
end

function M:SetNumChangedCallback(onChangeNumber)
    self.m_onNumChanged = onChangeNumber
end

function M:OnDispose()
    self.m_onNumChanged = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:_SetNumber(selectNumber)
    self.m_selectNum = Mathf.Clamp(selectNumber, self.m_minNum, self.m_maxNum)
    self._view.txt_number:SetText(tostring(self.m_selectNum))
    if self.m_onNumChanged then self.m_onNumChanged(self.m_selectNum) end
end

function M:GetSelectNumber()
    return self.m_selectNum
end

function M:SetActive(v)
    self._view:SetActive(v)
end

return M
