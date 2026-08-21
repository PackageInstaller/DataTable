local M = BaseClass("BaseRedPointChecker")
local CS_RedPoint = CS.GameX.RedPoint

function M:__init(type)
    self._type = type
    self.checkResult = 0
    self.isChecking = false
    self.keepWaiting = false
    self.serverCheckResult = 0
    self.gameModel = 0
    self.Current = nil
    self.dataCenterId = nil
end

function M:OnChanged(param)
    param = param or 0

    if param <= -99 then
        self.checkResult = 0
        return false
    end

    return true
end

function M:Check(param)

end

--服务器通知改变
function M:OnNotifyRedPoint(result)
    self.serverCheckResult = result or 0
    self.checkResult = self.serverCheckResult
    self:NotifyChanged(result)
end

function M:NotifyChanged(result)
    if self.keepWaiting then return end
    CS_RedPoint.Notify(self._type, result)
    self:SynchronizeServerRedPoint(result)
end

--同步服务器相关红点数据【如有必要】
function M:SynchronizeServerRedPoint(result)
    result = result or self.serverCheckResult
    if self.gameModel > 0 and self.serverCheckResult ~= result then
        local RequestUpdateRedPoint = {}
        RequestUpdateRedPoint.Point = {}
        RequestUpdateRedPoint.Point.Mod = self.gameModel
        RequestUpdateRedPoint.Point.Value = result
        NetPack:SendMessage(Proto.MessageId.RequestUpdateRedPoint, RequestUpdateRedPoint)
        self.serverCheckResult = result
        self.checkResult = result 
    end
end

function M:MoveNext()
    return self.keepWaiting
end

function M:Reset()
    -- body
end

function M:Clean()

end

return M
