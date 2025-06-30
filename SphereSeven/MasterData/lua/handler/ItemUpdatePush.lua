local ItemUpdatePush = BaseClass("ItemUpdatePush",IMHandler)

-- 断线重连触发事件
ItemUpdatePush.__init = function(self)

end

ItemUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        local updateIds = {}
        local removeIds = {}
        ---@type ItemComponent
        local itemComponent = Game.Scene.Player:GetComponent("ItemComponent")
        if pbMsg.removes ~= nil then
            for _, itemId in pairs(pbMsg.removes) do
                itemComponent:Remove(itemId)
                table.insert(removeIds, itemId)
            end
        end

        if pbMsg.items ~= nil then
            for key, value in pairs(pbMsg.items) do
                itemComponent:ChangeItemCount(value.uid, value.cid, value.count)
                table.insert(updateIds, value.uid)
            end
        end

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_ITEM_DATA_UPDATE, updateIds, removeIds)
    end)
end

return ItemUpdatePush