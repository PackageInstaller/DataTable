local PaymentInfoUpdatePush = BaseClass("PaymentInfoUpdatePush",IMHandler)

-- 断线重连触发事件
PaymentInfoUpdatePush.__init = function(self)

end

PaymentInfoUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end
        ---@type StarLightRebateComponent
        local StarLightRebateComponent = Game.Scene.Player:GetComponent("StarLightRebateComponent")
        
        for _, value in pairs(pbMsg["updated_shop"].updated_goods) do
            StarLightRebateComponent.PurchasesDetail[1][value.id] = value
            StarLightRebateComponent:UpdatePaymentHintNode(value)
        end

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_ITEM_INFO_CHG)
    end)
end

return PaymentInfoUpdatePush