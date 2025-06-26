
--
-- <代码文件解释说明>
--

local MonthlyCardUpdatePush = BaseClass("MonthlyCardUpdatePush",IMHandler)

-- 断线重连触发事件
MonthlyCardUpdatePush.__init = function(self)

end

MonthlyCardUpdatePush.Handle = function(self,pbMsg)
    ---@param pbMsg protocol.MonthlyCardUpdatePush
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end
        ---@type MonthCardComponent
        local monthCardComponent = Game.Scene.Player:GetComponent("MonthCardComponent")
    
        monthCardComponent:RefreshMonthCards(pbMsg.monthly_cards)

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_MONTH_CARD_INFO_CHG)
    end)
end

return MonthlyCardUpdatePush
