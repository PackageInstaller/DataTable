local FormationUpdatePush = BaseClass("FormationUpdatePush",IMHandler)

-- 断线重连触发事件
FormationUpdatePush.__init = function(self)

end

FormationUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        ---@type TeamComponent
        local TeamComponent = Game.Scene.Player:GetComponent("TeamComponent")
        for _,v in ipairs(pbMsg.formations_list.formations_list) do
            --每一类编队
            for key, value in ipairs(v.formations) do
                TeamComponent:UpdateData(value, v.type)
            end
        end
       
        TeamComponent:UpdateFightSoulData()

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_FORMATION_DATA_UPDATE)
    end)
end

return FormationUpdatePush