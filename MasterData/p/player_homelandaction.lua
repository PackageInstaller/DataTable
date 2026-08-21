--- Desc: 家园角色行为相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr, GameGlobal
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
    GameGlobal = require "GameGlobal"
end

local HomeAttributeMaxValue = nil
local GetHomeAttributeMaxValue = function ()
    if HomeAttributeMaxValue == nil then
        HomeAttributeMaxValue = Config.GetConfigInfo("HomeAttributeMaxValue")
    end
    return HomeAttributeMaxValue 
end

---更新英雄行为资源数据
---@param heroId integer 英雄id
---@param proto table 更新数据
---@return table|nil, table|nil
function Player:UpdateActionResource(heroId, proto)
    local heroInfo = self:getPlayerHero(heroId)
    if heroInfo == nil then
        return
    end
    heroInfo.homelandActionInfo = heroInfo.homelandActionInfo or {}

    local actionId = heroInfo.homelandActionInfo.actionId or 0
    if actionId == 0 then
        return
    end
   
    local cfg = Config.GetHomeActivateCfg(actionId)
    if cfg == nil then
        return
    end

    local resourceInfo = cfg.heroRewardList
    ---增加英雄对应属性数值
    local addAttributeVals = {}
    if cfg.heroRewardList ~= nil then
        for key, value in pairs(resourceInfo) do
            local t = value[1]
            local count = value[2]
            table.insert(addAttributeVals, {
                type = t,
                val = count,
            })
        end
    end

    ---扣除的数据
    local subAttrVals = self:DeductHeroAttributeValueOverTime(heroId)
    ---合并数据
    if subAttrVals ~= nil then
        for _, sv in ipairs(subAttrVals) do
            local attrVal = tablex.findSingle(addAttributeVals, function(tb)
                return tb.type == sv.type
            end)
            if attrVal then
                attrVal.val = attrVal.val + sv.val
            else
                -- 不存在则插入，并添加到映射表
                local newItem = {type = sv.type, val = sv.val}  -- 可选：深拷贝避免引用问题
                table.insert(addAttributeVals, newItem)
            end
        end
    end
    for i = #addAttributeVals, 1, -1 do
        --移除num = 0的元素
        local aval = addAttributeVals[i]
        if aval.val == 0 then
            table.remove(addAttributeVals, i)   
        end
    end


    if proto == nil then
        proto = {}
    end
    if proto.heroList == nil then
        proto.heroList = {}
    end

    ---增加英雄对应属性数值
    proto.heroList[heroId] = proto.heroList[heroId] or {}
    local updateHeroInfo = proto.heroList[heroId]
    updateHeroInfo.id = heroId
    heroInfo.attributeValList = heroInfo.attributeValList or {}
    local attributeValList = heroInfo.attributeValList
    updateHeroInfo.attributeValList = attributeValList

    ---增加英雄对应属性数值
    for key, value in pairs(addAttributeVals) do
        local t = value.type
        local val = value.val
        local attrVal = tablex.findSingle(attributeValList, function(v) return v.type == t end)
        if attrVal == nil then
            attrVal = {
                type = t,
                val = val,
            }
            table.insert(attributeValList, attrVal)
        else
            attrVal.val = math.floor(attrVal.val + val)
        end

        attrVal.val = math.max(attrVal.val, 0)

        local attrMaxCfg = GetHomeAttributeMaxValue()
        if attrMaxCfg ~= nil then
            local cfg = tablex.findSingle(attrMaxCfg, function(v)
                return #v >= 2 and v[1] == t
            end)
            if cfg ~= nil then
                attrVal.val = math.min(attrVal.val, cfg[2])
            end
        end
    end

    ---发送随机奖励 
    local rewardList = nil
    local homelandInfo = self.homeland
    local allLevel = 0
    for key, value in pairs(homelandInfo.buildingList) do
        allLevel = allLevel + value.level
    end
    allLevel = math.min(allLevel, #cfg.rewardList)
    local awardIdList = cfg.rewardList[allLevel]
    if awardIdList ~= nil and #awardIdList > 0 then
        ---@type RewardInfo[]
        local awardList = {}
        for i = 1, #awardIdList do
            awardList = tablex.combine(awardList, self:getRandomAward(awardIdList[i]))
        end
        --合并奖励
        for i = 1, #awardList -1 do
            local awardInfo = awardList[i]
            if awardInfo.num == 0 then
                goto continue
            end
            for j = i + 1, #awardList, 1 do
                local r = awardList[j]
                local type, id, num = r[1], r[2], r[3]
                if id == awardInfo.id and type == awardInfo.type then
                    awardInfo.num = awardInfo.num + num
                    awardList[j].num = 0
                end
            end
            ::continue::
        end
        local aList = self:GetHomelandStorageItemReward(awardList, proto)
        if aList ~= nil and #aList ~= 0 then
            rewardList = self:addRewardList(aList, proto, GE.EventItemType.HomeAction, heroId)
        end
    end
    return addAttributeVals, rewardList
end

---扣除英雄完成行为时耗时所用属性
---@param heroId integer
---@return table?{type, val}
function Player:DeductHeroAttributeValueOverTime(heroId)
    local heroInfo = self:getPlayerHero(heroId)
    if heroInfo == nil then
        return
    end
    local actionInfo = heroInfo.homelandActionInfo
    if actionInfo == nil or actionInfo.actionId == nil or actionInfo.actionId == 0 or actionInfo.beginTime == nil or actionInfo.beginTime == 0 then
        return
    end
    ---@type number
    local passTime = DLuaUtil.GetGreenwichTime() - actionInfo.beginTime
    passTime = passTime / 60
    if passTime <= 0 then
        return 
    end

    local heroCfg = Config.GetCharacterInfo(heroId)
    if heroCfg == nil or heroCfg.HomeAttribute == nil or #heroCfg.HomeAttribute == 0 then   
        return
    end
    local attribute = heroCfg.HomeAttribute
    ---增加英雄对应属性数值
    local addAttrVals = {}
    for i = 1, #attribute do
        local type = attribute[i][1]
        local val = attribute[i][2]
        val = val * passTime
        val = math.floor(val)
        val = -val

        table.insert(addAttrVals, {
            type = type,
            val = val,
        })
    end
    return addAttrVals
end


local workScheduleCfg = Config.GetConfigInfo("homework3")
local workTimeCfg = Config.GetConfigInfo("workTime")

---获取当前班表的index
---@return integer
function Player:getRoleScheduleIndex()
	local timeStamp = os.time()     --TODO
	local index = math.floor(timeStamp / 86400) % 3
	return index + 1
end



---获取当前时间处于工作状态的位置
---@return integer
function Player:getHomeCurWorkPos()
	local index = self:getRoleScheduleIndex()
	local workCfg = workScheduleCfg[index]
	local startTime = workTimeCfg[1]
	local endTime = workTimeCfg[2]
	local curHour = tonumber(os.date("%H"))
	local value = 2
	if curHour >= startTime and curHour < endTime then
		value = 1
	end
	for i = 1, 3 do
		if workCfg[i] == value then
			return i
		end
	end
    return 0
end

---角色是否在家园中 只有在家园中的才会触发对应的行为
---@param heroId number
---@return boolean
function Player:IsInHomeland(heroId)
    local homeland = self.homeland
    if homeland == nil then
        return false
    end
    local homeWalkHeroList = homeland.homeWalkHeroList
    if homeWalkHeroList ~= nil then
        if tablex.find(homeWalkHeroList, heroId) then
            return true
        end
    end

    local rolePreRoom = homeland.rolePreRoom
    if rolePreRoom ~= nil and rolePreRoom[heroId] ~= nil then
        return true
    end

    -- local buildingList = homeland.buildingList
    -- if buildingList ~= nil then
    --     for key, value in pairs(buildingList) do
    --         if tablex.find(value.disposeHeroList, heroId) then 
    --             return true
    --         end
    --     end
    -- end
    return false
end


---获取角色工作房间ID 只有排班到的英雄才会有工作房间
---@param heroId number 英雄ID
---@return integer
function Player:GetHeroWorkingRoom(heroId)
    local homeland = self.homeland
    if homeland == nil then
        return 0
    end
    local buildingList = homeland.buildingList
    if buildingList == nil then
        return 0
    end
    local pos = self:getHomeCurWorkPos()
    local homeId = 0
    for key, value in pairs(buildingList) do
        if value.disposeHeroList == nil then
            goto continue
        end
        if key == GE.CoustructionEnum.CommandRoom or key == GE.CoustructionEnum.PatrolRoom then
            if value.disposeHeroList ~= nil and tablex.find(value.disposeHeroList, heroId) then
                homeId = key
                break
            end
        else
            --判断排班表
            if value.disposeHeroList[pos] == heroId then
                homeId = key
                break
            end
        end
        ::continue::
    end
    return homeId
end


---获取角色工作状态 ps用来检测是否和配置配置一致
---0表示在巡逻 -1表示不在家园中 其余表示工作房间
---@param heroId any
---@return integer
function Player:GetHeorRoomId(heroId)
    local homeId = self:GetHeroWorkingRoom(heroId)
    if homeId ~= 0 then
        return homeId
    end
    if self:IsInHomeland(heroId) then
        return 0
    end
    return -1
end

---获得当前行为的英雄数量
---@param actionType HomeActionType
---@return integer
function Player:GetActionTypePlayerCount(actionType)

    local heroList = self.heroList
    if heroList == nil then
        return 0
    end
    local count = 0
    for key, value in pairs(heroList) do
        if value.homelandActionInfo == nil then
            goto continue
        end
        local actionId = value.homelandActionInfo.actionId
        if actionId == nil or actionId == 0 then
            goto continue
        end
        local cfg = Config.GetHomeActivateCfg(actionId)
        if cfg == nil then
            goto continue
        end
        if cfg.activateType == actionType then
            count = count + 1
        end
        ::continue::
    end
    return count
end

---获得当前行为的英雄数量
---@param actionId integer
---@param ignoreHeros integer[]?
---@return integer
function Player:GetActionIdPlayerCount(actionId, ignoreHeros)
    local heroList = self.heroList
    if heroList == nil then
        return 0
    end
    local count = 0
    for key, value in pairs(heroList) do
        if value.homelandActionInfo == nil then
            goto continue
        end
        if ignoreHeros ~= nil and tablex.indexof(ignoreHeros, value.id) > 0 then
           goto continue 
        end
        local aid = value.homelandActionInfo.actionId
        if aid == nil or aid == 0 then
            goto continue
        end
        if aid == actionId then
            count = count + 1
        end
        ::continue::
    end
    return count
end

---获得当前行为的英雄数量
---@param homeId integer
---@return integer
function Player:GetActionHomePlayerCount(homeId)
    local heroList = self.heroList
    if heroList == nil then
        return 0
    end
    local count = 0
    for key, value in pairs(heroList) do
        if value.homelandActionInfo == nil then
            goto continue
        end
        local aid = value.homelandActionInfo.actionId
        if aid == nil or aid == 0 then
            goto continue
        end
        local cfg = Config.GetHomeActivateCfg(aid)
        if cfg == nil then 
            goto continue
        end
        if cfg.param == homeId then
            count = count + 1
        end
        ::continue::
    end
    return count
end

---获得家园仓库道具数量
---@param itemId integer
---@return integer
function Player:GetHomelandItemCount(itemId)
    if self.homeland == nil or self.homeland.storageItemList == nil then
        return 0
    end
    local storageItemList = self.homeland.storageItemList
    local itemInfo = tablex.findSingle(storageItemList, function(v) return v.id == itemId end)
    return itemInfo and itemInfo.num or 0
end

---获得家园英雄数量
---@return integer
function Player:GetHomelandHeroCount()

    local count = 0
    if self.heroList == nil then
        return count
    end

    for key, value in pairs(self.heroList) do
        if value.homelandActionInfo ~= nil and value.homelandActionInfo.actionId ~= nil and value.homelandActionInfo.actionId ~= 0 then
            count = count + 1
        end
    end
    return count
end


---获得英雄接下来的行为
---@param heroId integer
---@return integer, ActionFailReason
function Player:GetHeroNextAction(heroId)

    local heroInfo = self:getPlayerHero(heroId)
    if heroInfo == nil then
        return 0, ActionFailReason.HomelandAction_HeroNotFind
    end

    local actionTab = Config.GetHomeActionTable()
    if actionTab == nil then
        return 0, ActionFailReason.HomelandAction_ConfigError
    end

    local homeRoomId = self:GetHeorRoomId(heroId)
    if homeRoomId == -1 then
        -- 下班
        local cfg = Config.GetHomeActivateCfgByactionType(HomeActionType.GetoffWork)
        local id = cfg and cfg.id or 0
        if heroInfo.homelandActionInfo.actionId == nil or heroInfo.homelandActionInfo.actionId == 0 then
            --上次行为是0 则不再下班
            LuaLogger.ds("the character get off work, current state 0 heorId:" .. tostring(heroId))
            return 0, ActionFailReason.HomelandAction_GetoffWorkError
        end
        if heroInfo.homelandActionInfo.actionId == id then
            LuaLogger.ds("the character get off work,  current state:" .. id .."  heorId:" .. tostring(heroId))
            id = 0
        end
        return id, ActionFailReason.None
    end

    heroInfo.homelandActionInfo = heroInfo.homelandActionInfo or {
        actionId = 0,
        lastActionId = 0,
        beginTime = 0,
    }

    local actionInfo = heroInfo.homelandActionInfo

    ---如果当前状态是下班 则不能再进行任何行为
    if actionInfo ~= nil and actionInfo.actionId ~= nil then
        local curAction = actionInfo.actionId
        local cfg = Config.GetHomeActivateCfg(curAction)
        if cfg ~= nil and cfg.activateType == HomeActionType.GetoffWork then
            return 0, ActionFailReason.None
        end
    end

    ---@type HomeActionTable[]
    local eligibleCfg = {}
    for key, value in pairs(actionTab) do
        if value.characterID ~= 0 and value.characterID ~= heroId then
            goto continue
        end

        if value.roomType ~= nil and #value.roomType ~= 0 then
            if not tablex.find(value.roomType, homeRoomId) then
                goto continue
            end
        end

        if value.characterCondition ~= nil and #value.characterCondition ~= 0 then
            local check = self:CheckCharacterCondition(value.characterCondition, heroInfo)
            if not check then
                goto continue
            end
        end

        if value.activateCondition ~= nil then 
            local check = self:CheckHeroActiveCondition(value.activateCondition, heroInfo)
            if not check then
                goto continue
            end
        end

        --检测子行为是否有满足条件的
        local childActivates = self:GetAllEnableActivate(value.id, heroId)
        if childActivates == nil or #childActivates == 0 then
            goto continue
        end

        table.insert(eligibleCfg, value)
        ::continue::
    end
    table.sort(eligibleCfg, function(a, b) 
        return a.id < b.id
    end)
    ---随机概率
    ---@type HomeActionTable?
    local randomCfg = nil
    for i = 1, #eligibleCfg, 1 do
        local cfg = eligibleCfg[i]
        local k = math.random(10000)
        if k <= cfg.probability then
            randomCfg = cfg
            break
        end
    end

    if randomCfg ~= nil then
        --检测子行为是否有满足条件的
        local childActivates = self:GetAllEnableActivate(randomCfg.id, heroId)
        if childActivates == nil or #childActivates == 0 then
            goto action_defualt
        end

        --随机行为
        local randomCount = 0
        for i = 1, #childActivates do
            randomCount = randomCount + childActivates[i][2]
        end

        local rv = math.random(randomCount)
        local actionId = -1
        local sum = 0
        for i = 1, #childActivates, 1 do
            sum = sum + childActivates[i][2]
            if rv <= sum then
                actionId = childActivates[i][1]  -- 返回行为
                break
            end
        end
        if actionId == -1 then
            goto action_defualt
        end
        if actionId ~= -1 then
            return actionId, ActionFailReason.None
        end
    end

    ::action_defualt::
    local actionId = 9001 ---散步保底
    return actionId, ActionFailReason.None
end

---获取当前行为组id 下可以激活的行为列表
---@param homeActionId integer homeActionId
---@param heroId integer
---@return table[]? {[],[]}1表示行为id 2表示概率
function Player:GetAllEnableActivate(homeActionId, heroId)

    local actoinCfg = Config.GetHomeActionCfg(homeActionId)
    if actoinCfg == nil then
       return nil 
    end
    local aLst = actoinCfg.activateList
    if aLst == nil then
       return nil
    end
    --检测子行为TODO
    local childActivates = {}
    for i = 1, #aLst do
        local tab = aLst[i]
        local aId = tab[1]
        local prob = tab[2]
        if aId > 100 then
            if self:CheckHomeActivateEnable(aId, heroId) then
                table.insert(childActivates, tab)
            end

        else
            local cfgs = Config.GetHomeActivateCfgsByactionType(aId)
            if cfgs ~= nil then
                for k, v in pairs(cfgs) do
                    if self:CheckHomeActivateEnable(v.id, heroId) then
                        table.insert(childActivates, tab)
                    end
                end
            end
        end
    end
    return childActivates
end

---检测当前行为是否可以被激活
---@param activateId integer
---@param heroId integer
function Player:CheckHomeActivateEnable(activateId, heroId)

    local homeRoomId = self:GetHeorRoomId(heroId)
    local activateCfg = Config.GetHomeActivateCfg(activateId)
    if activateCfg == nil then
        return false
    end

    ---判断行为上限
    if activateCfg ~= nil and activateCfg.maxCount > 0  then
        local curCount = self:GetActionIdPlayerCount(activateId, {heroId})
        if curCount >= activateCfg.maxCount then
            return false
        end
    end

    --判断子房间 人数上限
    local constructionCfg = Config.GetConstructionInfo(activateCfg.param)
    if constructionCfg ~= nil and constructionCfg.maxChara > 0 then
        local homeRoleCount = self:GetActionHomePlayerCount(activateId) 
        if homeRoleCount >= constructionCfg.maxChara then
            return false
        end
    end

    --判断等级
    if self:getBuildingLevel(activateCfg.param) < activateCfg.limitBuildingLv then
        return false
    end


    if activateCfg.activateType == HomeActionType.Working then
        --如果角色没有房间 则不能进入工作房间
        if homeRoomId == 0 then
            return false
        else
            --和角色工作房间不一致的房间也不能进入
            if activateCfg.param ~= homeRoomId then
                return false 
            end
        end
    end
    return true
end


---检测角色资源数量是否满足条件
---@param characterConditionCfg table{table} 
---@param heroInfo HeroInfo
---@return boolean
function Player:CheckCharacterCondition(characterConditionCfg, heroInfo)
    if characterConditionCfg == nil then
        return true
    end
    for key, value in pairs(characterConditionCfg) do
        local type = value[1]
        local minCount = value[2]
        local maxCount = value[3]
        local curCount = 0
        if heroInfo.attributeValList ~= nil then
            local attrVal = tablex.findSingle(heroInfo.attributeValList, function(v) return v.type == type end)
            curCount = attrVal and attrVal.val or 0
        end

        if curCount < minCount or curCount > maxCount then
            return false
        end
    end
    return true
end

---检测角色是否满足条件
---@param activateCfg any
---@param heroInfo HeroInfo
---@return boolean
function Player:CheckHeroActiveCondition(activateCfg, heroInfo)

    if activateCfg == nil then
        return true
    end
    for key, value in pairs(activateCfg) do
        local actionId = heroInfo.homelandActionInfo.actionId
        local cfg = Config.GetHomeActivateCfg(actionId)
        if key == "lastActionLimit" then ---表示上一次行为_activateType
            if cfg == nil then
                return false
            end
            if not tablex.find(value, cfg.activateType) then
                return false
            end
        elseif key == "lastActionIdLimitId" then ---表示上一次行为_id
            if not tablex.find(value, actionId) then
                return false
            end
        elseif key == "AllActionLimit" then
            for i = 1, #value, 1 do
                local actionType = value[i][1]
                local actionCount = value[i][2]
                local curCount = self:GetActionTypePlayerCount(actionType)
                if curCount > actionCount then 
                    return false
                end
            end
        elseif key == "AllActionIdLimit" then
            for i = 1, #value, 1 do
                local actionType = value[i][1]
                local actionCount = value[i][2]
                local curCount = self:GetActionIdPlayerCount(actionType, {heroInfo.id})
                if curCount > actionCount then 
                    return false
                end
            end
        elseif key == "resrouceLimit" then
            for i = 1, #value, 1 do
                local itemId = value[i][1]
                local itemCount = value[i][2]
                local curCount = self:GetStorageItemCount(itemId)
                if curCount < itemCount then 
                    return false
                end
            end
        elseif key == "propsResourceLimit" then
            for i = 1, #value, 1 do
                local propsId = value[i]
                local canAddReward = self:CovePropsCanAddReward(propsId)
                if not canAddReward then 
                    return false
                end
            end
        elseif key == "ConstructionLevelLimit" then
            for i = 1, #value, 1 do
                local buildId = value[i][1]
                local minLv = value[i][2]
                local buildData = self:getConstructionDataById(buildId)
                if buildData == nil or buildData.level < minLv then 
                    return false
                end
                
            end
        end
    end
    return true
end

---设置英雄的下一个行为
---@param heroId any
---@param proto any
---@return ActionFailReason, integer
function Player:SetHeroNextAction(heroId, proto)
    local nextAction, res = self:GetHeroNextAction(heroId)
    if res ~= ActionFailReason.None then
        return res, nextAction
    end

    local heroInfo = self:getPlayerHero(heroId)
    if heroInfo == nil then
        return ActionFailReason.HomelandAction_HeroNotFind, 0
    end

    heroInfo.homelandActionInfo = heroInfo.homelandActionInfo or {}
    local actionInfo = heroInfo.homelandActionInfo
    actionInfo.lastActionId = actionInfo.actionId
    actionInfo.actionId = nextAction
    actionInfo.beginTime = DLuaUtil.GetGreenwichTime()

    proto.heroList = proto.heroList or {}
    local updateHeroInfo = nil
    if proto.heroList ~= nil then
        updateHeroInfo = proto.heroList[heroId]
        if updateHeroInfo == nil then
            updateHeroInfo = tablex.findSingle(proto.heroList, function(v)
                return v.id == heroId
            end)
        end
    end
    if updateHeroInfo == nil then
        updateHeroInfo = {}
        updateHeroInfo.id = heroId
        proto.heroList[heroId] = updateHeroInfo
    end
    updateHeroInfo.homelandActionInfo = heroInfo.homelandActionInfo
    return ActionFailReason.None, nextAction
end


---获取空闲的英雄列表
---人数不会超过最大数量
---@return number[]|nil
function Player:GetIdleHeros()
    local heroList = self.heroList
    if heroList == nil then
        return nil
    end

    local maxCount = Config.GetConfigInfo("HomeMaxCharacter")
    local curCount = self:GetHomelandHeroCount()
    local addCount = maxCount - curCount
    if addCount <= 0 then
        return nil
    end
    local idleHeros = {}
    for key, value in pairs(heroList) do
        local actionId = value.homelandActionInfo and value.homelandActionInfo.actionId or 0
        actionId = actionId or 0

        if actionId == 0 then   
            table.insert(idleHeros, value.id)
            if #idleHeros >= addCount then
                break
            end
        end
    end
    return idleHeros
end

---设置英雄的下一个行为
---@param heroId any
---@param proto any
---@return ActionFailReason, integer
function Player:CompleSetHeroNextAction(heroId, actionId, proto)

     if actionId ~= nil and actionId ~= 0 then


     end

    local heroInfo = self:getPlayerHero(heroId)
    if heroInfo == nil then
        return ActionFailReason.HomelandAction_HeroNotFind, 0
    end

    heroInfo.homelandActionInfo = heroInfo.homelandActionInfo or {}
    local actionInfo = heroInfo.homelandActionInfo
    actionInfo.lastActionId = actionInfo.actionId
    actionInfo.actionId = actionId
    actionInfo.beginTime = DLuaUtil.GetGreenwichTime()


    proto.heroList = proto.heroList or {}
    local updateHeroInfo = nil
    if proto.heroList ~= nil then  
        local match = tablex.findMatch(proto.heroList, function(v)
            return v.id == heroId
        end, 1)
        if match ~= nil then
            updateHeroInfo = match[1]
        end
    end
    if updateHeroInfo == nil then
        updateHeroInfo = {}
        updateHeroInfo.id = heroId
        proto.heroList[heroId] = updateHeroInfo 
    end
    updateHeroInfo.homelandActionInfo = heroInfo.homelandActionInfo
    return ActionFailReason.None, actionId
end


---清除所有英雄的行为
function Player:ClearAllHeroAction(userInfo)
    local heroList = self.heroList
    if heroList == nil then
        return
    end

    for key, value in pairs(heroList) do
        local actionInfo = value.homelandActionInfo
        if actionInfo == nil or actionInfo.actionId == nil or actionInfo.actionId == 0 then
            goto continue
        end
        actionInfo.lastActionId = actionInfo.actionId
        actionInfo.actionId = 0
        actionInfo.beginTime = DLuaUtil.GetGreenwichTime()

        userInfo.heroList = userInfo.heroList or {}
        local updateHeroInfo = nil
        if userInfo.heroList ~= nil then  
            local match = tablex.findSingle(userInfo.heroList, function(v)
                return v.id == key
            end)
            if match ~= nil then
                updateHeroInfo = match
            end
        end
        if updateHeroInfo == nil then
            updateHeroInfo = {}
            updateHeroInfo.id = key
            userInfo.heroList[key] = updateHeroInfo
        end
        updateHeroInfo.homelandActionInfo = actionInfo
        ::continue::
    end
end

---离线重置英雄属性
---@param proto UserInfo
function Player:UpdateHomelandHeroOutLineAttribute(proto)

    local lastOnLineTime = 0
    if GV.IsServer then
        lastOnLineTime = self.lastofflinetime or 0
    else
        lastOnLineTime = self.lastonlinetime or 0
    end

    if lastOnLineTime == 0 then
        return
    end
    local curTime = DLuaUtil.GetGreenwichTime()
    local passTime = curTime - lastOnLineTime
    passTime = passTime / 60
    passTime = math.floor(passTime)
    local maxTime = Config.GetConfigInfo("HomeAttributeResetTime")
    if maxTime == nil or type(maxTime) ~= "number" then
        return
    end
    if passTime < maxTime then
       return 
    end
    local heroList = self.heroList
    if heroList == nil then
        return
    end

    -- local noSaveFields = {}
    -- if maxTime == 0 then
    --     table.insert(noSaveFields, {"heroList"})
    -- end
    --self:noSavedbRun(function()
        proto = proto or {}
        proto.heroList = proto.heroList or {}
        for key, value in pairs(heroList) do
            value.attributeValList = value.attributeValList
            local cfg = Config.GetCharacterInfo(value.id)
            if cfg == nil then
                goto continue
            end
            value.attributeValList = {}
            for i = 1, #cfg.OutLineAttribute do
                local type = cfg.OutLineAttribute[i][1]
                local val_min = cfg.OutLineAttribute[i][2]
                local val_max = cfg.OutLineAttribute[i][3]
                local val = math.random(val_min, val_max)
                tablex.insertproxy(value.attributeValList, {
                    type = type,
                    val = val,
                })
            end
            proto.heroList[value.id] = proto.heroList[value.id] or {}
            proto.heroList[value.id].id = value.id
            proto.heroList[value.id].attributeValList = value.attributeValList
            ::continue::
        end
    --end, noSaveFields)

end


---@param heroActions HeroActionInfo[]
---@param proto UserInfo
---@return HeroActionPushInfo[]
function Player:reportHeroHomeActionCompleted(heroActions, proto)

    if heroActions == nil then
        return {}
    end

    ---更新大仓库数量
    self:UpdateHomelandStorageItemData(false, proto)
    ---@type HeroActionPushInfo[]
    local infos = {}
    for index, value in ipairs(heroActions) do
        local ret = nil
        local actionId = nil

        if value.heroId == nil then
            goto continue
        end
        --获取奖励
        local aLst, rLst = nil, nil
        if value.actionId ~= nil and value.actionId ~= 0 then
            ret, actionId = self:CompleSetHeroNextAction(value.heroId, value.actionId, proto)  
        else
            aLst, rLst = self:UpdateActionResource(value.heroId, proto)
            ret, actionId = self:SetHeroNextAction(value.heroId, proto)
        end

        --如果有奖励，则记录日志
        if DataLogMgr and tablex.next(rLst) then
            DataLogMgr.LogHomeHeroAction({
                heroCid = value.heroId,
                actionId = actionId,
                rewards = rLst,
            }, self)
        end

        table.insert(infos, {
            ret = ret,
            heroId = value.heroId,
            actionId = actionId,
            attributeVals = aLst,
            rewardList = rLst,
        })
        ::continue::
    end
    return infos
end



return Player