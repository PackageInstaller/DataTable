local GMUtil={}

function GMUtil.Send(tt,callBack)
     coroutine.start(function()
        local g2cAddCurrency = coroutine.yieldstart(Game.Scene.Session.CoCall, nil,  Game.Scene.Session,
                OuterOpcode.Name2Code.ETModel_C2M_GM,{JsonDate=tt})
         if g2cAddCurrency.Error == ErrorCode.ERR_Success then
             local player = Game.Scene.Player
             tt= string.split(tt," ")
             local id= tonumber(tt[2])
             if id==1000 then
                 local count = tonumber(tt[4])
                 local CurrencyTypeVal=tonumber(tt[3])
                 local func_tab = {
                     [0] = function() player.GoldCoin = player.GoldCoin + count end ,
                     [1] = function() player.PaidStarStone = player.PaidStarStone + count end ,
                     [2] = function() player.FreeStarStone = player.FreeStarStone + count end ,
                     [3] = function() player.StarSand = player.StarSand + count end ,
                     [4] = function() player.MagicCrystal = player.MagicCrystal + count end ,
                     [5] = function() player.EmperorStarPoint = player.EmperorStarPoint + count end ,
                 }
                 func_tab[CurrencyTypeVal]()
                 UIUtil.ToolTipFourth("Get:"..count..CurrencyTypeVal)
                 DataManager:GetInstance():Broadcast(DataMessageNames.ON_PLAYER_INFO_CHG)
             elseif id==1001 then
                 --玩家等级
                 player.level=tonumber(tt[3])
             elseif id==7000 then
                 --增加争霸积分
             end
             callBack()
        end
    end)
end

return GMUtil