--- Desc: 玩家家园仓库相关逻辑
--- 大池子：控制玩家获取奖励的总量，池子每分钟恢复一定数量，达到最大值后不再恢复
--- 离线奖励：此离线非玩家离线，是离开家园的时间
---     离线时间累计足够时从大池子里拿奖励放入离线池子，等待玩家领取
--- 英雄行为奖励：此行为是在家园中自动随机的行为，钓鱼、散步等等
---     英雄完成行为后，如果此行为有奖励，则从大池子里拿奖励直接放入英雄背包
---     英雄行为由服务器控制，第一次进入家园时有默认的行为，之后随机生成行为
---@class Player
local Player = require "Player"
local DataLogMgr, GameGlobal
---@diagnostic disable-next-line: GV
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
    GameGlobal = require "GameGlobal"
end

---自定义奖励
---某些奖励需要单独在随机一次  冶炼金属液 
---[1] 表示自定义id
---[2]  -->[1]表示道具id
---     -->[2]随机最小值
---     -->[3]随机最大值
---     -->[4]消耗数量
---[n] 和第二个数组一样
---@type table 
local customRewardItemCfg = nil

function Player:GetCustomRewardItemCfg()
    if customRewardItemCfg ~= nil then
        return customRewardItemCfg
    end
    customRewardItemCfg = Config.GetConfigInfo("HomeResourceRetrieve")
    return customRewardItemCfg
end



function Player:GetStorageItemCount(itemId)
    local homelandInfo = self:getHomeland()
    if not homelandInfo then
        return 0
    end
    local storageItems = homelandInfo.storageItemList
    if not storageItems then
        return 0
    end
    for index, value in ipairs(storageItems) do
        if value.id == itemId then
            return value.num
        end
    end
    return 0
end


---更新仓库 和离线收益道具数量
---@param isLogin boolean
---@param userInfo UserInfo
function Player:UpdateHomelandStorageItemData(isLogin, userInfo)
    local homelandInfo = self:getHomeland()
    if not homelandInfo then
        LuaLogger.ds("UpdateHomelandStorageItemData homelandInfo == nil")
        return
    end
    local lastOnLineTime = 0
    if GV.IsServer then
        lastOnLineTime = self.lastofflinetime or 0
    else
        lastOnLineTime = self.lastonlinetime or 0
    end

    if lastOnLineTime == 0 then
        LuaLogger.ds("UpdateHomelandStorageItemData lastOnLineTime == 0")
        homelandInfo.lastUpdateEarningsTime = -1  ---默认不在家园
        return
    end

    local allLevel = 0
    for key, value in pairs(homelandInfo.buildingList) do
        allLevel = allLevel + value.level
    end
    local cfg = Config.GetHomeResourceCfg(allLevel)
    if not cfg then
        LuaLogger.ds("UpdateHomelandStorageItemData cfg == nil allLevel:" .. allLevel)
        return
    end

    --计算仓库自然收益
    local curTime = DLuaUtil.GetGreenwichTime()
    if homelandInfo.lastUpdateStorageTime == nil or homelandInfo.lastUpdateStorageTime == 0 then
        homelandInfo.lastUpdateStorageTime = curTime
    end
    local storeOffLineTime = curTime - homelandInfo.lastUpdateStorageTime
    storeOffLineTime = math.max(storeOffLineTime, 0)
    storeOffLineTime = storeOffLineTime / 60
    storeOffLineTime = math.floor(storeOffLineTime)


    --计算不在家园离线时间
    local offLineEarningsTime = 0
    if homelandInfo.lastUpdateEarningsTime == nil or homelandInfo.lastUpdateEarningsTime == -1 then
        homelandInfo.lastUpdateEarningsTime = 0
    end
    if isLogin then
        if homelandInfo.lastUpdateEarningsTime == 0 then
            homelandInfo.lastUpdateEarningsTime = lastOnLineTime
        end
        if homelandInfo.lastUpdateEarningsTime == 0 then
            homelandInfo.lastUpdateEarningsTime = curTime
        end
        offLineEarningsTime = curTime - (homelandInfo.lastUpdateEarningsTime or curTime)
    else
        if homelandInfo.lastUpdateEarningsTime ~= 0 then
            offLineEarningsTime = curTime - (homelandInfo.lastUpdateEarningsTime or curTime)
        end
    end

    offLineEarningsTime = math.max(offLineEarningsTime, 0)
    offLineEarningsTime = offLineEarningsTime / 60
    offLineEarningsTime = math.floor(offLineEarningsTime)

    if offLineEarningsTime < cfg.leastOffLineTimes then
        offLineEarningsTime = 0
    end

    if storeOffLineTime <= 0 and offLineEarningsTime <= 0 then
        return  
    end

    homelandInfo.storageItemList = homelandInfo.storageItemList or {}
    homelandInfo.earningsItemList = homelandInfo.earningsItemList or {}
    for key, value in pairs(cfg.resoureParameter) do
        local itemId = value[1]
        local storeRecoveryNum = value[2]       --仓库每分钟恢复数量
        local storeRecoveryMaxNum = value[3]    --仓库最大恢复数量

        local rewardRecoveryNum = value[4]      --奖励每分钟恢复数量
        local rewardRecoveryMaxNum = value[5]   --最大奖励数量

        ---计算仓库恢复数量
        ---@type RewardInfo?
        local itemInfo = tablex.findSingle(homelandInfo.storageItemList, function(item)
            return item.id == itemId
        end)
        if not itemInfo then
            itemInfo = {
                id = itemId,
                num = 0,
                type = 1,
                extraType = 0,
            }
            tablex.insertproxy(homelandInfo.storageItemList, itemInfo)
        end

        ---计算离线仓库恢复数量
        if storeOffLineTime > 0 then
            local recoveryNum = storeRecoveryNum * storeOffLineTime
            recoveryNum = itemInfo.num + recoveryNum
            recoveryNum = math.min(recoveryNum, storeRecoveryMaxNum)
            recoveryNum = math.floor(recoveryNum)
            itemInfo.num = recoveryNum
        end


        ---计算离线收益
        if offLineEarningsTime > 0 then
            ---@type RewardInfo?
            local earningsItem = tablex.findSingle(homelandInfo.earningsItemList, function(item)
                return item.id == itemId
            end)

            if not earningsItem then
                earningsItem = {
                    id = itemId,
                    type = 1,
                    num = 0,
                    extraType = 0,
                }
                tablex.insertproxy(homelandInfo.earningsItemList, earningsItem)
            end

            local recoveryNum = rewardRecoveryNum * offLineEarningsTime
            local max = math.min(rewardRecoveryMaxNum, itemInfo.num)
            recoveryNum = math.min(recoveryNum, max)

            local num = itemInfo.num - recoveryNum
            num = math.floor(num)
            itemInfo.num = num

            num = earningsItem.num + recoveryNum
            num = math.floor(num)
            earningsItem.num = num

        end
        ::continue::
    end

    --移除掉小于0 的仓库道具
    for i = tablex.size(homelandInfo.storageItemList), 1, -1 do
        local itemInfo = homelandInfo.storageItemList[i]
        if itemInfo.num <= 0 then
            tablex.removeproxy(homelandInfo.storageItemList, i)
        end
    end

    ---移除掉小于0 的离线收益
    for i = tablex.size(homelandInfo.earningsItemList), 1, -1 do
        local earningsItem = homelandInfo.earningsItemList[i]
        if earningsItem.num <= 0 then
            tablex.removeproxy(homelandInfo.earningsItemList, i)
        end
    end

    userInfo.homeland = userInfo.homeland or {}
    if storeOffLineTime > 0 then
        homelandInfo.lastUpdateStorageTime = curTime
        userInfo.homeland.lastUpdateStorageTime = homelandInfo.lastUpdateStorageTime
    end

    if offLineEarningsTime > 0 then
        homelandInfo.lastUpdateEarningsTime = curTime
        userInfo.homeland.lastUpdateEarningsTime = homelandInfo.lastUpdateEarningsTime
    end
    userInfo.homeland.storageItemList = homelandInfo.storageItemList
    userInfo.homeland.earningsItemList = homelandInfo.earningsItemList
end

---获取仓库道具
---@param itemDatas table{[4]}
---@param userInfo UserInfo
---@return table?
function Player:GetHomelandStorageItemReward(itemDatas, userInfo)

    local homelandInfo = self:getHomeland()
    if not homelandInfo then
        return nil
    end
    local storageItems = homelandInfo.storageItemList
    if not storageItems then
        return nil
    end

    ---@type RewardInfo[]
    local items = {}
    for index, value in ipairs(itemDatas) do
        local type, id, num, extraType  = value[1], value[2], value[3], 0
        if type ~= 1 then
            goto continue
        end
        local itemId = id
        local itemInfo = tablex.findSingle(homelandInfo.storageItemList, function(item)
            return item.id == itemId
        end)
        if not itemInfo then
            goto continue
        end

        local getCount = math.min(itemInfo.num, num)
        getCount = math.floor(getCount)
        if getCount <= 0 then
            goto continue
        end
        itemInfo.num = itemInfo.num - getCount
        local itemData = {
            type,
            itemId,
            getCount,
            extraType,
        }
        table.insert(items, itemData)
        ::continue::
    end
    if #items ~= 0 then
        userInfo.homeland = userInfo.homeland or {}
        userInfo.homeland.storageItemList = homelandInfo.storageItemList
    end
    return items
end

----设置家园是否进入
---@param isEnter boolean
---@param userInfo UserInfo
function Player:SetHomelandIsEnter(isEnter, userInfo)
    local homelandInfo = self:getHomeland()
    if not homelandInfo then
        return
    end
    local lastUpdateEarningsTime = 0
    if isEnter then
        self:UpdateHomelandStorageItemData(false, userInfo)
        lastUpdateEarningsTime = 0
    else
        self:ClearAllHeroAction(userInfo)
        lastUpdateEarningsTime = DLuaUtil.GetGreenwichTime()
    end
    homelandInfo.lastUpdateEarningsTime = lastUpdateEarningsTime

    if isEnter then
        self:CreateHomelandBattle(userInfo)
    end
end

---homeland 离线收益
---@param userInfo UserInfo
---@return RewardInfo[]?
function Player:GetHomelandEarningsItems(userInfo)
    local homelandInfo = self:getHomeland()
    if tablex.size(homelandInfo.earningsItemList) == 0 then
        return
    end
    local earningsItemList = homelandInfo.earningsItemList
    -- 生成自定义奖励
    local itemList = {}
    local customRewardItemCfg = self:GetCustomRewardItemCfg()
    for index, value in ipairs(earningsItemList) do
        if value.num <= 0 then
            goto continue
        end
        local cusCfg = tablex.findSingle(customRewardItemCfg, function(item)
            return item[1] == value.id
        end)
        if cusCfg then
            local count = value.num
            for i = 2, #cusCfg do
                local maxCount = count / cusCfg[i][4]
                maxCount = math.floor(maxCount)
                if maxCount <= 0 then
                    goto continue_i
                end
                local r = math.random(cusCfg[i][2], cusCfg[i][3])
                if i == #cusCfg then
                    r = 100
                end
                local c = maxCount * (r / 100)
                c = math.floor(c)
                if c <= 0 then
                    goto continue_i
                end
                count = count - c * cusCfg[i][4]
                local itemData = {
                    1,
                    cusCfg[i][1],
                    c,
                    0,
                }
                table.insert(itemList, itemData)
                ::continue_i::
            end
        else
            local itemData = {
                value.type,
                value.id,
                value.num,
                value.extraType,
            }
            table.insert(itemList, itemData)
        end
        ::continue::
    end
    homelandInfo.earningsItemList = {}
    userInfo.homeland = userInfo.homeland or {}
    userInfo.homeland.earningsItemList = homelandInfo.earningsItemList
    local rewardList = self:addRewardList(itemList, userInfo, GE.EventItemType.HomeEarnings, 0)
    return rewardList
end



---添加离线仓库奖励
---@param rewards integer[][]
---@param userInfo UserInfo
function Player:AddEarningsItemList(rewards, userInfo)
    local homelandInfo = self:getHomeland()
    local size = tablex.size(rewards)
    for i = 1, size do
        local r = rewards[i]
        local id = r[2]
        local num = r[3]
        ---@type RewardInfo?
        local earningsItem = tablex.findSingle(homelandInfo.earningsItemList, function(item)
            return item.id == id
        end)

        if earningsItem ~= nil then
            earningsItem.num = earningsItem.num + num
        else
            earningsItem = {
                id = id,
                type = 1,
                num = num,
                extraType = 0,
            }
            tablex.insertproxy(homelandInfo.earningsItemList, earningsItem)
        end
    end

    userInfo.homeland = userInfo.homeland or {}
    userInfo.homeland.earningsItemList = homelandInfo.earningsItemList
end

return Player