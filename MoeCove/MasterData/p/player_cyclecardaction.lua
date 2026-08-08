-- Desc: 月卡周卡逻辑
---@class Player
local Player = require "Player"

---@type integer
local resetTime = nil
local daySecond = 24*60*60

---@return table<integer, CycleCardData>
function Player:GetCycleCardDatas()
    return self.cycleCardDatas
end

---登录时检测周期卡数据
function Player:CheckCycleCardData(proto)

    if resetTime == nil then
        resetTime = tonumber(Config.GetConfigInfo("DailyResetTime")) * 3600 
    end
    local cycleCardDatas = self:GetCycleCardDatas()
    for k, v in pairs(cycleCardDatas) do
        self:UpdateCycleCardData(k, proto)
    end
end

---发送每日奖励
---@param cardId integer
---@param proto UserInfo
---@return boolean isSend 当日奖励是否发送
function Player:UpdateCycleCardData(cardId, proto)

    ---@type CycleCardData
    local cardData = self:GetCycleCardDatas()[cardId]
    if cardData == nil then
       return false
    end
    local cfg = Config.GetMonthCardInfo(cardId)
    if cfg == nil then
       return false
    end
    local curTime = DLuaUtil.GetGreenwichTime()
    local endTime = cardData.endTime
    endTime = math.min(curTime, endTime)

    local day = DLuaUtil.GetApartDays(cardData.lastGetRewardTime, endTime)
    if day <= 0 then
       return true
    end

    ---发送对应天数奖励 邮件发送 TODO
    LuaLogger.ds("cycleCard, send mail", self.uid, cardId, day)

    local mailInfo = {
        title = cfg.cardMailTitle,
        sender = "系统",
        content = cfg.cardMailContent,
        reward = {}
    }

    local maxDay = Config.GetConfigInfo("MouthCardMergeNum")
    if day < maxDay then
        for i = 1, day do
            for j = 1, #cfg.exAward do
                local rw = cfg.exAward[j]
                local reward = { rw[1], rw[2], rw[3],}
                table.insert(mailInfo.reward, reward)
            end
        end
    else
        for i = 1, #cfg.exAward do
            local rw = cfg.exAward[i]
            local reward = {rw[1], rw[2], rw[3] * day,}
            table.insert(mailInfo.reward, reward)
        end
    end

    self:createNewMail(mailInfo)
    cardData.lastGetRewardTime = curTime
    local cycleCardDatas = self:GetCycleCardDatas()
    proto.cycleCardDatas = proto.cycleCardDatas or {}
    if curTime > endTime then
        cycleCardDatas[cardId] = nil
        proto.cycleCardDatas[cardId] = {}
    else
        proto.cycleCardDatas[cardId] = cardData
    end
    return false
end

---判断周期卡是否激活
---@param cardId integer
---@return boolean
function Player:CycleCardIsActive(cardId)
    local time = self:GetCardLastTime(cardId)
    return time > 0
end

---激活周期卡
---@param cardId integer 周期卡ID
---@param proto UserInfo 更新数据
function Player:ActivityCycleCard(cardId, proto)
    local cardCfg = Config.GetMonthCardInfo(cardId)
    if cardCfg == nil then
        return
    end
    local curTime = DLuaUtil.GetGreenwichTime()
    ---@type CycleCardData
    local cardInfo = self:GetCycleCardDatas()[cardId]

    if cardInfo == nil then
        cardInfo = {
            cycleId = cardId,
            endTime = 0,
            lastGetRewardTime = 0,
        }
        self:GetCycleCardDatas()[cardId] = cardInfo
    end

    local statTime = DLuaUtil.GetNextResetTime(curTime, resetTime)
    statTime = statTime - daySecond

    if cardInfo.lastGetRewardTime < statTime - 1 then
        cardInfo.lastGetRewardTime = statTime - 1
    end

    local lastTime = self:GetCardLastTime(cardId)
    local addDay = 0
    if lastTime > 0 then
        addDay = math.ceil(lastTime / daySecond)
    end

    local endTime = statTime + (addDay + cardCfg.lastTime) * daySecond - 1

    cardInfo.cycleId = cardId
    cardInfo.endTime = endTime

    -- 发送邮件奖励
    local addReward = cardCfg.purchaseAward
    local rewards = self:addRewardList(addReward, proto, GE.EventItemType.CycleCard, cardId)

    -- 发送当天奖励 邮件
    local isSend = self:UpdateCycleCardData(cardId, proto)

    if not isSend then
        self:recoverExtraCount(proto)
    end

    proto.cycleCardDatas = proto.cycleCardDatas or {}
    proto.cycleCardDatas[cardId] = cardInfo
    return rewards
end

---获得周期卡剩余时间 单位秒
---@param cardId integer
---@return integer
function Player:GetCardLastTime(cardId)
    local cycleCardDatas = self:GetCycleCardDatas()
    if cycleCardDatas == nil then
       return 0 
    end
    local info = cycleCardDatas[cardId]
    if info == nil then
       return 0 
    end
    local curTime = DLuaUtil.GetGreenwichTime()
    local lastTime = (info.endTime or 0) - curTime
    lastTime = math.max(0, lastTime)
    return lastTime
end

---获得周期卡对应天数
---@param cardId integer 周期卡id
---@return integer day 剩余天数
function Player:GetCardLastDayTime(cardId)
    local cycleCardDatas = self:GetCycleCardDatas()
    if cycleCardDatas == nil then
       return 0
    end
    local info = cycleCardDatas[cardId]
    if info == nil then
       return 0 
    end
    local lastTime = self:GetCardLastTime(cardId)
    if lastTime <= 0 then
       return 0 
    end
    local day = math.ceil(lastTime / daySecond)
    return day
end

---判断周期卡是否激活
---@param cardId integer
---@return boolean
function Player:GetCycleCardActive(cardId)
    local cycleCardDatas = self:GetCycleCardDatas()
    if cycleCardDatas == nil then
       return false
    end
    local info = cycleCardDatas[cardId]
    if info == nil then
       return false
    end
    local curTime = DLuaUtil.GetGreenwichTime()
    return curTime <= info.endTime
end

---@param type PrivilegeType 特权类型
---@return integer count 增加的特权数量
function Player:GetCycleCardPrivilegeAddCount(type)

    local cycleCardDatas = self:GetCycleCardDatas()
    local count = 0
    if cycleCardDatas == nil then 
       return count
    end
    for k, v in pairs(cycleCardDatas) do
        if not self:GetCycleCardActive(k) then
            goto continue
        end
        local cfg = Config.GetMonthCardInfo(k)
        if cfg == nil or cfg.privilege == nil then
           goto continue 
        end
        for i = 1, #cfg.privilege do
            local p = cfg.privilege[i]
            if p[1] == type then
                count = count + p[2]
            end
        end
        ::continue::
    end
    return count
end

------------------------------------ client ------------------------------------

---更新服务器数据
---@param v table<integer, CycleCardData>
function Player:updateCycleCardData(v)
    if v == nil then
      self.cycleCardDatas = nil 
      return
   end
   for key, value in pairs(v) do
       if not next(value) then
           self.cycleCardDatas[key] = nil
       else
           self.cycleCardDatas[key] = value
       end
   end
end

return Player