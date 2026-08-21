local M = BaseClass("LotteryDrawData")

function M:SetData(roleLottoRec)
    -- self.Count = roleLottoRec.Count
    -- self.Total = roleLottoRec.Total
    -- self.Sign = roleLottoRec.Sign
    self.LottoId = roleLottoRec.LottoId
    local cfg    = ConfigHelper.GetCfg("luckDraw", self.LottoId)
    if cfg ~= nil then self.Sign = cfg.sign end
    self.TotalTimes     = roleLottoRec.TotalTimes
    self.GuaranteeFlag  = roleLottoRec.GuaranteeFlag
    self.SsrCountdown   = roleLottoRec.SsrCountdown
    self.ConditionTime  = roleLottoRec.ConditionTime  -- 每日抽卡道具消耗限制时间戳
    self.ConditionValue = roleLottoRec.ConditionValue -- 每日抽卡道具消耗限制使用量
end

return M
