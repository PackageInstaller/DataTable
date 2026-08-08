-- Desc: 玩家武器相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end


--武器词条等级提升系数
local weaponCoefficient = Config.GetConfigInfo("WeaponLevelupCoefficient") or 0.5
--武器部位最大值
local weaponPartMaxId = 2
--武器经验回收比例
local weaponReturn = Config.GetConfigInfo("weaponReturn") or 0.6
--武器强化货币与经验比例（{经验，货币}）
local weaponUseResRatio = Config.GetConfigInfo("weaponExpCost") or 0
--武器强化货币
local weaponResType = Config.GetConfigInfo("weaponCurrency") or 0
--对应锁定词条数量下需消耗的道具类型与数量
local WeaponEntryLock = Config.GetConfigInfo("WeaponEntryLock") or {{120000,1}}
--武器数量上限
local weaponNumMax = Config.GetConfigInfo("weaponNumMax") or 999
--武器词条最大数量
local weaponEntryMax = 4
--熔合所需武器个数
local fuseNeedWeaponNum = 2
--武器熔合稀有度下限
local fuseRareMin = Config.GetConfigInfo("WeaponSynthesisRareLimit") or 4


--获取全部武器信息
---@return table<integer, WeaponInfo>
function Player:getAllWeaponData()
    return self.weaponMap
end

--获取武器数量
---@return integer
function Player:getWeaponNum()
    local weaponMap = self:getAllWeaponData()
    return tablex.size(weaponMap)
end

--通过实例化id查找武器信息
---@param id integer 实例化id
---@return WeaponInfo? 武器信息
function Player:getWeaponDataById(id)
    local weaponMap = self:getAllWeaponData()
    return weaponMap[id]
end

--判断武器是否锁定
---@param weaponId integer 实例化id
---@return boolean 锁定状态
function Player:checkWeaponLockState(weaponId)
    local weaponData = self:getWeaponDataById(weaponId)
    if not weaponData then
        return false
    end
    return weaponData.isLock
end

--删除武器
---@param id integer 实例化id
---@param proto UserInfo 用户数据
---@param balance_channel_id integer 产出消耗渠道
---@param balance_channel_detail any 产出消耗渠道详细内容
---@return ActionFailReason 错误码
function Player:deletePlayerWeapon(id, proto, balance_channel_id, balance_channel_detail)
    --武器存在检测
    local weaponData = self:getWeaponDataById(id)
    if not weaponData then
        return ActionFailReason.WeaponNoFind
    end

    --武器锁定检测
    local isLock = self:checkWeaponLockState(id)
    if isLock then
        return ActionFailReason.WeaponIsLock
    end

    local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
    if not weaponConfig then
        return ActionFailReason.CfgNotFind
    end

    --删除武器
    local weaponMap = self:getAllWeaponData()
    weaponMap[id] = nil

    --减少武器图鉴数量
    self:saveWeaponHandbookData(weaponData.cid, proto, -1)

    if proto then
        if not proto.weaponMap then
            proto.weaponMap = {}
        end
        proto.weaponMap[id] = {}
    end

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogWeaponConsume({
            weaponCid = weaponData.cid,
            weaponId = id,
            weaponName = weaponConfig.name,
            balance_channel_id = balance_channel_id,
            balance_channel_detail = balance_channel_detail
        }, self)
    end

    return ActionFailReason.None
end

--添加武器
---@param cid integer 表id
---@param proto UserInfo 用户数据
---@param balance_channel_id integer 产出消耗渠道
---@param balance_channel_detail integer 产出消耗渠道详细内容
---@return ActionFailReason
---@return integer? 实例化id
function Player:addPlayerWeapon(cid, proto, balance_channel_id, balance_channel_detail)
    --武器数量检测
    local weaponNum = self:getWeaponNum()
    if weaponNum >= weaponNumMax then
        return ActionFailReason.WeaponWarehouseFull
    end

    --配置表检测
    local weaponConfig = Config.GetWeaponInfo(cid)
    if not weaponConfig then
        return ActionFailReason.CfgNotFind
    end
    --道具是否开放,0未开放，1开放
    if weaponConfig.isOpen ~= 1 then
        LuaLogger.es("Weapon is not open:", cid)
        return ActionFailReason.CfgError
    end

    --实例化id检测
    local newId = self:newWeaponLimitId()
    local weaponData = self:getWeaponDataById(newId)
    if weaponData then
        LuaLogger.es("已使用的Cid:", cid, "实例化id:", newId)
        return ActionFailReason.ParameterInvalid
    end

    --添加武器
    local weaponMap = self:getAllWeaponData()
    weaponMap[newId] = self:initWeaponInfo(weaponConfig, newId)

    if proto then
        if not proto.weaponMap then
            proto.weaponMap = {}
        end
        proto.weaponMap[newId] = self:getWeaponDataById(newId)
    end

    --记录武器图鉴
    self:saveWeaponHandbookData(cid, proto)

    -- 触发攻击舰装等级任务（新获得的武器初始等级为0）
    local newWeapon = self:getWeaponDataById(newId)
    if newWeapon then
        self:missionTrigger(GE.MissionFinishType.AttackWeaponReachLevel, {level = newWeapon.level}, proto)
    end

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogWeaponAdd({
            weaponCid = cid,
            weaponId = newId,
            weaponName = weaponConfig.name,
            balance_channel_id = balance_channel_id,
            balance_channel_detail = balance_channel_detail,
        }, self)
    end

    return ActionFailReason.None, newId
end

--初始化武器信息
---@param weaponConfig WeaponTable 武器表
---@param newId integer 实例化id
---@return WeaponInfo
function Player:initWeaponInfo(weaponConfig, newId)
    --构建数据
    local newWeaponData = {
        id = newId,
        cid = weaponConfig.id,
        level = 0,
        exp = 0,
        ownerId = 0,
        isLock = false,
        accuracy = self:initWeaponAccuracy(weaponConfig),
        quality = self:initWeaponQuality(weaponConfig),
        attributeList = self:initWeaponAttribute(weaponConfig),
    }
    return newWeaponData
end

--新建一个装备实例化id
---@return integer 实例化id
function Player:newWeaponLimitId()
    local onlyServerData = self:getOnlyServerData()
    onlyServerData.nowWeaponLimitId = onlyServerData.nowWeaponLimitId + 1
    return onlyServerData.nowWeaponLimitId
end

--初始化武器命中率
---@param weaponConfig WeaponTable 武器表
---@return integer 命中率
function Player:initWeaponAccuracy(weaponConfig)
    local accuracyMaxMin = weaponConfig.accuracy
    local random = self:getRandom()
    local newAccuracy = random:range(accuracyMaxMin[1], accuracyMaxMin[2])
    return newAccuracy
end

--初始化武器工艺值
---@param weaponConfig WeaponTable 武器表
---@return integer 工艺值
function Player:initWeaponQuality(weaponConfig)
    local qualityMaxMin = weaponConfig.quality
    local random = self:getRandom()
    local newQuality = random:range(qualityMaxMin[1], qualityMaxMin[2])
    return newQuality
end

--武器初始化词条
---@param weaponConfig WeaponTable 武器表
---@return WeaponEntry[] 词条组
function Player:initWeaponAttribute(weaponConfig)
    --将数据修改为随机逻辑需要的格式
    local countWeight = {}
    for _, v in pairs(weaponConfig.initial) do
        table.insert(countWeight,{index = v[1], weight = v[2]})
    end

    --随机初始化词条个数
    local random = self:getRandom()
    local attrCount = DLuaUtil.getRandomIndexLinear(countWeight, random)
    local initAttrList = {}
    local existGroupIdList = {}

    --根据个数随机词条内容
    for i = 1, attrCount do
        local attrId = self:randomSingleWeaponAttribute(existGroupIdList, i, weaponConfig)
        local entryConfig = Config.GetWeaponEntryInfo(attrId)
        if not entryConfig then
            LuaLogger.es("not entryConfig", attrId)

            --在特殊的情况下，需要考虑是给默认词条还是不给？
        else
            --记录词条组供判重使用
            existGroupIdList[entryConfig.group] = true
            --构造词条结构
            local attrData = {
                id = attrId,
                coefficient = weaponCoefficient[weaponConfig.rare][i],
                special = false,
            }
            tablex.insertproxy(initAttrList, attrData)
        end
    end

    return initAttrList
end

--根据词条位置库随机一个武器词条
---@param existGroupIdList table<integer, boolean>[] 已存在词条id
---@param index integer 初始化词条个数
---@param weaponConfig WeaponTable 武器表
---@return integer 词条id
function Player:randomSingleWeaponAttribute(existGroupIdList, index, weaponConfig)
    --当前位置词条组库
    local attrLibrary = weaponConfig["entry"..index]
    local groupWeight = {}
    for _, v in pairs(attrLibrary) do
        --排除已存在的词条组
        if not existGroupIdList[v[1]] then
            table.insert(groupWeight,{index = v[1], weight = v[2]})
        end
    end
    --随机出词条组id
    local random = self:getRandom()
    local attrGroupId = DLuaUtil.getRandomIndexLinear(groupWeight, random)
    local entryListCfg = Config.GetWeaponEntryInfoByGroup(attrGroupId)
    if not entryListCfg then
        LuaLogger.es("未找到配置表:", attrGroupId)
        --在特殊情况下，需要判断是否给默认信息？
    else
        --根据词条组随机出词条id
        local attrWeight = {}
        for _, v in pairs(entryListCfg) do
            table.insert(attrWeight,{index = v.id, weight = v.weight})
        end
        return DLuaUtil.getRandomIndexLinear(attrWeight, random)
    end

    --考虑给一个完全不可能的值
    return -1
end

--武器分解
---@param idList integer[] 武器id列表
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
---@return RewardInfo[]? 奖励列表
function Player:decomposePlayerWeapon(idList, proto)
    --分解奖励
    local allReward = {}

    --参数判空
    if not idList or not tablex.next(idList) then
        return ActionFailReason.ParameterInvalid
    end

    --参数检测
    local temp = {}
    for _, id in ipairs(idList) do
        --防重复检测
        if not temp[id] then
            temp[id] = id
        else
            return ActionFailReason.ParameterInvalid
        end

        --判断武器存在
        local weaponData = self:getWeaponDataById(id)
        if not weaponData then
            return ActionFailReason.WeaponNoFind
        end

        --判断武器锁定状态
        local isLock = self:checkWeaponLockState(id)
        if isLock then
            return ActionFailReason.WeaponIsLock
        end

        --判断武器是否被装备
        if weaponData.ownerId ~= 0 then
            return ActionFailReason.WeaponIsEquip
        end

        local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
        if not weaponConfig then
            return ActionFailReason.CfgNotFind
        end

        for _, v in pairs(weaponConfig.decompose) do
            table.insert(allReward, v)
        end
    end

    local rewardList = self:addRewardList(allReward, proto, GE.EventItemType.WeaponDecompose, #idList)
    rewardList = self:mergeRewardList(rewardList)

    --删除武器
    for _, id in ipairs(idList) do
        local ret = self:deletePlayerWeapon(id, proto, GE.EventItemType.WeaponDecompose, id)
        if ret ~= ActionFailReason.None then
            return ret
        end
    end

    return ActionFailReason.None, rewardList
end

--更改武器锁定状态
---@param weaponId integer 武器实例化id
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
function Player:changeWeaponLockState(weaponId, proto)
    if weaponId == nil then
        return ActionFailReason.ParameterInvalid
    end

    local weaponData = self:getWeaponDataById(weaponId)
    if not weaponData then
        return ActionFailReason.WeaponNoFind
    end

    local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
    if not weaponConfig then
        return ActionFailReason.CfgNotFind
    end

    local oldLockState = weaponData.isLock and 1 or 0
    weaponData.isLock = not weaponData.isLock

    if proto then
        if not proto.weaponMap then
            proto.weaponMap = {}
        end
        proto.weaponMap[weaponData.id] = weaponData
    end

    --记录数据日志
    if DataLogMgr then
        local curLockState = weaponData.isLock and 1 or 0
        DataLogMgr.LogWeaponDevelop({
            weaponCid = weaponData.cid,
            weaponId = weaponData.id,
            weaponName = weaponConfig.name,
            weaponDevelopType = GE.WeaponDevelopType.OwnerId,
            before = oldLockState,
            after = curLockState,
        }, self)
    end

    return ActionFailReason.None
end

--刷新武器列表(前端刷新使用)
---@param data table<integer, WeaponInfo> 武器数据列表
function Player:updateWeaponData(data)
    for key, value in pairs(data) do
        local weaponMap = self:getAllWeaponData()
        if not tablex.next(value) then
            weaponMap[key] = nil
        else
            --设置武器属性数据
            weaponMap[key] = self:setWeaponAttribute(value)
            -- if value.ownerId ~= 0 then
            --     local roleData = self:getPlayerHero(value.ownerId)
            --     self:updateHero(roleData)
            -- end
        end
    end
end

--装备武器
---@param charId integer 角色id
---@param partId integer 武器部位id
---@param weaponId integer 武器实例化id
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
function Player:setCharWeapon(charId, partId, weaponId, proto)
    --参数判空
    if not charId or not partId or not weaponId then
        return ActionFailReason.ParameterInvalid
    end

    --检测角色是否存在
    local roleData = self:getPlayerHero(charId)
    if not roleData then
        return ActionFailReason.HeroNoFind
    end

    --检测部位id是否合法
    if (partId > weaponPartMaxId) or (partId <= 0) then
        return ActionFailReason.ParameterInvalid
    end

    --检测武器第二部位是否解锁
    if partId == 2 and not self:getWeaponLockStateById(roleData.id) then
        return ActionFailReason.WeaponUnLockPart
    end

    --检测武器是否存在
    local weaponData = self:getWeaponDataById(weaponId)
    if not weaponData then
        return ActionFailReason.WeaponNoFind
    end

    local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
    if not weaponConfig then
        return ActionFailReason.CfgNotFind
    end
    local roleConfig = Config.GetCharacterInfo(charId)
    if not roleConfig then
        return ActionFailReason.CfgNotFind
    end
    --检测装备此武器是否超过角色负载
    local maxLoad = roleConfig.load + self:getWeaponLoadById(roleData.id)
    local useLoad = weaponConfig.load
    local otherPartId = partId == 1 and 2 or 1
    local otherWeaponId = roleData.carryWeapon[otherPartId] or 0
    local otherweaponData = self:getWeaponDataById(otherWeaponId)
    if otherweaponData then
        local otherweaponConfig = Config.GetWeaponInfo(otherweaponData.cid)
        if not otherweaponConfig then
            return ActionFailReason.CfgNotFind
        end
        useLoad = useLoad + otherweaponConfig.load
    end
    if maxLoad < useLoad then
        return ActionFailReason.WeaponOverLoad
    end

    --检测武器类型是否可被角色装备
    local weaponType = weaponConfig.type
    local needTypeList = roleConfig.useWeaponType
    if not tablex.contains(needTypeList, weaponType) then
        return ActionFailReason.WeaponTypeError
    end


    --如果对应位置穿着装备则进行互换
    -- local oldRoleData
    -- if weaponData.ownerId ~= 0 then
    --     oldRoleData = self:getPlayerHero(weaponData.ownerId)
    --     for part, id in pairs(oldRoleData.carryWeapon) do
    --         if id == weaponId then
    --             oldRoleData.carryWeapon[part] = roleData.carryWeapon[partId] or 0
    --             break
    --         end
    --     end
    -- end
    -- local oldWeaponData
    -- if roleData.carryWeapon[partId] and roleData.carryWeapon[partId] ~= 0 then
    --     oldWeaponData = self:getWeaponDataById(roleData.carryWeapon[partId])
    --     oldWeaponData.ownerId = weaponData.ownerId
    -- end

    --新版逻辑改为卸下装备，只为当前角色穿戴该装备
    ---@type ActionFailReason
    local ret = ActionFailReason.None
    if weaponData.ownerId ~= 0 then
        ret = self:removeCharWeapon(weaponId, proto)
    end
    if roleData.carryWeapon[partId] and roleData.carryWeapon[partId] ~= 0 then
        ret = self:removeCharWeapon(roleData.carryWeapon[partId], proto)
    end

    --最终穿戴数据
    roleData.carryWeapon[partId] = weaponId
    weaponData.ownerId = charId

    if proto then
        if not proto.weaponMap then
            proto.weaponMap = {}
        end
        proto.weaponMap[weaponData.id] = weaponData

        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[roleData.id] = roleData
    end

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogWeaponDevelop({
            weaponCid = weaponData.cid,
            weaponId = weaponData.id,
            weaponName = weaponConfig.name,
            weaponDevelopType = GE.WeaponDevelopType.OwnerId,
            before = 0,
            after = charId,
        }, self)

        --记录角色数据日志
        DataLogMgr.LogHeroDevelop({
            heroCid = charId,
            heroName = roleConfig.name,
            heroDevelopType = GE.HeroDevelopType.EquipWeapon,
            before = 0,
            after = weaponId,
        }, self)
    end

    return ret
end

--卸下武器
---@param weaponId integer 武器实例化id
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
function Player:removeCharWeapon(weaponId, proto)
    --参数判空
    if not weaponId then
        return ActionFailReason.ParameterInvalid
    end

    --检测武器是否存在
    local weaponData = self:getWeaponDataById(weaponId)
    if not weaponData then
        return ActionFailReason.WeaponNoFind
    end

    local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
    if not weaponConfig then
        return ActionFailReason.CfgNotFind
    end

    --检测角色是否存在
    local roleData = self:getPlayerHero(weaponData.ownerId)
    if not roleData then
        return ActionFailReason.HeroNoFind
    end

    for k, v in pairs(roleData.carryWeapon) do
        if v == weaponId then
            roleData.carryWeapon[k] = 0
            break
        end
    end

    local oldOwnerId = weaponData.ownerId
    weaponData.ownerId = 0

    if proto then
        if not proto.weaponMap then
            proto.weaponMap = {}
        end
        proto.weaponMap[weaponData.id] = weaponData

        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[roleData.id] = roleData
    end

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogWeaponDevelop({
            weaponCid = weaponData.cid,
            weaponId = weaponData.id,
            weaponName = weaponConfig.name,
            weaponDevelopType = GE.WeaponDevelopType.OwnerId,
            before = oldOwnerId,
            after = 0,
        }, self)

        --记录角色数据日志
        local roleConfig = Config.GetCharacterInfo(roleData)
        if roleConfig then
            DataLogMgr.LogHeroDevelop({
                heroCid = roleData,
                heroName = roleConfig.name,
                heroDevelopType = GE.HeroDevelopType.EquipWeapon,
                before = weaponId,
                after = 0,
            }, self)
        end
    end

    return ActionFailReason.None
end

--武器升级
---@param weaponId integer 武器实例化id
---@param useList CostInfo[]，有道具和武器两种
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
function Player:addWeaponExperience(weaponId, useList, proto)
    --参数判空
    if not weaponId or not useList or not tablex.next(useList) then
        return ActionFailReason.ParameterInvalid
    end
    --检测武器是否存在
    local weaponData = self:getWeaponDataById(weaponId)
    if not weaponData then
        return ActionFailReason.WeaponNoFind
    end

    local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
    if not weaponConfig then
        return ActionFailReason.CfgNotFind
    end

    --当前武器等级上限
    local weaponLvLimit = weaponConfig.levelMax
    if weaponData.level >= weaponLvLimit then
        return ActionFailReason.WeaponLevelMax
    end

    --检测升级消耗的道具正确性
    local addExp = 0
    local itemTemp = {}
    local weaponTemp = {}
    for k, expItem in pairs(useList) do
        if expItem.type == GE.RewardType.ItemProp then  --消耗狗粮
            --狗粮防重复检测
            if not itemTemp[expItem.id] then
                itemTemp[expItem.id] = expItem.id
            else
                return ActionFailReason.ParameterInvalid
            end

            local itemConfig = Config.GetItemInfo(expItem.id)
            if not itemConfig then
                return ActionFailReason.CfgNotFind
            end
            if not self:checkItemEnough(expItem) then
                return ActionFailReason.ItemNoEnough
            end
            local effectType = itemConfig.effect[1]
            if effectType ~= GE.ItemEffectType.weaponExp then
                return ActionFailReason.ParameterInvalid
            end
            local effectValue = itemConfig.effect[2]
            addExp = addExp + expItem.num * effectValue
        elseif expItem.type == GE.RewardType.Weapon then --消耗武器
            --武器防重复检测
            if not weaponTemp[expItem.id] then
                weaponTemp[expItem.id] = expItem.id
            else
                return ActionFailReason.ParameterInvalid
            end

            local useData = self:getWeaponDataById(expItem.id)
            if not useData then
                return ActionFailReason.WeaponNoFind
            end
            local isLock = self:checkWeaponLockState(expItem.id)
            if isLock then
                return ActionFailReason.WeaponIsLock
            end
            local useConfig = Config.GetWeaponInfo(useData.cid)
            if not useConfig then
                return ActionFailReason.CfgNotFind
            end
            if expItem.id == weaponId then
                return ActionFailReason.ParameterInvalid
            end
            if useData.ownerId ~= 0 then
                return ActionFailReason.WeaponIsEquip
            end
            local weaponExp = useData.exp
            addExp = addExp + useConfig.expValue + (weaponExp * weaponReturn)
        else
            return ActionFailReason.ParameterInvalid
        end
    end

    --升级资源消耗检测
    local costRes = {id = weaponResType, num = weaponUseResRatio * addExp}
    if not self:checkItemEnough(costRes) then
        return ActionFailReason.ItemNoEnough
    end

    --消耗升级物品
    for k, expItem in pairs(useList) do
        if expItem.type == GE.RewardType.ItemProp then  --消耗狗粮
            self:useItem(expItem.id, expItem.num, proto, GE.EventItemType.WeaponLevelUp, weaponId)
        elseif expItem.type == GE.RewardType.Weapon then --消耗武器
            self:deletePlayerWeapon(expItem.id, proto, GE.EventItemType.WeaponLevelUp, weaponId)
        end
    end

    --增加等级
    local oldExp = weaponData.exp
    local newExp = weaponData.exp + addExp


    --设置经验等级
    local limitEXP = 0
    --设置实际增加经验，关联到消耗资源
    local realAddEXP = addExp

    local weaponLevelList = Config.GetLevelconfigInfoByType(weaponConfig.levelupType)
    if not weaponLevelList then
        LuaLogger.es("未找到配置表:", weaponConfig.levelupType)
        --在特殊情况下，需要判断是否给默认信息？
        return ActionFailReason.CfgNotFind
    end

    --计算新等级
    local oldLevel = weaponData.level
    local newLevel = weaponData.level
    for k, v in pairs(weaponLevelList) do
        if newExp >= v.exp_sum then
            newLevel = v.level
            if newLevel == weaponLvLimit then
                limitEXP = v.exp_sum
                break
            end
        end
    end

    --计算升级
    local setExp = 0
    if newLevel > weaponData.level then
        setExp = newExp
        if limitEXP > 0 and setExp > limitEXP then
            realAddEXP = realAddEXP - (setExp - limitEXP)
            setExp = limitEXP
            --超出的经验值浪费掉
        end
    else
        setExp = newExp
    end

    --消耗资源
    self:useItem(weaponResType, weaponUseResRatio * realAddEXP, proto, GE.EventItemType.WeaponLevelUp, weaponId)

    --设置经验等级
    if newLevel > weaponData.level then
        --解锁及升级词条
        self:addOrLvUpWeaponAttribute(weaponData, weaponConfig, newLevel)
        weaponData.level = newLevel
        weaponData.exp = setExp
    else
        weaponData.exp = setExp
    end

    --任务埋点
    self:missionTrigger(GE.MissionFinishType.WeaponLevel, {count = 1}, proto)
    -- 触发攻击舰装等级任务
    self:missionTrigger(GE.MissionFinishType.AttackWeaponReachLevel, {level = weaponData.level}, proto)

    if proto then
        if not proto.weaponMap then
            proto.weaponMap = {}
        end
        proto.weaponMap[weaponData.id] = weaponData
    end

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogWeaponDevelop({
            weaponCid = weaponData.cid,
            weaponId = weaponData.id,
            weaponName = weaponConfig.name,
            weaponDevelopType = GE.WeaponDevelopType.Exp,
            before = oldExp,
            after = weaponData.exp,
        }, self)
        if oldLevel ~= newLevel then
            DataLogMgr.LogWeaponDevelop({
                weaponCid = weaponData.cid,
                weaponId = weaponData.id,
                weaponName = weaponConfig.name,
                weaponDevelopType = GE.WeaponDevelopType.Level,
                before = oldLevel,
                after = newLevel,
            }, self)
        end
    end

    return ActionFailReason.None
end

--根据等级解锁及升级武器词条
---@param weaponData WeaponInfo 武器数据
---@param weaponConfig WeaponTable 武器表数据
---@param newLevel integer 升级后的新等级
function Player:addOrLvUpWeaponAttribute(weaponData, weaponConfig, newLevel)
    local random = self:getRandom()
    local weaponLvUpNum = newLevel - weaponData.level
    local existGroupIdList = {}
    for _, attrData in pairs(weaponData.attributeList) do
        local attrId = attrData.id
        local entryConfig = Config.GetWeaponEntryInfo(attrId)
        if not entryConfig then
            LuaLogger.es("未找到配置表:", attrId)

            --在特殊情况下，需要判断是否给默认信息？
        else
            if not existGroupIdList[entryConfig.group] then
                existGroupIdList[entryConfig.group] = {}
            end
            table.insert(existGroupIdList[entryConfig.group], attrId)
        end
    end

    local nextLv = weaponData.level
    for i = 1, weaponLvUpNum do
        nextLv = nextLv + 1

        local isSpecialAdd = nextLv == weaponConfig.levelMax
        --武器满级时有额外规则
        if isSpecialAdd then
            self:weaponAttrSpecialAdd(existGroupIdList, weaponData, weaponConfig)
        else--普通规则
            local addAttrIndex = 0
            local isAddAttr = false
            for k, v in pairs(weaponConfig.entryUnlock) do
                if nextLv == v and tablex.size(existGroupIdList) < k then
                    isAddAttr = true
                    addAttrIndex = k
                end
            end
            --LuaLogger.ds(">>>>>isAddAttr<<<<", isAddAttr)
            if isAddAttr then--增加词条
                local newAttrId = self:randomSingleWeaponAttribute(existGroupIdList, addAttrIndex, weaponConfig)
                local attrData = {
                    id = newAttrId,
                    coefficient = weaponCoefficient[weaponConfig.rare][nextLv],
                    special = false,
                }
                tablex.insertproxy(weaponData.attributeList, attrData)
                local entryConfig = Config.GetWeaponEntryInfo(newAttrId)
                if not entryConfig then
                    LuaLogger.es("未找到配置表:", newAttrId)
                    --在特殊情况下，需要判断是否给默认信息？
                else
                    if not existGroupIdList[entryConfig.group] then
                        existGroupIdList[entryConfig.group] = {}
                    end
                    table.insert(existGroupIdList[entryConfig.group], newAttrId)
                end
            else--升级词条
                local groupWeight = {}
                for group, idList in pairs(existGroupIdList) do
                    local entryConfig = Config.GetWeaponEntryInfo(idList[1])
                    if not entryConfig then
                        LuaLogger.es("未找到配置表:", idList[1])
                        --在特殊情况下，需要判断是否给默认信息？
                    else
                        if tablex.size(idList) - 1 < entryConfig.levelupMax then
                            table.insert(groupWeight,{index = group, weight = 10})
                        end
                    end
                end
                local groupId = DLuaUtil.getRandomIndexLinear(groupWeight, random)
                local entryList = Config.GetWeaponEntryInfoByGroup(groupId)
                if not entryList then
                    LuaLogger.es("未找到配置表:", groupId)
                end
                --返回词条id
                local attrWeight = {}
                for _, v in pairs(entryList) do
                    table.insert(attrWeight,{index = v.id, weight = v.weight})
                end
                local addAttrId = DLuaUtil.getRandomIndexLinear(attrWeight, random)
                local attrData = {
                    id = addAttrId,
                    coefficient = weaponCoefficient[weaponConfig.rare][nextLv],
                    special = false,
                }
                tablex.insertproxy(weaponData.attributeList, attrData)
                local entryConfig = Config.GetWeaponEntryInfo(addAttrId)
                if not entryConfig then
                    LuaLogger.es("未找到配置表:", addAttrId)
                else
                    table.insert(existGroupIdList[entryConfig.group], addAttrId)
                end
            end
        end
    end
    --LuaLogger.ds(">>>>>!!!!<<<<", tablex.dump(existGroupIdList))
end

--武器满级时触发特殊升级
---@param existGroupIdList table<integer, boolean>[] 已存在词条id
---@param weaponData WeaponInfo 武器数据
---@param weaponConfig WeaponTable 武器表数据
function Player:weaponAttrSpecialAdd(existGroupIdList, weaponData, weaponConfig)
    --根据配置概率触发增加技能或词条暴击
    local random = self:getRandom()
    local randomNum = random:range(1, 100)
    local isAddSkill = randomNum <= weaponConfig.skillchance
    local weaponRare = weaponConfig.rare
    local maxLevel = weaponConfig.levelMax
    if isAddSkill then--增加技能
        local newAttrId = self:randomSingleWeaponAttribute({}, 5, weaponConfig)
        local attrData = {
            id = newAttrId,
            coefficient = 1,
            special = false,
        }
        tablex.insertproxy(weaponData.attributeList, attrData)
    else--词条暴击
        --根据已有词条随机一个词条组
        local groupWeight = {}
        for group, _ in pairs(existGroupIdList) do
            tablex.insertproxy(groupWeight,{index = group, weight = 10})
        end
        --返回词条组id
        local groupId = DLuaUtil.getRandomIndexLinear(groupWeight, random)
        local entryList = Config.GetWeaponEntryInfoByGroup(groupId)
        if not entryList then
            LuaLogger.es("未找到配置表:", groupId)
        else
            --根据组id随机一个词条暴击
            local attrWeight = {}
            for _, v in pairs(entryList) do
                tablex.insertproxy(attrWeight,{index = v.id, weight = v.weight})
            end
            local addAttrId = DLuaUtil.getRandomIndexLinear(attrWeight, random)
            local attrData = {
                id = addAttrId,
                coefficient = weaponCoefficient[weaponRare][maxLevel],
                special = true,
            }
            tablex.insertproxy(weaponData.attributeList, attrData)
        end
    end
end

--武器融合
---@param fuseList FuseWeaponInfo[] 融合材料数据
---@param proto UserInfo 用户数据
---@return ActionFailReason 错误码
---@return integer? 新武器数据
function Player:fusePlayerWeapon(fuseList, proto)
    local random = self:getRandom()
    --需要增加的词条组数量
    local needNum = weaponEntryMax
    --锁定词条组
    local lockGroupList = {}
    --已锁定的词条组
    local lockedGroupList = {}
    --随机词条组
    local randomGroupList = {}
    --技能词条
    local randomSkillList = {}
    --日志所需锁定词条数值
    local dataLogLockGroupData = {}
    --新装备数据初始化
    local newWeaponData = {
        id = 0,
        cid = 0,
        level = 0,
        exp = 0,
        ownerId = 0,
        isLock = false,
        accuracy = 0,
        quality = 0,
        attributeList = {},
    }

    --武器融合功能开启检测
    local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.WeaponFuse)
    if isOpen == GE.FunctionOpenState.Lock then
        return ActionFailReason.FunctionOpenNotOpen
    end

    --融合武器数量检测
    if tablex.size(fuseList) ~= fuseNeedWeaponNum then
        return ActionFailReason.ParameterInvalid
    end

    --检测武器并获得基础数据
    local lockAttrNum = 0
    local temp = {}
    for k, fuseData in pairs(fuseList) do
        if not fuseData.weaponId or not fuseData.lockGroupId then
            return ActionFailReason.ParameterInvalid
        end
        --防重复检测
        if not temp[fuseData.weaponId] then
            temp[fuseData.weaponId] = fuseData.weaponId
        else
            return ActionFailReason.ParameterInvalid
        end

        --判断武器是否存在
        local weaponData = self:getWeaponDataById(fuseData.weaponId)
        if not weaponData then
            return ActionFailReason.WeaponNoFind
        end

        --判断武器是否锁定
        local isLock = self:checkWeaponLockState(fuseData.weaponId)
        if isLock then
            return ActionFailReason.WeaponIsLock
        end

        --判断武器是否装备
        if weaponData.ownerId ~= 0 then
            return ActionFailReason.WeaponIsEquip
        end

        --武器表配置检测
        local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
        if not weaponConfig then
            return ActionFailReason.CfgNotFind
        end

        --判断武器是否满级
        if weaponData.level ~= weaponConfig.levelMax then
            return ActionFailReason.WeaponLevelNotEnough
        end

        --武器稀有度检测
        if weaponConfig.rare < fuseRareMin then
            return ActionFailReason.WeaponErrorRare
        end

        -- 词条组id检测
        if fuseData.lockGroupId < -1 or fuseData.lockGroupId == 0 then
            return ActionFailReason.ParameterInvalid
        end

        -- 锁定词条数量
        if fuseData.lockGroupId ~= -1 then
            lockAttrNum = lockAttrNum + 1
        end

        if k == 1 then
            -- newWeaponData = clone(weaponData)
            newWeaponData.cid = weaponData.cid
            newWeaponData.level = weaponData.level
            newWeaponData.exp = weaponData.exp
            -- newWeaponData.attributeList = {}
        else
            --判断武器cid是否一致
            if newWeaponData.cid ~= weaponData.cid then
                return ActionFailReason.ParameterInvalid
            end
        end
        newWeaponData.accuracy = math.max(newWeaponData.accuracy, weaponData.accuracy)
        newWeaponData.quality = math.max(newWeaponData.quality, weaponData.quality)

        --词条分组
        local weaponGroupIdList = {}
        for _, attrData in pairs(weaponData.attributeList) do
            local attrId = attrData.id
            local entryConfig = Config.GetWeaponEntryInfo(attrId)
            if not entryConfig then
                LuaLogger.es("未找到配置表:", attrId)
                return ActionFailReason.CfgNotFind
            end

            --区分普通词条与技能词条，技能词条单独随机
            if entryConfig.type == GE.WeaponEntryAttrType.specialSkill then
                table.insert(randomSkillList, attrData)
            else
                if not weaponGroupIdList[entryConfig.group] then
                    weaponGroupIdList[entryConfig.group] = {}
                end
                table.insert(weaponGroupIdList[entryConfig.group], attrData)
            end
        end

        --根据锁定id赋值对应词条
        if fuseData.lockGroupId ~= -1 then
            lockedGroupList[fuseData.lockGroupId] = true
            needNum = needNum - 1
            --检测锁定的词条组是否存在
            if not weaponGroupIdList[fuseData.lockGroupId] then
                return ActionFailReason.ParameterInvalid
            end
            for _, v in pairs(weaponGroupIdList[fuseData.lockGroupId]) do
                table.insert(lockGroupList,{
                    id = v.id,
                    coefficient = v.coefficient,
                    special = v.special,
                })
                --日志用锁定词条数据初始化
                dataLogLockGroupData[fuseData.lockGroupId] = fuseData.weaponId
            end
            weaponGroupIdList[fuseData.lockGroupId] = nil
        end

        --整合剩余普通词条
        for groupId, idDataList in pairs(weaponGroupIdList) do
            if not lockedGroupList[groupId] then
                local data = {
                    groupId = groupId,
                    groupList = idDataList,
                }
                table.insert(randomGroupList, data)
            end
        end
    end

    --判断道具是否足够
    if lockAttrNum ~= 0 then
        local entryLockConfig = WeaponEntryLock[lockAttrNum]
        --锁定词条数量检测
        if not entryLockConfig then
            return ActionFailReason.ParameterInvalid
        end
        local itemData = self:getItemById(entryLockConfig[1])
        if not itemData then
            return ActionFailReason.ItemNoFind
        end
        if itemData.num < entryLockConfig[2] then
            return ActionFailReason.ItemNoEnough
        end
    end

    --开始赋值新装备词条
    local attributeList = {}

    --锁定词条
    for k, v in pairs(lockGroupList) do
        table.insert(attributeList, v)
    end

    --日志用锁定词条数据
    local logNeedLockAttrData = {}
    local attrValueMap = self:setAttributeList(lockGroupList)
    for groupId, valueData in pairs(attrValueMap) do
        local weaponId = dataLogLockGroupData[groupId]
        logNeedLockAttrData[weaponId] = {
            type = valueData.type,
            value = valueData.value,
            attributeType = valueData.attributeType,
        }
    end

    --整理剩余普通词条
    local existGroupIdList = {}
    for k, v in pairs(randomGroupList) do
        if not existGroupIdList[v.groupId] then
            existGroupIdList[v.groupId] = {}
        end
        table.insert(existGroupIdList[v.groupId], v.groupList)
    end

    --每组随机一个词条list
    local existGroupIdList2 = {}
    for groupId, idDataList in pairs(existGroupIdList) do
        if tablex.size(idDataList) > 1 then
            local indexId = random:range(1, tablex.size(idDataList))
            table.insert(existGroupIdList2, idDataList[indexId])
        else
            table.insert(existGroupIdList2, idDataList[1])
        end
    end

    --随机剩余普通词条
    if needNum >= tablex.size(existGroupIdList2) then
        for k, v in pairs(existGroupIdList2) do
            for _, attrData in pairs(v) do
                table.insert(attributeList, attrData)
            end
        end
    else
        for i = 1, needNum do
            local indexId = random:range(1, tablex.size(existGroupIdList2))
            for _, attrData in pairs(existGroupIdList2[indexId]) do
                table.insert(attributeList, attrData)
            end
            table.remove(existGroupIdList2, indexId)
        end
    end

    --随机技能词条，技能最后随机，防止词条显示顺序问题
    local skillNum = tablex.size(randomSkillList)
    if skillNum > 0 then
        local indexId = random:range(1, skillNum)
        table.insert(attributeList, randomSkillList[indexId])
    end

    for _, v in pairs(attributeList) do
        tablex.insertproxy(newWeaponData.attributeList, {
            id = v.id,
            coefficient = v.coefficient,
            special = v.special,
        })
    end

    --日志需要，位置靠前
    local newId = self:newWeaponLimitId()
    newWeaponData.id = newId

    --删除消耗的武器
    for k, fuseData in pairs(fuseList) do
        local ret = self:deletePlayerWeapon(fuseData.weaponId, proto, GE.EventItemType.WeaponFuse, newId)
        if ret ~= ActionFailReason.None then
            return ret
        end
    end

    --消耗锁定词条道具
    local lockAttrNum = 0
    for k, fuseData in pairs(fuseList) do
        if fuseData.lockGroupId ~= -1 then
            lockAttrNum = lockAttrNum + 1
        end
    end
    if lockAttrNum ~= 0 then
        local entryLockConfig = WeaponEntryLock[lockAttrNum]
        self:useItem(entryLockConfig[1], entryLockConfig[2], proto, GE.EventItemType.WeaponFuse, newId)
    end

    --新增武器
    local weaponMap = self:getAllWeaponData()
    weaponMap[newId] = newWeaponData
    if proto then
        if not proto.weaponMap then
            proto.weaponMap = {}
        end
        proto.weaponMap[newId] = newWeaponData
    end

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogWeaponAdd({
            weaponCid = newWeaponData.cid,
            weaponId = newId,
            weaponName = Config.GetWeaponInfo(newWeaponData.cid).name,
            balance_channel_id = GE.EventItemType.WeaponFuse,
            balance_channel_detail = logNeedLockAttrData,
        }, self)
    end

    return ActionFailReason.None, newId
end

---@class EntryInfo
---@field id integer 词条id
---@field value number 词条值
---@field type integer 词条类型
---@field attributeType integer 词条属性类型
---@field isSpecial boolean 是否为特殊词条

--计算武器属性
---@param weaponData WeaponInfo 武器数据
---@return WeaponInfo 处理完成的武器数据
function Player:setWeaponAttribute(weaponData)
    ---@type table<integer, EntryInfo>
    local attrValueMap = self:setAttributeList(weaponData.attributeList)
    local weaponConfig = Config.GetWeaponInfo(weaponData.cid)

    if not weaponConfig then
        LuaLogger.es("未找到武器配置表:", weaponData.cid)
        return weaponData
    end

    --这部分信息是客户端需要使用，在服务器采用了其他的数据结构来存储
    weaponData.attributeValue = attrValueMap
    weaponData.rare = weaponConfig.rare
    weaponData.load = weaponConfig.load
    weaponData.point = math.floor((weaponConfig.bulletNum * weaponData.accuracy * weaponData.quality / 1000))

    return weaponData
end

--计算词条属性
---@param attributeList table<integer,WeaponEntry> 武器数据
---@return table 处理完成的武器数据
function Player:setAttributeList(attributeList)
    local attrOrderId = 1
    local attrValueMap = {}
    for _, attrData in pairs(attributeList) do
        local attrId = attrData.id
        local entryConfig = Config.GetWeaponEntryInfo(attrId)

        if not entryConfig then
            LuaLogger.es("未找到武器属性配置表:", attrId)
        else
            if not attrValueMap[entryConfig.group] then
                attrValueMap[entryConfig.group] = {
                    id = attrOrderId,
                    value = 0,
                    type = entryConfig.type,
                    attributeType = entryConfig.attributeId,
                    isSpecial = false,
                }
                attrOrderId = attrOrderId + 1
            end
            attrData.coefficient = math.floor(attrData.coefficient * 10 + 0.5) / 10
            local actualValue = entryConfig.attribute * attrData.coefficient
            attrValueMap[entryConfig.group].value = attrValueMap[entryConfig.group].value + actualValue
            attrValueMap[entryConfig.group].isSpecial = attrValueMap[entryConfig.group].isSpecial or attrData.special
        end
    end
    --数值向上取整
    for _, attrData in pairs(attrValueMap) do
        if attrData.type == GE.WeaponEntryAttrType.integer then--数值
            attrData.value = math.ceil(attrData.value)
        elseif attrData.type == GE.WeaponEntryAttrType.percentage then--百分比
            attrData.value = math.ceil(attrData.value * 10) / 10
        end
    end
    return attrValueMap
end

--建筑内 - 武器生产
---@param blueprintId integer 蓝图id
---@param count integer 生产数量
---@param proto UserInfo 用户数据
function Player:weaponProduction(blueprintId, count, proto)
    --功能开启检测 - 武器制造是否开启
    local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.WeaponMake)
    if isOpen == GE.FunctionOpenState.Lock then
        return ActionFailReason.FunctionOpenNotOpen
    end

    --参数判空
    if not blueprintId or not count or count <= 0 then
        return ActionFailReason.ParameterInvalid
    end
    --判断蓝图配置是否存在
    local blueprintConfig = Config.GetWeaponProductionInfo(blueprintId)
    if blueprintConfig == nil then
        --LuaLogger.es("未找到武器生产图纸配置表:", blueprintId)
        return ActionFailReason.CfgNotFind
    end

    --判断引导蓝图是否已完成
    local userData = self:getUserData()
    if blueprintConfig.useType == GE.BlueprintType.Guide and userData.GotGuideBlueprintAward then
        return ActionFailReason.ParameterInvalid
    end

    --判断蓝图是否充足（item）  无限类型不判断
    local blueprintData = self:getItemById(blueprintConfig.itemId)
    if blueprintConfig.useType ~= GE.BlueprintType.infnity then
        if blueprintData == nil then
            return ActionFailReason.ItemNoFind
        end
        if blueprintData.num < count then
            return ActionFailReason.ItemNoEnough
        end
    end

    --需要计算角色提供的增益对资源的影响
    local costRes = {}
    local tagEffectList = {}
    local finalTagList = {}
    local tagList = self:getHomeSignal(GE.CoustructionEnum.Armory)
    for _, value in pairs(tagList) do
        local signalConfig = Config.SignalInfo(value.signalId)
        if signalConfig then
            local group = signalConfig.group
            local priority = signalConfig.priority
            local existingTag = tagEffectList[group]

            if not existingTag or priority > existingTag.priority then
                tagEffectList[group] = {
                    tagId = signalConfig.id,
                    group = group,
                    priority = priority,
                    effect = signalConfig.effect
                }
            end
        else
            LuaLogger.es("signalConfig配置未找到：", value.signalId)
        end
    end

    ---@class TagEffectData
    ---@field tagId integer 效果id
    ---@field group integer 效果组
    ---@field priority integer 效果优先级
    ---@field effect table<integer, integer> 效果组

    for _, tagData in pairs(tagEffectList) do
        local effect = tagData.effect
        if not tablex.find(finalTagList, effect) then
            table.insert(finalTagList, effect)
        end
    end

    --根据物品id查找减少资源消耗效果
    ---@param itemId integer
    ---@return TagEffectData?
    local function findEffectExpendReductionByItemId(itemId)
        for _, tagData in pairs(finalTagList) do
            if tagData[1] ==  GE.TagEffectType.expendReduction then
                if tagData[2] == itemId then
                    return tagData
                end
            end
        end
        return nil
    end

    --根据效果类型查找生成武器加成效果
    ---@param effectType integer
    ---@return TagEffectData?
    local function findEffectByType(effectType)
        for _, tagData in pairs(finalTagList) do
            if tagData[1] == effectType then
                return tagData
            end
        end
        return nil
    end

    --确认需要哪些资源
    for _, value in pairs(blueprintConfig.commonCost) do
        local effectMsg = findEffectExpendReductionByItemId(value[1])
        local effectPercent = effectMsg and effectMsg[3] or 0
        local newNeedCount = (value[2] - math.floor(value[2] * effectPercent / 100)) * count
        table.insert(costRes, {id = value[1], num = newNeedCount})
    end
    table.insert(costRes, {id = blueprintConfig.ExtraCost[1], num = blueprintConfig.ExtraCost[2] * count})

    --判断资源是否充足
    for _, costData in pairs(costRes) do
        local itemData = self:getItemById(costData.id)
        if itemData == nil then
            return ActionFailReason.ItemNoFind
        end
        if itemData.num < costData.num then
            return ActionFailReason.ItemNoEnough
        end
    end

    --判断蓝图类型，无限类型不消耗
    if blueprintConfig.useType ~= GE.BlueprintType.infnity then
        --扣除蓝图
        self:useItem(blueprintConfig.itemId, count, proto, GE.EventItemType.WeaponProduce, blueprintId)
    end

    --扣除资源
    for _, costData in pairs(costRes) do
        self:useItem(costData.id, costData.num, proto, GE.EventItemType.WeaponProduce, blueprintId)
    end

    --查找是否有概率提升武器产出的效果
    local random = self:getRandom()
    local addCount = 0
    local effectWeaponGainUp = findEffectByType(GE.TagEffectType.weaponGainUp)
    if effectWeaponGainUp then                                  --如果有多生成的效果
        local effectValue = effectWeaponGainUp[2]    --概率，百分制
        local makeCount = effectWeaponGainUp[3]      --多生产的数量
        for i = 1, count do
            if random:range(1, 100) <= effectValue then
                addCount = addCount + makeCount
            end
        end
    end

    --引导类型完成时记录
    if blueprintConfig.useType == GE.BlueprintType.Guide then
        userData.GotGuideBlueprintAward = true
        if not proto.userData then
            proto.userData = {}
        end
        proto.userData.GotGuideBlueprintAward = userData.GotGuideBlueprintAward
    end

    self:missionTrigger(GE.MissionFinishType.MakeWeapon, {count = count}, proto)
    --整合玩家需求的生产数量 + 效果额外生产数量
    count = count + addCount
    self:ActivateEventTrigger(GE.EventTriggerType.CreateWeapon,count, proto)
    --添加武器
    local allRewardList = {}
    for i = 1, count do
        local rewardList = self:getRandomAward(blueprintConfig.produce)
        allRewardList = tablex.combine(allRewardList, self:addRewardList(rewardList, proto, GE.EventItemType.WeaponProduce, blueprintId))
        
        if blueprintConfig.ExtraProduce ~= {}  then
            for _, produceId in pairs(blueprintConfig.ExtraProduce) do
                local produceData = self:getRandomAward(produceId)
                allRewardList = tablex.combine(allRewardList, self:addRewardList(produceData, proto, GE.EventItemType.WeaponProduce, blueprintId))
            end
        end
    end

    return ActionFailReason.None, allRewardList
end

--获得武器属性加成
---@param carryWeapon table<integer, integer> 装备武器列表
---@param natureList table<string, number> 基础属性列表
---@param effectiveSkill table<integer, integer> 有效技能列表
---@return number 武器伤害加成比例
---@return table<string, number> 武器属性加成
function Player:getWeaponBonus(carryWeapon,natureList, effectiveSkill)
    local weaponRatio = 0
    local weaponValue = {
        hp = 0, bombard = 0, torpedo = 0, armor = 0, evade = 0, airdefense = 0, lucky = 0
    }

    for _, value in pairs(carryWeapon) do
        local weaponData = self:getWeaponDataById(value)
        local weaponNature = {}
        if weaponData and tablex.next(weaponData) then
            local weaponConfig = Config.GetWeaponInfo(weaponData.cid)

            if weaponConfig then
                weaponRatio = weaponRatio + ((weaponData.accuracy * weaponData.quality * weaponConfig.bulletNum) / 1000000)
                weaponNature = self:setWeaponAttribute(weaponData)
                if weaponNature and tablex.next(weaponNature) then
                    for _, v in pairs(weaponNature.attributeValue) do
                        if v.attributeType == 99 then
                            table.insert(effectiveSkill, v.value)
                        end
                        local basicValue = natureList[GE.NatureTypeName[v.attributeType]]
                        if v.type == GE.WeaponEntryAttrType.integer then --整数
                            weaponValue[GE.NatureTypeName[v.attributeType]] = weaponValue[GE.NatureTypeName[v.attributeType]] + v.value
                        elseif v.type == GE.WeaponEntryAttrType.percentage then  --百分比
                            weaponValue[GE.NatureTypeName[v.attributeType]] = weaponValue[GE.NatureTypeName[v.attributeType]] + (basicValue * (v.value / 100))
                        end
                    end
                end
            end
        end
    end

    return weaponRatio, weaponValue
end


return Player