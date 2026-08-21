-- Desc: 家园相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end

-- Get homeland data
---@return HomeLandinfo
function Player:getHomeland()
    return self.homeland
end

--获取家园中随机生成的角色的状态
---@return integer[] 角色id列表
function Player:getRolePreRoom()
    local homeland = self:getHomeland()
    if not homeland.rolePreRoom then
        homeland.rolePreRoom = {}
    end
    return homeland.rolePreRoom
end

--获取家园功能建筑总数据
---@return HomeBuilding[] 功能建筑数据
function Player:getConstructionMapData()
    local homeland = self:getHomeland()
    if not homeland.buildingList then
        homeland.buildingList = {}
    end
    return homeland.buildingList
end

--获取单个功能建筑数据
---@param constructionId integer 建筑id
---@return HomeBuilding? 功能建筑数据
function Player:getConstructionDataById(constructionId)
    local buildingList = self:getConstructionMapData()
    return buildingList[constructionId]
end

--获取家园散步角色列表
---@return integer[]
function Player:getWalkHeroList()
    local homeland = self:getHomeland()
    if not homeland.homeWalkHeroList then
        homeland.homeWalkHeroList = {}
    end
    return homeland.homeWalkHeroList
end

-- 获得建筑等级
---@param constructionId integer
---@return integer
function Player:getBuildingLevel(constructionId)
    local consData = self:getConstructionDataById(constructionId)
    return consData and consData.level or 0
end

--判断includeBuild列表中是否已有任意建筑建成（等级>0即视为该繁荣建筑已建造）
---@param includeBuild table
---@return boolean
function Player:isAnyIncludeBuildConstructed(includeBuild)
    if not includeBuild then
        return false
    end
    for _, buildId in pairs(includeBuild) do
        local consId = tonumber(buildId)
        if consId and self:getBuildingLevel(consId) > 0 then
            return true
        end
    end
    return false
end

--获取家园建筑部署角色
---@param consId integer 建筑id
---@return integer[]? 角色idlist
function Player:getDisposeRole(consId)
    local consData = self:getConstructionDataById(consId)
    if consData and consData.disposeHeroList then
        return consData.disposeHeroList
    end
end

--获取家园建筑部署角色数量
---@param consId integer 建筑id
---@return integer
function Player:getDisposeRoleNum(consId)
    local num = 0
    local consData = self:getConstructionDataById(consId)
    if consData and consData.disposeHeroList then
        for _, id in pairs(consData.disposeHeroList) do
            if id ~= 0 then
                num = num + 1
            end
        end
    end
    return num
end

--前端随机的散步英雄同步
---@param heroIdList integer[] 角色id列表
---@param coustructList integer[] 角色对应的建筑id列表
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason
function Player:rolePreRoom(heroIdList, coustructList, proto)
    --功能说明：
    --随机散步由前端控制，服务端只做记录
    --散步英雄替换时，服务器及时替换了，但是前端依然要排队去表现散步

    --是否缺少参数
    if not heroIdList or not coustructList then
        return ActionFailReason.ParameterInvalid
    end
    --参数长度是否不一致
    if tablex.size(heroIdList) ~= tablex.size(coustructList) then
        return ActionFailReason.ParameterInvalid
    end
    --角色是否拥有
    local temp = {}
    local homeDisposeRoleList = self:getInHomeDisposeRole()
    for _, roleId in pairs(heroIdList) do
        if roleId ~= 0 then
            --检测角色是否重复
            if not temp[roleId] then
                temp[roleId] = roleId
            else
                return ActionFailReason.ParameterInvalid
            end
            local heroData = self:getPlayerHero(roleId)
            if heroData == nil then
                return ActionFailReason.HeroNoFind
            end

            --检测角色是否正在工作 只有排班的角色才是在工作中
            local wrokRoomId = self:GetHeroWorkingRoom(roleId)
            if wrokRoomId ~= 0 then
                return ActionFailReason.HeroInWork
            end
            --检测角色是否正在散步
            local walkStatus = tablex.contains(self:getWalkHeroList(), roleId)
            if walkStatus then
                return ActionFailReason.HeroInWalk
            end
        end
    end
    --区域是否正确
    for _, consId in pairs(coustructList) do
        local constructionConfig = Config.GetConstructionInfo(consId)
        if not constructionConfig or constructionConfig.isWork == 1 then
            return ActionFailReason.BuildingNotExist
        end
    end
    local delRoleList = {}
    for roleId, coustructId in pairs(self:getRolePreRoom()) do
        if tablex.find(heroIdList, roleId) == false then
            table.insert(delRoleList, roleId)

            --记录日志
            if DataLogMgr then
                DataLogMgr.LogHomeHeroInOut({
                    heroCid = roleId,
                    inOut = 2,
                    action = 1,
                    buildingCid = coustructId,
                }, self)
            end
        end
    end

    local homeland = self:getHomeland()
    homeland.rolePreRoom = {}
    for i = 1, tablex.size(heroIdList) do
        if not homeland.rolePreRoom[heroIdList[i]] then
            homeland.rolePreRoom[heroIdList[i]] = 0
        end
        homeland.rolePreRoom[heroIdList[i]] = coustructList[i]

        --记录日志
        if DataLogMgr then
            DataLogMgr.LogHomeHeroInOut({
                heroCid = heroIdList[i],
                inOut = 1,
                action = 1,
                buildingCid = coustructList[i],
            }, self)
        end
    end
    if proto then
        if not proto.homeland then
            proto.homeland = {}
        end
        proto.homeland.rolePreRoom = homeland.rolePreRoom
    end
    self:roomListUpdateHeroInfo(proto, delRoleList)

    return ActionFailReason.None
end

--设置家园建筑部署角色
---@param constructionId integer 建筑id
---@param heroIdList integer[] 角色idlist
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason
function Player:setDisposeRole(constructionId, heroIdList, proto)
    if not heroIdList or not constructionId then
        return ActionFailReason.LackParameter
    end
    local buildingInfo = self:getConstructionDataById(constructionId)
    if not buildingInfo then
        return ActionFailReason.BuildingNotExist
    end

    local constructionCfg = Config.GetConstructionInfo(constructionId)
    if not constructionCfg or constructionCfg.isWork ~= 1 then
        return ActionFailReason.BuildingNotExist
    end

    if constructionId == GE.CoustructionEnum.PatrolRoom then
        local maxCount = self:getBuildAddPatrolRoleCount()
        if maxCount == 0 then
           return ActionFailReason.ParameterInvalid
        end
        --只取前N个部署位置
        heroIdList = tablex.slice(heroIdList, 1, maxCount)
    else
        local constructLvCfg = Config.GetConstructionLevelInfoByTypeLevel(constructionId, buildingInfo.level)
        if not constructLvCfg then
            return ActionFailReason.BuildingNotExist
        end
        local unlockList = {}
        for _, ef in pairs(constructLvCfg.effect) do
            if ef[1] == GE.HomeBuildEffectType.UnlockPos then
                unlockList = tablex.copy(ef) --解锁的角色位置
            end
        end
        table.remove(unlockList, 1) --移除第一个元素
        for i = 1, #heroIdList do
            local id = heroIdList[i]
            if id ~= 0 then
                local index = tablex.indexof(unlockList, i)
                if index == -1 then
                    return ActionFailReason.ParameterInvalid
                end
            end
        end
    end

    --只取前N个部署位置
    heroIdList = tablex.slice(heroIdList, 1, constructionCfg.workChara)

    -- --检测部署数量是否超出限制
    -- if tablex.size(heroIdList) > constructionCfg.workChara then
    --     return ActionFailReason.HomeWalkMax
    -- end

    --角色是否拥有
    local temp = {}
    for _, roleId in pairs(heroIdList) do
        if roleId ~= 0 then
            --检测角色是否重复
            if not temp[roleId] then
                temp[roleId] = roleId
            else
                return ActionFailReason.ParameterInvalid
            end
            local heroData = self:getPlayerHero(roleId)
            if heroData == nil then
                return ActionFailReason.HeroNoFind
            end
        end
    end

    buildingInfo.disposeHeroList = heroIdList
    --清除其他建筑中已部署的当前角色
    local idList = {}
    for _, roleId in pairs(heroIdList) do
        if roleId ~= 0 then
            table.insert(idList, roleId)
            -- 如果该角色正在散步，移除散步信息
            self:removeWalkHero(roleId, proto)
        end
    end
    for bulidId, consData in pairs(self:getConstructionMapData()) do
        if bulidId ~= constructionId and consData.disposeHeroList then
            for k, id in pairs(consData.disposeHeroList) do
                if tablex.find(idList, id) then
                    --如果当前角色在其他建筑中部署了，则清除该角色的部署信息
                    consData.disposeHeroList[k] = 0
                end
            end
        end
    end
    if proto then
        if not proto.homeland then
            proto.homeland = {}
        end
        proto.homeland.buildingList = self:getConstructionMapData()
    end

    --记录日志
    if DataLogMgr then
        for _, roleId in pairs(heroIdList) do
            DataLogMgr.LogHomeHeroInOut({
                heroCid = roleId,
                inOut = 1,
                action = 2,
                buildingCid = constructionId,
            }, self)
        end
    end
    return ActionFailReason.None
end

---@param homeDisposesHero SetHomeDisposeHeroReq[]
function Player:setDisposesRole(homeDisposesHero, proto)
    if not homeDisposesHero or tablex.size(homeDisposesHero) == 0 then
        return ActionFailReason.LackParameter
    end
    local size = tablex.size(homeDisposesHero)
    for i = 1, size do
        local temp = homeDisposesHero[i]
        if temp == nil then
           break 
        end
        local res = self:setDisposeRole(temp.constructionId, temp.heroIdList, proto)
        if res ~= ActionFailReason.None then
           return res 
        end
    end
    return ActionFailReason.None
end



--家园建筑升级
---@param constructId integer 建筑id
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason
function Player:homeBuildingLvUp(constructId, proto)
    if not constructId then
        return ActionFailReason.LackParameter
    end
    local consData = self:getConstructionDataById(constructId)
    if not consData then
        return ActionFailReason.BuildingNotExist
    end
    local maxLv = self:getHomeBuildingMaxLevel(constructId)
    if consData.level >= maxLv then
        return ActionFailReason.BuildingMaxLevel
    end
    local constructLvCfg = Config.GetConstructionLevelInfoByTypeLevel(constructId, consData.level + 1)
    if not constructLvCfg then
        return ActionFailReason.BuildingMaxLevel
    end
    if not self:canOpenFunctionByCfg(constructLvCfg.restrain) then
        return ActionFailReason.BuildingCanNotLevelUp
    end
    --检测升级所需资源
    local itemList = {}
    for _, v in pairs(constructLvCfg.cost) do
        table.insert(itemList, {
            id = v[2],
            num = v[3],
            type = v[1]
        })
    end
    if next(constructLvCfg.costResource) then
        table.insert(itemList, {
            id = constructLvCfg.costResource[2],
                num = constructLvCfg.costResource[3],
                type = constructLvCfg.costResource[1]
            })
    end
    if not self:checkItemListEnough(itemList) then
        return ActionFailReason.ItemNoEnough
    end
    for _, v in pairs(itemList) do
        --扣除资源
        self:useItem(v.id, v.num, proto, GE.EventItemType.HomeLvUp, constructId)
    end
    for _, v in pairs(constructLvCfg.effect) do
        --扣除资源
        if v[1] == GE.HomeBuildEffectType.UnlockWeaponPaper then
            self:addItem(v[2], 1, proto, GE.EventItemType.HomeLvUp, constructId)
        end
    end
    consData.level = consData.level + 1


    --添加升级奖励  TODO
    ---@type ConstructionLevelTable
    local cfg = constructLvCfg
    if cfg.upgradeReward ~= nil then
        local outPut = consData.output
        if outPut == nil then
           consData.output = {}
           outPut = consData.output 
        end

        for i = 1, #cfg.upgradeReward do
            local reward = cfg.upgradeReward[i]
            local type = reward[1]
            local id = reward[2]
            local num = reward[3]
            local o = tablex.findSingle(outPut, function(data)
                return data.id == id and data.type == type
            end)
            if o ~= nil then
               o.num = o.num + num
            else
                local d = {
                    id = id,
                    type = type,
                    num = num
                }
                tablex.insertproxy(outPut, d)
            end
        end 
    end
    proto.homeland = self:getHomeland()

    --建筑升级繁荣度行为渠道埋点
    if constructLvCfg.upProsperity then
        local prosperityAdd = constructLvCfg.upProsperity[3]
        if prosperityAdd and prosperityAdd > 0 then
            self:addProsperity(prosperityAdd, GE.ProsperityChannel.Item, proto)
        end
    end

    self:missionTrigger(GE.MissionFinishType.UpgradeHomeBuildingToLevel, {buildingId = constructId, level = consData.level}, proto) --触发任务系统的建筑升级计数
    self:missionTrigger(GE.MissionFinishType.MultiHomeBuildingReachLevel, {buildingId = constructId, level = consData.level}, proto) --触发多个建筑等级任务计数
    self:missionLockUpdate(GE.MissionUnLockType.HomeLandBuildLevel, proto) -- 建筑升级触发任务解锁检测
    self:FunctionOpenTrigger(GE.CommonLockJudgeType.BulidLevel, proto) -- 关卡完成触发功能开放

    --流水日志
    if DataLogMgr then
        DataLogMgr.LogHomeBuildingUp({
            buildingCid = constructId,
            afterLevel = consData.level,
        }, self)
    end
    return ActionFailReason.None
    --扣除资源
end

---@class HomeSignalInfo
---@field roleId integer 角色id
---@field signalId integer 词条id

--获取家园建筑已装配的词条
---@param consId integer 建筑id
---@return HomeSignalInfo[]
function Player:getHomeSignal(consId)
    local temp = {}
    --建筑部署的角色
    local disposeRoleList = self:getDisposeRole(consId)
    if not disposeRoleList then
        return temp
    end
    --建筑生效的tag类型
    local tagTypeList = Config.GetConstructionInfoTagType(consId)
    for index, roleId in ipairs(disposeRoleList) do
        local tagType = tagTypeList
        if consId == GE.CoustructionEnum.CommandRoom then
            tagType = {tagTypeList[index]}
        end
        if roleId ~= 0 then
            local roleTagList = self:getHeroTagList(roleId)
            if roleTagList and tablex.size(roleTagList) > 0 then
                for _, tagId in pairs(roleTagList) do
                    ---@type SignalTable
                    local tagData = Config.SignalInfo(tagId)
                    if tagData.type == GE.TagType.dwelling and tablex.size(tagData.effect) > 0 then
                        local has = tablex.indexof(tagType, tagData.useType) > 0
                        if has then
                            ---@type HomeSignalInfo
                            local data = {
                                roleId = roleId,
                                signalId = tagId
                            }
                            table.insert(temp, data)
                        end
                    end
                end
            end
        end
    end
    return temp
end

--获取家园部署中的角色
function Player:getInHomeDisposeRole()
    local roleList = {}
    local consMap = self:getConstructionMapData()
    if not consMap then
        return roleList
    end
    for _, consData in pairs(consMap) do
        if consData.disposeHeroList then
            for _, roleId in pairs(consData.disposeHeroList) do
                if roleId ~= 0 and not tablex.find(roleList, roleId) then
                    table.insert(roleList, roleId)
                end
            end
        end
    end
    return roleList
end

--获取单个功能建筑数据的资源储备
---@param constructionId integer 建筑id
---@param itemId integer 道具id
---@return integer
function Player:getConstructionOutput(constructionId, itemId)
    local outputList = self:getConstructionDataById(constructionId)
    if not outputList then
        return 0
    end
    outputList = outputList.output
    for k, v in pairs(outputList) do
        if v.id == itemId then
            return v.num
        end
    end
    return 0
end

--检测产出建筑是否到达上限 建筑有多个产出
---@param constructionId integer 建筑id
---@param needAll boolean 是否需要全部达到上限
---@return boolean
function Player:checkConstructionFull(constructionId, needAll)
    local efficiency = self:getHomeOutputEfficiency(constructionId)
    local fullNum = 0   --上限数量
    for _, efficiencyDetail in pairs(efficiency) do
        local max = efficiencyDetail[4]
        local itemId = efficiencyDetail[2]
        local existNum = self:getConstructionOutput(constructionId, itemId)
        if existNum >= max then
            fullNum = fullNum + 1
        end
    end
    if needAll then
        return tablex.size(efficiency) == fullNum
    else
        return fullNum > 0
    end
end

--设置功能建筑数据的资源储备
---@param constructionId integer 建筑id
---@param itemId integer 道具id
---@param num integer 数量
function Player:setConstructionOutput(constructionId, itemId, num)
    local outputList = self:getConstructionDataById(constructionId)
    if not outputList then
        return
    end
    outputList = outputList.output
    --已有数据赋值
    for k, v in pairs(outputList) do
        if v.id == itemId then
            v.num = num
            return
        end
    end
    --初始化数据
    local temp = {
        id = itemId,
        num = num,
        type = GE.RewardType.ItemProp
    }
    tablex.insertproxy(outputList, temp)
end

--初始化建筑数据
function Player:initHomelandWorkArea()
    local buildingList = self:getConstructionMapData()
    local constructionCfgList = Config.GetAllConfig("ConstructionTable")
    for id, cfg in pairs(constructionCfgList) do
        if not buildingList[id] then
            local disposeHeroList = {}
            for i = 1, cfg.workChara do
                tablex.insertproxy(disposeHeroList, 0)
            end
            local lv = cfg.minLv or 0
            buildingList[id] = {
                id = id,
                lastGenTime = DLuaUtil.GetGreenwichTime(),--测试逻辑默认开启
                level = lv,
                output = {},
                disposeHeroList = disposeHeroList
            }
        end
    end
end

--计算所有功能建筑收益
---@param proto UserInfo 玩家信息差量更新结构
function Player:getConstructionReward(proto)
    local isChanged = false
    local nowTime = DLuaUtil.GetGreenwichTime()
    local consMap = self:getConstructionMapData()
    for consId, consData in pairs(consMap) do
        local consConfig = Config.GetConstructionInfo(consId)
        --产出建筑
        if consConfig.workType == GE.HomeLandWorkType.Resource then
            local diffTime = nowTime - consData.lastGenTime
            local refreshTime = Config.GetConfigInfo("constructionRate") --间隔时间 半小时刷新一次
            local passedPeriod = math.floor(diffTime / refreshTime)      --过去的周期数
            --生产时间满足 计算资源增加
            if passedPeriod > 0 then
                local effectTime = passedPeriod * refreshTime       --资源产出生效时间 s
                local efficiency = self:getHomeOutputEfficiency(consId)   --计算建筑资源产出效率
                --每个产出单独计算（效率 上限）
                for _, efficiencyDetail in pairs(efficiency) do
                    local max = efficiencyDetail[4]
                    local speed = efficiencyDetail[3]
                    local itemId = efficiencyDetail[2]
                    --产生资源数量
                    local newResourceNum = math.floor(effectTime / 3600 * speed)  --生产速度单位是xxx/小时
                    --已有资源数量
                    local existResourceNum = math.floor(self:getConstructionOutput(consId, itemId))
                    --判断资源是否已经到达上限
                    if existResourceNum >= max then
                        --到达上限不做处理
                    else
                        local finalNum = (newResourceNum + existResourceNum) >= max and max or (newResourceNum + existResourceNum)
                        isChanged = true
                        self:setConstructionOutput(consId, itemId, finalNum)
                    end
                end
                --刷新时间
                consData.lastGenTime = consData.lastGenTime + effectTime
            end
        end
    end
    if isChanged then
        --全量推送
        if not proto.homeland then
            proto.homeland = {}
        end
        proto.homeland.buildingList = self:getConstructionMapData()
        proto.homeland = self:propToProto("homeland")
    end
end

---获取家园纯产出建筑基础效率
---@param consId integer 建筑id
---@param useLevel integer? 建筑等级 可选 不传则取当前等级
---@return integer[][] 资源产出效率表
function Player:getHomeOutputBaseEfficiency(consId, useLevel)
    local efficiency = {}
    local consData = self:getConstructionDataById(consId)
    if not consData then
        return efficiency
    end
    local level = consData.level
    if useLevel then
        level = useLevel
    end
    local cfg = Config.GetConstructionLevelInfoByTypeLevel(consId, level)
    if cfg then
        for _, v in pairs(cfg.effect) do
            if v[1] == GE.HomeBuildEffectType.Produce then
                table.insert(efficiency, tablex.clone(v))
            end
        end
    end
    return efficiency
end

--根据建筑id获取资源产出效率(带加成)
---@param consId integer 建筑id
---@return integer[][] 资源产出效率表
function Player:getHomeOutputEfficiency(consId)
    local workLowerLimit = Config.GetConfigInfo("workLowerLimit")
    local efficiency = self:getHomeOutputBaseEfficiency(consId)
    local addList = {}
    ---@type HomeSignalInfo[]
    local signalList = self:getHomeSignal(consId)
    if signalList and tablex.size(signalList) then
        for _, signalInfo in pairs(signalList) do
            ---@type SignalTable
            local tagData = Config.SignalInfo(signalInfo.signalId)
            --产量加成
            if tagData.effect[1] == GE.TagEffectType.buildGainUp then
                if not addList[tagData.effect[2]] then
                    addList[tagData.effect[2]] = tagData.effect[3]
                else
                    addList[tagData.effect[2]] = tagData.effect[3] + addList[tagData.effect[2]]
                end
            end
        end
    end

    local upCfgList = self:getTechTreeHomeUp()
    for _, effect in pairs(upCfgList) do
        if effect[1] == GE.TechTreeHomeUpType.OutPut then
            if not addList[effect[2]] then
                addList[effect[2]] = effect[3]
            else
                addList[effect[2]] = effect[3] + addList[effect[2]]
            end
        end
    end

    local roleCount = self:getDisposeRoleNum(consId)
    for _, effect in pairs(efficiency) do
        if addList[effect[2]] then
            effect[3] = effect[3] * (1 + (addList[effect[2]] + roleCount * workLowerLimit ) / 100)
        else
            effect[3] = effect[3] * (1 + roleCount * workLowerLimit / 100)
        end
    end
    return efficiency
end

--领取家园建筑奖励
---@param constructionId integer 建筑id
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason, integer[]? 奖励列表
function Player:getBuildingReward(constructionId, proto)
    if not constructionId then
        return ActionFailReason.LackParameter
    end
    local consData = self:getConstructionDataById(constructionId)
    --检测建筑是否存在
    if not consData then
        return ActionFailReason.BuildingNotExist
    end
    local output = consData.output
    local rewardList = {}
    --2025/2/11 目前没有设置道具上限需求 默认全领
    for k, v in pairs(output) do
        if v.num > 0 then
            local existNum = v.num --可领取数量
            local GetNum = self:calGetNum(v.id, existNum)
            local remainNum = existNum - GetNum
            --同步扣除
            self:setConstructionOutput(constructionId, v.id, remainNum)
            local tempReward = self:addRewardList({{v.type, v.id, GetNum}}, proto, GE.EventItemType.HomeBuilding, constructionId)
            rewardList = tablex.combine(rewardList, tempReward)
            self:missionTrigger(GE.MissionFinishType.CollectSpecificResourceCount, {resourceId = v.id, count = GetNum}, proto) --触发任务系统的道具获取计数
        end
    end
    if tablex.size(rewardList) == 0 then
        return ActionFailReason.BuildingNoOutput
    end

    --全满的情况下领取奖励需要重置倒计时
    if self:checkConstructionFull(constructionId, true) then
        consData.lastGenTime = DLuaUtil.GetGreenwichTime()
    end

    if proto then
        if not proto.homeland then
            proto.homeland = {}
        end
        proto.homeland.buildingList = self:getConstructionMapData()
    end
    return ActionFailReason.None, rewardList
end



--领取家园建筑奖励
---@param consIds integer[] 建筑id
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason, integer[]? 奖励列表
function Player:getBuildingsReward(consIds, proto)
    if consIds == nil or tablex.size(consIds) == 0 then
        return ActionFailReason.LackParameter
    end

    local rls = {}
    for i = 1, tablex.size(consIds) do
        local id = consIds[i]
        local res, rewardList = self:getBuildingReward(id, proto)
        for j = 1, tablex.size(rewardList) do
            local type = rewardList[j][1]
            local id = rewardList[j][2]
            local num = rewardList[j][3]
            local r = tablex.findSingle(rls, function(rl)
                return type == rl[1] and id == rl[2]
            end)
            if r ~= nil then
               r[3] = r[3] + num
            else
                table.insert(rls, rewardList[j]) 
            end
        end
    end

    if tablex.size(rls) == 0 then
        return ActionFailReason.BuildingNoOutput
    end
    return ActionFailReason.None, rls
end

--计算可领取的数量
---@param id integer 道具id
---@param existNum integer 道具已有数量
---@return integer
function Player:calGetNum(id, existNum)
    --目前道具没有上限的需求
    return existNum
end

--设置家园散步角色列表
---@param heroIdList integer[] 角色id列表 0表示随机
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason
function Player:setHomeWalkHero(heroIdList, proto)
    if not heroIdList then
        return ActionFailReason.LackParameter
    end

	if self:getFunctionOpenStateById(GE.FunctionOpenModule.HomeWalk) == GE.FunctionOpenState.Lock then
		return ActionFailReason.FunctionOpenNotOpen
	end

    --角色是否全部拥有，0表示随机不做判断
    local temp = {}
    local homeDisposeRoleList = self:getInHomeDisposeRole()
    for _, roleId in pairs(heroIdList) do
        if roleId ~= 0 and roleId ~= -1 then
            --检测角色是否重复
            if not temp[roleId] then
                temp[roleId] = roleId
            else
                return ActionFailReason.ParameterInvalid
            end
            local heroData = self:getPlayerHero(roleId)
            if heroData == nil then
                return ActionFailReason.HeroNoFind
            end
            local workStatus = tablex.find(homeDisposeRoleList, roleId)
            if workStatus then
                return ActionFailReason.HeroInWork
            end
        end
    end

    --判断是否超过最大数量
    local maxCount = Config.GetConfigInfo("homeCharacterShowBase") + self:getBuildAddWalkRoleCount()

    local count = 0
    for k, v in pairs(heroIdList) do
        if v ~= nil and v ~= -1 then
            count = count + 1 
        end
    end

    if count > maxCount then
        return ActionFailReason.HomeWalkMax
    end

    --设置家园散步角色列表
    local homeland = self:getHomeland()
    homeland.homeWalkHeroList = {}
    for _, roleId in pairs(heroIdList) do
        tablex.insertproxy(homeland.homeWalkHeroList, roleId)
        --记录日志
        if DataLogMgr then
            DataLogMgr.LogHomeHeroInOut({
                heroCid = roleId,
                inOut = 1,
                action = 3,
                buildingCid = 0,
            }, self)
        end
    end
    -- LuaLogger.ds("setHomeWalkHero  heroIdList:" .. tablex.dump(heroIdList) .. " homeland.homeWalkHeroList:" .. tablex.dump(homeland.homeWalkHeroList))
    if proto then
        if proto.homeland == nil then
            proto.homeland = {}
        end
        proto.homeland.homeWalkHeroList = homeland.homeWalkHeroList
    end
    return ActionFailReason.None
end

--查找并移除正在散步的角色
---@param roleId integer 角色id
---@param proto UserInfo 玩家信息差量更新结构
function Player:removeWalkHero(roleId, proto)
    local homeWalkHeroList = self:getWalkHeroList()
    for i = tablex.size(homeWalkHeroList), 1, -1 do
        if homeWalkHeroList[i] == roleId then
            local heroData = self:getPlayerHero(roleId)
            if heroData then
                heroData.affectionEvent = 0
            end
            if proto ~= nil then
                if proto.heroList == nil then
                    proto.heroList = {}
                end
                proto.heroList[roleId] = heroData
            end
            tablex.removeproxy(homeWalkHeroList, i)
        end
    end
end

--获取家园中随机生成的角色和手动设置散步角色的列表
function Player:getRandomAndSetWalkRoleList()
    local roleList = {}
    --获取家园中随机生成的角色
    local rolePreRoom = self:getRolePreRoom()
    for k, v in pairs(rolePreRoom) do
        table.insert(roleList, k)
    end
    --获取手动设置的散步角色
    local walkHeroList = self:getWalkHeroList()
    for _, v in pairs(walkHeroList) do
        if v ~= 0 and not tablex.contains(roleList, v) then
            table.insert(roleList, v)
        end
    end
    return roleList
end

--获取家园建筑最大等级
---@param constructId integer 建筑id
---@return integer 最大等级
function Player:getHomeBuildingMaxLevel(constructId)
    local maxLevel = 0
    local cfg = Config.GetConstructionLevelInfoByType(constructId)
    if not cfg then
        return maxLevel
    end
    return tablex.size(cfg) - 1
end

--一键收集家园资源：建筑产出 + 离线收益
--注意：离线收益领取前会先刷新大池子（UpdateHomelandStorageItemData），属于前置步骤
---@param proto UserInfo 差量更新结构
---@return ActionFailReason, integer[][] 合并后的全部奖励
function Player:oneKeyCollectHomelandResource(proto)
    local rewardList = {}
    local function mergeReward(reward)
        if not reward then
            return
        end
        local rewardType = reward[1] or reward.type
        local rewardId = reward[2] or reward.id
        local rewardNum = reward[3] or reward.num or 0
        if not rewardType or not rewardId or rewardNum <= 0 then
            return
        end
        local existed = tablex.findSingle(rewardList, function(v)
            return rewardType == v.type and rewardId == v.id
        end)
        if existed then
            existed.num = existed.num + rewardNum
        else
            table.insert(rewardList, {
                type = rewardType,
                id = rewardId,
                num = rewardNum
            })
        end
    end

    -- 步骤1：刷新建筑产出倒计时（确保积累的产出被计入 output）
    self:getConstructionReward(proto)

    -- 步骤2：按繁荣建筑配置筛选可领取建筑产出
    -- output = 1: 单建筑产出；output = 2: 建筑群产出（从includeBuild展开）
    local collectConsIdMap = {}
    local collectConsIds = {}
    local prosperityConstructionCfg = Config.GetAllConfig("ProsperityConstructionTable") or {}
    for _, cfg in pairs(prosperityConstructionCfg) do
        local outputType = cfg.output or 0
        if outputType == 1 or outputType == 2 then
            local includeBuild = cfg.includeBuild or {}
            for _, buildId in pairs(includeBuild) do
                local consId = buildId
                if consId and not collectConsIdMap[consId] then
                    collectConsIdMap[consId] = true
                    table.insert(collectConsIds, consId)
                end
            end
        end
    end
    for _, consId in pairs(collectConsIds) do
        local ret, buildingRewards = self:getBuildingReward(consId, proto)
        if ret == ActionFailReason.BuildingNoOutput then
            -- 单建筑无产出是正常情况，继续处理
        elseif ret ~= ActionFailReason.None then
            return ret, rewardList
        elseif buildingRewards then
            for _, v in pairs(buildingRewards) do
                mergeReward(v)
            end
        end
    end

    -- 步骤3：刷新大池子（离线收益前置）
    self:UpdateHomelandStorageItemData(false, proto)

    -- 步骤4：领取离线收益
    local earningsRewards = self:GetHomelandEarningsItems(proto)
    if earningsRewards then
        for _, v in pairs(earningsRewards) do
            mergeReward(v)
        end
    end

    return ActionFailReason.None, rewardList
end


------------------------------------client------------------------------------
--获取巡逻列表
---@return integer[]
function Player:getPatrolHeroList()

    local buildId = GE.CoustructionEnum.PatrolRoom
    ---@type HomeBuilding
    local tab = self:getConstructionDataById(buildId)
    if tab == nil then
       return {} 
    end
    return tab.disposeHeroList or {}
end

---获得英雄房间id
function Player:GetHeroRoomId(heroId)
    local consMap = self:getConstructionMapData()
    if not consMap then
        return 0
    end
    for _, consData in pairs(consMap) do
        if consData.disposeHeroList then
            if tablex.find(consData.disposeHeroList, heroId) then
                return consData.id
            end
        end
    end
    return 0
end

--角色是否处于家园部署中
---@param roleId integer 角色id
---@return boolean
function Player:roleInHomeDispose(roleId)
    local consMap = self:getConstructionMapData()
    if not consMap then
        return false
    end
    for _, consData in pairs(consMap) do
        if consData.disposeHeroList then
            if tablex.find(consData.disposeHeroList, roleId) then
                return true
            end
        end
    end
    return false
end

--根据建筑id和道具id 获取单个资源产出效率
---@param consId integer 建筑id
---@param itemId integer 道具id
---@return integer[]? 资源产出效率
function Player:getEfficiencyByIdAndItemId(consId, itemId)
    local efficiency = self:getHomeOutputEfficiency(consId)
    for k, v in pairs(efficiency) do
        if v[2] == itemId then
            return v
        end
    end
    return nil
end

--更新家园数据 前端用
function Player:updateHomelandData(data)
    local homeland = self:getHomeland()
    for k, v in pairs(data) do
        if k == "buildingList" then
            for buildId, buildData in pairs(v) do
                homeland.buildingList[buildId] = buildData
            end
        elseif k == "coveProps" then
            homeland.coveProps = homeland.coveProps or {}
            DLuaUtil.UpdateTable(homeland.coveProps, v)
        elseif k == "coveBattleData" then
            homeland.coveBattleData = homeland.coveBattleData or {}
            DLuaUtil.UpdateTable(homeland.coveBattleData, v)
            GameMsgMgr:sendEvent(GameMsgType.HomeLandCoveBattleDataChange, v)
        else
            homeland[k] = v
        end
    end
end

---@param effectType integer
---@param effectType integer 3散步 4巡逻
---@return integer addCount 增加的人数
function Player:getBuildAddRoleCount(effectType)
    local buildList = self:getHomeland().buildingList
    local addCount = 0
    for k, v in pairs(buildList) do
        ---@type ConstructionLevelTable
        local cfg = Config.GetConstructionLevelInfoByTypeLevel(v.id, v.level)
        if cfg ~= nil and cfg.effect ~= nil then
            for k, v in pairs(cfg.effect) do
                if v[1] == effectType then
                    addCount = addCount + v[2]
                end
            end
        end
    end
    return addCount
end

--获得最大散步人数
---@param effectType integer 3散步 4巡逻
---@return integer
function Player:getBuildMaxRoleCount(effectType)
    local addCount = 0
    ---@type table<integer, ConstructionLevelTable>
    local cfgs = Config.GetAllConfig("ConstructionLevelTable")
    ---@type table<integer, integer>
    local a = {}
    for k, v in pairs(cfgs) do
        if v.effect == nil then
           goto continue 
        end
        local e = tablex.findSingle(v.effect, function(effect)
            return effect ~= nil and effect[1] == effectType
        end)
        if e ~= nil then
            local val = a[v.type] or 0
            val = math.max(val, e[2])
            a[v.type] = val
        end
        ::continue::
    end
    for k, v in pairs(a) do
        addCount = addCount + v
    end
    return addCount
end



---获得槽位解锁信息 对于ConstructionLevelTable的id
---@param effectType integer 3散步 4巡逻
---@return integer[]
function Player:getRoleUnlockInfo(effectType)

    ---@type table<integer, ConstructionLevelTable>
    local cfgs = Config.GetAllConfig("ConstructionLevelTable")

    ---@type ConstructionLevelTable[]
    local unlockCfgs = {}

    for k, v in pairs(cfgs) do
        if v.effect == nil then
           goto continue 
        end
        local e = tablex.findSingle(v.effect, function(effect)
            return effect ~= nil and effect[1] == effectType
        end)
        if e ~= nil then
            table.insert(unlockCfgs, v)
        end
        ::continue::
    end
   
    table.sort(unlockCfgs, function (a, b)
        local sa = self:getConstructionDataById(a.type)
        local sb = self:getConstructionDataById(b.type)
        local isunlocka = sa ~= nil and sa.level >= a.level
        local isunlockb = sb ~= nil and sb.level >= b.level
        if isunlocka ~= isunlockb then
            return isunlocka
        end
        if a.type ~= b.type then
           return a.type > b.type 
        end
        if a.level ~= b.level then
           return a.level > b.level 
        end
        return a.id > b.id
    end)
    if unlockCfgs == nil or #unlockCfgs == 0 then
       return {} 
    end
    local a = {}
    local lastId = unlockCfgs[1].type
    local startIndex = 0
    for i = 1, #unlockCfgs do
        local cfg = unlockCfgs[i]
        if lastId ~= cfg.type then
            lastId = cfg.type
            startIndex = #a
        end
        local e = tablex.findSingle(cfg.effect, function(effect)
            return effect ~= nil and effect[1] == effectType
        end)
        local unlockCount = e[2]
        for j = 1, unlockCount do
            a[j + startIndex] = cfg.id
        end
    end
    return a
end



---获取建筑增加散步角色数量
---@return integer
function Player:getBuildAddWalkRoleCount()
    return self:getBuildAddRoleCount(GE.ConstructionLevelEffectType.UnlockPos_Walk)
end

--获得最大散步人数
---@return integer
function Player:getMaxWalkRoleCount()
    local addCount = self:getBuildMaxRoleCount(GE.ConstructionLevelEffectType.UnlockPos_Walk)
    local baseCount = Config.GetConfigInfo("homeCharacterShowBase")
    return baseCount + addCount
end

---获得散步槽位解锁信息 对于ConstructionLevelTable的id
---@return integer[]
function Player:getWalkRoleUnlockInfo()
    return self:getRoleUnlockInfo(GE.ConstructionLevelEffectType.UnlockPos_Walk)
end


---获取建筑增加巡逻角色数量
---@return integer
function Player:getBuildAddPatrolRoleCount()
    return self:getBuildAddRoleCount(GE.ConstructionLevelEffectType.UnlockPos_Patrol)
end

--获得最大巡逻人数
---@return integer
function Player:getMaxPatrolRoleCount()
    local addCount = self:getBuildMaxRoleCount(GE.ConstructionLevelEffectType.UnlockPos_Patrol)
    return addCount
end

---获得巡逻槽位解锁信息 对于ConstructionLevelTable的id
---@return integer[]
function Player:getPatrolRoleUnlockInfo()
    return self:getRoleUnlockInfo(GE.ConstructionLevelEffectType.UnlockPos_Patrol)
end

--获取繁荣度数据
---@return ProsperityInfo
function Player:getProsperityInfo()
    local homeland = self:getHomeland()
    if not homeland.prosperityInfo then
        homeland.prosperityInfo = {
            currentLevel = 0,
            dailyProsperityCount = 0,
            globalConditionProgress = {},
        }
    end
    return homeland.prosperityInfo
end

--重置繁荣度每日行为渠道累计量（跨天调用）
---@param userinfo UserInfo
function Player:resetDailyProsperityCount(userinfo)
    local info = self:getProsperityInfo()
    info.dailyProsperityCount = 0
end

--繁荣度升级主任务领奖后处理
--标记门卡任务、更新等级、应用建筑levelEffect、推送升级NTF
---@param configData TaskTable 任务配置
---@param proto UserInfo 差量更新结构
function Player:onProsperityLevelUpClaimed(configData, proto)
    -- 从ProsperityTable查找与该任务id对应的等级配置
    local levelCfg = Config.GetProsperityInfoBylevelTask(configData.id)
    if not levelCfg then return end

    local newLevel = levelCfg.id
    local info = self:getProsperityInfo()
    local newLevelTaskId = levelCfg.levelTask
    local missionList = self:getMissionList()
    if not missionList[newLevelTaskId] then
        missionList[newLevelTaskId] = {
            id = newLevelTaskId,
            state = GE.MissionState.Received,
            progress = 0,
            type = GE.MissionSystemType.task,
            conditionProgress = {},
        }
    else
        missionList[newLevelTaskId].state = GE.MissionState.Received
    end
    if not proto.missionList then proto.missionList = {} end
    proto.missionList[newLevelTaskId] = missionList[newLevelTaskId]

    -- 更新繁荣等级
    info.currentLevel = newLevel

    -- 触发繁荣等级任务进度检查
    self:missionTrigger(GE.MissionFinishType.ProsperityReachLevel, {level = newLevel}, proto)

    -- 应用levelEffect：仅在当前建筑等级低于目标等级时升级（防止降级）
    if levelCfg.levelEffect then
        for _, effect in pairs(levelCfg.levelEffect) do
            local buildingTypeId = effect[1]
            local targetLevel   = effect[2]
            local currentBuildingLevel = self:getBuildingLevel(buildingTypeId)
            if currentBuildingLevel < targetLevel then
                local consData = self:getConstructionDataById(buildingTypeId)
                if consData then
                    consData.level = targetLevel
                end
            end
        end
    end

    self:FunctionOpenTrigger(GE.CommonLockJudgeType.ProsperityLevel, proto)

    -- 同步家园数据到差量proto
    proto.homeland = self:getHomeland()

    --日志
    if DataLogMgr then
        DataLogMgr.LogHomeProsperity({level = newLevel, prosperity = info.globalConditionProgress[GE.MissionFinishType.Prosperity] or 0}, self)
    end
end

--增加繁荣度
--道具渠道（channel=Item）：直接加，不受每日上限
--行为渠道（channel=Behavior）：受 prosperityDailyLimit 限制
---@param value integer 希望增加量
---@param channel integer 渠道 GE.ProsperityChannel
---@param proto UserInfo
---@return integer 实际增加量
function Player:addProsperity(value, channel, proto)
    if not value or value <= 0 then return 0 end
    local info = self:getProsperityInfo()
    local gcp = info.globalConditionProgress
    local actualAdd = value

    if channel == GE.ProsperityChannel.Behavior then
        local dailyLimit = tonumber(Config.GetConfigInfo("DailyPpLimit")) or 0
        if dailyLimit > 0 then
            local remaining = dailyLimit - info.dailyProsperityCount
            if remaining <= 0 then return 0 end
            actualAdd = math.min(value, remaining)
        end
        info.dailyProsperityCount = info.dailyProsperityCount + actualAdd
    end

    gcp[GE.MissionFinishType.Prosperity] = (gcp[GE.MissionFinishType.Prosperity] or 0) + actualAdd

    --触发繁荣度任务进度检查
    self:missionTrigger(GE.MissionFinishType.Prosperity, {value = gcp[GE.MissionFinishType.Prosperity]}, proto)

    --同步繁荣度数据
    if proto then
        if not proto.homeland then proto.homeland = {} end
        proto.homeland.prosperityInfo = info
    end

    --日志
    if DataLogMgr then
        DataLogMgr.LogHomeProsperity({level = info.currentLevel, prosperity = gcp[GE.MissionFinishType.Prosperity], channel = channel}, self)
    end

    return actualAdd
end

--按获取途径增加繁荣度（行为渠道，受每日上限）
---@param getType integer 途径类型 GE.GetProsperityType
---@param proto UserInfo
---@return integer 实际增加量
function Player:addProsperityByGetType(getType, proto)
    local ppGetNumCfg = Config.GetConfigInfo("PpGetNum")
    if type(ppGetNumCfg) ~= "table" then
        return 0
    end

    local addNum = 0
    for _, cfg in pairs(ppGetNumCfg) do
        local cfgType = tonumber(cfg and cfg[1])
        if cfgType == getType then
            addNum = tonumber(cfg[2]) or 0
            break
        end
    end
    if addNum <= 0 then
        return 0
    end

    return self:addProsperity(addNum, GE.ProsperityChannel.Behavior, proto)
end

return Player