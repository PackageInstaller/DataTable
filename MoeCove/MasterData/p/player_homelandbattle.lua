-- Desc: 家园战斗相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end

-- 宝箱唯一id起始值
local keyStuff = 100


---@return CoveBattleData
function Player:GetCoveBattleData()
    local temp = self:getHomeland().coveBattleData
    if temp == nil then
        temp = {
            fightId = 0,
            createTime = 0,
            cacheBattleCount = 0,
            boxCachePos = {}
        }
        self:getHomeland().coveBattleData = temp
    end
    return temp
end

---@return table<integer, CoveBoxReward>
function Player:GetCoveBoxRewards()
    local temp = self:getHomeland().coveBoxRewards
    if temp == nil then
        temp = {}
        self:getHomeland().coveBoxRewards = temp
    end
    return temp
end

---登录时检测家园战斗宝箱
---@param userInfo UserInfo
function Player:UpdateHomelandBattleBoxData(userInfo)
    local curTime = DLuaUtil.GetGreenwichTime()
    local battleData = self:GetCoveBattleData()
    ---检测战斗

    local coveBoxRewards = self:GetCoveBoxRewards()

    local isChange = self:CheckBattleOverTime()
    if isChange then     
        userInfo.homeland = userInfo.homeland or {}
        userInfo.homeland.coveBattleData = self:GetCoveBattleData()
    end

    ---@type integer[]
    local overTimeRewards = {}
    for k,v in pairs(coveBoxRewards) do
        if v.overTime ~= nil and curTime > v.overTime then
            table.insert(overTimeRewards, k)
        end
    end

    local awardTemp = {}
    for i = 1, #overTimeRewards do
        ---@type integer
        local uid = overTimeRewards[i]
        local br = coveBoxRewards[uid]
        local awardList = self:getRandomAward(br.boxId)
        for k, v in pairs(awardList) do
            local id = v[2]
            local num = v[3]
            local r = awardTemp[id]
            if r == nil then
                awardTemp[id] = v
            else
                r[3] = r[3] + num
            end
        end
        coveBoxRewards[uid] = nil
    end

    local awards = {}
    for k, v in pairs(awardTemp) do
        table.insert(awards, v)
    end
    
    if #awards == 0 then
        return
    end

    self:AddEarningsItemList(awards, userInfo)    --添加离线仓库

    ---重置唯一id
    ---@type CoveBoxReward[]
    local temp = {}
    for k, v in pairs(coveBoxRewards) do
        table.insert(temp, v)
    end
    coveBoxRewards = {}
    local index = keyStuff
    for i = 1, #temp do
        index = index + 1
        temp[i].uid = index
        coveBoxRewards[index] = temp[i]
    end
    self.homeland.coveBoxRewards = coveBoxRewards

    userInfo.homeland = userInfo.homeland or {}
    userInfo.homeland.coveBoxRewards = userInfo.homeland.coveBoxRewards
end

---检测战斗超时
---@return boolean 是否更新战斗数据
function Player:CheckBattleOverTime()
    local curTime = DLuaUtil.GetGreenwichTime()
    local coveBoxRewards = self:GetCoveBoxRewards()

    ---检测战斗
    local battleData = self:GetCoveBattleData()
    if battleData.fightId == 0 then
       return false
    end

    local cfg = Config.GetHomeFightTableInfo(battleData.fightId)
    if cfg == nil then
        battleData.fightId = 0
        battleData.createTime = 0
        battleData.boxCachePos = {}
        return true
    end

    if curTime < battleData.createTime + cfg.duraction then
        return false
    end

    local size = tablex.size(battleData.boxCachePos)
    if size == 0 then
        battleData.fightId = 0
        battleData.createTime = 0
        battleData.boxCachePos = {}
        return true
    end

    local nextId = keyStuff
    for k, v in pairs(coveBoxRewards) do
        if not tablex.empty(v) then
            nextId = math.max(v.uid, nextId)
        end
    end

    --剩余怪物位置转为宝箱
    local overTime = battleData.createTime + 60*60
    for k, v in pairs(battleData.boxCachePos) do
        local boxId = cfg.Award[k - keyStuff]
        nextId = nextId + 1
        local box = {
            uid = nextId,
            boxId = boxId,
            overTime = overTime,
            pos = {x = v.x, y = v.y, z = v.z},
        }
        coveBoxRewards[box.uid] = box
    end
    battleData.fightId = 0
    battleData.createTime = 0
    battleData.boxCachePos = {}

    --日志
    if DataLogMgr then
        DataLogMgr.LogHomeBattleEvent({
            eventId = cfg.id,
            state = 4,
        }, self)
    end

    return true
end

---事件触发战斗
---@param eventId integer
---@param userInfo UserInfo?
function Player:RandomHomelandBattle(eventId, userInfo)
    local battleInfo = self:GetCoveBattleData()
    battleInfo.cacheBattleCount = battleInfo.cacheBattleCount + 1

    userInfo = userInfo or {}
    userInfo.homeland = userInfo.homeland or {}
    userInfo.homeland.coveBattleData = userInfo.homeland.coveBattleData or {}
    userInfo.homeland.coveBattleData.cacheBattleCount = battleInfo.cacheBattleCount
    self:CreateHomelandBattle(userInfo)

    --日志
    if DataLogMgr then
        DataLogMgr.LogHomeBattleEvent({
            eventId = 0, --0触发时没有记录事件id
            state = 1,
        }, self)
    end

    return ActionFailReason.None
end

---创建战斗
---@param userInfo UserInfo
---@return boolean?
function Player:CreateHomelandBattle(userInfo)
    if self:getFunctionOpenStateById(GE.FunctionOpenModule.CoveBattle) == GE.FunctionOpenState.Lock then
        return false
    end

    --剩余战斗次数、是否已有家园战斗
    local battleInfo = self:GetCoveBattleData()
    if battleInfo.cacheBattleCount <= 0 or battleInfo.fightId ~= 0 then
       return false
    end

    --是否进入家园
    local homeland = self:getHomeland()
    local isEnter = homeland.lastUpdateEarningsTime == 0
    if not isEnter then
       return false
    end

    --是否在CD时间
    local curTime = DLuaUtil.GetGreenwichTime()
    local cd = Config.GetConfigInfo("HomeFightCD") or 600
    if curTime < battleInfo.createTime + cd then
        return false
    end

    ---@type HomeFightTable[]
    local fTable = {}
    ---@type HomeFightTable[]
    local allCfg = Config.GetAllConfig("HomeFightTable") or {}
    for k, v in pairs(allCfg) do
        local isOpen = self:canOpenFunctionByCfg(v.condition)
        local disable = self:canOpenFunctionByCfg(v.disablecondition)
        if isOpen and (not disable) then
            table.insert(fTable, v)
        end
    end
    if #fTable == 0 then
        LuaLogger.ds("#fTable == 0")
        return false
    end

    local random = self:getRandom()
    local rv = random:range(1, #fTable)
    local cfg = fTable[rv]

    --战斗id、创建时间、剩余战斗次数
    battleInfo.fightId = cfg.id
    battleInfo.createTime = curTime
    battleInfo.cacheBattleCount = math.max(battleInfo.cacheBattleCount - 1, 0)

    --初始化小怪位置
    battleInfo.boxCachePos = {}
    for i = 1, cfg.enemyNum do
        local pos = {x = 0, y = 0, z = 0}
        battleInfo.boxCachePos[keyStuff + i] = pos
    end

    userInfo = userInfo or {}
    userInfo.homeland = userInfo.homeland or {}
    userInfo.homeland.coveBattleData = battleInfo

    --日志
    if DataLogMgr then
        DataLogMgr.LogHomeBattleEvent({
            eventId = cfg.id,
            state = 2,
        }, self)
    end

    return true
end

---创建宝箱
---@param covePoints table<integer, CovePos>
---@param isCrateReward boolean
---@param userInfo UserInfo
---@return ActionFailReason, CoveBox[]?
function Player:CreateHomelandBattleRewardBox(covePoints, isCrateReward, userInfo)
    if covePoints == nil or tablex.empty(covePoints) then
        return ActionFailReason.ParameterInvalid
    end

    --是否有家园战斗
    local battleData = self:GetCoveBattleData()
    if battleData.fightId == 0 then
        return ActionFailReason.HomeBattleNotOpen
    end

    for k, v in pairs(covePoints) do
        if tablex.empty(v) or v.x == nil or v.y == nil or v.z == nil then
            return ActionFailReason.ParameterInvalid
        end
    end

    ---@type HomeFightTable|nil
    local cfg = Config.GetHomeFightTableInfo(battleData.fightId)
    if cfg == nil then
       return ActionFailReason.CfgError
    end

    --创建小怪位置
    if not isCrateReward then
        if tablex.size(covePoints) ~= cfg.enemyNum then
            return ActionFailReason.ParameterInvalid
        end
        for k, v in pairs(covePoints) do
            local pos = battleData.boxCachePos[keyStuff + k]
            --如果当前位置已无小怪，说明已转为宝箱，不再同步位置
            if pos then
                pos.x = v.x
                pos.y = v.y
                pos.z = v.z
            end
        end

        ---boxCachePos 无需推送client
        return ActionFailReason.None
    end

    --验证小怪位置
    for k, v in pairs(covePoints) do
        if battleData.boxCachePos[keyStuff + k] == nil then
            return ActionFailReason.HomeBattleGetRewardPosError
        end
    end

    local coveBoxRewards = self:GetCoveBoxRewards()
    local nextId = keyStuff
    for k, v in pairs(coveBoxRewards) do
        nextId = math.max(v.uid, nextId)
    end

    userInfo.homeland = userInfo.homeland or {}
    userInfo.homeland.coveBoxRewards = userInfo.homeland.coveBoxRewards or {}
    userInfo.homeland.coveBattleData = userInfo.homeland.coveBattleData or {}
    userInfo.homeland.coveBattleData.boxCachePos = userInfo.homeland.coveBattleData.boxCachePos or {}

    --创建宝箱
    local overTime = battleData.createTime + 60*60
    local boxs = {}
    for k, v in pairs(covePoints) do
        local boxId = cfg.Award[k]
        nextId = nextId + 1
        local box = {
            uid = nextId,
            boxId = boxId,
            overTime = overTime,
            pos = {x = v.x, y = v.y, z = v.z},
        }
        local index = keyStuff + k
        coveBoxRewards[box.uid] = box
        battleData.boxCachePos[index] = nil
        table.insert(boxs, box)

        userInfo.homeland.coveBoxRewards[box.uid] = box
        userInfo.homeland.coveBattleData.boxCachePos[index] = {}
    end

    return ActionFailReason.None, boxs
end

---领取宝箱奖励
---@param uids integer[]
---@param userInfo UserInfo
---@return ActionFailReason, RewardInfo[]?
function Player:GetHomelandBattleRewardBox(uids, userInfo)
    if not uids or tablex.empty(uids) then
       return ActionFailReason.ParameterInvalid
    end

    local boxs = self:GetCoveBoxRewards()
    --去重
    local temp_uids = {}
    --验证宝箱id
    for _, uid in pairs(uids) do
        if not boxs[uid] then
           return ActionFailReason.ParameterInvalid
        end
        temp_uids[uid] = true
    end

    userInfo.homeland = userInfo.homeland or {}
    userInfo.homeland.coveBoxRewards = userInfo.homeland.coveBoxRewards or {}

    --领取宝箱奖励
    local awards = {}
    for uid, _ in pairs(temp_uids) do
        local box = boxs[uid]
        awards = tablex.combine(awards, self:getRandomAward(box.boxId))
        boxs[uid] = nil
        userInfo.homeland.coveBoxRewards[uid] = {}
    end

    local rewardList = self:addRewardList(awards, userInfo, GE.EventItemType.HomeCoveBattle, 0)
    return ActionFailReason.None, rewardList
end

---家园战斗结束
---@param userInfo UserInfo
---@return ActionFailReason, CoveBox[]?
function Player:HomelandBattleGameOver(userInfo)
    local battleInfo = self:GetCoveBattleData()
    if battleInfo.fightId == 0 then
        return ActionFailReason.HomeBattleNotOpen
    end

    local fightId = battleInfo.fightId
    local cfg = Config.GetHomeFightTableInfo(fightId)
    if cfg == nil then
       return ActionFailReason.CfgNotFind
    end

    ---发送未领取奖励
    local boxCachePos = battleInfo.boxCachePos
    local boxSize = tablex.size(boxCachePos)

    local boxs = nil
    if boxSize > 0 then
        local _
        local covePoints = {}
        for k, v in pairs(boxCachePos) do
            covePoints[k - keyStuff] = v
        end
        _, boxs = self:CreateHomelandBattleRewardBox(covePoints, true, userInfo)
    end

    local curTime = DLuaUtil.GetGreenwichTime()
    battleInfo.fightId = 0
    battleInfo.createTime = curTime
    battleInfo.boxCachePos = {}

    userInfo.homeland = userInfo.homeland or {}
    userInfo.homeland.coveBattleData = battleInfo

    --日志
    if DataLogMgr then
        DataLogMgr.LogHomeBattleEvent({
            eventId = fightId,
            state = 3,
        }, self)
    end

    return ActionFailReason.None, boxs
end

return Player