local M = BaseClass("PlotReviewChapterItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

-- 剧情章节图鉴Item
function M:Init()
    self._view.btn_enter:onClick(Bind(self, self.OnClickItem))
end

function M:OnDispose()
    self.m_data = nil
    self.m_index = nil
    self.m_callback = nil
    M.super.OnDispose(self)
end

function M:UpdateItem(data, idx)
    if not data then return end

    self.m_index = idx
    self.m_data = data
    local fmtStr = ConfigHelper.GetLocalString(4143)
    local value = self.m_data.UnlockNum / self.m_data.TotalNum
    self._view.img_prog:SetFillAmount(value)
    self._view.txt_chName:SetText(self.m_data.Name)
    self._view.img_icon:SetPic(self.m_data.PicPath, false)
    self._view.txt_index:SetText(string.format("%02d", idx - 1))
    self._view.txt_prog:SetText(string.format(fmtStr, math.floor(value * 100)))

    if self.m_data.SubType then
        self._view.redPoint:SetParam(0, self.m_data.SubType)
        self._view.redPoint:Check()
    end
end

function M:OnClickItem(go)
    if self.m_callback then
        self.m_callback(self.m_data, self.m_index)
    end
end

function M:SetCallback(callback)
    self.m_callback = callback
end

return M
