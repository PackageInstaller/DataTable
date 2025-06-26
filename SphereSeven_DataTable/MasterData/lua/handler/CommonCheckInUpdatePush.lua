
--
-- <代码文件解释说明>
--

local CommonCheckInUpdatePush = BaseClass("CommonCheckInUpdatePush",IMHandler)

-- 断线重连触发事件
CommonCheckInUpdatePush.__init = function(self)

end

CommonCheckInUpdatePush.Handle = function(self,pbMsg)
    ---@param pbMsg protocol.CommonCheckInUpdatePush
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        ---@type CheckInComponent
        local checkInComponent = Game.Scene.Player:GetComponent("CheckInComponent")

        checkInComponent:RefreshCheckInData(pbMsg.group_id, pbMsg.common_check_in)

        ---@type GameEventComponent
        local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
        gameEventComponent:RefreshModuleHint(nil, "CheckIn")

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_CHECK_IN_UPDATE)
    end)
end

return CommonCheckInUpdatePush
