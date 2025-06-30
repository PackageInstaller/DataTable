
---@class CheckInComponent
---@field checkInMap {group:CheckInItem[], config:table, count:number, canReceiveIndex:number[]}[]
local CheckInComponent = BaseClass("CheckInComponent", Component)
local base = Component
local this = CheckInComponent

function this:CoLoadData()
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            PROTOCOL.DailyRewardReq, {})
    self:RefreshDailyReward(info)

    return coroutine.yieldbreak(info)
end

function this:Awake()
    base.Awake(self)

    self.checkInMap = {}
end

---@param msg protocol.DailyRewardResp
function this:RefreshDailyReward(msg)
    self.dailyRewardCount = msg.count
    self.dailyRewardIsReceived = msg.is_received
end

function this:HasDailyReward()
    return not self.dailyRewardIsReceived
end

function this:GetDailyRewardReceivedCount()
    return self.dailyRewardCount
end

function this:DailyRefresh()
    self.dailyRewardIsReceived = false
end

function this:RequestCheckInData(checkInId)
    ---@param msg protocol.CommonCheckInResp
    PublicRequest.SendRequest(
        PROTOCOL.CommonCheckInReq,
        {group_id = checkInId},
        function(msg)
            self.checkInMap[checkInId] = {}
            self.checkInMap[checkInId].group = {}
            self.checkInMap[checkInId].config = Z_CommonCheckIn[checkInId]
            for _, checkInItem in pairs(msg.common_check_in) do
                self.checkInMap[checkInId].group[checkInItem.id] = Game.Registry:NewObject("CheckInItem", {
                    data = checkInItem,
                    checkInId = checkInId,
                })
            end

            self.checkInMap[checkInId].count = 1
            self.checkInMap[checkInId].canReceiveIndex = {}
            for index, checkIn in ipairs(self.checkInMap[checkInId].group) do
                if checkIn.receiveStatus ~= CheckInReceiveStatus.CheckInReceiveUnavailable then
                    self.checkInMap[checkInId].count = index
                end
                if checkIn.status == CommonCheckInStatus.CommonCheckInOnGoing and checkIn.receiveStatus == CheckInReceiveStatus.CheckInReceiveNotReceived then
                    table.insert(self.checkInMap[checkInId].canReceiveIndex, index)
                end
            end

            ---@type GameEventComponent
            local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
            gameEventComponent:RefreshModuleHint(nil, "CheckIn")
        end,
        function(error)
        end
    )
end

---@param checkIns protocol.CommonCheckIn[]
function this:RefreshCheckInData(checkInId, checkIns)
    if self.checkInMap[checkInId] == nil then
        self.checkInMap[checkInId] = {}
        self.checkInMap[checkInId].group = {}
    end

    for _, checkInItem in pairs(checkIns) do
        if self.checkInMap[checkInId].group[checkInItem.id] == nil then
            self.checkInMap[checkInId].group[checkInItem.id] = Game.Registry:NewObject("CheckInItem", {
                data = checkInItem,
                checkInId = checkInId,
            })
        else
            self.checkInMap[checkInId].group[checkInItem.id]:UpdateData(checkInItem)
        end
    end

    self.checkInMap[checkInId].count = 1
    self.checkInMap[checkInId].canReceiveIndex = {}
    for index, checkIn in ipairs(self.checkInMap[checkInId].group) do
        if checkIn.receiveStatus ~= CheckInReceiveStatus.CheckInReceiveUnavailable then
            if self.checkInMap[checkInId].count < index then
                self.checkInMap[checkInId].count = index
            end
        end
        if checkIn.status == CommonCheckInStatus.CommonCheckInOnGoing and checkIn.receiveStatus == CheckInReceiveStatus.CheckInReceiveNotReceived then
            table.insert(self.checkInMap[checkInId].canReceiveIndex, index)
        end
    end
end

---@return {group:CheckInItem[], config:table, count:number, canReceiveIndex:number[]} @ count: 已领取+可领取数量
function this:GetCheckInGroupData(checkInId)
    return self.checkInMap[checkInId]
end

function this:Dispose()
    base.Dispose(self)
end

return this