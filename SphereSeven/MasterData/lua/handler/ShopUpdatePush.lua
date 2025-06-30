local ShopUpdatePush = BaseClass("ShopUpdatePush",IMHandler)

-- 断线重连触发事件
ShopUpdatePush.__init = function(self)

end

ShopUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        for _, pbInfo in pairs(pbMsg["updated_shops"]) do
            ---@type ShopComponent
            local shopComponent = Game.Scene.Player:GetComponent("ShopComponent")
            
            for _, value in pairs(pbInfo.updated_goods) do
                local info = Z_Store[value.id]
                shopComponent.PurchasesDetailList[info.StoreType][value.id] = value
                shopComponent:UpdateShopHintNode(value)
            end
        end

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_ITEM_INFO_CHG)
    end)
end

return ShopUpdatePush