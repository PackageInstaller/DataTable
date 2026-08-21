
--
-- <代码文件解释说明>
--

local PassUpdatePush = BaseClass("PassUpdatePush",IMHandler)

-- 断线重连触发事件
PassUpdatePush.__init = function(self)

end

PassUpdatePush.Handle = function(self,pbMsg)
    ---@param pbMsg protocol.PassUpdatePush
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        ---@type PassComponent
        local PassComponent = Game.Scene.Player:GetComponent("PassComponent")
        
        if pbMsg.updateds ~= nil then
            for index, pass in ipairs(pbMsg.updateds) do
                PassComponent:AddOrUpdatePass(pass)
            end
        end
        if pbMsg.removeds ~= nil then
            for index, id in ipairs(pbMsg.removeds) do
                PassComponent:RemovePass(id)
            end
        end

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_PASS_UPDATE_PUSH)
    end)
end

return PassUpdatePush
