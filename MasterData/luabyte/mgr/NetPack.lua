require("Proto.Proto")
require("Proto.ProtoEnum")
local NetPack = BaseClass( "NetPack" )
local M = NetPack 

function M:__init()

    self.pb = require 'pb'
    local protoc = require 'protoc'
    local p = protoc.new()
    p.include_imports = true 
    p.unknown_type = true
    p.unknown_module = true 
    local messageBytes = IResourceManager:LoadLuaProto("message.pb")
    assert(self.pb.load(messageBytes))
    p.reload()

    self._responseDics = {}
    if NewNet then 
        INetPack.onByteMsg = Bind(self,self._OnByteMsg)
    else
        INetPack.onMsg = Bind(self,self._OnMsg)
    end
    self._protoMatches = {}
    --注册request 和 response 
    local requestName = "Request"
    local responseName = "Response"
    for protoName,protoId in pairs(Proto.MessageId) do
        if string.startswith( protoName,requestName) then 
            local name = string.sub(protoName,8)
            local responseProtoName = responseName .. name 
            local responseMessagId = Proto.MessageId[responseProtoName]
            if responseMessagId and responseMessagId > 0 then 
                self._protoMatches[protoId] = responseMessagId
                INetPack.connector:SetRequestResponse(protoId,Proto.MessageId[responseProtoName])
            end
        end
    end 
    self:_AddToTipsError()
end

function M:_AddToTipsError()
    INetPack:AddToTipsError(407)
    INetPack:AddToTipsError(857)
    INetPack:AddToTipsError(858)
    INetPack:AddToTipsError(859)
end

function M:_OnMsg(messageId,result,msg)
    local arr = self._responseDics[messageId]
    if arr == nil or #arr == 0 then 
        return 
    end
    local len = #arr 
    --从尾到头调用，担心迭代时删除
    for i = len , 1 , -1 do 
        local fun = arr[i]
        if fun then 
            fun(messageId,result,msg)
        end
    end
end

function M:_OnByteMsg(messageId,result,bytes)
    if self._responseDics[messageId] == nil then 
        return 
    end
    local arr = self._responseDics[messageId]
    if #arr == 0 then 
        return 
    end
    if bytes then 
        local msgName, msg = Proto.GetProto( messageId ,bytes)
        if msg.Result then 
            result = msg.Result 
            --和服务器约定 1 为正确码，为了客户端改动的问题，还是业务层还是使用0来判定
            if result == 1 then 
                result = 0 
                msg.Result = result 
            end
        end
        self:_OnMsg(messageId,result,msg)
    else
        self:_OnMsg(messageId,result,nil)
    end
    
end

function M:_AddReponse(messageId,responseCallback)
    if self._responseDics == nil then 
        return 
    end
    if messageId == nil then 
        Logger.LogError("MessageId is nil ")
        return 
    end
    if responseCallback == nil then 
        return 
    end
    if self._responseDics[messageId] == nil then
        self._responseDics[messageId] = {}
    end
    local idx = table.indexof( self._responseDics[messageId],responseCallback )
    if idx then
        print("重复添加 messageId" .. messageId ) 
        return 
    end
    table.insert( self._responseDics[messageId], responseCallback ) 
end

function M:_RemoveResponse(messageId,responseCallback)
    if self._responseDics == nil then 
        return 
    end
    if self._responseDics[messageId] ~= nil then
        local arr = self._responseDics[messageId]
        table.removebyvalue( arr,responseCallback ,true )
    end
end

--连接状态发生改变   1 - 开始连接， 2 - 连接成功 , 3 - 由网络错误导致的断开
function M:OnConnectStateChange(state)
    if state == 1 then 

    end
end

function M:SendMessage( messageId,msg)
    if self._responseDics == nil then 
        return false 
    end
    if self.m_nAccountId == nil or self.m_nAccountId == 0 then
        self.m_nAccountId = INetPack.accountId 
    end
    msg.AccountId = self.m_nAccountId 
    
    local msgName , bytes = Proto.GetProtoByte( messageId,msg )
    if msgName == nil then 
        Logger.LogError("messageId = " .. tostring(messageId) .. " 错误")
    end
    Logger.Log("<color=#2e91c1>lua客户端>>>>>服务器send:" .. msgName .. ",AccountId:" .. tostring(msg.AccountId) .. "</color>" .. " msg:" .. table.dump(msg))
    return INetPack:SendMessage(messageId,bytes)
end

function M:GetAccountId()
    if self.m_nAccountId == nil or self.m_nAccountId == 0 then
        self.m_nAccountId = INetPack.accountId 
    end
    return self.m_nAccountId
end

function M:GetServerId()
    return INetPack.serverId
end

function M:SendMessageNotKey(msg)
    if self._responseDics == nil then 
        return false 
    end
    if self.m_nAccountId == nil or self.m_nAccountId == 0 then
        self.m_nAccountId = INetPack.accountId 
    end
    msg.m_nAccountId = self.m_nAccountId 
    return INetPack:SendMessageNotKey(msg)
end

function M:RegistResponse(messageId,responseCallback)
    if NewNet then 
        if type(messageId) ~= "number" then 
            Logger.LogError("messageId 错误" .. messageId .. " must be a number ")
            return 
        end
    else
        if type(messageId)=="string" then 
            messageId = CS.PlatformRuntime.MessageId[messageId]
            if messageId == nil then 
                Logger.LogError("messageId 错误")
            end
        end
    end
    
    self:_AddReponse( messageId,responseCallback)
    return responseCallback
    -- INetPack:RegistResponse(messageId,responseCallback)
end

function M:UnRegistResponse(messageId,responseCallback)
    if type(messageId)=="string" then 
        messageId = CS.PlatformRuntime.MessageId[messageId]
        if messageId == nil then 
            Logger.Log("messageId 错误")
        end
    end
    self:_RemoveResponse(messageId,responseCallback)
    -- INetPack:UnRegistResponse(messageId,responseCallback)
end

function M:Cleanup()
    for messageId,callBackList in pairs(self._responseDics) do
        if callBackList then 
            for i,callBack in ipairs(callBackList) do
                self:UnRegistResponse(messageId,callBack)
            end
        end
    end
end

function M:SendHttp(isPost, url, method, param, callback)
    INetPack:SendHttp(isPost, url, method, param, callback)
end

function M:Dispose()
    INetPack.onMsg = nil 
    INetPack.onByteMsg = nil  
    self._responseDics = {} 
end



return NetPack 