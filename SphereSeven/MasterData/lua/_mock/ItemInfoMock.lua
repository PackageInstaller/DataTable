local ItemInfoMock = BaseClass("ItemInfoMock", Singleton);
local items = {} --- key: uid, value: count @ mock中默认cid和uid相同
local function ItemInfo(reqMsg)
    local rspMsg = 
    {
        items = {}
    }
    for key, value in pairs(Z_Item) do
        local count = 10000
        items[key] = count
        table.insert(rspMsg.items, {
            uid = key,
            cid = key,
            count = count
        })
    end

    return rspMsg
end

local function UseItem(msg)
    local rspMsg = 
    {
        reward_result = {}
    }

    local updateMsg = {
        removes = {},
        items = {},
    }
    for index, value in ipairs(msg.items) do
        -- uint64 uid = 1;
        -- uint32 count = 2;
        -- repeated uint32 args = 3;
        if items[value.uid] == nil or items[value.uid] < value.count then
            rspMsg.Error = 1
            break
        else
            items[value.uid] = items[value.uid] - value.count
            if items[value.uid] == 0 then
                items[value.uid] = nil
                table.insert(updateMsg.removes, value.uid)
            else
                table.insert(updateMsg.items, {
                    uid = value.uid,
                    cid = value.uid,
                    count = items[value.uid]
                })
            end
        end

        --todo: 根据cid获取uid mock中默认获取一个新的道具吧
        local newUid = value.uid
        if Z_Item[newUid + 1] ~= nil then
            newUid = newUid + 1
        end
        local newCount = math.random(1, 1)
        table.insert(rspMsg.reward_result, {
            type = 1,
            id = newUid,
            count = newCount
        })

        if items[newUid] ~= nil then
            items[newUid] = items[newUid] + newCount
        else
            items[newUid] = newCount
        end
        table.insert(updateMsg.items, {
            uid = newUid,
            cid = newUid,
            count = items[newUid]
        })
    end

    Game.Scene:GetComponent("MessageDispatcherComponent"):Handle(PROTOCOL.ItemUpdatePush, updateMsg)
    return rspMsg
end

local function ChangeItemCount(self, itemList)

end

local function GetItemByUid(self, uid)
    if items[uid] then
        return {
            uid = uid,
            cid = uid, 
            count = items[uid]
        }
    else
        return nil
    end
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.ItemBagReq, ItemInfo)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.UseItemReq, UseItem)
end

local function __delete(self)
end

ItemInfoMock.__init = __init
ItemInfoMock.__delete = __delete
ItemInfoMock.ChangeItemCount = ChangeItemCount
ItemInfoMock.GetItemByUid = GetItemByUid


return ItemInfoMock;