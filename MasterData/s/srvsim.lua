--服务器的模拟类
--用于模拟服务器的逻辑，其中包含了数据的encode和decode，以及消息的分发，并模拟了一个UserSim来进行数据的存储
--这里的UserSim是一个模拟用户，用于模拟用户的逻辑

local SrvSim = class("SrvSim")
local protocols = require "protocols"
local GameGlobal = require "GameGlobal"
local json = require "cjson"
local Player = require("PlayerAll").loadAllModules()
local DQueue = require "DQueue"

LuaMgr:AddLuaSearchPath("../../../server/lualib")

---下面的三个函数是用来在没有服务器的情况下，进行解包和封包的函数
---@param protoName string 协议名
---@param data table 数据
---@return string
---@return string
function pb_encode(protoName, data)
    -- LuaLogger.ds("encode", protoName, tablex.dump(data))

    -- *** use pbc ***
    -- local ok, proto = pcall(protobuf.encode, protoName, data)
    -- if not ok then
    --     LuaLogger.e("pbencode failed:%s-%s", protoName, proto)
    -- end
    -- *** use pbc ***

    -- *** use lua-protobuf ***
    local pb = require "pb"
    local proto = pb.encode(protoName, data)
    -- *** use lua-protobuf ***

	return proto, protoName
end

--消息解码
---@param data table
---@return table
function pb_decode(data)
    -- *** use pbc ***
    -- local msg = protobuf.decode(data.name, data.payload)
    -- *** use pbc ***

    -- *** use lua-protobuf ***
    local pb = require "pb"
    local msg = pb.decode(data.name, data.payload)
    -- *** use lua-protobuf ***

    -- LuaLogger.es("pb_decode", tablex.dump(msg))
    if not msg then
        LuaLogger.e("pb_decode error")
        return
    end
    if data.uid then
        msg.uid = data.uid
    end
    return msg
end

local passBeforeLoad = {
    ["user.RegisterUserReq"] = true,
    ["user.UserInfoReq"] = true,
    ["user.CanEnterGameReq"] = true,
    ["user.UserListReq"] = true,
    ["user.SelectUserReq"] = true,
    ["user.EnterSceneReq"] = true,
    ["user.BankItemsReq"] = true,
    ["user.ChooseBornReq"] = true,
    ["user.TimeReq"] = true,
    ["user.EnterChapterReq"] = true,
    ["user.ExitChapterReq"] = true,
    ["user.OpenPanelReq"] = true,
    ["user.RecordSuperPropertiesReq"] = true,
}

---@type NetPlayer 这个在使用的时候，会被看成是一个NetPlayer的实例，是一个服务器的角色实例，但是，实际上是UserSim的实例，在auth函数中会被创建
local userSimInstance

--消息分发函数
local function msg_dispatch(sessionId, protoId, msgdata, aid, fd, ip)
    local name = protocols[protoId]
    if not name then
        LuaLogger.e("cannot find protocol index:" .. msgdata.action)
        return
    end

    if userSimInstance then
        local subRes, retProtoName  = userSimInstance:doSub(name, sessionId)
        if subRes ~= nil then -- 
            LuaLogger.ws("subRes", name, subRes)
            return subRes, retProtoName
        end
    end

    LuaLogger.d(string.format("calling to %s", name))
    local module, method = name:match "([^.]*).(.*)"

    local index = ip:find(":", 1, true)
    if index then
        ip = ip:sub(1, index - 1)
    end

    --在这里组织了一个数据结构，用于传递给处理函数
    ---@type RequestData
    local data = {
        payload = protoclone(pb_decode({name = name, payload = msgdata})),
        aid = aid,
        fd = fd,
        ip = ip,
        protoName = name,
        agent = 1,
        player = userSimInstance -- 这个地方将NetPlayer（这是Player对象的一个子类的实例）对象传递给处理函数
    }

    local file = RequireDbg(module)
    local msg, retProtoName
    if userSimInstance then
        if name == "user.LoginGateReq" then
            msg, retProtoName = pb_encode("user.LoginGateResp", { ret = 0 })
        else
            if userSimInstance.isLoaded or passBeforeLoad[name] then
                local dealMethod = file[method]
                if dealMethod then
                    msg, retProtoName = dealMethod(data)
                    -- LuaLogger.ds(name, "processed")
                    if name ~= "user.UserInfoReq" then
                        if not(Standalone)  then
                            userSimInstance:save()
                        end
                    end
                else
                    LuaLogger.e("No dealMethod for %s", name)
                end
            else
                LuaLogger.es("notify error", name)
                userSimInstance:notify({"user.ErrorReason", { ret = ActionFailReason.UserNotExisted }})
            end
        end
    else
        LuaLogger.ds(file, method, data)
        msg, retProtoName = file[method](data)
    end

    --skynet.error("process %s time used %f ms", name, (skynet.time()-begin)*10)
    return msg, retProtoName
end

---------------------------------------------------------------------------------------------------
-- 本地模拟用户，从原来的User更名为UserSim，避免名字的错误理解
-- 用于模拟用户的逻辑
---@class UserSim ：NetPlayer
local UserSim = class("UserSim", require "NetPlayer")

function UserSim:ctor()
    ---@type table
    self.subs = {} -- 订阅待返回response
    ---@type table
    self.respMsgs = {} -- 准备发送的msglist, [key] = queue()
    ---@type table
    self.subSessions = {}
    local subProto = Player.NtfProtos
    for i,v in ipairs(subProto) do
        self.respMsgs[v] = DQueue:new()
        self.subs[v] = DQueue:new()
    end
end

function UserSim:save()
    -- if self.justLoad then
    --     self.justLoad = false
    --     return
    -- end

    if not self.isLoaded then
        return
    end

    local needCalc = true
    if needCalc then
        self:calcProp()
    end
    -- local saveData = {}
    -- for k,v in pairs(Player.SerialiseValues) do
    -- 	saveData[k] = v.toJsonFunc(clone(self[k]))
    -- end

    GameGlobal.UpdateUserInfoByUid(self.uid, self)
end

function UserSim:markDirty(key, firstKey)

end

function UserSim:clearDirty()
end

function UserSim:noMarkDirtyStart(key, firstLey)
end

function UserSim:noMarkDirtyEnd(key, firstLey)
end

--不保存数据执行
--param {function} func
--param {table} noSaveFields
--               {
--                   {key, firstKey},
--                   {key, firstKey},
--                   {key, firstKey},
--               }
--return {boolean} ok
--return {all} err
function UserSim:noSavedbRun(func, noSaveFields)
    if not isfunction(func) or not istable(noSaveFields) then
        LuaLogger.es("noSavedbRun invalid params", tostring(func), tablex.dump(noSaveFields))
        return false
    end

    local ok, result = pcall(func)
    if not ok then
        LuaLogger.es("noSavedbRun failed", result)
    end

    return ok, result
end

function UserSim:updateOneSec()

end

function UserSim:checkClientVersion()
    return true
end

function UserSim:StartCalcOnlineTime()

end

function UserSim:update10Sec()
    local user = require("user")
    local userinfo = {}
    --user.ExperienceRandomMonsterUpdate(self)

    if userinfo and not tablex.empty(userinfo) then
        UserSim:notify({ "user.UserInfoUpdate", { userinfo = userinfo } })
    end
end

local notifies = {}

-- 直接通知，丢失无所谓
---@param proto table
function UserSim:notifyDirect(proto)
    LuaLogger.d("notifyDirect %s %s", proto[1], tablex.dump(proto[2]))
    local notifymsg = pb_encode(proto[1], proto[2])

    table.insert(notifies, { sessionId = 0, id = protocols[proto[1]], buf = notifymsg })
end

function UserSim:notify(proto)
    LuaLogger.d("notify %s %s", proto[1], tablex.dump(proto[2]))
    local notifymsg = pb_encode(proto[1], proto[2])
    -- table.insert(notifies, { sessionId = 0, id = protocols[proto[1]], buf = notifymsg })

    -- pub模式
    local queue = self.subs[proto[1]]
    if queue then
        local sessionId = queue:popFront()
        if sessionId then
            LuaLogger.ds("notify session", sessionId)
            self.subSessions[sessionId] = nil
            table.insert(notifies, { sessionId = sessionId, id = protocols[proto[1]], buf = notifymsg })
        else
            self.respMsgs[proto[1]]:pushBack(notifymsg)
        end
    end
end

-- 返回false或者消息
function UserSim:doSub(name, sessionId)
    local queue = self.respMsgs[name]
    if queue then
        local msg = queue:popFront()
        if msg then
            return msg, name
        end

        if self.subSessions[sessionId] then
            return true
        end

        self.subSessions[sessionId] = true
        self.subs[name]:pushBack(sessionId)
        return false
    end
end

------------------------------------------------------------------------------------------------
-- SrvSim是一个模拟服务器，用于模拟服务器的逻辑
-- 利用UserSim来模拟用户的逻辑
function SrvSim:ctor()
    self.Time1 = 0
    self.Time10 = 0
end

-- 这个函数用于模拟服务器的登录逻辑，userSimInstance是一个服务器的角色实例
function SrvSim:auth(aid)
    userSimInstance = UserSim:new(aid)
    userSimInstance:loadUserList()
    GV.SimUser = userSimInstance
end

function SrvSim:readNotifies()
    local tmp = notifies
    notifies = {}
    return tmp
end

function SrvSim:dealProto(proto)
    self.Time1 = self.Time1 + Time.deltaTime
    if self.Time1 >= 1 then
        if userSimInstance then
            userSimInstance:updateOneSec()
        end
        self.Time1 = self.Time1%1
    end
    self.Time10 = self.Time10 + Time.deltaTime
    if self.Time10 >= 10 then
        if userSimInstance then
            userSimInstance:update10Sec()
        end
        self.Time10 = self.Time10%10
    end
    local msg, retProtoName = msg_dispatch(proto.sessionId, proto.id, proto.buf, userSimInstance and userSimInstance.aid or 9999999, 0, "110")
    if msg then
        return { sessionId = proto.sessionId, id = protocols[retProtoName], buf = msg }
    end

    return nil
end

function SrvSim:save()
    if userSimInstance ~= nil then 
        userSimInstance:save()
    end
end

return SrvSim