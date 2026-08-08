-- Desc: 玩家体力相关
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end
---@type integer 按时间回复体力的上限
local normalTicketNumCfg = Config.GetConfigInfo("LimitNormalTicketNum") or 0
---@type integer 购买体力的堆叠上限
local buyTicketNumCfg = Config.GetConfigInfo("ApMaxHold") or 0
---@type integer 随时间恢复体力的间隔
local recoverInterval = Config.GetConfigInfo("RecoverTicketTime") or 0
---@type integer[] 购买体力的配置
local buyTicketCfg = Config.GetConfigInfo("ApBuy") or {}
---@type integer 购买体力消耗的物品ID
local buyTicketCostItemID = buyTicketCfg[1] or 0
---@type integer 购买体力的每日限制次数
local buyTicketLimitNum = buyTicketCfg[2] or 0
---@type integer[] 依据购买体力次数所需货币数量
local buyTicketCostList = Config.GetConfigInfo("ApBuyCost")
---@type integer 货币购买的体力恢复量
local storeBuyTicket = Config.GetConfigInfo("ApBuyRestore") or 0


--获取体力信息
---@return table 体力数据
function Player:getTicketData()
    return self.ticket
end

--体力检测
---@param needNum integer 体力数量
---@return boolean 是否有足够的体力
function Player:checkNormalTicket(needNum)
    local ticketData = self:getTicketData()
    if ticketData.num >= needNum then
        return true
    end

    return false
end

--增加体力
---@param addNum integer 体力增加数量
---@param isBuy? boolean 是否购买体力
---@return ActionFailReason
function Player:addNormalTicket(addNum, isBuy, balance_channel_id, balance_channel_detail)
    local ticketData = self:getTicketData()
    if not addNum or addNum < 1 then
        return ActionFailReason.ParameterInvalid
    end

    local beforeCount = ticketData.num

    if (ticketData.num + addNum) >= normalTicketNumCfg and not isBuy then
        ticketData.num = normalTicketNumCfg
    else
        ticketData.num = ticketData.num + addNum
    end

    --判断体力不能超过最大堆叠上限(gm不受限制)
    if balance_channel_id ~= GE.EventItemType.GM and ticketData.num > buyTicketNumCfg then
        ticketData.num = buyTicketNumCfg
    end

    if ticketData.num >= normalTicketNumCfg then
        self:setLastRecoverTime(0)
    end

    self:missionTrigger(GE.MissionFinishType.CurrentActionPointReachValue, {count = ticketData.num}, {})
    --体力日志
    if DataLogMgr then
        DataLogMgr.LogTicket(
            {
                beforeCount = beforeCount,
                changeCount = addNum,
                afterCount = ticketData.num,
                balance_channel_id = balance_channel_id,
                balance_channel_detail = balance_channel_detail,
            },
            self
        )
    end

    return ActionFailReason.None
end

--消耗体力
---@param useNum integer 消耗的体力数量
---@param proto? UserInfo 玩家信息差量更新结构
---@param balance_channel_id integer 渠道ID
---@param balance_channel_detail any 渠道详情ID
---@return boolean 是否成功消耗
function Player:costNormalTicket(useNum, proto, balance_channel_id, balance_channel_detail)
    if not useNum or useNum < 0 then
        return false
    end

    --检查是否有足够的体力
    if not self:checkNormalTicket(useNum) then
        return false
    end
    local ticketData = self:getTicketData()
    local beforeCount = ticketData.num

    ticketData.num = ticketData.num - useNum
    if ticketData.num < 0 then
        ticketData.num = 0
    end

    --判断体力倒计时
    if ticketData.num >= normalTicketNumCfg then
        self:setLastRecoverTime(0)
    else
        local lastRecoverTime = ticketData.lastRecoverTime
        if lastRecoverTime == 0 then
            self:setLastRecoverTime(DLuaUtil.GetGreenwichTime())
        end
    end

    ---触发消耗体力任务事件
    self:missionTrigger(GE.MissionFinishType.UseTicket, {count = useNum}, proto)
    self:missionTrigger(GE.MissionFinishType.CurrentActionPointReachValue, {count = ticketData.num}, proto)
    --self:missionTrigger("ResExpend", {resType = 6, useCount = useNum}, proto)

    self:ActivateEventTrigger(GE.EventTriggerType.UseTicket,useNum, proto)

    if proto then
        proto.ticket = self:getTicketData()
    end

    --体力日志
    if DataLogMgr then
        DataLogMgr.LogTicket(
            {
                beforeCount = beforeCount,
                changeCount = -useNum,
                afterCount = ticketData.num,
                balance_channel_id = balance_channel_id,
                balance_channel_detail = balance_channel_detail,
            },
            self
        )
    end

    return true
end

---设置上次恢复体力的时间戳
---@param time integer 时间戳
function Player:setLastRecoverTime(time)
    local ticketData = self:getTicketData()
    ticketData.lastRecoverTime = time
end

---随时间恢复体力
---@param proto? UserInfo 玩家信息差量更新结构
function Player:recoverNormalTicket(proto)
    ---@type integer
    local nowTime = DLuaUtil.GetGreenwichTime()
    local ticketData = self:getTicketData()
    local lastRecoverTime = ticketData.lastRecoverTime
    if lastRecoverTime == 0 then
        if ticketData.num < normalTicketNumCfg then
            self:setLastRecoverTime(nowTime)
            if proto then
                proto.ticket = self:getTicketData()
            end
        end
    elseif nowTime >= lastRecoverTime + recoverInterval then
        local timeDiff = nowTime - lastRecoverTime
        local setTime = recoverInterval
        ---@type integer
        local recoverNum = math.modf(timeDiff / setTime)
        if recoverNum >= 1 then
            local timeRemaining = timeDiff % setTime
            self:setLastRecoverTime(nowTime - timeRemaining)
            self:addNormalTicket(recoverNum, nil, GE.EventItemType.Natural, 0)
            if proto then
                proto.ticket = self:getTicketData()
            end
        end

    end
end

--重置每日购买体力次数
---@param proto? UserInfo 玩家信息差量更新结构
function Player:resetTodayBuyCount(proto)
    local ticketData = self:getTicketData()
    ticketData.todayBuyCount = 0
    if proto then
        proto.ticket = ticketData
    end
end

--使用道具或者货币来购买体力
---@param mode TicketAddType 使用道具模式还是货币模式
---@param id integer 道具id
---@param num integer 道具数量
---@param userinfo UserInfo 玩家信息差量更新结构
---@return ActionFailReason 购买体力结果
function Player:buyNormalTicket(mode, id, num, userinfo)
    local ticketData = self:getTicketData()
    --参数检查
    if not mode then
        return ActionFailReason.LackParameter
    end

    if ticketData.num >= buyTicketNumCfg then
        return ActionFailReason.TicketHasMax
    end

    local ret = ActionFailReason.None
    if mode == GE.TicketAddType.item then
        if not id or not num or num <= 0 then
            return ActionFailReason.LackParameter
        end

        --使用道具模式
        local itemData = self:getItemById(id)
        if not itemData or itemData.num < num then
            return ActionFailReason.ItemNoEnough
        end

        local itemConfig = Config.GetItemInfo(id)
        if not itemConfig then
            return ActionFailReason.CfgNotFind
        end

        local count = 0
        if itemConfig.effect[1] == GE.ItemEffectType.ticketAdd then
            count = itemConfig.effect[2] * num
        else
            return ActionFailReason.ParameterInvalid
        end
        ret = self:useItem(id, num, userinfo, GE.EventItemType.BuyTicket, 0)
        if ret ~= ActionFailReason.None then
            return ret
        end

        self:addNormalTicket(count, true, GE.EventItemType.BuyTicket, table.concat({id, num}, ", "))

    elseif mode == GE.TicketAddType.buyTicket then
        --使用货币模式
        local itemData = self:getItemById(buyTicketCostItemID)

        ---检测是否达到购买体力的每日限制次数
        local NeedCount = ticketData.todayBuyCount + 1
        local addBuyCount = self:GetCycleCardPrivilegeAddCount(PrivilegeType.ApBuyAddCount)
        if NeedCount > buyTicketLimitNum + addBuyCount then
            return ActionFailReason.TicketBuyMax
        end

        ---检测购买体力的所需货币数量
        local itemNeedNum = buyTicketCostList[NeedCount]
        if not itemData or itemData.num < itemNeedNum then
            return ActionFailReason.CurrencyNoEnough
        end

        self:useItem(buyTicketCostItemID, itemNeedNum, userinfo, GE.EventItemType.BuyTicket, 0)
        ticketData.todayBuyCount = ticketData.todayBuyCount + 1
        self:addNormalTicket(storeBuyTicket, true, GE.EventItemType.BuyTicket, table.concat({buyTicketCostItemID, itemNeedNum}, ", "))
    else
        return ActionFailReason.ErrorTicketMode
    end

    userinfo.ticket = ticketData

    return ret
end

return Player