local M = BaseClass("ComNumSliderCtrl")

function M:__init(view)
    self._view = view
    self.m_minNum = 1
    self.m_maxNum = 1
    self.m_curNum = 1
    self.m_onNumChanged = nil
    self._view.numSlider:SetValue(0)
    self._view.btn_more:onClick(Bind(self, self.OnClickMore))
    self._view.btn_less:onClick(Bind(self, self.OnClickLess))
    self._view.numSlider:OnSliderChanged(Bind(self, self.OnSliderValueChanged))
end

function M:OnDispose()
    self.m_minNum = nil
    self.m_maxNum = nil
    self.m_curNum = nil
    self.m_onNumChanged = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

-- 数字变化回调
function M:SetChangedCallback(callback)
    self.m_onNumChanged = callback
end

function M:SetSliderInfo(curNum, maxNum, minNum)
    if not minNum then minNum = 1 end
    if maxNum < minNum then maxNum = minNum end

    self.m_minNum = minNum
    self.m_maxNum = maxNum
    local slider = self._view.numSlider
    local isVaild = self.m_maxNum > self.m_minNum
    local minValue = isVaild and self.m_minNum or 0
    slider:SetMin(minValue)
    slider:SetMax(self.m_maxNum)
    slider:SetInteractive(isVaild)
    self:_UpdateCurValueAndState(curNum)
    slider:SetValueWithoutNotify(self.m_curNum)
    self._view.txt_numMin:SetText(tostring(self.m_minNum))
    self._view.txt_numMax:SetText(tostring(self.m_maxNum))
end

function M:OnClickMore(go)
    if self.m_curNum >= self.m_maxNum then return end
    self._view.numSlider:SetValue(self.m_curNum + 1)
end

function M:OnClickLess(go)
    if self.m_curNum <= self.m_minNum then return end
    self._view.numSlider:SetValue(self.m_curNum - 1)
end

function M:OnSliderValueChanged(value)
    self:_UpdateCurValueAndState(math.floor(value))
end

function M:_UpdateCurValueAndState(num)
    self.m_curNum = Mathf.Clamp(num, self.m_minNum, self.m_maxNum)
    self._view.txt_numNow:SetText(tostring(self.m_curNum))
    if self.m_onNumChanged then self.m_onNumChanged(self.m_curNum) end

    local isMin = self.m_curNum <= self.m_minNum
    local isMax = self.m_curNum >= self.m_maxNum
    self._view.btn_less:SetState(isMin and 2 or 1)
    self._view.btn_more:SetState(isMax and 2 or 1)
end

function M:GetCurNum()
    return self.m_curNum
end

function M:SetActive(v)
    self._view:SetActive(v)
end

return M
