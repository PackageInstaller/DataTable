--多角色的玩家类，继承自Player
---@class NetPlayer:Player
local NetPlayer = class("NetPlayer", require "Player")
local GameGlobal = require "GameGlobal"
local CommonLogic = require "CommonLogic"
local Player = require "Player"



-- 用于初始化数据
function NetPlayer:loadUserList()
    if self.userList then
        return
    end

    self.userList = GameGlobal.GetUserListByAid(self.aid)

end

--删除角色
---@param uid integer
---@return boolean
function NetPlayer:delUser(uid)
    -- if not self.userList then
    --     return false
    -- end

    -- self.userList[uid] = nil
    return GameGlobal.DeleteUser(uid, self.aid)
end

--添加角色
---@param new_user Player
function NetPlayer:addToUserList(new_user)
    if not self.userList then
        self.userList = {}
    end

    self.userList[new_user.uid] = new_user
end

--重载数据
function NetPlayer:reloadSomeData()
    LuaLogger.ds("reloadSomeData", self.aid, self.uid)
    if self.uid then
        -- local data = GameGlobal.GetUserInfoByKeys(self.uid, {"toConfirmTrade"}, self.aid)
        -- CommonLogic.CopyProps(data, self)
    end
end

--加载用户信息
---@param uid integer
---@return ActionFailReason 返回结果是否成功，如有错误返回错误码
function NetPlayer:load(uid)
    if self.isLoaded and self.uid == uid then
        GameGlobal.GetUserInfo(uid, nil, self.aid)
        return ActionFailReason.None
    end

    self.isLoaded = false
    self.isDBLoaded = false

    -- 需求加载uid不是自己的，基本是篡改数据来的
    if not self.userList[uid] then
        return ActionFailReason.UserNotThisAccount
    end

    -- 从数据库中获取用户信息
	local info = GameGlobal.GetUserInfo(uid, true, self.aid)
    if not info then
        LuaLogger.ws("No such user", uid)
        return ActionFailReason.UserNotExist
    end
    -- self.user_info = info

    self:setRandomSeed(os.time() + os.clock())

    -- self.userInfo = info
    CommonLogic.CopyProps(info, self, function (key, value)
        local v = Player.SerialiseValues[key]
        return v and v.indb
    end)
    --db数据加载完成
    self.isDBLoaded = true
    self:transformInitialData()

    local isNew = self:newUserInitData()

    if self.loadOver then
        self:loadOver(isNew)
    end

    self:calcProp()
    --db数据和内存全部加载完成
    self.isLoaded = true
    --self:clearDirty() -- load之后会进行一些数据check，还是需要修改保存
    -- self.justLoad = true

    return ActionFailReason.None
end

--加载用户信息
---@param userLoadedParam table
---@param isEnterScene boolean
function NetPlayer:reloadData(userLoadedParam, isEnterScene)
    self:loadUserList()
    local user = require "user"
    user.UserInfoReq({player = self, payload = userLoadedParam}, true)
    if not self.isLoaded then
        return
    end

    if isEnterScene then
        local payload = 
        {
            reEnter = true,
        }
        user.EnterSceneReq({player = self, payload = payload}, isEnterScene)
    end
end

--基于协议来通知客户端，这里面的notify在客户端模拟的情况下是调用的SrvSim中UserSim的notify方法
--在服务端的执行环境中是Role中的notify方法
---@param protos table 协议列表
function NetPlayer:notifyProtos(protos)
    if protos then
        for i,v in ipairs(protos) do
            self:notify(v)
        end
    end
end

function NetPlayer:getUpdateProto(...)
    local userinfo = {}
    local proto = { "user.UserInfoUpdate", { userinfo = userinfo } }

    for i,v in ipairs({...}) do
        if v then
            if isstring(v) then
                if v == "noInfoFlag" then
                    userinfo.noInfoFlag = 1
                else
                    userinfo[v] = self:propToProto(v)
                end
            else
                local key = v[1]
                if v[3] == true then -- 表示本身就是数组结构
                    for i2,v2 in ipairs(v[2]) do
                        InsertProtoData(userinfo, key, v2)
                    end
                else
                    for i2,v2 in ipairs(v) do
                        if i2 ~= 1 then
                            InsertProtoData(userinfo, key, v2)
                        end
                    end
                end
            end
        end
    end

    return proto
end

-- 每个参数为字符串key，或{"key", 单个值}，或{"key", 数组值, true}
function NetPlayer:notifyPropUpdate(...)
    local proto = self:getUpdateProto(...)
    self:notify(proto)
end

return NetPlayer