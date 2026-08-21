
--
-- <代码文件解释说明>
--

local DailrRewardUpdatePush = BaseClass("DailrRewardUpdatePush",IMHandler)

-- 断线重连触发事件
DailrRewardUpdatePush.__init = function(self)

end

DailrRewardUpdatePush.Handle = function(self,pbMsg)
    ---@param pbMsg protocol.DailyRewardUpdatePush
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        ---@type CheckInComponent
        local checkInComponent = Game.Scene.Player:GetComponent("CheckInComponent")
        checkInComponent:RefreshDailyReward(pbMsg)

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_DAILY_REWARD_UPDATE)
    end)
end

return DailrRewardUpdatePush
