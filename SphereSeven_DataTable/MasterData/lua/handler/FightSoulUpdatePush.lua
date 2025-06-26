local FightSoulUpdatePush = BaseClass("FightSoulUpdatePush",IMHandler)

-- 断线重连触发事件
FightSoulUpdatePush.__init = function(self)

end

FightSoulUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        ---@type FightSoulComponent
        local fightSoulComponent = Game.Scene.Player:GetComponent("FightSoulComponent")

        if pbMsg.fight_souls ~= nil then
            for _, v in pairs(pbMsg.fight_souls) do
                fightSoulComponent:UpdateData({
                    uid = v.uid,
                    cid = v.cid,
                    exp = v.exp,
                    level = v.level,
                    mergeLevel = v.merge_level,
                    isLocked = v.locked
                }) 
            end
        end

        if pbMsg.removeds ~= nil then
            for _, uid in pairs(pbMsg.removeds) do
                fightSoulComponent:Remove(uid) 
            end
        end

        if pbMsg.bag_capacity ~= nil then
            fightSoulComponent:UpdateBagCapacity(pbMsg.bag_capacity) 
        end

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
    end)
end

return FightSoulUpdatePush