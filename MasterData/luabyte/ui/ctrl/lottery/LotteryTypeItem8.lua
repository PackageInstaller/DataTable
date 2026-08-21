local LotteryTypeItem8 = BaseClass("LotteryTypeItem8", require("UI.Ctrl.Lottery.BaseLotteryItem"))
local M = LotteryTypeItem8

function M:_initView()

end

function M:Refresh(drawData)
    M.super.Refresh(self, drawData)
    local cfg = self._lotteryCfg
    --只用单抽去读数据
    local times = ConfigHelper.GetSystemParam(342)
    local restTimes = times
    if drawData ~= nil then
        restTimes = times - drawData.TotalTimes
        if drawData.SsrCountdown ~= nil then
            self._view.ssrNeedTime:SetText("最多<color=#FF8901>" .. drawData.SsrCountdown .. "/120</color>次必出SSR战员")
        end
    end

    if restTimes <= 0 then
        restTimes = 0
        self._view.numberTip:SetActive(false)
    end
    if self._view.numberTip ~= nil then
        self._view.numberTip:SetActive(false) --03.15杜老师要求先把这个隐藏
    end
    self._view.ssrCountTf:SetText(tostring(restTimes))


    if self._view.Time ~= nil then
        local startstr = GameHelper.TimeStampToString(cfg.startTime, "yyyy.MM.dd")
        local endstr = GameHelper.TimeStampToString(cfg.lastTime, "yyyy.MM.dd")
        self._view.Time:SetText(startstr .. "-" .. endstr)
    end


    if self._view.ssrNeedTime ~= nil then
        local num, max = self:GetSsrCountdownNumber(drawData)
        self._view.ssrNeedTime:SetText(string.format("最多<color=#FF8901>%d/%d</color>次必出SSR战员", num, max))
    end

    if self._view.drawTimes ~= nil then
        local num, max = self:GetDrawCardLimit(drawData)
        self._view.drawTimes:SetText("今日剩余精密星斯抽卡次数：<color=#FF8901>" .. num .. "/" .. max .. "</color>")
    end
end

return M
