
--
-- <代码文件解释说明>
--

local FriendUpdatePush = BaseClass("FriendUpdatePush",IMHandler)

-- 断线重连触发事件
FriendUpdatePush.__init = function(self)

end

FriendUpdatePush.Handle = function(self,pbMsg)
    ---@param pbMsg protocol.FriendDataUpdatePush
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        ---@type FriendComponent
        local friendComponent = Game.Scene.Player:GetComponent("FriendComponent")

        if pbMsg.changed_friends ~= nil then
            for _, friend in ipairs(pbMsg.changed_friends) do
                friendComponent:AddOrUpdateFriend(friend)
            end

            if table.count(pbMsg.changed_friends) > 0 then
                DataManager:GetInstance():Broadcast(DataMessageNames.ON_FRIEND_UPDATE)
            end
        end

        if pbMsg.removed_friends ~= nil then
            for _, id in ipairs(pbMsg.removed_friends) do
                friendComponent:RemoveFriend(id)
            end

            if table.count(pbMsg.removed_friends) > 0 then
                DataManager:GetInstance():Broadcast(DataMessageNames.ON_FRIEND_UPDATE)
            end
        end

        if pbMsg.changed_requests ~= nil then

            for _, request in ipairs(pbMsg.changed_requests) do
                friendComponent:AddOrUpdateRequest(request)
            end

            if table.count(pbMsg.changed_requests) > 0 then
                DataManager:GetInstance():Broadcast(DataMessageNames.ON_FRIEND_REQUEST_UPDATE)
            end
        end

        if pbMsg.removed_requests ~= nil then
            for _, id in ipairs(pbMsg.removed_requests) do
                friendComponent:RemoveRequest(id)
            end

            if table.count(pbMsg.removed_requests) > 0 then
                DataManager:GetInstance():Broadcast(DataMessageNames.ON_FRIEND_REQUEST_UPDATE)
            end
        end



        -- DataManager:GetInstance():Broadcast(DataMessageNames.xxx, param1, param2)
    end)
end

return FriendUpdatePush
