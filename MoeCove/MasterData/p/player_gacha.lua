-- Desc: 玩家抽卡相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end

--最大抽卡记录数量
local maxNum = 1000
--三个月对应的秒数
local diffTime = 7776000

--获取卡池总数居
---@return GachaData 保底数据
function Player:getGachaData()
    return self.gachaData
end

--获取卡池保底数据
---@return table<integer, GachaCountInfo> 保底数据
function Player:getGachaCountData()
    local gachaData = self:getGachaData()
    if not gachaData.countMap then
        gachaData.countMap = {}
    end
    return gachaData.countMap
end

--根据保底id获取次数数据
---@param countGroupId integer 保底id
---@return GachaCountInfo 保底数据
function Player:getGachaCountDataById(countGroupId)
    local countMap = self:getGachaCountData()
    if not countMap[countGroupId] then
        countMap[countGroupId] = {
            num = 0,
            totalNum = 0,
        }
    end
    return countMap[countGroupId]
end

--根据卡池id获取保底数据
---@param poolId integer 卡池id
---@param countGroupId integer 计数组id
---@return integer 保底次数
function Player:getGachaGuarantCountById(poolId, countGroupId)
    local gachaData = self:getGachaData()
    if not gachaData.guarantMap then
        gachaData.guarantMap = {}
    end
    if not gachaData.guarantMap[poolId] then
        gachaData.guarantMap[poolId] = {
            data = {},
        }
    end
    if not gachaData.guarantMap[poolId].data[countGroupId] then
        gachaData.guarantMap[poolId].data[countGroupId] = 0
    end
    return gachaData.guarantMap[poolId].data[countGroupId]
end

--增加保底次数
---@param poolId integer 卡池id
---@param countGroupId integer 计数组id
function Player:addGachaGuarantCountById(poolId, countGroupId)
    local gachaData = self:getGachaData()
    if not gachaData.guarantMap then
        gachaData.guarantMap = {}
    end
    if not gachaData.guarantMap[poolId] then
        gachaData.guarantMap[poolId] = {
            data = {},
        }
    end
    if not gachaData.guarantMap[poolId].data[countGroupId] then
        gachaData.guarantMap[poolId].data[countGroupId] = 0
    end
    gachaData.guarantMap[poolId].data[countGroupId] = gachaData.guarantMap[poolId].data[countGroupId] + 1
end

--测试抽卡
---@param raffleId integer 卡池id
---@param count integer 抽取次数
---@return ActionFailReason 错误码
---@return RewardInfo[]? rewardList 奖励列表
function Player:testRaffle(raffleId, count)
    if GV.IsServer and GF.isReleaseVersions() then
        return ActionFailReason.Failed
    end

    local gachaCfg = Config.GetGachaPoolInfo(raffleId)
    if not gachaCfg then
        return ActionFailReason.CfgNotFind
    end

    --抽卡次数不能小于0
    if count <= 0 then
        return ActionFailReason.ParameterInvalid
    end

    --测试方法与正式方法共用核心逻辑
    local awardList = self:doRaffleByCount(gachaCfg, count)
    --测试方法仅返回数据，没有实际奖励
    local rewardList = {}
    local totalList = {}
    --整合奖励数据
    for _, reward in ipairs(awardList) do
        local rewardType = reward[1]
        local propId = reward[2]
        local addNum = reward[3]
        if not totalList[rewardType] then
            totalList[rewardType] = {}
        end
        if not totalList[rewardType][propId] then
            totalList[rewardType][propId] = {}
            totalList[rewardType][propId].num = 0
        end
        totalList[rewardType][propId].num = totalList[rewardType][propId].num + addNum
    end
    --将奖励数据处理为协议需要的结构
    for rewardType, typeDataList in pairs(totalList) do
        for propId, v in pairs(typeDataList) do
            table.insert(rewardList, {
                id = propId,
                type = rewardType,
                num = v.num,
            })
        end
    end

    --保底总数数据不记录
    local gachaCountMap = self:getGachaCountData()
    for _, guarantId in pairs(gachaCfg.countGroup or {}) do
        if not gachaCountMap[guarantId] then
            gachaCountMap[guarantId] = {
                num = 0,
                totalNum = 0,
            }
        end
        gachaCountMap[guarantId].totalNum = gachaCountMap[guarantId].totalNum - count
    end

    return ActionFailReason.None, rewardList
end

--奖池抽卡
---@param raffleId integer 卡池id
---@param count integer 抽取次数
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
---@return RewardInfo[]? rewardList 奖励列表
function Player:startRaffle(raffleId, count, proto)
    --功能开启检测 - 抽卡是否开启
    local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.Gacha)
    if isOpen == GE.FunctionOpenState.Lock then
        return ActionFailReason.FunctionOpenNotOpen
    end

    local gachaCfg = Config.GetGachaPoolInfo(raffleId)
    if not gachaCfg then
        return ActionFailReason.CfgNotFind
    end

    --抽卡次数只能为1或10
    if count ~= 1 and count ~= 10 then
        return ActionFailReason.ParameterInvalid
    end

    local curTime = luautil.getGmtStamp()
    --判断卡池是否开启
    if curTime < gachaCfg.startTime or (gachaCfg.endTime ~= 0 and curTime > gachaCfg.endTime) then
        return ActionFailReason.ActivityNotOpen
    end

    --判断抽卡卷是否足够
    if not self:checkItemEnough2({gachaCfg.cost, count}) then
        return ActionFailReason.ItemNoEnough
    end

    --抽奖
    local awardList = self:doRaffleByCount(gachaCfg, count)

    --扣除道具
    self:useItem(gachaCfg.cost, count, proto, GE.EventItemType.Summon, raffleId)

    --发送奖励
    local rewardList = self:addRewardList(awardList, proto, GE.EventItemType.Summon, raffleId)

    --记录抽卡信息
    self:setGachaRecordData(raffleId, rewardList, curTime, proto)
    local userData = self:getUserData()
    userData.TotalGachaNum = userData.TotalGachaNum + count

    if not proto.userData then
        proto.userData = {}
    end
    proto.userData.GetSSRNum = userData.GetSSRNum
    proto.userData.TotalGachaNum = userData.TotalGachaNum
    if not proto.gachaData then
        proto.gachaData = {}
    end
    proto.gachaData.countMap = self.gachaData.countMap
    proto.gachaData.guarantMap = self.gachaData.guarantMap

    self:missionTrigger(GE.MissionFinishType.DrawCardCount, {count = count}, proto, {})

    --记录日志
    if DataLogMgr then
        --保底数据
        local guaranteed = {SRNum = 0, SSRNum = 0,}
        local ssr = gachaCfg.countGroup[1]
        local sr = gachaCfg.countGroup[2]
        local ssrCfg, srCfg
 
        local guarantCount = self:getGachaGuarantCountById(gachaCfg.id, ssr)
        local guarantCfgList = Config.GetGachaGuarantInfoByPoolIdGroupId(gachaCfg.id, ssr)
        if guarantCfgList and next(guarantCfgList) then
            table.sort(guarantCfgList, function(a, b)
                return a.id < b.id
            end)
            for _, guarantCfg in pairs(guarantCfgList) do
                if guarantCfg.type == 1 and guarantCount < guarantCfg.num then
                    ssrCfg = guarantCfg
                    break
                elseif guarantCfg.type == 2 then
                    ssrCfg = guarantCfg
                end
            end
        end
        guarantCfgList = Config.GetGachaGuarantInfoByPoolIdGroupId(gachaCfg.id, sr)
        srCfg = guarantCfgList[1]


        local ssrInfo = self:getGachaCountDataById(ssr)
        local srInfo = self:getGachaCountDataById(sr)
        if srInfo then
            guaranteed.SRNum = srCfg.commonGuarant - srInfo.num
        end
        if ssrInfo then
            guaranteed.SSRNum = ssrCfg.commonGuarant - ssrInfo.num
        end

        -- LuaLogger.ds(">>>>抽卡日志<<<<", tablex.dump(guaranteed))
        DataLogMgr.LogSummon({
            summonPool = raffleId,
            summonTimes = count,
            summonResult = rewardList,
            guaranteed = guaranteed
        }, self)
    end

    return ActionFailReason.None, rewardList
end

--核心逻辑
---@param gachaCfg GachaPoolTable 对应卡池数据
---@param count integer 抽取次数
---@return integer[] 结果列表
function Player:doRaffleByCount(gachaCfg, count)
    --先抽取奖励类型，在抽取类型中的内容
    local awardData
    local awardList = {}
    for i = 1, count do
        local guarantId = self:isGachaGuarant(gachaCfg)--判断是否触发保底
        if not guarantId then--未触发保底
            guarantId = self:goOnceGacha(gachaCfg)
        end
        --LuaLogger.ds(">>>>>>保底id<<<<<<", guarantId)
        local guarantCfg = Config.GetGachaGuarantInfo(guarantId)
        awardData = self:getGachaReward(guarantCfg.gachaGroup)
        table.insert(awardList, awardData)
    end
    return awardList
end

--判断保底方法
---@param gachaCfg GachaPoolTable 对应卡池数据
---@return integer? 保底id
function Player:isGachaGuarant(gachaCfg)
    local thisTimeId    -- 如果多个保底同时满足条件，则按配置表顺序触发第一个保底
    for _, countGroupId in ipairs(gachaCfg.countGroup) do
        local countData = self:getGachaCountDataById(countGroupId)
        --次数加一
        countData.num = countData.num + 1
        countData.totalNum = countData.totalNum + 1
        if not thisTimeId then
            thisTimeId = self:getGachaGuarantIdByParam(gachaCfg, countGroupId, true)
        end
    end
    return thisTimeId
end

--根据卡池信息和计数组id获取保底id
---@param gachaCfg GachaPoolTable 对应卡池数据
---@param countGroupId integer 计数组id
---@param needCount boolean 是否需要次数判断
---@return integer? 保底id
function Player:getGachaGuarantIdByParam(gachaCfg, countGroupId, needCount)
    local thisTimeId
    --初始化
    local countData = self:getGachaCountDataById(countGroupId)
    local guarantCount = self:getGachaGuarantCountById(gachaCfg.id, countGroupId)
    --通过计数组id获取保底配置
    local nomalGuarantId
    local guarantCfgList = Config.GetGachaGuarantInfoByPoolIdGroupId(gachaCfg.id, countGroupId)
    if guarantCfgList and next(guarantCfgList) then
        --LuaLogger.ds(">>>>>>保底配置<<<<<<", tablex.dump(guarantCfgList))
        for _, guarantCfg in pairs(guarantCfgList) do
            if needCount then
                if guarantCfg.type == 1 and countData.num >= guarantCfg.commonGuarant and guarantCount < guarantCfg.num then
                    thisTimeId = guarantCfg.id
                    break
                elseif guarantCfg.type == 2 and countData.num >= guarantCfg.commonGuarant then
                    nomalGuarantId = guarantCfg.id
                end
            else
                if guarantCfg.type == 1 and guarantCount < guarantCfg.num then
                    thisTimeId = guarantCfg.id
                    break
                elseif guarantCfg.type == 2 then
                    nomalGuarantId = guarantCfg.id
                end
            end
        end
        if not thisTimeId then--没有特殊保底则进入普通保底
            thisTimeId = nomalGuarantId
        end
        if thisTimeId then--重置数据及保底计数
            local guarantCfg = Config.GetGachaGuarantInfo(thisTimeId)
            if guarantCfg.commonGuarant ~= 0 then
                self:resetGuarantNum(guarantCfg.countGroupID)
            end
            if guarantCfg.grandPrize == 1 then
                self:addGachaGuarantCountById(gachaCfg.id, guarantCfg.countGroupID)
            end
        end
    else
        LuaLogger.es("not guarantCfgList", gachaCfg.id, countGroupId)
    end
    return thisTimeId
end

--重置对应保底类型
---@param guarantId integer 保底id
function Player:resetGuarantNum(guarantId)
    local gachaCountInfo = self:getGachaCountDataById(guarantId)
    gachaCountInfo.num = 0
end

--一次抽卡
---@param gachaCfg GachaPoolTable 对应卡池数据
---@return integer 保底id
function Player:goOnceGacha(gachaCfg)
    local resultGroupId
    local needWeightMain = {}
    local poolContent = gachaCfg.content

    --获取本次权重内容
    needWeightMain = self:probabilityGrowth(poolContent, gachaCfg.incrementalRules)

    --抽取奖励组id
    local random = self:getRandom()
    resultGroupId = DLuaUtil.getRandomIndexLinear(needWeightMain, random)
    local guarantId = self:getGachaGuarantIdByParam(gachaCfg, resultGroupId, false)

    return guarantId
end

---@class GachaWeightData
---@field index integer 索引
---@field weight integer 权重
---@field isGrandPrize boolean  是否大奖

--大奖从配置次数概率递增
---@param poolContent table 奖池内容
---@param incrementalRules table 递增规则
---@return GachaWeightData[] 调整后的权重表
function Player:probabilityGrowth(poolContent, incrementalRules)
    ---@type  GachaWeightData[]
    local needWeightMain = {}
    local needGuarantId = incrementalRules[1]
    local needUpCount = incrementalRules[2]
    local upWeight = incrementalRules[3]
    local maxWeight = 0
    --整合所需奖励的权重数据
    for _, contentData in pairs(poolContent) do
        local guarantId = contentData[1]
        local awardWeight = contentData[2]
        maxWeight = math.max(maxWeight, awardWeight)
        table.insert(needWeightMain,{index = guarantId, weight = awardWeight})
    end
    --根据配置增减此次抽卡内容权重
    local nowGuarantCount = self:getGachaCountDataById(needGuarantId).num
    local addWeight = (nowGuarantCount - needUpCount + 1) * upWeight
    if nowGuarantCount >= needUpCount then
        for _,weightData in pairs(needWeightMain) do
            if weightData.weight == maxWeight then
                weightData.weight = weightData.weight - addWeight
            end
            if weightData.index == needGuarantId then
                weightData.weight = weightData.weight + addWeight
            end
        end
    end

    return needWeightMain
end

--从奖池中获取奖励
---@param awardGroupId integer 奖励组id
---@return integer[] 奖励数据
function Player:getGachaReward(awardGroupId)
    local rewardList = Config.GetGachaInfoByGroup(awardGroupId)
    if not rewardList then
        LuaLogger.es("not rewardList", awardGroupId)  
    end

    --整合奖池权重
    local rewardWeightMain = {}
    for _, rewardData in pairs(rewardList) do
        table.insert(rewardWeightMain,{index = rewardData.id, weight = rewardData.weight})
    end

    --从奖池中抽取一次
    local random = self:getRandom()
    local awardId = DLuaUtil.getRandomIndexLinear(rewardWeightMain, random)

    --根据抽奖奖励id获取奖励数据
    local awardData = Config.GetGachaInfo(awardId)
    if not awardData then
        LuaLogger.es("not awardData", awardId)
    else
        local resultData = {
            awardData.type,
            awardData.gachaid,
            awardData.num,
        }
        return resultData
    end

    return {}
end

--获取抽卡记录数据
---@return GachaRecordData 抽卡记录数据
function Player:getGachaRecordInfo()
    local gachaData = self:getGachaData()
    if not gachaData.recordData or tablex.next(gachaData.recordData) == nil then
        gachaData.recordData = {
            count = 0,
            pathkeyList = {},
            recordList = {},
        }
    end
    return gachaData.recordData
end

--记录抽卡信息
---@param raffleId integer 卡池id
---@param rewardList RewardInfo[]  奖励列表
---@param curTime integer 当前时间
---@param proto UserInfo 用户数据
function Player:setGachaRecordData(raffleId, rewardList, curTime, proto)
    local recordInfo = self:getGachaRecordInfo()
    --超过设置条目数则删除先前的
    local recordNum = tablex.size(recordInfo.recordList)
    local needDeleteNum = recordNum + tablex.size(rewardList) - maxNum
    if needDeleteNum > 0 then
        for i = 1, needDeleteNum do
            tablex.removeproxy(recordInfo.recordList, recordNum - i + 1)
        end
    end

    --新增条目
    local userData = self:getUserData()
    for _, rewardData in pairs(rewardList) do
        local newData = {
            raffleId = raffleId,
            type = rewardData.type,
            id = rewardData.id,
            gachaTime = curTime,
        }
        tablex.insertproxy(recordInfo.recordList, 1, newData)

        --记录SSR角色
        if rewardData.type == GE.RewardType.Character then
            local heroCfg = Config.GetCharacterInfo(rewardData.id)
            if not heroCfg then
                LuaLogger.es("not heroCfg", rewardData.id)
            else
                if heroCfg.rank >= GE.HeroRankStar.SSR then
                    userData.GetSSRNum = userData.GetSSRNum + 1
                end
            end
        end
    end

    --上传抽卡记录
    self:putGachaRecordList()

    if not proto.gachaData then
        proto.gachaData = {}
    end
    if not proto.gachaData.recordData then
        proto.gachaData.recordData = {}
    end
    proto.gachaData.recordData = recordInfo
    proto.gachaData = self:propToProto("gachaData", proto.gachaData)
end

--引导抽卡
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
---@return RewardInfo[]? rewardList 奖励列表
function Player:doGuideRaffle(proto)
    --检测是否获得过此次奖励
    local userData = self:getUserData()
    if userData.GotGuideGachaAward then
        return ActionFailReason.AwardAlready
    end

    local awardList = Config.GetConfigInfo("FirstGacha")
    local rewardList = self:addRewardList(awardList, proto, GE.EventItemType.Summon, 0)
    userData.GotGuideGachaAward = true
    if not proto.userData then
        proto.userData = {}
    end
    proto.userData.GotGuideGachaAward = userData.GotGuideGachaAward

    return ActionFailReason.None, rewardList
end

return Player