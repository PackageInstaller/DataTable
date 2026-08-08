local CommonLogic = require "CommonLogic"
local GameGlobal = require "GameGlobal"
local GMServer = require "GMServer"
local Player = require "Player"
local AddictionPrevention = require "AddictionPrevention"
local cjson = require "cjson"
local DataLogMgr = nil
local skynet
local dservice
--require "BattleSimOutput"
if GV.IsServer then
    skynet = require "skynet"
    DataLogMgr = require "DataLogMgr"
    dservice = require "dservice"
end
require "DLuaUtil"
require "CommonType"

local ActionFailReason = ActionFailReason

--所有请求的data结构
---@class RequestData
---@field ip string 客户端的ip地址
---@field agent number 代理信息
---@field protoName string 请求的协议名
---@field fd number socket的文件描述符
---@field aid number 用户的aid
---@field player NetPlayer 在服务器解析请求的时候，会将当前请求的用户信息放入这个字段
---@field payload table 这个是客户端发送过去的请求数据，这个后面会根据user.proto生成的lua文件来进行解析

local handler = {}

--武器数据推送数量限制
local weaponMapLimit = 100
--装备数据推送数量限制
local equipMapLimit = 200
--道具数据推送数量限制
local itemMapLimit = 300
--任务数据推送数量限制
local missionListLimit = 400
--邮件收藏数据推送数量限制
local mailCollectLimit = 100

----------------------------------------------------------------------------------------------
--测试代码，先不用管
---@param data RequestData
function handler.Test1Req(data)
    local payload = data.payload
    LuaLogger.ds(tablex.dump(payload))
    return pb_encode("user.Test1Resp", {ret = ActionFailReason.None})
end

---@param data RequestData
function handler.Test2Req(data)
    local player = data.player
    local payload = data.payload
    LuaLogger.ds("os.time()", os.time())
    LuaLogger.ds("os.date()", os.date(), type(os.date()))
    LuaLogger.ds("payload.num2", payload.num2)
    LuaLogger.ds(tablex.dump(payload))
    return pb_encode("user.Test2Resp", {ret = 9})
end

---@param data RequestData
function handler.Test3Req(data)
    LuaLogger.ds("data.payload.testb", data.payload.testb)
    return pb_encode("user.Test3Resp", {ret = ActionFailReason.None})
end

----------------------------------------------------------------------------------------------
--用户注册角色，在游戏中存在一个角色列表，一个账号可以有多个角色的概念，但是，在当前游戏中是不存在这个逻辑的，只是从结构上保留了这个结构
---@param data RequestData
function handler.RegisterUserReq(data)
    local player = data.player
    ---@type RegisterUserReq
    local payload = data.payload
    local aid = player.aid
    local ip = data.ip

    --首先加载角色列表
    player:loadUserList()

    --检查当前账号在当前区服的角色数量是否达到上限，GF.getCreateCharLimit()，兼容本地模式用1代替
    local maxUserNumPerZone = 1
    if GV.IsServer then
        maxUserNumPerZone = GF.getMaxUserNumPerZone()
    end
    if player.userList and tablex.size(player.userList) >= maxUserNumPerZone then
        return pb_encode("user.RegisterUserResp", {ret = ActionFailReason.CreateUserExceedMax})
    end

    local name = payload.name
    --去除两端空白
    name = name:trim()
    payload.name = name

    local ok, reason = player:CheckUserName(name, GE.NameChangeType.RegisterName, ip)
    if not ok then
        return pb_encode("user.RegisterUserResp", {ret = reason})
    end

    -- 没有这个需求
    -- --检查是否已经有这个名字的角色
    -- local ok, reason = GameGlobal.CanCreateChar(player.aid, name)
    -- if not ok then
    --     return pb_encode("user.RegisterUserResp", {ret = reason})
    -- end

    --创建一个新的角色
    local new_user = player:createUserStructure(aid, ip, payload)
    -- 根据玩家注册的账号，确定是否使用预留的玩家id(参考配置ReservedAccountTable)
    new_user.reserved_account_md5 = player.loginAccInfo and player.loginAccInfo.reserved_account_md5 or nil

    new_user = GameGlobal.CreateUser(new_user)
    if GV.IsServer then
        skynet.fork(function()
            GameGlobal.CreateUser_Account({uid = new_user.uid, aid = new_user.aid, stamp = DLuaUtil.GetGreenwichTime()})
        end)
    end

    --如果创建失败，则返回错误给客户端
    if new_user == nil then
        LuaLogger.e("%s:%s aid=%d", data.protoName, "create and insert user to db failed", aid)
        return pb_encode("user.RegisterUserResp", {ret = ActionFailReason.CreateUserFailed})
    else
        --创建成功，则将其加入到userList中
        player:addToUserList(new_user)
        --日志
        if DataLogMgr then
            DataLogMgr.LogUserRegister(
                {
                    ip = data.ip,
                    uid = new_user.uid,
                    distinct_id = payload.distinct_id
                }, player)
            DataLogMgr.LogAccountLoginState({
                state = GE.AccountLoginState.regUserSuc,
                channel = player.loginChannel,
                zone = GV.IsServer and tonumber(skynet.getenv("zone"))
            }, player)
        end
    end

    --通知服务器，有新的角色创建了，客户端无实现
    if GV.IsServer then
        skynet.fork(function()
            GameGlobal.TellCreateChar(aid)
        end)
    end

    return pb_encode("user.RegisterUserResp", {ret = ActionFailReason.None})
end

--获取角色列表
---@param data RequestData
function handler.UserListReq(data)
    local player = data.player
    ---@type UserListReq
    local payload = data.payload

    --首先加载角色列表
    player:loadUserList()

    --LuaLogger.ds("user.userList", tablex.dump(player.userList))

    --将角色列表转换成proto格式
    local user_infos = {}
    if player.userList then
        for k, v in pairs(player.userList) do
            table.insert(
                user_infos,
                Player.convertUserInfoToProto(
                    v,
                    function(key)
                        local value = Player.SerialiseValues[key]
                        return value and value.roleList
                    end
                )
            )
        end
    end

    if DataLogMgr then
        DataLogMgr.LogAccountLoginState({
            state = GE.AccountLoginState.userListSuc,
            channel = player.loginChannel,
            zone = GV.IsServer and tonumber(skynet.getenv("zone"))
        }, player)
    end

    return pb_encode("user.UserListResp", {ret = ActionFailReason.None, user_infos = user_infos})
end

--玩家进入到游戏后，让后端来进行版本的比对，防沉迷等信息
---@param data RequestData
function handler.CanEnterGameReq(data)
    local player = data.player
    ---@type CanEnterGameReq
    local payload = data.payload

    --版本号空检查
    local versionCode = payload.versionCode
    local versionBattle = "0"--to do... 等前端增加战斗字段后再打开 payload.versionBattle
    if stringx.isNilOrEmpty(versionCode) or stringx.isNilOrEmpty(versionBattle) then
        return pb_encode("user.CanEnterGameResp", {ret = ActionFailReason.LackParameter})
    end

    local enterCode = GE.EnterGameCode.CanEnter

    --防沉迷检查
    --if AddictionPrevention.CanEnterGameTimePeriod(player.yearsOld) then
    --    if player.dayLoginTime and player.dayLoginTime >= AddictionPrevention.MaxSecondsToday(player.yearsOld) then
    --        enterCode = GE.EnterGameCode.CantEnterOvertime18
    --    end
    --else
    --    enterCode = GE.EnterGameCode.CantEnterBetween228
    --end

    if GV.IsServer then
        --先检测最小年龄限制登录
        if not AddictionPrevention.CanEnterUnderAgeLimit(player.yearsOld) then
            return GE.EnterGameCode.CantEnterUnder16
        end

        if not AddictionPrevention.CanEnterGameNewPolicy1(player.yearsOld) then
            enterCode = GE.EnterGameCode.CanOnlyEnterByNewPolicy1
        end
    end

    --版本号检查，如果版本号不一致，则返回需要升级的错误代码
    if enterCode == GE.EnterGameCode.CanEnter then
        --这个地方在客户端的模拟环境下，执行的是SrvSim.lua中的代码，在服务器上会执行真正的服务器代码，应该是Role.lua中的代码
        if not player:checkClientVersion(versionCode, versionBattle) then
            enterCode = GE.EnterGameCode.GameVersionNeedUpdate
        end
    end

    return pb_encode("user.CanEnterGameResp", {enterCode = enterCode})
end

--数数日志公共事件属性记录
---@param data RequestData
function handler.RecordSuperPropertiesReq(data)
    local player = data.player
    ---@type RecordSuperPropertiesReq
    local payload = data.payload

    --user增加临时属性shushuPresetProperties
    player.shushuPresetProperties = payload.info

    return pb_encode("user.RecordSuperPropertiesResp", {ret = ActionFailReason.None})
end

-- 获取角色信息
---@param data RequestData
function handler.UserInfoReq(data, reloaded)
    local player = data.player
    ---@type UserInfoReq
    local payload = data.payload

    --检查uid的合法性
    local uid = payload.uid
    -- if not uid or uid <= 0 then
    --     LuaLogger.es("ActionFailReason.UserNotExisted2", uid)
    --     return pb_encode("user.UserInfoResp", {ret = ActionFailReason.UserNotExisted})
    -- end

    --加载角色信息
    -- LuaLogger.ds("user.toConfirmTrade1", tablex.dump(player.toConfirmTrade))
    local ret = player:load(uid)
    if ret ~= ActionFailReason.None then
        if ret == ActionFailReason.UserNotThisAccount then
            if DataLogMgr then
                DataLogMgr.LogEvent(
                GE.LogEventType.Warn,
                {
                    warn_id = GE.WarnInfoType.LoginOtherUser,
                    info = cjson.encode({aid = player.aid, uid = uid})
                },
                player
            )
            end
        end

        LuaLogger.ws("ActionFailReason.UserNotExisted3 user not load", uid, player.aid)
        return pb_encode("user.UserInfoResp", {ret = ret or ActionFailReason.UserNotExisted})
    end

    --将角色信息转换成proto格式
    if player.isLoaded then
        player.servertime = DLuaUtil.GetGreenwichTime()
        player.lastlogintime = DLuaUtil.GetGreenwichTime()
        player.lastonlinetime = DLuaUtil.GetGreenwichTime()
        player.zoneId = GV.IsServer and tonumber(skynet.getenv("zone")) or 0
        
        player:setChannel(payload.channel, payload.deviceType, payload.deviceSubType)
        if reloaded then
            return pb_encode("user.UserInfoResp", {ret = ActionFailReason.None})
        end
        
        ---@type UserInfo
        local user_info = player:convertUserInfoToProto()
        local over = true
        user_info.serverChannel = GV.IsServer and skynet.getenv("channel_name") or ""

        if GV.IsServer then
			--日志
			if DataLogMgr then
				DataLogMgr.LogGameLogin({
                    action = GE.GameConnectType.EnterGame,
                    ip = data.ip,
                    platid = player.platid,
                }, player)

				DataLogMgr.LogUser(GE.GameConnectType.EnterGame, data)

                DataLogMgr.LogAccountLoginState({
                    state = GE.AccountLoginState.getUserInfoSuc,
                    channel = player.channel,
                    zone = player.zoneId,
                }, player)
			end

            --前端开始接入主动请求时，再删除不推送的数据
            --登录时不推送的数据
            for _, v in pairs(GE.ToObsoletePushData) do
                user_info[v] = nil
            end

            --纯后端逻辑，前端不需要推送的数据
            if user_info.triggerEventMap then
                user_info.triggerEventMap = nil
            end

            -- 前端进入主界面时，就会主动请求任务数据，这里就先不推送了
            if user_info.missionList then
                user_info.missionList = nil
            end

            -- 前端进入主界面时，就会主动请求通行证数据，这里就先不推送了
            if user_info.passDataMap then
                user_info.passDataMap = nil
            end

            -- 前端进入主界面时，就会主动请求任务数据，这里就先不推送了
			-- --任务信息
			-- if user_info.missionList then
            --     --分批推送
            --     skynet.fork(function()
            --         while tablex.size(user_info.missionList) > 0 do
            --             local missionList = {}
            --             for k, v in pairs(user_info.missionList) do
            --                 missionList[k] = v
            --                 user_info.missionList[k] = nil
            --                 if tablex.size(missionList) >= missionListLimit then
            --                     break
            --                 end
            --             end
            --             player:notifyDirect({"user.UserInfoUpdate", {userinfo = {missionList = missionList}}})
            --         end
            --     end)
            --     user_info.missionList = nil
            -- end

            if user_info.weaponMap then
                local weaponMapTemp = user_info.weaponMap
                user_info.weaponMap = nil
                --分批推送
                skynet.fork(function()
                    while tablex.size(weaponMapTemp) > 0 do
                        local weaponMap = {}
                        for k, v in pairs(weaponMapTemp) do
                            weaponMap[k] = v
                            weaponMapTemp[k] = nil
                            if tablex.size(weaponMap) >= weaponMapLimit then
                                break
                            end
                        end
                        player:notifyDirect({"user.UserInfoUpdate", {userinfo = {weaponMap = weaponMap}}})
                    end
                end)
            end

            if user_info.equipMap then
                local equipMapTemp = user_info.equipMap
                user_info.equipMap = nil
                --分批推送
                skynet.fork(function()
                    while tablex.size(equipMapTemp) > 0 do
                        local equipMap = {}
                        for k, v in pairs(equipMapTemp) do
                            equipMap[k] = v
                            equipMapTemp[k] = nil
                            if tablex.size(equipMap) >= equipMapLimit then
                                break
                            end
                        end
                        player:notifyDirect({"user.UserInfoUpdate", {userinfo = {equipMap = equipMap}}})
                    end
                end)
                
            end

            --英雄数据、皮肤数据、好感度，数据一起推送
            if user_info.heroList or user_info.skinList or user_info.affectionData then
                local heroList = user_info.heroList
                local skinList = user_info.skinList
                local delegateEventList = user_info.affectionData.delegateEventList
                skynet.fork(function()
                    player:notifyDirect({"user.UserInfoUpdate", {userinfo = {
                        heroList = heroList, 
                        skinList = skinList,
                        affectionData = {delegateEventList = delegateEventList}
                    }}})
                end)
                user_info.heroList = nil
                user_info.skinList = nil
                user_info.affectionData = nil
            end

            --普通商店、氪金商店、周期卡数据，数据一起推送
            if user_info.generalShopData or user_info.premiumShopMap or user_info.cycleCardDatas then
                local generalShopData = user_info.generalShopData
                local premiumShopMap = user_info.premiumShopMap
                local cycleCardDatas = user_info.cycleCardDatas
                skynet.fork(function()
                    player:notifyDirect({"user.UserInfoUpdate", {userinfo = {
                        generalShopData = generalShopData, 
                        premiumShopMap = premiumShopMap,
                        cycleCardDatas = cycleCardDatas
                    }}})
                end)
                user_info.generalShopData = nil
                user_info.premiumShopMap = nil
                user_info.cycleCardDatas = nil
            end

            --家园数据、天气数据、情报数据，数据一起推送
            if user_info.homeland or user_info.weatherForecastData or user_info.combatIntelligenctInfo then
                local homeland = user_info.homeland
                local weatherForecastData = user_info.weatherForecastData
                local combatIntelligenctInfo = user_info.combatIntelligenctInfo
                skynet.fork(function()
                    player:notifyDirect({"user.UserInfoUpdate", {userinfo = {
                        homeland = homeland, 
                        weatherForecastData = weatherForecastData,
                        combatIntelligenctInfo = combatIntelligenctInfo
                    }}})
                end)
                user_info.homeland = nil
                user_info.weatherForecastData = nil
                user_info.combatIntelligenctInfo = nil
            end

            --科技树数据、周期活动、简易通行证数据
            if user_info.technologyTree or user_info.regularActivityData or user_info.miniPassMap then
                local technologyTree = user_info.technologyTree
                local regularActivityData = user_info.regularActivityData
                local miniPassMap = user_info.miniPassMap
                skynet.fork(function()
                    player:notifyDirect({"user.UserInfoUpdate", {userinfo = {
                        technologyTree = technologyTree,
                        regularActivityData = regularActivityData,
                        miniPassMap = miniPassMap
                    }}})
                end)
                user_info.technologyTree = nil
                user_info.regularActivityData = nil
                user_info.miniPassMap = nil
            end

            --关卡数据 同步推送
            if user_info.pveLevelMap then
                local pveLevelMap = user_info.pveLevelMap
                player:notifyDirect({"user.UserInfoUpdate", {userinfo = {pveLevelMap = pveLevelMap}}})
                user_info.pveLevelMap = nil
            end

            if user_info.itemMap then
                local itemMapTemp = user_info.itemMap
                user_info.itemMap = nil
                --分批推送
                skynet.fork(function()
                    while tablex.size(itemMapTemp) > 0 do
                        local itemMap = {}
                        for k, v in pairs(itemMapTemp) do
                            itemMap[k] = v
                            itemMapTemp[k] = nil
                            if tablex.size(itemMap) >= itemMapLimit then
                                break
                            end
                        end
                        player:notifyDirect({"user.UserInfoUpdate", {userinfo = {itemMap = itemMap}}})
                    end
                end)
            end

            --最后--
            player:notifyGate({userLoaded = payload})
        else
            local dataPack = {
                {},
                {},
                {},
                "__allData__"
            }

            if not payload.part then
                for index, v in ipairs(dataPack) do
                    player["__reqData_Index" .. index] = 0
                end
            end

			local currDataIndex
			for k = 1, tablex.size(dataPack) do
			    if player["__reqData_Index" .. k] then
			        currDataIndex = k
			        break
			    end
			end

			LuaLogger.ds("##########################currDataIndex???", currDataIndex)

			if currDataIndex == tablex.size(dataPack) then
			    for n = 1, currDataIndex - 1 do
			        for _, v in pairs(dataPack[n]) do
			            user_info[v.key] = nil
			        end
			    end
			    player["__reqData_Index" .. currDataIndex] = nil
			else
				over = false
			    local keys = dataPack[currDataIndex]
			    local data = {}
			    if keys and keys[1] and keys[1].maxNum then
			        local key = keys[1].key
			        local maxNum = keys[1].maxNum
			        data[key] = {}
			        local from = player["__reqData_Index" .. currDataIndex] + 1
			        local to = from + maxNum - 1
			        for i = from, to do
			            LuaLogger.ds(key, i, tablex.dump(user_info))
			            if user_info[key][i] then
			                table.insert(data[key], user_info[key][i])
			            end
			        end
			        player["__reqData_Index" .. currDataIndex] = to
			        if user_info[key][to + 1] == nil then
			            player["__reqData_Index" .. currDataIndex] = nil
			        end
			    else
			        if keys then
			            for _, v in pairs(keys) do
			                local key = v.key
			                data[key] = user_info[key]
			            end
			        end
			        player["__reqData_Index" .. currDataIndex] = nil
			    end
			    user_info = data
			end
        end

        return pb_encode("user.UserInfoResp", {ret = ActionFailReason.None, user_info = user_info, over = over})
    else
        --LuaLogger.e("aid:%d uid:%u not found", player.aid, uid)
        return pb_encode("user.UserInfoResp", {ret = ActionFailReason.NotLoadUserInfo, over = true})
    end
end

--请求获得某功能数据
---@param data RequestData
function handler.GetFunctionDataReq(data)
    local player = data.player
    ---@type GetFunctionDataReq
    local payload = data.payload

    local userinfo = {}
    local ret = player:getFunctionData(payload.functions, userinfo)
    if ret ~= ActionFailReason.None then
        return pb_encode("user.GetFunctionDataResp", {ret = ret})
    end

    --------------------分批推送数据--------------------
    if GV.IsServer then
        --任务信息
        if userinfo.missionList then
            --分批推送
            skynet.fork(function()
                while tablex.size(userinfo.missionList) > 0 do
                    local missionList = {}
                    for k, v in pairs(userinfo.missionList) do
                        missionList[k] = v
                        userinfo.missionList[k] = nil
                        if tablex.size(missionList) >= missionListLimit then
                            break
                        end
                    end
                    player:notifyDirect({"user.UserInfoUpdate", {userinfo = {missionList = missionList}}})
                end
                userinfo.missionList = nil
            end)
        end

        if userinfo.weaponMap then
            --分批推送
            skynet.fork(function()
                while tablex.size(userinfo.weaponMap) > 0 do
                    local weaponMap = {}
                    for k, v in pairs(userinfo.weaponMap) do
                        weaponMap[k] = v
                        userinfo.weaponMap[k] = nil
                        if tablex.size(weaponMap) >= weaponMapLimit then
                            break
                        end
                    end
                    player:notifyDirect({"user.UserInfoUpdate", {userinfo = {weaponMap = weaponMap}}})
                end
                userinfo.weaponMap = nil
            end)
        end

        if userinfo.equipMap then
            --分批推送
            skynet.fork(function()
                while tablex.size(userinfo.equipMap) > 0 do
                    local equipMap = {}
                    for k, v in pairs(userinfo.equipMap) do
                        equipMap[k] = v
                        userinfo.equipMap[k] = nil
                        if tablex.size(equipMap) >= equipMapLimit then
                            break
                        end
                    end
                    player:notifyDirect({"user.UserInfoUpdate", {userinfo = {equipMap = equipMap}}})
                end
                userinfo.equipMap = nil
            end)
        end

        if userinfo.itemMap then
            --分批推送
            skynet.fork(function()
                while tablex.size(userinfo.itemMap) > 0 do
                    local itemMap = {}
                    for k, v in pairs(userinfo.itemMap) do
                        itemMap[k] = v
                        userinfo.itemMap[k] = nil
                        if tablex.size(itemMap) >= itemMapLimit then
                            break
                        end
                    end
                    player:notifyDirect({"user.UserInfoUpdate", {userinfo = {itemMap = itemMap}}})
                end
                userinfo.itemMap = nil
            end)
        end
    end

    --------------------------------------------------

    --剩余的一起推送
    if not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.GetFunctionDataResp", {ret = ret, functions = payload.functions})
end

--角色删除，这个功能在游戏中是没有的
---@param data RequestData
function handler.CharDelReq(data)
    local player = data.player
    ---@type CharDelReq
    local payload = data.payload

    --检查uid是否存在？
    local uid = player.uid
    -- local delUser
    -- for k, v in pairs(player.userList) do
    --     if v.uid == payload.uid then
    --         uid = v.uid
    --         delUser = v
    --         break
    --     end
    -- end

    --如果不存在直接返回错误给到客户端
    if not uid then
        return pb_encode("user.CharDelResp", {ret = ActionFailReason.CharNotExist})
    end

    --判断是否可以删除？
    local ok, reason = GameGlobal.CanDelChar(player.aid)
    if not ok then
        return pb_encode("user.CharDelResp", {ret = reason})
    end

    if dservice then
        dservice.pcallCluster(GF.GetLoginNode(), ".login_server", "kick_account", player.aid)
    end

    --删除角色
    local ok = player:delUser(uid)
    if ok then
        if DataLogMgr then
            DataLogMgr.LogEvent(
                GE.LogEventType.DeleteChar,
                {
                    uid = uid,
                    aid = player.aid,
                    name = player.name
                },
                player
            )
        end

        GameGlobal.TellDelChar(player.aid)
        if GV.IsServer then
            GameGlobal.DeleteUser_Account({uid = uid, aid = player.aid})
        end

        --返回成功
        return pb_encode("user.CharDelResp", {ret = ActionFailReason.None})
    else
        --删除失败，返回错误给客户端
        return pb_encode("user.CharDelResp", {ret = ActionFailReason.CharDelFailed})
    end
end

--用户进入场景的请求
---@param data RequestData
function handler.EnterSceneReq(data, isEntered)
    ---@type EnterSceneReq
    local payload = data.payload
    local player = data.player

    --检查是否已经加载完成
    if not player.isLoaded then
        return pb_encode("user.EnterSceneResp", {ret = ActionFailReason.NotLoadUserInfo})
    end

    --判断客户端版本号
    --这个地方在客户端的模拟环境下，执行的是SrvSim.lua中的代码，在服务器上会执行真正的服务器代码，应该是Role.lua中的代码
    if not player:checkClientVersion() then
        player:notifyDirect({"user.GameVersionNeedUpdateNtf", {}})
        return pb_encode("user.EnterSceneResp", {ret = ActionFailReason.NotLoadUserInfo})
    end

    LuaLogger.d("player:%d %s enterScene:%s isEntered:%s", player.uid, player.name, tostring(payload.reEnter), tostring(isEntered))

    if not isEntered then
        local enterData =
            CommonLogic.CopyPropsByKey(player, {}, {"uid", "aid", "agent", "job", "head", "name", "gmLevel", "borntime", "gameNode", "channel"})
        --进入场景的时候，需要通知服务器，这个角色已经进入了游戏
        local enterOk = GameGlobal.EnterPlayer(enterData)
        if GV.IsServer and not enterOk then
            LuaLogger.ds("EnterSceneReq EnterPlayer failed", player.uid, player.aid)
            return pb_encode("user.EnterSceneResp", {ret = ActionFailReason.NotLoadUserInfo})
        end
    end

    --记录已经进入场景
    player.isEnterScene = true
    --进入场景后，userList会被清空
    player.userList = nil
    --这个地方在客户端的模拟环境下，执行的是SrvSim.lua中的代码，在服务器上会执行真正的服务器代码，应该是Role.lua中的代码
    player:StartCalcOnlineTime()

    if GV.IsServer then
        player:pushWaitPushMsgs()
    end

    if DataLogMgr then
        DataLogMgr.LogAccountLoginState({
            state = GE.AccountLoginState.enterSceneSuc,
            channel = player.channel,
            zone = player.zoneId,
        }, player)
    end

    if isEntered then
        return pb_encode("user.EnterSceneResp", {ret = ActionFailReason.None})
    end

    if GV.IsServer then
        player:loginCheckRedeemCode()
        GameGlobal.LoginUser_Account({uid = player.uid, aid = player.aid, stamp = DLuaUtil.GetGreenwichTime()})
        player:notifyGate({isEnterScene = true})
        GameGlobal.PayCheckException(player.uid, {user_id = player.uid})
    end
    -- --通知客户端，用户信息更新
    -- if userinfo and not tablex.empty(userinfo) then
    --     player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    -- end


    --返回给客户端，进入场景成功
    return pb_encode("user.EnterSceneResp", {ret = ActionFailReason.None})
end

--请求客服链接
---@param data RequestData
function handler.GetSupportLinkReq(data)
    local player = data.player

    local ret, link = GameGlobal.GetSupportLink({
        uid = player.uid,
        aid = player.aid,
        name = player.name,
        channel = player.channel,
        zone = player.zoneId,
    })

    return pb_encode("user.GetSupportLinkResp", {ret = ret, link = link})
end

--请求服务器时间戳
---@param data RequestData
function handler.TimeReq(data)
    ---@type TimeReq
    local payload = data.payload
    local player = data.player

    local clientSec = payload.sec
    local serversec = DLuaUtil.GetGreenwichTime()
    local servermsec = serversec * 1000
    local timeZone = DLuaUtil.GetTimeZone()

    --!!!!!注意!!!!!
    if not GV.IsServer then
        --逻辑请放入此方法内，不在此方法内的逻辑可能无法正常运行在服务器上
        player:runOnce1Sec()
        player:runOnce10Sec()
        player:runOnce60Sec()

        player.lastonlinetime = serversec
        local userinfo = {}
        userinfo.lastonlinetime = serversec
        -- userinfo.regularActivityData = player.regularActivityData
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.TimeResp", {ret = ActionFailReason.None, sec = serversec, msec = servermsec, timeZone = timeZone})
end

--打开某个窗口，这是用来做日志处理的，后面会通过数数发送到数数服务器
---@param data RequestData
function handler.OpenPanelReq(data)
    local payload = data.payload
    local player = data.player

    if DataLogMgr then
        --记录打开的界面
        DataLogMgr.LogPanelUse(
            {
                panelName = payload.panelName,
                source = payload.source,
            }, player)
    end

    return pb_encode("user.OpenPanelResp", {ret = ActionFailReason.None})
end

---进出关卡
---@param data RequestData
function handler.BattleEnterLevelReq(data)
    ---@type BattleEnterLevelReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret = player:BattleEnterLevel(payload.levelId)
    --通知客户端，用户信息更新
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.BattleEnterLevelResp", {ret = ret})
end



--请求开始战斗
---@param data RequestData
function handler.BattleStartReq(data)
    ---@type BattleStartReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret, battleStartInfo = player:startBattle(payload.level, payload.heroCidList, payload.enterMeans, userinfo)

    --通知客户端，用户信息更新
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.BattleStartResp", {ret = ret, battleStartInfo = battleStartInfo})
end

--请求战斗结果
---@param data RequestData
function handler.BattleResultReq(data)
    ---@type BattleResultReq
    local payload = data.payload
    local player = data.player
    ---@type UserInfo
    local userinfo = {}

    local result = player:battleResult(payload.orderReport, userinfo, payload.battleLogData, payload.simpleVerifyData)

    --如果数据有更新，则通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.BattleResultResp", result)
end

--请求生成自动战斗战报
---@param data RequestData
function handler.GenerateAutoBattleReportReq(data)
    ---@type GenerateAutoBattleReportReq
    local payload = data.payload
    local player = data.player

    local ret, orderReport, simpleVerifyData, battleStartInfo = player:generateAutoBattleReport(payload.levelCid, payload.heroCidList)

    return pb_encode("user.GenerateAutoBattleReportResp", {ret = ret, orderReport = orderReport, battleStartInfo = battleStartInfo, simpleVerifyData = simpleVerifyData})
end

--请求验证战斗战报
---@param data RequestData
function handler.VerifyBattleReportReq(data)
    ---@type VerifyBattleReportReq
    local payload = data.payload
    local player = data.player

    local time_before = skynet.now()
    local ret = player:verifyBattleReport(payload.orderReport, payload.simpleVerifyData, payload.battleStartInfo)
    local time_after = skynet.now()
    --写文件
    local file = io.open("battle_report_verify_time.txt", "a+")
    if file then
        file:write(string.format("uid:%d time:%dms\n", player.uid, (time_after - time_before) * 10))
        file:close()
    end

    return pb_encode("user.VerifyBattleReportResp", {ret = ret})
end

--购买体力
---@param data RequestData
function handler.BuyNormalTicketReq(data)
    local player = data.player
    ---@type BuyNormalTicketReq
    local payload = data.payload
    local userinfo = {}

    --购买体力
    local ret = player:buyNormalTicket(payload.mode, payload.id, payload.num, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.BuyNormalTicketResp", {ret = ret})
end

--使用体力-测试代码
---@param data RequestData
function handler.UseNormalTicketReq(data)
    ---@type UseNormalTicketReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --使用体力
    if player:costNormalTicket(payload.num, userinfo, GE.EventItemType.Test, 0) then
        --test code
        player:addUserExp(500, userinfo)

        --通知客户端，用户信息更新
        if userinfo and not tablex.empty(userinfo) then
            player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
        end

        --返回给客户端，使用体力成功
        return pb_encode("user.UseNormalTicketResp", {ret = ActionFailReason.None})
    else
        --返回给客户端，使用体力失败
        return pb_encode("user.UseNormalTicketResp", {ret = ActionFailReason.TicketNoEnough})
    end
end

--请求同步体力
---@param data RequestData
function handler.RecoverNormalTicketReq(data)
    local player = data.player
    local userinfo = {}

    --恢复体力,前端倒计时出现异常时,需要调用此接口，清明测试未出现此问题，但是需要保留此接口，防止后续出现此问题
    player:recoverNormalTicket(userinfo)

    --通知客户端，用户信息更新
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.RecoverNormalTicketResp", {ret = ActionFailReason.None})
end

--获得新手引导的ID
--根据组id设置引导id
---@param data RequestData
function handler.ChangeGuideIDReq(data)
    ---@type ChangeGuideIDReq
    local payload = data.payload
    local player = data.player

    --设置新手引导的id
    local ret, guideInfoMap = player:changeGuideIdByGroupId(payload.guideType, payload.guideId)

    return pb_encode("user.ChangeGuideIDResp", {ret = ret, guideInfoMap = guideInfoMap})
end

--获取邮件列表
---@param data RequestData
function handler.MailListReq(data)
    local player = data.player

    local ret, mailList, stamp = player:getMailList()
    if ret ~= ActionFailReason.None then
        return pb_encode("user.MailListResp", {ret = ret})
    end

    --返回信息
    return pb_encode("user.MailListResp", {ret = ret, mailList = mailList, stamp = stamp})
end

--邮件操作
---@param data RequestData
function handler.MailActionReq(data)
    ---@type MailActionReq
    local payload = data.payload
    local player = data.player

    local userinfo = {}
    local reason, rewards = player:mailAction(payload.action, payload.id, userinfo)

    --通知客户端，用户信息更新
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.MailActionResp", {ret = reason, rewards = rewards})
end

--收藏邮件，此功能邮件数据隔离
---@param data RequestData
function handler.MailCollectReq(data)
    ---@type MailCollectReq
    local payload = data.payload
    local player = data.player

    local userinfo = {}
    local ret = player:mailCollect1(payload.id, userinfo)

    --通知客户端，用户信息更新
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.MailCollectResp", {ret = ret})
end

--升级英雄
---@param data RequestData
function handler.HeroLevelUpReq(data)
    ---@type HeroLevelUpReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --升级英雄
    local reason = player:heroLevelUp(payload.id, payload.upLevel, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.HeroLevelUpResp", {ret = reason})
end

--英雄升星
---@param data RequestData
function handler.HeroStarUpReq(data)
    ---@type HeroStarUpReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --升星
    local ret, rewardList = player:heroStarUp(payload.id, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.HeroStarUpResp", {ret = ret, rewardList = rewardList})
end

--请求领取英雄星级奖励
---@param data RequestData
function handler.GetHeroStarRewardReq(data)
    ---@type GetHeroStarRewardReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --领取英雄星级奖励
    local ret, rewardList = player:getHeroStarReward(payload.id, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.GetHeroStarRewardResp", {ret = ret, rewardList = rewardList})
end


--改变阵容列表
---@param data RequestData
function handler.ChangeFormationListReq(data)
    ---@type ChangeFormationListReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --改变阵容列表
    local ret = player:changeFormationList(payload.id, payload.formationList, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.ChangeFormationListResp", {ret = ret})
end

--家园建筑升级
---@param data RequestData
function handler.HomeLvUpReq(data)
    ---@type HomeLvUpReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --家园建筑升级
    local ret = player:homeBuildingLvUp(payload.constructionId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.HomeLvUpResp", {ret = ret})
end

--装备升级
---@param data RequestData
function handler.AddEquipExpReq(data)
    ---@type AddEquipExpReq
    local payload = data.payload
    ---@type Player
    local player = data.player
    local userinfo = {}

    --装备升级
    local ret = player:addEquipExperience(payload.id, payload.useList, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.AddEquipExpResp", {ret = ret})
end

--装备升星(突破)
---@param data RequestData
function handler.AddEquipStarReq(data)
    ---@type AddEquipStarReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --装备升星
    local ret = player:addEquipStar(payload.id, payload.useIdList, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.AddEquipStarResp", {ret = ret})
end

--装备分解
---@param data RequestData
function handler.DecomposeEquipReq(data)
    ---@type DecomposeEquipReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --装备分解
    local ret, rewardList = player:decomposePlayerEquip(payload.idList, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.DecomposeEquipResp", {ret = ret, rewardList = rewardList})
end

--装备穿戴
---@param data RequestData
function handler.SetCharEquipReq(data)
    ---@type SetCharEquipReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --装备穿戴
    local ret = player:setCharEquip(payload.charId, payload.partId, payload.equipId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.SetCharEquipResp", {ret = ret})
end

--装备卸下
---@param data RequestData
function handler.RemoveCharEquipReq(data)
    ---@type RemoveCharEquipReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --装备卸下
    local ret = player:removeCharEquip(payload.equipId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.RemoveCharEquipResp", {ret = ret})
end

--更改装备锁定状态
---@param data RequestData
function handler.ChangeEquipLockStateReq(data)
    ---@type ChangeEquipLockStateReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --更改装备锁定状态
    local ret = player:changeEquipLockState(payload.equipId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.ChangeEquipLockStateResp", {ret = ret})
end

--请求解锁天赋树节点
---@param data RequestData
function handler.TalentTreeUnLockPointReq(data)
    ---@type TalentTreeUnLockPointReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret = player:talentTreeUnLockPoint(payload.heroId, payload.talentID, userinfo)

    --通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.TalentTreeUnLockPointResp", {ret = ret})
end

--请求解锁天赋树阶段
---@param data RequestData
function handler.TalentTreeStageUnlockReq(data)
    ---@type TalentTreeStageUnlockReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret = player:addTalentTreeStageData(payload.heroId, payload.stageID, userinfo)

    --通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.TalentTreeStageUnlockResp", {ret = ret})
end

--请求解锁科技树阶段
---@param data RequestData
function handler.TechnologyTreeUnlockReq(data)
    ---@type TechnologyTreeUnlockReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret = player:lightTechTreeNode(payload.groupId, userinfo)

    --通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.TechnologyTreeUnlockResp", {ret = ret})
end

--请求跑片开始
---@param data RequestData
function handler.GenRoleFragStartReq(data)
    ---@type GenRoleFragStartReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret, list = player:genRoleFrag(payload.roleIdList, userinfo)

    --通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.GenRoleFragStartResp", {ret = ret, list = list})
end

--请求签到奖励
---@param data RequestData
function handler.GetSignRewardReq(data)
    ---@type GetSignRewardReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret, list = player:getSignReward(payload.signId, payload.signIndex, userinfo)

    --通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.GetSignRewardResp", {ret = ret, list = list})
end


--派遣开始请求
function handler.DispatchStartReq(data)
    ---@type DispatchStartReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret = player:startDispatch(payload.dispatchId, payload.lineId, payload.roleIdList, userinfo)

    --通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.DispatchStartResp", {ret = ret})
end

--派遣结束请求
function handler.DispatchEndReq(data)
    ---@type DispatchEndReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}
    local ret, rewardList = player:settleDispatch(payload.dispatchIdList, userinfo)

    --通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.DispatchEndResp", {ret = ret, rewardList = rewardList})
end

--派遣章节奖励领取
function handler.DispatchChapterRewardReq(data)
    ---@type DispatchChapterRewardReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret, rewardList = player:receiveDispatchChapterReward(payload.chapterId, userinfo)

    --通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.DispatchChapterRewardResp", {ret = ret, rewardList = rewardList})
end


--前端随机的散步英雄同步
---@param data RequestData
function handler.SetHomeShowHeroReq(data)
    ---@type SetHomeShowHeroReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret = player:rolePreRoom(payload.heroIdList, payload.constructIdList, userinfo)

    --通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notifyDirect({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    --返回成功
    return pb_encode("user.SetHomeShowHeroResp", {ret = ret})
end


--设置家园部署英雄
---@param data RequestData
function handler.SetHomeDisposesHeroReq(data)
    ---@type SetHomeDisposesHeroReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --设置家园部署英雄
    local ret = player:setDisposesRole(payload.homeDisposesHero, userinfo)
    --如果用户信息有更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notifyDirect({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.SetHomeDisposesHeroResp", {ret = ret})
end

--重复战斗
---@param data RequestData
function handler.BattleRepeatReq(data)
    ---@type BattleRepeatReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --重复战斗
    local ret, rewardList, singleRewardList, extraRewardList, extraSingleList
        = player:finishBattleRepeat(payload.levelId, payload.repeatNum, payload.formationId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回数据
    return pb_encode("user.BattleRepeatResp", {ret = ret, rewardList = rewardList, singleRewardList = singleRewardList
    , extraRewardList = extraRewardList, extraSingleList = extraSingleList})
end

--为英雄装备技能
---@param data RequestData
function handler.EquipHeroSkillReq(data)
    ---@type EquipHeroSkillReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret = player:equipHeroSkill(payload.heroId, payload.skillList, userinfo)

    --通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.EquipHeroSkillResp", {ret = ret})
end

--武器分解
---@param data RequestData
function handler.DecomposeWeaponReq(data)
    ---@type DecomposeWeaponReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --武器分解
    local ret, rewardList = player:decomposePlayerWeapon(payload.idList, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回
    return pb_encode("user.DecomposeWeaponResp", {ret = ret, rewardList = rewardList})
end

--更改武器锁定状态
---@param data RequestData
function handler.ChangeWeaponLockStateReq(data)
    ---@type ChangeWeaponLockStateReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --更改武器锁定状态
    local ret = player:changeWeaponLockState(payload.weaponId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回
    return pb_encode("user.ChangeWeaponLockStateResp", {ret = ret})
end

---装备武器
---@param data RequestData
function handler.SetCharWeaponReq(data)
    ---@type SetCharWeaponReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --装备武器
    local ret = player:setCharWeapon(payload.charId, payload.partId, payload.weaponId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回
    return pb_encode("user.SetCharWeaponResp", {ret = ret})
end

--卸下武器
---@param data RequestData
function handler.RemoveCharWeaponReq(data)
    ---@type RemoveCharWeaponReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --卸下武器
    local ret = player:removeCharWeapon(payload.weaponId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回
    return pb_encode("user.RemoveCharWeaponResp", {ret = ret})
end

--升级武器
---@param data RequestData
function handler.AddWeaponExpReq(data)
    ---@type AddWeaponExpReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --升级武器
    local ret = player:addWeaponExperience(payload.weaponId, payload.useList, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回
    return pb_encode("user.AddWeaponExpResp", {ret = ret})
end

--融合武器
---@param data RequestData
function handler.FuseWeaponReq(data)
    ---@type FuseWeaponReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --融合武器
    local ret, newWeaponId = player:fusePlayerWeapon(payload.fuseList, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回
    return pb_encode("user.FuseWeaponResp", {ret = ret, newWeaponId = newWeaponId})
end

--领取任务奖励请求
---@param data RequestData
function handler.GetMissionRewardReq(data)
    local player = data.player
    ---@type GetMissionRewardReq
    local payload = data.payload
    local userinfo = {}

    --获取任务奖励
    local ret, rewardList = player:getMissionReward(payload.idList, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.GetMissionRewardResp", {ret = ret, rewardList = rewardList})
end

--提交领取任务奖励
---@param data RequestData
function handler.SubmitClaimMissionRewardReq(data)
    ---@type SubmitClaimMissionRewardReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --提交领取任务奖励
    local ret, rewardList = player:submitClaimMissionReward(payload.idList, userinfo)
    if ret ~= ActionFailReason.None then
        return pb_encode("user.SubmitClaimMissionRewardResp", {ret = ret})
    end

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.SubmitClaimMissionRewardResp", {ret = ret, rewardList = rewardList})
end

--更换看板娘
---@param data RequestData
function handler.SetPosterDataReq(data)
    ---@type SetPosterDataReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --更换看板娘
    local reason = player:changePoeterId(payload.posterId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.SetPosterDataResp", {ret = reason})
end

--更改看板娘位置缩放
---@param data RequestData
function handler.SetPosterPosReq(data)
    ---@type SetPosterPosReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --更改看板娘位置缩放
    local ret = player:changePosterPos(payload, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.SetPosterPosResp", {ret = ret})
end

--抽卡
---@param data RequestData
function handler.StartRaffleReq(data)
    ---@type StartRaffleReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --抽卡
    local ret, rewardList = player:startRaffle(payload.raffleId, payload.count, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.StartRaffleResp", {ret = ret, rewardList = rewardList})
end

--测试抽卡
---@param data RequestData
function handler.TestRaffleReq(data)
    ---@type TestRaffleReq
    local payload = data.payload
    local player = data.player

    --测试抽卡
    local ret, rewardList = player:testRaffle(payload.raffleId, payload.count)

    return pb_encode("user.TestRaffleResp", {ret = ret, rewardList = rewardList})
end

--引导抽卡
---@param data RequestData
function handler.GuideRaffleReq(data)
    ---@type GuideRaffleReq
    local payload = data.payload
    local player = data.player

    local userinfo = {}
    local ret, rewardList = player:doGuideRaffle(userinfo)
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.GuideRaffleResp", {ret = ret, rewardList = rewardList})
end

--穿戴皮肤
---@param data RequestData
function handler.EquipSkinReq(data)
    ---@type EquipSkinReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret = player:equipSkin(payload.heroId, payload.skinId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.EquipSkinResp", {ret = ret})
end

--更换签名
---@param data RequestData
function handler.ChangeSignReq(data)
    ---@type ChangeSignReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --更换签名
    local ret = player:setUserSign(payload.signTxt, data.ip, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.ChangeSignResp", {ret = ret})
end

--更换名称
---@param data RequestData
function handler.ChangeNameReq(data)
    ---@type ChangeNameReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --更换名称
    local ret = player:setUserName(payload.newName, data.ip, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.ChangeNameResp", {ret = ret})
end

--更换头像
---@param data RequestData
function handler.ChangeHeadReq(data)
    ---@type ChangeHeadReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --更换头像
    local ret = player:setUserHead(payload.HeadId, userinfo)

    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.ChangeHeadResp", {ret = ret})
end


--领取家园建筑奖励
---@param data RequestData
function handler.GetBuildingsRewardReq(data)
    ---@type GetBuildingsRewardReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --领取奖励
    local ret, rewardList = player:getBuildingsReward(payload.constIds, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.GetBuildingsRewardResp",{ret = ret, rewardList = rewardList})
end


--请求生产武器
---@param data RequestData
function handler.WeaponProductionReq(data)
    ---@type WeaponProductionReq
    local payload = data.payload
    local player = data.player
    ---@type UserInfo
    local userinfo = {}

    --生产武器
    local ret, rewardList = player:weaponProduction(payload.blueprintId, payload.count, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.WeaponProductionResp",{ret = ret, rewardList = rewardList})
end

--请求领取章节奖励
---@param data RequestData
function handler.GetChapterAwardReq(data)
    ---@type GetChapterAwardReq
    local payload = data.payload
    local player = data.player
    ---@type UserInfo
    local userinfo = {}

    --领取奖励
    local ret, rewardList = player:getChapterAwardReward(payload.id, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.GetChapterAwardResp",{ret = ret, rewardList = rewardList})
end

--请求修改图鉴收藏状态（自动反转当前状态）
---@param data RequestData
function handler.SetHandbookCollectedReq(data)
    ---@type SetHandbookCollectedReq
    local payload = data.payload
    local player = data.player
    ---@type UserInfo
    local userinfo = {}
    --反转收藏状态
    local ret, newCollectedState = player:toggleHandbookCollected(payload.bookType, payload.id, userinfo)

    if ret ~= ActionFailReason.None then
        return pb_encode("user.SetHandbookCollectedResp", {ret = ret})
    end

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功，并返回新的收藏状态
    return pb_encode("user.SetHandbookCollectedResp", {ret = ActionFailReason.None, isCollected = newCollectedState})
end

--请求设置散步英雄列表
---@param data RequestData
function handler.SetHomeWalkHeroReq(data)
    ---@type SetHomeWalkHeroReq
    local payload = data.payload
    local player = data.player
    ---@type UserInfo
    local userinfo = {}

    local ret = player:setHomeWalkHero(payload.heroIdList, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.SetHomeWalkHeroResp",{ret = ret})
end

----------------------------------------Friend----------------------------------------
--好友操作
function handler.OperateFriendReq(data)
	local payload = data.payload
    local player = data.player

    -- GE.OperateFriend
    local ret = ActionFailReason.None
    local successList = {}
    if GV.IsServer then
        ret, successList = GameGlobal.OperateFriend({operate = payload.operate, uid = player.uid, uidList = payload.uidList})
    end

	return pb_encode("user.OperateFriendResp", {ret = ret, successList = successList})
end

--领取友情点
function handler.GetFriendPointReq(data)
    local payload = data.payload
    local player = data.player

    local ret = ActionFailReason.None
    local rewardList = {}
    local successList = {}
    local userinfo = {}
    if GV.IsServer then
        ret, successList, rewardList = GameGlobal.GetFriendPoint({uid = player.uid, uidList = payload.uidList})
        --奖励发放
        if rewardList and not tablex.empty(rewardList) then
            --添加奖励
            rewardList = player:addRewardList(rewardList, userinfo, GE.EventItemType.FriendPoint, #payload.uidList)
        end
        --如果有用户信息更新，通知客户端
        if userinfo and not tablex.empty(userinfo) then
            player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
        end
    end

    return pb_encode("user.GetFriendPointResp", {ret = ret, successList = successList, rewardList = rewardList})
end

--赠送友情点
function handler.GiveFriendPointReq(data)
    local payload = data.payload
    local player = data.player

    local ret = ActionFailReason.None
    local successList = {}
    if GV.IsServer then
        ret, successList = GameGlobal.GiveFriendPoint({uid = player.uid, uidList = payload.uidList})
    end

    return pb_encode("user.GiveFriendPointResp", {ret = ret, successList = successList})
end

--gm命令
function handler.GmCommandReq(data)
    local payload = data.payload
    local player = data.player

    local ret, proto = GMServer.clientGmRequest(player, payload.content)
    --如果有用户信息更新，通知客户端
    if proto and not tablex.empty(proto) then
        player:notify(proto)
    end

    return pb_encode("user.GmCommandResp", {ret = ret})
end

----------------------------------------好感度----------------------------------------

--请求赠送英雄好感度礼物
---@param data RequestData
function handler.HeroAffectionGitfReq(data)
    ---@type HeroAffectionGitfReq
    local payload = data.payload
    local player = data.player
    ---@type UserInfo
    local userinfo = {}
    local ret = player:giveAffectionGift(payload.id, payload.giftId, payload.count, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.HeroAffectionGitfResp",{ret = ret})
end

--请求领取英雄好感度等级奖励
---@param data RequestData
function handler.HeroAffectionRewardReq(data)
    ---@type HeroAffectionRewardReq
    local payload = data.payload
    local player = data.player
    ---@type UserInfo
    local userinfo = {}

    local ret, rewardList = player:affectionGetReward(payload.id, payload.level,userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.HeroAffectionRewardResp",{ret = ret, rewardList = rewardList})
end

--请求接受好感度事件
---@param data RequestData
function handler.AcceptAffectionEventReq(data)
     ---@type AcceptAffectionEventReq
    local payload = data.payload
    local player = data.player
    ---@type UserInfo
    local userinfo = {}
    local ret, rewardList = player:finishiAffectionEvent(payload.id, payload.selectIndex, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    --返回成功
    return pb_encode("user.AcceptAffectionEventResp",{ret = ret, rewardList = rewardList})
end

--请求完成好感度事件委托
---@param data RequestData
function handler.DelegateEventFinishReq(data)
     ---@type DelegateEventFinishReq
    local payload = data.payload
    local player = data.player
    ---@type UserInfo
    local userinfo = {}
    local ret, rewardList = player:finishiDelegateEvent(payload.id, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    --返回成功
    return pb_encode("user.DelegateEventFinishResp",{ret = ret, rewardList = rewardList})
end

--------------------------------------------------------------------------------
--商店购买
---@param data RequestData
function handler.ShopBuyReq(data)
    ---@type ShopBuyReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --购买商店物品
    local ret, rewardList = player:shopBuy(payload.goodsId, payload.buyNum, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.ShopBuyResp",{ret = ret, rewardList = rewardList})
end

--商店刷新
---@param data RequestData
function handler.ShopRefreshReq(data)
    ---@type ShopBuyReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    local ret = player:shopRefresh(payload.shopId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.ShopRefreshResp",{ret = ret})
end

--------------------------------------------------------------------------------
--支付相关
--------------------------------------------------------------------------------
--支付初始化
---@param data RequestData
function handler.payInitializeReq(data)
    ---@type payInitializeReq
    local payload = data.payload
    local player = data.player

    local ret = player:payInitialize(payload)

    return pb_encode("user.payInitializeResp", {ret = ret})
end

--客户端验证支付
---@param data RequestData
function handler.payClientCheckReq(data)
    ---@type payClientCheckReq
    local payload = data.payload
    local player = data.player

    local ret, success, item = player:payClientCheck(payload)

    return pb_encode("user.payClientCheckResp", {ret = ret, success = success, item = item})
end

--支付请求
---@param data RequestData
function handler.payReq(data)
    ---@type payReq
    local payload = data.payload
    local player = data.player

    local ret, orderString, game_trade_no, trade_no_uuid = player:pay(payload)

    return pb_encode("user.payResp", {ret = ret, orderString = orderString, game_trade_no = game_trade_no, trade_no_uuid = trade_no_uuid})
end

--请求支付结果
---@param data RequestData
function handler.payResultReq(data)
    ---@type payResultReq
    local payload = data.payload
    local player = data.player

    local ret, receipt_order = player:payResult(payload)

    return pb_encode("user.payResultResp", {ret = ret, receipt_order = receipt_order})
end

--支付成功处理
---@param data RequestData
function handler.paySuccess(player, data, success)
    player:paySuccess(data, success)
end

--退款成功处理
---@param data RequestData
function handler.refundSuccess(player, data, success)
    player:refundSuccess(data, success)
end

----------------------------模拟演习------------------------------
--请求领取模拟演习层奖励
---@param data RequestData
function handler.GetSimulatedAwardReq(data)
    ---@type GetSimulatedAwardReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --领取模拟演习层奖励
    local ret, rewardList = player:getSimulatedAward(payload.floorId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.GetSimulatedAwardResp", {ret = ret, rewardList = rewardList})
end

--请求模拟演习扫荡战斗
---@param data RequestData
function handler.SimulatedSweepReq(data)
    ---@type SimulatedSweepReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --领取模拟演习层奖励
    local ret, rewardList = player:simulatedSweeping(payload.formationId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.SimulatedSweepResp", {ret = ret, rewardList = rewardList})
end

--请求领取Boss积分奖励
---@param data RequestData
function handler.GetBossScoreAwardReq(data)
    ---@type GetBossScoreAwardReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --领取Boss积分奖励
    local ret, rewardList = player:getWeeklyBossScoreAward(payload.scoreId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.GetBossScoreAwardResp", {ret = ret, rewardList = rewardList})
end

--请求设置Boss战Tag列表
---@param data RequestData
function handler.SetWeeklyBossTagReq(data)
    ---@type SetWeeklyBossTagReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --设置Boss战Tag列表
    local ret = player:setWeeklyBossTag(payload.bossId, payload.tagList, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.SetWeeklyBossTagResp", {ret = ret})
end

--请求已读功能开放
---@param data RequestData
function handler.ReadFunctionReq(data)
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --读取功能开启状态
    local ret = player:setFunctionReadById(payload.functionId, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.ReadFunctionResp", {ret = ret})
end

--请求打开道具礼包奖励
---@param data RequestData
function handler.OpenGiftPackReq(data)
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --打开道具礼包
    local ret, rewardList = player:getGiftPackRewards(payload.id, payload.num, payload.selectIndex, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.OpenGiftPackResp", {ret = ret, rewardList = rewardList})
end


---收到 获取英雄状态请求
---@param data RequestData
function handler.ReportHeroHomeActionCompletedReq(data)

    local player = data.player
    ---@type ReportHeroHomeActionCompletedReq
    local payload = data.payload
    local protoData = {}

    local infos = player:reportHeroHomeActionCompleted(payload.heroActions, protoData)

    --如果有用户信息更新，通知客户端
    if protoData and not tablex.empty(protoData) then
        player:notifyDirect({"user.UserInfoUpdate", {userinfo = protoData}})
    end

    --返回成功
    return pb_encode("user.ReportHeroHomeActionCompletedResp", {
        ret = ActionFailReason.None, 
        infos = infos
    })
end

---收到置进出家园请求
---@param data RequestData
function handler.ReportHomelandEnterExitReq(data)

    local player = data.player
    local payload = data.payload
    ---@type UserInfo
    local protoData = {}

    local isEnter = payload.isEnter
    player:SetHomelandIsEnter(isEnter, protoData)

    --如果有用户信息更新，通知客户端
    if protoData and not tablex.empty(protoData) then
        player:notifyDirect({"user.UserInfoUpdate", {userinfo = protoData}})
    end

    --返回成功
    return pb_encode("user.ReportHomelandEnterExitResp", {
        ret = ActionFailReason.None, 
        isEnter = isEnter,
    })
end


---收到领取家园收益请求
---@param data RequestData
function handler.ReportHomelandGetEarningRewardReq(data)

    local player = data.player
    local payload = data.payload
    ---@type UserInfo
    local protoData = {}
    player:UpdateHomelandStorageItemData(false, protoData)
    local rewardList = player:GetHomelandEarningsItems(protoData)

    --如果有用户信息更新，通知客户端
    if protoData and not tablex.empty(protoData) then
        player:notifyDirect({"user.UserInfoUpdate", {userinfo = protoData}})
    end

    --返回成功
    return pb_encode("user.ReportHomelandGetEarningRewardResp", {
        ret = ActionFailReason.None, 
        rewardList = rewardList,
    })
end

--一键收集家园资源（建筑产出+离线收益）
---@param data RequestData
function handler.OneKeyCollectHomelandResourceReq(data)
    local player = data.player
    ---@type UserInfo
    local protoData = {}

    local ret, rewardList = player:oneKeyCollectHomelandResource(protoData)

    --推送家园数据变更给客户端
    if protoData and not tablex.empty(protoData) then
        player:notify({"user.UserInfoUpdate", {userinfo = protoData}})
    end

    return pb_encode("user.OneKeyCollectHomelandResourceResp", {
        ret = ret,
        rewardList = rewardList or {},
    })
end

--设置自定义数据
function handler.SetUserDefinedReq(data)
    local payload = data.payload
    local player = data.player

    local userinfo = {}
    local ret = player:SetUserDefined(payload.info, userinfo)

    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.SetUserDefinedResp", {ret = ret})
end

--领取问卷调查奖励请求
function handler.GetQnaireRewardReq(data)
    local payload = data.payload
    local player = data.player

    local userinfo = {}
    local ret, rewardList = player:GetQnaireReward(payload.qnaireId, userinfo)

    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.GetQnaireRewardResp", {ret = ret, rewardList = rewardList})
end


--领取通行证奖励
function handler.GetPassRewardReq(data)
    local payload = data.payload
    local player = data.player

    local userinfo = {}
    local ret, rewardList = player:GetPassLevelReward(payload.id, payload.level, payload.rewardState, userinfo)

    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.GetPassRewardResp", {ret = ret, rewardList = rewardList})
end

--修改英雄名称
function handler.HeroChangeNameReq(data)
    local payload = data.payload
    local player = data.player

    local userinfo = {}
    local ret = player:ChangeHeroName(payload.id, payload.newName, data.ip, userinfo)

    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.HeroChangeNameResp", {ret = ret})
end


--添加家园互动道具奖励
function handler.ReportHomelandCovePropsAddRewardReq(data)

    ---@type ReportHomelandCovePropsAddRewardReq
    local payload = data.payload
    ---@type Player
    local player = data.player

    local id = payload.id
    local userinfo = {}

    local ret,rewards = player:AddCovePropsReward(payload.id, payload.actionId, userinfo)
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    return pb_encode("user.ReportHomelandCovePropsAddRewardResp", {ret = ret, id = id, rewards = rewards})
end

--领取家园互动道具奖励
function handler.ReportHomelandCovePropsGetRewardReq(data)
    ---@type ReportHomelandCovePropsGetRewardReq
    local payload = data.payload
    ---@type Player
    local player = data.player

    local userinfo = {}

    local ret, rewardList = player:GetCovePropsReward(payload.id, userinfo)

    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.ReportHomelandCovePropsGetRewardResp", {ret = ret, id = payload.id, rewardList = rewardList})
end


---英雄交互请求
function handler.ReportHomelandCoveHeroInteractionReq(data)

    ---@type ReportHomelandCoveHeroInteractionReq
    local payload = data.payload
    ---@type Player
    local player = data.player

    local userinfo = {}

    local ret = player:CoveInteraction(payload.heroId, payload.talkId, userinfo)
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.ReportHomelandCoveHeroInteractionResp", {ret = ret})
end

---创建家园战斗宝箱信息
function handler.ReportCreateHomelandBattleRewardBoxReq(data)
    ---@type ReportCreateHomelandBattleRewardBoxReq
    local payload = data.payload
    ---@type Player
    local player = data.player

    local userinfo = {}

    local ret, coveBoxReward = player:CreateHomelandBattleRewardBox(payload.covePoints, payload.isCrateReward, userinfo)
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.ReportCreateHomelandBattleRewardBoxResp", {ret = ret, coveBoxReward = coveBoxReward})
end


---发送战斗结束
function handler.ReportHomelandBattleGameOverReq(data)
    ---@type ReportHomelandBattleGameOverReq
    local payload = data.payload
    ---@type Player
    local player = data.player

    local userinfo = {}

    local ret, coveBoxReward = player:HomelandBattleGameOver(userinfo)
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.ReportHomelandBattleGameOverResp", {ret = ret, coveBoxReward = coveBoxReward or {}})
end

---领取宝箱奖励
function handler.ReportGetHomelandBattleRewardBoxReq(data)
    ---@type ReportGetHomelandBattleRewardBoxReq
    local payload = data.payload
    ---@type Player
    local player = data.player

    local userinfo = {}

    local ret, rewardList = player:GetHomelandBattleRewardBox(payload.uids, userinfo)
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.ReportGetHomelandBattleRewardBoxResp", {ret = ret, rewardList = rewardList})
end

---领取兑换码奖励
function handler.GetRedeemCodeAwardReq(data)
    ---@type GetRedeemCodeAwardReq
    local payload = data.payload
    ---@type Player
    local player = data.player

    local ret = player:verifyRedeemCodeReward(payload.code)

    return pb_encode("user.GetRedeemCodeAwardResp", {ret = ret})
end

---请求设置英雄语种
---@param data RequestData
function handler.SetCharVoiceReq(data)
    ---@type SetCharVoiceReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --设置英雄语种
    local ret = player:setCharVoiceType(payload.idList, payload.type, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.SetCharVoiceResp", {ret = ret})
end

---请求设置英雄初始语种
---@param data RequestData
function handler.SetCharInitVoiceReq(data)
    ---@type SetCharInitVoiceReq
    local payload = data.payload
    local player = data.player
    local userinfo = {}

    --设置英雄初始语种
    local ret = player:setCharInitVoiceType(payload.type, userinfo)

    --如果有用户信息更新，通知客户端
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end

    --返回成功
    return pb_encode("user.SetCharInitVoiceResp", {ret = ret})
end

---请求游戏分享
---@param data RequestData
function handler.GameShareReq(data)
    ---@type GameShareReq
    local payload = data.payload
    ---@type Player
    local player = data.player
    local userinfo = {}

    local ret, rewardList = player:gameShare(payload.shareType, userinfo)
    if userinfo and not tablex.empty(userinfo) then
        player:notify({"user.UserInfoUpdate", {userinfo = userinfo}})
    end
    return pb_encode("user.GameShareResp", {ret = ret, rewardList = rewardList})
end


return handler