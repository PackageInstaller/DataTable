
--
-- <代码文件解释说明>
--

local ArenaUpdatePush = BaseClass("ArenaUpdatePush",IMHandler)

-- 断线重连触发事件
ArenaUpdatePush.__init = function(self)

end

ArenaUpdatePush.Handle = function(self,pbMsg)
    ---@param pbMsg protocol.ArenaUpdatePush
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        ---@type CompetitionComponent
        local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
        competitionComponent.oldScore = competitionComponent.info.score

        competitionComponent:CreateOrUpdateArenaInfo(pbMsg.info)

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_ARENA_UPDATE)
    end)
end

return ArenaUpdatePush
