-- Desc: 玩家道具相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end


--获取道具列表
function Player:getItemMap()
    return self.itemMap
end

--根据id获取道具数量
---@param id integer 道具id
---@return integer 道具数量
function Player:getItemNumById(id)
    local itemMap = self:getItemMap()
    if itemMap[id] then
        return itemMap[id].num
    else
        return 0
    end
end


--根据id获取道具数量
---@param id integer 道具id
---@return integer 道具数量
function Player:getItemCountById(id)
    local addCount = 0
    if id == GE.ResourceType.PayDiamond then
        if GV.IsServer then
            local info = self:getPayDiamond()
            if info ~= nil then
                addCount = info.num
            end
        else
            addCount = ClientData:GetPayDiamond() 
        end
    end
    local count = self:getItemNumById(id)
    return count + addCount
end

--根据id获取道具信息
---@param id integer 道具id
---@return ItemInfo? 道具信息
function Player:getItemById(id)
    local itemMap = self:getItemMap()
    return itemMap[id]
end

--检测单个道具是否足够
---@param item CostInfo 道具id
---@return boolean 是否足够
function Player:checkItemEnough(item)
    local haveNum = self:getItemNumById(item.id)
    return haveNum >= item.num
end

--检测单个道具是否足够
---@param item integer[] 道具id
---@return boolean 是否足够
function Player:checkItemEnough2(item)
    local haveNum = self:getItemNumById(item[1])
    return haveNum >= item[2]
end

--检查道具列表是否足够
---@param itemList CostInfo[] 道具列表
---@return boolean 是否足够
function Player:checkItemListEnough(itemList)
    for _, item in pairs(itemList) do
        if item ~= nil and item.id ~= nil then
            local haveNum = self:getItemNumById(item.id)
            if haveNum < item.num then
                return false
            end
        end
    end
    return true
end

--检查道具列表是否足够
---@param itemList integer[] 道具列表
---@return boolean 是否足够
function Player:checkItemListEnough2(itemList)
    for _, item in pairs(itemList) do
        local haveNum = self:getItemNumById(item[1])
        if haveNum < item[2] then
            return false
        end
    end
    return true
end

--批量扣除道具
---@param itemList integer[] 道具列表
---@param proto UserInfo 玩家信息差量更新结构
---@param balance_channel_id EventItemType? 产出消耗渠道
---@param balance_channel_detail integer? 产出消耗渠道详细内容
---@return boolean 是否成功扣除
function Player:useItemList(itemList, proto, balance_channel_id, balance_channel_detail)
    if not self:checkItemListEnough2(itemList) then
        return false
    end

    for _, item in pairs(itemList) do
        self:useItem(item[1], item[2], proto, balance_channel_id, balance_channel_detail)
    end
    return true
end

--根据效果类型获取道具列表
function Player:getItemListByEffectType(EffectType)
    local itemList = {}
    local needItemList = Config.GetItemInfoByEffectId(EffectType)
    if needItemList then
        for _, itemData in pairs(needItemList) do
            local itemId = itemData.id
            local itemData = self:getItemById(itemId)
            if itemData then
                table.insert(itemList, itemData)
            end
        end
    end
    return itemList
end

--增加道具
---@param id integer 道具id
---@param addNum integer 增加数量
---@param proto UserInfo? 玩家信息差量更新结构
---@param balance_channel_id integer 产出消耗渠道
---@param balance_channel_detail any 产出消耗渠道详细内容
---@return ActionFailReason 失败原因
function Player:addItem(id, addNum, proto, balance_channel_id, balance_channel_detail)
    --繁荣度代替道具：不入背包，直接转化为繁荣値
    if id == GE.ProsperityItemId then
        self:addProsperity(addNum, GE.ProsperityChannel.Item, proto)
        return ActionFailReason.None
    end
    local itemData = self:getItemById(id)
    local itemConfig = Config.GetItemInfo(id)
    local itemMap = self:getItemMap()

    if not itemConfig then
        LuaLogger.ws("not itemConfig", id)
        return ActionFailReason.ItemNoFind
    end
    --道具是否开放,0未开放，1开放
    if itemConfig.isOpen ~= 1 then
        LuaLogger.ws("Item is not open:", id)
        return ActionFailReason.CfgError
    end
    if (not addNum) or addNum < 0 then
        return ActionFailReason.ParameterInvalid
    end

    local beforeCount = itemData and itemData.num or 0

    if itemData then
        itemData.num  = itemData.num + addNum
    else
        local timeData = 0
        if itemConfig.countdown[1] == GE.ItemTimeType.ArrivalTime then
            timeData = DLuaUtil.ParseConfigTime(itemConfig.countdown[2])
        elseif itemConfig.countdown[1] == GE.ItemTimeType.ExpirationTime then
            timeData = DLuaUtil.GetGreenwichTime() + (itemConfig.countdown[2] * 60)
        else
            timeData = 0
        end
        itemMap[id] = {
            id = id,
            num = addNum,
            expirationTime = timeData,
        }
    end

    self:missionTrigger(GE.MissionFinishType.GetItemCountById, {itemId = id, count = addNum}, proto)

    if proto then
        if not proto.itemMap then
            proto.itemMap = {}
        end
        proto.itemMap[id] = itemMap[id]
    end

    --道具产出
    if DataLogMgr then
        DataLogMgr.LogItemProduce(
            {
                itemId = id,
                itemName = itemConfig.itemName,
                beforeCount = beforeCount,
                changeCount = addNum,
                afterCount = itemMap[id].num,
                balance_channel_id = balance_channel_id,
                balance_channel_detail = balance_channel_detail,
            }, self)
    end

    return ActionFailReason.None
end

--使用道具
---@param id integer 道具id
---@param useNum integer 使用数量
---@param proto UserInfo 玩家信息差量更新结构
---@param balance_channel_id integer 产出消耗渠道
---@param balance_channel_detail any 产出消耗渠道详细内容
---@return ActionFailReason 失败原因
function Player:useItem(id, useNum, proto, balance_channel_id, balance_channel_detail, breakDiamond)

    if (not breakDiamond) and id == GE.ResourceType.PayDiamond then
        local isSuccess = self:costPayDiamond(useNum, proto, balance_channel_id, balance_channel_detail)
        if not isSuccess then
            return ActionFailReason.ItemNoEnough
        else
            if proto then
                self:missionTrigger(GE.MissionFinishType.ConsumeItemCountById, {itemId = id, count = useNum}, proto)
            end
            return ActionFailReason.None
        end
    end

    local itemData = self:getItemById(id)
    if not itemData then
        return ActionFailReason.ItemNoFind
    end

    if (not useNum) or useNum < 0 then
        return ActionFailReason.ParameterInvalid
    end

    if useNum == 0 then
        return ActionFailReason.None
    end

    local itemConfig = Config.GetItemInfo(id)
    if not itemConfig then
        return ActionFailReason.CfgNotFind
    end

    if itemConfig.replaceItem ~= 0 then--抵扣道具
        local replaceItemcount = self:getItemCountById(itemConfig.replaceItem)
        local totalCount = itemData.num + replaceItemcount
        if totalCount < useNum then
            return ActionFailReason.ItemNoEnough
        end
    else
        if itemData.num < useNum then
            return ActionFailReason.ItemNoEnough
        end
    end

    local beforeCount = itemData.num

    --特殊效果逻辑写在对应脚本中，此处只扣除数量
    if itemConfig.replaceItem ~= 0 then--抵扣道具
        if itemData.num >= useNum then
            itemData.num = itemData.num - useNum
        else
            local needReplaceCount = useNum - itemData.num
            itemData.num = 0
            self:useItem(itemConfig.replaceItem, needReplaceCount, proto, balance_channel_id, balance_channel_detail)
        end
    else
        itemData.num = itemData.num - useNum
    end

    if itemData.id == GE.ResourceType.Gold then
        self:ActivateEventTrigger(GE.EventTriggerType.UseMoney, useNum, proto)
    end
    if itemConfig.type == GE.ItemPropType.Currency and proto then
        self:missionTrigger(GE.MissionFinishType.ConsumeItemCountById, {itemId = id, count = useNum}, proto)
    end

    if proto then
        if not proto.itemMap then
            proto.itemMap = {}
        end
        proto.itemMap[id] = itemData
    end

    --道具消耗
    if DataLogMgr then
        DataLogMgr.LogItemConsume(
            {
                itemId = id,
                itemName = itemConfig.itemName,
                beforeCount = beforeCount,
                changeCount = useNum,
                afterCount = itemData.num,
                balance_channel_id = balance_channel_id,
                balance_channel_detail = balance_channel_detail,
            }, self)
    end

    return ActionFailReason.None
end

--根据过期时间删除道具
---@param proto UserInfo 玩家信息差量更新结构
function Player:updataTimeLimitItem(proto)
    local itemMap = self:getItemMap()
    local deleteList = {}
    for id, itemData in pairs(itemMap) do
        if itemData.expirationTime ~= 0 and DLuaUtil.GetGreenwichTime() >= itemData.expirationTime then
            table.insert(deleteList, id)
        end
    end
    for _, id in pairs(deleteList) do
        itemMap[id] = nil
        if proto then
            if not proto.itemMap then
                proto.itemMap = {}
            end
            proto.itemMap[id] = {}
        end
    end
end

---更新玩家的道具信息
---@param data ItemInfo
function Player:updateItemMap(data)
    local itemPropData = self:getItemById(data.id)
    local itemMap = self:getItemMap()
    if itemPropData then
        itemPropData.num = data.num
    else
        local itemConfig = Config.GetItemInfo(data.id)
        if itemConfig then
            itemMap[data.id] = {
                id = data.id,
                num = data.num,
                expirationTime = data.expirationTime,
            }
        end
    end
end

-------------------------------------奖励相关逻辑------------------------------------------
--奖励格式转换
---@param rewardList {{type = 1,id = 1,num = 1}} 奖励列表
---@return integer[][]
function Player:rewardFormatConversion(rewardList)
    local rewards = {}
    for _, reward in pairs(rewardList) do
        if reward.type and reward.id and reward.num then
            table.insert(rewards, {reward.type, reward.id, reward.num})
        end
    end
    return rewards
end

--根据奖励列表增加奖励
---@param rewardList integer[][]分解可获得奖励配置列表
---@param proto UserInfo? 需要完善的道具信息
---@param balance_channel_id integer? 产出消耗渠道
---@param balance_channel_detail any? 产出消耗渠道详细内容
---@return RewardInfo[] 奖励列表
function Player:addRewardList(rewardList, proto, balance_channel_id, balance_channel_detail)
    local rewards = {}
    for _, reward in pairs(rewardList) do
        local rewardType = reward[1]
        local propId = reward[2]
        local addNum = reward[3]
        local changeType = nil
        if rewardType == GE.RewardType.ItemProp then--道具类型
            local propConfig = Config.GetItemInfo(propId)
            if propConfig then
                local ret
                if propConfig.type == GE.ItemPropType.Currency then--货币
                    --来源于充值渠道，充值货币
                    if balance_channel_id == GE.EventItemType.MoneyPay and propConfig.id == GE.ResourceType.PayDiamond then
                        local suc = self:addPayDiamond(addNum, proto, balance_channel_id, balance_channel_detail)
                        if suc then
                            ret = ActionFailReason.None
                        end
                    else
                        ret = self:addItem(propConfig.id, addNum, proto, balance_channel_id, balance_channel_detail)
                    end
                elseif propConfig.type == GE.ItemPropType.Strength then--体力
                    ret = self:addNormalTicket(addNum, true, balance_channel_id, balance_channel_detail)
                    if proto then
                        proto.ticket = self:getTicketData()
                    end
                elseif propConfig.type == GE.ItemPropType.Item and propConfig.useType == GE.ItemUseType.autoGift then--自动打开的礼包
                    local autoRewards = self:addAutoGiftRewards(propConfig, addNum, proto, balance_channel_id, balance_channel_detail)
                    rewards = tablex.combine(rewards, autoRewards)
                elseif propConfig.type == GE.ItemPropType.UserExp then--用户经验
                    ret = self:addUserExp(addNum, proto)
                else
                    ret = self:addItem(propId, addNum, proto, balance_channel_id, balance_channel_detail)
                end

                if ret == ActionFailReason.None and propConfig.useType ~= GE.ItemUseType.autoGift then
                    local propData = {
                        id = propId,
                        type = rewardType,
                        num = addNum,
                    }
                    table.insert(rewards, propData)
                end
            end
        elseif rewardType == GE.RewardType.Character then--角色类型
            for i = 1, addNum do
                changeType = self:addPlayerHero(propId, proto, balance_channel_id, balance_channel_detail)
                local propData = {
                    id = propId,
                    type = rewardType,
                    num = 1,
                    extraType = changeType,
                }
                table.insert(rewards, propData)
            end
        elseif rewardType == GE.RewardType.Skin then--皮肤类型
            for i = 1, addNum do
                local ret = self:addSkin(propId, proto, balance_channel_id, balance_channel_detail)
                if ret == ActionFailReason.None then
                    local propData = {
                        id = propId,
                        type = rewardType,
                        num = 1,
                    }
                    table.insert(rewards, propData)
                end
            end
        elseif rewardType == GE.RewardType.Equipment then--装备类型
            for i = 1, addNum do
                local ret, newId = self:addPlayerEquip(propId, proto, balance_channel_id, balance_channel_detail)
                if newId then
                    local propData = {
                        id = newId,
                        type = rewardType,
                        num = 1,
                    }
                    table.insert(rewards, propData)
                end
            end
        elseif rewardType == GE.RewardType.Weapon then--武器类型
            for i = 1, addNum do
                local ret, newId = self:addPlayerWeapon(propId, proto, balance_channel_id, balance_channel_detail)
                if newId then
                    local propData = {
                        id = newId,
                        type = rewardType,
                        num = 1,
                    }
                    table.insert(rewards, propData)
                end
            end
        elseif rewardType == GE.RewardType.Affection then --给某个角色增加好感度
            self:addAffectionExpByHeroId(propId, addNum, proto, balance_channel_id, balance_channel_detail)
            local propData = {
                id = Config.GetConfigInfo("AffectionItem"),
                type = GE.RewardType.Affection,
                num = addNum,
            }
            table.insert(rewards, propData)
        elseif rewardType == GE.RewardType.PassUnlock then --解锁通行证高级
            self:UnlockAdvancePass(propId,proto)
        elseif rewardType == GE.RewardType.PassExp then --增加通行证经验
            self:addPassTaskExp(propId,addNum, proto)
        elseif rewardType == GE.RewardType.PassLevel then --增加通行证10级经验
            self:addSuperPassLevelExp(propId,addNum,proto)
        elseif rewardType == GE.RewardType.PassSuper then --解锁超级通行证
            self:UnlockSuperPass(propId,proto)
        elseif rewardType == GE.RewardType.CycleCard then  --解锁周卡月卡
            local rw = self:ActivityCycleCard(propId, proto)
            if rw ~= nil and #rw > 0 then
                tablex.move(rw, 1, #rw, #rewards + 1, rewards)
            end
        elseif rewardType == GE.RewardType.MiniPassUnlock then  --解锁简易通行证高级
            self:unlockMiniPass(propId, proto)
        end
    end
    return rewards
end

---获取随机奖励
---@param randomAwardId integer 随机奖励ID
---@return RewardInfo[] 奖励列表
function Player:getRandomAward(randomAwardId)
    local random = self:getRandom()
    local list = {}

    local randomAwardConfig = Config.GetRandomAwardInfo(randomAwardId)
    if not randomAwardConfig then
        LuaLogger.ws("not randomAwardConfig", randomAwardId)
        return list
    end

    if (randomAwardConfig.type == GE.AwardRandomType.Merge) then --合并权重
        local weightAll = 0
        local randomAward = randomAwardConfig.randomAward
        for _, awardInfo in ipairs(randomAward) do
            weightAll = weightAll + awardInfo[4]
        end
        local randomValue = random:range(1, weightAll)

        local awardNum = tablex.size(randomAward)
        for i = 1, awardNum do
            local awardInfo = randomAward[i]
            randomValue = randomValue - awardInfo[4]
            if randomValue <= 0 then
                local award = {
                    awardInfo[1],   --type
                    awardInfo[2],   --id
                    awardInfo[3]    --num
                }
                table.insert(list, award)
                break
            end
        end
    elseif (randomAwardConfig.type == GE.AwardRandomType.Single) then --单独判定
        local randomAward = randomAwardConfig.randomAward
        for _, awardInfo in ipairs(randomAward) do
            local randomValue = random:range(1, 100)
            if randomValue <= awardInfo[4] then
                local award = {
                    awardInfo[1],   --type
                    awardInfo[2],   --id
                    awardInfo[3]    --num
                }
                table.insert(list, award)
            end
        end
    else
        LuaLogger.ws("GetRandomAward Wrong RandomType", randomAwardConfig.type)
    end

    return list
end

--奖励整合
---@param rewardList RewardInfo[] 奖励列表
---@return RewardInfo[] 奖励列表
function Player:mergeRewardList(rewardList)
    local rewardMap = {}
    for _, reward in pairs(rewardList) do
        local key = reward.id .. "_" .. reward.type.. "_" .. (reward.extraType or 0)
        if rewardMap[key] then
            rewardMap[key].num = rewardMap[key].num + reward.num
        else
            rewardMap[key] = clone(reward)
        end
    end

    local rewards = {}
    for _, reward in pairs(rewardMap) do
        table.insert(rewards, reward)
    end

    return rewards
end

--获取自动打开礼包的奖励
---@param propConfig ItemTable 道具配置
---@param giftNum integer 礼包数量
---@param proto UserInfo 玩家信息差量更新结构
---@param balance_channel_id integer 产出消耗渠道
---@param balance_channel_detail any 产出消耗渠道详细内容
---@return RewardInfo[] 奖励列表
function Player:addAutoGiftRewards(propConfig, giftNum, proto, balance_channel_id, balance_channel_detail)
    local awardIdList = propConfig.effect
    local awardList = {}
    local rewardList = {}
    for i = 1, giftNum do
        for _, randomAwardId in ipairs(awardIdList) do
            awardList = tablex.combine(awardList, self:getRandomAward(randomAwardId))
        end
    end
    --过滤掉自动打开类型的道具
    for i = #awardList , 1, -1 do
        local awardData = awardList[i]
        local rewardType = awardData[1]
        if rewardType == GE.RewardType.ItemProp then--道具类型
            local propId = awardData[2]
            local propConfig = Config.GetItemInfo(propId)
            if propConfig and propConfig.useType == GE.ItemUseType.autoGift then
                table.remove(awardList, i)
            end
        end
    end
    rewardList = self:addRewardList(awardList, proto, balance_channel_id, balance_channel_detail)
    return rewardList
end

--获取手动打开的礼包奖励
---@param itemId integer 礼包id
---@param useNum integer 使用数量
---@param selectIndex integer? 选中的奖励序号
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason 错误码
---@return RewardInfo[]? rewardList 奖励列表
function Player:getGiftPackRewards(itemId, useNum, selectIndex, proto)
    --参数检测
    if not itemId or itemId <= 0 then
        return ActionFailReason.ParameterInvalid
    end

    if not useNum or useNum <= 0 then
        return ActionFailReason.ParameterInvalid
    end
    --配置检测
    local itemConfig = Config.GetItemInfo(itemId)
    if not itemConfig then
        return ActionFailReason.CfgNotFind
    end
    --条件检测
    if itemConfig.useType == GE.ItemUseType.multiple then--自选礼包则需要选中的奖励序号
        if not selectIndex or selectIndex <= 0 or selectIndex > #itemConfig.effect then
            return ActionFailReason.ParameterInvalid
        end
    end
    --数量检测
    local itemData = {id = itemId, num = useNum, type = GE.RewardType.ItemProp}
    if not self:checkItemEnough(itemData) then
        return ActionFailReason.ItemNoEnough
    end

    --扣除礼包
    self:useItem(itemId, useNum, proto, GE.EventItemType.OpenItem, itemId)

    --根据使用类型发放奖励
    local awardList = {}
    local rewardList = {}
    if itemConfig.useType == GE.ItemUseType.multiple then--自选礼包
        for index, awardData in ipairs(itemConfig.effect) do
            if index == selectIndex then
                local newData = {
                    awardData[1],
                    awardData[2],
                    awardData[3] * useNum,
                }
                table.insert(awardList, newData)
                break
            end
        end
    elseif itemConfig.useType == GE.ItemUseType.randomGift then--随机礼包
        local awardIdList = itemConfig.effect
        for i = 1, useNum do
            for _, randomAwardId in ipairs(awardIdList) do
                awardList = tablex.combine(awardList, self:getRandomAward(randomAwardId))
            end
        end
    end
    rewardList = self:addRewardList(awardList, proto, GE.EventItemType.OpenItem, itemId)

    return ActionFailReason.None, rewardList
end

return Player