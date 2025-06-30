
--
-- <代码文件解释说明>
--

local BossraidUpdatePush = BaseClass("BossraidUpdatePush",IMHandler)

-- 断线重连触发事件
BossraidUpdatePush.__init = function(self)

end

BossraidUpdatePush.Handle = function(self,pbMsg)
    ---@param pbMsg protocol.BossraidUpdatePush
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        ---@type BossraidComponent
        local bossraidComponent = Game.Scene.Player:GetComponent("BossraidComponent")
        if pbMsg.info ~= nil then
            for i, v in ipairs(pbMsg.info) do
                bossraidComponent:AddOrUpdateBossraid(v)
            end
        end


        DataManager:GetInstance():Broadcast(DataMessageNames.ON_BOSSRAID_UPDATE_PUSH)
    end)
end

return BossraidUpdatePush
