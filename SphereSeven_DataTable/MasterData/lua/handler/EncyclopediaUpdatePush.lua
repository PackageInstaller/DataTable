
--
-- <代码文件解释说明>
--

local EncyclopediaUpdatePush = BaseClass("EncyclopediaUpdatePush",IMHandler)

-- 断线重连触发事件
EncyclopediaUpdatePush.__init = function(self)

end

EncyclopediaUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        ---@type RecordComponent
        local RecordComponent = Game.Scene.Player:GetComponent("RecordComponent")
        RecordComponent:RefreshData(pbMsg.records)

        -- DataManager:GetInstance():Broadcast(DataMessageNames.ON_ENCYCLOPEDIA_UPDATE)
    end)
end

return EncyclopediaUpdatePush
