---@class NetManager2
local NetManager2 = class("NetManager2", require "NetMidw")

------------------------plan2---------------------------
--local NetManager2 = class("NetManager2")

--function extend(target)
--    local t = tolua.getpeer(target)
--    if not t then
--        t = {}
--        tolua.setpeer(target, t)
--    end
--    setmetatable(t, NetManager2)
--    target:ctor(target)
--    return target
--end
------------------------plan2---------------------------

local _checkReconnectSeconds = 3
local _stampCalc = os.time

function NetManager2:GetMsgProtoId(name)
    local id = self.SProtoSpace[name]
    if id then
        return id
    else
        return nil
    end
end

function NetManager2:GetProtoName(id)
    local msg = self.SProtoSpace[id]
    if msg then
        return msg
    else
        return ""
    end
end

function NetManager2:ctor(name)
    self.SProtoSpace = require "protocols"
    self.callbackArray = {}
    self.msgFuncTable = {}

    -- *** use pbc ***
    -- self.pb = require "protobuf"
    -- *** use pbc ***

    -- *** use lua-protobuf ***
    self.pb = require "pb"
    self.pb.option("no_default_values")
	self.pb.option("encode_default_values")
    -- *** use lua-protobuf ***
    -- self.pb = require "protobuf"


    self.pb.ExtractEnabled = true
    self.loaderMap = {}
    self.protosRmvOnDisconnect = {}
end

local EmptyCallback = function () end

function NetManager2:doSendWait(name, data, callback, loaderTime, sessionId)
    if not self.cacheProtoExcept or self.cacheProtoExcept[name] then
        local id = self:GetMsgProtoId(name)
        --LuaLogger.ds(name, tablex.dump(data))
        local buf = self.pb.encode(name, data)
        --LuaLogger.ds(name, tablex.dump(self.pb.decode(name, buf)))
        if sessionId then
            self:QueueSendWithSession(id, buf, sessionId)
        else
            sessionId = self:QueueSend(id, buf)
        end

        if GV.IsEditor then
            pcall(function()
                LuaLogger.ds("[auto][发送]", name, sessionId, id, tablex.dump(self.pb.decode(name, buf)), callback)
            end)    
        end
        

        local loaderId
        if not GV.IsServerLogic then
            if loaderTime == nil then
                loaderTime = 1
            end

            if loaderTime >= 0 then
                loaderId = UIMgr:startLoad(loaderTime)
                --LuaLogger.ds("start load", sessionId, name, loaderId)
                self.loaderMap[sessionId] = loaderId
            end
        end
    else
        LuaLogger.ds("CacheMessage", name)
    end

    local callbackData = {sessionId = sessionId, callback = callback, name = name, data = data, loaderTime = loaderTime}
    if loaderTime and loaderTime > 0 then
        callbackData.loaderStartStamp = _stampCalc()
        callbackData.loaderStartFrameCount = Time.frameCount
    end

    table.insert(self.callbackArray, callbackData)
end

function NetManager2:addProtoesToRmvOnDisconnect(protoNames)
    for i, v in ipairs(protoNames) do
        if isstring(v) then
            self.protosRmvOnDisconnect[v] = v
        else
            self.protosRmvOnDisconnect[v.protoName] = v
        end
    end
end

function NetManager2:CacheMessageExcept(protoNames)
    self.cacheProtoExcept = {}
    for i, v in ipairs(protoNames) do
        self.cacheProtoExcept[v] = true
    end
end

function NetManager2:StopCacheMessage()
    self.cacheProtoExcept = nil
end

-- loaderTime < 0 时，表示不显示loader
function NetManager2:SendWaitMessage(name, data, callback, loaderTime)
    self:doSendWait(name, data, callback, loaderTime)
    --  if StopSend then
    --     StopSend = false
    --     LuaLogger.ds("StopSend Disconnect")
    --     self:Disconnect()
    -- end

    -- print("req sessionId", sessionId)
end

function NetManager2:SendMessage(name, data, callback)
    self:doSendWait(name, data, callback, -1)
end

-- 将等待返回消息队列里的消息再发送出去(目前是在断线重连之后)
function NetManager2:ReSendMessage(resendSessionIds)
    LuaLogger.ds("ReSendMessage")
    self:ClearLoader()
    local tmpArray = self.callbackArray
    self.callbackArray = {}
    for i,v in ipairs(tmpArray) do
        local exist = false
        for _,vv in ipairs(resendSessionIds) do
            if vv == v.sessionId then
                exist = true
            end
        end
        if exist then
            LuaLogger.ds("Resend", v.sessionId, v.name)
            self:doSendWait(v.name, v.data, v.callback, v.loaderTime, v.sessionId) -- loaderTime有的是-1，所以不能统一用0
        end
    end
end

-- 收集需重发消息
function NetManager2:CollectNeedResendSessionIds()
    local tmpArray = {}
    for i,v in ipairs(self.callbackArray) do
        table.insert(tmpArray, v.sessionId)
    end
    return tmpArray
end

function NetManager2:ClearLoader()
    for k,v in pairs(self.loaderMap) do
        UIMgr:endLoad(v)
    end
    self.loaderMap = {}
end

function NetManager2:ClearSessionData(sessionId)
    self:RemoveCallbackOfSession(sessionId)
    self:GetCallbackOfSession(sessionId, true)
end

function NetManager2:RemoveCallbackOfSession(sessionId)
    self:RemoveLoaderOfSession(sessionId)
end

function NetManager2:RemoveLoaderOfSession(sessionId)
    if self.loaderMap[sessionId] then
        -- LuaLogger.ds("endloader", sessionId)
        UIMgr:endLoad(self.loaderMap[sessionId])
        self.loaderMap[sessionId] = nil
    end
end

function NetManager2:GetCallbackOfSession(sessionId, del)
    for i, v in ipairs(self.callbackArray) do
        if v.sessionId == sessionId then
            if del then
                table.remove(self.callbackArray, i)
            end

            return v.callback
        end
    end
end

function NetManager2:GetCallbackDataOfProtoName(protoName, del)
    for i, v in ipairs(self.callbackArray) do
        if v.name == protoName then
            if del then
                table.remove(self.callbackArray, i)
            end

            return v
        end
    end
end

function NetManager2:GetMsgDealer(nMsgId)
    local dealer = self.msgFuncTable[nMsgId]
    if dealer then
        return dealer
    else
	    return nil
    end
end

--function GetMsgProtoName(nMsgId)
--	return self.msgFuncTable[nMsgId].protoName;
--end

function NetManager2:RegisterMsgDealer(protoStr, dealerFunc)
	local msgID = self:GetMsgProtoId(protoStr)
	if msgID == nil then 
		LuaLogger.e("msgID is nil, RegisterMsgDealer fail, protoStr is " .. protoStr)
		return 
	end
	
	if dealerFunc == nil then 
		LuaLogger.e("msg dealer func is invalid, RegisterMsgDealer fail ")
		return
	end
	
	local protoName = self:GetProtoName(msgID)

	self.msgFuncTable[msgID] = {}
	self.msgFuncTable[msgID].dealerFunc = dealerFunc
	self.msgFuncTable[msgID].protoName = protoName

	--InfoLog("RegisterMsgDealer OK, msg id=%d : %s", msgID, protoName)
end

function NetManager2:GetDealer(sessionId, protoId, msg, del)
    local str = self:GetProtoName(protoId)
    local tb = self.pb.decode(str, msg)
    -- tb = protoClone(tb)
    if GV.IsEditor then
        pcall(function()
            LuaLogger.ds("[auto][接收]", str, sessionId, protoId, tablex.dump(tb))
        end)
    end
    
    local dealed = false
    -- print("self.callbackArray:length()", self.callbackArray:length())
    local callback = self:GetCallbackOfSession(sessionId, del)
    if callback then
        return callback, tb
    end

    local dealer = self:GetMsgDealer(protoId)
    if dealer then
        return dealer.dealerFunc, tb
    end

    return nil
end

NetManager2.MsgFilter = function () return true end

function NetManager2:ProtoHandle(sessionId, protoId, msg)
    local dealer, data = self:GetDealer(sessionId, protoId, msg, true)

    -- if not server and self.loaderMap[sessionId] then
    -- 如果用上面的写法Sim模式到选服界面会一直转（跟server赋值的时机有关）
    -- LuaLogger.ds("ProtoHandle", sessionId, self:GetProtoName(protoId), tablex.dump(data))
    self:RemoveLoaderOfSession(sessionId)

    if dealer then
        data = protoclone(data)
        if self.MsgFilter(data, self:GetProtoName(protoId)) then
            --LuaLogger.ds(dealer, sessionId, protoId, tablex.dump(data))
            dealer(data)
        end

        return true
    else
        LuaLogger.e("No callback for %d %d:%s", sessionId, protoId, self:GetProtoName(protoId))
        return false
    end
end

function NetManager2:stopCheckTimer()
    if self.checkLoadingTimer then
        LuaLogger.ds("self:stopCheckTimer()", self.HandlerName, self.checkLoadingTimer)
        DLuaTimer:RemoveTimer(self.checkLoadingTimer)
        self.checkLoadingTimer = nil
    end
end

function NetManager2:startCheckTimer()
    self:stopCheckTimer()
    self.checkLoadingTimer = DLuaTimer:DoRepeatForever(1, function()
        local currentFrameCount = Time.frameCount
        local frameRate = math.max(30, math.min(60, Application.targetFrameRate))
        for i, v in ipairs(self.callbackArray) do
            --if v.loaderStartStamp and v.loaderTime and _stampCalc() - v.loaderStartStamp - v.loaderTime >= _checkReconnectSeconds then
            if v.loaderStartFrameCount and v.loaderTime and  (currentFrameCount - v.loaderStartFrameCount) >= _checkReconnectSeconds * frameRate then
                print("Check Timer do disconnect", v.sessionId, v.name)
                self:stopCheckTimer()
                LuaLogger.ds("Check Timer do disconnect", self.HandlerName)
                self:Disconnect()
                break
            end
        end
    end)
end

function NetManager2:LuaConnect(ip, port, action)
    local loaderId = UIMgr:startLoad(1)
    local wrap = function (success)
        action(success)
        UIMgr:endLoad(loaderId)
    end

    self:Connect(ip, port, wrap)
end

function NetManager2:DisconnectHandle()
    LuaLogger.ds("base NetManager:DisconnectHandle()")
    self:stopCheckTimer()
    for k, v in pairs(self.protosRmvOnDisconnect) do
        local callbackData, toCallback
        if isstring(v) then
            callbackData = self:GetCallbackDataOfProtoName(v, true)
        else
            callbackData = self:GetCallbackDataOfProtoName(v.protoName, true)
            toCallback = v.callback
        end

        if callbackData then
            LuaLogger.ds("remove callback", v.protoName, callbackData.sessionId, callbackData.callback)
            self:ClearSessionData(callbackData.sessionId)
            if toCallback then
                callbackData.callback(nil) -- 对应 self:SendWaitMessage("user.LoginGateReq", req, function (data)
            end
        end
    end
end

function NetManager2:SendProtoResultHandle(sessionId, protoId, success)
    --LuaLogger.ds("send", sessionId, protoId, success)
    -- 主要针对发送成功但没有返回的协议
    local callback = self:GetCallbackOfSession(sessionId, false)
    if not callback then
        self:GetCallbackOfSession(sessionId, true)
    end
end

return NetManager2