-- Desc: 玩家装备相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end


--装备部位最大ID
local equipPartMaxId = 4
--装备数量上限
local equipNumMax = Config.GetConfigInfo("equipNumMax") or 999
--装备经验回收比例
local equipReturn = Config.GetConfigInfo("equipReturn") or 0.6
--装备强化货币与经验比例（{经验，货币}）
local equipExpCost = Config.GetConfigInfo("equipExpCost") or 1
--装备强化货币
local equipCurrency = Config.GetConfigInfo("equipCurrency") or 100003


--获取全部装备信息
function Player:getAllEquipData()
    return self.equipMap
end

--获取装备数量
function Player:getEquipNum()
    local equipMap = self:getAllEquipData()
    return tablex.size(equipMap)
end

--根据星级查找装备
---@param Star number 星级
---@return EquipInfo[] 装备列表
function Player:getEquipByStar(Star)
    local temp = {}
    local equipMap = self:getAllEquipData()
    for _, value in pairs(equipMap) do
        if value.star == Star then
            table.insert(temp, value)
        end
    end
    return temp
end

--根据位置获取装备列表
---@param partID number 武器或装备类型ID
---@param roleWearType number[] 可装备的部位类型列表
---@return EquipInfo[] 装备列表
function Player:getEquipListByPart(partID, roleWearType)
    local temp = {}

    --如果没有可装备的部位类型列表，则返回空列表
    if not roleWearType then
        return temp
    end

    local equipMap = self:getAllEquipData()
    for _, value in pairs(equipMap) do
        local equipData = Config.GetEquipmentInfo(value.cid)
        if not equipData then
            LuaLogger.es("装备配置表中没有找到对应的装备配置", value.cid)
            return temp
        end

        for _, typeIndex in pairs(roleWearType) do
            if equipData.equipWearType == typeIndex then
                for _,v in pairs(equipData.part) do
                    if v == partID then
                        table.insert(temp, value)
                    end
                end
            end
        end
    end

    return temp
end

--刷新装备列表
---@param data table<integer, EquipInfo> 装备数据表
function Player:updateEquipData(data)
    local equipMap = self:getAllEquipData()
    for key, value in pairs(data) do
        if not tablex.next(value) then
            equipMap[key] = nil
        else
            equipMap[key] = value
            -- if value.ownerId ~= 0 then
            --     local roleData = self:getPlayerHero(value.ownerId)
            --     self:updateHero(roleData)
            -- end
        end
    end
end

--通过实例化id查找装备信息
---@param id number 实例ID
---@return EquipInfo 装备信息
function Player:getEquipDataByid(id)
    local equipMap = self:getAllEquipData()
    return equipMap[id]
end

--通过配置id查找装备信息
---@param cid number 配置ID
---@return EquipInfo[] 装备信息
function Player:getEquipDataByCid(cid)
    local temp = {}

    local equipMap = self:getAllEquipData()
    for _, v in pairs(equipMap) do
        if v.cid == cid then
            table.insert(temp, v)
        end
    end

    return temp
end

--添加装备
---@param cid integer 配置ID
---@param proto UserInfo 玩家信息差量更新结构
---@param balance_channel_id integer 产出消耗渠道
---@param balance_channel_detail integer 产出消耗渠道详细内容
---@return ActionFailReason
---@return integer?
function Player:addPlayerEquip(cid, proto, balance_channel_id, balance_channel_detail)
    --判断装备数量是否超过上限
    local equipNum = self:getEquipNum()
    if equipNum >= equipNumMax then
        return ActionFailReason.EquipWarehouseFull
    end

    --配置表检测
    local equipConfig = Config.GetEquipmentInfo(cid)
    if not equipConfig then
        return ActionFailReason.CfgNotFind
    end

    --装备是否开放,0未开放，1开放
    if equipConfig.isOpen ~= 1 then
        LuaLogger.es("Equip is not open:", cid)
        return ActionFailReason.CfgError
    end

    --实例化id检测
    local equipMap = self:getAllEquipData()
    local newId = self:newEquipLimitId()
    if equipMap[newId] then
        return ActionFailReason.ParameterInvalid
    end

    --添加装备
    equipMap[newId] = self:initEquipInfo(cid, newId)

    if proto then
        if not proto.equipMap then
            proto.equipMap = {}
        end
        proto.equipMap[newId] = self:getEquipDataByid(newId)
    end
    local newEquip = self:getEquipDataByid(newId)
    self:missionTrigger(GE.MissionFinishType.OwnEquipCountByLevelPartRank, {level = newEquip.level, part = equipConfig.part[1], rank = equipConfig.quality}, proto)
    -- 如果是支援舰装，触发支援舰装任务
    if equipConfig.equipType == GE.EquipType.equip then
        self:missionTrigger(GE.MissionFinishType.SupportEquipReachLevel, {level = newEquip.level}, proto)
    end

    --记录装备图鉴
    self:saveEquipHandbookData(cid, proto)

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogEquipAdd({
            equipCid = cid,
            equipId = newId,
            equipName = equipConfig.name,
            balance_channel_id = balance_channel_id,
            balance_channel_detail = balance_channel_detail,
        }, self)
    end

    return ActionFailReason.None, newId
end

--初始化装备信息
---@param cid integer 装备表id
---@param newId integer 实例化id
---@return EquipInfo
function Player:initEquipInfo(cid, newId)
    local equipConfig = Config.GetEquipmentInfo(cid)
    --构建数据
    ---@type EquipInfo
    local newEquipData = {
        id = newId,
        cid = cid,
        level = 1,
        exp = 0,
        star = equipConfig and equipConfig.basicStar or 1,
        ownerId = 0,
        isLock = equipConfig and equipConfig.equipType == GE.EquipType.sp or false,
    }
    return newEquipData
end

--删除装备
---@param id integer 装备的实例化id
---@param proto UserInfo 玩家信息差量更新结构
---@param balance_channel_id integer 产出消耗渠道
---@param balance_channel_detail any 产出消耗渠道详细内容
---@return ActionFailReason 返回结果是否成功，如有错误返回错误码
function Player:deletePlayerEquip(id, proto, balance_channel_id, balance_channel_detail)
    local equipData = self:getEquipDataByid(id)
    if not equipData then
        return ActionFailReason.EquipNoFind
    end

    local equipConfig = Config.GetEquipmentInfo(equipData.cid)
    if not equipConfig then
        return ActionFailReason.CfgNotFind
    end

    local equipMap = self:getAllEquipData()
    equipMap[id] = nil

    --减少装备图鉴数量
    self:saveEquipHandbookData(equipData.cid, proto, -1)

    if proto then
        if not proto.equipMap then
            proto.equipMap = {}
        end
        proto.equipMap[id] = {}
    end

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogEquipConsume({
            equipCid = equipData.cid,
            equipId = id,
            equipName = equipConfig.name,
            balance_channel_id = balance_channel_id,
            balance_channel_detail = balance_channel_detail,
        }, self)
    end

    return ActionFailReason.None
end

--新建一个装备实例化id
---@return integer
function Player:newEquipLimitId()
    local onlyServerData = self:getOnlyServerData()
    onlyServerData.nowEquipLimitId = onlyServerData.nowEquipLimitId + 1
    return onlyServerData.nowEquipLimitId
end

--判断装备是否锁定
---@param equipId integer 装备的实例化id
---@return boolean 返回结果是否锁定
function Player:checkEquipLockState(equipId)
    local equipData = self:getEquipDataByid(equipId)
    if not equipData then
        return false
    end
    return equipData.isLock
end

--装备升级
---@param equipId integer 装备的实例化id
---@param useList CostInfo[] 消耗物品结构
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason 返回结果是否成功，如有错误返回错误码
function Player:addEquipExperience(equipId, useList, proto)
    --参数判空
    if not equipId or not useList or not tablex.next(useList) then
        return ActionFailReason.ParameterInvalid
    end

    local equipData = self:getEquipDataByid(equipId)
    if not equipData then
        return ActionFailReason.EquipNoFind
    end

    local equipConfig = Config.GetEquipmentInfo(equipData.cid)
    if not equipConfig then
        return ActionFailReason.CfgNotFind
    end

    local nowEquipLvLimit = equipConfig.levelMax[equipData.star]
    if equipData.level >= nowEquipLvLimit then
        return ActionFailReason.EquipLevelMax
    end

    --消耗升级物品
    local itemTemp = {}
    local equipTemp = {}
    local addExp = 0
    for _, expItem in pairs(useList) do
        if not expItem or not expItem.id then
            return ActionFailReason.ParameterInvalid
        end

        if expItem.type == GE.RewardType.ItemProp then  --消耗狗粮
            --狗粮防重复验证
            if not itemTemp[expItem.id] then
                itemTemp[expItem.id] = expItem
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

            if itemConfig.effect[1] ~= GE.ItemEffectType.equipExp then
                return ActionFailReason.NotLevelUpMaterial
            end

            local effectValue = itemConfig.effect[2]
            addExp = addExp + expItem.num * effectValue
        elseif expItem.type == GE.RewardType.Equipment then --消耗装备
            --装备防重复验证
            if not equipTemp[expItem.id] then
                equipTemp[expItem.id] = expItem
            else
                return ActionFailReason.ParameterInvalid
            end

            local useData = self:getEquipDataByid(expItem.id)
            if not useData then
                return ActionFailReason.EquipNoFind
            end

            if useData.isLock then
                return ActionFailReason.EquipIsLock
            end

            local useConfig = Config.GetEquipmentInfo(useData.cid)
            if not useConfig then
                return ActionFailReason.CfgNotFind
            end
            if useConfig.equipType == GE.EquipType.sp then
                return ActionFailReason.EquipIsLock
            end
            if expItem.id == equipId then
                return ActionFailReason.ParameterInvalid
            end
            if useData.ownerId ~= 0 then
                return ActionFailReason.EquipIsEquip
            end

            local equipExp = useData.exp
            addExp = addExp + useConfig.expValue + equipExp * equipReturn
        else
            return ActionFailReason.ParameterInvalid
        end
    end

    --升级资源消耗检测
    local costRes = {id = equipCurrency, num = equipExpCost * addExp}
    if not self:checkItemEnough(costRes) then
        return ActionFailReason.CurrencyNoEnough
    end

    --消耗升级物品
    for k, expItem in pairs(useList) do
        if expItem.type == GE.RewardType.ItemProp then  --消耗狗粮
            self:useItem(expItem.id, expItem.num, proto, GE.EventItemType.EquipLevelUp, equipId)
        elseif expItem.type == GE.RewardType.Equipment then --消耗武器
            self:deletePlayerEquip(expItem.id, proto, GE.EventItemType.EquipLevelUp, equipId)
        end
    end

    --增加等级
    local oldExp = equipData.exp
    local oldLevel = equipData.level
    local newExp = equipData.exp + addExp

    --计算经验等级
    local limitEXP = 0
    local realAddEXP = addExp
    local setLevel, setExp = 0, 0
    local equipLvGroup = equipConfig.levelGroup
    local equipLevelList = Config.GetEquipLevelByLevelGroup(GE.EquipLevelType.Normal, equipLvGroup)
    for _, v in pairs(equipLevelList) do
        --装备达到当前突破上限
        if v.equipLevel == nowEquipLvLimit then
            limitEXP = v.expTotal
        end
        if limitEXP ~= 0 and newExp >= limitEXP then
            realAddEXP = limitEXP - equipData.exp
            setLevel = nowEquipLvLimit
            setExp = limitEXP
            break
        else
            if newExp < v.expTotal then
                setLevel = v.equipLevel - 1
                setExp = newExp
                break
            end
        end
    end

    --消耗资源
    local ret = self:useItem(equipCurrency, equipExpCost * realAddEXP, proto, GE.EventItemType.EquipLevelUp, equipId)
    if ret ~= ActionFailReason.None then
        return ret
    end

    --更新经验等级
    equipData.level = setLevel
    equipData.exp = setExp

    ---触发升级装备相关的任务
    self:missionTrigger(GE.MissionFinishType.EquipLevel, {count = 1}, proto)
    self:missionTrigger(GE.MissionFinishType.OwnEquipCountByLevelPartRank, {level = equipData.level, part = equipConfig.part[1], rank = equipConfig.quality}, proto)
    -- 如果是支援舰装，触发支援舰装任务
    if equipConfig.equipType == GE.EquipType.equip then
        self:missionTrigger(GE.MissionFinishType.SupportEquipReachLevel, {level = equipData.level}, proto)
    end


    if proto then
        if not proto.equipMap then
            proto.equipMap = {}
        end
        proto.equipMap[equipData.id] = equipData
    end

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogEquipDevelop({
            equipCid = equipData.cid,
            equipId = equipData.id,
            equipName = equipConfig.name,
            equipDevelopType = GE.EquipDevelopType.Exp,
            before = oldExp,
            after = equipData.exp,
        }, self)
        if oldLevel ~= equipData.level then
            DataLogMgr.LogEquipDevelop({
                equipCid = equipData.cid,
                equipId = equipData.id,
                equipName = equipConfig.name,
                equipDevelopType = GE.EquipDevelopType.Level,
                before = oldLevel,
                after = equipData.level,
            }, self)
        end
    end

    return ActionFailReason.None
end

--装备升星(突破)
---@param equipId integer 装备的实例化id
---@param useIdList integer[] 消耗的装备实例化id列表
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason 返回结果是否成功，如有错误返回错误码
function Player:addEquipStar(equipId, useIdList, proto)
    --参数判空
    if not equipId or not useIdList or not tablex.next(useIdList) then
        return ActionFailReason.ParameterInvalid
    end

    local equipData = self:getEquipDataByid(equipId)
    if not equipData then
        return ActionFailReason.EquipNoFind
    end

    local equipConfig = Config.GetEquipmentInfo(equipData.cid)
    if not equipConfig then
        return ActionFailReason.CfgNotFind
    end

    --判断是否可以突破
    if equipData.star - 1 >= #equipConfig.levelMax or equipData.level ~= equipConfig.levelMax[equipData.star] then
        return ActionFailReason.EquipLevelNotEnough
    end

    --获取突破等级配置
    local equipLevelCfg = Config.GetEquipLevelByBreakGroup(GE.EquipLevelType.Advanced, equipConfig.breakGroup, equipData.star + 1)
    if not equipLevelCfg then
        return ActionFailReason.CfgNotFind
    end

    --检测消耗的装备
    local temp = {}
    for _, useId in pairs(useIdList) do
        --判断消耗的装备是否重复
        if not temp[useId] then
            temp[useId] = useId
        else
            return ActionFailReason.ParameterInvalid
        end

        local useData = self:getEquipDataByid(useId)
        if not useData then
            return ActionFailReason.EquipNoFind
        end

        --判断装备是否锁定
        if self:checkEquipLockState(useId) then
            return ActionFailReason.EquipIsLock
        end

        --判断消耗装备不能是自己
        if useId == equipId then
            return ActionFailReason.ParameterInvalid
        end

        --判定装备是否已穿戴
        if useData.ownerId ~= 0 then
            return ActionFailReason.EquipIsEquip
        end

        --判断是否为正确的突破材料
        local isCan = false
        for _, canUseCid in pairs(equipConfig.breakMaterial) do
            if useData.cid == canUseCid then
                isCan = true
            end
        end
        if not isCan then
            return ActionFailReason.NotStarUpMaterial
        end
    end

    --检测突破所需材料
    local itemList = equipLevelCfg.breakCurrency
    if not self:checkItemListEnough2(itemList) then
        return ActionFailReason.ItemNoEnough
    end

    --检测突破资源消耗
    local costRes = {id = equipCurrency, num = equipLevelCfg.breakGoldCost}
    if not self:checkItemEnough(costRes) then
        return ActionFailReason.CurrencyNoEnough
    end

    --扣除装备突破所需材料
    self:useItemList(itemList, proto, GE.EventItemType.EquipStarUp, equipId)
    for _, useId in pairs(useIdList) do
        ---删除被用于升星的装备数据
        local ret = self:deletePlayerEquip(useId, proto, GE.EventItemType.EquipStarUp, equipId)
        if ret ~= ActionFailReason.None then
            return ret
        end
    end

    --消耗资源
    local ret = self:useItem(equipCurrency, equipLevelCfg.breakGoldCost, proto, GE.EventItemType.EquipStarUp, equipId)
    if ret ~= ActionFailReason.None then
        return ret
    end

    --设置新星级
    local oldStar = equipData.star
    equipData.star = equipData.star + 1

    ---触发升星装备相关的任务
    self:missionTrigger(GE.MissionFinishType.EquipStarUp, {count = 1}, proto)

    if proto then
        if not proto.equipMap then
            proto.equipMap = {}
        end
        proto.equipMap[equipData.id] = equipData
    end

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogEquipDevelop({
            equipCid = equipData.cid,
            equipId = equipData.id,
            equipName = equipConfig.name,
            equipDevelopType = GE.EquipDevelopType.Star,
            before = oldStar,
            after = equipData.star,
        }, self)
    end

    return ActionFailReason.None
end

--装备分解
---@param idList integer[] 分解的装备实例化id列表
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason, RewardInfo[]? 返回结果是否成功，如有错误返回错误码
function Player:decomposePlayerEquip(idList, proto)
    local allReward = {}

    --参数判空
    if not idList or not tablex.next(idList) then
        return ActionFailReason.ParameterInvalid
    end

    --正确性检测
    local temp = {}
    for _, id in pairs(idList) do
        --防重复检测
        if not temp[id] then
            temp[id] = id
        else
            return ActionFailReason.ParameterInvalid
        end
        local equipData = self:getEquipDataByid(id)
        if not equipData then
            return ActionFailReason.EquipNoFind
        end
        local isLock = self:checkEquipLockState(id)
        if isLock then
            return ActionFailReason.EquipIsLock
        end
        local equipConfig = Config.GetEquipmentInfo(equipData.cid)
        if not equipConfig then
            return ActionFailReason.CfgNotFind
        end
        if equipConfig.equipType == GE.EquipType.sp then
            return ActionFailReason.EquipIsLock
        end
        if equipData.ownerId ~= 0 then
            return ActionFailReason.EquipIsEquip
        end

        --计算分解奖励
        ---@type integer[] 分解可获得奖励配置列表
        local decomposeReward = clone(equipConfig.decompose)
        if decomposeReward[equipData.star] ~= nil then
            table.insert(allReward, decomposeReward[equipData.star])
        end
        --追加装备按等级返还的经验材料
        local equipExpConfig = Config.GetEquipLevelByGroupAndLevel(GE.EquipLevelType.Normal, equipConfig.levelGroup, equipData.level)
        if equipExpConfig and equipExpConfig.decompose then
            for _, expReward in pairs(equipExpConfig.decompose) do
                table.insert(allReward, expReward)
            end
        end
    end

    --允许分解部分装备
    for _, id in pairs(idList) do
        --删除装备
        self:deletePlayerEquip(id, proto, GE.EventItemType.EquipDecompose, 0)
    end
    --添加分解奖励
    local rewardList = self:addRewardList(allReward, proto, GE.EventItemType.EquipDecompose, #idList)
    --合并奖励
    rewardList = self:mergeRewardList(rewardList)

    return ActionFailReason.None, rewardList
end

--根据角色ID和部位ID获取装备信息
---@param charId integer 角色id
---@param partID integer 部位id
---@return integer? 装备实例化id
function Player:getEquipByPart(charId, partID)
    local roleData = self:getPlayerHero(charId)
    if roleData then
        LuaLogger.ds("roleData.carryEquip[partID]", roleData.carryEquip[partID])
        return roleData.carryEquip[partID]
    end
end

--装备穿戴
---@param charId integer 角色id
---@param partId integer 部位id
---@param equipId integer 装备实例化id
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason 是否成功，如有错误返回错误码
function Player:setCharEquip(charId, partId, equipId, proto)
    --参数判空
    if not charId or not isnumber(partId) or not equipId then
        return ActionFailReason.LackParameter
    end
    local roleData = self:getPlayerHero(charId)
    if not roleData then
        return ActionFailReason.HeroNoFind
    end

    local equipData = self:getEquipDataByid(equipId)
    if not equipData then
        return ActionFailReason.EquipNoFind
    end

    --判断装备部位是否正确
    if partId <= 0 or partId > equipPartMaxId then
        return ActionFailReason.ParameterInvalid
    end

    local equipConfig = Config.GetEquipmentInfo(equipData.cid)
    if not equipConfig then
        return ActionFailReason.CfgNotFind
    end
    --判断装备部位与穿戴部位是否匹配
    local needPartList = equipConfig.part
    if not tablex.contains(needPartList, partId) then
        return ActionFailReason.ParameterInvalid
    end
    --检测装备类型是否可被角色穿戴
    local roleConfig = Config.GetCharacterInfo(charId)
    if not roleConfig then
        return ActionFailReason.CfgNotFind
    end
    local equipType = equipConfig.equipWearType
    local needTypeList = roleConfig.useEquipType
    if not tablex.contains(needTypeList, equipType) then
        return ActionFailReason.EquipLTypeError
    end

    --如果对应位置穿着装备则进行互换
    local oldRoleData
    if equipData.ownerId ~= 0 then
        oldRoleData = self:getPlayerHero(equipData.ownerId)
        oldRoleData.carryEquip[partId] = roleData.carryEquip[partId] or 0
        --记录数据日志
        if DataLogMgr then
            local heroCfg = Config.GetCharacterInfo(equipData.ownerId)
            if heroCfg then
                DataLogMgr.LogHeroDevelop({
                    heroCid = heroCfg.id,
                    heroName = heroCfg.name,
                    heroDevelopType = GE.HeroDevelopType.EquipWeapon,
                    before = equipId,
                    after = oldRoleData.carryEquip[partId],
                }, self)
            end
        end
    end
    local oldEquipData
    if roleData.carryEquip[partId] and roleData.carryEquip[partId] ~= 0 then
        oldEquipData = self:getEquipDataByid(roleData.carryEquip[partId])
        local oldOwnerId = oldEquipData.ownerId
        oldEquipData.ownerId = equipData.ownerId

        --记录数据日志
        if DataLogMgr then
            local oldEquipConfig = Config.GetEquipmentInfo(oldEquipData.cid)
            if not oldEquipConfig then
                return ActionFailReason.CfgNotFind
            end
            DataLogMgr.LogEquipDevelop({
                equipCid = oldEquipData.cid,
                equipId = oldEquipData.id,
                equipName = oldEquipConfig.name,
                equipDevelopType = GE.EquipDevelopType.OwnerId,
                before = oldOwnerId,
                after = oldEquipData.ownerId,
            }, self)      
        end
    end

    --最终穿戴数据
    local oldOwnerId = equipData.ownerId
    roleData.carryEquip[partId] = equipId
    equipData.ownerId = charId

    if proto then
        if not proto.equipMap then
            proto.equipMap = {}
        end
        proto.equipMap[equipData.id] = equipData
        if oldEquipData then
            proto.equipMap[oldEquipData.id] = oldEquipData
        end

        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[roleData.id] = roleData
        if oldRoleData then
            proto.heroList[oldRoleData.id] = oldRoleData
        end
    end

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogEquipDevelop({
            equipCid = equipData.cid,
            equipId = equipData.id,
            equipName = equipConfig.name,
            equipDevelopType = GE.EquipDevelopType.OwnerId,
            before = oldOwnerId,
            after = equipData.ownerId,
        }, self)

        --记录角色数据日志
        local heroCfg = Config.GetCharacterInfo(equipData.ownerId)
        if heroCfg then
            DataLogMgr.LogHeroDevelop({
                heroCid = charId,
                heroName = roleConfig.name,
                heroDevelopType = GE.HeroDevelopType.EquipWeapon,
                before = oldRoleData and oldRoleData.carryEquip[partId] or 0,
                after = equipId,
            }, self)
        end
    end

    return ActionFailReason.None
end

--装备卸下
---@param equipId integer 装备实例化id
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason 是否成功，如有错误返回错误码
function Player:removeCharEquip(equipId, proto)
    --参数判空
    if not equipId then
        return ActionFailReason.ParameterInvalid
    end

    local equipData = self:getEquipDataByid(equipId)
    if not equipData then
        return ActionFailReason.EquipNoFind
    end

    local equipConfig = Config.GetEquipmentInfo(equipData.cid)
    if not equipConfig then
        return ActionFailReason.CfgNotFind
    end

    local roleData = self:getPlayerHero(equipData.ownerId)
    if not roleData then
        return ActionFailReason.HeroNoFind
    end

    ---将装备从角色身上移除
    for k, v in pairs(roleData.carryEquip) do
        if v == equipId then
            roleData.carryEquip[k] = 0
            break
        end
    end

    local oldOwnerId = equipData.ownerId
    equipData.ownerId = 0

    if proto then
        if not proto.equipMap then
            proto.equipMap = {}
        end
        proto.equipMap[equipData.id] = equipData

        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[roleData.id] = roleData
    end

    --记录数据日志
    if DataLogMgr then
        DataLogMgr.LogEquipDevelop({
            equipCid = equipData.cid,
            equipId = equipData.id,
            equipName = equipConfig.name,
            equipDevelopType = GE.EquipDevelopType.OwnerId,
            before = oldOwnerId,
            after = equipData.ownerId,
        }, self)

        --记录角色数据日志
        local heroCfg = Config.GetCharacterInfo(equipData.ownerId)
        if heroCfg then
            DataLogMgr.LogHeroDevelop({
                heroCid = heroCfg.id,
                heroName = heroCfg.name,
                heroDevelopType = GE.HeroDevelopType.EquipWeapon,
                before = equipId,
                after = 0,
            }, self)
        end
    end

    return ActionFailReason.None
end

--更改装备锁定状态
---@param equipId integer 装备实例化id
---@param proto any 需要完善道具信息
---@return ActionFailReason 是否成功，如有错误返回错误码
function Player:changeEquipLockState(equipId, proto)
    if equipId == nil then
        return ActionFailReason.ParameterInvalid
    end

    local equipData = self:getEquipDataByid(equipId)
    if not equipData then
        return ActionFailReason.EquipNoFind
    end

    local equipConfig = Config.GetEquipmentInfo(equipData.cid)
    if not equipConfig then
        return ActionFailReason.CfgNotFind
    end

    if equipConfig.equipType == GE.EquipType.sp then
        return ActionFailReason.EquipIsLock
    end

    local oldLockState = equipData.isLock and 1 or 0
    equipData.isLock = not equipData.isLock

    if proto then
        if not proto.equipMap then
            proto.equipMap = {}
        end
        proto.equipMap[equipData.id] = equipData
    end

    --记录数据日志
    if DataLogMgr then
        local curLockState = equipData.isLock and 1 or 0
        DataLogMgr.LogEquipDevelop({
            equipCid = equipData.cid,
            equipId = equipData.id,
            equipName = equipConfig.name,
            equipDevelopType = GE.EquipDevelopType.LockState,
            before = oldLockState,
            after = curLockState,
        }, self)
    end

    return ActionFailReason.None
end

---@class NatureData 六维属性数据
---@field type integer 属性类型ID
---@field value integer 属性值

---@class EquipNatureData 装备六维信息
---@field hp NatureData 生命值
---@field bombard NatureData 炮击值
---@field torpedo NatureData 雷击值
---@field armor NatureData 装甲值
---@field evade NatureData 机动值
---@field airdefense NatureData 防空值
---@field lucky NatureData 幸运值

--根据id获取装备六维信息
---@param equipId integer 装备实例化id
---@return EquipNatureData? 装备六维信息
function Player:getEquipNatureDataById(equipId)
    local equipData = self:getEquipDataByid(equipId)
    if equipData then
        local equipConfig = Config.GetEquipmentInfo(equipData.cid)
        if not equipConfig then
            return nil
        end
        local levelCoefficient = equipData.level - 1
        local temp = {
            hp = {type = GE.NatureType.hp, value = math.ceil(equipConfig.hp + math.ceil(levelCoefficient * equipConfig.hpUp))},
            bombard = {type = GE.NatureType.bombard, value = math.ceil(equipConfig.bombard + math.ceil(levelCoefficient * equipConfig.bombardUp))},
            torpedo = {type = GE.NatureType.torpedo, value = math.ceil(equipConfig.torpedo + math.ceil(levelCoefficient * equipConfig.torpedoUp))},
            armor = {type = GE.NatureType.armor, value = math.ceil(equipConfig.armor + math.ceil(levelCoefficient * equipConfig.armorUp))},
            evade = {type = GE.NatureType.evade, value = math.ceil(equipConfig.evade + math.ceil(levelCoefficient * equipConfig.evadeUp))},
            airdefense = {type = GE.NatureType.airdefense, value = math.ceil(equipConfig.airdefense + math.ceil(levelCoefficient * equipConfig.airdefenseUp))},
            lucky = {type = GE.NatureType.lucky, value = math.ceil(equipConfig.lucky + math.ceil(levelCoefficient * equipConfig.luckyUp))},
        }
        table.sort(temp, function(a, b) return a.type < b.type end)
        return temp
    end

    return nil
end

--根据cid获取装备六维信息
---@param cid integer 装备配置id
---@return EquipNatureData? 装备六维信息
function Player:getEquipNatureDataByCid(cid)
    local equipConfig = Config.GetEquipmentInfo(cid)
    if not equipConfig then
        return nil
    end
    local levelCoefficient = 1
    local temp = {
        hp = {type = GE.NatureType.hp, value = math.ceil(equipConfig.hp + math.ceil(levelCoefficient * equipConfig.hpUp))},
        bombard = {type = GE.NatureType.bombard, value = math.ceil(equipConfig.bombard + math.ceil(levelCoefficient * equipConfig.bombardUp))},
        torpedo = {type = GE.NatureType.torpedo, value = math.ceil(equipConfig.torpedo + math.ceil(levelCoefficient * equipConfig.torpedoUp))},
        armor = {type = GE.NatureType.armor, value = math.ceil(equipConfig.armor + math.ceil(levelCoefficient * equipConfig.armorUp))},
        evade = {type = GE.NatureType.evade, value = math.ceil(equipConfig.evade + math.ceil(levelCoefficient * equipConfig.evadeUp))},
        airdefense = {type = GE.NatureType.airdefense, value = math.ceil(equipConfig.airdefense + math.ceil(levelCoefficient * equipConfig.airdefenseUp))},
        lucky = {type = GE.NatureType.lucky, value = math.ceil(equipConfig.lucky + math.ceil(levelCoefficient * equipConfig.luckyUp))},
    }
    table.sort(temp, function(a, b) return a.type < b.type end)
    return temp
end

--获取装备某个等级的六维信息
---@param equipId integer 装备实例化id
---@param level integer 等级
---@return EquipNatureData? 装备六维信息
function Player:getEquipNatureDataByIdAndLevel(equipId, level)
    local equipData = self:getEquipDataByid(equipId)
    if equipData then
        local equipConfig = Config.GetEquipmentInfo(equipData.cid)
        local temp = {
            hp = {type = GE.NatureType.hp, value = math.ceil(equipConfig.hp + math.ceil(level * equipConfig.hpUp))},
            bombard = {type = GE.NatureType.bombard, value = math.ceil(equipConfig.bombard + math.ceil(level * equipConfig.bombardUp))},
            torpedo = {type = GE.NatureType.torpedo, value = math.ceil(equipConfig.torpedo + math.ceil(level * equipConfig.torpedoUp))},
            armor = {type = GE.NatureType.armor, value = math.ceil(equipConfig.armor + math.ceil(level * equipConfig.armorUp))},
            evade = {type = GE.NatureType.evade, value = math.ceil(equipConfig.evade + math.ceil(level * equipConfig.evadeUp))},
            airdefense = {type = GE.NatureType.airdefense, value = math.ceil(equipConfig.airdefense + math.ceil(level * equipConfig.airdefenseUp))},
            lucky = {type = GE.NatureType.lucky, value = math.ceil(equipConfig.lucky + math.ceil(level * equipConfig.luckyUp))},
        }
        table.sort(temp, function(a, b) return a.type < b.type end)
        return temp
    end
    return nil
end

--获取装备某个等级的六维信息
---@param equipId integer 装备实例化id
---@param level integer 等级
---@return EquipNatureData? 装备六维信息
function Player:getEquipNatureDataByCidAndLevel(equipId, level)
    local equipConfig = Config.GetEquipmentInfo(equipId)
    local temp = {
        hp = {type = GE.NatureType.hp, value = math.ceil(equipConfig.hp + math.ceil(level * equipConfig.hpUp))},
        bombard = {type = GE.NatureType.bombard, value = math.ceil(equipConfig.bombard + math.ceil(level * equipConfig.bombardUp))},
        torpedo = {type = GE.NatureType.torpedo, value = math.ceil(equipConfig.torpedo + math.ceil(level * equipConfig.torpedoUp))},
        armor = {type = GE.NatureType.armor, value = math.ceil(equipConfig.armor + math.ceil(level * equipConfig.armorUp))},
        evade = {type = GE.NatureType.evade, value = math.ceil(equipConfig.evade + math.ceil(level * equipConfig.evadeUp))},
        airdefense = {type = GE.NatureType.airdefense, value = math.ceil(equipConfig.airdefense + math.ceil(level * equipConfig.airdefenseUp))},
        lucky = {type = GE.NatureType.lucky, value = math.ceil(equipConfig.lucky + math.ceil(level * equipConfig.luckyUp))},
    }

    table.sort(temp, function(a, b) return a.type < b.type end)

    return temp
end

--装备属性加成
---@param carryEquip integer[] 装备实例化id列表
---@param effectiveSkill integer[] 有效技能列表
---@return table<string, integer> 属性加成
function Player:getEquipBonus(carryEquip, effectiveSkill)
    local equipValue = {
        hp = 0, bombard = 0, torpedo = 0, armor = 0, evade = 0, airdefense = 0, lucky = 0
    }
    --装备属性
    for _, value in pairs(carryEquip) do
        local NatureData = self:getEquipNatureDataById(value)
        local EquipData = self:getEquipDataByid(value)
        if EquipData then
            local nowEffectRank = self:getEquipEffectStageByid(value)
            local equipConfig = Config.GetEquipmentInfo(EquipData.cid)
            if equipConfig then
                if tablex.next(equipConfig.skill) then
                    local skillId = 0
                    if nowEffectRank > 0 then
                        skillId = equipConfig.skill[nowEffectRank]
                    end
                    if skillId ~= 0 then
                        table.insert(effectiveSkill, skillId)
                    end
                end
            end
        end

        if NatureData and tablex.next(NatureData) then
            equipValue.hp = equipValue.hp + NatureData.hp.value
            equipValue.bombard = equipValue.bombard + NatureData.bombard.value
            equipValue.torpedo = equipValue.torpedo + NatureData.torpedo.value
            equipValue.armor = equipValue.armor + NatureData.armor.value
            equipValue.evade = equipValue.evade + NatureData.evade.value
            equipValue.airdefense = equipValue.airdefense + NatureData.airdefense.value
            equipValue.lucky = equipValue.lucky + NatureData.lucky.value
        end
    end

    return equipValue
end

--根据装备id获取下一个解锁档位的技能id
---@param equipId integer 装备实例化id
---@return integer? 下一个解锁档位的技能id，如没有返回nil，已满档位返回满级档位技能id
function Player:getEquipNextEffectIdByid(equipId)
    local equipData = self:getEquipDataByid(equipId)
    if not equipData then
        return nil
    end

    local equipConfig = Config.GetEquipmentInfo(equipData.cid)
    if not equipConfig then
        return nil
    end

    --unLockSkillLv为空表，表示该装备未配置解锁档位
    if not tablex.next(equipConfig.unLockSkillLv) then
        return nil
    end

    --找到当前已解锁的最高档位
    local currentRank = 0
    for rank, unlockLevel in pairs(equipConfig.unLockSkillLv) do
        if equipData.level >= unlockLevel and rank > currentRank then
            currentRank = rank
        end
    end

    --计算下一个档位
    local nextRank = currentRank + 1
    if not equipConfig.unLockSkillLv[nextRank] then
        --已是最高档位，返回0标识前后端
        return 0
    end

    --返回下一档位对应的技能id
    if equipConfig.skill and equipConfig.skill[nextRank] and equipConfig.skill[nextRank] ~= 0 then
        return equipConfig.skill[nextRank]
    end

    return nil
end

--根据装备id查找该装备当前生效效果id，如没有返回空
---@param equipId integer 装备实例化id
---@return integer? 当前生效的技能id
function Player:getEquipEffectIdByid(equipId)
    local equipData = self:getEquipDataByid(equipId)
    if equipData then
        local equipConfig = Config.GetEquipmentInfo(equipData.cid)
        if not equipConfig then
            return nil
        end
        --获取当前装备等级，在unLockSkillLv查找已解锁的最高档位
        --数据结构为{10,20,30,40,50}，rank即索引，值为该档位的解锁等级阈值
        local currentRank = 0
        for rank, unlockLevel in pairs(equipConfig.unLockSkillLv) do
            if equipData.level >= unlockLevel and rank > currentRank then
                currentRank = rank
            end
        end

        if currentRank > 0 and equipConfig.skill and equipConfig.skill[currentRank] and equipConfig.skill[currentRank] ~= 0 then
            return equipConfig.skill[currentRank]
        end
        return nil
    end

    return nil
end

--根据装备id查找该装备当前生效效果档位（阶段），如没有返回0
---@param equipId integer 装备实例化id
---@return integer 当前生效效果档位（阶段），无效果返回0
function Player:getEquipEffectStageByid(equipId)
    local equipData = self:getEquipDataByid(equipId)
    if not equipData then
        return 0
    end

    local equipConfig = Config.GetEquipmentInfo(equipData.cid)
    if not equipConfig then
        return 0
    end

    local currentRank = 0
    for rank, unlockLevel in pairs(equipConfig.unLockSkillLv) do
        if equipData.level >= unlockLevel and rank > currentRank then
            currentRank = rank
        end
    end

    if currentRank > 0 and equipConfig.skill and equipConfig.skill[currentRank] and equipConfig.skill[currentRank] ~= 0 then
        return currentRank
    end

    return 0
end

---------------------------------------------------------------------------------------------------

--根据装备cid和等级查找该装备当前生效效果档位（阶段），如没有返回0
---@param cid integer 装备配置id
---@param level integer 装备等级
---@return integer? 当前生效的技能id
function Player:getEquipEffectStageByCidAndLevel(cid, level)
    local equipConfig = Config.GetEquipmentInfo(cid)
    if not equipConfig then
        return 0
    end

    local currentRank = 0
    for rank, unlockLevel in pairs(equipConfig.unLockSkillLv) do
        if level >= unlockLevel and rank > currentRank then
            currentRank = rank
        end
    end

    if currentRank > 0 and equipConfig.skill and equipConfig.skill[currentRank] and equipConfig.skill[currentRank] ~= 0 then
        return currentRank
    end

    return 0
end

--根据装备cid查找该装备当前生效效果id，如没有返回空
---@param cid integer 装备配置id
---@param level integer 装备等级
---@return integer? 当前生效的技能id
function Player:getEquipEffectIdByCidAndLevel(cid, level)
    local equipConfig = Config.GetEquipmentInfo(cid)
    if not equipConfig then
        return nil
    end
    --获取当前装备等级，在unLockSkillLv查找已解锁的最高档位
    --数据结构为{10,20,30,40,50}，rank即索引，值为该档位的解锁等级阈值
    local currentRank = 0
    for rank, unlockLevel in pairs(equipConfig.unLockSkillLv) do
        if level >= unlockLevel and rank > currentRank then
            currentRank = rank
        end
    end

    if currentRank > 0 and equipConfig.skill and equipConfig.skill[currentRank] and equipConfig.skill[currentRank] ~= 0 then
        return equipConfig.skill[currentRank]
    end
    return nil
end

return Player