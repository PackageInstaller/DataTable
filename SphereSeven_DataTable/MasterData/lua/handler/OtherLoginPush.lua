
--
-- <代码文件解释说明>
--

local OtherLoginPush = BaseClass("OtherLoginPush",IMHandler)

-- 断线重连触发事件
OtherLoginPush.__init = function(self)

end

OtherLoginPush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end


        Game.Scene:GetComponent("SoundComponent"):Stop()
        Game.Scene:GetComponent("SessionComponent"):ExitGame(0)
        -- DataManager:GetInstance():Broadcast(DataMessageNames.xxx, param1, param2)
    end)
end

return OtherLoginPush
