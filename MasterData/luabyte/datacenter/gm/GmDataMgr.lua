local GmDataMgr = BaseClass("GmDataMgr", Singleton)
local M = GmDataMgr
local MessageId = Proto.MessageId

function M:__init(obj)
    self._callback = nil

    self._responseGameCmd = NetPack:RegistResponse
        (MessageId.ResponseGameCmd, Bind(self, self.OnResponseGameCmd))
end

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.ResponseGameCmd, self._responseGameCmd)

    self._callback = nil
end

function M:RequestGameCmd(cmdType, cmdPara, callback)
    self._callback = callback

    local request = {}
    request.cmdType = cmdType
    request.cmdPara = cmdPara
    NetPack:SendMessage(MessageId.RequestGameCmd, request)
end

function M:OnResponseGameCmd(messageId, result, msg)
    if result ~= 0 then
        self._callback = nil
        return
    end

    if self._callback then
        self._callback()
        self._callback = nil
    end
end

function M:Cleanup()
end

return GmDataMgr