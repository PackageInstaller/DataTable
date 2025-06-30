
--
-- <代码文件解释说明>
--

local RoleInfoUpdatePush = BaseClass("RoleInfoUpdatePush",IMHandler)

-- 断线重连触发事件
RoleInfoUpdatePush.__init = function(self)

end

RoleInfoUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        local oldLevel = Game.Scene.Player.Level
        Game.Scene.Player:UpdateData(pbMsg)

        if oldLevel ~= Game.Scene.Player.Level then
            ---@type HintComponent
            local hintComponent = Game.Scene:GetComponent("HintComponent")
            hintComponent:RefreshCondition()
        end

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_ROLE_INFO_UPDATE)
    end)
end

return RoleInfoUpdatePush
