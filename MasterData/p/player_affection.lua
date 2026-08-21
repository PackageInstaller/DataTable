-- Desc: 好感度相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end

--该系统分为 事件Event、委托Delegate、触发器Trigger三部分
--事件：好感度事件，触发后会在对应的角色身上刷出事件
--委托：触发好感度事件中选项对应的效果，添加到委托列表中，完成后会给对应的奖励 （以任务的形式记录进度）
--触发器：根据玩家行为和配置中对应的概率触发，效果仅为从好感度事件列表中随机一个事件，刷在对应的角色身上

-------------------------------------------数据获取 & 更新-------------------------------------------------------

--获取全部好感度数据
function Player:getAffectionData()
    return self.affectionData
end

--获取好感度事件列表
---@return table 好感度事件列表
function Player:getAffectionEvent()
    local affectionData = self:getAffectionData()
    return affectionData.affectionEventMap
end

--根据id获取好感度事件
---@param eventId integer 事件ID
---@return table? 事件数据
function Player:getAffectionEventById(eventId)
    local affectionEventMap = self:getAffectionEvent()
    return affectionEventMap[eventId]
end

--根据英雄ID获取好感度事件列表 仅返回已开启的事件
---@param heroId integer 英雄ID
---@return table 事件列表
function Player:getAffectionEventListByHeroId(heroId)
    local eventList = {}
    local eventListMap = Config.GetHeroEventByCharacterId(heroId)
    if eventListMap then
        for _, value in pairs(eventListMap) do
            local eventData = self:getAffectionEventById(value.id)
            if eventData and eventData.state == GE.AffectionEventState.Open then
                table.insert(eventList, eventData)
            end
        end
    end
    return eventList
end

--更新好感度数据 前端用
function Player:updateAffectionData(data)
    local affectionData = self:getAffectionData()
    for key, value in pairs(data) do
        affectionData[key] = value
    end
end

--获取委托列表
---@return table 委托列表
function Player:getDelegateEvent()
    local affectionData = self:getAffectionData()
    if not affectionData or not affectionData.delegateEventList then
        return {}
    end
    return affectionData.delegateEventList
end

--根据id获取委托信息
---@param eventId integer 事件ID
---@return MissionInfo? 委托任务数据
function Player:getDelegateEventById(eventId)
    -- 具体进度信息从任务系统内查找
    local delegateEventList = self:getDelegateEvent()

    local foundDelegateId = tablex.find(delegateEventList, eventId)
    if not foundDelegateId then
        return nil
    end
    return self:getMissionListById(eventId)
end

--刷新全部数据
function Player:fillEventProto(userinfo)
    if userinfo then
        if not userinfo.affectionData then
            userinfo.affectionData = {}
            userinfo.affectionData.delegateEventList = {}
        end
        userinfo.affectionData.delegateEventList = self:getDelegateEvent()
    end
end

--获取每日已触发次数
function Player:getLimitCount()
    local affectionData = self:getAffectionData()
    return affectionData.limitCount
end

--设置每日已触发次数
---@param count integer 新的触发次数
function Player:setLimitCount(count)
    if count < 0 then
        count = 0
    end
    local affectionData = self:getAffectionData()
    affectionData.limitCount = count
end

-------------------------------------------------事件相关处理------------------------------------------------
--初始化事件列表
---@param userinfo UserInfo 用户信息
function Player:affectionEventInit(userinfo)
    local affectionEventConfig = Config.GetAllConfig("HomeEventTable")
    local affectionEvent = self:getAffectionEvent()
    for _, eventData in pairs(affectionEventConfig) do
        local isIn = self:getAffectionEventById(eventData.id)
        if not isIn then
            local eventInfo = {}
            eventInfo.id = eventData.id
            eventInfo.state = eventData.originalState
            affectionEvent[eventData.id] = eventInfo
        end
    end

    --触发器列表初始化
    for _, eventId in pairs(self:getDelegateEvent()) do
        local eventConfig = Config.GetHomeEventInfo(eventId)
        self:addTriggerList(eventConfig)
    end
end

--根据英雄ID列表随机一个好感度事件 刷在对应的角色身上
---@param heroIdList integer[] 英雄ID
---@param userinfo UserInfo 用户信息
---@return ActionFailReason? 错误码
function Player:randomAffectionEventByHeroId(heroIdList, userinfo)
    if heroIdList == nil then
        return ActionFailReason.HeroNoFind
    end
    if self:getFunctionOpenStateById(GE.FunctionOpenModule.AffectionEvent) == GE.FunctionOpenState.Lock then
        return
    end

    local eventAllList = {}
    --检测英雄是否存在
    for _, heroId in pairs(heroIdList) do
        local heroData = self:getPlayerHero(heroId)
        if heroData then
            if heroData.affectionEvent == 0 then
                local eventList = self:getAffectionEventListByHeroId(heroId)
                if #eventList ~= 0 then
                    for _, event in ipairs(eventList) do
                        table.insert(eventAllList, event)
                    end
                end
            end
        end
    end

    --制作一个待随机列表
    local randomList = {}
    for _, value in pairs(eventAllList) do
        local eventConfig = Config.GetHomeEventInfo(value.id)
        if eventConfig then
            local temp = {
                index = value.id,
                weight = eventConfig.weight
            }
            if eventConfig.activation and next(eventConfig.activation) then
                for _, activationData in pairs(eventConfig.activation) do
                    if activationData[1] == GE.AffectionEventActivationType.Affection then  --好感度到达指定值
                        local heroDataAffection = self:getPlayerHero(activationData[2])
                        if heroDataAffection then
                            local affectionValue = heroDataAffection.affectionLevel
                            if affectionValue >= activationData[3] then
                                table.insert(randomList, temp)
                            end
                        end
                    elseif activationData[1] == GE.AffectionEventActivationType.LevelFinish then  --关卡完成情况
                        local levelData = self:getLevelDataByid(activationData[2])
                        if levelData then
                            local levelState = levelData.state
                            if levelState == GE.LevelStateType.Finish then
                                table.insert(randomList, temp)
                            end
                        end
                    end
                end
            else
                --没有激活条件，直接添加到随机列表
                table.insert(randomList, temp)
            end
        end
    end

    local random = self:getRandom()
    local nowRandomId = DLuaUtil.getRandomIndexLinear(randomList, random)
    if nowRandomId == nil or nowRandomId == -1 then --不需要返回错误，列表中没有事件可以刷新是被允许的
        return
    end

    --检测事件是否已经在委托列表中
    local delegateData = self:getDelegateEventById(nowRandomId)
    if delegateData then
        return ActionFailReason.AffectionEventAlreadyInDelegate
    end

    --刷在角色身上
    local eventConfig = Config.GetHomeEventInfo(nowRandomId)
    local heroData = self:getPlayerHero(eventConfig.character)
    heroData.affectionEvent = nowRandomId

    if userinfo ~= nil then
        if userinfo.heroList == nil then
            userinfo.heroList = {}
        end
        userinfo.heroList[eventConfig.character] = heroData
    end

    --记录日志
    if DataLogMgr then
        DataLogMgr.LogAffectionEvent({
            heroCid = eventConfig.character,
            eventId = nowRandomId,
            operate = 1 -- 1表示刷出事件
        }, self)
    end

    return ActionFailReason.None
end

--根据事件id开启事件，使事件可以被随机
---@param eventId integer 事件ID
---@param state AffectionEventState 状态枚举
---@param userinfo UserInfo 用户信息
function Player:changeEventByEventId(eventId, state, userinfo)
    local eventData = self:getAffectionEventById(eventId)

    if not eventData then
        return ActionFailReason.AffectionEventNoFind
    end

    if state == nil then
        return ActionFailReason.AffectionEventStateError
    end

    if state ~= GE.AffectionEventState.Open and state ~= GE.AffectionEventState.Close then
        return ActionFailReason.AffectionEventStateError
    end

    eventData.state = state
    local affectionEventMap = self:getAffectionEvent()
    affectionEventMap[eventId] = eventData

    return ActionFailReason.None
end

-------------------------------------------------委托相关处理-----------------------------------------------------
--根据事件id请求添加到委托列表并创建对应任务信息
---@param eventId integer 事件ID
---@param userinfo? UserInfo 用户信息
function Player:addAffectionEventToDelegate(eventId, userinfo)
    local delegateEvent = self:getDelegateEvent()
    --检测委托列表是否已满
    if tablex.size(delegateEvent) >= Config.GetConfigInfo("commissionMax") then
        return ActionFailReason.DelegateEventListFull
    end

    --检测事件是否存在
    local eventData = self:getAffectionEventById(eventId)
    if not eventData then
        return ActionFailReason.AffectionEventNoFind
    end

    --检测事件是否已经在委托列表中
    local delegateData = self:getDelegateEventById(eventId)
    if delegateData then
        return ActionFailReason.AffectionEventAlreadyInDelegate
    end

    --检测事件配置是否存在
    local eventConfig = Config.GetHomeEventInfo(eventId)
    if not eventConfig then
        return ActionFailReason.CfgNotFind
    end

    --增加任务
    local ret = self:addTaskFormOther(eventId, GE.MissionSystemType.affection, userinfo)
    if ret ~= ActionFailReason.None then
        return ret
    end

    local delegateEvent = self:getDelegateEvent()
    --添加到委托列表
    tablex.insertproxy(delegateEvent, eventId)

    self:fillEventProto(userinfo)

    return ActionFailReason.None
end

---------------------------------------------协议处理-------------------------------------------------------

--根据前端发送的事件id和选项索引，完成事件
---@param eventId integer 事件ID
---@param selectIndex integer 选项索引
---@param userinfo UserInfo 用户信息
---@return ActionFailReason? 错误码
---@return RewardInfo[]? 奖励列表
function Player:finishiAffectionEvent(eventId, selectIndex, userinfo)
    if selectIndex == nil or eventId == nil then
        return ActionFailReason.LackParameter
    end

    --检测事件是否存在
    local eventData = self:getAffectionEventById(eventId)
    if not eventData then
        return ActionFailReason.AffectionEventNoFind
    end

    --检测事件状态是否为开启
    if eventData.state ~= GE.AffectionEventState.Open then
        return ActionFailReason.AffectionEventStateNotOpen
    end

    --事件配置是否存在
    local eventConfig = Config.GetHomeEventInfo(eventId)
    if not eventConfig then
        return ActionFailReason.CfgNotFind
    end

    --检测选项索引是否正确
    if selectIndex < 1 or selectIndex > 3 then
        return ActionFailReason.AffectionOptionIndexError
    end

    --事件是否刷在了角色身上
    local heroData = self:getPlayerHero(eventConfig.character)
    if not heroData then
        return ActionFailReason.HeroNoFind
    end

    local eventState = heroData.affectionEvent
    if eventState ~= eventId then
        return ActionFailReason.AffectionEventNotOnCharacter
    end
    local ret = ActionFailReason.None
    --完成事件，发送协议给后端，后端根据选项内容，触发对应选项事件，发送选项奖励和事件完成奖励
    --触发对应选项中的效果
    local effectList = eventConfig["choice"..selectIndex.."Effect"]
    for _, effectData in pairs(effectList) do
        if effectData[1] == GE.AffectionEventEffectType.GiveUp then --放弃该事件
            --从角色身上移除该事件
            heroData.affectionEvent = 0
        elseif effectData[1] == GE.AffectionEventEffectType.IgnoreConditionEvent then   --无视条件激活事件
            ret = self:changeEventByEventId(effectData[2], GE.AffectionEventState.Open, userinfo)
        elseif effectData[1] == GE.AffectionEventEffectType.CloseEvent then    --关闭事件
            ret = self:changeEventByEventId(effectData[2], GE.AffectionEventState.Close, userinfo)
        end
    end

    -- LuaLogger.ds("eventConfig", tablex.dump(eventConfig))

    --根据事件类型处理后续效果
    local eventType = eventConfig.eventType
    --整合发送的奖励，区分增加的好感度和发送的道具
    local finishReward = eventConfig.finishReward or {}
    local choseRewardList = eventConfig["choice"..selectIndex.."Reward"] or {}
    -- LuaLogger.ds("choseRewardList", tablex.dump(choseRewardList))
    local rewardList = {}
    --下发选项奖励并合并到最终奖励列表
    local choseRewards = self:addRewardList(choseRewardList, userinfo, GE.EventItemType.AffectionEventAccept, table.concat({eventId, selectIndex}, ", "))
    if choseRewards then
        for _, r in ipairs(choseRewards) do
            table.insert(rewardList, r)
        end
    end

    local finishEffect = eventConfig.finishEffect or {}
    for _, effectData in pairs(finishEffect) do
        if effectData[1] == GE.AffectionEventEffectType.IgnoreConditionEvent then
            self:changeEventByEventId(effectData[2], GE.AffectionEventState.Open, userinfo)
        elseif effectData[1] == GE.AffectionEventEffectType.CloseEvent then
            self:changeEventByEventId(effectData[2], GE.AffectionEventState.Close, userinfo)
        end
    end

    -- LuaLogger.ds("finishReward", tablex.dump(finishReward))

    if eventType == GE.AffectionEventType.Normal then           --普通类型 直接结算奖励
        --下发完成奖励并合并到最终奖励列表
        local finishRewards = self:addRewardList(finishReward, userinfo, GE.EventItemType.AffectionEventFinish, eventId)
        if finishRewards then
            for _, r in ipairs(finishRewards) do
                table.insert(rewardList, r)
            end
        end
        self:missionTrigger(GE.MissionFinishType.FinishHomeEventCount, {count = 1}, userinfo) --触发任务系统的事件完成计数
        self:missionTrigger(GE.MissionFinishType.FinishHomeEventById,{eventId = eventId,}, userinfo) --触发任务系统的事件完成
        self:addProsperityByGetType(GE.GetProsperityType.HomeEvent, userinfo)
    elseif eventType == GE.AffectionEventType.Delegate then --委托类型加入委托列表
        ret = self:addAffectionEventToDelegate(eventId, userinfo)
    end

    -- LuaLogger.ds("finishAffectionEvent rewardList", tablex.dump(rewardList))

    self:missionTrigger(GE.MissionFinishType.SelectHomeEventOptionById,{eventId = eventId, optionId = selectIndex}, userinfo)
    heroData.affectionEvent = 0
    if userinfo ~= nil then
        if userinfo.heroList == nil then
            userinfo.heroList = {}
        end
        userinfo.heroList[eventConfig.character] = heroData
    end

    --记录日志
    if DataLogMgr then
        DataLogMgr.LogAffectionEvent({
            heroCid = eventConfig.character,
            eventId = eventId,
            operate = 2, -- 2表示接受事件
            option = selectIndex,
        }, self)
    end

    return ret, rewardList
end

--完成委托事件请求
---@param delegateId integer 委托ID
---@param userinfo UserInfo 用户信息
---@return ActionFailReason? 错误码
---@return RewardInfo[]? 奖励列表
function Player:finishiDelegateEvent(delegateId, userinfo)
    if delegateId == nil then
        return ActionFailReason.LackParameter
    end

    --判断委托是否存在
    local delegateTaskData = self:getDelegateEventById(delegateId)
    if not delegateTaskData then
        return ActionFailReason.DelegateEventNoFind
    end

    --判断委托对应的任务是否完成
    if delegateTaskData.state ~= GE.MissionState.Unclaimed then
        return ActionFailReason.DelegateEventStateNotUnclaimed
    end

    --发送奖励
    local eventConfig = Config.GetHomeEventInfo(delegateId)
    if not eventConfig then
        return ActionFailReason.CfgNotFind
    end

    --添加奖励
    local rewardList = self:addRewardList(eventConfig.finishReward, userinfo, GE.EventItemType.AffectionEventFinish, delegateId)
    local delegateEvent = self:getDelegateEvent()
    --从委托列表中移除
    local length = tablex.size(delegateEvent)
    for i = length, 1, -1 do
        if delegateEvent[i] == delegateId then
            tablex.removeproxy(delegateEvent, i)
            break
        end
    end

    self:fillEventProto(userinfo)
    self:missionTrigger(GE.MissionFinishType.FinishHomeEventById,{eventId = delegateId}, userinfo) --触发任务系统的事件完成
    self:missionTrigger(GE.MissionFinishType.FinishHomeEventCount, {count = 1}, userinfo) --触发任务系统的事件完成计数
    self:addProsperityByGetType(GE.GetProsperityType.HomeEvent, userinfo)
    --记录日志
    if DataLogMgr then
        DataLogMgr.LogAffectionEvent({
            heroCid = eventConfig.character,
            eventId = delegateId,
            operate = 3, -- 3表示完成委托
        }, self)
    end

    return ActionFailReason.None, rewardList
end

--根据家园信息，更新英雄身上的好感度事件信息
---@param userinfo UserInfo 用户信息
---@param delRoleList integer[] 删除的角色列表
function Player:roomListUpdateHeroInfo(userinfo, delRoleList)
    if delRoleList and tablex.size(delRoleList) > 0 then
        for _, roleId in pairs(delRoleList) do
            local heroData = self:getPlayerHero(roleId)
            if heroData then
                heroData.affectionEvent = 0 --清空好感度事件
                self.heroList[heroData.id] = heroData --更新英雄数据
                if userinfo.heroList == nil then
                    userinfo.heroList = {}
                end
                userinfo.heroList[heroData.id] = heroData
            end
        end
    end
end

--GM触发指定好感度事件
---@param eventId integer 事件ID
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason 错误码
function Player:gmTriggerAffectionEvent(eventId, proto)
    if not eventId then
        return ActionFailReason.ParameterInvalid
    end

    local eventCfg = Config.GetHomeEventInfo(eventId)
    if not eventCfg then
        return ActionFailReason.CfgNotFind
    end

    local eventData = self:getAffectionEventById(eventId)
    if not eventData or eventData.state ~= GE.AffectionEventState.Open then
        return ActionFailReason.DelegateEventNoFind
    end

    --检测事件对应的角色是否在家园内
    local inRoomList = self:getRandomAndSetWalkRoleList()
    if not tablex.find(inRoomList, eventCfg.character) then
        return ActionFailReason.AffectionEventNoFind
    end

    local heroData = self:getPlayerHero(eventCfg.character)
    if not heroData then
        return ActionFailReason.HeroNoFind
    end

    --检测事件是否已经在委托列表中
    local delegateData = self:getDelegateEventById(eventId)
    if delegateData then
        return ActionFailReason.AffectionEventAlreadyInDelegate
    end

    --刷在角色身上
    heroData.affectionEvent = eventId

    if proto ~= nil then
        if proto.heroList == nil then
            proto.heroList = {}
        end
        proto.heroList[eventCfg.character] = heroData
    end

    --记录日志
    if DataLogMgr then
        DataLogMgr.LogAffectionEvent({
            heroCid = eventCfg.character,
            eventId = eventId,
            operate = 1 -- 1表示刷出事件
        }, self)
    end

    return ActionFailReason.None
end

--增加好感度经验
---@param heroId integer 英雄ID
---@param addNum integer 增加的经验值
---@param proto UserInfo 玩家信息差量更新结构
---@param balance_channel_id integer 产出消耗渠道
---@param balance_channel_detail any 产出消耗渠道详细内容
function Player:addAffectionExpByHeroId(heroId, addNum, proto, balance_channel_id, balance_channel_detail)
    if not heroId or not addNum then
        LuaLogger.es("not heroId or not addNum")
        return
    end

    if addNum <= 0 then
        LuaLogger.ds("addNum must be greater than 0")
        return
    end

    local heroInfo = self:getPlayerHero(heroId)
    if not heroInfo then
        return
    end

    local heroCfg = Config.GetCharacterInfo(heroId)
    if not heroCfg then
        return
    end

    local curLevel = heroInfo.affectionLevel
    local curLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, curLevel)
    if not curLevelData then
        LuaLogger.ds("CfgNotFind",GE.LevelDataType.affection, curLevel)
        return
    end
    local oldExp = heroInfo.affectionExp or 0
    local maxLevel = Config.GetConfigInfo("AffectionLevelGiftMax")
    local oldLevel = heroInfo.affectionLevel

    local maxExp = curLevelData.exp
    if curLevel == maxLevel and maxExp == oldExp then
        return
    end

    local simExp = math.floor(oldExp + addNum)
    local simLevel = oldLevel
    local simLevelData = curLevelData
    local simMaxExp = simLevelData.exp
    while simExp >= simMaxExp and simLevel < maxLevel do
        simExp = simExp - simMaxExp
        simLevel = simLevel + 1
        simLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, simLevel)
        if not simLevelData then
            LuaLogger.ds("CfgNotFind", GE.LevelDataType.affection, simLevel)
            return
        end
        simMaxExp = simLevelData.exp
    end
    if simLevel >= maxLevel then
        simLevel = maxLevel
        simLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, simLevel)
        if not simLevelData then
            LuaLogger.ds("CfgNotFind", GE.LevelDataType.affection, simLevel)
            return
        end
        simExp = math.min(simExp, simLevelData.exp)
    end

    heroInfo.affectionExp = simExp
    heroInfo.affectionLevel = simLevel
    self:missionTrigger(GE.MissionFinishType.SpecifiedRoleCountWithAffectionLevel, {roleId = heroId}, proto, {})

    if proto and proto.heroList == nil then
        proto.heroList = {}
    end
    if proto then
        proto.heroList[heroId] = heroInfo
    end

    --记录日志
    if DataLogMgr then
        DataLogMgr.LogHeroDevelop({
            heroCid = heroId,
            heroName = heroCfg.name,
            heroDevelopType = GE.HeroDevelopType.AffectionExp,
            before = oldExp,
            after = heroInfo.affectionExp,
        }, self)
    end

    if oldLevel ~= heroInfo.affectionLevel then
        if DataLogMgr then
            DataLogMgr.LogHeroDevelop({
                heroCid = heroId,
                heroName = heroCfg.name,
                heroDevelopType = GE.HeroDevelopType.AffectionLevel,
                before = oldLevel,
                after = heroInfo.affectionLevel,
            }, self)
        end
    end
end


return Player