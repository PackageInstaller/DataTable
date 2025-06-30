
--
-- <代码文件解释说明>
--

local DailyUpdatePush = BaseClass("DailyUpdatePush",IMHandler)

-- 断线重连触发事件
DailyUpdatePush.__init = function(self)

end

DailyUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        DayUpdate = 1
        ---@type MonthCardComponent
        local monthCardComponent = Game.Scene.Player:GetComponent("MonthCardComponent")
        monthCardComponent:DailyRefresh()

        ---@type CheckInComponent
        local checkInComponent = Game.Scene.Player:GetComponent("CheckInComponent")
        checkInComponent:DailyRefresh()

        ---@type ItemComponent
        local itemComponent = Game.Scene.Player:GetComponent("ItemComponent")
        itemComponent:DailyRefresh()

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_DAILY_UPDATE_PUSH)
    end)
end

return DailyUpdatePush
