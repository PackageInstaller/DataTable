
--
-- <代码文件解释说明>
--

local GameEventUpdatePush = BaseClass("GameEventUpdatePush",IMHandler)

-- 断线重连触发事件
GameEventUpdatePush.__init = function(self)

end

GameEventUpdatePush.Handle = function(self,pbMsg)
    ---@param pbMsg protocol.GameEventUpdatePush
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        ---@type GameEventComponent
        local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
        
        if pbMsg.events ~= nil then
            for _, event in pairs(pbMsg.events) do
               gameEventComponent:RefreshEventData(event)
            end
        end

        if pbMsg.modules ~= nil then
            for _, module in pairs(pbMsg.modules) do
                gameEventComponent:RefreshModuleData(module)
            end
        end

        if pbMsg.removed_events ~= nil then
            for _, id in pairs(pbMsg.removed_events) do
                gameEventComponent:RemoveEvent(id)
            end
        end

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_GAME_EVENT_UPDATE)
    end)
end

return GameEventUpdatePush
