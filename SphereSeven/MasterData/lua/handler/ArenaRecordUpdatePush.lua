
--
-- <代码文件解释说明>
--

local ArenaRecordUpdatePush = BaseClass("ArenaRecordUpdatePush",IMHandler)

-- 断线重连触发事件
ArenaRecordUpdatePush.__init = function(self)

end

ArenaRecordUpdatePush.Handle = function(self,pbMsg)
    ---@param pbMsg protocol.ArenaRecordUpdatePush
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        ---@type CompetitionComponent
        local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
        competitionComponent:RefreshArenaRecord(pbMsg.records)

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_ARENA_RECORD_UPDATE)
    end)
end

return ArenaRecordUpdatePush
