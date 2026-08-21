
--
-- <代码文件解释说明>
--

local TaskUpdatePush = BaseClass("TaskUpdatePush",IMHandler)

-- 断线重连触发事件
TaskUpdatePush.__init = function(self)

end

TaskUpdatePush.Handle = function(self,pbMsg)
    ---@param pbMsg protocol.TaskUpdatePush
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end
        ---@type TaskComponent
        local taskComponent = Game.Scene.Player:GetComponent("TaskComponent")
        taskComponent:UpdateTaskPack(pbMsg)

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_TASK_UPDATE, pbMsg.type)
    end)
end

return TaskUpdatePush
