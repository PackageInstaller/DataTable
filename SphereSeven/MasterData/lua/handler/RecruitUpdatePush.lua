
--
-- <代码文件解释说明>
--

local RecruitUpdatePush = BaseClass("RecruitUpdatePush",IMHandler)

-- 断线重连触发事件
RecruitUpdatePush.__init = function(self)

end

RecruitUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        Game.Scene.Player:GetComponent("RecruitComponent"):UpdateRecruit(pbMsg)        


        DataManager:GetInstance():Broadcast(DataMessageNames.ON_RECRUIT_UPDATE)
    end)
end

return RecruitUpdatePush
