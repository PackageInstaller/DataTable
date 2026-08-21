local M = BaseClass("LotteryTypeItem1", require("UI.Ctrl.Lottery.BaseLotteryItem"))

function M:_initView()

end

function M:Refresh(drawData)
    M.super.Refresh(self, drawData)
    local cfg = self._lotteryCfg
    --只用单抽去读数据
    --local times = Mathf.Max( cfg.floorTimes , cfg.bigfloorTimes )
    local restTimes = 0

    -- local restTimes = times
    -- if drawData ~= nil then
    --     restTimes = times - drawData.Count
    -- end

    -- if restTimes < 0 then
    --     restTimes = 0
    -- end
    self._view.ssrCountTf:SetText(tostring(restTimes))

    if self._view.ssrNeedTime ~= nil then
        local num, max = self:GetSsrCountdownNumber(drawData)
        self._view.ssrNeedTime:SetText(string.format("最多<color=#FF8901>%d/%d</color>次必出SSR战员", num, max))
    end

    if self._view.drawTimes ~= nil then
        local times, max = self:GetDrawCardLimit(drawData)
        self._view.drawTimes:SetText("今日剩余精密星斯抽卡次数：<color=#FF8901>" .. times .. "/" .. max .. "</color>")
    end
end

return M
