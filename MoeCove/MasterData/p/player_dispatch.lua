-- Desc: 派遣相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end

--获取派遣全量数据
---@return DispatchData
function Player:getDispatchData()
    return self.dispatchData
end

--获取已完成路线列表
---@return integer[]|[]
function Player:getDispatchFinishRouteList()
    local dispatchData = self:getDispatchData()
    return dispatchData.finishRouteList
end

--增加已完成路线
---@param routeId integer 路线ID
function Player:addDispatchFinishRoute(routeId)
    local finishRouteList = self:getDispatchFinishRouteList()
    for _, id in pairs(finishRouteList) do
        if id == routeId then
            return
        end
    end
    tablex.insertproxy(finishRouteList, routeId)
end

--获取奖励记录列表
---@return integer[]|[]
function Player:getDispatchRewardRecordList()
    local dispatchData = self:getDispatchData()
    return dispatchData.rewardRecordList
end

--增加领奖记录
---@param chapterId integer 章节ID
function Player:addDispatchRewardRecordList(chapterId)
    local recordList = self:getDispatchRewardRecordList()
    if tablex.find(recordList, chapterId) == false then
        tablex.insertproxy(recordList, chapterId)
    end
end

--是否已领取派遣章节奖励
---@param chapterId integer 章节ID
function Player:dispatchChapterRewardIsReceive(chapterId)
    local recordList = self:getDispatchRewardRecordList()
    return tablex.find(recordList, chapterId)
end

--获取派遣任务列表
---@return table<integer,DispatchTaskInfo>|{}
function Player:getDispatchTaskList()
    local dispatchData = self:getDispatchData()
    return dispatchData.dispatchTaskList or {}
end

--设置派遣任务数据
---@param dispatchId integer 派遣ID
function Player:setDispatchTaskDataById(dispatchId, data)
    local dispatchTaskList = self:getDispatchTaskList()
    dispatchTaskList[dispatchId] = data
end

--获取派遣任务数据
---@param dispatchId integer 派遣ID
---@return DispatchTaskInfo|nil
function Player:getDispatchTaskDataById(dispatchId)
    local dispatchTaskList = self:getDispatchTaskList()
    if not dispatchTaskList[dispatchId] then
        return nil
    end
    return dispatchTaskList[dispatchId]
end

--获取随机派遣任务列表
---@return table<integer,DispatchRandomTaskInfo>|{}
function Player:getDispatchRandomTaskList()
    local dispatchData = self:getDispatchData()
    return dispatchData.dispatchRandomTaskList
end

--设置随机派遣任务数据
---@param dispatchId integer 派遣ID
---@param data DispatchRandomTaskInfo|nil 派遣数据
function Player:setDispatchRandomTaskData(dispatchId, data)
    local dispatchRandomTaskList = self:getDispatchRandomTaskList()
    dispatchRandomTaskList[dispatchId] = data
end

--获取某个待派遣任务
---@param dispatchId integer 派遣任务ID
---@return DispatchRandomTaskInfo|nil
function Player:getDispatchRandomListById(dispatchId)
    local dispatchRandomTaskList = self:getDispatchRandomTaskList()
    return dispatchRandomTaskList[dispatchId]
end

--更新 待派遣数据 数据
function Player:updateDispatchRandomTaskList(dispatchId, proto)
    if not proto.dispatchData then
        proto.dispatchData = {}
    end
    if not proto.dispatchData.dispatchRandomTaskList then
        proto.dispatchData.dispatchRandomTaskList = {}
    end

    local randomInfo = self:getDispatchRandomListById(dispatchId)
    if not randomInfo then
        proto.dispatchData.dispatchRandomTaskList[dispatchId] = {}
    else
        proto.dispatchData.dispatchRandomTaskList[dispatchId] = randomInfo
    end
end

--更新 正在派遣数据 数据
function Player:updateDispatchTaskList(dispatchId, proto)
    if not proto.dispatchData then
        proto.dispatchData = {}
    end
    if not proto.dispatchData.dispatchTaskList then
        proto.dispatchData.dispatchTaskList = {}
    end

    local dispatchTaskData = self:getDispatchTaskDataById(dispatchId)
    if not dispatchTaskData then
        proto.dispatchData.dispatchTaskList[dispatchId] = {}
    else
        proto.dispatchData.dispatchTaskList[dispatchId] = dispatchTaskData
    end
end

--更新 派遣过的路线 数据
function Player:updateDispatchFinishRouteList(proto)
    if not proto.dispatchData then
        proto.dispatchData = {}
    end
    if not proto.dispatchData.finishRouteList then
        proto.dispatchData.finishRouteList = {}
    end

    local finishRouteList = self:getDispatchFinishRouteList()
    for _, routeId in pairs(finishRouteList) do
        table.insert(proto.dispatchData.finishRouteList, routeId)
    end
end

--更新 领奖数据 数据
function Player:updateRewardRecordList(proto)
    if not proto.dispatchData then
        proto.dispatchData = {}
    end
    if not proto.dispatchData.rewardRecordList then
        proto.dispatchData.rewardRecordList = {}
    end

    local rewardRecordList = self:getDispatchRewardRecordList()
    for _, rewardId in pairs(rewardRecordList) do
        table.insert(proto.dispatchData.rewardRecordList, rewardId)
    end
end

--刷新派遣状态
function Player:refreshDispatchData(userinfo)
    local dispatchTaskList = self:getDispatchTaskList()
    local dispatchRandomTaskList = self:getDispatchRandomTaskList()
    for _, routeData in pairs(dispatchTaskList) do
        if routeData.state == GE.DispatchState.Dispatching then
            if DLuaUtil.GetGreenwichTime() >= routeData.finishTime then
                --派遣完成
                routeData.state = GE.DispatchState.Finish
                --proto更新
                self:updateDispatchTaskList(routeData.dispatchId, userinfo)
            end
        end
    end
    local delList = {}
    for _, taskData in pairs(dispatchRandomTaskList) do
        if taskData.lineId == 0 then
            if DLuaUtil.GetGreenwichTime() >= taskData.endTime then
                --任务过期
                table.insert(delList, taskData.dispatchId)
            end
        end
    end
    for _, dispatchId in pairs(delList) do
        self:setDispatchRandomTaskData(dispatchId, nil)
        self:updateDispatchRandomTaskList(dispatchId, userinfo)
    end
end

--触发器随机派遣事件
function Player:randomDispatchEvent(proto)
    local randomDispatchTaskList = self:getDispatchRandomTaskList()
    --生成数量限制
    if tablex.size(randomDispatchTaskList) >= 3 then
        return
    end
    --已生成组列表
    local existGroupList = {}
    for _, v in pairs(self:getDispatchTaskList()) do
        local dispatchCfg = Config.GetDispatchInfo(v.dispatchId)
        if dispatchCfg then
            existGroupList[dispatchCfg.group] = true
        end
    end
    --随机列表
    local randomDataList = {}
    local dispatchCfgList = Config.GetDispatchInfoByType(GE.DispatchType.Random)
    if not dispatchCfgList then
        LuaLogger.ds("not dispatchCfgList")
        return
    end
    local userLv = self:getUserLevel()
    for _, cfg in pairs(dispatchCfgList) do
        --排除已生成的和未到解锁等级的
        if not existGroupList[cfg.group] then
            if cfg.unLock[1] == GE.CommonLockJudgeType.Level then
                if userLv >= cfg.unLock[2] and userLv <= cfg.unLock[3] then
                    table.insert(randomDataList, {[1] = cfg, [2] = cfg.weight})
                end
            end
        end
    end
    if #randomDataList == 0 then
        LuaLogger.ds("#randomDataList == 0")
        return
    end
    local random = self:getRandom()
    local randomCfg = DLuaUtil.getRandomIndexLinear2(randomDataList, random)
    ---@type DispatchRandomTaskInfo
    local taskInfo = {
        dispatchId = randomCfg.id,
        endTime = DLuaUtil.GetGreenwichTime() + randomCfg.countDown * 60,  -- 等待时间
        lineId = 0,  -- 派遣路线ID
    }
    --数据更新
    self:setDispatchRandomTaskData(randomCfg.id, taskInfo)
    --proto更新
    self:updateDispatchRandomTaskList(randomCfg.id, proto)
end

--请求派遣开启
---@param dispatchId integer 派遣id
---@param lineId integer 派遣路线id
---@param roleIdList integer[] 角色ID列表
---@param proto UserInfo 用户信息
---@return ActionFailReason 错误码
function Player:startDispatch(dispatchId, lineId, roleIdList, proto)
    --功能开启检测 - 派遣是否开启
    local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.ShipDispatch)
    if isOpen == GE.FunctionOpenState.Lock then
        return ActionFailReason.FunctionOpenNotOpen
    end
    --入参检测
    if not dispatchId or not lineId or not roleIdList or #roleIdList == 0 then
        return ActionFailReason.ParameterInvalid
    end
    --获取派遣配置
    local dispatchCfg = Config.GetDispatchInfo(dispatchId)
    if not dispatchCfg then
        return ActionFailReason.CfgNotFind
    end
    --检查是否开启
    if self:canOpenFunctionByCfg(dispatchCfg.unLock) == false then
        return ActionFailReason.FunctionOpenNotOpen
    end
    --如果是随机派遣
    if dispatchCfg.type == GE.DispatchType.Random then
        --获取派遣数据
        local randominfo = self:getDispatchRandomListById(dispatchId)
        if not randominfo or randominfo.lineId ~= 0 then
            return ActionFailReason.DispatchNotFind
        end
    end
    --检测路线
    if tablex.find(dispatchCfg.lineGroup, lineId) == false then
        return ActionFailReason.DispatchLineNotFind
    end
    --检测角色
    local dispatchRoleList = self:getInDispatchRole()
    --检测重复角色
    local checkList = {}
    for _, roleId in pairs(roleIdList) do
        if checkList[roleId] then
            return ActionFailReason.ParameterInvalid
        end
        checkList[roleId] = true
        --检测角色是否存在
        local roleData = self:getPlayerHero(roleId)
        if not roleData then
            return ActionFailReason.HeroNoFind
        end
        if tablex.find(dispatchRoleList, roleId) then
            return ActionFailReason.RoleInDispatch
        end
    end
    --检测派遣角色数量
    if tablex.size(roleIdList) > dispatchCfg.characterNum then
        return ActionFailReason.DispatchRoleNumExceed
    end
    --派遣成功
    local curTime = DLuaUtil.GetGreenwichTime()
    local lineIndex = 1
    for i = 1, #dispatchCfg.lineGroup do
        if dispatchCfg.lineGroup[i] == lineId then
            lineIndex = i
            break
        end
    end
    local costTimeList = dispatchCfg.costTime[lineIndex]
    if not costTimeList then
        costTimeList = {1,1,1,1,1,1,1,1,1,1}
    end
    --local finishTime = curTime + dispatchCfg.costTime * 60
    local pointInfo, finishTime = self:genDispatchPointInfo(roleIdList, dispatchId, lineId, curTime, costTimeList, proto)
    ---@type DispatchTaskInfo
    local taskInfo = {
        dispatchId = dispatchId,
        lineId = lineId,
        state = GE.DispatchState.Dispatching,
        finishTime = finishTime,
        roleIdList = roleIdList,
        pointInfo = pointInfo,
    }
    self:setDispatchTaskDataById(dispatchId, taskInfo)
    --如果是随机派遣
    if dispatchCfg.type == GE.DispatchType.Random then
        --获取派遣数据
        local randominfo = self:getDispatchRandomListById(dispatchId)
        randominfo.lineId = lineId
        --proto更新
        self:updateDispatchRandomTaskList(dispatchId, proto)
    end
    --proto更新
    self:updateDispatchTaskList(taskInfo.dispatchId, proto)

    --流水日志
    if DataLogMgr then
        DataLogMgr.LogHomeDispatch({
            dispatchId = dispatchId,
            lineId = lineId,
            heroList = roleIdList,
            startTime = os.date('%Y-%m-%d %H:%M:%S', curTime),
            endTime = os.date('%Y-%m-%d %H:%M:%S', finishTime),
        }, self)
    end
    return ActionFailReason.None
end

--生成派遣点位信息
---@return DispatchPointData[]|[] 点位信息列表
---@return number 完成时间
function Player:genDispatchPointInfo(roleIdList, dispatchId, lineId, curTime, costTimeList, proto)
    local finishTime = curTime
    local allBattleCfg = Config.GetAllConfig("DispatchBattleTable")
    local disPatchData = Config.GetDispatchInfo(dispatchId)
    --加成舰种
    local enhanceTypeList = {}
    if disPatchData and disPatchData.extraCondition then
        local index = 1
        for k, v in pairs(disPatchData.lineGroup) do
            if v == lineId then
                index = k
                break
            end
        end
        enhanceTypeList = disPatchData.extraCondition[index] or {}
    end
    local roleBattlePointList = {}
    local heroes = {}
    for _, v in pairs(roleIdList) do
        local heroData = self:getPlayerHero(v)
        local roleConfig = Config.GetCharacterInfo(v)
        if heroData and roleConfig then
            self:setHeroAttribute(heroData)
            local signalList = self:getDispatchSignal(v)
            --单角色词条战力加成
            local mul = 1
            if signalList then
                for _, signalData in pairs(signalList) do
                    if signalData.effect[1] == GE.TagEffectType.dispatchBattlePointUp then
                        mul = mul + signalData.effect[2]
                    end
                end
            end
            --舰种加成
            local shipType = math.floor(roleConfig.attribute / 10)
            for _, enhanceType in pairs(enhanceTypeList) do
                if shipType == enhanceType then
                    mul = mul * Config.GetConfigInfo("DispatchMagnification")
                end
            end
            roleBattlePointList[v] = heroData.allDmg * mul
            table.insert(heroes, heroData)
        end
    end
    local pointCfgList = self:getDispatchPointCfgList(dispatchId, lineId)
    if not pointCfgList then
        LuaLogger.e("getDispatchPointCfgList failed, no pointCfgList")
        return {}, curTime
    end
    ---@type DispatchPointData[]
    local pointInfo = {}
    for _, pointCfg in ipairs(pointCfgList) do
        ---@type DispatchPointData
        local pointData = {
            showTime = 0,
            beginEnergy = {},
            endEnergy = {},
            reward = {},
        }
        if pointCfg.monster and pointCfg.monster ~= 0 then
            local roleNum = 0
            for _, heroData in pairs(heroes) do
                if heroData.energy > 0 then
                    roleNum = roleNum + 1
                end
                tablex.insertproxy(pointData.beginEnergy, heroData.energy)  -- 初始精力
            end
            if roleNum == 0 then
                --没有角色了，后续点位不生成了
                break
            end
            local battleCfg = nil
            for _, v in pairs(allBattleCfg) do
                if v.energeticNumber == roleNum then
                    battleCfg = v
                    break
                end
            end
            if not battleCfg then
                battleCfg = {
                    fireCoefficient = 1,
                    adjustedValue = 1,
                }
            end
            local isWin = false
            for _, heroData in pairs(heroes) do
                local roleBP = roleBattlePointList[heroData.id] or 0
                local pointBP = pointCfg.powerPoint or 0
                local allowNum = disPatchData.characterNum
                local deduct = math.pow(roleBP + pointBP / allowNum, 2) /
                    math.pow(roleBP, 2) * math.pow(pointBP / allowNum / roleBP, 0.125) * battleCfg.fireCoefficient * battleCfg.adjustedValue
                deduct = math.random(-20,20) / 100 * deduct + deduct

                -- 词条减少能量消耗
                local mul = 1
                local signalList = self:getDispatchSignal(heroData.id)
                if signalList then
                    for _, signalData in pairs(signalList) do
                        if signalData.effect[1] == GE.TagEffectType.dispatchHpReduce then
                            mul = signalData.effect[2]
                        end
                    end
                end
                heroData.energy = heroData.energy - math.floor(deduct * mul)
                --test
                --heroData.energy = heroData.energy - 10
                if heroData.energy < 0 then
                    heroData.energy = 0
                end
                local heroInfo = self:getPlayerHero(heroData.id)
                if heroInfo then
                    heroInfo.energy = heroData.energy
                    proto.heroList = proto.heroList or {}
                    proto.heroList[heroData.id] = heroInfo
                    tablex.insertproxy(pointData.endEnergy, heroData.energy)  -- 结束精力
                    if heroData.energy > 0 then
                        isWin = true
                    end
                end
            end

            if isWin then
                for _, awardId in pairs(pointCfg.award) do
                    local list = self:getRandomAward(awardId)
                    for _, data in pairs(list) do
                        local temp = {
                            type = data[1],
                            id = data[2],
                            num = data[3]
                        }
                        tablex.insertproxy(pointData.reward, temp)
                    end
                end
            end
        end
        tablex.insertproxy(pointInfo, pointData)
    end
    local totalPoint = tablex.size(pointInfo)
    for i = 1, totalPoint do
        local time = 1
        if costTimeList[i] then
            time = costTimeList[i]
        end
        finishTime = finishTime + time
        pointInfo[i].showTime = finishTime
    end
    --LuaLogger.e(tablex.dump(pointInfo))
    return pointInfo, finishTime
end

--请求派遣完成
---@param dispatchIdList integer[] 派遣路线id
---@param proto UserInfo 用户信息
---@return ActionFailReason 错误码
---@return RewardInfo[]? 奖励列表
function Player:settleDispatch(dispatchIdList, proto)
    if not dispatchIdList or #dispatchIdList == 0 then
        return ActionFailReason.ParameterInvalid
    end
    local allRewardList = {}
    local idList = {}
    for _, dispatchId in pairs(dispatchIdList) do
        --入参检测
        if not dispatchId then
            return ActionFailReason.ParameterInvalid
        end
        --id重复检测
        if not idList[dispatchId] then
            idList[dispatchId] = true
        else
            return ActionFailReason.ParameterInvalid
        end
        --派遣配置
        local dispatchCfg = Config.GetDispatchInfo(dispatchId)
        if not dispatchCfg then
            return ActionFailReason.ParameterInvalid
        end
        --获得正在进行中的派遣数据
        local taskData = self:getDispatchTaskDataById(dispatchId)
        if not taskData then
            return ActionFailReason.ParameterInvalid
        end
        --派遣状态检测
        if taskData.state ~= GE.DispatchState.Finish then
            return ActionFailReason.DispatchStateError
        end
    end
    for _, dispatchId in pairs(dispatchIdList) do
        local taskData = self:getDispatchTaskDataById(dispatchId)
        local dispatchCfg = Config.GetDispatchInfo(dispatchId)
        local isWin = self:getDispatchIsWin(dispatchId)
        if isWin then
            --派遣过的路线
            self:addDispatchFinishRoute(taskData.lineId)
            --触发任务系统的派遣完成计数
            self:missionTrigger(GE.MissionFinishType.FinishDispatchCount, {count = 1}, proto) --触发任务系统的派遣完成计数
        end

        --奖励
        for _, v in pairs(taskData.pointInfo) do
            for _, reward in pairs(v.reward) do
                --table.insert(rewardList, {[1] = reward.type, [2] = reward.id, [3] = reward.num})
                table.insert(allRewardList, {[1] = reward.type, [2] = reward.id, [3] = reward.num})
            end
        end

        --数据更新
        self:setDispatchTaskDataById(dispatchId, nil)
        --如果是随机派遣
        if dispatchCfg.type == GE.DispatchType.Random then
            --移除随机派遣数据
            self:setDispatchRandomTaskData(dispatchId, nil)
            --proto更新
            self:updateDispatchRandomTaskList(dispatchId, proto)
        end

        local ChapterProgress = self:getDispatchChapterProgress(dispatchId)
        if ChapterProgress == 1 then
            -- 派遣完成后，章节进度满了，触发任务系统的章节完成
            self:missionTrigger(GE.MissionFinishType.FinishDispatchById, {dispatchId = dispatchId}, proto)
        end
        --proto更新
        self:updateDispatchTaskList(dispatchId, proto)
    end
    --更新派遣过的路线
    self:updateDispatchFinishRouteList(proto)

    allRewardList = self:addRewardList(allRewardList, proto, GE.EventItemType.Dispatch)
    allRewardList = self:mergeRewardList(allRewardList)
    return ActionFailReason.None, allRewardList
end

function Player:getDispatchIsWin(dispatchId)
    local taskData = self:getDispatchTaskDataById(dispatchId)
    if not taskData then
        return false
    end
    local isWin = true
    for _, pointData in pairs(taskData.pointInfo) do
        local pointFail = true
        for _, energy in pairs(pointData.endEnergy) do
            if energy > 0 then
                pointFail = false
                break
            end
        end
        if tablex.size(pointData.endEnergy) == 0 then
            pointFail = false
        end
        if pointFail then
            isWin = false
            break
        end
    end
    return isWin
    
end

--请求派遣章节奖励
---@param chapterId integer 章节ID
---@param userinfo UserInfo 用户信息
---@return ActionFailReason, RewardInfo[]? 错误码，奖励列表
function Player:receiveDispatchChapterReward(chapterId, userinfo)
    if not chapterId then
        return ActionFailReason.ParameterInvalid
    end
    local cfg = Config.GetDispatchInfo(chapterId)
    if not cfg then
        return ActionFailReason.ParameterInvalid
    end
    if self:getDispatchChapterProgress(chapterId) ~= 1 then
        return ActionFailReason.DispatchChapterNotFinish
    end
    local recordList = self:getDispatchRewardRecordList()
    if tablex.find(recordList, chapterId) then
        return ActionFailReason.DispatchChapterRewardReceived
    end
    --奖励
    local rewardList = {}
    rewardList = self:addRewardList(cfg.finishAward, userinfo, GE.EventItemType.Dispatch, chapterId)
    rewardList = self:mergeRewardList(rewardList)
    --记录奖励领取状态
    self:addDispatchRewardRecordList(chapterId)
    --更新派遣数据
    self:updateRewardRecordList(userinfo)
    return ActionFailReason.None, rewardList

end

--获取派遣词条
function Player:getDispatchSignal(roleId)
    local signalList = {}
    local roleTagList = self:getHeroTagList(roleId)
    if roleTagList and tablex.size(roleTagList) > 0 then
        for _, tagId in pairs(roleTagList) do
            local tagData = Config.SignalInfo(tagId)
            if tagData and tagData.type == GE.TagType.dwelling and tablex.size(tagData.effect) > 0 then
                if tagData.effect[1] == GE.TagEffectType.dispatchHpReduce or 
                     tagData.effect[1] == GE.TagEffectType.dispatchBattlePointUp then
                      table.insert(signalList, tagData)
                 end
            end
        end
    end
    if tablex.size(signalList) == 0 then
        return nil
    end
    return signalList
end

--角色是否在派遣中
---@param roleId integer 角色ID
---@return boolean 是否在派遣中
function Player:roleInDispatch(roleId)
    local dispatchTaskList = self:getDispatchTaskList()
    for _, routeData in pairs(dispatchTaskList) do
        if routeData.roleIdList and tablex.find(routeData.roleIdList, roleId) then
            return true
        end
    end
    return false
end

--获取派遣中的角色
function Player:getInDispatchRole()
    local roleList = {}
    local dispatchTaskList = self:getDispatchTaskList()
    for _, routeData in pairs(dispatchTaskList) do
        if routeData.roleIdList then
            for _, roleId in pairs(routeData.roleIdList) do
                if not tablex.find(roleList, roleId) then
                    table.insert(roleList, roleId)
                end
            end
        end
    end
    return roleList
end

--角色是否在工作中
---@param roleId integer 角色ID
---@return boolean 是否在工作中
function Player:roleInWorking(roleId)
    local dispatchTaskList = self:getInHomeDisposeRole()
    return tablex.find(dispatchTaskList, roleId)
end


----------clinet----------

--获取可派遣的角色列表
---@return HeroInfo[]|[] 角色列表
function Player:getCanDispatchRoleList()
    local roleList = {}
    local dispatchRoleList = self:getInDispatchRole()
    for _, heroData in pairs(self.heroList) do
        --TODO 血量筛选
        if tablex.find(dispatchRoleList, heroData.id) == false  then
            table.insert(roleList, heroData)
        end
    end
    return roleList
end

--获取章节完成进度
---@param chapterId integer 章节ID
---@return number 章节完成进度，0-1之间
function Player:getDispatchChapterProgress(chapterId)
    local curCfg = Config.GetDispatchInfo(chapterId)
    if not curCfg then
        return 0
    end
    local lineCount = tablex.size(curCfg.lineGroup)
    local completeCount = 0
    local finishRouteList = self:getDispatchFinishRouteList()
    for _, line in pairs(curCfg.lineGroup) do
        local exist = tablex.find(finishRouteList, line)
        if exist then
            completeCount = completeCount + 1
        end
    end
    return completeCount / lineCount
end


--获取派遣点配置列表 通过路线id
---@param dispatchId integer 派遣id
---@param lineId integer 派遣路线ID
---@return DispatchPointTable[]|[] 派遣点配置列表
function Player:getDispatchPointCfgList(dispatchId, lineId)
    local dispatchCfg = Config.GetDispatchInfo(dispatchId)
    if not dispatchCfg then
        LuaLogger.e("getDispatchPointCfgList failed, no dispatchCfg")
        return {}
    end
    local pointIndex = 0
    for index, id in pairs(dispatchCfg.lineGroup) do
        if id == lineId then
            pointIndex = index
            break
        end
    end
    local pointGroupId = dispatchCfg.pointGroup[pointIndex]
    local pointList = Config.GetDispatchPointByGroup(pointGroupId)
    return pointList
end

--获取派遣路线推荐体力 通过路线id
---@param dispatchId integer 派遣id
---@param lineId integer 派遣路线ID
---@return integer 派遣路线推荐体力
function Player:getDispatchSuggestHp(dispatchId, lineId)
    local dispatchCfg = Config.GetDispatchInfo(dispatchId)
    if not dispatchCfg then
        LuaLogger.e("getDispatchSuggestHp failed, no dispatchCfg")
        return 0
    end
    local pointIndex = 0
    for index, id in pairs(dispatchCfg.lineGroup) do
        if id == lineId then
            pointIndex = index
            break
        end
    end
    if not dispatchCfg.suggestHp or not dispatchCfg.suggestHp[pointIndex] then
        LuaLogger.e("getDispatchSuggestHp failed, no suggestHp")
        return 0
    end
    return dispatchCfg.suggestHp[pointIndex]
end


--获取精力颜色和索引
---@param energy integer 精力
function Player:getDispatchEnergyIndexAndColor(energy)
    if not energy or energy < 0 then
        LuaLogger.e("getDispatchEnergyIndexAndColor failed, energy is nil or less than 0")
        return 3, "fd5252"  -- 默认红色
    end
    local cfg = Config.GetConfigInfo("DispatchEpColor")
    if energy < cfg[2] then
        return 3, "fd5252"
    elseif energy < cfg[1] then
        return 2, "fdc752"
    end
    return 1, "53ff6f"
    --self.msgNumTxt.text.color = 
end

--路线是否完成过
function Player:dispatchRouteIsFinish(routeId)
    local finishRouteList = self:getDispatchFinishRouteList()
    if tablex.find(finishRouteList, routeId) then
        return true
    end
    return false
end

return Player